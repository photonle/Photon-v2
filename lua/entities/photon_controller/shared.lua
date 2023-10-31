---@class PhotonController : Entity
---@field ComponentParent Entity
---@field Components table<string, PhotonLightingComponent>
---@field ComponentArray PhotonBaseEntity[]
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
ENT = ENT


local emergencyConfigs = {
	["code3_z3"] = {
		Name = "Code 3 Z3S",
		Default = { 
			Sound = "photon/controllers/code3_z3s_chirp.wav", 
			Volume = 100, -- default: 100
			Duration = 0.1, -- default: 0.1 -- specified to prevent undesired sound overlapping
			Pitch = 100 -- default: 100
		},
		Press = true,
		Release = false,
		Momentary = false,
		Hold = true
	},
	["fedsig_ssp"] = {
		Name = "Federal Signal SSP",
		Default = { Sound = "photon/controllers/fedsig_ssp_chirp.wav" },
		Release = false,
		Momentary = true
	},
}

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Photon Controller"
ENT.Authors = "Photon Lighting Group"
ENT.Spawnable = true
ENT.IsPhotonController = true

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
        "Elements",
        "HighBeam"
    }
}



-- Returns table of all _utilized_ channels and modes.
function ENT:GetChannelModeTree()
	local cache = {}
	local result = {}

	local componentTables = { "Components", "VirtualComponents" }

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


	print("^^^^^^^^^^^^^^^^^^^^^^^^^")
	print("\tGetChannelModeTree() -> Result")
	PrintTable(result)
	print("^^^^^^^^^^^^^^^^^^^^^^^^^")
	return result
end

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "LinkedToVehicle" )
	self:NetworkVar( "Bool", 1, "VehicleReversing" )
	self:NetworkVar( "Bool", 2, "VehicleBraking" )
	
	self:NetworkVar( "Int",  0, "VehicleSpeed" )
end

function ENT:InitializeShared()
	self.Components = {}
	self.VirtualComponents = {}
	self.Props = {}
	self.UIComponents = {}

	self.ComponentArray = {}
	self.VirtualComponentArray = {}
	self.PropArray = {}
	self.UIComponentArray = {}

	self.Equipment = {
		Components = {},
		Props = {},
		BodyGroups = {},
		SubMaterials = {},
		VirtualComponents = {},
		UIComponents = {}
	}

	--self.CurrentConfiguration = {}
	-- self.EquipmentConfiguration = {}
	self:SetupChannels()
	timer.Simple(0, function()
		-- Used so the controller will update on a hot-reload.
		hook.Add("Photon2.VehicleCompiled", self, self.OnVehicleCompiled)
		hook.Add("Photon2:ComponentReloaded", self, self.OnComponentReloaded)
	end)
	self:SetInteractionSound( "Controller", emergencyConfigs["fedsig_ssp"] )
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

	local oldState = self:GetNW2String("Photon2:CS:" .. channel, "OFF" )

	self:SetNW2String( "Photon2:CS:" .. channel, string.upper(state) )

	if CLIENT then
		self:OnChannelModeChanged( channel, state, oldState )
		Photon2.cl_Network.SetControllerChannelState( self, channel, state )
	end

end


function ENT:GetChannelState( channel )
    return self:GetNW2String( "Photon2:CS:" .. channel, "OFF" )
end


function ENT:GetProfileName()
	return self:GetNW2String( "Photon2:ProfileName" )
end


function ENT:GetProfile( )
	return Photon2.Index.Vehicles[self:GetProfileName()]
end

ENT.UserCommands = {
	["OFF_TOGGLE"] 		= "UserCommandOffToggle",
	["ON_TOGGLE"] 		= "UserCommandOnToggle",
	["OFF_WITH"]		= "UserCommandOffWith",
	["SET"] 			= "UserCommandSet",
	["TOGGLE"] 			= "UserCommandToggle",
	["CYCLE"] 			= "UserCommandCycle",
	["SOUND"]			= "UserCommandSound",
}


local normalVehicleConfigs = {
	["default"] = {
		Name = "Default",
		Default = {
			Sound = "photon/generic/click1.wav",
			Duration = 0.1
		},
		Press = true,
		Release = true,
		Momentary = true
	}
}


-- local 

-- To be moved into vehicle profile...
ENT.Interactions = {
	---@type table<string, PhotonControllerSound>
	Sounds = {
		Controller = emergencyConfigs["fedsig_ssp"],
		Click = normalVehicleConfigs["default"]
	},
}

local soundFileMeta = {
	__index = {
		-- Volume of sound when played
		Volume = 100,
		-- Duration of sound file. (Developer note: does not use SoundDuration due to reliability problems.)
		Duration = 0.1,
		-- Pitch of the sound when played.
		Pitch = 100
	}
}

