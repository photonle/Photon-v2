if (exmeta.ReloadFile()) then return end

local info, warn = Photon2.Debug.Declare( "Vehicle" )

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

NAME = "PhotonVehicle"

---@class PhotonVehicle
---@field Name string
---@field Title string
---@field Target string
---@field EntityClass string
---@field Model string
---@field New? fun(data: PhotonLibraryVehicle): PhotonVehicle Internal.
---@field Equipment {}
---@field EquipmentSelections? {}
---@field SubMaterials table<integer, string>
---@field Schema table<string, table<table>>
---@field EquipmentSignature string (Internal)
---@field SelectionsSignature string (Internal)
---@field InvalidVehicle? boolean (Internal) If vehicle base is invalid or missing.
---@field EngineIdleEnabled boolean If vehicle should idle when player quickly exits.
local Vehicle = exmeta.New() --[[@as PhotonVehicle]]

Vehicle.SubMaterials = {}
Vehicle.EntityClass = "prop_vehicle_jeep"
Vehicle.EngineIdleEnabled = true

Vehicle.Schema = {
	["Emergency.Warning"] = {
		{ Label = "PRIMARY" },
		{ Mode = "MODE1", Label = "STAGE 1" },
		{ Mode = "MODE2", Label = "STAGE 2" },
		{ Mode = "MODE3", Label = "STAGE 3" },
	},
	["Emergency.Directional"] = {
		{ Label = "ADVISOR" },
		{ Mode = "LEFT", Label = "LEFT" },
		{ Mode = "CENOUT", Label = "CTR/OUT" },
		{ Mode = "RIGHT", Label = "RIGHT" }
	},
	["Emergency.Marker"] = {
		{ Label = "CRZ" },
		{ Mode = "CRUISE", Label = "CRZ" }
	},
	["Emergency.Auxiliary"] = {
		{ Label = "AUX" },
		{ Mode = "MODE1", Label = "RED" },
		{ Mode = "MODE2", Label = "WHI" },
	},
	["Emergency.Siren"] = {
		{ Label = "SIREN" }
	},
	["Vehicle.Lights"] = {
		{ Label = "OFF" },
		{ Mode = "PARKING", Label = "PRK" },
		{ Mode = "HEADLIGHTS", Label = "HDL" },
		{ Mode = "OFF" }
	},
	["Emergency.Cut"] = {
		{ Label = "CUT" },
		{ Mode = "FRONT", Label = "FRO" },
		{ Mode = "REAR", Label = "REA" },
	}
}

local equipmentTypeMap = {
	["Components"] = "Component",
	["Props"] = "Prop"
}

-- This is to prevent 3rd party test vehicles from using the same category name as official demo vehicles.
-- It's an issue because some people are uploading their test vehicles in the Photon 2 category without realizing.

-- TODO: This should be abstracted and implemented for all library types to prevent similar issues.
local categoryWhitelist = {
	-- ["Photon 2"] = {
	-- 	Rename = "Photon 2: Addons",
	-- 	Allow = {
	-- 		["photon_sgm_chevcap13_wa_wsp"] = true,
	-- 		["photon_sgm_chevcap13_ftc_co_cso"] = true,
	-- 		["photon_sgm_cvpi96_ftc_co_pd"] = true,
	-- 		["photon_sgm_durang21_co_csp"] = true,
	-- 		["photon_sgm_fpiu13_sea_pd"] = true,
	-- 		["photon_sgm_fpiu20_bou_co_pd"] = true,
	-- 		["photon_sgm_fpiu20_bou_co_so"] = true,
	-- 		["photon_sgm_fpiu20_mpdc"] = true,
	-- 		["photon_sgm_fpiu20_unmarked"] = true,
	-- 		["photon_sgm_fpiu20_uscp"] = true,
	-- 		["photon_sm_fpiu16_lvmpd"] = true,
	-- 	}
	-- }
}

