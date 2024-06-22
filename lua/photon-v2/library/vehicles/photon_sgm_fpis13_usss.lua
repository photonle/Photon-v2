if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "U.S. Secret Service Police - 2013 Ford Police Interceptor Sedan"
VEHICLE.Vehicle		= "13fpis_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = { "code3_z3" }

local livery = PhotonMaterial.New({
	Name = "schmal_fpis13_usss",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpis13/usss_police.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.3, 0.3, 0.35 ),
		["$envmapfresnel"] = 1,

		["$phong"] = 1,
		["$phongboost"] = 15,
		["$phongexponent"] = 3,
		["$phongfresnelranges"] = Vector( 0.22, 0.2, 2 ),

		["$rimlight"] = 1,
		["$rimlightexponent"] = 2,
		["$rimlightboost"] = 1,
		["$rimmask"] = 1,

		["$phongexponenttexture"] = "photon/common/flat_exp",
		["$basemapluminancephongmask"] = 1,
		["$phongalbedotint"] = 1,

		["$nodecal"] = 1
	}
})


VEHICLE.Equipment = {
	{
		Category = "HUD",
		Options = {
			{
				Option = "HUD",
				Components = {
					{
						Component = "photon_hud_default"
					}
				}
			}
		}		
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Code 3 RX2700",
				Components = {
					{
						Component = "photon_c3_rx2700_47",
						Position = Vector( 0, -8, 74.4 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.17,
						Options = {
							Feet = -1,
							Mount = "classic",
							Domes = "black",
							-- To configure domes individually:
							-- Domes = { "red", "clear", "blue" }
						},
						StateMap = "[R] 4 14 13 [B] 3 11 12 15 16"
						-- SubMaterials = {
						-- 	-- [6] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[7] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[8] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[9] = "schmal/photon/code3_rx2700/black_plastic",
						-- }
					}
				}
			},
		}
	},
	{
		Category = "Default",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_fpis13",
						States = {},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {
									TailFlasher = "ALT",
									RearSignalFlasher = "ALT",
								},
								["MODE3"] = {
									TailFlasher = "ALT",
									RearSignalFlasher = "ALT",
								}
							},
						}
					}
				},
				Props = {
					{
						Model = "models/schmal/sgm_fpis13_glass.mdl",
						Position = Vector( 0, 0, -5 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1
					}
				},
				Bones = {
					-- { Bone = "pushbar_wrap", Position = Vector( 0, 0, 0 ), Angles = Angle( 0, 0, 0 ), Scale = 0.8 }
				},
				BodyGroups = {
					{ BodyGroup = "lightbar", Value = 1 },
					{ BodyGroup = "grillelights", Value = 1 },
					{ BodyGroup = "spotlight_l", Value = 1 },
					{ BodyGroup = "spotlight_r", Value = 1 },
					{ BodyGroup = "rearwindowlights", Value = 1 },
					{ BodyGroup = "pushbar", Value = 0 },
					{ BodyGroup = "badge", Value = 1 },
					
				},
				SubMaterials = {
					{ Id = 4, Material = "photon/common/blank" },
					{ Id = 1, Material = "schmal/sgm_fpis13/chrome" },
					{ Id = 8, Material = "schmal/sgm_fpis13/forward_signal" },
					{ Id = 9, Material = "schmal/sgm_fpis13/forward_signal" },
					{ Id = 27, Material = livery.MaterialName }
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
						Model = "models/sentry/props/whelensa315p_mounta.mdl",
						Component = "siren_prototype",
						Position = Vector(-10, 96, 31),
						Angles = Angle(1.5, 0, 0),
						Scale = 1,
						Siren = 1
					},
				}
			}
		}
	},
	{
		Category = "Interaction Sound",
		Options = {
			{
				Option = "Code 3 Z3",
				InteractionSounds = {
					{ Class = "Controller", Profile = "code3_z3s" }
				}
			},
		}
	},
	{
		Category = "License Plate",
		Options = {
			{
				Option = "Visible",
				Props = {
					{
						Name = "@rear_plate",
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, -122.2, 19 ),
						Angles = Angle( 0, 0, 90 ),
						Scale = 1.25,
						SubMaterials = {
							-- [1] = "",
							[1] = "photon/license/plates/ph2_us_gov"
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
						Angles = Angle( 0, 180, 89 ),
						Position = Vector( 0, 125, 18 ),
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
		Category = "Spotlight",
		Options = {
			{
				Option = "PAR46",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -37, 44, 51 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
						Templates = {
							["Bone"] = {
								Shaft = {
									States = {
										["DOWN"] = { Target = 300 },
									}
								},
							}
						}
					},
				}
			},
		}
	},
		{
		Category = "Antenna",
		Options = {
			{
				Option = "Option",
				Props = {
					-- models/sentry/antenna.mdl

					{
						Model = "models/sentry/antenna.mdl",
						Position = Vector( -35, -100, 51.3 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna3.mdl",
						Position = Vector( 0, -51, 68.3 ),
						Angles = Angle( 0, 0, 14 ),
						Scale = 1
					},
				}
			},
		}
	},
}