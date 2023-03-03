ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Photon Controller"
ENT.Authors = "Photon Lighting Group"
ENT.Spawnable = true
ENT.IsPhotonController = true

function ENT:GetChannelState( channel )
    return self:GetNW2String( "Photon2:CS:" .. channel, "OFF" )
end

function ENT:GetVehicleName()
	return self:GetNW2String( "Photon2:VehicleName" )
end