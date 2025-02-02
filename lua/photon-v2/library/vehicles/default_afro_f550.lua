if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "2014 Ford F-550 Ambulance"
VEHICLE.Vehicle		= "f550_ambu_sgm"

VEHICLE.Default	= true

VEHICLE.Equipment = {
	{
		Category = "Standard Lighting",
		Options = {
			{
				Option = "Default",
				VirtualComponents = {
					{
						Component = "photon_standard_2014f550",
						Inputs = {
                            ["Emergency.Warning"] = {
                                ["MODE3"] = {
                                    
                                }
                            },
						}
					},
				},
			}
		}
	}
}