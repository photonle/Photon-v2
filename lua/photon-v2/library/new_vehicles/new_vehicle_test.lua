if (Photon2.ReloadNewVehicleFile()) then return end
local VEHICLE = Photon2.LibraryNewVehicle()

VEHICLE.Title 		= "New Vehicle Test"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = { "fedsig_smartsiren", "fedsig_touchmaster_delta" }

-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	{
		Category = "Lightbar",
		Options = {
			{ Option = "None" },
			{
				Option = "nForce 54\"",
				Components = {
					{
						Name = "@nforce54",
						Component = "photon_sos_nforce_54",
						Position = Vector( 0, -15, 87.55 ),
						Angles = Angle( 0, 0, -1 ),
						Scale = 1.029
					}
				}
			},
		}
	},
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false