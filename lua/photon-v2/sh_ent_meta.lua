
---@class Entity
local ent = FindMetaTable("Entity")


---@return PhotonController
function ent:GetPhotonController()
	return self:GetNW2Entity( "Photon2:Controller" )
end

-- Checks if the entity's parent or ancestors have a Photon Controller if 
-- the entity itself does not. Is necessary for custom vehicle bases where
-- the driver is technically in a seat and the seat is not the intended target.
---@return PhotonController|nil
function ent:GetPhotonControllerFromAncestor()
	if ( IsValid( self:GetPhotonController() ) ) then
		return self:GetPhotonController()
	elseif ( IsValid( self:GetParent() ) ) then
		return self:GetParent():GetPhotonControllerFromAncestor()
	end
	return nil
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

function ent:IsPhoton2Seat()
	if ( self:GetClass() == "prop_vehicle_prisoner" ) then
		return true
	end
end