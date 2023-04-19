if (exmeta.ReloadFile()) then return end

NAME = "PhotonSequenceFrame"

---@class PhotonSequenceFrame
local Frame = META

-- ******* currently unused ********

---@return PhotonSequenceFrame
function Frame.New()
	return setmetatable( {}, { __index = PhotonSequenceFrame } )
end