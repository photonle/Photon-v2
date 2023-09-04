
local ent = FindMetaTable("Entity")


---@return PhotonController
function ent:GetPhotonController()
	return self:GetNW2Entity( "Photon2:Controller" )
end

function ent:SetPhotonController( controller )
	self:SetNW2Entity( "Photon2:Controller", controller )
end