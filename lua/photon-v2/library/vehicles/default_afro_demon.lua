if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "2017 Dodge Demon"
VEHICLE.Vehicle		= "demon_fh3_sgm"

VEHICLE.Default	= true

VEHICLE.Equipment = {
	{
		Category = "Standard Lighting",
		Options = {
			{
				Option = "Default",
				VirtualComponents = {
					{
						Component = "photon_standard_2017demon",
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