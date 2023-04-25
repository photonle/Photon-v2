
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Ford Police Interceptor (2020) Demonstrator"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}

-- Category -> Option (-> Variant)
VEHICLE.Selections = {
	{
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmfpiu20"
					}
				}
			}
		}
	},
	-- {
	-- 	Category = "Forward Lightbar",
	-- 	Options = {
	-- 		{ Option = "JetSolaris", Variants = {
	-- 				{ Variant = "Front",
	-- 					Components = {
	-- 						{
	-- 							Name 		= "@jetsolaris_front",
	-- 							Component	= "photon_fedsig_jetsolaris",
	-- 							Position	= Vector(0, -15, 91),
	-- 							Angles		= Angle(0, 0, 0),
	-- 							Scale		= 1
	-- 						},
	-- 					}
						
	-- 				},
	-- 				{ Variant = "Alternate",
	-- 					Components = {
	-- 						{
	-- 							Inherit 	= "@jetsolaris_front",
	-- 							Scale		= 0.5,
	-- 							Position	= Vector(0, -15, 100 )
	-- 						}
	-- 					}
	-- 				},
	-- 			}
	-- 		}
	-- 	},
	-- }
	-- },
	-- {
	-- 	Category = "Rear Lightbar",
	-- 	Options = {
	-- 		{
	-- 			Option = "None",
	-- 			Components = {}
	-- 		},
	-- 		{
	-- 			Option = "JetSolaris",
	-- 			Components = {
	-- 				{
	-- 					Inherit 	= "@jetsolaris_front",
	-- 					Position	= Vector(0, -65, 91),
	-- 				}
	-- 			}
	-- 		},
			
			
			
	-- 	}
	-- },
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false