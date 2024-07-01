if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Longmont Police - Ford F150 Police Responder (2018)"
VEHICLE.Vehicle		= "smfordresponder"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = { "fedsig_pathfinder_unitrol" }

local livery = PhotonMaterial.New({
	Name = "schmal_f15018_lgmt_co_pd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sm_f15018/longmont_pd.png",
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
		Category = "Standard",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_smf15018",
					}
				},
				Props = {
					{
						-- Adds realistic window tinting and is skinnable
						Model = "models/schmal/smf15018_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1,
					}
				},
				SubMaterials = {
					{ Id = 23, Material = "photon/common/blank" },
					{ Id = 29, Material = livery.MaterialName }
				},
				BodyGroups = {
					{ BodyGroup = "Front Bumper", Value = 5 },
					{ BodyGroup = "Rear Bumper", Value = 2 },
				}
			}
		}
	},
	{
		Category = "Bumper",
		Options = {
			{
				Option = "Default",
				BodyGroups = {
					["Pushbar"] = 1
				},
				Components = {
					{
						Component = "photon_whe_dominator_6",
						Position = Vector( 0, 139, 40 ),
						Angles = Angle( 0, 0, 180 ),
						Scale = 1.2,
						Features = {
							ParkMode = true
						},
						Inputs = {
							["Emergency.Marker"] = {
								["ON"] = { ["All"] = "ALL" }
							},
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = "SCAN",
								["MODE3"] = "SCAN_W",
							},
							["Emergency.SceneForward"] = {
								["FLOOD"] = { ["Illum"] = "ILLUM" }
							},
							["Emergency.Cut"] = {
								["FRONT"] = { ["All"] = "OFF" }
							}
						}
					},
					{
						Name = "@pushbar_mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -20.5, 137.5, 47 ),
						Angles = Angle( 0, 180, 75 ),
						Scale = 1,
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = "2FH_2C",
								["MODE3"] = "2FH_2C_FAST",
							},
							["Emergency.Cut"] = { ["FRONT"] = "OFF" }
						}
					},
					{
						Inherit = "@pushbar_mpf4",
						States = { "B", "R", "W" },
						Position = Vector( 20.5, 137.5, 47 ),
						Angles = Angle( 0, 0, -75 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {}
							},
							["Emergency.Cut"] = { ["FRONT"] = "OFF" }
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
				Option = "Spectralux ILS",
				Components = {
					{
						Component = "photon_fedsig_ils",
						Position = Vector( 0, 44, 83.5 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1.1,
						Options = {
							Width = 7,
							Angle = 15
						}
					}
				}
			},
		}
	},
	{
		Category = "Rear",
		Options = {
			{
				Option = "CN SignalMaster",
				Components = {
					{
						Component = "photon_fedsig_cn_signalmaster",
						Position = Vector( 0, -39.7, 83),
						Angles = Angle( 0, -90, 180 ),
						Scale = 1.1,
						RenderGroup = RENDERGROUP_OPAQUE,
						BodyGroups = {
							["mount"] = "mount_tall"
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = "MIX_2FH_2C",
								["MODE2"] = "MIX_2FH_2C",
								["MODE3"] = "PURSUIT"
							},
							["Emergency.Directional"] = {
								-- Flipped because it's upside down
								["LEFT"] = { SignalMaster = "RIGHT" },
								["RIGHT"] = { SignalMaster = "LEFT" },
							}
						}
					}
				}
			},
		}
	},
	{
		Category = "Side",
		Options = {
			{
				Option = "Lights",
				Components = {
					-- The real thing uses T-Ions, but I don't have a model available for those so fucking sue me.
					{
						Name = "@side_lights",
						Component = "photon_sos_mpf4_x4",
						Position = Vector( -47, 11.3, 20 ),
						Angles = Angle( 0.8, 90 - 0.43, 0 ),
						Scale = 1,
						SubMaterials = {
							-- Uses the vehicle's black so it blends in a little better
							[3] = "models/supermighty/f150_responder/black" 
						},
						Options = {
							Spacing = 12
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = "MIX_2FH",
							},
							["Emergency.SceneLeft"] = { ["ON"] = { All = "ILLUM" } },
							["Emergency.SceneRight"] = { ["ON"] = {} },
							["Emergency.Cut"] = { ["FRONT"] = "OFF" }
						}
					},
					{
						Inherit = "@side_lights",
						Position = Vector( 47, 11.3, 20 ),
						Angles = Angle( -0.8, -90 + 0.43, 0 ),
						Phase = 180,
						Inputs = {
							["Emergency.SceneLeft"] = { ["ON"] = {} },
							["Emergency.SceneRight"] = { ["ON"] = { All = "ILLUM" } },
						}
					},
					{
						Component = "photon_sos_mpf4_bracket_x2",
						RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {}
							},
							["Emergency.Cut"] = { ["FRONT"] = "OFF" }
						},
						Bones = {
							[1] = { Vector( -5, 40.9, 64.7 ), Angle( -14, 90, 1 ), 1 },
							[2] = { Vector( -5, -40.9, 64.7 ), Angle( -14, -90, -1 ), 1 },
						}
					}
				}
			},
		}
	},
	{
		Category = "Lift Gate",
		Options = {
			{
				Option = "Lights",
				Components = {
					-- Whatever you do, do not closely inspect the positioning of these. (Again, fucking sue me.)
					{
						Component = "photon_sos_mpf4_x4",
						Position = Vector( 0, -130.5, 38.35 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1,
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = "MIX_2FH",
								["MODE3"] = "MIX_2FH_FAST"
							},
							["Emergency.Cut"] = {
								["REAR"] = "OFF"
							}
						},
						Options = {
							Spacing = 8
						}
					}
				}
			},
		}
	},
	{
		Category = "Bed",
		Options = {
			{
				Option = "Bed Cover",
				Props = {
					{
						Model = "models/schmal/f150xl_bedcover_generic.mdl",
						Position = Vector( 0, -86.5, 66.3 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1
					}
				}
			},
			{
				Option = "Open"
			}
		}
	},
	{
		Category = "Antennas",
		Options = {
			{
				Option = "Default",
				Props = {
					{
						Model = "models/schmal/antenna_pod_trimode.mdl",
						Position = Vector( 19.8, 29, 90 ),
						Angles = Angle( 4, 0, -7 ),
						Color = Color( 32, 32, 32 ),
						Scale = 1.2
					},
					{
						Model = "models/schmal/antenna_pod_navigator.mdl",
						Position = Vector( 19.8, -35, 91.5 ),
						Angles = Angle( -6.5, 90, 0 ),
						Color = Color( 32, 32, 32 ),
						Scale = 1
					},
					{
						Model = "models/schmal/antenna_pod_navigator.mdl",
						Position = Vector( -19.8, -35, 91.5 ),
						Angles = Angle( -6.5, 90, 0 ),
						Color = Color( 32, 32, 32 ),
						Scale = 1
					},
					{
						Model = "models/schmal/antenna_motorola.mdl",
						Position = Vector( -13.5, -15, 91.5 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1
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
						Position = Vector( -37, 57, 71 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1
					},
					{
						Component = "photon_whe_par46_right",
						Position = Vector( 37, 57, 71 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				},
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
						Position = Vector( 0, -131.2, 34 ),
						Angles = Angle( 0, 0, 90 ),
						Scale = 1.1,
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
						Position = Vector( 0, 135, 27.7 ),
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
		Category = "Siren",
		Options = {
			{
				Option = "Siren",
				Components = {
					{
						Component = "siren_prototype",
						Model = "models/schmal/fedsig_es100.mdl",
						Position = Vector( -13.5, 138.92, 33.7 ),
						Angles = Angle(1.5, 90, 0),
						Scale = 1.1,
						Siren = 1
					},
				}
			}
		}
	},
	{
		Category = "Interior Equipment",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_fedsig_scsb",
						Position = Vector( 0, 35.2, 51 ),
						Angles = Angle( 32.5, -90, 0 ),
						Scale = 1
					},
					{
						Component = "photon_sos_observe",
						Position = Vector( 0, 15, 90.2 ),
						Angles = Angle( 5, 90, 180 ),
						Scale = 1.1
					},
					{
						Component = "photon_pan_toughbookcf30",
						Position = Vector( 7.7, 35, 60 ),
						Angles = Angle( 0, 31, 0 ),
						Scale = 1,
						Options = {
							Pole = 2,
							Base = -60,
							-- You can change the screen material by using this option:
							Screen = "schmal/toughbook_cf30/laptop_screen_darkmode",
						}
					}
				},
			},
		},
	}
}