
---@class Entity
local ENTITY = FindMetaTable( "Entity" )


---@return PhotonController
function ENTITY:GetPhotonController()
	return self:GetNW2Entity( "Photon2:Controller" )
end

-- Checks if the entity's parent or ancestors have a Photon Controller if 
-- the entity itself does not. Is necessary for custom vehicle bases where
-- the driver is technically in a seat and the seat is not the intended target.
---@return PhotonController|nil
function ENTITY:GetPhotonControllerFromAncestor()
	if ( IsValid( self:GetPhotonController() ) ) then
		return self:GetPhotonController()
	elseif ( IsValid( self:GetParent() ) ) then
		return self:GetParent():GetPhotonControllerFromAncestor()
	end
	return nil
end

function ENTITY:SetPhotonController( controller )
	self:SetNW2Entity( "Photon2:Controller", controller )
end

function ENTITY:LookUpBoneOrError( boneName )
	if ( not IsValid( self ) ) then ErrorNoHaltWithStack( "Attempted bone name lookup on an invalid entity." ) return -1 end
	if CLIENT then self:SetupBones() end
	local result = self:LookupBone( boneName )
	local model = self:GetModel() or "ERROR"
	if ( not result ) then
		if ( model == "ERROR" ) then
			ErrorNoHaltWithStack( "Attempted bone name lookup on an entity with an invalid or missing model." )
		else
			ErrorNoHaltWithStack( "Unable to find bone name [" .. tostring( boneName ) .. "] in model [" .. tostring( model ) .. "]. See log/console for more information." )
			if ( model ~= "ERROR" ) then
				print("\tBones found in [" .. tostring( model ) .. "]: " )
				for i=0, self:GetBoneCount() - 1 do
					print( "\t\t[" .. tostring( i ) .. "]: [" .. tostring( self:GetBoneName( i ) ) .. "] ~= [" .. tostring( boneName ) .. "]" )
				end
			end
		end
	end
	return result or -1
end

function ENTITY:IsPhoton2Seat()
	if ( self:GetClass() == "prop_vehicle_prisoner" ) then
		return true
	end
end

if SERVER then
	local VEHICLE = FindMetaTable("Vehicle")

	VEHICLE.PhotonPreviousSetSubMaterial = VEHICLE.PhotonPreviousSetSubMaterial or VEHICLE.SetSubMaterial or ENTITY.SetSubMaterial

	function VEHICLE:SetSubMaterial( index, material )
		if ( IsValid( self:GetPhotonController() ) ) then
			self:GetPhotonController():ParentSubMaterialChanged()
			VEHICLE.PhotonPreviousSetSubMaterial( self, index, material )
		else
			VEHICLE.PhotonPreviousSetSubMaterial( self, index, material )
		end
	end
end