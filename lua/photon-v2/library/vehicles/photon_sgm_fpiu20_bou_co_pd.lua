
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Boulder Police Department - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}


local bpd = PhotonDynamicMaterial.Generate("schmal_fpiu20_bpd", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sgm_fpiu20/bou_co_pd.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[20] = bpd.Name,
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
				},
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Federal Signal Valor",
				Components = {
					{
						Component = "photon_fedsig_valor_suv",
						Position = Vector(0, -15, 86.1),
						Angles = Angle(1.5, 90, 0),
						Scale = 1.14,
						PoseParameters = {
							extend_feet = 0.55
						},
						Bones = {
							["right_bone_rod"] = { Vector(-3, 0, -1), Angle(0, 0, 0), 1 },
							["left_bone_rod"] = { Vector(-3, 0, -1), Angle(0, 0, 0), 1 },
						},
						Options = {
							FeetHeight = 0.55,
							HookMount = { -3, -1 }
						}
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
		Category = "Spotlights (Decorative)",
		Options = {
			{
				Option = "Decorative",
				Props = {
					{
						Model = "models/sentry/props/spotlight_left_down.mdl",
						Position = Vector( -39.4, 37, 63 ),
						Angles = Angle( 20, 0, -10 ),
						Scale = 1.1
					},
					{
						Model = "models/sentry/props/spotlight_right_down.mdl",
						Position = Vector( 39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1
					}
				}
			}
		}
	}
	-- {
	-- 	Category = "Forward Lightbar",
	-- 	Options = {
	-- 		{ Option = "SoundOff Signal nForce", 
	-- 			Variants = {
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