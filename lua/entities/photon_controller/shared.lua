---@class PhotonController : Entity
---@field ComponentParent Entity
---@field Components table<string, PhotonLightingComponent>
---@field ComponentArray PhotonBaseEntity[]
---@field CurrentProfile PhotonVehicle
---@field CurrentModes table Stores all channels and their current modes. Components have a direct reference to the table.
ENT = ENT

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
        "Reverse",
        "Lights",
        "HighBeam"
    }
}

function ENT:InitializeShared()
	self.Components = {}
	self.VirtualComponents = {}
	self.Props = {}

	self.ComponentArray = {}
	self.VirtualComponentArray = {}
	self.PropArray = {}

	self.Equipment = {
		Components = {},
		Props = {},
		BodyGroups = {},
		SubMaterials = {},
		VirtualComponents ={}
	}

	--self.CurrentConfiguration = {}
	-- self.EquipmentConfiguration = {}
	self:SetupChannels()
	timer.Simple(0, function()
		-- Used so the controller will update on a hot-reload.
		hook.Add("Photon2.VehicleCompiled", self, self.OnVehicleCompiled)
		hook.Add("Photon2:ComponentReloaded", self, self.OnComponentReloaded)
	end)
end



function ENT:SetupChannels()
	local channelList = {}
	-- Flatten channel tree
	for category, channels in pairs(self.ChannelTree) do
		for _, channel in pairs( channels ) do
			-- channelList[#channelList+1] = string.format("%s.%s", category, channel)
			channelList[string.format("%s.%s", category, channel)] = "OFF"
		end
	end
	self.CurrentModes = channelList
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
	end
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
function ENT:SetupComponent( id )
	local data = self.Equipment.Components[id] --[[@as PhotonVehicleEquipment]]
	if (not data) then
		print(string.format("Unable to locate equipment component ID [%s]", id))
		return
	end
	print(string.format("Setting up component [%s]", id))

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
end

---@param equipmentTable PhotonEquipmentTable
function ENT:RemoveEquipment( equipmentTable )
	print("Controller is removing an equipment table...")
	local equipmentComponents = equipmentTable.Components
	for i=1, #equipmentComponents do
		self:RemoveEquipmentComponentByIndex(equipmentComponents[i])
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
		component:SetChannelMode( channel, newState, oldState )
	end
	for id, virtualComponent in pairs( self.VirtualComponents ) do
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
	
	self:RemoveEquipment(category[self.CurrentSelections[categoryIndex]])
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
	local matched = false
	printf( "Controller notified of a component reload [%s]", componentId )
	-- Reload normal components
	for equipmentId, component in pairs( self.Components ) do
		if ( component.Name == componentId ) then
			self:RemoveEquipmentComponentByIndex( equipmentId )
			self:SetupComponent( equipmentId )
			matched = true
		end
	end
	-- Reload virtual components
	for equipmentId, component in pairs( self.VirtualComponents ) do
		if ( component.Name == componentId ) then
			self:RemoveEquipmentVirtualComponentByIndex( equipmentId )
			self:SetupVirtualComponent( equipmentId )
			matched = true
		end
	end
	if ( matched ) then
		self:SetupComponentArrays()
	end
end