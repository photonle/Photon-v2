if (exmeta.ReloadFile("photon-v2/meta/sh_sequence_frame.lua")) then return end

NAME = "PhotonSequenceFrame"

---@class PhotonSequenceFrame
local Frame = META

-- ******* currently unused ********

---@return PhotonSequenceFrame
function Frame.New()
	return setmetatable( {}, { __index = PhotonSequenceFrame } )
end