if (exmeta.ReloadFile()) then return end

NAME = "PhotonDynamicMaterial"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local materialPrefix = "ph2_dyn"

local Repository = Photon2.DynamicMaterials

local textureParams = {
	["$basetexture"] = true,
	["$bumpmap"] = true,
}

---@class PhotonDynamicMaterial
---@field Id string
---@field Parameters table
---@field Material IMaterial
---@field MaterialName string
---@field Data table
---@field ShouldRecompute boolean
local Mat = exmeta.New()


function Mat.Get( id )
	return Repository[id]
end


function Mat.Set( id, material )
	Repository[id] = material
	return material
end


---@param png string
---@param onCreate? function
function Mat.GenerateLightQuad( png, onCreate )
	return Mat.Create( png, {
		"UnLitGeneric",
		["$basetexture"] = png,
		["$nocull"] = 1,
		["$additive"] = 1,
		["$vertexalpha"] = 1,
		["$vertexcolor"] = 1
	}, onCreate )
end

function Mat.GenerateBloomQuad( png, onCreate )
	return Mat.Create( png, {
		"UnLitGeneric",
		["$basetexture"] = png,
		["$nocull"] = 1,
		["$vertexalpha"] = 1,
		["$vertexcolor"] = 1,
		-- ["$translucent"] = 1,
		["$additive"] = 1,
		["$ignorez"] = 1
	}, onCreate )
end

---@return PhotonDynamicMaterial
function Mat.Create( id, data, onCreate )
	id = string.StripExtension( id )
	local material = { 
		Id = id,
		Data = data,
		MaterialName = "!" .. materialPrefix .. "/" .. id,
		-- Parameters = Mat.ProcessMaterialData( data ),
		ShouldRecompute = true
	}

	if SERVER then return material end

	if ( not Photon2.DynamicMaterials.Ready ) then
		Photon2.DynamicMaterials.Queue[id] = material
		return material
	end
	return Mat.CreateNow( id, material, onCreate )
end


---@param id string | integer
---@param material PhotonDynamicMaterial
---@param onCreate? function
---@return PhotonDynamicMaterial
function Mat.CreateNow( id, material, onCreate )

	local materialName = materialPrefix .. "/" .. id
	local mat = Material( material.MaterialName )
	material.Parameters = Mat.ProcessMaterialData( material.Data )

	if ( ( not Mat.Get( id ) ) or ( mat:IsError() ) ) then
		printf( "Creating new material [%s].", id )
		local shader = material[1]
		if ( not isstring(shader) ) then shader = "UnLitGeneric" end
		mat = CreateMaterial( materialName, shader, material.Parameters )
	end

	material.Material = mat
	setmetatable( material, { __index = PhotonDynamicMaterial } )

	material:ApplyMaterialParameters( material.ShouldRecompute )

	if ( mat:IsError() ) then
		error("Material creation [" .. tostring( id ) .. "] failed for an unknown reason.")
	end

	Mat.Set( id, material )

	if ( onCreate and isfunction(onCreate) ) then onCreate( id ) end

	return material
end


function Mat:ApplyMaterialParameters( recompute )
	local material = self.Material
	for key, value in pairs( self.Parameters ) do
		if ( isnumber( value ) ) then material:SetInt( key, value )
		elseif ( isnumber( value ) and (value % 1) == 0 ) then material:SetFloat( key, value )
		elseif ( isvector( value ) ) then material:SetVector( key, value )
		elseif ( IsColor( value ) ) then material:SetVector( key, value )
		elseif ( isstring( value ) ) then material:SetString( key, value )
		elseif ( ismatrix( value ) ) then material:SetMatrix( key, value )
		elseif ( type(value) == "ITexture" ) then material:SetTexture( key, value )
		else
			print("[WARNING] Unrecognized material parameter type [" .. tostring(type( value ) .. "]"))
		end
	end
	if ( recompute ) then
		printf( "Recomputing material [%s]...", self.Id )
		material:Recompute()
	end
end


function Mat.ProcessMaterialData( data )
	for key, value in pairs( data ) do
		if (textureParams[key]) then
		
			if ( isstring( value ) ) then
				data[key] = Material( value ):GetTexture( key )
			end
		
		end
	end
	
	return data
end


Mat.__call = Mat.Create

hook.Add( "Photon2:ClientMaterialsLoaded", "Photon2:ClientMaterialsLoaded", function()
	Repository = Photon2.DynamicMaterials
end)