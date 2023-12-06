if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSoundState"
BASE = "PhotonElementState"
---@class PhotonElementSoundState : PhotonElementState, PhotonElementSoundStateProperties
local State = exmeta.New()

function State.New( self, name, data, collection )
	return PhotonElementState.New( PhotonElementSoundState, name, data, collection )
end