---@class PhotonController : Entity
---@field ComponentParent Entity
---@field Components table<string, PhotonLightingComponent>
---@field ComponentArray PhotonLightingComponent[]
---@field CurrentProfile PhotonVehicle
---@field GetLinkedToVehicle fun(): boolean
---@field GetVehicleBraking fun(): boolean
---@field GetVehicleReversing fun(): boolean
---@field GetVehicleSpeed fun(): number
---@field SetVehicleBraking fun(self: PhotonController, braking: boolean)
---@field SetVehicleReversing fun(self: PhotonController, reversing: boolean)
---@field SetVehicleSpeed fun(self: PhotonController, speed: number)
---@field SetLinkedToVehicle fun(self: PhotonController, linked: boolean)
---@field CurrentModes table Stores all channels and their current modes. Components have a direct reference to the table.
---@field AttemptingComponentSetup boolean (Internal) Set to true when controller sets up a component. Used to 
---@field DoHardReload boolean (Internal) Triggers a hard reload on the next tick.
---@field DrawController boolean If the Photon Controller model should be visible.
---@field SyncAttachedParentSubMaterials boolean SGM attachment framework compatability.
---@field CurrentPulseComponents table<PhotonLightingComponent> (Internal) Array of components actively listening to controller pulse cycle.
---@field RebuildPulseComponents boolean (Internal) Triggers rebuild of all components that need to be on the pulse schedule.
---@field UsesSubParenting boolean (Internal) If any components use sub-parenting (uncommon). Used for optimization purposes.
ENT = ENT

local info, warn = Photon2.Debug.Declare( "Controller" )

local print = info
local printf = info

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Photon Controller"
ENT.Authors = "Photon Lighting Group"
ENT.Spawnable = true
ENT.IsPhotonController = true
ENT.UsesSubParenting = false

ENT.ChannelTree = {
    ["Emergency"] = { 
        "Cut", 
        "Illuminate",
        "SceneForward",
        "SceneLeft",
        "SceneRight",
        "SceneRear",
        "Directional",
        "Auxiliary",
        "Marker",
        "Siren2Override",
        "SirenOverride",
        "Siren2",
        "Siren",
        "Warning"
    },
    ["Vehicle"] = {
        "Signal",
        "Brake",
        "Transmission",
        "Lights",
        "HighBeam",
		"Ambient",
		"Engine"
    }
}

ENT.CurrentInputSchema = false

function ENT:GenerateInputSchema( template, currentChannelModes )
	
	-- local start = SysTime()

	if ( not currentChannelModes ) then
		local _, modes = self:GetChannelModeTree()
		currentChannelModes = modes
	end

	local schema = {}
	for channel, modes in pairs( template ) do
		if ( currentChannelModes[channel] ) then
			schema[channel] = {}
			local newIndex = 1
			for index, data in ipairs( modes ) do
				local mode = data.Mode or "OFF"
				if ( currentChannelModes[channel][mode] ) then
					newIndex = #schema[channel] + 1
					if ( mode == "OFF" ) then newIndex = 0 end
					if (schema[channel][mode]) then
						newIndex = schema[channel][mode].Index
					end
					schema[channel][newIndex] = {
						Mode = mode,
						Label = data.Label or mode,
						Index = newIndex,
						Data = data.Data
					}
					schema[channel][mode] = schema[channel][newIndex]
				end
			end
		end
	end

	for channel, modes in pairs( currentChannelModes ) do
		if ( schema[channel] ) then continue end
		schema[channel] = {
			[0] = { Mode = "OFF", Label = channel, Index = 0 }
		}
		for mode, _ in SortedPairs( modes ) do
			if ( mode == "OFF" ) then continue end
			local index = #schema[channel]+1
			schema[channel][index] = {
				Mode = mode,
				Label = mode,
				Index = index
			}
			schema[channel][mode] = schema[channel][index]
		end
	end

	-- local duration = SysTime() - start
	-- print("Schema calculated in: " .. tostring( duration ) .. " seconds")

	return schema
end

function ENT:GetInputSchema()
	if ( not self.CurrentInputSchema ) then
		self.CurrentInputSchema = self:GenerateInputSchema( self.Schema )
	end
	return self.CurrentInputSchema
end

-- Returns table of all _utilized_ channels and modes.
function ENT:GetChannelModeTree()


	local cache = {}
	local result = {}

	local componentTables = { "Components" }

	for _, componentType in pairs( componentTables ) do
		for k, v in pairs( self[componentType] ) do
			for channel, modes in pairs( v.InputActions ) do
				cache[channel] = cache[channel] or {
					OFF = true
				}
				for i=1, #modes do
					cache[channel][modes[i]] = true
				end
			end
		end
	end

	

	for channel, modes in pairs( cache ) do
		result[channel] = {}
		for mode, _ in pairs( modes ) do
			result[channel][#result[channel]+1] = mode
		end
	end


	-- local inputSchema = self:GenerateInputSchema( templatePrototype, cache )

	-- print("^^^^^^^^^^^^^^^^^^^^^^^^^")
	-- print("\tGetChannelModeTree() -> Result")
	-- PrintTable(result)
	-- print("^^^^^^^^^^^^^^^^^^^^^^^^^")

	-- print("^^^^^^^^^^^^^^^^^^^^^^^^^")
	-- print("\tINPUT SCHEMA() -> Result")
	-- PrintTable(inputSchema)
	-- print("^^^^^^^^^^^^^^^^^^^^^^^^^")
	return result, cache
end

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "LinkedToVehicle" )
	self:NetworkVar( "Bool", 1, "VehicleReversing" )
	self:NetworkVar( "Bool", 2, "VehicleBraking" )
	self:NetworkVar( "Bool", 3, "EngineRunning" )

	self:NetworkVar( "Int",  0, "VehicleSpeed" )

	self:NetworkVar( "String", 0, "ProfileName" )

	self:NetworkVarNotify( "ProfileName", self.OnProfileNameChange )
	self:NetworkVarNotify( "EngineRunning", self.OnEngineStateChange )