function Vehicle.GetError()
	return {
		Model = "models/error.mdl",
		Class = "prop_physics",
		KeyValues = {
			-- ["vehiclescript"] = "scripts/vehicles/jeep_test.txt"
		}
	}
end

-- Creates a "signature" string based on how the vehicle's
-- equipment is configured. This is used to detect significant
-- changes in equipment configurations so a "hard reload" can be
-- triggered when editing vehicle files.
function Vehicle.BuildEquipmentSignature( tbl )
	local sig = ""
	for equipmentType, entries in pairs( tbl ) do
		if (equipmentTypeMap[equipmentType]) then
			sig = sig .. string.format("[%s]=>{", equipmentType)
			for index, entry in ipairs( entries ) do
				local baseClassName = ""
				if (istable(entry.BaseClass)) then
					baseClassName = entry.BaseClass.Name
				end
				sig = sig .. string.format( "<%s:%s{%s}(%s/%s)>", index, entry[equipmentTypeMap[equipmentType]], entry.Model or "", baseClassName, entry.Name )
			end
			sig = sig .. "}"
		end
	end
	return sig
end

-- Creates a "signature" string based on how the vehicle's
-- selections are configured. This is used to detect significant
-- changes in equipment configurations so a "hard reload" can be
-- triggered when editing vehicle files.
function Vehicle.BuildSelectionSignature( tbl )
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

-- Maps what equipment types should be merged into others
-- before being processed. Necessary for backwards compatibility
-- when different component types needed to be explicitly defined.
local preMergeEquipment = {
	["VirtualComponents"] = "Components",
	["UIComponents"] = "Components"
}

