--[[
       ____     __  __   ____   ______   ____     _   __          ___ 
      / __ \   / / / /  / __ \ /_  __/  / __ \   / | / /         |__ \
     / /_/ /  / /_/ /  / / / /  / /    / / / /  /  |/ /          __/ /
    / ____/  / __  /  / /_/ /  / /    / /_/ /  / /|  /          / __/ 
   /_/      /_/ /_/   \____/  /_/     \____/  /_/ |_/          /____/ 
                                                                   

	E  M  E  R  G  E  N  C  Y     S  Y  S  T  E  M  S     P  L  A  T  F  O  R  M


	P R O J E C T   S T A R T   D A T E :   F E B R U A R Y   1 4 T H ,   2 0 2 3
	B A S E D   O N   P H O T O N .   P R O J E C T   S T A R T :   S E P T E M B E R   2 0 1 3

	C O D E D   B Y :   S C H M A L 

--]]

--[[
	Photon v2 Initialization
--]]

if ( SERVER ) then
	
end

---@type table
Photon2 = Photon2 or {}

Photon2.Version = "2.0.39"

if CLIENT then
	CreateClientConVar( "ph2_enable_auto_download", "1", true, true, "Automatically download and mount required core addons." )
end

--[[
	Client Starter Package Addons

	(This is locked down until a more comprehensive requirement manager is implemented.)
--]]
local requiredAddons = {
	"2821476376", -- MX7000
	"2795457300", -- SM Liberty and Liberty II
	"2046835872", -- SGM props
	"1851425708", -- Anemolis antennas
	"489864412", -- TDM props
	"2932505261", -- Anemolis legacy pack
	"1701821427", -- Mighty props and components
	"2962795021", -- Paolo props and components,
	"218869210", -- SGM Shared Textures
	"739684120", -- SM Shared Textures
	"2786308957", -- SGM Edge
}

local vehicleAddons = {
	["13fpiu_sgm"] = "2798400972",
	["15charger_fm2_sgm"] = "2962795021",
	["13caprice_sgm"] = "2596828039",
	["96cvpi_sgm"] = "2861441761",
	["21durango_sgm"] = "3018829161",
	["13fpis_sgm"] = "2075396899",
	["20fpiu_new_sgm"] = "2915669862",
	["sm16fpiu"] = "2629021071",
	["91caprice_sgm"] = "2953545073"
}

if CLIENT then
	if ( GetConVar( "ph2_enable_auto_download" ):GetBool() ) then
		for _, addonId in pairs( requiredAddons ) do
			if ( not steamworks.IsSubscribed( addonId ) ) then
				steamworks.DownloadUGC( addonId, function( path, content )
					-- print("MOUNTING: " .. tostring(path))
					game.MountGMA( path )
				end )
			end
		end
	end
end

-- Checks if the given vehicle name is registered and, if so, returns
-- the respective Workshop ID.
function Photon2.SearchForVehicleContent( vehicleName )
	return vehicleAddons[vehicleName]
end

--[[
	Compatability
--]]

string.StartsWith = string.StartsWith or string.StartWith

if CLIENT then
    MsgC( Color(255, 94, 82), "\nP H O ", Color(97, 160, 255), "T O N ", Color(255, 255, 255, 255), "  v" .. Photon2.Version .. "\n\n")
end

local fol, files, folders = "", nil, nil

include( "photon-v2/sh_cami.lua" )
include( "photon-v2/sh_debug.lua" )

local libraries = {
	"components",
	"vehicles",
	"sirens",
	"interaction_sounds",
	"commands",
	"input_configurations",
	"schemas"
}

local startTime = SysTime()

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

	AddCSLuaFile("photon-v2/sh_cami.lua")
	-- Util must now come first because exlib uses it
	AddCSLuaFile("photon-v2/sh_util.lua")
	AddCSLuaFile("photon-v2/cl_convars.lua")

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


	include("photon-v2/sv_init.lua")
    include("photon-v2/sv_net.lua")

end

if CLIENT then
	-- TODO: need a better solution for the fucking Derma panels
	-- that rely on core Photon code
	include("photon-v2/cl_convars.lua")
	include("photon-v2/sh_util.lua")
	autoInclude("photon-v2/exlib/")
	include("photon-v2/cl_init.lua")
end

if (Photon2 and Photon2.Debug and Photon2.Debug.Print) then
	Photon2.Debug.Info( "INIT", "Photon 2 initialized in " .. math.Round(SysTime() - startTime, 3) .. " seconds." )
end