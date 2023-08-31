Photon2.MeshCache = Photon2.MeshCache or {
	Cache = {}
}

local printf = Photon2.Debug.PrintF

---@param model string Model name
---@param material string Material name
---@param index? number
function Photon2.MeshCache.GetMesh( model, material, index )
	local cache = Photon2.MeshCache.Cache

	index = index or 1

	if ( not cache[model] ) then
		local meshes = util.GetModelMeshes( model )

		cache[model] = {}
		
		for i=1, #meshes do
			local meshResult = meshes[i]
			local _material = meshResult.material
			cache[model][_material] = cache[model][_material] or {}
			cache[model][_material][#cache[model][_material]+1] = {
				MasterIndex = i,
				Index = #cache[model][_material]+1,
				Triangles = meshResult.triangles
			}
		end
		
	end

	if ( not cache[model][material] ) then
		error("Material name '" .. tostring(material) .. "' was not found in model '" .. tostring(model) .. "'.")
	end

	if ( not cache[model][material][index] ) then
		error("Mesh material index '" .. tostring( index ) .. "' was not located in model mesh '" .. tostring(material) .."' in model '" .. tostring(model) .."'" )
	end

	if ( not cache[model][material][index].Mesh ) then
		cache[model][material][index].Mesh = Mesh()
		cache[model][material][index].Mesh:BuildFromTriangles( cache[model][material][index].Triangles )
	end

	return cache[model][material][index].Mesh
end