if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Colorado State Patrol - Dodge Durango (2021)"
VEHICLE.Vehicle		= "21durango_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"


VEHICLE.SubMaterials = {
	[17] = "photon/common/blank", -- skin
	[20] = "photon/common/blank", -- black_chrome
}

VEHICLE.Siren = { "whelen_gamma" }

VEHICLE.Equipment = {
	{
		Category = "HUD",
		Options = {
			{
				Option = "HUD",
				UIComponents = {
					{
						Component = "photon_hud_default"
					}
				}
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
			{
				Option = "Code 3",
				InteractionSounds = {
					{ Class = "Controller", Profile = "code3_z3s" }
				}
			},
			{
				Option = "Federal Signal",
				InteractionSounds = {
					{ Class = "Controller", Profile = "fedsig" }
				}
			},
			{
				Option = "SoundOff Signal",
				InteractionSounds = {
					{ Class = "Controller", Profile = "sos_nergy" }
				}
			}
		}
	},
	{
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmdodur21"
					}
				}
			}
		}
	},
	{
		Category = "Mirror",
		Options = {
			{
				Option = "Intersectors (Surface)",
				Components = {
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( -45, 32.7, 56 ),
						Angles = Angle( 1, 90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 45, 32.7, 56 ),
						Angles = Angle( -1, -90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
					},
				}
			}
		}
	},
	{
		Category = "Interior Lightbar",
		Options = {
			{
				Option = "Whelen Inner Edge",
				Components = {
					{
						Component = "photon_whe_inner_edge_left",
						Position = Vector( -20, 19, 75.8 ),
						Angles = Angle( 0, 96, 0 ),
						-- Position = Vector( 0, 0, 110 ),
						-- Angles = Angle( 0, 90, 0 ),
					},
					{
						Component = "photon_whe_inner_edge_right",
						Position = Vector( 20, 19, 75.8 ),
						Angles = Angle( 0, 84, 0 )
					}
				}
			}
		}
	},
	{
		Category = "Body",
		Options = {
			{
				Option = "Black Trim",
				Props = {
					{
						Model = "models/schmal/dodur21_hull.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[0] = "schmal/liveries/sgm_durang21/co_csp",
						}
					},
					{
						Model = "models/schmal/dodur21_wheels.mdl",
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
						AutoWheels = { Offset = Vector( -2.7, 0, 0 ) }
						-- SubMaterials = {
						-- 	[0] = "schmal/liveries/sgm_durang21/co_csp",
						-- }
					}
				}
			}
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Setina",
				Props = {
					{
						Model = "models/schmal/setina_pushbar_durango.mdl",
						Position = Vector( 0, 118, 32 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1,
						SubMaterials = {}
					}
				}
			}
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
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, -129, 49.5 ),
						Angles = Angle( 0, 0, 66 ),
						Scale = 1.2,
						SubMaterials = {
							-- [1] = "",
							[1] = "photon/license/plates/ph2_co_sp"
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
						Position = Vector( 0, 117, 27 ),
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular",
							["mount"] = "mount"
						}
					},
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			-- { Option = "None" },
			{
				Option = "Liberty II",
				Components = {
					{
						Component = "photon_sm_liberty_ii_suv",
						Position = Vector( 0, -14, 86.7 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.1,
					}
				},
				
			}
		}
	},
	{
		Category = "Spotlight",
		Options = {
			{
				Option = "Whelen PAR46",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -37, 34, 64 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
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
						Model = "models/schmal/antennas/antenna_6.mdl",
						Position = Vector( 0, -30, 95),
						Angles = Angle( 0, 0, 1 ),
						Scale = Vector(1,1,2)
					},
					{
						Model = "models/sentry/antenna5.mdl",
						Position = Vector( 0, -79, 84.8 ),
						Angles = Angle( 0, 0, 2 ),
						Scale = .9
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
						Position = Vector(-13, 123, 33.2),
						Angles = Angle(1.5, -90, -180),
						Scale = 1.4,
						Siren = 1
					},
				}
			}
		}
	},
	{
		Category = "Dominator",
		Options = {
			{
				Option = "Dominator",
				Components = {
					{
						Component = "photon_whe_dominator_8",
						Position = Vector( 0, -111.5, 75.8 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.3
					}
				}
			}
		}
	},
	{
		Category = "Ions",
		Options = {
			{
				Option = "Ions",
				Components = {
					{
						Component = "photon_whe_ion_surface",
						Position = Vector( 0, 0, 100 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1
					}
				}
			}
		}
	},
}