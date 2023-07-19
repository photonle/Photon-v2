if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightProjectedState"
BASE = "PhotonLightState"

---@class PhotonLightProjectedState : PhotonLightState
---@field Color PhotonColor
local State = exmeta.New()

State.Color = PhotonColor( 255, 255, 255 )

function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightProjectedState, name, data, collection )
end