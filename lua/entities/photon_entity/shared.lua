---@class photon_entity : Entity
ENT = ENT

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Photon Component"
ENT.Authors = "Photon Lighting Group"
ENT.IsPhotonEntity = true

function ENT:Think()
	print("think hook")
end