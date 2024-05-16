Photon2.MeshCache = Photon2.MeshCache or {
	Cache = {}
}

local printf = Photon2.Debug.PrintF

function Photon2.MeshCache.ClearCache()
	Photon2.MeshCache.Cache = {}
	collectgarbage("collect")
	hook.Run( "Photon2.MeshCache:Purge" )
end

---@param model string Model name
---@param material string Material name
---@param index? number
function Photon2.MeshCache.GetMesh( model, material, index )
	local cache = Photon2.MeshCache.Cache

	index = index or 1
	local modelExists = true

	if ( not cache[model] ) then
		local meshes = util.GetModelMeshes( model )

		if ( not meshes ) then
			modelExists = false
			meshes = {}
		end

		cache[model] = {}
		
		for i=1, #meshes do
			local meshResult = meshes[i]
			local _material = meshResult.material
			cache[model][_material] = cache[model][_material] or {}
			-- Ignore meshes with no geometry
			if ( istable( meshResult.triangles ) and #meshResult.triangles > 0 ) then
				local mesh = Mesh()
				mesh:BuildFromTriangles( meshResult.triangles )
				cache[model][_material][#cache[model][_material] + 1] = {
					MasterIndex = i,
					Index = #cache[model][_material] + 1,
					Mesh = mesh
				}
			end
		end
		
	end

	if ( modelExists ) then
		if ( not cache[model][material] ) then
			error("Material name '" .. tostring(material) .. "' was not found in model '" .. tostring(model) .. "'.")
		end
	
		if ( not cache[model][material][index] ) then
			error("Mesh material index '" .. tostring( index ) .. "' was not located in model mesh '" .. tostring(material) .."' in model '" .. tostring(model) .."'" )
		end
	else
		error( "Model " .. tostring( model ) .. " could not be found." )
	end

	return cache[model][material][index].Mesh
end