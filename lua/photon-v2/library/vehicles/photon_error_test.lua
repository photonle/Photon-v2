if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Vehicle Test"
VEHICLE.Vehicle		= "nonexistent_vehicle"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}