---@param data PhotonLibraryVehicle
---@return PhotonVehicle
-- Compiles a new vehicle profile entry using raw input data.
function Vehicle.New( data )
	local Equipment = PhotonVehicleEquipmentManager


	if ( istable(data.Equipment) and ( not data.EquipmentSelections ) ) then
		data.EquipmentSelections = data.Equipment
		data.Equipment = nil
	end

	local sirenConfig = nil

	-- Setup/build siren slots
	if ( istable( data.Siren ) and ( #data.Siren > 0 ) ) then
		sirenConfig = {}
		for i, siren in pairs( data.Siren ) do
			if ( istable( siren ) ) then
				local sirenId = string.format( "%s[%s]", data.Name, i )

				local tones = {}
				
				for toneId, tone in pairs( siren ) do
					tones[toneId] = Photon2.GetSirenTone( tone )
				end

				Photon2.RegisterSiren({
					Name = sirenId,
					Make = "(Custom)",
					Model = string.format( "%s [%s]", data.Title, i ),
					Author = data.Author,
					Tones = tones
				})

				sirenConfig[i] = sirenId
			else
				sirenConfig[i] = siren
			end
		end
	end

	local schema
	-- local defaultSchema = PhotonVehicle.Schema
	-- Setup schema
	if ( istable( data.Schema ) ) then
		schema = {}
		for channel, modes in pairs( data.Schema ) do
			schema[channel] = modes
		end
		for channel, modes in pairs( PhotonVehicle.Schema ) do
			schema[channel] = schema[channel] or modes
		end
	else
		schema = PhotonVehicle.Schema
	end

	local title = data.Title
	local invalidVehicle = false

	---@type VehicleTable
	local target = list.GetForEdit( "Vehicles" )[data.Vehicle]
	if ( not target ) then
		warn("Vehicle target [" .. tostring(data.Vehicle) .. "] does not appear to exist. Ensure the name is correct and you have the required addons.")
		target = Vehicle.GetError()
		invalidVehicle = true
		title = "[ERROR] " .. title
	end

	-- Handle vehicle itself
	---@type PhotonVehicle
	local vehicle = {
		Name				= data.Name,
		ID 					= data.Name,
		Title 				= data.Title,
		Model 				= string.lower(target.Model),
		EntityClass 		= target.Class,
		Target 				= data.Vehicle,
		Equipment 			= Equipment.GetTemplate(),
		SubMaterials 		= data.SubMaterials,
		Siren				= sirenConfig,
		InteractionSounds	= data.InteractionSounds,
		Schema 				= schema,
		InvalidVehicle 		= invalidVehicle
	}

	--[[
			Setup Livery
			(Simple property if vehicle uses just one livery.)
	--]]

	if ( isstring( data.Livery ) ) then
		data.SubMaterials = data.SubMaterials or {}
		data.SubMaterials["SKIN"] = data.Livery
	end

	--[[
			Setup SIMPLIFIED Equipment		
	--]]

	local defaultEquipmentTable
	for key, _ in pairs( vehicle.Equipment ) do
		if ( istable( data[key] ) ) then
			defaultEquipmentTable = defaultEquipmentTable or {
				Category = "Equipment",
				Visible = false,
				Options = {
					{
						Option = "Default",
					}
				}
			}
			-- SubMaterials need special handling to for backwards compatability
			if ( key == "SubMaterials" ) then
				local result = {}
				for k, v in pairs( data["SubMaterials"] ) do
					if ( isstring( v ) ) then
						result[#result+1] = { Id = k, Material = v }
					else
						result[#result+1] = v
					end
				end
				defaultEquipmentTable.Options[1]["SubMaterials"] = result
			else
				defaultEquipmentTable.Options[1][key] = data[key]
			end
		end
	end

	if ( defaultEquipmentTable ) then
		data.EquipmentSelections = data.EquipmentSelections or {}
		data.EquipmentSelections[#data.EquipmentSelections+1] = defaultEquipmentTable
	end

	--[[
			Setup Equipment
	--]]

	local nameTable = Equipment.GetTemplate()
	local pendingNamesQueue = Equipment.GetTemplate()
	local loadedParents = Equipment.GetTemplate()

	-- Handle each entry in equipment
	if (data.EquipmentSelections) then

		vehicle.EquipmentSelections = {}

		-- Loop through each category
		for categoryIndex, category in ipairs(data.EquipmentSelections) do
			local visible = true
			
			if ( category.Visible ~= nil ) then
				visible = category.Visible
			end
			
			vehicle.EquipmentSelections[categoryIndex] =
			{
				Category = category.Category,
				Index = categoryIndex,
				Visible = visible,
				Options = {},
				Map = {}
			}
			
			local currentCategory = vehicle.EquipmentSelections[categoryIndex]
			local map = currentCategory.Map
			-- Loop through each option
			for optionIndex, option in pairs(category.Options) do
				local optionIndex = #currentCategory.Options + 1
				currentCategory.Options[optionIndex] = 
				{
					Option = option.Option,
					-- Index = optionIndex,
				}
				local currentOption = currentCategory.Options[optionIndex]
				-- Loop through each variant (if defined)
				if istable(option.Variants) then
					currentOption.Variants = {}
					for variantIndex, variant in pairs( option.Variants ) do
						local selection = #map + 1
						currentOption.Variants[variantIndex] =
						{
							Selection = selection,
							Variant = variant.Variant,
						}

						Equipment.ApplyTemplate( currentOption.Variants[variantIndex] )
						
						local currentVariant = currentOption.Variants[variantIndex]
						
						-- Merge different component types into .Components
						Equipment.PreMergeEquipment( variant, preMergeEquipment )

						-- Automatically iterate through each type of Equipment and process
						for key, value in pairs( vehicle.Equipment ) do
							if ( variant[key] ) then
								Equipment.ProcessTable(
									key,
									variant[key], 
									currentVariant[key], 
									vehicle.Equipment[key], 
									nameTable[key], 
									pendingNamesQueue[key] )

							end
						end

						map[selection] = currentVariant
					end
				else
					-- If no variants are defined, load equipment options
					currentOption.Option = option.Option
					Equipment.ApplyTemplate( currentOption )
					currentOption.Selection = #map + 1

					-- Merge different component types into .Components
					Equipment.PreMergeEquipment( option, preMergeEquipment )

					-- Automatically iterate through each type of Equipment and process
					for key, value in pairs( vehicle.Equipment ) do
						if ( option[key] ) then
							Equipment.ProcessTable(
								key, 
								option[key], 
								currentOption[key], 
								vehicle.Equipment[key], 
								nameTable[key], 
								pendingNamesQueue[key] 
							)
						end
					end

					map[currentOption.Selection] = currentOption
				end
			end
		end
		
		Equipment.ResolveNamesFromQueue( pendingNamesQueue.Components, nameTable.Components )

	end

	for key, value in pairs( vehicle.Equipment ) do
		Equipment.ProcessInheritance(
			vehicle.Equipment[key],
			nameTable[key],
			loadedParents[key]
		)
	end

	Equipment.BuildComponents( vehicle.Equipment, "Components", data.Name )

	local vehicleListId = "photon2:".. data.Name --[[@as string]]

	-- Populate entry in Map table
	local profiles = Photon2.Index.Profiles
	local map = profiles.Map
	map[vehicle.EntityClass] 								= map[vehicle.EntityClass] or {}
	map[vehicle.EntityClass][vehicle.Model] 				= map[vehicle.EntityClass][vehicle.Model] or {}
	map[vehicle.EntityClass][vehicle.Model][vehicleListId] 	= data.Name
	if ( data.Default ) then map[vehicle.EntityClass][vehicle.Model]["*"] = data.Name end


	-- Populate entry in Vehicles table
	profiles.Vehicles[vehicleListId] = data.Name

	if ( not data.Default ) then	
	-- Generate table for Vehicles list table
		local vehicleTable				 = Vehicle.CopyVehicle( data.Vehicle )
		vehicleTable.Category			 = data.Category or target.Category
		vehicleTable.Name				 = title
		vehicleTable.IconOverride		 = "entities/" .. data.Name .. ".png"
		vehicleTable.IsPhoton2Generated  = true

		-- Category whitelist check
		if ( categoryWhitelist[vehicleTable.Category] ) then
			if ( not categoryWhitelist[vehicleTable.Category].Allow[data.Name] ) then
				warn( "Vehicle [" .. data.Name .. "] is using a protected category name [" .. vehicleTable.Category .. "]. It has been moved to [" ..  categoryWhitelist[vehicleTable.Category].Rename .. "] to prevent conflicts." )
				vehicleTable.Category = categoryWhitelist[vehicleTable.Category].Rename
			end
		end

		list.Set( "Vehicles", vehicleListId, vehicleTable )
	end
	setmetatable( vehicle, { __index = PhotonVehicle } )

	-- SGM Model Attachment compatibility
	if ( SGM and SGM.AttachModelsByClass and SGM.AttachModelsByClass[data.Vehicle] ) then
		SGM.AttachModelsByClass[vehicleListId] = SGM.AttachModelsByClass[data.Vehicle]
	end

	-- Generate Signatures (used for soft/hard reload functionality)
	if ( vehicle.Equipment ) then
		vehicle.EquipmentSignature = PhotonVehicle.BuildEquipmentSignature( vehicle.Equipment )
	else
		vehicle.EquipmentSignature = ""
	end

	if ( vehicle.EquipmentSelections ) then
		vehicle.SelectionsSignature = PhotonVehicle.BuildSelectionSignature( vehicle.EquipmentSelections )
	else
		vehicle.SelectionsSignature = ""
	end

	return vehicle
end


local ignoredLegacyParams = {
	IsEMV 		= true,
	EMV 		= true,
	HasPhoton 	= true,
	Photon 		= true
}


---@param name string Vehicle index.
---@return VehicleTable
function Vehicle.CopyVehicle( name )
	local entry = list.GetForEdit( "Vehicles" )[name] or Vehicle.GetError()
	---@type VehicleTable
	local copy = {}
	for k, v in pairs(entry) do
		if (not ignoredLegacyParams[k]) then
			copy[k] = v
		end
	end
	return copy
end