if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementProjectedState"
BASE = "PhotonElementState"

---@class PhotonElementProjectedState : PhotonElementState
---@field Color PhotonColor
local State = exmeta.New()

State.Color = PhotonColor( 255, 255, 255 )

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementProjectedState, name, data, collection )
end