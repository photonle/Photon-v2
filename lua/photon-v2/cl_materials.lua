Photon2.Materials = Photon2.Materials or {
	Index = {}
}

local whi16 = Material( "photon/whi_16px.png" )

function Photon2.Materials.ProcessMaterialData( data )
	return data
end

function Photon2.Materials.Create( id, data )
	local matId = "photon2/" .. id
	local material = Material( "!" .. id )

	if ( material:IsError() ) then
		local shader = data[1]

		if (not isstring(shader)) then shader = "UnLitGeneric" end

		material = CreateMaterial(
			matId,
			shader,
			Photon2.Materials.ProcessMaterialData( data )
		)
	end

end


---@param material IMaterial
---@param processedData table
function Photon2.Materials.ApplyProcessedDataToMaterial( material, processedData )
	for key, value in pairs( processedData ) do
		if ( isnumber( value ) ) then material:SetInt( key, value )
		elseif ( isvector( value ) ) then material:SetVector( key, value )
		
		else

		end
	end
end


---@param id string
function Photon2.Materials.Reload( id )
	local material = Photon2.Materials.GetOrError( id )

end


function Photon2.Materials.GetOrError( id )
	local matId = "!photon2/" .. id

	local material = Photon2.Materials.Index[id]

	if ( not material ) then
		error( string.format("Photon Dynamic Material [%s] is not defined.") )
	end

	return material
end