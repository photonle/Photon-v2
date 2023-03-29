
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()
---


VEHICLE.Title 		= "Ford Police Interceptor (2020) Demonstrator"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {
	{
		Component	= "photon_fedsig_jetsolaris",
		Position	= Vector(0, -15, 91),
		Angles		= Angle(0, 0, 0),
		Scale		= 1
	},
	{
		Component	= "photon_fedsig_jetsolaris",
		Position	= Vector(0, -65, 91),
		Angles		= Angle(0, 0, 0),
		Scale		= 1
	}
}