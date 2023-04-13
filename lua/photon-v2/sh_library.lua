Photon2.Library = Photon2.Library or {
	Components = {},
	Vehicles = {}
}

local library = Photon2.Library
local _g = _G

local componentsRoot = "photon-v2/library/components/"
local vehiclesRoot = "photon-v2/library/vehicles/"

local print = Photon2.Debug.PrintF

function Photon2.LoadComponentFile( filePath, isReload )
	Photon2.Debug.Print("Loading component file: " .. filePath)
	local nameStart = string.len(componentsRoot) + 1
	local nameEnd = string.len(componentsRoot) - nameStart - 4
	local name = string.sub(filePath, nameStart, nameEnd)
	Photon2.Debug.Print("Component name: " .. name)
	-- _COMPONENT = COMPONENT
	PHOTON_LIBRARY_COMPONENT = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	if (istable(library.Components[name])) then
		Photon2.Debug.Print("Component '" .. name .. "' already exists. Overwriting.")
	end
	PHOTON_LIBRARY_COMPONENT.Name = name
	library.Components[name] = PHOTON_LIBRARY_COMPONENT
	-- COMPONENT = _COMPONENT
	PHOTON_LIBRARY_COMPONENT = nil
	if (isReload) then
		Photon2.CompileComponent( name, library.Components[name] )
		hook.Run( "Photon2:ComponentReloaded", name, library.Components[name] )
	end
end

function Photon2.LoadComponentLibrary( folderPath )
	folderPath = folderPath or ""
	local search = componentsRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadComponentFile( search .. fil )
	end
	hook.Call("Photon2.LoadComponentLibrary")
	Photon2.Index.ProcessComponentLibrary()
end

function Photon2.ReloadComponent( id )
	if (Photon2._acceptFileReload) then
		Photon2.Debug.Print( "Reloading component: " .. tostring(id) )
		Photon2.LoadComponentFile( componentsRoot .. id .. ".lua", true )
		return true
	end
	return false
end

---@param filePath string
---@param isReload? boolean
function Photon2.LoadVehicleFile( filePath, isReload )
	Photon2.Debug.Print("Loading vehicle file: " .. filePath)
	local nameStart = string.len(vehiclesRoot) + 1
	local nameEnd = string.len(vehiclesRoot) - nameStart - 4
	local name = filePath:sub(nameStart, nameEnd)
	Photon2.Debug.Print("Vehicle name: " .. name)
	---@type PhotonLibraryVehicle
	PHOTON2_LIBRARY_VEHICLE = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	if (istable(library.Vehicles[name])) then
		Photon2.Debug.Print("Vehicle '" .. name .. "' already exists. Overwriting.")
	end
	PHOTON2_LIBRARY_VEHICLE.ID = name
	library.Vehicles[name] = PHOTON2_LIBRARY_VEHICLE
	PHOTON2_LIBRARY_VEHICLE = nil
	print("END of LoadVehicleFile() filepath: %s", filePath)
	print("\tname: %s", name)
	Photon2.Index.CompileVehicle( name, library.Vehicles[name], isReload )
end

-- Returns the active library vehicle global when loading a vehicle file.
-- Workaround to ensure correct Lua annotation/suggestion behavior.
---@return PhotonLibraryVehicle
function Photon2.LibraryVehicle()
	return _g["PHOTON2_LIBRARY_VEHICLE"]
end

---@return PhotonLibraryComponent
function Photon2.LibraryComponent()
	return _g["PHOTON_LIBRARY_COMPONENT"]
end

function Photon2.LoadVehicleLibrary( folderPath )
	Photon2.Debug.Print("LoadVehicleLibrary() called")
	folderPath = folderPath or ""
	local search = vehiclesRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadVehicleFile( search .. fil )
	end
	Photon2.Debug.Print("LoadVehicleLibrary hook")
	
	hook.Call("Photon2.LoadVehicleLibrary")
	Photon2.Debug.Print("ProcessVehicleLibrary hook called()")
	Photon2.Index.ProcessVehicleLibrary()
end

function Photon2.ReloadComponentFile()
	if (Photon2._acceptFileReload) then
		local source = debug.getinfo(2, "S").source
		if source:sub(1, 1) == "@" then
			source = source:sub(2)
		else
			return false
		end
		
		local startPos, endPos = source:find(componentsRoot, 1, true)

		if (startPos) then
			local path = source:sub(startPos)
			Photon2.Debug.Print("Reloading vehicle: " .. tostring(path))
			Photon2.LoadComponentFile( path, true )
		else
			Photon2.Debug.Print("Attempted to call ReloadComponentFile() from an invalid file location [" .. tostring(source) .."]")
			return false
		end

		return true
	end
	return false
end

function Photon2.ReloadVehicle( id )
	if (Photon2._acceptFileReload) then
		Photon2.Debug.Print("Reloading vehicle: " .. tostring(id))
		Photon2.LoadVehicleFile(vehiclesRoot .. id .. ".lua")
		return true
	end
	return false
end

function Photon2.ReloadVehicleFile()
	if (Photon2._acceptFileReload) then
		local source = debug.getinfo(2, "S").source
		if source:sub(1, 1) == "@" then
			source = source:sub(2)
		else
			return false
		end
		
		local startPos, endPos = source:find(vehiclesRoot, 1, true)

		if (startPos) then
			local path = source:sub(startPos)
			Photon2.Debug.Print("Reloading vehicle: " .. tostring(path))
			Photon2.LoadVehicleFile( path, true )
		else
			Photon2.Debug.Print("Attempted to call ReloadVehicleFile() from an invalid file location [" .. tostring(source) .."]")
			return false
		end

		return true
	end
	return false
end

hook.Add("Initialize", "Photon2:InitializeLibrary", function()
	Photon2.LoadComponentLibrary()
	Photon2.Debug.Print("about to execute LoadVehicleLibrary()")
	Photon2.LoadVehicleLibrary()
end)