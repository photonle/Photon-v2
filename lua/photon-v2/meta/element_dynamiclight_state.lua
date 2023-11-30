if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementDynamicLightState"
BASE = "PhotonElementState"

---@class PhotonElementDynamicLightState : PhotonElementState
---@field Color? PhotonColor
---@field Brightness? number
---@field Size? number
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementState, name, data, collection )
end