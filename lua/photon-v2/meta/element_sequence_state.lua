if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSequenceState"
BASE = "PhotonElementState"

---@class PhotonElementSequenceState : PhotonElementState
---@field Sequence string Sequence name.
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementSequenceState, name, data, collection )
end