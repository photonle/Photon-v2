if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementProjectedState"
BASE = "PhotonElementState"

---@class PhotonElementProjectedState : PhotonElementState, PhotonElementProjectedStateProperties
---@field Color PhotonColor
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementProjectedState, name, data, collection )
end