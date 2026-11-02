
if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Burlington Police Department - Ford Police Interceptor (2025)"
VEHICLE.Vehicle		= "25fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "SGM"

VEHICLE.BodyGroups = {
	["interceptorbadge"] = 1,
}

local livery = PhotonMaterial.New({
	Name = "25fpiubpd_sgm",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "sentry/bpd/25fpiu.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.15, 0.15, 0.15 ),
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

local glass = PhotonMaterial.New({
	Name = "25fpiubpdglass_sgm",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "sentry/bpd/25fpiuwindows.png",
		["$bumpmap"] = "sentry/bpd/25fpiuwindows_nm.png",
		
		["$translucent"] = 1,
		["$halflambert"] = 1,

		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.75, 0.75, 0.75 ),
		["$envmapfresnel"] = 1,
		["$normalmapalphaenvmapmask"] = 1,

		["$phong"] = 1,
		["$phongboost"] = 0.2,
		["$phongexponent"] = 55,
		["$phongfresnelranges"] = Vector( 4, 1, 4 ),
		["$notint"] = 1,

		["$nodecal"] = 1
	}
})

VEHICLE.SubMaterials = {
	["6"] = glass.MaterialName,
	["24"] = livery.MaterialName,
}

VEHICLE.Siren = {
	[1] = "sos_nergy400",
}
local sequence = Photon2.SequenceBuilder.New
-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	{
		Category = "Lights",
		Options ={
			{
				Option = "Lights",
				Components = {
					{
						Component = "photon_standard_sgmfpiu25",
						Segments = {
							Taillight_flasher_l = {
								Frames = {
									[0] = "[PASS] TailL",
									[1] = "TailL",
								},
								Sequences = {
									["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap(),
								},
							},
							Taillight_flasher_r = {
								Frames = {
									[0] = "[PASS] TailR",
									[1] = "TailR",
								},
								Sequences = {
									["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap(),
								},
							},
							Reverse_flasher_l = {
								Frames = {
									[0] = "[PASS] 15",
									[1] = "[R] 15",
									[2] = "[W] 15",
								},
								Sequences = {
									["ALTERNATE"] = sequence():Alternate(1,0,10),
									["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap():Add( 2, 2, 0, 2, 2, 0, 2, 2 ):AppendPhaseGap(),
									["STEADY"] = { 1 },
								}
							},
							Reverse_flasher_r = {
								Frames = {
									[0] = "[PASS] 16",
									[1] = "[B] 16",
									[2] = "[W] 16",
								},
								Sequences = {
									["ALTERNATE"] = sequence():Alternate(1,0,10),
									["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap():Add( 2, 2, 0, 2, 2, 0, 2, 2 ):AppendPhaseGap(),
									["STEADY"] = { 1 },
								}
							},
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									HighBeamL = "PASS",
									HighBeamR = "PASS",
									HeadlightL = "PASS",
									HeadlightR = "PASS",
									Reverse_flasher_l = "ALTERNATE",
									Reverse_flasher_r = "ALTERNATE:180",
								},
								["MODE2"] = {
									HighBeamL = "WIGWAG",
									HighBeamR = "WIGWAG",
									HeadlightL = "WIGWAG",
									HeadlightR = "WIGWAG",
									Taillight_flasher_l = "TRI_FLASH_SOLO:180",
									Taillight_flasher_r = "TRI_FLASH_SOLO:180",
									Reverse_flasher_l = "TRI_FLASH_SOLO",
									Reverse_flasher_r = "TRI_FLASH_SOLO:180",
								},
								["MODE3"] = {
									HighBeamL = "WIGWAG",
									HighBeamR = "WIGWAG",
									HeadlightL = "WIGWAG",
									HeadlightR = "WIGWAG",
									Taillight_flasher_l = "TRI_FLASH_SOLO:180",
									Taillight_flasher_r = "TRI_FLASH_SOLO:180",
									Reverse_flasher_l = "TRI_FLASH_SOLO",
									Reverse_flasher_r = "TRI_FLASH_SOLO:180",
								}
							},
							["Emergency.Marker"] = {
								["ON"] = {
									Reverse_flasher_l = "STEADY",
									Reverse_flasher_r = "STEADY",
								},
							}
						},
					},
				}
			}
		},
	},
    {
		Category = "Lightbar",
		Options ={
			{
				Option = "Lightbar",
				Components = {
					{
						Component = "photon_sos_mpower_55",
						Position = Vector( 0.0, -15, 87.0 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1.03,
						BodyGroups = {
							["feet"] = 0,
						},
						Segments = {
							Light = {
								Frames = {
									[17] = "Sec_4 Sec_5 Sec_6 Sec_7 Sec_11 Sec_12 Sec_13 Sec_14 Sec_20 Sec_21 Sec_22 Sec_23 Sec_24",
								},
								Sequences = {
									["STEADY"] = { 7 },
									["ALTERNATE"] = sequence():Alternate(1,17,10),
								}
							}
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "3"
								},
							},
							["Emergency.Marker"] = {
								["ON"] = {
									Light = "STEADY",
								}
							}
						},
					},
				},
			},
		},
	},
	{
		Category = "Side Lighting",
		Options ={
			{
				Option = "Fascias",
				Components = {
					{
						Name = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -48.05, 49.6, 43.6 ),
						Angles = Angle( -10, 187.5, 0 ),
						Scale = 0.9,
						States = {"R"},
						Segments = {
							Light = {
								Frames = {
									[1] = "[1] 1",
									[2] = "[W] 1",
								},
								Sequences = {
									["ALTERNATE"] = sequence():Alternate(1,0,10),
									["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap():Add( 2, 2, 0, 2, 2, 0, 2, 2 ):AppendPhaseGap(),
									["STEADY"] = { 1 },
								}
							},
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
							["Emergency.Marker"] = {
								["ON"] = {
									Light = "STEADY",
								}
							}
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -45.3, -74.6, 54.7 ),
						Angles = Angle( -20, 184, 2.5 ),
						Scale = 0.9,
						Phase = 135,
						States = {"R"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:-135"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 48.05, 49.6, 43.6 ),
						Angles = Angle( -10, -7.5, 0 ),
						Scale = 0.9,
						Phase = 0,
						States = {"B"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:180"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 45.3, -74.6, 54.7 ),
						Angles = Angle( -20, -4, -2.5 ),
						Scale = 0.9,
						Phase = 135,
						States = {"B"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:45"
								},
							},
						},
					},
					--headlight
					{
						Inherit = "@mpf4",
						Name = "@hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( -40.7, 91.6, 51.5 ),
						Angles = Angle( -79, -20, 0 ),
						Scale = 0.3,
						Phase = 135,
						States = {"R"},
						Segments = {
							Light = {
								Frames = {
									[1] = "[1] Light",
									[2] = "[W] Light",
								},
								Sequences = {
									["1"] = { 1 },
								}
							}
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:-135"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								}
							},
							["Emergency.Marker"] = {
								["ON"] = {
									Light = "1"
								}
							}
						},
					},
					{
						Inherit = "@hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( 40.7, 91.6, 51.5 ),
						Angles = Angle( 79, 20, 0 ),
						Scale = 0.3,
						Phase = 135,
						States = {"B"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:45"
								},
							},
						},
					},
					--pushbar
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -11, 120.7, 50.05 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 0.9,
						Phase = 45,
						States = {"R"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:135"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 11, 120.7, 50.05 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 0.9,
						Phase = 180,
						States = {"B"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:-180"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -20.6, 124.0, 39.05 ),
						Angles = Angle( 180, 0, 90 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 20.6, 124.0, 39.05 ),
						Angles = Angle( 0, 0, 90 ),
						Scale = 0.9,
						Phase = 135,
						States = {"B"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:45"
								},
							},
						},
					},

					--rear
					--left pillar
					{
						Inherit = "@mpf4",
						Name = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( -34.7, -104.8, 74.5 ),
						Angles = Angle( 0, -82, 62.75 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						SubMaterials = {
							["sentry/props/soundofffascia/soundoff"] = "sentry/props/soundofffascia/soundoff_flipped",
						},
						BodyGroups = {
							["mount"] = 1,
						},
						Segments = {
							Traffic = {
								Frames = {
									[1] = "[A] 1"
								},
								Sequences = {
									["ON"] = { 1 },
								}
							},
							Reverse = {
								Frames = {
									[1] = "[W] 1"
								},
								Sequences = {
									["ON"] = { 1 },
								}
							},
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
							["Emergency.Directional"] = {
								["LEFT"] = {
									Traffic = "ON",
								},
								["RIGHT"] = {
									Traffic = "ON",
								},
								["CENOUT"] = {
									Traffic = "ON",
								}
							},
							["Vehicle.Transmission"] = {
								["REVERSE"] = {
									Reverse = "ON",
								}
							}
						},
					},
					{
						Inherit = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( -35.75, -108.65, 70 ),
						Angles = Angle( 0, -80, 66.5 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
							},
						},
					},
					{
						Inherit = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( -36.85, -112.5, 65.5 ),
						Angles = Angle( 0, -80, 68.5 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
						},
					},
					
					--right pillar
					{
						Inherit = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( 34.7, -104.8, 74.5 ),
						Angles = Angle( 0, -98, -62.75 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						SubMaterials = {
							["sentry/props/soundofffascia/soundoff"] = "",
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
							},
						},
					},
					{
						Inherit = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( 35.75, -108.65, 70 ),
						Angles = Angle( 0, -100, -66.5 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						SubMaterials = {
							["sentry/props/soundofffascia/soundoff"] = "",
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
							},
						},
					},
					{
						Inherit = "@mpf3",
						Component = "photon_sos_mpf3",
						Position = Vector( 36.85, -112.5, 65.5 ),
						Angles = Angle( 0, -100, -68.5 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						SubMaterials = {
							["sentry/props/soundofffascia/soundoff"] = "",
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
							},
						},
					},
					--spoiler left
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -26.0, -109.0, 77.3 ),
						Angles = Angle( 0, -107.5, 0 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -20.5, -110.2, 77.3 ),
						Angles = Angle( 0, -97.5, 0 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( -14.97, -110.99, 77.3 ),
						Angles = Angle( 0, -97.5, 0 ),
						Scale = 0.9,
						Phase = 0,
						States = {"R"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
						},
					},
					--spoiler right
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 26.0, -109.0, 77.3 ),
						Angles = Angle( 0, -72.5, 0 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 20.5, -110.2, 77.3 ),
						Angles = Angle( 0, -82.5, 0 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO:90"
								},
							},
						},
					},
					{
						Inherit = "@mpf4",
						Component = "photon_sos_mpf4",
						Position = Vector( 14.97, -110.99, 77.3 ),
						Angles = Angle( 0, -82.5, 0 ),
						Scale = 0.9,
						Phase = 90,
						States = {"B"},
						BodyGroups = {
							["mount"] = 0,
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Light = "ALTERNATE:90"
								},
								["MODE2"] = {
									Light = "TRI_FLASH_SOLO"
								},
								["MODE3"] = {
									Light = "TRI_FLASH_SOLO"
								},
							},
						},
					},
				}
			}
		}
	},
	{
		Category = "Equipment",
		Options ={
			{
				Option = "Default",
                BodyGroups = {
					{ BodyGroup = "Pushbar", Value = 1 },
					{ BodyGroup = "console", Value = 2 },
					{ BodyGroup = "laptop", Value = 1 },
				},
				Components = {
					{
						Component = "photon_pan_toughbookcf30",
						Position = Vector(8.3, 18, 49.4),
						Angles = Angle(0, 30, 0),
						Scale = 1.0,
						Options = {
							Pole = -2,
							Base = -60,
							-- You can change the screen material by using this option:
							Screen = "schmal/toughbook_cf30/laptop_screen_darkmode",
						}
					},
					{
						Component = "photon_sos_nergy",
						Position = Vector(0, 16.7, 41.5),
						Angles = Angle(35, -90, 0),
						Scale = 1.0,
					},
				},
				Props = {
					{
						Model = "models/paolo/props/motorola_6500.mdl",
						Position = Vector(0, 13.85, 35.4),
						Angles = Angle(35, -90, 0),
						Scale = 0.72,
					},
					{
						Model = "models/sentry/props/soundofffascia_fpiu_l.mdl",
						Position = Vector( -20.5, -110.2, 77.3 ),
						Angles = Angle( 0, -97.5, 0 ),
						Scale = 0.9,
						BodyGroups = {
							["mount"] = 2,
						},
					},
					{
						Model = "models/sentry/props/soundofffascia_fpiu_r.mdl",
						Position = Vector( 20.5, -110.2, 77.3 ),
						Angles = Angle( 0, -82.5, 0 ),
						Scale = 0.9,
						BodyGroups = {
							["mount"] = 2,
						},
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
						Model = "models/sentry/props/sosetss100n.mdl",
						Position = Vector(-14.85, 126.5, 29.4),
						Angles = Angle(0, -90, 0),
						Scale = 1.2,
                        Siren = "sos_nergy400",
						Bones = {
                            ["mount"] = { Vector(0, 0, 0), Angle(0, 180, 0), 1 },
                        },
						SubMaterials = {
							[0] = "sentry/bpd/speaker",
						},
						Options = {
							DisableInterrupt = true,
							DisableParkKill = true,
						}
					},
					--use a prop instead because 2 sirens is very loud
					-- {
					-- 	Component = "siren_prototype",
					-- 	Model = "models/sentry/props/sosetss100n.mdl",
					-- 	Position = Vector(14.85, 126.5, 29.4),
					-- 	Angles = Angle(0, -90, 0),
					-- 	Scale = 1.2,
                    --     Siren = "sos_nergy400",
					-- 	Bones = {
                    --         ["mount"] = { Vector(0, 0, 0), Angle(0, 180, 0), 1 },
                    --     },
					-- },
				},
				Props = {
					{
						Model = "models/sentry/props/sosetss100n.mdl",
						Position = Vector(14.85, 126.5, 29.4),
						Angles = Angle(0, -90, 0),
						Scale = 1.2,
						Bones = {
                            ["mount"] = { Vector(0, 0, 0), Angle(0, 180, 0), 1 },
                        },
						SubMaterials = {
							[0] = "sentry/bpd/speaker",
						},
					},
				},
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
				},
			},
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
						Model = "models/xenosprops/na_plate/na_plate_gov.mdl",
						Position = Vector( 0, -127.4, 50.2 ),
						Angles = Angle( -12, -90, 0 ),
						Scale = 1.0,
						SubMaterials = {
							[1] = "sentry/bpd/plate_1804",
						},
					},
				}
			}
		}
	},
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false