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
		if ( metaTable.Inherits == base ) then
			return
		end
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

-- function Photon2.Util.CacheModelMesh( model, meshes )
-- 	local materialLookup = {}
-- 	Util.ModelMeshMap[model] = {}
-- 	for k, v in pairs( meshes or util.GetModelMeshes( model )) do
-- 		local material = v.material
-- 		-- local material = string.GetFileFromFilename( v.material )
-- 		if ( not materialLookup[material] ) then
-- 			materialLookup[material] = 0
-- 		end
-- 		materialLookup[material] = materialLookup[material] + 1
-- 		Photon2.Util.ModelMeshMap[model][material .. "[".. materialLookup[material] .. "]"] = k
-- 	end
-- 	print("MATERIAL LOOKUP RESULT")
-- 	PrintTable( materialLookup )
-- end

-- function Photon2.Util.GetModelMesh( model, mesh, index )
-- 	index = index or 1
	
-- 	local meshes
	
-- 	if ( isstring( mesh ) ) then
-- 		local prev = mesh
-- 		if ( Util.ModelMeshMap[model] == nil ) then
-- 			meshes = util.GetModelMeshes( model )
-- 			Util.CacheModelMesh( model, meshes )
-- 		end
-- 		mesh = Util.ModelMeshMap[model][mesh .. "[" .. index .. "]"]
-- 		if ( not mesh ) then
-- 			error("No mesh with material '" .. tostring(prev) .."' was found on model '" .. tostring(mdl) .. "'")
-- 		end
-- 	end

-- 	if ( isnumber( mesh ) ) then
-- 		Util.ModelMeshes[model] = Util.ModelMeshes[model] or {}
-- 		if ( not Util.ModelMeshes[model][mesh] ) then
-- 			meshes = meshes or util.GetModelMeshes( model )
-- 			Util.ModelMeshes[model][mesh] = Mesh()
-- 			Util.ModelMeshes[model][mesh]:BuildFromTriangles( meshes[mesh].triangles )
-- 		end
-- 	end

-- 	return Util.ModelMeshes[model][mesh]
-- end

function Photon2.Util.FindBodyGroupOptionByName( ent, bodyGroupIndex, name )
	if ( string.len(name) > 0 ) then name = name .. ".smd" end
	for index, subModel in pairs( ent:GetBodyGroups()[bodyGroupIndex+1].submodels ) do
		if ( name == subModel ) then return index end
	end
	ErrorNoHaltWithStack(string.format("Could not find body group option [%s] in body group index [%s] in model [%s]", name, bodyGroup, self:GetModel() ))
	return 0
end

function Photon2.Util.PrintTableProperties( tbl )
	print("\nSTART >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n")
	local searching = true
	local currentTable = tbl
	while ( searching ) do
		if istable( currentTable ) then
			PrintTable( currentTable )
		else

		end
		local metaTable = debug.getmetatable( currentTable )
		if ( istable( metaTable ) and istable( metaTable.__index ) ) then
			currentTable = metaTable.__index
			print("\n HAS META TABLE: ==========\n")
		else
			searching = false
		end
	end
	print("\nEND   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n")
end

-- Runs a function if it is indeed a function.
function Photon2.Run( func )
	if ( isfunction( func ) ) then func() end
end

-- PrintTable(Util.ModelMeshes)