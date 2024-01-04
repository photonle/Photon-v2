Photon2.Library = Photon2.Library or {
	Components = {},
	-- Stores copies of raw components 
	ComponentsGraph = {},
	Vehicles = {},
	---@type table<string, PhotonLibrarySiren>

	-- New Library system
	Types = {},
	Repository = {},
	---@type PhotonInputConfigurationLibrary
	InputConfigurations = nil
}

local library = Photon2.Library
local _g = _G
local Util = Photon2.Util

local componentsRoot = "photon-v2/library/components/"
local vehiclesRoot = "photon-v2/library/vehicles/"

local printf = Photon2.Debug.PrintF
local print = Photon2.Debug.Print

---@class PhotonInputConfigurationLibrary : PhotonLibraryType
local inputConfigurations = {
	Name = "InputConfigurations",
	Folder = "input_configurations",
	Singular = "InputConfiguration",
	Template = {
		Binds = {}
	},
	OnServer = false,
	ToJson = function( self, configProfile ) 
		return Photon2.ClientInput.ExportProfileToJson( configProfile )
	end,
	FromJson = function( self, json ) 
		return Photon2.ClientInput.ImportProfileFromJson( json )
	end,
	OnReload = function( self, profile )
		if ( Photon2.ClientInput.Active and ( Photon2.ClientInput.Active.Name == profile.Name ) ) then
			Photon2.ClientInput.Active = Photon2.Index.CompileInputConfiguration( profile )
		else
			Photon2.Index.InputConfigurations[profile.Name] = nil
		end
	end,
	DoCompile = function( self, profile )
		return Photon2.Index.CompileInputConfiguration( profile )
	end,
	AddButtonToConfig = function( config, button )
		config.Binds[button] = config.Binds[button] or {}
	end,
	AddCommandToButton = function( config, button, command )
		config.Binds[button] = config.Binds[button] or {}
		config.Binds[button][#config.Binds[button]+1] = { Command = command }
	end,
	ClearCommandsFromButton = function( config, button )
		if ( config.Binds[button] ) then
			config.Binds[button] = {}
		end
	end,
	DeleteButton = function( config, button )
		config.Binds[button] = nil
	end,
	SwapButtonCommand = function( config, button, commandIndex, newCommand )
		config.Binds[button][commandIndex].Command = newCommand
	end,
	AddModifierToCommand = function( config, button, commandIndex, modifier )
		config.Binds[button][commandIndex].Modifiers = config.Binds[button][commandIndex].Modifiers or {}
		if ( not table.HasValue( config.Binds[button][commandIndex].Modifiers, modifier ) ) then
			config.Binds[button][commandIndex].Modifiers[#config.Binds[button][commandIndex].Modifiers+1] = modifier
		end
	end,
	ClearAllModifiers = function( config, button, commandIndex )
		config.Binds[button][commandIndex].Modifiers = nil
	end,
	RemoveCommandFromButton = function( config, button, commandIndex )
		table.remove( config.Binds[button], commandIndex )
	end,
	SwapCommandModifier = function( config, button, commandIndex, modifierIndex, newModifier )
		config.Binds[button][commandIndex].Modifiers[modifierIndex] = newModifier
	end,
	RemoveCommandModifier = function( config, button, commandIndex, modifierIndex )
		if ( #config.Binds[button][commandIndex].Modifiers == 1 ) then
			return Photon2.Library.InputConfigurations.ClearAllModifiers( config, button, commandIndex )
		end
		table.remove( config.Binds[button][commandIndex].Modifiers, modifierIndex )
	end,
	BuildBasicCommandMap = function( config )
		local result = {}
		for key, commands in pairs( config.Binds ) do
			for i, commandEntry in ipairs( commands ) do
				result[commandEntry.Command] = result[commandEntry.Command] or {}
				result[commandEntry.Command][#result[commandEntry.Command]+1] = {
					Key = key,
					Index = i
				}
			end
		end
		return result
	end,
	-- Removes the specified command from every key it's referenced in
	ClearCommandFromAll = function( config, command )
		local map = Photon2.Library.InputConfigurations.BuildBasicCommandMap( config )
		if not ( map[command] ) then 
			return end
		for i, assignment in pairs( map[command] ) do
			Photon2.Library.InputConfigurations.RemoveCommandFromButton( config, assignment.Key, assignment.Index )
		end
	end,
	-- For basic configuration. Erases command references from other keys and assigns to the specified key.
	AssignCommandToButtonBasic = function( config, button, command, modifier )
		if ( ( button ) and ( button < 1 ) ) then button = nil end
		if ( ( modifier ) and ( modifier < 1 ) ) then modifier = nil end
		Photon2.Library.InputConfigurations.ClearCommandFromAll( config, command )
		if ( not button ) then return end
		-- local map = Photon2.Library.InputConfigurations.BuildBasicCommandMap( config )
		config.Binds[button] = config.Binds[button] or {}
		local modifierTable = nil
		if ( modifier ) then
			modifierTable = { modifier }
		end
		config.Binds[button][#config.Binds[button]+1] = {
			Command = command,
			Modifiers = modifierTable
		}
	end,
	-- Returns the default key and modifier of a command (if it exists)
	GetDefaultButtonsForCommand = function( command )
		local default = Photon2.Library.InputConfigurations:Get("default")
		local map = Photon2.Library.InputConfigurations.BuildBasicCommandMap( default )
		if not map[command] then return nil, nil end
		local defaultCommandLocation = map[command][1]
		local modifiers = default.Binds[defaultCommandLocation.Key][defaultCommandLocation.Index].Modifiers
		local modifier
		if ( modifiers ) then modifier = modifiers[1] end
		return defaultCommandLocation.Key, modifier
	end
	-- LoadFile = function
}

---@type PhotonLibraryType
local commands = {
	Name = "Commands",
	Folder = "commands",
	Singular = "Command",
	OnServer = false,
	DoCompile = function( self, command )
		for _, activity in pairs( Photon2.ClientInput.KeyActivities ) do
			if ( command[activity] ) then
				for i, action in pairs( command[activity] ) do
					if ( istable( action.Value ) ) then
						action.ValueMap = {}
						for j, value in pairs( action.Value ) do
							action.ValueMap[value] = j
						end
					end
				end
			end
		end
		command.ExtendedTitle = command.Category .. " " .. command.Title
		return command
	end,
}

local soundFileMeta = {
	__index = {
		-- Volume of sound when played
		Volume = 100,
		-- Duration of sound file. (Developer note: does not use SoundDuration due to reliability problems.)
		Duration = 0.1,
		-- Pitch of the sound when played.
		Pitch = 100
	}
}

local soundConfigMeta = {
	__index = {
		-- Sound played as soon as button is pressed
		Press = true,
		-- Sounds played when the button is "momentary," e.g. manual and horn
		Momentary = true,
		-- Sounds played when any specified button is released
		Release = true,
		-- Sounds played when the button is pressed and held (one second by default)
		Hold = true
	}
}

---@type PhotonLibraryType
local interactionSounds = {
	Name = "InteractionSounds",
	Folder = "interaction_sounds",
	Singular = "InteractionSound",
	OnServer = false,
	DoCompile = function( self, profile )
		setmetatable( profile, soundConfigMeta )
		for key, value in pairs( profile ) do
			if ( istable( value ) and isstring( value.Sound ) ) then
				setmetatable( value, soundFileMeta )
			end
		end
		return profile
	end
}

---@type PhotonLibraryType
local sirens = {
	Name = "Sirens",
	Folder = "sirens",
	Singular = "Siren",
	-- EagerLoading = true,
	DoCompile = function( self, siren )
		return Photon2.Index.CompileSiren( siren )
	end
}

local schemas = {
	Name = "Schemas",
	Folder = "schemas",
	Singular = "Schema"
}

---@param entry PhotonLibraryType
function Photon2.Library.AddType( entry )
	entry = PhotonLibraryType.New( entry )
end

Photon2.Library.AddType( sirens )
Photon2.Library.AddType( inputConfigurations )
Photon2.Library.AddType( commands )
Photon2.Library.AddType( interactionSounds )
Photon2.Library.AddType( schemas )

function Photon2.LoadComponentFile( filePath, isReload )
	-- Photon2.Debug.Print("Loading component file: " .. filePath)
	local nameStart = string.len(componentsRoot) + 1
	local nameEnd = string.len(componentsRoot) - nameStart - 4
	local name = string.sub(filePath, nameStart, nameEnd)
	-- Photon2.Debug.Print("Component name: " .. name)
	-- _COMPONENT = COMPONENT
	_UNSET = UNSET
	UNSET = PHOTON2_UNSET
	PHOTON_LIBRARY_COMPONENT = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	-- if (istable(library.Components[name])) then
	-- 	Photon2.Debug.Print("Component '" .. name .. "' already exists. Overwriting.")
	-- end
	PHOTON_LIBRARY_COMPONENT.Name = name
	library.Components[name] = PHOTON_LIBRARY_COMPONENT
	-- COMPONENT = _COMPONENT
	PHOTON_LIBRARY_COMPONENT = nil
	UNSET = _UNSET
	if (isReload) then
		Photon2.CompileComponent( name, library.Components[name] )
	end
end

function Photon2.LoadComponentLibrary( folderPath )
	folderPath = folderPath or ""
	local search = componentsRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadComponentFile( search .. fil )
	end
	hook.Run("Photon2.LoadComponentLibrary")
	Photon2.Index.ProcessComponentLibrary()
end

function Photon2.BuildParentLibraryComponent( childId, parentId )
	---@type PhotonLibraryComponent
	local parentLibraryComponent = Photon2.Library.Components[parentId]
	-- local libraryComponent = table.Copy(Photon2.Library.Components[parentId])
	if ( not parentLibraryComponent ) then
		error ("Component [" .. tostring(childId) .. "] attempted to inherit from parent component [" .. tostring( parentId ) .."], which could not be found." )
	end
	parentLibraryComponent = table.Copy( parentLibraryComponent )
	local parentLibraryComponentInputs
	if ( parentLibraryComponent.Inputs ) then parentLibraryComponentInputs = table.Copy(  parentLibraryComponent.Inputs ) end
	if ( parentLibraryComponent.Base ) then
		Util.Inherit( parentLibraryComponent, Photon2.BuildParentLibraryComponent( parentId, parentLibraryComponent.Base ))
		Photon2.ComponentBuilder.InheritInputs( parentLibraryComponentInputs, parentLibraryComponent.Inputs )
	end
	return parentLibraryComponent
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
	-- Photon2.Debug.Print("Loading vehicle file: " .. filePath)
	local nameStart = string.len(vehiclesRoot) + 1
	local nameEnd = string.len(vehiclesRoot) - nameStart - 4
	local name = string.lower(filePath:sub(nameStart, nameEnd))
	-- Photon2.Debug.Print("Vehicle name: " .. name)
	---@type PhotonLibraryVehicle
	PHOTON2_LIBRARY_VEHICLE = {}
	Photon2._acceptFileReload = false
	include( filePath )
	Photon2._acceptFileReload = true
	-- if (istable(library.Vehicles[name])) then
	-- 	Photon2.Debug.Print("Vehicle '" .. name .. "' already exists. Overwriting.")
	-- end
	PHOTON2_LIBRARY_VEHICLE.ID = name
	library.Vehicles[name] = PHOTON2_LIBRARY_VEHICLE
	PHOTON2_LIBRARY_VEHICLE = nil
	-- printf("END of LoadVehicleFile() filepath: %s", filePath)
	-- printf("\tname: %s", name)
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
	-- Photon2.Debug.Print("LoadVehicleLibrary() called")
	folderPath = folderPath or ""
	local search = vehiclesRoot .. folderPath
	local files, folders = file.Find( search .. "*.lua", "LUA" )
	for _, fil in pairs( files ) do
		Photon2.LoadVehicleFile( search .. fil )
	end
	-- Photon2.Debug.Print("LoadVehicleLibrary hook")
	
	hook.Run("Photon2.LoadVehicleLibrary")
	-- Photon2.Debug.Print("ProcessVehicleLibrary hook called()")
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
			Photon2.Debug.Print("Reloading component: " .. tostring(path))
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
	Photon2.LoadLibraries( { "Sirens" })
	Photon2.LoadComponentLibrary()
	Photon2.LoadLibraries( { "Schemas" })
	Photon2.LoadVehicleLibrary()
	Photon2.LoadLibraries( { "InteractionSounds", "Commands", "InputConfigurations" } )

	if CLIENT then
		-- Photon2.ClientInput.SetActiveConfiguration( "default" )
	end
	hook.Run( "Photon2.PostInitializeLibrary" )
end)

---@param types string[]
function Photon2.LoadLibraries( types )
	for i=1, #types do
		---@type PhotonLibraryType
		local libraryType = Photon2.Library[types[i]]
		if ( libraryType ) then
			libraryType:LoadLibrary()
		end
	end
end
