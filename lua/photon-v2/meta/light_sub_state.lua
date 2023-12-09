if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSubState"
BASE = "PhotonElementState"

---@class PhotonElementSubState : PhotonElementSubStateProperties, PhotonElementState
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementSubState, name, data, collection )
end