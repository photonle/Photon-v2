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
---@field ControllerType string
---@field EquipmentMode EquipmentMode
---@field Target string
---@field EntityClass string
---@field Model string
---@field New fun(data: PhotonLibraryVehicle): PhotonVehicle
---@field Equipment {}
---@field Selections {}
local Vehicle = exmeta.New()

Vehicle.EntityClass = "prop_vehicle_jeep"

-- Specifies the actual controller entity class to create when the vehicle is created.
-- Override if using your own modified controller entity.
Vehicle.ControllerType = "photon_controller"

---@param data PhotonLibraryVehicle
---@return PhotonVehicle
function Vehicle.New( data )
	local Equipment = PhotonVehicleEquipmentManager

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
		Equipment 			= Equipment.GetTemplate()
	}


	local nameTable = Equipment.GetTemplate()
	local pendingNamesQueue = Equipment.GetTemplate()
	local loadedParents = Equipment.GetTemplate()

	-- Handle each entry in equipment
	if (data.Selections) then

		vehicle.Selections = {}

		-- Loop through each category
		for categoryIndex, category in pairs(data.Selections) do
			vehicle.Selections[categoryIndex] = 
			{
				Category = category.Category,
				Index = categoryIndex, 
				Options = {},
				Map = {}
			}
			local currentCategory = vehicle.Selections[categoryIndex]
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
						Equipment.ProcessTable( variant.Components, currentVariant.Components, vehicle.Equipment.Components, nameTable.Components, pendingNamesQueue.Components )
						
						map[selection] = currentVariant
					end
				else 
					-- If no variants are defined, load equipment options
					currentOption.Option = option.Option
					Equipment.ApplyTemplate( currentOption )
					currentOption.Selection = #map + 1

					Equipment.ProcessTable( option.Components, currentOption.Components, vehicle.Equipment.Components, nameTable.Components, pendingNamesQueue.Components )

					map[currentOption.Selection] = currentOption
				end
			end
		end
		
		Equipment.ResolveNamesFromQueue( pendingNamesQueue.Components, nameTable.Components )

	end

	Equipment.ProcessInheritance( vehicle.Equipment.Components, nameTable.Components, loadedParents.Components )

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
	
end