if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Colorado State Patrol - Dodge Durango (2021)"
VEHICLE.Vehicle		= "21durango_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}

-- local livery = PhotonDynamicMaterial.Generate("schmal_sgm_durang21_csp", { "VertexLitGeneric",
-- 	["$basetexture"] = Material( "schmal/liveries/sgm_durang21/co_csp.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
-- 	["$bumpmap"] = "photon/common/flat",
-- 	["$phong"] = 1,
-- 	["$envmap"] = "env_cubemap",
-- 	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
-- 	["$phongboost"] = 1.25,
-- 	["$phongexponent"] = 23,
-- 	["$nodecal"] = 1
-- })

VEHICLE.SubMaterials = {
	[17] = "photon/common/blank", -- skin
	[20] = "photon/common/blank", -- black_chrome
	-- [17] = livery.Name,
}

VEHICLE.Equipment = {
	{
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmdodur21"
					}
				}
			}
		}
	},
	{
		Category = "Body",
		Options = {
			{
				Option = "Black Trim",
				Props = {
					{
						Model = "models/schmal/dodur21_hull.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[0] = "schmal/liveries/sgm_durang21/co_csp",
						}
					},
					{
						Model = "models/schmal/dodur21_wheels.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						Bones = {
							["wheel_fl"] = { 
								Position = Vector( -2.7, 0, 0 ),
								Angles = Angle( 0, 0, 0 ),
								Scale = 1,
								Follow = { Attachment = "wheel_fl" }
							},
							["wheel_fr"] = { 
								Position = Vector( -2.7, 0, 0 ),
								Angles = Angle( 0, 0, 0 ),
								Scale = 1,
								Follow = { Attachment = "wheel_fr" }
							},
							["wheel_rl"] = { 
								Position = Vector( -2.7, 0, 0 ),
								Angles = Angle( 0, 0, 0 ),
								Scale = 1,
								Follow = { Attachment = "wheel_rl" }
							},
							["wheel_rr"] = { 
								Position = Vector( -2.7, 0, 0 ),
								Angles = Angle( 0, 0, 0 ),
								Scale = 1,
								Follow = { Attachment = "wheel_rr" }
							},
						},
						AutoWheels = { Offset = Vector( -2.7, 0, 0 ) }
						-- SubMaterials = {
						-- 	[0] = "schmal/liveries/sgm_durang21/co_csp",
						-- }
					}
				}
			}
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Setina",
				Props = {
					{
						Model = "models/schmal/setina_pushbar_durango.mdl",
						Position = Vector( 0, 118, 32 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1,
						SubMaterials = {}
					}
				}
			}
		}
	},
	{
		Category = "License Plates",
		Options = {
			{
				Option = "License Plates",
				Props = {
					{
						Name = "@rear_plate",
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, -129, 49.5 ),
						Angles = Angle( 0, 0, 66 ),
						Scale = 1.2,
						SubMaterials = {
							-- [1] = "",
							[1] = "photon/license/plates/ph2_co_sp"
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
						Position = Vector( 0, 117, 27 ),
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular",
							["mount"] = "mount"
						}
					},
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options ={
			{
				Option = "Liberty II",
				Components = {
					{
						Component = "photon_sm_liberty_ii_suv",
						Position = Vector( 0, -14, 86.7 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.1
					}
				}
			}
		}
	},
	{
		Category = "Spotlight",
		Options = {
			{
				Option = "Whelen PAR46",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -37, 34, 64 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				}
			}
		}
	},
	{
		Category = "Antennas",
		Options = {
			{
				Option = "Antennas",
				Props = {
					{
						Model = "models/schmal/antennas/antenna_6.mdl",
						Position = Vector( 0, -30, 95),
						Angles = Angle( 0, 0, 1 ),
						Scale = Vector(1,1,2)
					},
					{
						Model = "models/sentry/antenna5.mdl",
						Position = Vector( 0, -79, 84.8 ),
						Angles = Angle( 0, 0, 2 ),
						Scale = .9
					}
				}
			}
		}
	},
}