Photon2 = Photon2 or {}

if CLIENT then
    MsgC( Color(255, 94, 82), "\nP H O ", Color(97, 160, 255), "T O N ", Color(255, 255, 255, 255), " v2\n\n")
end

local fol, files, folders = ""

include("photon_v2/sh_debug.lua")

local libraries = {
	"components",
	"vehicles"
}

if SERVER then

	-- load exlib utilities library
	fol = "photon_v2/exlib/"

    files, folders = file.Find( fol .. "sv_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		include( fol .. fil )
	end

	files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		include( fol .. fil )
		AddCSLuaFile( fol .. fil )
	end

	files, folders = file.Find( fol .. "cl_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
	end

	-- load Photon 2
	fol = "photon_v2/"
    
    files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
    for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
    end

    files, folders = file.Find( fol .. "cl_*.lua", "LUA" )
    for _, fil in pairs( files ) do
		AddCSLuaFile( fol .. fil )
    end

	for _, lib in pairs( libraries ) do
		fol = "photon_v2/library/" .. lib .. "/"
		files, folders = file.Find( fol .. "*.lua", "LUA" )
		for __, fil in pairs( files ) do
			AddCSLuaFile( fol .. fil )
		end
	end

	-- load 

	include("photon_v2/sv_init.lua")
    include("photon_v2/sv_net.lua")

end

if CLIENT then

	fol = "photon_v2/exlib/"

	files, folders = file.Find( fol .. "sh_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		include( fol .. fil )
	end

	files, folders = file.Find( fol .. "cl_*.lua", "LUA" )
	for _, fil in pairs( files ) do
		include( fol .. fil )
	end

	include("photon_v2/cl_init.lua")

end