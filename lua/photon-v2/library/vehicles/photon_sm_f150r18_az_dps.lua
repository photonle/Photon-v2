if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Arizona State Trooper - Ford F150 Police Responder (2018)"
VEHICLE.Vehicle		= "smfordresponder"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Noble"

VEHICLE.WorkshopRequirements = { 
	[2875774360] = "2018 Ford F150 XL SuperCrew",
	[739684120] = "Super's Cars Shared Textures"
}

VEHICLE.Description = [[
The Arizona Department of Public Safety (AZDPS) or Arizona Highway Patrol (AHP) is a state-level law enforcement agency with a primary function of patrolling and enforcing state laws on Arizona highways.
]]

VEHICLE.Siren = { "fedsig_smartsiren" }

local livery = PhotonMaterial.New({
	Name = "noble_f15018_az_dps",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "noble/liveries/sm_f15018/arizona_dps.png",
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

		["$nodecal"] = 1,
	}
})

-- New window material that isn't DecalModulate to help solve z-fighting issues
local liveryGlass = PhotonMaterial.New({
	Name = "arizonadps_glass",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "noble/liveries/sm_f15018/arizonadps_glass.png",
		["$translucent"] = "1",
		["$model"] = "1",
		["$nocull"] = "0"
	}
})

local liverySticker = PhotonMaterial.New({
	Name = "arizonadps_sticker",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "noble/liveries/sm_f15018/arizonadps_sticker.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.1, 0.1, 0.15 ),
		["$envmapfresnel"] = 1,

		["$phong"] = 1,
		["$phongboost"] = 1,
		["$phongexponent"] = 1,
		["$phongfresnelranges"] = Vector( 0.22, 0.2, 2 ),
		["$phongfix"] = Vector( 1, 1, 1 ),

		["$rimlight"] = 1,
		["$rimlightboost"] = 1.2,
		["$rimmask"] = 1,

		["$phongexponenttexture"] = "photon/common/flat_exp",
		["$basemapluminancephongmask"] = 1,
		["$phongalbedotint"] = 1,

		["$alphatest"] = 1,
		// Adding $translucent seems to help some with z-fighting
		["$translucent"] = 1,
	}
})

