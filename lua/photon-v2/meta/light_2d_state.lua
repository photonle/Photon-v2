if (exmeta.ReloadFile()) then return end

NAME = "PhotonElement2DState"
BASE = "PhotonElementState"

---@class PhotonElement2DState : PhotonElementState, PhotonElement2DStateProperties
local State = exmeta.New()

---@return PhotonElement2DState
function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElement2DState, name, data, collection ) --[[@as PhotonElement2DState]]
end