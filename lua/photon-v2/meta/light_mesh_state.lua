if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementMeshState"
BASE = "PhotonElementState"

---@class PhotonElementMeshState : PhotonElementState
---@field DrawColor? PhotonBlendColor 
---@field BloomColor? PhotonBlendColor
---@field Intensity? number
---@field IntensityTransitions? boolean
local State = exmeta.New()

---@return PhotonElementMeshState
function State.New( self, name, data, collection )
	if ( isstring( data.DrawMaterial ) ) then
		data.DrawMaterial = Material( data.DrawMaterial )
	end
	if ( isstring( data.BloomMaterial ) ) then
		data.BloomMaterial = Material( data.BloomMaterial )
	end
	return PhotonElementState.New( PhotonElementMeshState, name, data, collection ) --[[@as PhotonElementMeshState]]
end