if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

-- the saviors of Capitol Police
-- https://www.youtube.com/watch?v=iaUAwSbEROQ 
VEHICLE.Title 		= "Virginia State Police - 2013 Ford Police Interceptor Sedan"
VEHICLE.Vehicle		= "13fpis_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

VEHICLE.Description = [[]]

VEHICLE.Siren = { "motorola_spectra" }

-- I (schmal) like to use PNGs because they have a smaller file size
-- and I can quickly edit them in Photoshop with a macro. This is not
-- at all required and you can use VTF/VMT files if you prefer.
local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_va_vsp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpis13/va_vsp.png",
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

local sequence = Photon2.SequenceBuilder.New

VEHICLE.SubMaterials = {
	-- [7] = "schmal/sgm_fpis13/lights"
	[1] = "schmal/sgm_fpis13/chrome",
	[8] = "schmal/sgm_fpis13/forward_signal",
	[9] = "schmal/sgm_fpis13/forward_signal",
	[4] = "photon/common/blank",
}

-- VEHICLE.Livery = livery.MaterialName

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
		Category = "Wheels",
		Options = {
			{
				Option = "Hub Caps",
				Bones = {
					{ Bone = "fl_wheel", Scale = 0, Position = Vector(0, 0, 0), Angles = Angle(0, 0, 0) },
					{ Bone = "fr_wheel", Scale = 0, Position = Vector(0, 0, 0), Angles = Angle(0, 0, 0) },
					{ Bone = "bl_wheel", Scale = 0, Position = Vector(0, 0, 0), Angles = Angle(0, 0, 0) },
					{ Bone = "br_wheel", Scale = 0, Position = Vector(0, 0, 0), Angles = Angle(0, 0, 0) },
				},
				Props = {
					{
						-- It took five hours to get these wheels exported in the correct orientation
						Model = "models/schmal/sgm_fpis13_wheels.mdl",
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
								-- Follow = { Bone = "door_fl" }
							},
						},
					}	
				}
			}
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Setina Wraparound",
				Props = {
					{
						Model = "models/sentry/props/setina_wraps_fpis.mdl",
						Position = Vector( 0, 7, -3.5 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = Vector( 1, 0.93, 0.93 ),
					}
				},
				Components = {
					{
						Name = "@bumper_ion",
						Component = "photon_whe_ion_split",
						Position = Vector( -11, 121.1, 38.6 ),
						Angles = Angle( 0, 0, 0 ),
						States = { "B", "W" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {},
								-- This works because "QUINT_FLASH" is a defined PATTERN
								["MODE3"] = "DOUBLE_FLASH_MED",
							}
						},
						Scale = 1
					},
					{
						Inherit = "@bumper_ion",
						Component = "photon_whe_ion_split",
						Position = Vector( 11, 121.1, 38.6 ),
						Angles = Angle( 0, 0, 0 ),
						States = { "W", "B" },
						Scale = 1
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
									TailFlasher = "ALT"
								},
								["MODE3"] = {
									TailFlasher = "ALT"
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
					{ Id = 27, Material = livery.MaterialName }
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Whelen Liberty (48\")",
				Components = {
					{
						Component = "photon_whe_liberty_48",
						Position = Vector( 0, -7.6, 71 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 0.91,
						-- 7 3 4 8
						-- 9 13 14 10
						StateMap = "[B] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
						Segments = {
							VSP = {
								Frames = {
									[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
								},
								Sequences = {
									["ON"] = { 1 },
								}
							},
							VSP_Corner = {
								Frames = {
									[1] = "7 10",
									[2] = "9 8",
								},
								Sequences = {
									["FLASH"] = sequence():FlashHold( { 1, 2 }, 2, 4 ),
								}
							},
							VSP_Inner = {
								Frames = {
									[1] = "3 14",
									[2] = "4 13",
									[3] = "13",
									[4] = "14",
								},
								Sequences = {
									["FLASH"] = sequence():Add( 1, 0, 2, 0 ):SetVariableTiming( 1/20, 1/6, 1/2 ),
									["REAR"] = sequence():Add( 3, 0, 4, 0 ):SetVariableTiming( 1/20, 1/6, 1/2 ),
								}
							}
						},
						Bones = {
							["foot_l"] = { Vector( 0, 0, 0), Angle( 0, 0, 0 ), 1 },
							["foot_r"] = { Vector( 0, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_l"] = { Vector( 1.4, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_r"] = { Vector( -1.4, 0, 0), Angle( 0, 0, 0 ), 1 },
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									VSP_Inner = "REAR",
								},
								["MODE2"] = {
									VSP_Corner = "FLASH",
									VSP_Inner = "FLASH",
								},
								["MODE3"] = {
									VSP_Corner = "FLASH",
									VSP_Inner = "FLASH",
								}
							},
							["Emergency.Directional"] = {
								["LEFT"] = { AmberTrafficFill = "LEFT" },
								["RIGHT"] = { AmberTrafficFill = "RIGHT" },
								["CENOUT"] = { AmberTrafficFill = "CENOUT" },
							}
						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						},
						BodyGroups = {
							["front_inner"] = 4,
							["front_middle"] = 0,
							["front_outer"] = 1,
							["rear_outer"] = 1,
							["rear_inner"] = 1
						},
						-- States = { "A", "A", "A", "A" }
					}
				}
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
							[1] = "photon/license/plates/ph2_va_state_police"
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
		Category = "Controller Sound",
		Options = {
			{
				Option = "Whelen",
				InteractionSounds = {
					{ Class = "Controller", Profile = "whelen_cencom" }
				}
			},
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
		Category = "Antenna",
		Options = {
			{
				Option = "Option",
				Props = {
					-- models/sentry/antenna.mdl
					{
						Model = "models/sentry/antenna.mdl",
						Scale = 1,
						Position = Vector( 0, -27, 69.9 ),
						Angles = Angle( 0, 0, 2 )
					},
					{
						Model = "models/sentry/antenna3.mdl",
						Position = Vector( 0, -109, 52 ),
						Angles = Angle( 0, 0, 2 ),
						Scale = 1.1
					},
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( 0, -99, 52 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna6.mdl",
						Position = Vector( 0, -39, 70.4 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 1
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
	{
		Category = "Rear Deck",
		Options = {
			{
				Option = "Rear Deck",
				Components = {
					-- this isn't even remotely accurate but fucking sue me
					{
						Component = "photon_fedsig_xstream_single",
						Position = Vector( -10, -81.6, 54 ),
						Angles = Angle( 0, -95, 0 ),
						BodyGroups = {
							["Mount"] = 0,
							["Shroud"] = 0
						},
						Bones = {
							["suction_mount"] = { Vector( 0, 0, 0), Angle( 0, 0, -20 ), 1 },
						
						},
						States = { "B" },
						Inputs = {

						},
						Segments = {

						},
						Scale = 1.1
					},
				}
			},
		}
	},
}
