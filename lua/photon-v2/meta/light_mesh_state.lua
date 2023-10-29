if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementMeshState"
BASE = "PhotonElementState"

---@class PhotonElementMeshState : PhotonElementState
---@field DrawColor? PhotonBlendColor 
---@field BloomColor? PhotonBlendColor
---@field Intensity? number
---@field IntensityTransitions? boolean
local State = exmeta.New()

---@return PhotonElementMeshState
function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementMeshState, name, data, collection ) --[[@as PhotonElementMeshState]]
end