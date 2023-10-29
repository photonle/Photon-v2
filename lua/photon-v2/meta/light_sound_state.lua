if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSoundState"
BASE = "PhotonElementState"
---@class PhotonElementSoundState : PhotonElementState
---@field Volume number
---@field Play boolean
---@field Mute boolean
---@field DSP number
---@field Level number
---@field Pitch number
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementSoundState, name, data, collection )
end