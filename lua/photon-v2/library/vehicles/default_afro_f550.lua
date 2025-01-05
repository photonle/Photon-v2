if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "2012 Chevrolet Impala"
VEHICLE.Vehicle		= "sm_chev_impalappv"

VEHICLE.Default	= true

VEHICLE.Equipment = {
	{
		Category = "Standard Lighting",
		Options = {
			{
				Option = "Default",
				VirtualComponents = {
					{
						Component = "photon_standard_2012impala",
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