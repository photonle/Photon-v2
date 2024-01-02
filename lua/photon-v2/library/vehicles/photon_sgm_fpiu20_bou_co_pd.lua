
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Boulder Police Department - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = {
	-- This an example of using mixed siren tones (also a real-world recreation)
	[1] = {
		T1 = "fedsig_touchmaster_delta/wail",
		T2 = "fedsig_touchmaster_delta/yelp",
		T3 = "fedsig_smartsiren/priority",
		T4 = "fedsig_smartsiren/hilo",
		AIR = "fedsig_smartsiren/airhorn",
		MAN = "fedsig_touchmaster_delta/manual",
	},
	-- [1] = "fedsig_touchmaster_delta",
	-- [2] = "fedsig_smartsiren"
}

local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_boulderpd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/bou_co_pd.png",
		["$bumpmap"] = "photon/common/flat",
		["$phong"] = 1,
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector(0.020, 0.020, 0.023),
		["$phongboost"] = 1.25,
		["$phongexponent"] = 23,
		["$nodecal"] = 1
	}
})

local sequence = Photon2.SequenceBuilder.New

-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	{
		Category = "Liveries",
		Options = {
			{
				Option = "Boulder PD",
				SubMaterials = {
					{ Id = 20, Material = livery.MaterialName },
				}
			},
			{
				Option = "None",
				SubMaterials = {
					{ Id = 20, Material = nil }
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
		Category = "Hide-Aways",
		Options = {
			{
				Option = "SOS Undercover",
				Components = {
					{
						Name = "@forward_hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( -41.4, 90, 51.5 ),
						Angles = Angle( 0, 74, -76 ),
						Scale = 0.4,
						States = { "B", "R" },
						Inputs = {
							["Emergency.SceneForward"] = {
								["FLOOD"] = { Light = "SCENE" }
							},
							["Emergency.Warning"] = {
								["!MODE1"] = {}
							}
						}
					},
					{
						Inherit = "@forward_hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( 41.4, 90, 51.5 ),
						Angles = Angle( 0, -74, -76 ),
						Scale = 0.4,
						States = { "R", "W" }
					}
				}
			}
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Pushbar",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 1 }
				},
				Components = {
					{
						Name = "@pushbar_mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -15, 128, 34 ),
						Angles = Angle( 0, 90, 0),
						Inputs = {
							["Emergency.SceneForward"] = {
								["ON"] = { Light = "W" },
								["FLOOD"] = { Light = "W" }
							},
							["Emergency.Warning"] = {
								["!MODE1"] = {}
							}
						},
						Phase = "A",
					},
					{
						Inherit = "@pushbar_mpf4",
						Position = Vector( 15, 128, 34 ),
						States = { "B", "R", "W" },
						Phase = "B"
					},
					{
						Name = "@pushbar_mp4_side",
						Component = "photon_sos_mpf4",
						Position = Vector( -20.5, 124.5, 36 ),
						Angles = Angle( 0, 180, 0),
						Phase = "A",
						Inputs = {
							["Emergency.SceneForward"] = {
								["FLOOD"] = { Light = "W" }
							},
							-- Disables MODE1
							["Emergency.Warning"] = {
								["!MODE1"] = {}
							}
						},
					},
					{
						Inherit = "@pushbar_mp4_side",
						Position = Vector( 20.5, 124.5, 36 ),
						Angles = Angle( 0, 0, 0 ),
						States = { "B", "R", "W" },
						Phase = "B"
					}
				}
			},
			{
				Option = "None",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 0 }
				}
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
						},
						BodyGroups = {
							forward_hotfeet = 1,
							alley_hotfeet = 1
						},
						States = {
							[1] = "R", [2] = "B", [3] = "W"
						},
						Segments = {},
						Inputs = {
							["Emergency.Marker"] = {
								["ON"] = { SteadyBurn = "FULL" }
							},
							-- !MODE1 is the same as MODE1, but indicates that
							-- the table should NOT be inherited.
							--
							-- This is a Photon-specific feature built into its
							-- core inheritance logic.
							["Emergency.Warning"] = {
								["!MODE1"] = {
									RE_Rear = "MODE1"
								}
							}
						}
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
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( 0, -50, 85.4 ),
						Angles = Angle( 0, 0, 2 ),
						Scale = 1.3
					},
					{
						Model = "models/schmal/antennas/antenna_6.mdl",
						Position = Vector( 0, -77, 95.5 ),
						Angles = Angle( 0, 0, 6 ),
						Scale = 2.2
					},
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
	},
	{
		Category = "Dome Light",
		Options = {
			{
				Option = "SoundOff Signal obSERVE",
				Components = {
					{
						Component = "photon_sos_observe",
						Position = Vector( 0, -5, 84.8 ),
						Angles = Angle( 4, 90, 180 ),
						Scale = 1
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
						Position = Vector(-11, 125, 35),
						Angles = Angle(1.5, -90, 0),
						Scale = 1.4,
						-- Siren = "fedsig_smartsiren"
						Siren = 1
					},
					-- {
					-- 	Component = "photon_siren_secondary",
					-- 	Position = Vector(11, 125, 35),
					-- 	Angles = Angle(1.5, -90, 0),
					-- 	Scale = 1.4,
					-- 	-- Siren = "fedsig_smartsiren"
					-- 	Siren = 2
					-- },
				}
			}
		}
	},
	{
		Category = "Rear",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						-- Unique name
						Name = "@rear_mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -10, -128.7, 56.4 ),
						Angles = Angle( 0, -96, 0),
						Phase = "A",
						Segments = {
							-- Creates a new segment
							Override = {
								Frames = {
									[1] = "1"
								},
								Sequences = {
									["MODE1:A"] = sequence():FlashHold( 1, 2, 5 ):Add( 0 ):Do( 10 ),
									["MODE1:B"] = sequence():Add( 0 ):Do( 10 ):FlashHold( 1, 2, 5 ),
								}
							}
						},
						Inputs = {
							-- Lights will turn RED when braking
							["Vehicle.Brake"] = {
								["BRAKE"] = { Light = "R" }
							},
							-- Lights will turn WHITE when reversing
							["Vehicle.Transmission"] = {
								["REVERSE"] = { Light ="W" }
							},
							["Emergency.Warning"] = {
								["!MODE1"] = {
									-- Light = 
									Override = "MODE1"
								}
							}
						},
						-- Raises the Vehicle.Transmission input priority so
						-- the reverse mode will override the braking mode
						InputPriorities = {
							["Vehicle.Transmission"] = 200
						}
					},
					{
						-- Inherits from the entry above
						Inherit = "@rear_mpf4",
						Position = Vector( 10, -128.7, 56.4 ),
						Angles = Angle( 0, -84, 0),
						-- Assigns B to slot #1, and R to slot #2 because
						-- by default they are opposite.
						States = { [1] = "B", [2] = "R" },
						Phase = "B",
					},
				}
			}
		},
	},
	{
		Category = "Side",
		Options = {
			{
				Option = "XStream Duo",
				Components = {
					{
						Name = "@xstream_side",
						Component = "photon_fedsig_xstream_duo",
						Position = Vector( -37.6, -95, 63.4 ),
						Angles = Angle( 0, 180+7, 180),
						BodyGroups = {
							["Mount"] = 1,
							["Shroud"] = 1
						},
						Phase = "A",
						Inputs = {
							["Emergency.Warning"] = {
								-- Disables MODE1
								["!MODE1"] = {}
							}
						}
					},
					{
						Inherit = "@xstream_side",
						Position = Vector( 37.6, -95, 63.4 ),
						Angles = Angle( 0, -7, 180 ),
						Phase = "B"
					}
				}
			}
		},
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
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false