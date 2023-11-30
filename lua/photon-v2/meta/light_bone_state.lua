if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementBoneState"
BASE = "PhotonElementState"

---@class PhotonElementBoneState : PhotonElementState, PhotonElementBoneStateProperties
local State = exmeta.New()

function State:New( name, data, collection )
	return PhotonElementState.New( PhotonElementBoneState, name, data, collection )
end