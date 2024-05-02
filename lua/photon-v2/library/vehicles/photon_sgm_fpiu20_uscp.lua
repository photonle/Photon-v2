if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "U.S. Capitol Police - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_uscp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/uscp.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.3, 0.3, 0.3 ),
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

local usGovPlate = PhotonMaterial.New({
	Name = "schmal_us_gov",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "photon/license/plates/usgov.png"
	}
})

VEHICLE.Siren = { "whelen_epsilon" }

VEHICLE.Livery = livery.MaterialName

VEHICLE.Equipment = {
	{
		Category = "Controller Sound",
		Options = {
			{
				Option = "Whelen",
				InteractionSounds = {
					{ Class = "Controller", Profile = "whelen_cencom" }
				}
			}
		}
	},
	{
		Category = "Rims",
		Options = {
			{
				Option = "Silver",
				BodyGroups = {
					{ BodyGroup = "hubcaps", Value = 0 }
				}
			}
		}
	},
	{
		Category = "Fog Lights",
		Options = {
			{
				Option = "Enabled",
				BodyGroups = {
					{ BodyGroup = "foglights", Value = 1 }
				}
			}
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
						Position = Vector( 0, -126.7, 49 ),
						Angles = Angle( 0, 0, 80 ),
						Scale = 1.2,
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
						Angles = Angle(0, 0, 0),
						SubMaterials = {
							[1] = "schmal/sgm_fpiu20/uscp_glass"
						}
					}
				},
			}
		}
	},
	{
		Category = "Grille",
		Options = {
			{
				Option = "mPower",
				Components = {
					{
						Name = "@GRILLE_MP4",
						Component = "photon_sos_mpf4",
						Position = Vector( -11, 114.8, 48.7 ),
						Angles = Angle( -10, 90+8, 0 ),
						Scale = 0.9,
						Flags = {
							FrontNoM1 = true
						},
						RenderGroup = RENDERGROUP_OPAQUE,
					},
					{
						Inherit = "@GRILLE_MP4",
						Position = Vector( 11, 114.8, 48.7 ),
						Angles = Angle( -10, 90-8, 0 ),
						States = { "B", "R" },
						Phase = 180,
					},
				}
			}
		}
	},
	{
		Category = "Mirror",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Name = "@MIRROR_ION",
						Component = "photon_whe_ion",
						Position = Vector( -53.1, 32.3, 62.5 ),
						Angles = Angle( 0, 32, 0 ),
						Scale = 0.8,
						SubMaterials = {
							[0] = "sentry/20fpiu_new/black"
						},
						Flags = {
							FrontNoM1 = true
						}
					},
					{
						Inherit = "@MIRROR_ION",
						Component = "photon_whe_ion",
						Position = Vector( 53.1, 32.3, 62.5 ),
						Angles = Angle( 0, -32, 0 ),
						States = { "B" },
						Phase = 180
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
				Components = {
					{
						Component = "photon_standard_sgmfpiu20",
						States = { "R", "B" },
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						},
						Inputs = {
							["Emergency.Marker"] = { ON = {} },
							["Emergency.Warning"] = {
								["MODE2"] = {
									ReverseFlasher = "RFTR_FLASH",
									Fog = "ROAD_RUNNER"
								},
								["MODE3"] = {
									ReverseFlasher = "RFTR_FLASH",
									Fog = "ROAD_RUNNER",
									HighBeamL = "WIGWAG",
									HighBeamR = "WIGWAG",
									HeadlightL = "WIGWAG",
									HeadlightR = "WIGWAG",
								}
							}
						}
					}
				},
				SubMaterials = {
					{ Id = 3, Material = "photon/common/blank" },
					-- { Id = 1, Material = "photon/common/blank" },
				}
			}
		}
	},
	{
		Category = "Hide-aways",
		Options = {
			{
				Option = "Option",
				Components = {
					{
						Name = "@HIDE_MP4",
						Component = "photon_sos_mpf4",
						Position = Vector( -41.4, 88.4, 51.9 ),
						Angles = Angle( -10, 165, 2 ),
						Scale = 0.9,
						RenderGroup = RENDERGROUP_OPAQUE,
						Flags = {
							FrontNoM1 = true
						}
					},
					{
						Name = "@HIDE_MP3",
						Component = "photon_sos_mpf3",
						Position = Vector( -39.6, 94.3, 51.7 ),
						Angles = Angle( -10, 157, 2 ),
						Scale = 0.9,
						Phase = 180,
						RenderGroup = RENDERGROUP_OPAQUE,
						Flags = {
							FrontNoM1 = true
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE3"] = { Light = "TRI_FLASH_SOLO" }
							}
						}
					},
					{
						Inherit = "@HIDE_MP4",
						Position = Vector( 41.4, 88.4, 51.9 ),
						States = { "B", "R" },
						Angles = Angle( -10, 180 - 165, -2 ),
						
					},
					{
						Inherit = "@HIDE_MP3",
						Position = Vector( 39.6, 94.3, 51.7 ),
						Angles = Angle( -10, 180 - 157, -2 ),
						States = { "B", "R" },
						Phase = 180,

					}
				}
			},
		}
	},
	{
		Category = "Spotlights",
		Options = {
			{
				Option = "Spotlights",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				},
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
						-- soundoff siren speaker?
						Component = "photon_sos_siren",
						Model = "models/sentry/props/whelensa315p_mounta.mdl",
						Position = Vector(-11, 113, 39.5),
						Angles = Angle(0, 0, 10),
						Scale = 1,
						-- Siren = "fedsig_smartsiren"
						Siren = 1
					},
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Legacy (48\")",
				Components = {
					{
						Component = "photon_whe_legacy_48",
						Position = Vector( 0, -15, 87.7 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1.02,
						Bones = {
							[11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							[10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
						-- Phase = "A:180",
						Inputs = {
							["Emergency.Warning"] = {
								["MODE3"] = {
									Full = "TRIP_MODIFIED",
									Takedown = "TRI_FLASH",
									Alley_Left = "ALT",
									Alley_Right = "ALT",
								},
								-- ["MODE2"] = { Test = "PHASE" },
								["MODE2"] = { Full = "QUAD" },
								["MODE1"] = {
									Full = "QUAD",
									Cut = "FRONT"
								}
							},
							["Virtual.WarningSiren"] = { ["T1"] = {}, ["T2"] = {}, ["T3"] = {}, ["T4"] = {} },
							["Virtual.ParkedWarning"] = { ["MODE3"] = {} },
							["Virtual.NightParkedWarning"] = { ["MODE3"] = {} },
						}
					}
				},
			},
		}
	},
	{
		Category = "Side Lighting",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Name = "@INTERIOR_ION",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( -33.8, -77, 75.4 ),
						Angles = Angle( 178, 90, 0 ),
						RenderGroup = RENDERGROUP_OPAQUE,
						Scale = 0.8,
						Phase = 90,
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { Light = "DOUBLE_FLASH_HOLD" },
								["MODE2"] = { Light = "DOUBLE_FLASH_HOLD" },
								["MODE3"] = { Light = "DOUBLE_FLASH_HOLD" },
							}
						}
					},
					{
						Inherit = "@INTERIOR_ION",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( 33.8, -77, 75.4 ),
						Angles = Angle( 182, -90, 0 ),
						States = { "B" },
						Phase = 270
					}
				}
			},
		}
	},
	{
		Category = "Front Visor",
		Options = {
			{
				Option = "Inner Edge",
				Components = {
					{
						Name = "@INNER_EDGE",
						Component = "photon_whe_inner_edge_left",
						Position = Vector( -21, 19.4, 77.3 ),
						Angles = Angle( 0, 93, 0 ),
						RenderGroup = RENDERGROUP_OPAQUE,
						Scale = 0.9,
						Inputs = {
							["Emergency.Warning"] = { 
								["MODE3"] = "QUAD_FLASH",
								["MODE1"] = {}
							},
							["Emergency.SceneForward"] = { 
								["ON"] = { Takedown = "CHEAP" },
								["FLOOD"] = { Flood = "CHEAP" } 
							}
						}
					},
					{
						Inherit = "@INNER_EDGE",
						Component = "photon_whe_inner_edge_right",
						Position = Vector( 21, 19.1, 77.3 ),
						Angles = Angle( 0, 87, 0 ),
						States = { "B" },
						Phase = 180,
						Inputs = {
							-- ["Emergency.Warning"] = { ["MODE3"] = "QUINT_FLASH" }
						}
					}
				}
			}
		}
	},
	{
		Category = "Rear Inner",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Inherit = "@INTERIOR_ION",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( -10, -107, 76.2 ),
						Angles = Angle( 180, 180, 0 ),
						Phase = 0
					},
					{
						Inherit = "@INTERIOR_ION",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( 10, -107, 76.2 ),
						Angles = Angle( 180, 180, 0 ),
						States = { "B" },
						Phase = 180
					}
				}
			},
		}
	},
	{
		Category = "Rear Spoiler",
		Options = {
			{
				Option = "96T Traffic/Warning",
				Components = {
					{
						Component = "photon_sos_ford96t",
						Position = Vector( 0, -110.4, 78.1 ),
						Angles = Angle( 0, -90, 0 ),
						-- Note there are actally two of these combined in one model
						Bones = {
							["ford_96t_left"] = { Vector( 0, -20.9, 0 ), Angle( 0, -13.635, 0 ) },
							["ford_96t_right"] = { Vector( 0, 20.9, 0 ), Angle( 0, 13.635, 0 ) },
						}
					},
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
						Model = "models/sentry/antenna.mdl",
						Position = Vector( 0, -35, 86 ),
						Angles = Angle( 0, 0, 3 ),
						Scale = 1.2
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna9.mdl",
						Position = Vector( -13, -50, 86.5 ),
						Angles = Angle( 0, 0, 3 ),
						Scale = 1.4
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna1.mdl",
						Position = Vector( 13, -50, 96.8 ),
						Angles = Angle( 0, 0, 3 ),
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna4.mdl",
						Position = Vector( 25, 9, 84.1 ),
						Angles = Angle( 8, 0, -12 ),
					},
					{
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( 0, 9, 83.9 ),
						Angles = Angle( 0, 0, -12 ),
						Scale = 0.8
					}
				}
			},
		}
	},
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
}