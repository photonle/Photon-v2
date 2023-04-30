if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightSubState"
BASE = "PhotonLightState"

---@class PhotonLightSubState : PhotonLightState
---@field Material string Material to apply.
local State = exmeta.New()


function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightSubState, name, data, collection )
end