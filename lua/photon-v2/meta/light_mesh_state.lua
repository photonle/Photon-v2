if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightMeshState"
BASE = "PhotonLightState"

---@class PhotonLightMeshState : PhotonLightState
---@field DrawColor? PhotonBlendColor 
---@field BloomColor? PhotonBlendColor
---@field Intensity? number
---@field IntensityTransitions? boolean
local State = exmeta.New()

---@return PhotonLightMeshState
function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightMeshState, name, data, collection ) --[[@as PhotonLightMeshState]]
end