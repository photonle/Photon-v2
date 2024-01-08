Photon2.Index = Photon2.Index or {}
Photon2.Index.Components = Photon2.Index.Components or {}
Photon2.Index.Vehicles = Photon2.Index.Vehicles or {}
Photon2.Index.Tones = Photon2.Index.Tones or {}
Photon2.Index.Profiles = Photon2.Index.Profiles or { Map = {}, Vehicles = {} }

--[[
	Profiles = {
		Map = {
			["prop_vehicle_jeep"] = {
				["models/sentry/20fpiu_new.mdl"] = {
					["~default"] = "photon_sgm_fpiu20",
					["20fpiu_new_sgm"] = "photon_sgm_fpiu20"
				}
			}
		},
		Vehicles = {
			["sgm_fpiu_2020_new"] = "photon_sgm_fpiu20"
		}	
	}
]]

local print = Photon2.Debug.PrintF
local printf = Photon2.Debug.PrintF

local lastSave = SysTime()
local doubleSaveThreshold = 1

local index = Photon2.Index
local library = Photon2.Library
local debug = Photon2.Debug

--[[---------------------
		Config
--]]---------------------
local mergeComponentReloads = false


--[[---------------------
	Component Index
-----------------------]]

function Photon2.Index.ProcessComponentLibrary()	
	local dependencyList = {}
	-- High-level dependency check
	for name, component in pairs(library.Components) do
		table.insert(dependencyList, { name, component.Base })
		if (component.Base) and (not library.Components[component.Base]) then
			debug.Print("Component [" .. tostring(name) .. "] is based on [" .. tostring(component.Base) .. "], which could not be found. Aborting.")
			error()
		end
	end

	local loadOrder = {}
	-- Determines load order by dependencies
	while (not table.IsEmpty(dependencyList)) do
		for i, entry in pairs( dependencyList ) do
			if ((not entry[2]) or table.HasValue(loadOrder, entry[2])) then
				loadOrder[#loadOrder + 1] = entry[1]
				dependencyList[i] = nil
			end
		end
	end

	local function setMetaTable(targ, meta)
		for k, v in pairs(meta) do
			if istable(v) then
				if (targ[k] == nil) then
					targ[k] = meta[k]
				end
				setMetaTable(targ[k], meta[k])
			end
		end
		debug.setmetatable(targ, { __index = meta })
	end

	for i = 1, #loadOrder do
		local name = loadOrder[i]
		local component = library.Components[name]
		if (not component.Base) then
			-- debug.setmetatable( component, { __index = PhotonLightingComponent } )
			Photon2.CompileComponent( name, component )

			-- exmeta.SetMetaTable(component, PhotonLightingComponent)
		else
			if ( not library.Components[component.Base] ) then
				error("Attempted to inherit from [" .. tostring( component.Base ) .."], which could not found.")
			end
			if ( name == component.Base ) then
				error("It appears you attempted to inherit a component from itself: [" .. tostring( name ) .. "]" )
			end
			Photon2.CompileComponent( name, component )
			-- TODO: Component inheritance
			--setMetaTable(component, index.Components[component.Base])
			-- exmeta.SetMetaTable(component, Index.Components[component.Base])
		end
	end

end


---@param name string
---@param inputComponent PhotonLibraryComponent
---@return PhotonComponent
function Photon2.CompileComponent( name, inputComponent )
	-- print("Compiling component [" .. name .. "]")

	-- local component = _G[class].New( name, inputComponent, class )
	local component = PhotonLightingComponent.New( name, inputComponent )

	component.CompileTime = RealTime()

	if ( not component.NewLibrary ) then
		if ( mergeComponentReloads and istable(Photon2.Index.Components[name] ) ) then
			table.Merge(Photon2.Index.Components[name], component)
		else
			Photon2.Index.Components[name] = component
		end
	end

	-- Rebuild child components
	for id, _ in pairs( Photon2.Library.ComponentsGraph[name] or {} ) do
		local child = Photon2.GetLibraryComponent( id )
		if Photon2.GetLibraryComponent( id ) then
			Photon2.CompileComponent( id, Photon2.GetLibraryComponent( id ) )
		end
	end

	hook.Run( "Photon2:ComponentReloaded", name, library.Components[name] )
	return component
end


--[[---------------------
	Vehicle Index
-----------------------]]

function Photon2.Index.ProcessVehicleLibrary()
	local dependencyList = {}
	for name, vehicle in pairs(library.Vehicles) do
		dependencyList[#dependencyList+1] = { name, vehicle.Base }
		if (vehicle.Base) and (not library.Vehicles[vehicle.Base]) then
			debug.Print("Vehicle [" .. tostring(name) .. "] is based on [" .. tostring(component.Base) .. "], which could not be found. Aborting.")
			error()
		end
	end

	local loadOrder = {}
	while (not table.IsEmpty(dependencyList)) do
		for i, entry in pairs( dependencyList ) do
			if ( ( not entry[2] ) or ( table.HasValue(loadOrder, entry[2]) ) ) then
				loadOrder[#loadOrder+1] = entry[1]
				dependencyList[i] = nil
			end
		end
	end

	for i=1, #loadOrder do
		local name = loadOrder[i]
		local vehicle = library.Vehicles[name]
		if (not vehicle.Base) then
			Photon2.Index.CompileVehicle( name, vehicle )
		else
			-- TODO: Vehicle inheritance
		end
	end

end

local equipmentTypeMap = {
	["Components"] = "Component",
	["Props"] = "Prop"
}

---@param name string The name of the vehicle profile.
---@param inputVehicle PhotonLibraryVehicle The library vehicle instance to compile.
---@param isReload? boolean If the component is being reloaded (i.e. the file was just saved).
function Photon2.Index.CompileVehicle( name, inputVehicle, isReload )
	local current = Photon2.Index.Vehicles[name]

	if (not current) then
		isReload = false
	end

	local currentEquipmentCount, newEquipmentCount
	local currentEquipmentSignature, newEquipmentSignature

	local currentSelectionsSignature, newSelectionsSignature

	local hardSet = true

	local function buildEquipmentSignature( tbl )
		local sig = ""
		for equipmentType, entries in pairs( tbl ) do
			if (equipmentTypeMap[equipmentType]) then
				sig = sig .. string.format("[%s]=>{", equipmentType)
				for index, entry in ipairs( entries ) do
					local baseClassName = ""
					if (istable(entry.BaseClass)) then
						baseClassName = entry.BaseClass.Name
					end
					sig = sig .. string.format("<%s:%s(%s/%s)>", index, entry[equipmentTypeMap[equipmentType]], baseClassName, entry.Name)
				end
				sig = sig .. "}"
			end
		end
		return sig
	end

	local function buildSelectionSignature( tbl )
		local sig = ""
		for key, category in ipairs(tbl) do
			sig = sig .. string.format("[%s]", key)
			for mapKey, option in pairs(category.Map) do
				sig = sig .. tostring(mapKey) .. "("
					if (option.Option) then
						sig = sig .. string.format("<%s>*%s,", mapKey, option.Option)

					elseif (option.Variant) then
						sig = sig .. string.format("<%s>^%s,", mapKey, option.Variant)
					end
				sig = sig .. ")"
			end
		end
		return sig
	end

	if (isReload) then
		currentEquipmentSignature = buildEquipmentSignature( current.Equipment )
		if (current.EquipmentSelections) then
			currentSelectionsSignature = buildSelectionSignature( current.EquipmentSelections )
		end
	end

	Photon2.Index.Vehicles[name] = PhotonVehicle.New( inputVehicle )

	local newVehicle = Photon2.Index.Vehicles[name]


	if (isReload) then
		-- Build new Equipment signature
		newEquipmentSignature = buildEquipmentSignature( newVehicle.Equipment )
		
		if (currentEquipmentSignature == newEquipmentSignature) then
			hardSet = false
		end

		-- Build new Selections signature
		-- (any modifications of the Selections tree needs to require a hard reload)
		if (currentSelectionsSignature) then
			if ( newVehicle.EquipmentSelections ) then
				newSelectionsSignature = buildSelectionSignature( newVehicle.EquipmentSelections )				
				if (newSelectionsSignature ~= currentSelectionsSignature) then
					hardSet = true
				end
			else
				hardSet = true
			end
		elseif ((newVehicle.EquipmentSelections) and (not currentSelectionsSignature)) then
			hardSet = true
		end

		-- Saving a file twice within the specified threshold forces a hard-reload of the profile
		if ( ( lastSave + doubleSaveThreshold ) >= SysTime() ) then 
			hardSet = true 
		end
		lastSave = SysTime()
	end

	if (PHOTON2_DEBUG_VEHICLE_HARDRELOAD) then
		print("Debug global PHOTON2_DEBUG_VEHICLE_HARDRELOAD is currently true.")
		hardSet = true
	end

	hook.Run("Photon2.VehicleCompiled", name, Photon2.Index.Vehicles[name], hardSet)
	return Photon2.Index.Vehicles[name]
end

hook.Add("Photon2.VehicleCompiled", "Photon2:OnVehicleCompiled", function(name, vehicle)
	-- print("Vehicle compiled (%s)", name)
end)


local toneNameToNumber = {}
local toneNumberToName = {}

for i=1, 10 do
	toneNumberToName[i] = "T" .. tostring(i)
	toneNameToNumber["T" .. tostring(i)] = i
end

function Photon2.Index.CompileSiren( siren )
	if ( not isstring( siren.Name ) ) then 
		ErrorNoHaltWithStack( "Siren Name must be defined and must be a string. Received: " .. tostring( siren.Name ) )
		return nil
	end

	local result = table.Copy(siren)
	
	result.Sounds = result.Sounds or {}

	local buildTones = false

	if ( not result.Tones ) then
		result.Tones = {}
		buildTones = true
	end

	for name, sound in pairs( result.Sounds ) do
		sound.Name = name
		sound.Siren = result.Name
		if ( not sound.Label ) then
			sound.Label = name
		end
		if ( not sound.Icon ) then
			sound.Icon = string.lower( sound.Name )
		end
		if ( buildTones ) then
			if ( sound.Default ) then
				result.Tones[sound.Default] = sound
			end
		end
		local id = string.lower( result.Name .. "/" .. sound.Name )
		Photon2.Index.Tones[id] = sound
	end

	local numericTones = {}
	local sortedTones = {}

	for toneName, tone in pairs( result.Tones ) do
		if ( toneNameToNumber[toneName] ) then
			numericTones[#numericTones+1] = { toneName, toneNameToNumber[toneName] }
		end
	end

	table.SortByMember( numericTones, 2, true )

	for i=1, #numericTones do
		sortedTones[i] = numericTones[i][1]
		sortedTones[numericTones[i][1]] = i
	end


	if ( result.Tones.OFF == nil ) then
		result.Tones.OFF = { Default = "OFF", Name = "OFF", Label = "OFF", Icon = "siren" }
	end

	result.OrderedTones = sortedTones

	return result
	-- Photon2.Index.Sirens[result.Name] = result
	
	-- printf( "Compiling siren [%s] and adding to index.", result.Name )
	-- return Photon2.Index.Sirens[result.Name]
end

function index.ProcessSirenLibrary()
	for name, data in pairs ( library.Sirens ) do
		index.CompileSiren( data )
	end
end

function Photon2.GetSirenTone( name )
	local result = Photon2.Index.Tones[name]
	if ( result ) then return result end
	
	local split = string.Split( name, "/" )
	local siren = Photon2.GetSiren( split[1] )
	if ( siren ) and siren.Sounds[string.upper(split[2] or "")] then 
		return Photon2.GetSirenTone( name )
	else
		print( "Unable to find siren tone: " .. tostring( name ) )
	end
	return nil
end


-- Compiles a configuration with Library inheritance support
function Photon2.Index.CompileInputConfiguration( config )
	local inheritancePath = nil

	local binds = config.Binds
	if ( config.Inherit ) then
		local searching = true
		local currentParent = config.Inherit
		if ( currentParent ) then
			inheritancePath = { config.Name }
			inheritancePath[#inheritancePath+1] = currentParent
			while ( searching ) do
				-- local nextParent = Photon2.Library.InputConfigs[currentParent]
				local nextParent = Photon2.Library.InputConfigurations:Get( currentParent )
				if ( nextParent and nextParent.Inherit ) then
					inheritancePath[#inheritancePath+1] = nextParent.Inherit
					currentParent = nextParent.Inherit
				else
					searching = false
				end
			end
			binds = {}
			for i=#inheritancePath, 1, -1 do
				local parentConfig = Photon2.Library.InputConfigurations:Get(inheritancePath[i])
				-- local parentConfig = Photon2.Library.InputConfigs[inheritancePath[i]]
				for key, commands in pairs( parentConfig.Binds ) do
					binds[key] = commands
				end
			end
			config.Binds = binds
		end
	end
	
	local keys = config.Binds
	
	binds = {}

	-- Loads commands into the configuration
	for key, commands in pairs( keys ) do
		binds[key] = {}
		for _, commandEntry in pairs ( commands ) do
			local command = Photon2.GetCommand( commandEntry.Command )
			for _, event in pairs( Photon2.ClientInput.KeyActivities ) do
				if ( command[event] ) then
					binds[key][event] = binds[key][event] or {}

					binds[key][event][#binds[key][event]+1] = {
						Action = "META",
						Value = command.Name
					}

					for _, action in pairs( command[event] ) do
						binds[key][event][#binds[key][event]+1] = table.Copy( action )
						binds[key][event][#binds[key][event]].Modifiers = commandEntry.Modifiers
					end
				end
			end
		end
	end

	-- Processes actual command actions and optimize
	for key, keyConfig in pairs( binds ) do
		local modifiers = {}
		local actions = {}
		for _, activity in pairs( Photon2.ClientInput.KeyActivities ) do
			if ( istable( keyConfig[activity] ) ) then
				for _, action in pairs( keyConfig[activity] ) do
					action.ModifierConfig = {}
					if ( istable( action.Modifiers ) ) then
						for _, modifierKey in pairs( action.Modifiers ) do
							modifiers[modifierKey] = true
							action.ModifierConfig[modifierKey] = true
						end
					end
					actions[#actions+1] = action
				end
			end
		end
		for i, action in pairs( actions ) do
			-- Process modifier keys
			for modifierKey, _ in pairs( modifiers ) do
				if ( action.ModifierConfig[modifierKey] == nil ) then
					action.ModifierConfig[modifierKey] = false
				end
			end
			-- Process value mapping
			if ( istable( action.Value ) ) then
				action.ValueMap = {}
				for j, value in pairs( action.Value ) do
					action.ValueMap[value] = j
				end
			end
		end
	end

	-- Build map that indexes by command
	local commandMap = {}
	for key, commands in pairs( config.Binds ) do
		for i, command in ipairs( commands ) do
			commandMap[command.Command] = commandMap[command.Command] or {}
			local displayKey = ""
			if ( command.Modifiers ) then
				for _i, modifier in ipairs( command.Modifiers ) do
					displayKey = displayKey .. Photon2.ClientInput.GetKeyPrintName( modifier ) .. " + "
				end
			end
			displayKey = displayKey .. Photon2.ClientInput.GetKeyPrintName( key )
			commandMap[command.Command][#commandMap[command.Command]+1] = {
				Key = key,
				Modifiers = command.Modifiers,
				Display = displayKey
			}
		end
	end

	return {
		Name = config.Name,
		Title = config.Title,
		Author = config.Author,
		Binds = binds,
		Map = commandMap
	}
end