local soundConfigMeta = {
	__index = {
		-- Sound played as soon as button is pressed
		Press = true,
		-- Sounds played when the button is "momentary," e.g. manual and horn
		Momentary = true,
		-- Sounds played when any specified button is released
		Release = true,
		-- Sounds played when the button is pressed and held (one second by default)
		Hold = true
	}
}

---@param type string
---@param config table
function ENT:SetInteractionSound( type, config )

	if ( istable( config ) ) then
		setmetatable( config, soundConfigMeta )
		for key, value in pairs( config ) do
			if ( istable( value ) and isstring( value.Sound ) ) then
				setmetatable( value, soundFileMeta )
			end
		end
	end

	self.Interactions.Sounds[type] = config
end


function ENT:UserCommandSound( action, press, name )
	-- if true then return end
	local class = self.Interactions.Sounds[action.Sound]
	press = action.Press or press
	
	local sound = class[press]

	if ( sound and isstring( sound ) ) then
		sound = class[sound]
	elseif ( sound and isbool( sound ) ) then
		sound = class.Default 
	end

	if not sound then return end

	-- local sound = self.Interactions.Sounds[action.Sound]
	local lastPlayed = sound.LastPlayed or 0

	if ( CurTime() < lastPlayed + ( sound.Duration or 0.1 ) ) then return end

	self:EmitSound( sound.Sound )
	sound.LastPlayed = CurTime()
end

function ENT:UserCommandOnToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	if ( currentMode == "OFF" ) then
		self:SetChannelMode( action.Channel, action.Value )
	end
end

function ENT:UserCommandOffToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	if ( currentMode == "OFF" ) then
		self:SetChannelMode( action.Channel, action.Value )
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
	self:SetChannelMode( action.Channel, action.Value )
end

function ENT:UserCommandToggle( action )
	local currentMode = self.CurrentModes[action.Channel]
	if ( currentMode == action.Value ) then
		self:SetChannelMode( action.Channel, "OFF" )
	else
		self:SetChannelMode( action.Channel, action.Value )
	end
end

function ENT:UserCommandCycle( action )
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
function ENT:InputUserCommand( actions, key, press, name )
	-- any condition in which the server would run this and not the client?
	-- self:EmitSound( self.Interactions.Sounds.Button )
	local action
	for i=1, #actions do
		action = actions[i].Action
		print("[" .. tostring( action.Action ) .. "] " .. tostring( action.Channel ) .. "::" .. tostring( action.Value ))

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
	print("Controller is executing HARD reload...")
	self:SetupProfile()
end


function ENT:SoftEquipmentReload()
	print("Controller is executing SOFT reload...")
	local profile = self:GetProfile()
	for id, component in pairs(self.Components) do
		component:SetPropertiesFromEquipment( profile.Equipment.Components[id], true )
	end
	for id, prop in pairs(self.Props) do
		prop:SetPropertiesFromEquipment( profile.Equipment.Props[id], true )
		prop:SetupSubMaterials()
		prop:SetupBodyGroups()
	end
	-- for id, bodyGroupData in pairs( self.Equipment.BodyGroups ) do
	-- 	self:SetupBodyGroup( id )
	-- end
end



---@param name string
---@param vehicle PhotonVehicle
---@param hardReload boolean
function ENT:OnVehicleCompiled( name, vehicle, hardReload )
	if (not self:GetProfileName() == name) then
		print(string.format("Controller detected vehicle compilation but the profile did not match. (%s =/= %s [this])", name, self:GetProfileName()))
		return
	end
	print(string.format("Controller's vehicle profile was just recompiled (%s). Updating.", name))
	
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
			self:SyncSelections()
		end
	end
end

-- Returns the component IDs that should be active based 
-- on the current equipment conifguration.
function ENT:GetCurrentEquipment()
	local result
	local optionEquipment
	local selections = self.CurrentProfile.Selections
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


---@param id string
function ENT:SetupVirtualComponent( id )
	local data = self.Equipment.VirtualComponents[id] --[[@as PhotonVehicleEquipment]]
	printf("Setting up virtual component [%s]", id)
	if (not data) then
		error(string.format("Unable to locate equipment virtual component ID [%s]", id))
		return
	end

	local component = Photon2.Index.Components[data.Component]
	local virtualEnt = component:CreateOn( self:GetComponentParent(), self )
	self.VirtualComponents[id] = virtualEnt
	virtualEnt:ApplyModeUpdate()
end

