if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Washington State Patrol - 2013 Chevrolet Caprice PPV"
VEHICLE.Vehicle		= "13caprice_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

VEHICLE.Description = [[
The Washington State Patrol is responsible for enforcing traffic laws and investigating accidents on state highways and unincorporated roads.

The Caprice was very common throughout the mid 2010s. They used a relatively unique lighting configuration that was primarily blue with some red and amber.

Their vehicle designs are very simple with graphics only present on the driver and front-passenger doors.
]]

-- This actually does have a siren
VEHICLE.Siren = { "whelen_epsilon" }


local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_wa_wsp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_chevcap13/wa_wsp.png",
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

VEHICLE.SubMaterials = {
	[13] = livery.MaterialName,
	[15] = "photon/common/blank"
}

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
		Category = "Windows",
		Options = {
			{
				Option = "Window",
				Props = {
					{
						Model = "models/schmal/chevcap13_windows.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1,
						SubMaterials = {
							[1] = "schmal/chevcap13/wsp_window",
						}
					}
				}
			},
		}
	},
	{
		Category = "Lighting",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_chevcap13",
						States = { "B", "B" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
								},
								["MODE2"] = {
									RearSignalFlasher = "FLASH_ALT",
								},
								["MODE3"] = {
									TailLightFlasher = "FLASH_ALT",
									ReverseFlasher = "FLASH_ALT",
									RearSignalFlasher = "FLASH_ALT",
									HighBeams = "WIGWAG_RAPID",
								}
							}
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
				Option = "Whelen Liberty (48\")",
				Components = {
					{
						Component = "photon_whe_liberty_48",
						Position = Vector( 0, -19.2, 70.2 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 0.8,
						StateMap = "[B] 1 2 3 4 [R] 5 6 [B] 7 8 9 10 [A] 11 12 [B] 13 14 [R] 15 16",
						Segments = {
							ForwardInboard = {
								Frames = {
									[1] = "3 6",
									[2] = "4 5",
									[3] = "5",
									[4] = "6"
								},
								Sequences = {
									["QUAD_FLASH"] = sequence():QuadFlash( 1, 2 ):Do( 4 ):Alternate( 1, 2, 4 ):Do( 4 ),
									["SLOW"] = sequence():Steady( 4, 10 ):Off( 1 ):Steady( 3, 10 ):Off( 1 )
								}
							},
							Corners = {
								Frames = {
									[1] = "7 9",
									[2] = "8 10",
									[3] = "7 8 9 10"
								},
								Sequences = {
									["TRIPLE_FLASH_HOLD"] = { 1, 1, 0, 1, 0, 1, 0, 2, 2, 0, 2, 0, 2, 0 },
									["ON"] = { 3 }
								}
							},
							RearOuter = {
								Frames = {
									[1] = "11",
									[2] = "12",
								},
								Sequences = {
									["SLOW"] = sequence():Steady( 1, 10 ):Off( 2 ):Steady( 2, 10 ):Off( 2 )
								}
							},
							RearInboard = {
								Frames = {
									[1] = "13 16",
									[2] = "14 15",
									[3] = "13",
									[4] = "14"
								},
								Sequences = {
									["QUAD_FLASH"] = sequence():QuadFlash( 1, 2 ):Do( 4 ):Alternate( 1, 2, 4 ):Do( 4 ),
									["QUAD_FLASH_BLUE"] = sequence():QuadFlash( 3, 4 ):Do( 4 ):Alternate( 3, 4, 4 ):Do( 4 ),
								}
							}
						},
						Bones = {
							["foot_l"] = { Vector( -0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							["foot_r"] = { Vector( 0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_l"] = { Vector( 0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_r"] = { Vector( -0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									Corners = "ON",
									ForwardInboard = "SLOW",
									RearOuter = "SLOW",
								},
								["MODE2"] = {
									ForwardInboard = "QUAD_FLASH",
									Corners = "TRIPLE_FLASH_HOLD",
									RearOuter = "SLOW",
									RearInboard = "QUAD_FLASH_BLUE"
								},
								["MODE3"] = {
									ForwardInboard = "QUAD_FLASH",
									Corners = "TRIPLE_FLASH_HOLD",
									RearOuter = "SLOW",
									RearInboard = "QUAD_FLASH",
									Takedown = "TRIPLE_FLASH",
									Alley = "TRIPLE_FLASH:180"
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
							["front_inner"] = 3,
							["front_middle"] = 0,
							["front_outer"] = 0,
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
						Component = "photon_par46_left",
						Position = Vector( -32, 27, 53 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
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
						Position = Vector( 0, -120.2, 25.6 ),
						Angles = Angle( 0, 0, 90 ),
						Scale = 1.2,
						SubMaterials = {
							-- [1] = "",
							[1] = "photon/license/plates/ph2_wsp"
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
						Position = Vector( 0, 109.9, 18.85 ),
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular",
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
		Category = "Bumper",
		Options = {
			{
				Option = "Setina",
				Props = {
					{
						Model = "models/schmal/chevcap13_bumper.mdl",
						Position = Vector( 0, 113, 24 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1,
						BodyGroups = {
							["wrap"] = 1
						}
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
		Category = "Forward Hide-away Lights",
		Options = {
			{

				Option = "Whelen Vertex", -- just kidding :)
				Components = {
					-- They could've used blue lights on the fender for enhanced intersection clearance,
					-- but they installed these white upward-facing flashers next to the fucking wig-wags instead. 
					--
					-- ?????????????????????????????????
					{
						Name = "@undercover",
						Component = "photon_sos_undercover",
						Position = Vector( -28, 93, 29 ),
						Angles = Angle( 5, 0, -2 ),
						Scale = 0.5,
						RenderGroup = RENDERGROUP_BOTH,
						Elements = {
							-- The angle of the 2D light is manually adjusted to face outward instead of up, giving a better effect
							-- as to be one notch above completely and utterly useless.
							[3] = { "Mid", Vector( 0, 0, 1.2 ), Angle( -45, 45, 0 ) },
						},
						Segments = {
							WSP = {
								Frames = { [1] = "[W] Light"},
								Sequences = {
									["ON"] = { 1 },
									["DOUBLE_FLASH"] = sequence():Add( 1, 1, 1, 0, 1, 1, 0, 0 ):AppendPhaseGap()
								}
							}
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {},
								["MODE3"] = {
									WSP = "DOUBLE_FLASH"
								}
							},
							["Emergency.Marker"] = {
								["ON"] = {}
							}
						}
					},
					{
						Inherit = "@undercover",
						Position = Vector( 28, 93, 29 ),
						Angles = Angle( -5, 0, -2 ),
						Elements = {
							-- Same story as above, but mirrored because I couldn't be bothered to spend 45 seconds
							-- to just change the component angles
							[3] = { "Mid", Vector( 0, 0, 1.2 ), Angle( -45, -45, 0 ) },
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE3"] = { WSP = "DOUBLE_FLASH:180" }
							}
						}
					}
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
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( 0, -5, 67.3 ),
						Angles = Angle( 0, 0, -8 ),
						Scale = Vector( 1, 1, 1.5)
					},
					{
						Model = "models/sentry/antenna.mdl",
						Position = Vector( 0, -38, 68.5 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 1
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna4.mdl",
						Position = Vector( 12, -45, 69.3 ),
						Angles = Angle( 3, 0, 6 ),
						Scale = 1.2
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna3.mdl",
						Position = Vector( 0, -102, 53 ),
						Angles = Angle( 0, 0, 2 ),
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
						Position = Vector( 0, -7, 64.3),
						Angles = Angle( 2, 90, 180 ),
						Scale = 1
					}
				}
			}
		}
	},
	{
		Category = "Interior Equipment",
		Options = {
			{
				Option = "Default",
				Props = {
					{
						Model = "models/schmal/whelen_cencom_panel.mdl",
						Position = Vector( 0, 8, 27.3 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 1
					}
				}
			},
		}
	},
}

hook.Add( "HUDPaint", "Photon2:SGMChevCap13MatOverride", function()
	Material( "sentry/13caprice/turnsig_orange" ):SetInt( "$nowritez", 1 )
	Material( "sentry/13caprice/red_glass" ):SetInt( "$nowritez", 1 )
	Material( "sentry/13caprice/ridges_drl" ):SetInt( "$nowritez", 1 )
	timer.Simple( 5, function()
		Material( "sentry/13caprice/turnsig_orange" ):SetInt( "$nowritez", 1 )
		Material( "sentry/13caprice/red_glass" ):SetInt( "$nowritez", 1 )
		Material( "sentry/13caprice/ridges_drl" ):SetInt( "$nowritez", 1 )
	end)
	hook.Remove( "HUDPaint", "Photon2:SGMChevCap13MatOverride" )
end)
