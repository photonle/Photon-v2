
---@class Entity
local ent = FindMetaTable("Entity")


---@return PhotonController
function ent:GetPhotonController()
	return self:GetNW2Entity( "Photon2:Controller" )
end

function ent:SetPhotonController( controller )
	self:SetNW2Entity( "Photon2:Controller", controller )
end

function ent:LookUpBoneOrError( boneName )
	local result = self:LookupBone( boneName )
	if ( not result ) then
		ErrorNoHaltWithStack( "Unable to find bone name [" .. tostring( boneName ) .. "] in model [" .. tostring( self:GetModel() .. "]."))
	end
	return result or -1
end