local sequence = Photon2.SequenceBuilder.New

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
						Features = {
							ParkMode = true
						},
						Segments = {
							WIGWAG = {
								Frames = {
									[4] = "4 [~SW*0.4] 3",
									[5] = "3 [~SW*0.4] 4"
								},
								Sequences = {
									["WIGWAG"] = sequence():Alternate( 4, 5):SetTiming(0.1875),
									["OFF"] = { 0 }
								}
							},
							BrakeFlasher = {
								Frames = {
									[0] = "[PASS] 9 10",
									[1] = "[~R] 9 10"
								},
								Sequences = {
									["FLASH"] = sequence():Alternate(0, 1):SetTiming(0.1875)
								}
							},
							ReverseFlasher = {
								Frames = {
									[7] = "[B] 11 12",
								},
								Sequences = {
									-- 160 flashes per minute
									["BLINK"] = sequence():Alternate(7, 0):SetTiming(0.1875)
									--["BLINK"] = sequence():Blink(7):Stretch(4)
								}
							}
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { ReverseFlasher = "BLINK" },
								["MODE2"] = { 
									ReverseFlasher = "BLINK",
									BrakeFlasher = "FLASH"
								},
								["MODE3"] = { 
									ReverseFlasher = "BLINK",
									BrakeFlasher = "FLASH",
									WIGWAG = "WIGWAG", 
								},
							},
							["Emergency.ParkedWarning"] = {
								["MODE3"] = { WIGWAG = "OFF"},
							},
							["Emergency.Marker"] = {
								["ON"] = { ReverseFlasher = "CUT" }
							},
						}
					}
				},
				Props = {
					{
						-- Adds realistic window tinting and is skinnable
						Name = "@smf15018_glass",
						Model = "models/schmal/smf15018_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1,
						-- Change window material from DecalModulate to help solve z-fighting issues
						SubMaterials = {
							[0] = liveryGlass.MaterialName
						}
					},
					{
						-- Opaque rear window sticker
						Inherit = "@smf15018_glass",
						Position = Vector( 0, -0.05, 0 ),
						SubMaterials = {
							[0] = "photon/common/blank",
							[1] = liverySticker.MaterialName
						}
					}
				},
				SubMaterials = {
					{ Id = 23, Material = "photon/common/blank" },
					{ Id = 29, Material = livery.MaterialName }
				},
				BodyGroups = {
					{ BodyGroup = "Front Bumper", Value = 2 },
					{ BodyGroup = "Rear Bumper", Value = 0 },
					{ BodyGroup = "Towbar", Value = 1 },
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
						Name = "@mpf4_lights",
						Component = "photon_sos_mpf4",
						Position = Vector( -20.5, 137, 45 ),
						Angles = Angle( 0, 180, 90 ),
						Scale = 1,
						Segments = {
							Light = {
								Frames = {
									[6] = "[R*0.6] 1",
									[7] = "[B*0.6] 1",
								},
								Sequences = {
									["ALT_R_140"] = sequence():Alternate(6, 1):SetTiming(0.429),
									["ALT_B_140"] = sequence():Alternate(7, 2):SetTiming(0.429),
									["ALT_2C_140"] = sequence():Alternate(1, 2):SetTiming(0.429),
									["FLASH_2C"] = sequence():Flash(1, 2):SetTiming(0.261 / 1),
									-- This timing is more accurate to the real light but looks odd within Photon
									--["QUINT_2C"] = sequence():QuintFlash(1, 2):SetTiming(0.429 / 10),
									["QUINT_2C"] = sequence():QuintFlash(1, 2),
									["QUINT_RW"] = sequence():QuintFlash(1, 3),
									["QUINT_BW"] = sequence():QuintFlash(2, 3),
								}
							}
						},
						VirtualOutputs = {
							["Emergency.ParkedWarningAlt"] = {
								{
									Mode = "DIM",
									Conditions = {
										["Vehicle.Ambient"] = { "DARK" },
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" }
									}
								},
								{
									Mode = "MODE1",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" }
									}
								}
							},
						},
						InputPriorities = {
							["Emergency.ParkedWarningAlt"] = 46
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Light = "FLASH_2C:90" },
								["MODE3"] = { Light = "QUINT_RW:180" }
							},
							["Emergency.Cut"] = { ["FRONT"] = "OFF" },
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_R_140:180" },
								["MODE1"] = { Light = "ALT_2C_140" }
							},
							["Emergency.Marker"] = {
								["ON"] = { }
							}
						}
					},
					{
						Inherit = "@mpf4_lights",
						--States = { "B", "R", "W" },
						Position = Vector( 20.5, 137, 45 ),
						Angles = Angle( 0, 0, -90 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = { Light = "FLASH_2C" },
								["MODE3"] = { Light = "QUINT_BW" },
							},
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_B_140" },
								["MODE1"] = { Light = "ALT_2C_140:90" }
							},
						}
					},
					{
						Inherit = "@mpf4_lights",
						Position = Vector( -12, 135.4, 54.7 ),
						Angles = Angle( 0, 90, 0 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE3"] = { Light = "QUINT_RW:180" },
							},
							["Emergency.SceneForward"] = {
								["ON"] = { Light = "W" },
								["FLOOD"] = { Light = "W" },
							},
						}
					},
					{
						Inherit = "@mpf4_lights",
						Position = Vector( 12, 135.4, 54.7 ),
						Angles = Angle( 0, 90, 0 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = { Light = "FLASH_2C" },
								["MODE3"] = { Light = "QUINT_BW" },
							},
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_B_140" },
								["MODE1"] = { Light = "ALT_2C_140:90" }
							},
							["Emergency.SceneForward"] = {
								["ON"] = { Light = "W" },
								["FLOOD"] = { Light = "W" },
							},
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
				Option = "SoundOff Signal nForce",
				Components = {
					{
						Name = "@nforce_54",
						Component = "photon_sos_nforce_54",
						Position = Vector( 0, 6.2, 93.7 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = .96,
						Segments = {
							All = {
								Frames = {
									[8]  = "[R*0.6] 2 4 6 8 10 12 14 16 18 20 22 24 1 26 [B*0.6] 3 5 7 9 11 13 15 17 19 21 23 25 26",
								},
								Sequences = {
									["ALT_SLOW"] = sequence():Alternate(5, 4):SetTiming(0.429),
									["ALT_NEW"] = sequence():Alternate(5, 4):SetTiming(0.261),
									["DIM_CONST"] = { 8 }
								}
							},
							Front = {
								Frames = {
									-- [13 11 9] 7 5 3 1 2 4 6 [8 10 12]
									[1] = "[W] 1",
									[2] = "[W] 3 1 2",
									[3] = "[W] 5 3 2 4",
									[4] = "[W] 7 5 4 6",
									[5] = "[W] 7 6",
									
									[6] = "1",
									[7] = "3 1 2",
									[8] = "5 3 2 4",
									[9] = "7 5 4 6",
									[10] = "7 6",

									[11] = "7 5 3 1 2 4 6",
								},
								Sequences = {
									-- PURSUIT timing calculated from 60 flashes per minute, divided by 22 frames, then divided by 60 frames per second
									["PURSUIT"] = sequence():Sequential(1, 5):Add(0):Sequential(5, 1):Sequential(6, 10):Add(0):Sequential(10, 6):SetTiming(.045),
									["FLICKER_CRZ"] = sequence():QuadFlash(11):Steady(11, 140):SetTiming(.025)
								}
							},
							Rear = {
								Frames = {
									-- [14 16 18] 20 22 24 26 25 23 21 [19 17 15]
									[1] = "[R] 20 22 24 26",
									[2] = "[B] 26 25 23 21",
									[3] = "[R] 20 22 24 26 [B*0.6] 25 23 21",
									[4] = "[R*0.6] 20 22 24 [B] 26 25 23 21",
								},
								Sequences = {
									["ALT_FAST"] = sequence():Alternate(1, 2):SetTiming(0.162),
									["ALT_SLOW"] = sequence():Alternate(1, 2):SetTiming(0.429),
									["ALT_SLOW_DIM"] = sequence():Alternate(3, 4):SetTiming(0.429),
								}
							},
							FrontCorner = {
								Frames = {
									-- [13 11 9] [8 10 12]
									[1] = "[B] 13 11 9",
									[2] = "[R] 8 10 12",
									[3] = "[R] 8 10 12 [B*0.6] 13 11 9",
									[4] = "[R*0.6] 8 10 12 [B] 13 11 9",
								},
								Sequences = {
									["QUINT_2C"] = sequence():QuintFlash(2, 1),
									["ALT_SLOW"] = sequence():Alternate(2, 1):SetTiming(0.429),
									["ALT_SLOW_DIM"] = sequence():Alternate(3, 4):SetTiming(0.429),
								}
							},
							RearCorner = {
								Frames = {
									-- [14 16 18] [19 17 15]
									[1] = "[R] 14 16 18",
									[2] = "[B] 19 17 15",
									[3] = "[R] 14 16 18 [B*0.6] 19 17 15",
									[4] = "[R*0.6] 14 16 18 [B] 19 17 15",
								},
								Sequences = {
									["QUINT_2C"] = sequence():QuintFlash(1, 2),
									["ALT_SLOW"] = sequence():Alternate(1, 2):SetTiming(0.429),
									["ALT_SLOW_DIM"] = sequence():Alternate(3, 4):SetTiming(0.429),
								}
							}
						},
						VirtualOutputs = {
							["Emergency.NightParkedWarning"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								},
							},
							["Emergency.ParkedWarning"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
									}
								},
							},
							-- There's some sort of dimmed version of this that exists too but don't fully understand the context to include it
							-- Maybe active when Code 3 driving at night?
							-- https://youtu.be/wgkOjXP7EME?si=lqQFaUD7EaRiM8p9&t=70
							-- https://www.youtube.com/watch?v=7KBe94f2nZc
							--[[["Emergency.NightWarning"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "DRIVE", "REVERSE" },
										["Vehicle.Ambient"] = { "DARK" },
										["Emergency.Warning"] = { "MODE3" }
									}
								},
							}]]
						},
						InputPriorities = {
							["Emergency.ParkedWarning"] = 45,
							["Emergency.NightParkedWarning"] = 46,
							--["Emergency.NightWarning"] = 39,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { All = "ALT_SLOW" },
								["MODE2"] = { All = "ALT_NEW" },
								["MODE3"] = { 
									Front = "PURSUIT",
									Rear = "ALT_FAST",
									FrontCorner = "QUINT_2C",
									RearCorner = "QUINT_2C",
								}
							},
							["Emergency.ParkedWarning"] = {
								["MODE3"] = {
									Front = "FLICKER_CRZ",
									Rear = "ALT_SLOW",
									FrontCorner = "ALT_SLOW",
									RearCorner = "ALT_SLOW",
								 }
							},
							["Emergency.NightParkedWarning"] = {
								["MODE3"] = { 
									Front = "FLICKER_CRZ",
									Rear = "ALT_SLOW_DIM",
									FrontCorner = "ALT_SLOW_DIM",
									RearCorner = "ALT_SLOW_DIM",
								}
							},
							--[[["Emergency.NightWarning"] = {
								["MODE3"] = { 
									All = "DIM_CONST",
								}
							}]]
						}
					}
				}
			},
			{
				Option = "SoundOff Signal mpower Traffic Controller",
				Components = {
					{
						-- SoundOff Signal nForce Interior LED Lightbar isn't an existing component so this will have to do
						Component = "photon_fedsig_ils",
						Position = Vector( 0, 44, 83.5 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1.1,
						Options = {
							Width = 7,
							Angle = 15
						},
						Segments = {
							All = {
								Frames = {
									[4] = "1 3 5 7",
									[5] = "2 4 6 8",
									[6] = "[R] 1 3 5 7 [B*0.6] 2 4 6 8",
									[7] = "[R*0.6] 1 3 5 7 [B] 2 4 6 8",

									[8] = "2 [W] 1",
									[9] = "4 2 [W] 1 3",
									[10] = "6 4 [W] 3 5",
									[11] = "8 6 [W] 5 7",
									[12] = "8 [W] 7",

									[13] = "2:W 1",
									[14] = "4:W 2:W 1 3",
									[15] = "6:W 4:W 3 5",
									[16] = "8:W 6:W 5 7",
									[17] = "8:W 7",

									[18] = "1 3 5 7 2 4 6 8",
								},
								Sequences = {
									["ALT_SLOW"] = sequence():Alternate(4, 5):SetTiming(0.429),
									["ALT_SLOW_DIM"] = sequence():Alternate(6, 7):SetTiming(0.429),
									["ALT"] = sequence():Alternate(4, 5):SetTiming(0.261),
									--["ALT_FAST"] = sequence():Alternate(4, 5):SetTiming(0.162),
									-- PURSUIT timing calculated from 60 flashes per minute, divided by 22 frames, then divided by 60 frames per second
									["PURSUIT"] = sequence():Sequential(8, 12):Add(0):Sequential(12, 8):Sequential(13, 17):Add(0):Sequential(17, 13):SetTiming(.045),
									["FLICKER_CRZ"] = sequence():QuadFlash(18):Steady(18, 140):SetTiming(.025),
								}
							},
						},
						VirtualOutputs = {
							["Emergency.NightParkedWarningOverride"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								},
							},
							["Emergency.ParkedWarningOverride"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
									}
								},
							}
						},
						InputPriorities = {
							["Emergency.ParkedWarningOverride"] = 47,
							["Emergency.NightParkedWarningOverride"] = 48,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { All = "ALT_SLOW" },
								["MODE2"] = { All = "ALT" },
								["MODE3"] = { All = "PURSUIT" }
							},
							["Emergency.ParkedWarningOverride"] = {
								["MODE3"] = { All = "FLICKER_CRZ" }
							},
							["Emergency.NightParkedWarningOverride"] = {
								["MODE3"] = { All = "FLICKER_CRZ" }
							},
							["Emergency.Marker"] = {
								["ON"] = { }
							}
						}
					},
					{
						Name = "@mptc_x6",
						Component = "photon_sos_mptc_x6",
						Position = Vector( 0, -39.6, 84),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1.2,
						RenderGroup = RENDERGROUP_OPAQUE,
						Features = {
							--NightParkMode = true
						},
						-- Have to override all of this since it needs to activate on Mode 2 as well
						VirtualOutputs = {
							["Emergency.NightParkedWarningOverride"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								},
							},
							["Emergency.ParkedWarningOverride"] = {
								{
									Mode = "MODE3",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
									}
								},
							},
							["Emergency.NightParkedDirectionalOverride"] = {
								{
									Mode = "LEFT",
									Conditions = {
										["Emergency.Directional"] = { "LEFT" },
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								},
								{
									Mode = "RIGHT",
									Conditions = {
										["Emergency.Directional"] = { "RIGHT" },
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								},
								{
									Mode = "CENOUT",
									Conditions = {
										["Emergency.Directional"] = { "CENOUT" },
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" },
										["Vehicle.Ambient"] = { "DARK" }
									}
								}
							},
						},
						InputPriorities = {
							["Emergency.ParkedWarningOverride"] = 47,
							["Emergency.NightParkedWarningOverride"] = 48,
							["Emergency.NightParkedDirectionalOverride"] = 82,
						},
						Inputs = {
							["Emergency.ParkedWarningOverride"] = {
								["MODE3"] = { Light = "ALT_SLOW" }
							},
							["Emergency.NightParkedWarningOverride"] = {
								["MODE3"] = { Light = "ALT_SLOW_DIM" }
							},
							["Emergency.NightParkedDirectionalOverride"] = {
								["LEFT"] = { TrafficAdvisor = "LEFT_DIM_6" },
								["RIGHT"] = { TrafficAdvisor = "RIGHT_DIM_6" },
								["CENOUT"] = { TrafficAdvisor = "CENOUT_DIM_6" }
							}
						}
					}
				}
			},
			{
				Option = "SoundOff Signal nForce & mpower TC",
				Components = {
					{
						Inherit = "@nforce_54",
						Inputs = {
							["Emergency.Directional"] = {
								["LEFT"] = { },
								["RIGHT"] = { },
								["CENOUT"] = { }
							},
						}
					},
					{
						Inherit = "@mptc_x6",
					}
				}
			},
			--[[{
				Option = "None"
			}]]
		}
	},
	{
		Category = "Mirrors",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Name = "@mpf3_lights",
						Component = "photon_sos_mpf3",
						--RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( -44.5, 58.5, 58.6 ),
						Angles = Angle( -10, 180, 1 ),
						Segments = {
							Light = {
								Frames = {
									[6] = "[R*0.6] 1",
									[7] = "[B*0.6] 1",
								},
								Sequences = {
									["ALT_R_140"] = sequence():Alternate(6, 1):SetTiming(0.429),
									["ALT_B_140"] = sequence():Alternate(7, 2):SetTiming(0.429),
									["ALT_2C_140"] = sequence():Alternate(1, 2):SetTiming(0.429),
									["FLASH_2C"] = sequence():Flash(1, 2):SetTiming(0.261 / 1),
									-- This timing is more accurate to the real light but looks odd within Photon
									--["QUINT_2C"] = sequence():QuintFlash(1, 2):SetTiming(0.429 / 10),
									["QUINT_2C"] = sequence():QuintFlash(1, 2),
								}
							}
						},
						VirtualOutputs = {
							["Emergency.ParkedWarningAlt"] = {
								{
									Mode = "DIM",
									Conditions = {
										["Vehicle.Ambient"] = { "DARK" },
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" }
									}
								},
								{
									Mode = "MODE1",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" }
									}
								}
							},
						},
						InputPriorities = {
							["Emergency.ParkedWarningAlt"] = 46
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Light = "FLASH_2C:90" },
								["MODE3"] = { Light = "QUINT_2C" }
							},
							["Emergency.Cut"] = { ["FRONT"] = "OFF" },
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_R_140:180" },
								["MODE1"] = { Light = "ALT_2C_140" }
							},
							["Emergency.Marker"] = {
								["ON"] = { }
							}
						}
					},
					{
						Inherit = "@mpf3_lights",
						Position = Vector( 44.5, 58.5, 58.6 ),
						Angles = Angle( -10, 0, -1 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = { Light = "FLASH_2C" },
							},
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_B_140" },
								["MODE1"] = { Light = "ALT_2C_140:90" }
							},
						}
					}
				}
			}
		}
	},
	{
		Category = "Side",
		Options = {
			{
				Option = "Lights",
				Components = {
					{
						Inherit = "@mpf4_lights",
						RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( -40.7, -3, 64.6 ),
						Angles = Angle( -14, 180, 1 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE3"] = { Light = "QUINT_2C" }
							},
						}
					},
					{
						Inherit = "@mpf4_lights",
						RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( 40.7, -3, 64.6 ),
						Angles = Angle( -14, 0, -1 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = { Light = "FLASH_2C" },
								["MODE3"] = { Light = "QUINT_2C" }
							},
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_B_140" },
								["MODE1"] = { Light = "ALT_2C_140:90" }
							},
						}
					}
				}
			},
		}
	},
	{
		Category = "Fender Lights",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Inherit = "@mpf3_lights",
						Position = Vector( -46.3, -78.6, 50 ),
						Angles = Angle( 0, 180, 0 ),
						
					},
					{
						Inherit = "@mpf3_lights",
						Position = Vector( 46.3, -78.6, 50 ),
						Angles = Angle( 0, 0, 0 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = { Light = "FLASH_2C" },
							},
							["Emergency.ParkedWarningAlt"] = {
								["DIM"] = { Light = "ALT_B_140" },
								["MODE1"] = { Light = "ALT_2C_140:90" }
							},
						}
					}
				}
			},
			{
				Option = "None"
			}
		}
	},
	{
		Category = "Lift Gate",
		Options = {
			{
				Option = "Spaced",
				Components = {
					-- Lights are setup either evenly spaced or with a larger gap in the center.
					{
						Name = "@rear_lights",
						Component = "photon_sos_mpf4_x4",
						Position = Vector( 0, -130.5, 38.35 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1,
						Features = {
							ParkMode = true
						},
						Segments = {
							All = {
								Frames = {
									[7] = "[R] 1 3 2 4",
									[8] = "[B] 1 3 2 4",
									[9] = "[R*0.6] 1 3 2 4",
									[10] = "[B*0.6] 1 3 2 4"
								},
								Sequences = {
									-- I used a metronome for this, don't laugh until you try it
									-- Not able to tell if the lights actually flash due to lack of footage and shutter speed
									-- 0.261s = 230cpm for 2 frames
									-- 0.162s = 370cpm for 2 frames
									["ALT_140"] = sequence():Alternate(7, 8):SetTiming(0.429),
									["ALT_230"] = sequence():Alternate(7, 8):SetTiming(0.261),
									["ALT_370"] = sequence():Alternate(7, 8):SetTiming(0.162),
									-- 140 timing, side only?
									--["DOUBLE_2C"] = sequence():DoubleFlash(7, 8):SetTiming(0.10725),
									--["TRIPLE_2C"] = sequence():TripleFlash(7, 8):SetTiming(0.0715),
									["QUINT_2C"] = sequence():QuintFlash(7, 8):SetTiming(0.0429),
									--["FLASH_2C_230"] = sequence():Flash(7, 8):SetTiming(0.1305 / 1),
									--["DOUBLE_2C_230"] = sequence():DoubleFlash(7, 8):SetTiming(0.1305 / 2),
									["DOUBLE_2C_230"] = sequence():Alternate(7, 9):Do(2):Alternate(8, 10):Do(2):SetTiming(0.261 / 4),
									["FLASH_2C_370"] = sequence():Flash(7, 8):SetTiming(0.162 / 2),
									["DOUBLE_2C_370"] = sequence():Alternate(7, 9):Do(2):Alternate(8, 10):Do(2):SetTiming(0.162 / 4),
								}
							}
						},
						VirtualOutputs = {
							["Emergency.ParkedWarningAlt"] = {
								{
									Mode = "MODE1",
									Conditions = {
										["Vehicle.Transmission"] = { "PARK" },
										["Emergency.Warning"] = { "MODE2", "MODE3" }
									}
								}
							},
						},
						InputPriorities = {
							["Emergency.ParkedWarningAlt"] = 46
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { All = "ALT_140" },
								["MODE2"] = { All = "ALT_230" },
								["MODE3"] = { All = "ALT_370" }
							},
							["Emergency.ParkedWarningAlt"] = {
								["MODE1"] = { All = "ALT_140" }
							},
							["Emergency.Marker"] = {
								["ON"] = { }
							}
						},
						Options = {
							Spacing = 10
						}
					}
				}
			},
			{
				Option = "Grouped",
				Components = {
					{
						Inherit = "@rear_lights",
						Options = {
							["Spacing"] = { 10, 11 }
						}
					}
				}
			}
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
						Model = "models/schmal/antenna_absc.mdl",
						Position = Vector( -6, -8, 92 ),
						Angles = Angle( 0, 0, 0 ),
						Color = Color( 32, 32, 32 ),
						Scale = 1.4
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
						Position = Vector( -13.5, -26, 91.5 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1
					},
					{
						Model = "models/schmal/antenna_lojack.mdl",
						Position = Vector( 13.5, -26, 91.8 ),
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
							[1] = "photon/license/plates/ph2_az"
						},
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 0,
							["face"] = "face_circular"
						}
					},
					{
						Inherit = "@rear_plate",
						Angles = Angle( 0, 180, 90 ),
						Position = Vector( 0, 135, 27.7 ),
						BodyGroups = {
							["screws_top"] = 1,
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
		Category = "Controller Sound",
		Options = {
			{
				Option = "Federal Signal",
				InteractionSounds = {
					{ Class = "Controller", Profile = "fedsig" }
				}
			},
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