end

function ENT:InitializeShared()
	self.Components = {}
	self.Props = {}
	self.SubMaterials = {}
	self.EquipmentProperties = {}
	self.Bones = {}

	self.ComponentArray = {}
	self.PropArray = {}
	self.SubMaterialArray = {}

	self.ActiveNamedEquipment = {}

	self.Equipment = PhotonVehicleEquipmentManager.GetTemplate()

	self.CurrentSelections = {}
	self.Schema = {}

	self.LastHardReload = 0

	--self.CurrentConfiguration = {}
	-- self.EquipmentConfiguration = {}
	self:SetupChannels()
	timer.Simple(0, function()
		-- Used so the controller will update on a hot-reload.
		if ( not IsValid( self ) ) then return end
		hook.Add( "Photon2.VehicleCompiled", self, self.OnVehicleCompiled )
		hook.Add( "Photon2:ComponentReloaded", self, self.AttemptComponentReload )
		hook.Add( "Photon2.MeshCache:Purge", self, self.HardReload )
	end)

	-- self:SetInteractionSound( "Controller", "sos_nergy" )
	-- self:SetInteractionSound( "Click", "default" )
end

function ENT:FindNamedEquipment( name )
	if ( self.ActiveNamedEquipment[name] ) then
		if ( IsValid( self.ActiveNamedEquipment[name] ) ) then
			return self.ActiveNamedEquipment[name]
		elseif ( self.ActiveNamedEquipment.IsVirtual ) then
			return self.ComponentParent
		else
			self.ActiveNamedEquipment[name] = nil
		end
	end
	return nil
end

function ENT:OnMeshCachePurge()

end

function ENT:AttemptComponentReload( id )
	if ( self.PerformedSoftReload ) then
		-- This is to prevent soft-reload changes from being reverted by a component reload.
		self:HardReload()
	end
	local success, code = pcall( self.OnComponentReloaded, self, id )
	if ( not success ) then 
		warn( "ERROR in [%s]: \n\t\t\t[%s]", id, code )
		ErrorNoHalt( "\n[" .. id .."]:\n\t" .. code .. "\n" )
		self.LastReloadFailed = true
	else
		if ( self:GetActiveComponents()[id] ) then
			info( "Component [%s] was successfully reloaded.", id )
		end
	end
end

function ENT:GetOperator()
	return self:GetNW2Entity( "Photon2:Operator" )
end

