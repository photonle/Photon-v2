if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Las Vegas Metropolitan Police - Ford Police Interceptor (2016)"
VEHICLE.Vehicle		= "sm16fpiu"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonDynamicMaterial.Generate("schmal_fpiu16_lvmpd", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sm_fpiu16/lvmpd.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[15] = livery.Name,
	[5] = "photon/common/blank",
	[28] = "photon/common/blank",
}

VEHICLE.Selections = {
	{
		Category = "Vehicle Lighting",
		Options = {
			{
				Option = "Default",
				VirtualComponents = {
					{
						Component = "photon_standard_smfpiu16",
						Segments = {
							Reverse_Flasher = {
								Frames = {
									[1] = "[R] 11 [B] 12",
									[2] = "[R] 12 [B] 11",
								},
								Sequences = {
									FLASH = { 1, 0, 1, 0, 1, 1, 1, 1, 2, 0, 2, 0, 2, 2, 2, 2 }
								}
							}
						},
						InputActions = {
							["Emergency.Warning"] = {
								["MODE1"] = { Reverse_Flasher = "FLASH" },
								["MODE2"] = { Reverse_Flasher = "FLASH" },
								["MODE3"] = { Reverse_Flasher = "FLASH" },
							},
						}
					}
				}
			}
		}
	},
	{
		Category = "Windows",
		Options = {
			{
				Option = "LVMPD",
				Props = {
					{
						Model = "models/schmal/sm_fpiu16_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						SubMaterials = {
							[1] = "schmal/liveries/sm_fpiu16/lvmpd_modulate",
							[2] = "schmal/liveries/sm_fpiu16/lvmpd_glass",
							-- [1] = "photon/commmon/blank",
							-- [0] = "photon/commmon/blank",
							-- [2] = "photon/commmon/blank",
							-- [3] = "photon/commmon/blank",
							-- [4] = "photon/commmon/blank",
						}
					}
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Federal Signal Vision SLR",
				Components = {
					{
						Component = "photon_fedsig_visionslr",
						Position = Vector( 0, -15, 87 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.08,
						Bones = {
							["hook_mount_foot_lf"] = { Vector( -0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_rf"] = { Vector( 0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_lr"] = { Vector( -0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_rr"] = { Vector( 0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
						},
						SubMaterials = {
							["schmal/photon/fedsig_visionslr/lens_pod_1"] = "schmal/photon/fedsig_visionslr/lens_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_1_glass"] = "schmal/photon/fedsig_visionslr/glass_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_2"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_2_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_3"] = "schmal/photon/fedsig_visionslr/lens_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_3_glass"] = "schmal/photon/fedsig_visionslr/glass_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_4"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_4_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_5"] = "schmal/photon/fedsig_visionslr/lens_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_5_glass"] = "schmal/photon/fedsig_visionslr/glass_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_6"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_6_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_7"] = "schmal/photon/fedsig_visionslr/lens_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_7_glass"] = "schmal/photon/fedsig_visionslr/glass_color_red",
						}
					},
					{
						Component = "photon_fedsig_opticom795",
						Position = Vector( 19, -8.8, 85.2 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 0.15
					}
				}
			}
		}
	},
	{
		Category = "Spotlights",
		Options = {
			{
				Option = "Decorative (Body Group)",
				BodyGroups = {
					{ BodyGroup = "Spotlights", Value = 1 }
				}
			}
		}
	},
	{
		Category = "Push Bar",
		Options = {
			{
				Option = "Setina Push Bar",
				BodyGroups = {
					-- { BodyGroup = "Pushbar", Value = 1 }
				},
				Components = {
					{
						Component = "photon_setina_fpiu16",
						Position = Vector( 0, 120, 32.7 ),
						Angles = Angle( 0, 180, 0 ),
					}
				}
			}
		}
	},
	{
		Category = "Misc",
		Options = {
			{
				Option = "Default",
				BodyGroups = {
					{ BodyGroup = "Bobblehead", Value = 6 }
				}
			}
		}
	},
	{
		Category = "Rear Lights",
		Options = {
			{
				Option = "X-Streams",
				Components = {
					{
						Name = "@rear_xstream",
						Component = "photon_fedsig_xstream_single",
						Position = Vector( -12, -103.2, 75.5 ),
						Angles = Angle( 0, -90 - 10, 0 ),
						Scale = 1,
						BodyGroups = {
							["Mount"] = 2,
							["Shroud"] = 1
						},
						ColorMap = "[B] 1",
						Phase = "A",
						InputActions = {
							["Emergency.Warning"] = {
								["MODE1"] = { Light = "FLASH1" },
								["MODE2"] = { Light = "FLASH1" },
								["MODE3"] = { Light = "FLASH1" },
							},
						}
					},
					{
						Inherit = "@rear_xstream",
						Position = Vector( 12, -103.2, 75.5 ),
						Angles = Angle( 0, -90 + 10, 0 ),
						Phase = "B",
						ColorMap = "[R] 1"
					}
				}
			}
		}
	},
	{
		Category = "Siren",
		Options = {
			{
				Option = "Siren Prototype",
				Components = {
					{
						Component = "siren_prototype",
						Position = Vector(-11, 123, 34.4),
						Angles = Angle(1.5, -90, -180),
						Scale = 1.4,
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
						Position = Vector( 0, -120.8, 49 ),
						Angles = Angle( 0, 0, 71 ),
						Scale = 1.1,
						SubMaterials = {
							[1] = "photon/license/plates/ph2_lvmpd_nv",
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
						Name = "@front_plate",
						Angles = Angle( 0, 180, 90 ),
						Position = Vector( 0, 118.8, 27.1 ),
					},
				}
			}
		}
	},
	{
		Category = "Cellular Antenna",
		Options = {
			{
				Option = "Cellular",
				Props = {
					{
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( -21, 12, 82 ),
						Angles = Angle( -3, 0, -6 ),
						Scale = 1.6,
						SubMaterials = {
							[0] = "photon/common/white_gloss"
						}
					}
				}
			}
		}
	},
	{
		Category = "Lojack Antennas",
		Options = {
			{
				Option = "Lojack Antennas",
				Props = {
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( -4.9, -37, 85 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = Vector( 1, 1, 1.8)
					},
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( 4.9, -37, 85 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = Vector( 1, 1, 1.8)
					},
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( -4.9, -45, 85 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = Vector( 1, 1, 1.8)
					},
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( 4.9, -45, 85 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = Vector( 1, 1, 1.8)
					},
				}
			}
		}
	}
}