if (exmeta.ReloadFile()) then return end

NAME = "PhotonDynamicMaterial"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local materialPrefix = "ph2_dyn"

local Repository = Photon2.DynamicMaterials

local textureParams = {
	["$basetexture"] = true,
	["$bumpmap"] = true,
	["$envmap"] = true
}

---@class PhotonDynamicMaterial
---@field Id string
---@field Parameters table
---@field Name string
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
	-- printf("Creating PhotonDynamicMaterial [%s]", id)
	id = string.StripExtension( id )
	local material = { 
		Id = id,
		Data = data,
		Name = materialPrefix .. "/" .. id,
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

function Mat.Generate( name, data, overwrite )
	if SERVER then return {} end

	data = table.Copy( data )

	if ( istable(overwrite) ) then
		table.Merge( data, overwrite )
	end

	local result = {
		Id = name,
		Name = "!" .. name,
		Material = Material ( "!" .. name )
	}
	-- Create the material
	local creationParameters = PhotonDynamicMaterial.BuildCreationParameters( table.Copy( data ) )
	CreateMaterial( name, data[1] or "UnlitGeneric", creationParameters )
	-- Update the material once more
	result.Data = table.Copy( data )
	PhotonDynamicMaterial.SetMaterialParameters( result.Material, data, true )
	return result
end


---@param id string | integer
---@param material PhotonDynamicMaterial
---@param onCreate? function
---@return PhotonDynamicMaterial
function Mat.CreateNow( id, material, onCreate )
	-- printf("Creating NOW a PhotonDynamicMaterial [%s]", id)
	local materialName = materialPrefix .. "/" .. id
	local mat
	-- local mat = Material( material.MaterialName )
	material.Parameters = Mat.ProcessMaterialData( table.Copy(material.Data) )

	local existed = true

	if ( ( not Mat.Get( id ) ) ) then
	-- if ( ( not Mat.Get( id ) ) or ( mat:IsError() ) ) then
		existed = false
		-- printf( "Creating new material [%s].", id )
		local shader = material[1] or material["Shader"]
		if ( not isstring(shader) ) then shader = "UnLitGeneric" end
		-- printf( "Calling CreateMaterial. Shader [%s]. Name [%s].", shader, materialName )
		-- print("======== PARAMETERS =========")
		local parameters = table.Copy( Mat.BuildCreationParameters( material.Data ) )
		-- PrintTable( parameters )
		-- print("==== END OF PARAMETERS ======")
		mat = CreateMaterial( materialName, shader, parameters )
	else
		-- printf("The material appears to already exist...")
		mat = Material( material.MaterialName, "smooth mips" )
	end

	material.Material = mat
	setmetatable( material, { __index = PhotonDynamicMaterial } )

	material.SetMaterialParameters( material.Material, material.Parameters, material.ShouldRecompute)

	if ( mat:IsError() ) then
		error("Material creation [" .. tostring( id ) .. "] failed for an unknown reason.")
	end

	Mat.Set( id, material )

	if ( onCreate and isfunction(onCreate) ) then onCreate( id ) end

	return material
end

---@param material IMaterial
---@param parameters table
---@param recompute boolean
function Mat.SetMaterialParameters( material, parameters, recompute )
	for key, value in pairs( parameters ) do
		if ( key == "Shader" or isnumber(key) ) then continue end
		-- printf("Setting [%s] to [%s]. The value type is [%s]", key, value, type(value))
		if ( isnumber( value ) and (value % 1) == 0 ) then material:SetFloat( key, value )
		elseif ( isnumber( value ) ) then material:SetFloat( key, value )
		elseif ( isvector( value ) ) then material:SetVector( key, value )
		elseif ( IsColor( value ) ) then material:SetVector( key, value )
		elseif ( isstring( value ) and ( not textureParams[key] )) then material:SetString( key, value )
		elseif ( ismatrix( value ) ) then material:SetMatrix( key, value )
		elseif ( type(value) == "IMaterial" ) then material:SetTexture( key, value:GetTexture( key ) )
		elseif ( type(value) == "ITexture" ) then material:SetTexture( key, value )
		else
			print("[WARNING] Unrecognized material parameter type [" .. tostring(type( value ) .. "]"))
		end
	end
	if ( recompute ) then
		material:Recompute()
	end
end

-- function Mat:ApplyMaterialParameters( recompute )
-- 	print("Applying material parameters...")
-- 	local material = self.Material
-- 	for key, value in pairs( self.Parameters ) do
-- 		printf("Setting [%s] to [%s]. The value type is [%s]", key, value, type(value))
-- 		if ( isnumber( value ) ) then material:SetInt( key, value )
-- 		elseif ( isnumber( value ) and (value % 1) == 0 ) then material:SetFloat( key, value )
-- 		elseif ( isvector( value ) ) then 
-- 			printf("\t*** Setting vector: %s", value)
-- 			material:SetVector( key, value )
-- 			printf("\t*** Material's value: %s", material:GetVector(key))
-- 		elseif ( IsColor( value ) ) then material:SetVector( key, value )
-- 		elseif ( isstring( value ) and ( not textureParams[key] ) ) then material:SetString( key, value )
-- 		elseif ( ismatrix( value ) ) then material:SetMatrix( key, value )
-- 		elseif ( type(value) == "ITexture" ) then material:SetTexture( key, value )
-- 		else
-- 			print("[WARNING] Unrecognized material parameter type [" .. tostring(type( value ) .. "]"))
-- 		end
-- 	end
-- 	if ( recompute ) then
-- 		printf( "Recomputing material [%s]...", self.Id )
-- 		material:Recompute()
-- 	end
-- end

function Mat.BuildCreationParameters( parameters )
	-- When initially creating a material, the parameters 
	-- must be only string and table values. When updating the material, 
	-- the parameters need to be set as their type and cannot be just strings.
	local result = {}
	for key, value in pairs( parameters ) do
		if ( isnumber(key) or (key == "Shader")) then continue end
		if ( isvector(value) ) then
			result[key] = "[" .. tostring(value) .. "]"
		elseif ( istable(value) ) then
			result[key] = Mat.BuildCreationParameters( value )
		elseif ( type(value) == "IMaterial" ) then
			result[key] = value:GetTexture(key):GetName()
		elseif ( type(value) == "ITexture" ) then
			result[key] = value:GetName()
		elseif ( isstring( value ) and textureParams[key] and string.EndsWith( value, ".png") ) then
			result[key] = "photon/common/blank"
		else
			result[key] = tostring( value )
		end
	end
	return result
end

function Mat.ProcessMaterialData( data )
	for key, value in pairs( data ) do
		if (textureParams[key]) then
			if ( isstring( value ) and string.EndsWith( value, ".png" ) ) then
				data[key] = Material( value, "smooth mips" ):GetTexture( "$basetexture" )
			end
		end
	end
	return data
end


-- Mat.__call = Mat.Create

hook.Add( "Photon2:ClientMaterialsLoaded", "Photon2:ClientMaterialsLoaded", function()
	Repository = Photon2.DynamicMaterials
end)