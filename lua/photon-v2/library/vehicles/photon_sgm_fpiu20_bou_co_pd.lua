
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]

if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Boulder Police Department - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = {
	-- This an example of using mixed siren tones (also a real-world recreation)
	-- [1] = {
	-- 	T1 = "fedsig_touchmaster_delta/wail",
	-- 	T2 = "fedsig_touchmaster_delta/yelp",
	-- 	T3 = "fedsig_smartsiren/priority",
	-- 	T4 = "fedsig_smartsiren/hilo",
	-- 	AIR = "fedsig_smartsiren/airhorn",
	-- 	MAN = "fedsig_touchmaster_delta/manual",
	-- },
	-- [1] = "fedsig_touchmaster_delta",
	[1] = "fedsig_pathfinder_ssp"
}

local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_boulderpd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/bou_co_pd.png",
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

local sequence = Photon2.SequenceBuilder.New

-- Category -> Option (-> Variant)
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
						Phase = "A",
						States = { "R", "B" },
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						Inputs = {
							["Emergency.SceneForward"] = {
								["FLOOD"] = { Light = "SCENE" }
							},
							["Emergency.SirenOverride"] = {
								["AIR"] = { Light = "SCENE" }
							},
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Override = "MODE2" },
								["MODE3"] = { Override = "MODE3" },
							}
						},
						Segments = {
							Override = {
								Frames = {
									[1] = "1 2 3",
									[2] = "[W] 1 2 3",
								},
								Sequences = {
									["MODE2:A"] = sequence():FlashHold( 1, 1, 5 ):Add( 0 ):Do( 8 ),
									["MODE2:B"] = sequence():Add( 0 ):Do( 8 ):FlashHold( 1, 1, 5 ),
									["MODE3:A"] = sequence():FlashHold( 1, 2, 3 ):FlashHold( 2, 2, 3 ),
									["MODE3:B"] = sequence():FlashHold( 2, 2, 3 ):FlashHold( 1, 2, 3 )
								}
							}
						}
					},
					{
						Inherit = "@forward_hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( 41.4, 90, 51.5 ),
						Angles = Angle( 0, -74, -76 ),
						Scale = 0.4,
						States = { "B", "R" },
						Phase = "B"
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
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						Segments = {
							-- Creates a new segment
							Override = {
								Frames = {
									[1] = "1",
									[2] = "[W] 1"
								},
								Sequences = {
									["MODE2:A"] = sequence():FlashHold( 1, 1, 5 ):Add( 0 ):Do( 8 ),
									["MODE2:B"] = sequence():Add( 0 ):Do( 8 ):FlashHold( 1, 1, 5 ),
									["MODE3:A"] = sequence():FlashHold( 1, 2, 3 ):FlashHold( 2, 2, 3 ),
									["MODE3:B"] = sequence():FlashHold( 2, 2, 3 ):FlashHold( 1, 2, 3 )
								}
							}
						},
						Inputs = {
							["Emergency.SceneForward"] = {
								["ON"] = { Light = "W" },
								["FLOOD"] = { Light = "W" }
							},
							["Emergency.SirenOverride"] = {
								["AIR"] = { Light = "W" }
							},
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Override = "MODE2" },
								["MODE3"] = { Override = "MODE3" },
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
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						Segments = {
							-- Creates a new segment
							Override = {
								Frames = {
									[1] = "1",
									[2] = "[W] 1"
								},
								Sequences = {
									["MODE2:B"] = sequence():FlashHold( 1, 1, 5 ):Add( 0 ):Do( 8 ),
									["MODE2:A"] = sequence():Add( 0 ):Do( 8 ):FlashHold( 1, 1, 5 ),
									["MODE3:B"] = sequence():FlashHold( 1, 2, 3 ):FlashHold( 2, 2, 3 ),
									["MODE3:A"] = sequence():FlashHold( 2, 2, 3 ):FlashHold( 1, 2, 3 ),
								}
							}
						},
						Inputs = {
							["Emergency.SceneForward"] = {
								["FLOOD"] = { Light = "W" }
							},
							["Emergency.SirenOverride"] = {
								["AIR"] = { Light = "W" }
							},
							["Emergency.Warning"] = {
								-- Disables MODE1
								["MODE1"] = {},
								["MODE2"] = { Override = "MODE2" },
								["MODE3"] = { Override = "MODE3" },
							},
							["Emergency.SceneLeft"] = { ["ON"] = { Light = "W" } },
						},
					},
					{
						Inherit = "@pushbar_mp4_side",
						Position = Vector( 20.5, 124.5, 36 ),
						Angles = Angle( 0, 0, 0 ),
						States = { "B", "R", "W" },
						Phase = "B",
						Inputs = {
							-- Clears SceneLeft from doing anything on this component.
							["Emergency.SceneLeft"] = { ["ON"] = {} },
							-- Configure SceneRight, which the parent component does not use.
							["Emergency.SceneRight"] = { ["ON"] = { Light = "W" } },
						}
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
					-- {
					-- 	Name = "@parent1",
					-- 	Component = "photon_sos_undercover",
					-- 	Parent = "@valor",
					-- 	Position = Vector( 0, 0, 20 ),
					-- 	Angles = Angle( 0, 0, 0 ),

					-- },
					-- {
					-- 	Name = "@parent2",
					-- 	Component = "photon_sos_undercover",
					-- 	Parent = "@parent1",
					-- 	Position = Vector( 0, 0, 20 ),
					-- 	Angles = Angle( 0, 0, 0 ),
					-- },
					{
						Name = "@valor",
						Component = "photon_fedsig_valor_51",
						Position = Vector(0, -11, 87.5),
						Angles = Angle(2, 90, 0),
						Scale = 1.04,
						-- PoseParameters = {
						-- 	extend_feet = 0.55
						-- },
						Bones = {
							["valor_51_feet_left"] = { Vector(-0.34, 0, 1.1), Angle(0, 0, 0), 1 },
							["valor_51_feet_right"] = { Vector(0.34, 0, 1.1), Angle(0, 0, 0), 1 },
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
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						Segments = {},
						-- InputPriorities = {
						-- 	["Virtual.ParkedWarning"] = 41
						-- },
						-- VirtualOutputs = {
						-- 	["Virtual.ParkedWarning"] = {
						-- 		{
						-- 			Mode = "MODE3",
						-- 			Conditions = {
						-- 				["Emergency.Warning"] = { "MODE3" },
						-- 				["Vehicle.Transmission"] = { "PARK" }
						-- 			}
						-- 		}
						-- 	}
						-- },
						Inputs = {
							["Emergency.Marker"] = {
								["ON"] = { SteadyBurn = "FULL" }
							},
							-- ["Virtual.ParkedWarning"] = {
							-- 	["MODE3"] = {
							-- 		RE_Rear = "MODE2",
							-- 		RE_Front = "MODE2",
							-- 	}
							-- },
							["Emergency.Warning"] = {
								["MODE1"] = {
									-- ["All"] = "DEV"
									RE_Rear = "MODE1",
									-- PoseTest = "ON"
									-- RE_Traffic = "LEFT"
								},
								["MODE2"] = {
									RE_Rear = "MODE2",
									RE_Front = "MODE2",
								},
								["MODE3"] = {
									-- The R/B pattern needs to override white lighting
									-- so the white only occupies otherwise "off" lights (defined using the "PASS" state).
									Pursuit = { "PURSUIT", Order = 10 },
									PursuitWO = "PURSUIT"
									-- { "Pursuit" }
									-- RE_Rear = "MODE2",
									-- RE_Front = "MODE2",
								}
							},
							["Emergency.Directional"] = {
								["LEFT"] = { RE_Traffic = "LEFT" },
								["RIGHT"] = { RE_Traffic = "RIGHT" },
								["CENOUT"] = { RE_Traffic = "CENOUT" },
							},
							["Emergency.SirenOverride"] = {
								["AIR"] = { Alert = "ALERT" }
							},
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
		Category = "Spotlights",
		Options = {
			{
				Option = "Spotlights",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1
					},
					{
						Component = "photon_whe_par46_right",
						Position = Vector( 39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1
					}
				},
			},
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
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						Segments = {
							-- Creates a new segment
							Override = {
								Frames = {
									-- Element 1 assigned to state 1 (its primary color)
									[1] = "[1] 1",
									[2] = "[2] 1"
								},
								Sequences = {
									["MODE1:A"] = sequence():Add( 1 ):Do( 10 ):Add( 0 ):Do( 10 ),
									["MODE1:B"] = sequence():Add( 0 ):Do( 10 ):Add( 1 ):Do( 10 ),
									["MODE2:A"] = sequence():FlashHold( 1, 1, 5 ):Add( 0 ):Do( 8 ):FlashHold( 2, 1, 5 ):Add( 0 ):Do( 8 ),
									["MODE2:B"] = sequence():Add( 0 ):Do( 8 ):FlashHold( 1, 1, 5 ):Add( 0 ):Do( 8 ):FlashHold( 2, 1, 5 ),
									["MODE3"] = sequence():FlashHold( 1, 2, 3 ):FlashHold( 2, 2, 3 ),
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
								["MODE1"] = { Override = "MODE1" },
								["MODE2"] = { Override = "MODE2" },
								["MODE3"] = { Override = "MODE3" },
							}
						},
						-- Raises the Vehicle.Transmission input priority so
						-- the reverse mode will override the braking mode
						InputPriorities = {
							["Vehicle.Transmission"] = 200
						}
					},
					{
						-- Inherits from the entry above so you don't have to copy
						-- all of the code again
						Inherit = "@rear_mpf4",
						Position = Vector( 10, -128.7, 56.4 ),
						Angles = Angle( 0, -84, 0),
						-- Assigns BLUE to slot #1, and RED to slot #2
						States = { [1] = "B", [2] = "R" },
						-- Use alternate phase from component above
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
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						BodyGroups = {
							["Mount"] = 1,
							["Shroud"] = 1
						},
						Phase = "A",
						Segments = {
							Override = {
								Frames = {
									[1] = "1",
									[2] = "2"
								},
								Sequences = {
									["MODE2"] = sequence():FlashHold( 1, 1, 5 ):FlashHold( 2, 1, 5 ),
									["MODE3"] = sequence():FlashHold( 1, 2, 3 ):FlashHold( 2, 2, 3 )
								}
							}
						},
						Inputs = {
							["Emergency.Warning"] = {
								-- Disable inheritance from parent component by prepending !
								["MODE1"] = {},
								["MODE2"] = { Override = "MODE2" },
								["MODE3"] = { Override = "MODE3" }
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
				Components = {
					{
						Component = "photon_standard_sgmfpiu20",
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
							NightParkMode = { "Emergency.Marker", "ON" }
						},
						-- Add custom segments to to flash the vehicle lights
						Segments = {
							-- Create new segment for reverse flashers
							ReverseFlasher = {
								-- RevL and RevR and element groups defined in photon_standard_sgmfpiu20
								Frames = {
									[1] = "[2] RevL",
									[2] = "[2] RevR",
									[3] = "[2] RevL [W] RevR",
									[4] = "[W] RevL [2] RevR",
								},
								Sequences = {
									-- Slow left-right pattern (10 frames per side)
									["MODE1"] = sequence():Add( 1 ):Do( 10 ):Add( 2 ):Do( 10 ),
									["MODE2"] = sequence():FlashHold( 2, 1, 5 ):FlashHold( 1, 1, 5 ),
									["MODE3"] = sequence():FlashHold( 3, 2, 3 ):FlashHold( 4, 2, 3 )
								}
							}
						},
						Inputs = {
							-- This channel and mode is setup by the ParkMode flag
							["Emergency.ParkedWarning"] = {
								["MODE3"] = {
									HighBeamL = "PASS",
									HighBeamR = "PASS",
									HeadlightL = "PASS",
									HeadlightR = "PASS",
								}
							},
							["Emergency.Warning"] = {
								["MODE1"] = {
									-- Assign reverse left-right flash to MODE1
									ReverseFlasher = "MODE1"
								},
								["MODE2"] = { 
									ReverseFlasher = "MODE2",
								},
								["MODE3"] = { 
									HighBeamL = "WIGWAG",
									HighBeamR = "WIGWAG",
									HeadlightL = "WIGWAG",
									HeadlightR = "WIGWAG",
									ReverseFlasher = "MODE3" 
								},
							}
						}
					}
				}
			}
		}
	},
}
