if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightSoundState"
BASE = "PhotonLightState"
---@class PhotonLightSoundState : PhotonLightState
---@field Volume number
---@field Play boolean
---@field Mute boolean
---@field DSP number
---@field Level number
---@field Pitch number
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonLightState.New( PhotonLightSoundState, name, data, collection )
end