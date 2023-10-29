if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementVirtualState"
BASE = "PhotonLightState"

---@class PhotonElementVirtualState : PhotonLightState
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightState, name, data, collection )
end