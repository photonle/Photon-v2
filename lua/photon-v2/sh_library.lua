Photon2.Library = Photon2.Library or {
	ComponentsGraph = {},
	-- New Library system
	Types = {},
	Repository = {},
	---@type PhotonInputConfigurationLibrary
	InputConfigurations = nil
}

local library = Photon2.Library
local _g = _G
local Util = Photon2.Util

local info, warn = Photon2.Debug.Declare( "Library" )

local printf = info
local print = info

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
		-- Clears out the old compiled version (if it exists)
		-- to force a recompile next time the profile is requested
		self.Index[profile.Name] = nil
		if ( Photon2.ClientInput.Active and ( Photon2.ClientInput.Active.Name == profile.Name ) ) then
			-- Should immediately trigger a recompile
			Photon2.ClientInput.SetActiveConfiguration( profile.Name )
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
	OnPostReload = function()
		Photon2.Library.InputConfigurations:ReloadIndex()
	end
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
	end,
	UI = {
		PreviewPanel = "Photon2UISirenPreviewer",
		BrowserColumnSchema = {

			{
				Label = "Make",
				Property = "Make",
				Search = true
			},
			{
				Label = "Model",
				Property = "Model",
				Search = true,
				DefaultSortBy = true 
			},
			{
				Label = "Author",
				Property = "Author",
				Search = true,
				MaxWidth = 80
			},
			{
				Label = "Name",
				Property = "Name",
				Search = true,
				Visible = false
			},
			{
				Label = "Source",
				Property = "SourceType",
				MaxWidth = 56,
				MinWidth = 56,
				Visible = false
			},

		}
	}
}

---@type PhotonLibraryType
local schemas = {
	Name = "Schemas",
	Folder = "schemas",
	Singular = "Schema",
}

---@type PhotonLibraryType
local components = {
	Name = "Components",
	Folder = "components",
	Singular = "Component",
	DoCompile = function( self, data )
		local component = PhotonLightingComponent.New( data.Name, data )
		return component
	end,
	GetInherited = function( self, data, unique )
		if ( isstring( data ) ) then data = self:GetCopy( data ) end
		if ( unique ) then data = Photon2.Util.UniqueCopy( data ) end
		if ( data.Base ) then
			local dataInputs
			if ( istable( data.Inputs ) ) then dataInputs = table.Copy( data.Inputs ) end
			Photon2.Util.Inherit( data, table.Copy( Photon2.BuildParentLibraryComponent( name, data.Base ) ))
			Photon2.Library.ComponentsGraph[data.Base] = Photon2.Library.ComponentsGraph[data.Base] or {}
			Photon2.Library.ComponentsGraph[data.Base][data.Name] = true
	
			Photon2.ComponentBuilder.InheritInputs( dataInputs, data.Inputs )
		end
		return data
	end,
	PostCompile = function( self, name, isReload, hardReload )
		-- TODO: lazy loading needs to be implemented to maintain
		-- good compilation performance
		if ( isReload ) then
			for id, _ in pairs( Photon2.Library.ComponentsGraph[name] or {} ) do
				if ( id ~= name ) then
					self:Register( self:Get( id ) )
				end
			end
		end
	end,
	PreRegister = function( self, data )
		-- Required for backwards compatibility
		data.Title = data.Title or data.PrintName
		PHOTON_LIBRARY_COMPONENT = nil
	end,
	PostRegister = function( self, name )
		hook.Run( "Photon2:ComponentReloaded", name, self:Get( name ) )
	end,
	FindCategory = function( self, name )
		local component = self:Get( name )
		if ( component.Category ) then
			return component.Category
		elseif ( component.Base ) then
			return self:FindCategory( component.Base  )
		else
			return nil
		end
	end,
	UI = {
		PreviewPanel = "Photon2UIComponentPreviewer",
		DefaultFilter = "Lua",
		BrowserColumnSchema = {
			{
				Label = "Type",
				Property = "Category",
				Search = true,
				MinWidth = 80,
				MaxWidth = 80
			},
			{
				Label = "Title",
				Property = "Title",
				Search = true,
				DefaultSortBy = true
			},
			{
				Label = "Source",
				Property = "SourceType",
				MaxWidth = 56,
				MinWidth = 56,
				Visible = false
			},
			{
				Label = "Name",
				Property = "Name",
				Search = true,
				Visible = false
			},
		}
	}
}

---@type PhotonLibraryType
local vehicles = {
	Name = "Vehicles",
	Folder = "vehicles",
	Singular = "Vehicle",
	EagerLoading = true,
	Signatures = { "EquipmentSignature", "SelectionsSignature" },
	DoCompile = function( self, data )
		local vehicle = PhotonVehicle.New( data )
		return vehicle
	end,
	PostCompile = function( self, name, isReload, hardReload )
		hook.Run( "Photon2.VehicleCompiled", name, nil, hardReload )
	end,
	PostRegister = function( self, name )
		-- hook.Run( "Photon2.VehicleCompiled", name, nil, true )
	end
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
Photon2.Library.AddType( components )
Photon2.Library.AddType( vehicles )

function Photon2.BuildParentLibraryComponent( childId, parentId )
	---@type PhotonLibraryComponent
	local parentLibraryComponent = Photon2.Library.Components:Get( parentId )

	if ( not parentLibraryComponent ) then
		error ("Component [" .. tostring( parentId ) .."] could not be found." )
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

function Photon2.Library.Initialize()
	local startTime = SysTime()
	Photon2.LoadLibraries({
		"Sirens",
		"Components",
		"Schemas",
		"Vehicles",
		"InteractionSounds",
		"Commands",
		"InputConfigurations"
	})
	hook.Run( "Photon2.PostInitializeLibrary" )
	printf( "Photon 2 libraries loaded in %.2f seconds.", SysTime() - startTime )
end

local initializationErrorDisplayed = false

hook.Add("Initialize", "Photon2:InitializeLibrary", function()
	Photon2.Library.Initialize()

	-- Temporary code to troubleshoot library loading problems
	if ( SERVER ) then return end
	
	if ( not Photon2.GetInputConfiguration( "default" ) ) then
		if ( not initializationErrorDisplayed ) then
			print( "[CRITICAL] The Photon 2 libraries failed to initialize correctly. This is most likely caused by a conflicting addon. Photon 2 will try to reload the libraries again in 10 seconds." )
		end
		timer.Simple( 10, Photon2.Library.Initialize )
	end
end)

---@param types string[]
function Photon2.LoadLibraries( types )
	for i=1, #types do
		---@type PhotonLibraryType
		local libraryType = Photon2.Library[types[i]]
		if ( libraryType ) then
			local success, code = pcall( libraryType.LoadLibrary, libraryType )
			if ( not success ) then
				warn("ERROR: %s", code )
			end
		end
	end
end
