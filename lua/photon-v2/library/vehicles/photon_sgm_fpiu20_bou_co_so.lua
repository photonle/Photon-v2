
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Boulder County Sheriff's Office - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}


local bcso = PhotonDynamicMaterial.Generate("schmal_fpiu20_bcso", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sgm_fpiu20/bou_co_cso.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.1, 0.1, 0.1),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[20] = bcso.Name,
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
							[1] = "",
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
	{
		Category = "Forward Lightbar",
		Options = {
			{ Option = "SoundOff Signal nForce", 
				Variants = {
				{
					Variant = "Default",
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
				{
					Variant = "MPDC",
					Components = {
						{
							Inherit = "@nforce54",
							Component = "schmal_mpdc_sos_nforce_54",
						},
					}
				}
				},
			},
		},
	}
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