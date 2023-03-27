if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]

VEHICLE.Title 		= "Ford Police Interceptor (2020) Demonstrators"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {
	{
		ID			= "lightbar",
		Component	= "photon_fedsig_jetsolaris",
		Position	= Vector(0, 0, 95),
		Angles		= Angle(0, 0, 0)
	}
}