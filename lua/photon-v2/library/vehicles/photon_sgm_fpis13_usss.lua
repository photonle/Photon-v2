if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "U.S. Secret Service Police - Ford Police Interceptor Sedan (2013)"
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
									RearSignalFlasher = "TRI_FLASH_HOLD",
								},
								["MODE3"] = {
									TailFlasher = "ALT",
									RearSignalFlasher = "TRI_FLASH_HOLD",
									ForwardSignalFlasher = "ALT"
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
						Component = "siren_prototype",
						Position = Vector(0, 112, 24.5),
						Angles = Angle( 0, -90, 0 ),
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
	{
		Category = "Side",
		Options = {
			{
				Option = "Code 3 XT",
				Components = {
					{
						Name = "@side_xt",
						Component = "photon_code3_xt4",
						Position = Vector( -45.8, 56, 34.72 ),
						Angles = Angle( -10, 182, 2.5 ),
						Scale = 1,
						Inputs = { ["Emergency.Cut"] = { ["FRONT"] = { Light = "OFF" } } },
						States = { "B", "R" }
					},
					{
						Inherit = "@side_xt",
						Position = Vector( 45.8, 56, 34.72 ),
						Angles = Angle( -10, -2, -2.5 ),
					}
				}
			},
		}
	},
	{
		Category = "Upper Deck",
		Options = {
			{
				Option = "Whelen Spitfires",
				Components = {
					{
						Name = "@forward_spitfire",
						Component = "photon_whe_ion_spitfire",
						Position = Vector( 10, 24.5, 63 ),
						Angles = Angle( 0, 0, 0 ),
						RenderGroup = RENDERGROUP_OPAQUE,
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { Light = "VARIABLE_SINGLE" },
								["MODE2"] = { Light = "VARIABLE_SINGLE" },
								["MODE3"] = { Light = "VARIABLE_SINGLE" },
							},
							["Emergency.Cut"] = { ["FRONT"] = { Light = "OFF" } }
						},
						Scale = 1,
						States = { "B" },
						Options = {
							Angle = -51,
							Mount = 1
						}
					},
					{
						Inherit = "@forward_spitfire",
						Position = Vector( 24, 24.5, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Phase = 180,
						States = { "R" }
					}
				}
			},
		}
	},
	{
		Category = "Rear",
		Options = {
			{
				Option = "Whelen Spitfires",
				Components = {
					{
						Name = "@rear_spitfire",
						Component = "photon_whe_ion_spitfire",
						Position = Vector( -14.5, -60.5, 62.5 ),
						Angles = Angle( 0, 180 - 10, 0 ),
						RenderGroup = RENDERGROUP_OPAQUE,
						Inputs = {
							["Emergency.Warning"] = {},
							["Emergency.Cut"] = { ["REAR"] = { Light = "OFF" } }
						},
						Scale = 1,
						Options = {
							Angle = -50,
							Mount = 1
						}
					},
					{
						Inherit = "@rear_spitfire",
						Position = Vector( 14.5, -60.5, 62.5 ),
						Angles = Angle( 0, 180 + 10, 0 ),
						Phase = 180,
						States = { "B" }
					}
				}
			},
		}
	},
	{
		Category = "Grille",
		Options = {
			{
				Option = "XT6",
				Components = {
					{
						Name = "@grille_xt6",
						Component = "photon_code3_xt6",
						Position = Vector( -10, 118.85, 28.9 ),
						Angles = Angle( -10, 90 + 7, 0 ),
						Scale = 1,
						Inputs = { ["Emergency.Cut"] = { ["FRONT"] = { Light = "OFF" } } }
					},
					{
						Inherit = "@grille_xt6",
						Position = Vector( 10, 118.85, 28.9 ),
						Angles = Angle( -10, 90 - 7, 0 ),
					}
				}
			},
		}
	},
	{
		Category = "Dome Light",
		Options = {
			{
				Option = "SoundOff Signal obSERVE",
				Components = {
					{
						Component = "photon_sos_observe",
						Position = Vector( 0, 3, 68),
						Angles = Angle( 2, 90, 180 ),
						Scale = 1.1
					}
				}
			}
		}
	},
}