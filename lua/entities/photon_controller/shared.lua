---@class PhotonController : Entity
---@field ComponentParent Entity
---@field Components PhotonBaseEntity[]
---@field CurrentProfile PhotonLibraryVehicle
ENT = ENT

local print = Photon2.Debug.Print

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Photon Controller"
ENT.Authors = "Photon Lighting Group"
ENT.Spawnable = true
ENT.IsPhotonController = true

function ENT:InitializeShared()
	self.Components = {}
	self.Equipment = {}

	timer.Simple(0, function()
		hook.Add("Photon2.VehicleCompiled", self, self.OnVehicleCompiled)
	end)
end

function ENT:GetChannelState( channel )
    return self:GetNW2String( "Photon2:CS:" .. channel, "OFF" )
end

function ENT:GetProfileName()
	return self:GetNW2String( "Photon2:ProfileName" )
end


---@param string
function ENT:GetProfile( )
	return Photon2.Index.Vehicles[self:GetProfile()]
end

function ENT:GetComponentParent()
	return self:GetParent()
end


local softRefreshProperties = {
	["Position"] = true,
	["Angles"] = true
}

function ENT:SoftEquipmentRefresh()
	local profile = self:GetProfile()
	for id, component in pairs(self.Components) do
		component:SetLocalPos(profile.Equipment[id].Position)
		component:SetLocalAngles(profile.Equipment[id].Angles)
	end
end


---@param name string
---@param vehicle PhotonVehicle
function ENT:OnVehicleCompiled( name, vehicle )
	-- TODO: detect specific determine hard vs soft reloading?
	if (not self:GetProfileName() == name) then
		print(string.format("Controller detected vehicle compilation but the profile did not match. (%s =/= %s [this])", name, self:GetProfileName()))
	end
	print(string.format("Controller's vehicle profile was just recompiled (%s). Updating.", name))
	self:SoftEquipmentRefresh()
end