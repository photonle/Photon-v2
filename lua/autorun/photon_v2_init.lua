---@type table
Photon2 = Photon2 or {}

if CLIENT then
    MsgC( Color(255, 94, 82), "\nP H O ", Color(97, 160, 255), "T O N ", Color(255, 255, 255, 255), " v2\n\n")
end

local fol, files, folders = "", nil, nil

include("photon-v2/sh_debug.lua")

local libraries = {
	"components",
	"vehicles"
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
	files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
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