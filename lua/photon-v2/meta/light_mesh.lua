if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightMesh"
BASE = "PhotonLight"

---@class PhotonLightMesh : PhotonLight
---@field Model string
---@field MeshId number Model's mesh index.
---@field SubMaterial string Finds mesh from its corresponding sub-material.
---@field States table<string, PhotonLightMeshState>
local Light = exmeta.New()

Light.Class = "Mesh"

function Light.New( data )

end

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonLightMesh })
end