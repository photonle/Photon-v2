if (exmeta.ReloadFile("photon-v2/meta/sh_vehicle.lua")) then return end

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
---@field Configuration {}
local Vehicle = META

Vehicle.EntityClass = "prop_vehicle_jeep"

-- Specifies the actual controller entity class to create when the vehicle is created.
-- Override if using your own modified controller entity.
Vehicle.ControllerType = "photon_controller"

---@param data PhotonLibraryVehicle
---@return PhotonVehicle
function Vehicle.New( data )
	---@type VehicleTable
	local target = list.GetForEdit( "Vehicles" )[data.Vehicle]
	if (not target) then
		error("Vehicle target [" .. tostring(data.Vehicle) .. "] does not appear to exist. Ensure the name is correct and you have the required addons.")
	end

	---@type PhotonVehicle
	local vehicle = {
		ID 			= data.ID,
		Title 		= data.Title,
		Model 		= target.Model,
		EntityClass = target.Class,
		Target 		= data.Vehicle,
		Equipment 	= {},
	}

	-- Handle equipment
	if (data.IsEquipmentConfigurable) then
	
	else
		for index, entry in pairs(data.Equipment) do
			vehicle.Equipment[index] = {
				ID 			= index,
				Component 	= entry.Component,
				Position 	= entry.Position,
				Angles 		= entry.Angles
			}
		end
	end


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