function ENT:SetupProp( id )
	local data = self.Equipment.Props[id]
	printf( "Setting up Prop [%s]", id )
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

	ent:SetMoveType( MOVETYPE_NONE )
	ent:SetParent( self:GetComponentParent() )
	ent:SetPropertiesFromEquipment( data )

	if (IsValid(self.Props[id])) then
		self.Props[id]:Remove()
	end

	self.Props[id] = ent
end

---@param id string

function ENT:SetupBodyGroup( id )
	if CLIENT then return end
	local data = self.Equipment.BodyGroups[id]
	printf( "Setting up BodyGroup [%s]", id )
	local bodyGroup = data.BodyGroup
	local value = data.Value
	if ( isstring( bodyGroup ) ) then bodyGroup = self:GetParent():FindBodygroupByName( bodyGroup ) end
	if ( isstring( value ) ) then value = Photon2.Util.FindBodyGroupOptionByName( self, bodyGroup, option ) end
	
	if ( bodyGroup == -1 ) then
		error("Body group [" .. tostring( data.BodyGroup ) .. "] could not be identified.")
	end

	printf("\tSetting bodygroup [%s] to [%s]", bodyGroup, value )
	self:GetParent():SetBodygroup( bodyGroup, value )
end

function ENT:SetupSubMaterial( id )
	-- if CLIENT then return end
	local data = self.Equipment.SubMaterials[id]
	printf( "Setting up SubMaterial [%s]", id )
	local index = data.Id
	local material = data.Material
	self:GetParent():SetSubMaterial( index, material )
end

---@param id string
function ENT:SetupComponent( id )
	local data = self.Equipment.Components[id] --[[@as PhotonVehicleEquipment]]
	if (not data) then
		print(string.format("Unable to locate equipment component ID [%s]", id))
		return
	end
	print( string.format( "Setting up component [%s] [%s]", id, data.Component ) )

	---@type PhotonLightingComponent
	local component = Photon2.Index.Components[data.Component]

	local ent

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

	-- Set the other basic properties
	ent:SetPropertiesFromEquipment( data )

	if (IsValid(self.Components[id])) then
		self.Components[id]:Remove()
	end

	self.Components[id] = ent
	ent:ApplyModeUpdate()
end

function ENT:RemoveAllComponents()
	for id, ent in pairs(self.Components) do
		self:RemoveEquipmentComponentByIndex( id )
	end
	for id, virtualComponent in pairs( self.VirtualComponents ) do
		self:RemoveEquipmentVirtualComponentByIndex( id )
	end
end

function ENT:RemoveAllProps()
	for id, ent in pairs( self.Props ) do
		self:RemoveEquipmentPropByIndex( id )
	end
end

function ENT:RemoveEquipmentComponentByIndex( index )
	printf("Controller is removing equipment ID [%s]", index)
	if (IsValid(self.Components[index])) then
		self.Components[index]:Remove()
	end
	self.Components[index] = nil
end

function ENT:RemoveEquipmentVirtualComponentByIndex( index )
	printf("Controller is removing virtual component equipment ID [%s]", index)
	if ( self.VirtualComponents[index] ) then
		self.VirtualComponents[index]:RemoveVirtual()
	end
	self.VirtualComponents[index] = nil
end

function ENT:RemoveEquipmentPropByIndex( index )
	printf("Controller is removing virtual component equipment ID [%s]", index)
	if ( self.Props[index] ) then
		self.Props[index]:Remove()
	end
	self.Props[index] = nil
end

---@param equipmentTable PhotonEquipmentTable
function ENT:AddEquipment( equipmentTable )
	local components = equipmentTable.Components
	for i=1, #components do
		self:SetupComponent( components[i] )
	end
	local virtualComponents = equipmentTable.VirtualComponents
	for i=1, #virtualComponents do
		self:SetupVirtualComponent( virtualComponents[i] )
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
end

---@param equipmentTable PhotonEquipmentTable
function ENT:RemoveEquipment( equipmentTable )
	print("Controller is removing an equipment table...")
	for i=1, #equipmentTable.Components do
		self:RemoveEquipmentComponentByIndex(equipmentTable.Components[i])
	end
	for i=1, #equipmentTable.VirtualComponents do
		self:RemoveEquipmentVirtualComponentByIndex(equipmentTable.VirtualComponents[i])
	end
	for i=1, #equipmentTable.Props do
		self:RemoveEquipmentPropByIndex(equipmentTable.Props[i])
	end
end

