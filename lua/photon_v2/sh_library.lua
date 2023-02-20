Photon2.Library = Photon2.Library or {}
local Library = Photon2.Library

Library.Components = Library.Components or {}
Library.Vehicles = Library.Vehicles or {}

local componentsRoot = "photon_v2/library/components/"
local vehiclesRoot = "photon_v2/library/vehicles/"

function Photon2.LoadComponentFile( filePath )
	Photon2.Debug.Print("Loading component file: " .. filePath)
	local nameStart = string.len(componentsRoot) + 1
	local nameEnd = string.len(componentsRoot) - nameStart - 4
	local name = string.sub(filePath, nameStart, nameEnd)
	Photon2.Debug.Print("Component name: " .. name)
	_COMPONENT = COMPONENT
	COMPONENT = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	if (istable(Library.Components[name])) then
		Photon2.Debug.Print("Component '" .. name .. "' already exists. Overwriting.")
	end
	COMPONENT.Name = name
	Library.Components[name] = COMPONENT
	COMPONENT = _COMPONENT
end

function Photon2.LoadComponentLibrary( folderPath )
	folderPath = folderPath or ""
	local search = componentsRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadComponentFile( search .. fil )
	end
	hook.Call("Photon2.LoadComponentLibrary")
end

function Photon2.ReloadComponent( id )
	if (Photon2._acceptFileReload) then
		Photon2.Debug.Print("Reloading component: " .. tostring(id))
		Photon2.LoadComponentFile(componentsRoot .. id .. ".lua")
		return true
	end
	return false
end

hook.Add("InitPostEntity", "Photon2:LoadComponentLibrary", Photon2.LoadComponentLibrary)


function Photon2.LoadVehicleFile( filePath )
	Photon2.Debug.Print("Loading vehicle file: " .. filePath)
	local nameStart = string.len(vehiclesRoot) + 1
	local nameEnd = string.len(vehiclesRoot) - nameStart - 4
	local name = string.sub(filePath, nameStart, nameEnd)
	Photon2.Debug.Print("Vehicle name: " .. name)
	_VEHICLE = VEHICLE
	VEHICLE = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	if (istable(Library.Vehicles[name])) then
		Photon2.Debug.Print("Vehicle '" .. name .. "' already exists. Overwriting.")
	end
	VEHICLE.Name = name
	Library.Vehicles[name] = VEHICLE
	VEHICLE = _VEHICLE
end

function Photon2.LoadVehicleLibrary( folderPath )
	folderPath = folderPath or ""
	local search = vehiclesRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadVehicleFile( search .. fil )
	end
	hook.Call("Photon2.LoadVehicleLibrary")
end

function Photon2.ReloadVehicle( id )
	if (Photon2._acceptFileReload) then
		Photon2.Debug.Print("Reloading component: " .. tostring(id))
		Photon2.LoadVehicleFile(vehiclesRoot .. id .. ".lua")
		return true
	end
	return false
end

hook.Add("InitPostEntity", "Photon2:LoadVehicleLibrary", Photon2.LoadVehicleLibrary)
