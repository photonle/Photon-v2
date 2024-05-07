--[[
                                            
	_____ _____ _____ _____ _____ _____    ___ 
	|  _  |  |  |     |_   _|     |   | |  |_  |
	|   __|     |  |  | | | |  |  | | | |  |  _|
	|__|  |__|__|_____| |_| |_____|_|___|  |___|


	E M E R G E N C Y   S Y S T E M S   P L A T F O R M


	P R O J E C T   S T A R T   D A T E :   F E B R U A R Y   1 4 T H ,   2 0 2 3
	B A S E D   O N   P H O T O N .   P R O J E C T   S T A R T :   S E P T E M B E R   2 0 1 3

	C O D E D   B Y :   S C H M A L


--]]

--[[
	Photon v2 Initialization
--]]

---@type table
Photon2 = Photon2 or {}

Photon2.Version = "2.0.27 (BETA)"

--[[
	Compatability
--]]

string.StartsWith = string.StartsWith or string.StartWith

if CLIENT then
    MsgC( Color(255, 94, 82), "\nP H O ", Color(97, 160, 255), "T O N ", Color(255, 255, 255, 255), "  v" .. Photon2.Version .. "\n\n")
end

local fol, files, folders = "", nil, nil

include("photon-v2/sh_debug.lua")

local libraries = {
	"components",
	"vehicles",
	"sirens",
	"interaction_sounds",
	"commands",
	"input_configurations",
	"schemas"
}

local function autoInclude( fol )
	if (SERVER) then
		files, folders = file.Find( fol .. "sv_*.lua", "LUA" )
		for _, fil in pairs( files ) do
			include( fol .. fil )
		end
	end

	files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		include( fol .. fil )
		if (SERVER) then AddCSLuaFile( fol .. fil ) end
	end

	files, folders = file.Find( fol .. "cl_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
		if (CLIENT) then include( fol .. fil ) end
	end

	local _, folders = file.Find(fol .. "*", "LUA")

	if (folders) then
		for i = 1, #folders do
			autoInclude(fol .. folders[i] .. "/")
		end
	end
end

if SERVER then

	-- send meta files to client (required here for file reloading to work)
	fol = "photon-v2/meta/"
	files, folders = file.Find( fol .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
	end

	-- load exlib utilities library
    autoInclude( "photon-v2/exlib/" )

	-- load Photon 2
	fol = "photon-v2/"
    
    files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
    for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
    end

    files, folders = file.Find( fol .. "cl_*.lua", "LUA" )
    for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
    end

	for _, lib in pairs( libraries ) do
		fol = "photon-v2/library/" .. lib .. "/"
		files, folders = file.Find( fol .. "*.lua", "LUA" )
		for __, fil in pairs( files ) do
			AddCSLuaFile( fol .. fil )
		end
	end

	-- load 

	include("photon-v2/sv_init.lua")
    include("photon-v2/sv_net.lua")

end

if CLIENT then
	autoInclude("photon-v2/exlib/")
	include("photon-v2/cl_init.lua")
end