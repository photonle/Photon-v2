if (exmeta.ReloadFile()) then return end

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

NAME = "PhotonVehicle"
---@alias EquipmentMode
---| "Configurable" # Has multiple equipment options.
---| "Static" # Uses all defined equipment and does not support any options.

---@class PhotonVehicle
---@field ID string
---@field Title string
---@field ControllerType? string Not implemented.
---@field EquipmentMode? EquipmentMode Not implemented.
---@field Target string
---@field EntityClass string
---@field Model string
---@field New? fun(data: PhotonLibraryVehicle): PhotonVehicle Internal.
---@field Equipment {}
---@field SubMaterials table<integer, string>
---@field Schema table<string, table<table>>
local Vehicle = exmeta.New() --[[@as PhotonVehicle]]

Vehicle.SubMaterials = {}

Vehicle.EntityClass = "prop_vehicle_jeep"

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
	}
}

-- Specifies the actual controller entity class to create when the vehicle is created.
-- Override if using your own modified controller entity.
Vehicle.ControllerType = "photon_controller"

---@param data PhotonLibraryVehicle
---@return PhotonVehicle
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
				local sirenId = string.format( "%s[%s]", data.ID, i )

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

	---@type VehicleTable
	local target = list.GetForEdit( "Vehicles" )[data.Vehicle]
	if ( not target ) then
		error("Vehicle target [" .. tostring(data.Vehicle) .. "] does not appear to exist. Ensure the name is correct and you have the required addons.")
	end

	-- Handle vehicle itself
	---@type PhotonVehicle
	local vehicle = {
		ID 					= data.ID,
		Title 				= data.Title,
		Model 				= target.Model,
		EntityClass 		= target.Class,
		Target 				= data.Vehicle,
		Equipment 			= Equipment.GetTemplate(),
		SubMaterials 		= data.SubMaterials,
		Siren				= sirenConfig,
		InteractionSounds	= data.InteractionSounds,
		Schema 				= schema,
	}


	local nameTable = Equipment.GetTemplate()
	local pendingNamesQueue = Equipment.GetTemplate()
	local loadedParents = Equipment.GetTemplate()

	-- Handle each entry in equipment
	if (data.EquipmentSelections) then

		vehicle.EquipmentSelections = {}

		-- Loop through each category
		for categoryIndex, category in pairs(data.EquipmentSelections) do
			vehicle.EquipmentSelections[categoryIndex] = 
			{
				Category = category.Category,
				Index = categoryIndex, 
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
						
						-- Automatically iterate through each type of Equipment and process
						for key, value in pairs( vehicle.Equipment ) do
							if ( variant[key] ) then
								Equipment.ProcessTable( 
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

					-- Automatically iterate through each type of Equipment and process
					for key, value in pairs( vehicle.Equipment ) do
						if ( option[key] ) then
							Equipment.ProcessTable( 
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
		Equipment.ResolveNamesFromQueue( pendingNamesQueue.VirtualComponents, nameTable.VirtualComponents )
		Equipment.ResolveNamesFromQueue( pendingNamesQueue.UIComponents, nameTable.UIComponents )

	end

	for key, value in pairs( vehicle.Equipment ) do
		Equipment.ProcessInheritance(
			vehicle.Equipment[key],
			nameTable[key],
			loadedParents[key]
		)
	end

	Equipment.BuildComponents( vehicle.Equipment, "Components", data.ID )
	Equipment.BuildComponents( vehicle.Equipment, "VirtualComponents", data.ID )
	Equipment.BuildComponents( vehicle.Equipment, "UIComponents", data.ID )

	local vehicleListId = "photon2:".. data.ID --[[@as string]]

	-- Populate entry in Map table
	local profiles = Photon2.Index.Profiles
	local map = profiles.Map
	map[vehicle.EntityClass] 								= map[vehicle.EntityClass] or {}
	map[vehicle.EntityClass][vehicle.Model] 				= map[vehicle.EntityClass][vehicle.Model] or {}
	map[vehicle.EntityClass][vehicle.Model][vehicleListId] 	= data.ID

	-- Populate entry in Vehicles table
	profiles.Vehicles[vehicleListId] = data.ID

	-- Generate table for Vehicles list table
	local vehicleTable				 = Vehicle.CopyVehicle( data.Vehicle )
	vehicleTable.Category			 = data.Category or target.Category
	vehicleTable.Name				 = data.Title
	vehicleTable.IconOverride		 = "entities/" .. data.ID .. ".png"
	vehicleTable.IsPhoton2Generated  = true
	list.Set( "Vehicles", vehicleListId, vehicleTable )

	return setmetatable( vehicle, { __index = PhotonVehicle } )
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
	local entry = list.GetForEdit( "Vehicles" )[name]
	---@type VehicleTable
	local copy = {}
	for k, v in pairs(entry) do
		if (not ignoredLegacyParams[k]) then
			copy[k] = v
		end
	end
	return copy
end


-- Development function for change detection
function Vehicle.BuildEquipmentSignature()
	--- ?????
end