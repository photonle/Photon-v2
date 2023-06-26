
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Ford Police Interceptor (2020) Unmarked"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}

if CLIENT then
	-- mpdcSkin.Material:SetTexture("$basetexture", Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "VertexLitGeneric noclamp smooth" ):GetTexture( "$basetexture" ))
end

VEHICLE.SubMaterials = {
	-- [20] = mpdcSkin.Name,
	[3] = "photon/common/blank"
	-- [20] = Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "vertexlitgeneric"):GetName(),
}

-- Category -> Option (-> Variant)
VEHICLE.Selections = {
	{
		Category = "License Plate",
		Options = {
			{
				Option = "Visible",
				Props = {
					{
						Name = "@rear_plate",
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, -126.7, 49 ),
						Angles = Angle( 0, 0, 80 ),
						Scale = 1.2,
						SubMaterials = {
							-- [1] = "",
							[1] = "photon/license/plates/ph2_co_gvt"
							-- [1] = "photon/license/plates/mpdc_demo"
							-- [1] = "!ph2_mpdc_demo"
						},
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular"
						}
					},
					{
						Inherit = "@rear_plate",
						Angles = Angle( 0, 180, 90 ),
						Position = Vector( 0, 120.5, 26 ),
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular",
							["mount"] = "mount"
						}
					},
					{
						Model = "models/schmal/sgm_fpiu20_win.mdl",
						Position = Vector(),
						Angles = Angle(0, -90, 0)
					}
				},
				Components = {
					{
						Component = "photon_sos_mpf4_lic_h",
						Angles = Angle( 0, -90, 0 ),
						Position = Vector( 0, -125, 49 ),
						Scale = 0.96
					}
				}
			}
		}
	},
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
	{
		Category = "Grille",
		Options = {
			{
				Option = "Intersectors",
				Components = {
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( -11, 116.2, 48 ),
						Angles = Angle( 0, 7, 12 ),
						Scale = 1
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 11, 116.2, 48 ),
						Angles = Angle( 0, -7, 12 ),
						Scale = 1
					}
				}
			}
		}
	},
	{
		Category = "Mirror",
		Options = {
			{
				Option = "Intersectors (Surface)",
				Components = {
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( -45.5, 34.5, 57.3 ),
						Angles = Angle( 1, 90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 45.5, 34.5, 57.3 ),
						Angles = Angle( -1, -90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
					},
				}
			}
		}
	},
	-- {
	-- 	Category = "Build",
	-- 	Options = {
	-- 		{
	-- 			Option = "mpower Fascia 4\"",
	-- 			Components = {
	-- 				{
	-- 					Component = "photon_sos_mpf4",
	-- 					Position = Vector( 0, 0, 120 ),
	-- 					Angles = Angle( 0, 90, 0 ),
	-- 					Scale = 1
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- },
	-- {
	-- 	Category = "Forward Lightbar",
	-- 	Options = {
			
	-- 		{ Option = "SoundOff Signal nForce", 
	-- 			Variants = {
	-- 				{
	-- 					Variant = "MPDC",
	-- 					Components = {
	-- 						{
	-- 							Inherit = "@nforce54",
	-- 							Component = "schmal_mpdc_sos_nforce_54",
	-- 						},
	-- 					}
	-- 				},
	-- 				{
	-- 					Variant = "Default",
	-- 					Components = {
	-- 						{
	-- 							Name = "@nforce54",
	-- 							Component = "photon_sos_nforce_54",
	-- 							Position = Vector( 0, -15, 87.55 ),
	-- 							Angles = Angle( 0, 0, -1 ),
	-- 							Scale = 1.029
	-- 						}
	-- 					}
	-- 				},
					
	-- 			},
	-- 		},
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
	-- 		},
	-- 		{ Option = "None",
			
	-- 		},
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