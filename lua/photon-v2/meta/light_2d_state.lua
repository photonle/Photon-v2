if (exmeta.ReloadFile()) then return end

NAME = "PhotonElement2DState"
BASE = "PhotonElementState"

---@class PhotonElement2DState : PhotonElementState
---@field SingleSourceColor PhotonElementColor Source color for lights that use a *single* 2D source material.
---@field SourceFillColor PhotonElementColor Base color used for the fill material on Fill/Detail-configured lights.
---@field SourceDetailColor PhotonElementColor Detail/overlay color used for the detail material on Fill/Detail-configured lights.
---@field GlowColor Color
---@field SubtractiveMid PhotonElementColor
local State = exmeta.New()

State.SourceFillColor = nil
State.SourceDetailColor = nil

---@return PhotonElement2DState
function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElement2DState, name, data, collection ) --[[@as PhotonElement2DState]]
end