---@param name? string Name of profile to load.
---@param isReload? boolean
function ENT:SetupProfile( name, isReload )
	name = name or self:GetProfileName()
	local profile = Photon2.Index.Vehicles[name]

	self:RemoveAllComponents()
	self:RemoveAllProps()

	self.CurrentSelections = nil
	self.CurrentProfile = profile
	if not (profile) then
		error("Unable to locate vehicle profile [" .. tostring(name) .."].")
		return
	end
	
	print( string.format( "Setting up %s (%s)...", profile.Title, profile.ID ) )
	
	self.Equipment = profile.Equipment

	if ( not profile.Selections ) then
		-- Setup normal components
		for id, equipment in pairs( self.Equipment.Components ) do
			self:SetupComponent( id )
		end
		-- Setup virtual components
		for id, equipment in pairs( self.Equipment.VirtualComponents ) do
			self:SetupVirtualComponent( id )
		end
		-- Setup props
		for id, prop in pairs( self.Equipment.Props ) do
			self:SetupProp( id )
		end
		-- Setup body groups
		for id, bodyGroupData in pairs( self.Equipment.BodyGroups ) do
			self:SetupBodyGroup( id )
		end
		-- Setup sub-materials
		for id, subMaterialData in pairs( self.Equipment.SubMaterials ) do
			self:SetupSubMaterial( id )
		end
	else
		self:SetupSelections()
	end

	self:SetupComponentArrays()

	self:ApplySubMaterials( profile.SubMaterials )

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

	-- Setup virtual components array
	local virtualComponentArray = self.VirtualComponentArray
	for i=1, #virtualComponentArray do
		virtualComponentArray[i] = nil
	end
	for id, component in pairs( self.VirtualComponents ) do
		virtualComponentArray[#virtualComponentArray+1] = component
	end

	-- Setup props
	local propsArray = self.PropArray
	for i=1, #propsArray do
		propsArray[i] = nil
	end
	for id, prop in pairs( self.Props ) do
		propsArray[#propsArray+1] = prop
	end
end


function ENT:SetupSelections()
	local profile = self.CurrentProfile
	if (profile.Selections) then
		-- TODO: is this reseting the current equipment configuration on each save?
		self.CurrentSelections = {}
		for categoryIndex, category in pairs(profile.Selections) do
			self.CurrentSelections[categoryIndex] = 1
			self:OnSelectionChanged( categoryIndex, 1 )
		end
	end
	if (SERVER) then 
		self:SyncSelections()
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
		if not IsValid( self ) then
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
		else

		end
	end)
end

---@param channel string Channel name.
---@param newState string New value.
---@param oldState string Old value.
function ENT:OnChannelModeChanged( channel, newState, oldState )
	oldState = oldState or "OFF"
	print("Controller channel state changed. " .. tostring(self) .. " (" .. channel .. ") '" .. oldState .."' ==> '" .. newState .. "'")
	self.CurrentModes[channel] = newState
	for id, component in pairs(self.Components) do
		-- component:ApplyModeUpdate()
		component:SetChannelMode( channel, newState, oldState )
	end
	for id, virtualComponent in pairs( self.VirtualComponents ) do
		-- component:ApplyModeUpdate()
		virtualComponent:SetChannelMode( channel, newState, oldState )
	end
end


---@param categoryIndex integer
---@param optionIndex integer
function ENT:OnSelectionChanged( categoryIndex, optionIndex )
	-- print(string.format("Selection: [%s] option: [%s]", categoryIndex, optionIndex))
	-- print("Controller:OnSelectionChanged() - Selections:")
	-- PrintTable( self.CurrentProfile.Selections )
	local category = self.CurrentProfile.Selections[categoryIndex].Map
	if ( istable(category[self.CurrentSelections[categoryIndex]]) ) then 
		self:RemoveEquipment(category[self.CurrentSelections[categoryIndex]])
	end
	self.CurrentSelections[categoryIndex] = optionIndex
	self:AddEquipment(category[optionIndex])
	self:SetupComponentArrays()
end


---@param selections string
function ENT:ProcessSelectionsString( selections )
	-- print("Processing selections string '" .. tostring(selections) .. "'")
	local newSelections = string.Explode( " ", selections, false )
	local currentSelections = self.CurrentSelections
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
	local matched = false
	printf( "Controller notified of a component reload [%s]", componentId )
	-- Reload normal components
	for equipmentId, component in pairs( self.Components ) do
		if ( component.Ancestors[componentId] ) then
			self:RemoveEquipmentComponentByIndex( equipmentId )
			self:SetupComponent( equipmentId )
			matched = true
		end
	end
	-- Reload virtual components
	for equipmentId, component in pairs( self.VirtualComponents ) do
		if ( component.Ancestors[componentId] ) then
			self:RemoveEquipmentVirtualComponentByIndex( equipmentId )
			self:SetupVirtualComponent( equipmentId )
			matched = true
		end
	end
	if ( matched ) then
		self:SetupComponentArrays()
	end
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
		self:SetChannelMode( "Vehicle.Transmission", "OFF" )
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