if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementBoneState"
BASE = "PhotonElementState"

---@class PhotonElementBoneState : PhotonElementState
---@field Activity PhotonBoneLightActivity
---@field Smooth number
---@field Direction number
---@field Speed number
---@field Target number
---@field SweepStart number
---@field SweepEnd number
---@field SweepPause number
local State = exmeta.New()

function State:New( name, data, collection )
	return PhotonElementState.New( PhotonElementBoneState, name, data, collection )
end