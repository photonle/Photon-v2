print("sv_functions.lua")

local folder = "photon-v2/exlib/ui/"

for _, File in pairs(file.Find(folder .. "vgui/*.lua", "LUA")) do
	AddCSLuaFile(folder .. "vgui/" .. File)
end

resource.AddFile("resource/fonts/exuimdi.ttf")