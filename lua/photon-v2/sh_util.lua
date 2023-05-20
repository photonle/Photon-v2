Photon2.Util = {
	ModelMeshes = {},
	ModelMeshMap = {}
}

local Util = Photon2.Util

---@param target table
---@param meta table
function Photon2.Util.ReferentialCopy( target, meta )
	for k, v in pairs(meta) do
		if istable(v) then
			if (rawget( target, k ) == nil) then
				target[k] = meta[k]
			else
				Util.ReferentialCopy(target[k], meta[k])
			end
		end
	end
	setmetatable( target, { __index = meta } )
end

function Photon2.Util.Inherit( target, base )
	local metaTable = getmetatable( target )
	if ( not metaTable ) then
		setmetatable( target, {} )
		metaTable = getmetatable( target )
	end

	if ( metaTable.Inherits ) then
		error("Attempt to setup inheritance on a table that has already been inherited. To preserve parent data integrity, this action is not allowed.")
	end

	for key, value in pairs( base ) do
		local raw = rawget( target, key )
		if ( raw == nil ) then
			target[key] = value
		elseif ( raw == PHOTON2_UNSET ) then
			target[key] = nil
		elseif ( istable( raw ) and istable( value ) ) then
			Photon2.Util.Inherit( raw, value )
		end
	end
	
	metaTable.Inherits = base
end

function Photon2.Util.CacheModelMesh( model, meshes )
	local materialLookup = {}
	Util.ModelMeshMap[model] = {}
	for k, v in pairs( meshes or util.GetModelMeshes( model )) do
		local material = v.material
		-- local material = string.GetFileFromFilename( v.material )
		if ( not materialLookup[material] ) then
			materialLookup[material] = 0
		end
		materialLookup[material] = materialLookup[material] + 1
		Photon2.Util.ModelMeshMap[model][material .. "[".. materialLookup[material] .. "]"] = k
	end
	print("MATERIAL LOOKUP RESULT")
	PrintTable( materialLookup )
end

function Photon2.Util.GetModelMesh( model, search, resultIndex )
	resultIndex = resultIndex or 1
	
	local meshes
	
	if ( isstring( search ) ) then
		local prev = search
		if ( Util.ModelMeshMap[model] == nil ) then
			meshes = util.GetModelMeshes( model )
			Util.CacheModelMesh( model, meshes )
		end
		search = Util.ModelMeshMap[model][search .. "[" .. resultIndex .. "]"]
		if ( not search ) then
			error("No mesh with material '" .. tostring(prev) .."' was found on model '" .. tostring(mdl) .. "'")
		end
	end

	if ( isnumber( search ) ) then
		Util.ModelMeshes[model] = Util.ModelMeshes[model] or {}
		if ( not Util.ModelMeshes[model][search] ) then
			meshes = meshes or util.GetModelMeshes( model )
			Util.ModelMeshes[model][search] = Mesh()
			Util.ModelMeshes[model][search]:BuildFromTriangles( meshes[search].triangles )
		end
	end

	return Util.ModelMeshes[model][search]
end

-- PrintTable(Util.ModelMeshes)