Photon2.Debug = {}

local red = Color(255, 72, 0)
local blu = Color(97, 160, 255)
local blk = Color(0, 0, 0)
local whi = Color(255, 255, 255)
local sv = Color(137, 222, 255)
local cl = Color(255, 222, 102)

function Photon2.Debug.Print( text )
	local col = sv
	if CLIENT then col = cl end
	MsgC( col, "[", red, "PHO", blu, "TON", whi, "2", col, "] ", col, text .. "\n")
end