function ENT:SetupChannels()
	local channelList = {}
	-- Flatten channel tree
	for category, channels in pairs(self.ChannelTree) do
		-- TODO: draw from input priorities instead?
		for _, channel in pairs( channels ) do
			-- channelList[#channelList+1] = string.format("%s.%s", category, channel)
			channelList[string.format("%s.%s", category, channel)] = "OFF"
		end
	end
	self.CurrentModes = channelList
end

function ENT:SetChannelMode( channel, state )
	state = state or "OFF"
	
	local oldState = self:GetParent():GetNW2String("Photon2:CS:" .. channel, "OFF" )

	self:GetParent():SetNW2String( "Photon2:CS:" .. channel, string.upper(state) )

	if CLIENT then
		-- this line may be necessary for client prediction but it's doing some really weird shit
		if ( not game.SinglePlayer() ) then
			self:OnChannelModeChanged( channel, state, oldState )
		end
		Photon2.cl_Network.SetControllerChannelState( self, channel, state )
	end

end

---@param channel string
---@return string
function ENT:GetChannelMode( channel )
    return self:GetParent():GetNW2String( "Photon2:CS:" .. channel, "OFF" )
end

-- -@return string
-- function ENT:GetProfileName()
	-- return self:GetDTProfileName()
	-- return self:GetNW2String( "Photon2:ProfileName" )
-- end


function ENT:GetProfile( name )
	return Photon2.GetVehicle( name or self:GetProfileName() )
end

ENT.UserCommands = {
	["OFF_TOGGLE"] 		= "UserCommandOffToggle",
	["ON_TOGGLE"] 		= "UserCommandOnToggle",
	["OFF_WITH"]		= "UserCommandOffWith",
	["SET"] 			= "UserCommandSet",
	["TOGGLE"] 			= "UserCommandToggle",
	["CYCLE"] 			= "UserCommandCycle",
	["SOUND"]			= "UserCommandSound"
}


ENT.Interactions = {
	Sounds = {
		Controller = "fedsig",
		Click = "default"
	}
}

function ENT:QueryModeFromInputSchema( channel, query, param )
	local schema = self:GetInputSchema()[channel]
	local currentMode = self.CurrentModes[channel]
	if ( not schema ) or ( not currentMode ) then return nil end
	local result
	if ( query == "FIRST" ) then
		result = schema[1]
	elseif ( query == "LAST" ) then
		result = schema[#schema]
	elseif ( query == "NEXT" ) then
		local currentIndex = ( (schema[currentMode] or {}).Index or 0 ) + 1
		if ( currentIndex > #schema ) then
			result = schema[1]
		else
			result = schema[currentIndex]
		end
	elseif ( query == "PREV" ) then
		local currentIndex = ((schema[currentMode] or {}).Index or 0 ) - 1
		if ( currentIndex < 1 ) then
			result = schema[#schema]
		else
			result = schema[currentIndex]
		end
	elseif ( query == "LAST_MINUS" ) then
		param = tonumber( param ) or 0
		result = schema[math.Clamp( #schema - param, 1, #schema )]
	elseif ( query == "FIRST_PLUS" ) then
		param = tonumber( param ) or 0
		result = schema[math.Clamp( 1 + param, 1, #schema )]
	end
	return (result or {}).Mode
end

---@param class string
---@param name string
function ENT:SetInteractionSound( class, name )
	self.Interactions.Sounds[class] = name
end


function ENT:UserCommandSound( action, press, name )
	-- if true then return end
	-- local sound = Photon2.GetInteractionSoundProfile( action.Sound, self.Interactions.Sounds[action.Sound] )
	local sound = Photon2.GetInteractionSound( self.Interactions.Sounds[action.Sound] )
	press = action.Press or press
	
	local subSound = sound[press]

	if ( subSound and isstring( subSound ) ) then
		subSound = sound[subSound]
	elseif ( subSound and isbool( subSound ) ) then
		subSound = sound.Default 
	end

	if not subSound then return end

	-- local sound = self.Interactions.Sounds[action.Sound]
	local lastPlayed = subSound.LastPlayed or 0

	if ( CurTime() < lastPlayed + ( subSound.Duration or 0.1 ) ) then return end

	self:EmitSound( subSound.Sound, 100, subSound.Pitch, subSound.Volume/100 )
	subSound.LastPlayed = CurTime()
end

function ENT:UserCommandOnToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	if ( currentMode == "OFF" ) then
		local value = action.Value
		if ( action.Query ) then 
			value = self:QueryModeFromInputSchema( action.Channel, action.Query, action.Value ) 
		end
		self:SetChannelMode( action.Channel, value )
	end
end

function ENT:UserCommandOffToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	if ( currentMode == "OFF" ) then
		local value = action.Value
		if ( action.Query ) then 
			value = self:QueryModeFromInputSchema( action.Channel, action.Query, action.Value ) 
		end
		self:SetChannelMode( action.Channel, value )
	else
		self:SetChannelMode( action.Channel, "OFF" )
	end
end

function ENT:UserCommandOffWith( action )
	-- Turns Channel OFF if the channel defined in Value is OFF
	if ( self.CurrentModes[action.Value] ) == "OFF" then
		self:SetChannelMode( action.Channel, "OFF" )
	end
end

function ENT:UserCommandSet( action )
	local value = action.Value
	if ( action.Query ) then 
		value = self:QueryModeFromInputSchema( action.Channel, action.Query, action.Value ) 
	end
	self:SetChannelMode( action.Channel, value )
end

function ENT:UserCommandToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	-- TODO: should this be a schema thing?
	local off = "OFF"
	local on = action.Value
	if ( istable( action.Value ) ) then
		off = action.Value[2] or "OFF"
		on = action.Value[1]
	end
	if ( currentMode == on ) then
		self:SetChannelMode( action.Channel, off )
	else
		local value = on
		if ( action.Query ) then 
			value = self:QueryModeFromInputSchema( action.Channel, action.Query, value ) 
		end
		self:SetChannelMode( action.Channel, value )
	end
end

function ENT:UserCommandCycle( action )
	if ( action.Query ) then
		self:SetChannelMode( action.Channel, self:QueryModeFromInputSchema( action.Channel, action.Query, action.Value ) )
		return
	end
	local currentMode = self.CurrentModes[action.Channel]
	local currentIndex = action.ValueMap[currentMode]
	if ( currentIndex == nil ) then currentIndex = 0 end
	local nextIndex = currentIndex + 1
	if ( nextIndex > #action.Value ) then nextIndex = 1 end
	self:SetChannelMode( action.Channel, action.Value[nextIndex] )
end



---@param actions table Actions to process and execute.
---@param press? number Simulated button press state.
---@param name? string Generic name of command.
function ENT:InputUserCommand( actions, press, name )
	-- any condition in which the server would run this and not the client?
	-- self:EmitSound( self.Interactions.Sounds.Button )
	local action
	for i=1, #actions do
		action = actions[i].Action
		-- print("[" .. tostring( action.Action ) .. "] " .. tostring( action.Channel ) .. "::" .. tostring( action.Value ))

		local func = self[self.UserCommands[action.Action]]
		if ( not isfunction( func ) ) then
			continue
			-- error( "Invalid/undefined controller action '" .. tostring( action ) .."'")
		end
		func( self, action, press, name )
	end
end

function ENT:GetComponentParent()
	return self:GetParent()
end


function ENT:HardReload()
	if CLIENT then
		-- ErrorNoHaltWithStack("Hard reload was triggered...")
	end
	print( "Controller performing HARD reload..." )
	self.DoHardReload = false
	self.PerformedSoftReload = false
	self:SetupProfile()
end


function ENT:SoftEquipmentReload()
	print("Controller performing SOFT reload...")
	local profile = self:GetProfile()

	for id, component in pairs( self.Components ) do
		if ( ( component.EquipmentData )  and ( not component.EquipmentData.Parent ) ) then
			component:SetPropertiesFromEquipment( profile.Equipment.Components[id], true )
		end
	end
	
	for id, prop in pairs(self.Props) do
		prop:SetPropertiesFromEquipment( profile.Equipment.Props[id], true )
		prop:SetupSubMaterials()
		prop:SetupBodyGroups()
	end
	
	self:SetSchema( profile.Schema )

	self.PerformedSoftReload = true

	if ( SERVER ) then
		if ( IsValid( self:GetParent() ) ) then
			self:GetParent():PhysWake()
		end
	end
	
	for id, data in pairs( self.Bones ) do
		self:SetupBone( id, profile.Equipment.Bones[id] )
	end
	-- for id, bodyGroupData in pairs( self.Equipment.BodyGroups ) do
	-- 	self:SetupBodyGroup( id )
	-- end
end



---@param name string
---@param vehicle PhotonVehicle
---@param hardReload boolean
function ENT:OnVehicleCompiled( name, vehicle, hardReload )
	if not ( self:GetProfileName() == name ) then
		return
	end
	
	local currentSelections
	
	if (SERVER) then
		if ( self.CurrentSelections ) then
			currentSelections = table.Copy( self.CurrentSelections )
		end
	end

	-- self:HardReload()
	if ( hardReload ) then
		self:HardReload()
	else 
		self:SoftEquipmentReload()
	end
	
	if (SERVER) then
		-- Reapplies previous selections, which is merged with any new ones
		if ( currentSelections and self.CurrentSelections ) then
			table.Merge( self.CurrentSelections, currentSelections )
			self--[[@as sv_PhotonController]]:SyncSelections()
		end
	end
end

-- Returns the component IDs that should be active based 
-- on the current equipment conifguration.
function ENT:GetCurrentEquipment()
	local result
	local optionEquipment
	local selections = self.CurrentProfile.EquipmentSelections
	if (istable(selections) and (#selections > 0)) then
		result = {}
		for i = 1, #selections do
			optionEquipment = selections[i].Map[self.CurrentSelections[i]].Equipment
			for j = 1, #optionEquipment do
				result[optionEquipment[j]] = self.Equipment[optionEquipment[j]]
			end
		end
	end
	return result or self.Equipment
end

function ENT:SetupProp( id )
	local data = self.Equipment.Props[id]
	-- printf( "Setting up Prop [%s]", id )
	if ( not data ) then
		error(string.format("Unable to locate prop ID [%s]", id))
	end

	local ent
	local prop = setmetatable( data, { __index = PhotonBaseEntity } )
	
	setmetatable( data, { __index = PhotonBaseEntity } )

	if ( SERVER and data.OnServer ) then
		-- TODO: serverside spawn code
	elseif (CLIENT and ( not data.OnServer ) ) then
		ent = prop:CreateClientside( self )
	else
		return
	end

	ent.EquipmentData = data
	if ( data.Name ) then 
		ent.EquipmentName = data.Name
		self.ActiveNamedEquipment[data.Name] = ent
	end

	ent:SetMoveType( MOVETYPE_NONE )
	ent:SetParent( self:GetComponentParent() )

	if ( data.Parent ) then
		self:AddToPropPendingParents( ent, data.Parent )
	else
		ent:SetPropertiesFromEquipment( data )
	end

	if (IsValid(self.Props[id])) then
		self.Props[id]:Remove()
	end

	self.Props[id] = ent
end

function ENT:AddToPropPendingParents( ent, parentName )
	self.UsesSubParenting = true
	ent.IsParentPending = true
	self.PropPendingParents = self.PropPendingParents or {}
	self.PropPendingParents[ent] = parentName
end

function ENT:UpdatePropPendingParents()
	if ( not self.PropPendingParents ) then return end

	local newPending = nil
	
	for ent, parentName in pairs( self.PropPendingParents ) do
		if ( not IsValid( ent ) ) then continue end
		if ( ActiveNamedEquipment[parentName] ) then
			ent:SetParent( ActiveNamedEquipment[parentName] )
			ent.IsParentPending = nil
			ent:SetPropertiesFromEquipment()
		else
			newPending = newPending or {}
			newPending[ent] = parentName
		end
	end

	self.PropPendingParents = newPending
end

---@param id string | any
function ENT:SetupBodyGroup( id )
	if CLIENT then return end
	local data = self.Equipment.BodyGroups[id]
	-- printf( "Setting up BodyGroup [%s]", id )
	local bodyGroup = data.BodyGroup
	local value = data.Value
	if ( isstring( bodyGroup ) ) then bodyGroup = self:GetParent():FindBodygroupByName( bodyGroup ) end
	if ( isstring( value ) ) then value = Photon2.Util.FindBodyGroupOptionByName( self, bodyGroup, option ) end
	
	if ( bodyGroup == -1 ) then
		error("Body group [" .. tostring( data.BodyGroup ) .. "] could not be identified.")
	end

	-- printf("\tSetting bodygroup [%s] to [%s]", bodyGroup, value )
	self:GetParent():SetBodygroup( bodyGroup, value )
end

function ENT:SetParentSubMaterial( index, material )
	if ( index == "SKIN" ) then index = Photon2.Util.FindSkinSubMaterial( self:GetParent() ) end
	self:GetParent():SetSubMaterial( index, material )
	if ( self.SyncAttachedParentSubMaterials ) then
		for i, child in pairs( self:GetParent():GetChildren() ) do
			if ( IsValid( child ) and child:GetNW2Bool( "Photon2.SyncSubMaterials" ) ) then
				child.parentSubMaterialMap = child.parentSubMaterialMap or Photon2.Util.BuildParentSubMaterialMap( child )
				if ( child.parentSubMaterialMap[index] ) then
					child:SetSubMaterial( child.parentSubMaterialMap[index], material )
				end
			end
		end
	end
end

function ENT:SetupSubMaterial( id )
	if SERVER then return end
	local data = self.Equipment.SubMaterials[id]
	-- if ( string.StartWith( data.Material, "!" ) and SERVER ) then return end
	-- printf( "Setting up SubMaterial [%s]", id )

	self:SetParentSubMaterial( data.Id, data.Material )
	self.SubMaterials[id] = data
end

function ENT:SetupInteractionSound( id )
	local data = self.Equipment.InteractionSounds[id]
	-- printf( "Setting up interaction sound [%s]", id )
	self:SetInteractionSound( data.Class, data.Profile )
end

function ENT:SetupEquipmentProperties( id )
	if CLIENT then return end
	local data = self.Equipment.Properties[id]

	if ( data.Skin ) then self:GetParent():SetSkin( data.Skin ) end
	if ( data.Color ) then self:GetParent():SetColor( data.Color ) end
end

function ENT:SetupBone( id, data )
	if CLIENT then return end
	data = data or self.Equipment.Bones[id]
	local parent = self:GetComponentParent()
	if ( not IsValid( parent ) ) then return end
	-- printf( "Setting up bone [%s]", id )
	-- printf( "Searching for bone [%s]", tostring( data.Bone ) )
	local bone
	if ( isstring( data.Bone ) ) then
		bone = parent:LookUpBoneOrError( data.Bone )
	else
		bone = data.Bone
	end
	local scale = data.Scale
	if ( isnumber( scale ) ) then scale = Vector( scale, scale, scale ) end
	parent:ManipulateBoneScale( bone, scale )
	parent:ManipulateBoneAngles( bone, data.Angles )
	parent:ManipulateBonePosition( bone, data.Position )
	self.Bones[id] = data
end

function ENT:SetupComponent( id )
	self.AttemptingComponentSetup = true
	local data = self.Equipment.Components[id]
	if (not data) then
		print(string.format("Unable to locate equipment component ID [%s]", id))
		return
	end

	-- print( string.format( "Setting up component [%s] [%s]", id, data.Component ) )

	---@type PhotonLightingComponent
	local component = Photon2.GetComponent( data.Component )

	local ent

	if ( component.IsVirtual ) then
		local component = Photon2.GetComponent( data.Component )
		ent = component:CreateOn( self:GetComponentParent(), self )
	else
		if (SERVER and data.OnServer) then
			-- TODO: serverside spawn code
		elseif (CLIENT and (not data.OnServer)) then
			---@type PhotonLightingComponent
			ent = component:CreateClientside( self ) --[[@as PhotonLightingComponent]]
			-- component.Setup( component )
		else
			return
		end

		if ( not ent.IsVirtual ) then
			-- Set default/essential properties
			ent.Entity:SetMoveType( MOVETYPE_NONE )
			ent.Entity:SetParent( self:GetComponentParent() )
		end

		ent.EquipmentData = data

		if ( data.Name ) then 
			ent.EquipmentName = data.Name
			self.ActiveNamedEquipment[data.Name] = ent
		end

		if ( data.Parent ) then
			self:AddToComponentPendingParents( ent, data.Parent )
		else
			-- Set the other basic properties
			ent:SetPropertiesFromEquipment()
		end

		if (IsValid(self.Components[id])) then
			self.Components[id]:Remove()
		end		
	end
	self.Components[id] = ent
	if ( not ent.IsParentPending ) then ent:ApplyModeUpdate() end
	self.AttemptingComponentSetup = false
	return ent
end

function ENT:AddToComponentPendingParents( ent, parentName )
	self.UsesSubParenting = true
	ent.IsParentPending = true
	self.ComponentPendingParents = self.ComponentPendingParents or {}
	self.ComponentPendingParents[ent] = parentName
end

function ENT:UpdateComponentPendingParents()
	if ( not self.ComponentPendingParents ) then return end

	local newPending = nil

	for ent, parentName in pairs( self.ComponentPendingParents ) do
		if ( not IsValid( ent ) ) then continue end
		if ( self.ActiveNamedEquipment[parentName] ) then
			ent:SetParent( self.ActiveNamedEquipment[parentName] )
			ent.IsParentPending = nil
			ent:SetPropertiesFromEquipment()
			ent:ApplyModeUpdate()
		else
			newPending = newPending or {}
			newPending[ent] = parentName
		end
	end

	self.ComponentPendingParents = newPending
end

function ENT:RemoveAllComponents()
	for id, ent in pairs(self.Components) do
		self:RemoveEquipmentComponentByIndex( id )
	end
end

function ENT:RemoveAllProps()
	for id, ent in pairs( self.Props ) do
		self:RemoveEquipmentPropByIndex( id )
	end
end

function ENT:RemoveAllSubMaterials()
	for id, subMaterial in pairs( self.SubMaterials ) do
		self:RemoveSubMaterialByIndex( id )
	end
end

function ENT:ResetAllBones()
	for id, boneData in pairs( self.Bones ) do
		self:ResetBoneByIndex( id )
	end
end

function ENT:RemoveEquipmentComponentByIndex( index )
	-- printf("Controller is removing equipment ID [%s]", index)
	if ( not self.Components[index] ) then return end
	
	if ( self.Components[index].EquipmentName ) then
		self.ActiveNamedEquipment[self.Components[index].EquipmentName] = nil
	end

	if ( (self.Components[index]).IsVirtual ) then
		self.Components[index]:RemoveVirtual()
	elseif ( IsValid(self.Components[index]) ) then
		self.Components[index]:Remove()
	end
	self.Components[index] = nil
end

function ENT:RemoveEquipmentPropByIndex( index )
	-- printf("Controller is removing virtual component equipment ID [%s]", index)
	if ( self.Props[index] ) then
		self.Props[index]:Remove()
	end
	self.Props[index] = nil
end

function ENT:RemoveSubMaterialByIndex( index )
	local parent = self:GetParent()
	if ( not IsValid( parent ) ) then return end
	if ( self.SubMaterials[index] ) then
		self:SetParentSubMaterial( self.SubMaterials[index].Id, nil )
	end
	self.SubMaterials[index] = nil
end

function ENT:ResetBoneByIndex( index )
	if ( CLIENT ) then return end
	local parent = self:GetComponentParent()
	if ( not IsValid( parent ) ) then return end
	if ( self.Bones[index] ) then
		local bone = self.Bones[index].Bone
		if ( isstring( bone ) ) then
			bone = parent:LookUpBoneOrError( bone )
		else
			bone = data.Bone
		end
		parent:ManipulateBoneScale( bone, Vector( 1, 1, 1 ) )
		parent:ManipulateBoneAngles( bone, Angle( 0, 0, 0 ) )
		parent:ManipulateBonePosition( bone, Vector( 0, 0, 0 ) )
	end
end

---@param equipmentTable PhotonEquipmentTable
function ENT:AddEquipment( equipmentTable )
	if ( not equipmentTable ) then return end

	local components = equipmentTable.Components
	for i=1, #components do
		self:SetupComponent( components[i] )
	end
	
	local props = equipmentTable.Props
	for i=1, #props do
		self:SetupProp( props[i] )
	end
	local bodyGroups = equipmentTable.BodyGroups
	for i=1, #bodyGroups do
		self:SetupBodyGroup( bodyGroups[i] )
	end
	
	local subMaterials = equipmentTable.SubMaterials
	for i=1, #subMaterials do
		self:SetupSubMaterial( subMaterials[i] )
	end
	
	for i=1, #equipmentTable.InteractionSounds do
		self:SetupInteractionSound( equipmentTable.InteractionSounds[i] )
	end
	
	for i=1, #equipmentTable.Properties do
		self:SetupEquipmentProperties( equipmentTable.Properties[i] )
	end

	for i=1, #equipmentTable.Bones do
		self:SetupBone( equipmentTable.Bones[i] )
	end

	self:UpdateComponentPendingParents()
	self:UpdatePropPendingParents()
end

function ENT:RefreshParentSubMaterials()
	-- print("REFRESHING PARENT SUB MATERIALS @ " .. tostring( CurTime() ) )
	if ( not IsValid( self ) or not ( IsValid( self:GetParent() ) ) ) then return end
	for i=1, #self.SubMaterialArray do
		-- printf("ID: %s Material: %s", self.SubMaterialArray[i].Id, self.SubMaterialArray[i].Material)
		self:SetParentSubMaterial( self.SubMaterialArray[i].Id, self.SubMaterialArray[i].Material )
	end

	for i=1, #self.ComponentArray do
		if ( not self.ComponentArray[i].IsVirtual ) then continue end
		for elementIndex, element in pairs( self.ComponentArray[i].Elements ) do
			if ( element and element.Class == "Sub" ) then
				element--[[@as PhotonElementSub]]:ReapplyState()
			end
		end
	end
end

function ENT:RefreshParentMaterialsOnNextFrame()
	local hookName = "PreRender"
	local hookId = "Photon2:" .. tostring( SysTime() )
	-- Should work 80% of the time
	hook.Add( hookName, hookId, function()
		hook.Remove( hookName, hookId )
		if ( not IsValid( self ) ) then return end
		self:RefreshParentSubMaterials()
		-- If not, then probably now...
		timer.Simple( 0.1, function()
			if ( not IsValid( self ) ) then return end
			self:RefreshParentSubMaterials()
			-- And once again...
			timer.Simple( 1, function()
				if ( not IsValid( self ) ) then return end
				self:RefreshParentSubMaterials()
			end)
		end)
	end)
end

---@param equipmentTable PhotonEquipmentTable
function ENT:RemoveEquipment( equipmentTable )
	-- print("Controller is removing an equipment table...")
	for i=1, #equipmentTable.Components do
		self:RemoveEquipmentComponentByIndex(equipmentTable.Components[i])
	end
	for i=1, #equipmentTable.Props do
		self:RemoveEquipmentPropByIndex(equipmentTable.Props[i])
	end
	for i=1, #equipmentTable.SubMaterials do
		self:RemoveSubMaterialByIndex(equipmentTable.SubMaterials[i])
	end
end

---@param name? string Name of profile to load.
---@param isReload? boolean
function ENT:SetupProfile( name, isReload )
	name = name or self:GetProfileName()
	---@type PhotonVehicle
	local profile = self:GetProfile( name )

	if ( profile.InvalidVehicle ) then 
		warn( "Vehicle profile [%s] uses a vehicle that does not exist [%s]. Aborting setup.", name, profile.Target )
		return 
	end

	self:SetSchema( profile.Schema )

	self:RemoveAllComponents()
	self:RemoveAllProps()
	self:RemoveAllSubMaterials()
	self:ResetAllBones()

	if ( profile.EngineIdleEnabled and self:GetParent():IsVehicle() ) then
		self.EngineIdleEnabled = profile.EngineIdleEnabled
		self:GetParent().PhotonEngineIdleEnabled = profile.EngineIdleEnabled

		if ( SERVER ) then
			local soundData = Photon2.Util.TryGetVehicleStartAndIdleSounds( self:GetParent() )
			if ( soundData ) then
				self.EngineIdleData = {
					StartSound = soundData.StartSound,
					StartDuration = soundData.StartDuration,
					IdleSound = soundData.IdleSound,
					StopIdleTimer = "Photon.StopIdleSound[" .. self:EntIndex() .. "]",
					StopStartTimer = "Photon.StopStartSound[" .. self:EntIndex() .. "]",

				}
			else
				self.EngineIdleEnabled = false
			end
		end
	else
		self.EngineIdleEnabled = false
	end

	if ( istable( profile.InteractionSounds ) ) then
		for class, name in pairs( profile.InteractionSounds ) do
			self:SetInteractionSound( class, name )
		end
	end

	self.CurrentSelections = nil
	self.CurrentProfile = profile
	if not (profile) then
		error("Unable to locate vehicle profile [" .. tostring(name) .."].")
		return
	end
	
	-- print( string.format( "Setting up %s (%s)...", profile.Title, profile.Name ) )
	
	self.Equipment = profile.Equipment

	-- This block is for static equipment which is technically
	-- supported but also deprecated and should be removed.
	-- ????????????
	if ( profile.EquipmentSelections ) then
		self:SetupSelections()
	end

	if CLIENT then
		self:ProcessSelectionsString(self:GetSelectionsString())
	end

	self:SetupComponentArrays()

	self:ApplySubMaterials( self.CurrentProfile.SubMaterials )
	self:RefreshParentMaterialsOnNextFrame()
	
	if ( SERVER ) then
		if ( IsValid( self:GetParent() ) ) then
			self:GetParent():PhysWake()
		end
	end
end

function ENT:SetSchema( schema )
	self.Schema = schema
	self.CurrentInputSchema = nil
end

function ENT:ApplySubMaterials( subMaterials )
	for index, materialName in pairs( subMaterials ) do
		self:GetParent():SetSubMaterial( index, materialName )
	end
end

-- Stores components and virtual components in a numeric table
-- for faster iteration operations.
function ENT:SetupComponentArrays()
	-- Setup normal components array
	local componentArray = self.ComponentArray
	for i=1, #componentArray do
		componentArray[i] = nil
	end
	for id, component in pairs( self.Components ) do
		componentArray[#componentArray+1] = component
	end

	-- Setup props
	local propsArray = self.PropArray
	for i=1, #propsArray do
		propsArray[i] = nil
	end
	for id, prop in pairs( self.Props ) do
		propsArray[#propsArray+1] = prop
	end

	-- Setup sub-materials
	local subMaterialArray = self.SubMaterialArray
	for i=1, #subMaterialArray do
		subMaterialArray[i] = nil
	end
	for id, subMaterial in pairs( self.SubMaterials ) do
		subMaterialArray[#subMaterialArray+1] = subMaterial
	end
end


function ENT:SetupSelections()
	local profile = self.CurrentProfile
	if (profile.EquipmentSelections) then
		-- TODO: is this reseting the current equipment configuration on each save?
		self.CurrentSelections = {}
		for categoryIndex, category in pairs(profile.EquipmentSelections) do
			self.CurrentSelections[categoryIndex] = 1
			self:OnSelectionChanged( categoryIndex, 1 )
		end
	end
	if (SERVER) then 
		self--[[@as sv_PhotonController]]:SyncSelections()
	end
end

function ENT:OnRemove()
	local components = {}
	local props = {}
	for k, v in pairs(self.Components) do
		components[#components+1] = v
	end
	for k, v in pairs(self.Props) do
		props[#props+1] = v
	end
	timer.Simple(0, function()
		-- if not IsValid( self ) then
			for i = 1, #components do
				if (IsValid(components[i])) then
					components[i]:Remove()
				end
			end
			for i = 1, #props do
				if (IsValid(props[i])) then
					props[i]:Remove()
				end
			end
		-- else
-- 
		-- end
	end)
end

---@param channel string Channel name.
---@param newState string New value.
---@param oldState string Old value.
function ENT:OnChannelModeChanged( channel, newState, oldState )
	oldState = oldState or "OFF"
	-- print("Controller channel state changed. " .. tostring(self) .. " (" .. channel .. ") '" .. oldState .."' ==> '" .. newState .. "'")
	self.CurrentModes[channel] = newState
	
	local pulseComponents = {}
	
	for id, component in pairs(self.Components) do
		-- component:ApplyModeUpdate()
		component:SetChannelMode( channel, newState )
		if ( component.AcceptControllerPulse ) then pulseComponents[#pulseComponents+1] = component end
	end

	self.CurrentPulseComponents = pulseComponents
end


function ENT:GetSelectionsString()
	return self:GetParent():GetNW2String( "Photon2:Selections" )
end

function ENT:GetActiveComponents()
	
	if ( self.ActiveComponentMap ) then return self.ActiveComponentMap end
	local result = {}

	for categoryIndex, selectionIndex in pairs( self.CurrentSelections ) do
		local map = self.CurrentProfile.EquipmentSelections[categoryIndex].Map
		if ( map and map[selectionIndex] ) then
			for _, componentIndex in pairs( map[selectionIndex].Components ) do
				result[self.CurrentProfile.Equipment.Components[componentIndex].Component] = true
			end
		end
	end

	self.ActiveComponentMap = result
	return result
end

---@param categoryIndex integer
---@param optionIndex integer
function ENT:OnSelectionChanged( categoryIndex, optionIndex )
	-- print(string.format("Selection: [%s] option: [%s]", categoryIndex, optionIndex))
	-- print("Controller:OnSelectionChanged() - Selections:")
	-- PrintTable( self.CurrentProfile.EquipmentSelections )
	self.ActiveComponentMap = nil
	if ( not self.CurrentProfile.EquipmentSelections[categoryIndex] ) then
		print("Category index " .. tostring( categoryIndex ) .. " is invalid. Vehicle respawn may be necessary.")
		return
	end
	-- this forces the input schema to rebuild
	self.CurrentInputSchema = nil

	local category = self.CurrentProfile.EquipmentSelections[categoryIndex].Map 
	if ( istable(category[self.CurrentSelections[categoryIndex]]) ) then 
		category = self.CurrentProfile.EquipmentSelections[categoryIndex].Map
		self:RemoveEquipment(category[self.CurrentSelections[categoryIndex]])
	end
	self.CurrentSelections[categoryIndex] = optionIndex
	if ( category ) then
		self:AddEquipment(category[optionIndex])
	end
	self:SetupComponentArrays()
end


---@param selections string
function ENT:ProcessSelectionsString( selections )
	-- print("Processing selections string '" .. tostring(selections) .. "'")
	if ( not selections ) then return end
	local newSelections = string.Explode( " ", selections, false )
	local currentSelections = self.CurrentSelections or {}
	for categoryIndex, optionIndex in pairs( newSelections ) do
		optionIndex = tonumber( optionIndex ) --[[@as integer]]
		newSelections[categoryIndex] = optionIndex
		if ( currentSelections[categoryIndex] ~= optionIndex ) then
			self:OnSelectionChanged( categoryIndex, optionIndex )
		end
	end
	--self:SetupEquipment()
end


-- Called when a component file is saved and reloaded
---@param componentId string
function ENT:OnComponentReloaded( componentId )
	-- self:SetupComponentArrays()
	-- if true then return end
	-- if ( not self:GetActiveComponents()[componentId] ) then return end
	local matched = false
	local shouldExist = self:GetActiveComponents()[componentId]
	local doSoftReload = false
	local hasChildren = false
	local newComponent
	-- printf( "Controller notified of a component reload [%s]", componentId )
	-- Reload normal components
	for equipmentId, component in pairs( self.Components ) do
		if ( component.Ancestors[componentId] ) then

			self:RemoveEquipmentComponentByIndex( equipmentId )
			newComponent = self:SetupComponent( equipmentId )

			matched = true
		end
	end

	if ( self.UsesSubParenting and IsValid( newComponent ) ) then
		for i=1, #self.ComponentArray do
			if ( IsValid( self.ComponentArray[i] ) ) then
				if ( ( self.ComponentArray[i].EquipmentData.Parent )  and ( self.ComponentArray[i].EquipmentData.Parent == newComponent.EquipmentName ) ) then
					self.ComponentArray[i]:SetParent( newComponent )
					self.ComponentArray[i]:SetPropertiesFromEquipment()
				end
			end
		end
		for i=1, #self.PropArray do
			if ( IsValid( self.PropArray[i] ) ) then
				if ( ( self.PropArray[i].EquipmentData.Parent )  and ( self.PropArray[i].EquipmentData.Parent == newComponent.EquipmentName ) ) then
					self.PropArray[i]:SetParent( newComponent )
					self.PropArray[i]:SetPropertiesFromEquipment()
				end
			end
		end
	end
	
	if ( matched ) then
		self:SetupComponentArrays()
	end

	if ( ( not matched ) and ( shouldExist ) ) then
		print( "Queueing hard reload because component [%s] is not currently spawned...", componentId )
		self.DoHardReload = true
	end

	-- if ( self.LastReloadFailed ) then
	-- 	self.DoHardReload = true
	-- end

	self:UpdatePulseComponentArray()

	self.LastReloadFailed = false

	if ( doSoftReload ) then self:SoftEquipmentReload()	end
end

function ENT:UpdateVehicleBraking( braking )	
	if ( self:GetVehicleBraking() == braking ) then return end
	
	self:SetVehicleBraking( braking )
	
	if ( braking ) then
		self:SetChannelMode( "Vehicle.Brake", "BRAKE" )
	else
		self:SetChannelMode( "Vehicle.Brake", "OFF" )
	end
end

function ENT:UpdateVehicleReversing( reversing )	
	if ( self:GetVehicleReversing() == reversing ) then return end
	
	self:SetVehicleReversing( reversing )
	
	if ( reversing ) then
		self:SetChannelMode( "Vehicle.Transmission", "REVERSE" )
	else
		if ( self:GetChannelMode( "Vehicle.Transmission" ) == "REVERSE" ) then
			self:SetChannelMode( "Vehicle.Transmission", "DRIVE" )
		end
	end
end

-- Vehicle-specific code
---@param ply Player
---@param moveData CMoveData
function ENT:UpdateVehicleParameters( ply, vehicle, moveData )
	if ( not self:GetLinkedToVehicle() ) then return end

	local velocity = vehicle:WorldToLocal( vehicle:GetVelocity() + vehicle:GetPos() ).y

	-- and ( ( velocity < 1 ) )
	-- and ( vehicle:GetSpeed() > 0 )
	if ( moveData:KeyDown( IN_BACK ) and ( not moveData:KeyDown( IN_FORWARD ) ) ) then
		if ( self:GetVehicleReversing() ) then

		elseif ( velocity < 1 ) then
			self:UpdateVehicleReversing( true )
		end
	else
		self:UpdateVehicleReversing( false )
	end

	if ( moveData:KeyDown( IN_JUMP ) or ( ( ( velocity > 1 ) and ( ( moveData:KeyDown( IN_BACK ) ) and ( not moveData:KeyDown( IN_FORWARD ) ) ) ) and ( vehicle:GetSpeed() > 0 ) ) ) then
		self:UpdateVehicleBraking( true )
	else
		self:UpdateVehicleBraking( false )
	end
end

function ENT:OnEngineStateChange( name, old, new )
	print("Engine state change: " .. tostring(new))
	if ( new ) then
		self:SetChannelMode( "Vehicle.Engine", "ON" )
	else
		self:SetChannelMode( "Vehicle.Engine", "OFF" )
	end
end

function ENT:OnProfileNameChange( name, old, new )
	print("Profile name change: " .. tostring( new ) )
	self:SetupProfile( new )
end

function ENT:GetSirenSelection( number )
	if ( not self.CurrentProfile or not self.CurrentProfile.Siren ) then return nil end
	return self.CurrentProfile.Siren[number]
end

function ENT:UpdatePulseComponentArray()
	local result = {}
	for i=1, #self.ComponentArray do
		if( self.ComponentArray[i].AcceptControllerPulse ) then result[#result+1] = self.ComponentArray[i] end
	end
	self.CurrentPulseComponents = result
	self.RebuildPulseComponents = false
end