---@class PhotonController : Entity
---@field ComponentParent Entity
---@field Components PhotonBaseEntity[]
---@field CurrentProfile PhotonVehicle
---@field CurrentModes table Stores all channels and their current modes. Components have a direct reference to the table.
ENT = ENT

local print = Photon2.Debug.Print

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
	self.Equipment = {}
	self.CurrentConfiguration = {}
	-- self.EquipmentConfiguration = {}
	self:SetupChannels()
	timer.Simple(0, function()
		-- Used so the controller will update on a hot-reload.
		hook.Add("Photon2.VehicleCompiled", self, self.OnVehicleCompiled)
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
	print("Executing HARD reload...")
	self:SetupProfile()
end


function ENT:SoftEquipmentReload()
	print("Executing SOFT reload...")

	local profile = self:GetProfile()
	local equipmentData
	for id, component in pairs(self.Components) do
		component:SetPropertiesFromEquipment( profile.Equipment[id], true )
	end
end


---@param name string
---@param vehicle PhotonVehicle
---@param hardReload boolean
function ENT:OnVehicleCompiled( name, vehicle, hardReload )
	if (not self:GetProfileName() == name) then
		print(string.format("Controller detected vehicle compilation but the profile did not match. (%s =/= %s [this])", name, self:GetProfileName()))
	end
	print(string.format("Controller's vehicle profile was just recompiled (%s). Updating.", name))
	if (hardReload) then
		self:HardReload()
	else 
		self:SoftEquipmentReload()
	end
end

-- Returns the component IDs that should be active based 
-- on the current equipment conifguration.
function ENT:GetCurrentEquipment()

end


---@param id string
function ENT:SetupComponent( id )
	local data = self.Equipment[id] --[[@as PhotonVehicleEquipment]]
	if (not data) then
		print(string.format("Unable to locate equipment ID [%s]", id))
		return
	end
	print(string.format("Setting up component [%s]", id))

	-- If equipment is a standard component
	if (data.Component) then
		---@type PhotonLightingComponent
		local component = Photon2.Index.Components[data.Component]

		---@type PhotonBaseEntity
		local ent

		if (SERVER and data.OnServer) then
			-- TODO: serverside spawn code
		elseif (CLIENT and (not data.OnServer)) then
			ent = component:CreateClientside( self )
		else
			return
		end

		-- Set default/essential properties
		ent:SetMoveType( MOVETYPE_NONE )
		ent:SetParent( self:GetComponentParent() )

		-- Set the other basic properties
		ent:SetPropertiesFromEquipment( data )

		if (IsValid(self.Components[id])) then
			self.Components[id]:Remove()
		end
		self.Components[id] = ent
	end
end

function ENT:RemoveAllComponents()
	for id, ent in pairs(self.Components) do
		if (IsValid(ent)) then
			ent:Remove()
		end
		self.Components[id] = nil
	end
end


---@param name? string Name of profile to load.
function ENT:SetupProfile( name )
	name = name or self:GetProfileName()
	local profile = Photon2.Index.Vehicles[name]
	self:RemoveAllComponents()
	self.CurrentProfile = profile
	if not (profile) then
		error("Unable to locate vehicle profile [" .. tostring(name) .."].")
		return
	end
	print( string.format( "Setting up %s (%s)...", profile.Title, profile.ID ) )
	self.Equipment = profile.Equipment

	if (not profile.Configuration) then
		for id, equipment in pairs(self.Equipment) do
			self:SetupComponent( id )
		end
	end

end


function ENT:OnRemove()
	local components = {}
	for k, v in pairs(self.Components) do
		components[#components+1] = v
	end
	timer.Simple(0, function()
		if not IsValid( self ) then
			for i = 1, #components do
				if (IsValid(components[i])) then
					components[i]:Remove()
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
	print("Controller channel state changed. " .. tostring(self) .. " (" .. channel .. ") '" .. oldState .."' => '" .. newState .. "'")
	self.CurrentModes[channel] = newState
	for id, component in pairs(self.Components) do
		component:SetChannelMode( channel, state )
	end
end