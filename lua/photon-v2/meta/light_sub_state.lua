if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSubState"
BASE = "PhotonElementState"

---@class PhotonElementSubState : PhotonElementState
---@field Material string Material to apply.
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementSubState, name, data, collection )
end