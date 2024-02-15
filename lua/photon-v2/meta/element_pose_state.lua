if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementPoseState"
BASE = "PhotonElementState"

---@class PhotonElementPoseState : PhotonElementState, PhotonElementPoseStateProperties
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementPoseState, name, data, collection )
end