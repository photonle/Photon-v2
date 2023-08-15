if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightBoneState"
BASE = "PhotonLightState"

---@class PhotonLightBoneState : PhotonLightState
---@field Activity PhotonBoneLightActivity
---@field Smooth number
---@field Direction number
---@field Speed number
---@field Target number
---@field SweepTo number
local State = exmeta.New()

function State:New( name, data, collection )
	return PhotonLightState.New( PhotonLightBoneState, name, data, collection )
end