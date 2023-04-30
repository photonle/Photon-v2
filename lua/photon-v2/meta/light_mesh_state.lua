if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightMeshState"
BASE = "PhotonLightState"

---@class PhotonLightMeshState : PhotonLightState
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightMeshState, name, data, collection )
end