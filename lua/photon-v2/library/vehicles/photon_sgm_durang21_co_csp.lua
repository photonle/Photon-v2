if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Colorado State Patrol - Dodge Durango (2021)"
VEHICLE.Vehicle		= "21durango_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonMaterial.New({
	Name = "schmal_dodur21_csp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_durang21/co_csp.png",
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

VEHICLE.SubMaterials = {
	[17] = "photon/common/blank", -- skin
	[20] = "photon/common/blank", -- black_chrome
}

VEHICLE.Siren = { "whelen_epsilon" }

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
				Components = {
					{
						Component = "photon_standard_sgmdodur21",
						Inputs = {
							["Emergency.Warning"] = {
							}
						}
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
						Position = Vector( 0, 5, 81.9 ),
						Angles = Angle( 9, 90, 180 ),
						Scale = 1
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
						Name = "@intersector_mirror",
						Component = "photon_sos_intersector_surf",
						Position = Vector( -45, 32.7, 56 ),
						Angles = Angle( 1, 90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
						Inputs = {
							["Emergency.Warning"] = {
								MODE1 = {
									Light = "STEADY_FLASH"
								},
								MODE3 = {
									Light = "QUAD_FLASH_DUO"
								}
							},
						},
						States = { "R", "W" }
					},
					{
						Inherit = "@intersector_mirror",
						Position = Vector( 45, 32.7, 56 ),
						Angles = Angle( -1, -90, 2 ),
						States = { "B", "W" },
						Phase = "B"
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
						Phase = "B"
						-- Position = Vector( 0, 0, 110 ),
						-- Angles = Angle( 0, 90, 0 ),
						
					},
					{
						Component = "photon_whe_inner_edge_right",
						Position = Vector( 20, 19, 75.8 ),
						Angles = Angle( 0, 84, 0 ),
						States = { "B", "B" },
						Phase = "A"
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
							[0] = livery.MaterialName,
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
						Inputs = {
							["Emergency.SceneForward"] = {
								["ON"] = { Takedown = "ON_CHEAP" },
								["FLOOD"] = { Takedown = "ON_CHEAP" },
							}
						}
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
						Position = Vector( -37, 35, 64 ),
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
						Scale = 1.3,
						Inputs = {
							["Emergency.Warning"] = {
								MODE1 = {
									All = "STEADY_FLASH"
								},
								MODE2 = {
									All = "ALT_MED"
								},
								MODE3 = {
									All = "QUAD_FLASH"
								}
							},
						}
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
						Name = "@grille_ion",
						Component = "photon_whe_ion_surface",
						Position = Vector( -8, 106, 43 ),
						Angles = Angle( 0, 4, 0 ),
						Phase = "A",
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { Light = "STEADY_FLASH" },
								["MODE2"] = { Light = "ALT_MED" },
								["MODE3"] = { Light = "QUAD_FLASH" },
							}
						},
						
					},
					{
						Inherit = "@grille_ion",
						Component = "photon_whe_ion_surface",
						Position = Vector( 8, 106, 43 ),
						Angles = Angle( 0, -4, 0 ),
						Phase = "B",
						States = { "B", "R" }
					},
					{
						Name = "@side_ion",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( -37.7, -82, 65.5 ),
						Angles = Angle( 0, 93, 0 ),
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { Light = "STEADY_FLASH" },
								["MODE2"] = { Light = "ALT_MED_DUO" },
								["MODE3"] = { Light = "QUAD_FLASH_DUO" },
							}
						},
						Segments = {
							---@diagnostic disable-next-line: missing-fields
							Light = {
								Sequences = {

								},
								Inputs = {
									["Emergency.Warning:MODE1"] = "STEADY_FLASH"
								}
							}
						},
						Scale = 0.9
					},
					{
						Inherit = "@side_ion",
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( 37.7, -82, 65.5 ),
						Angles = Angle( 0, -93, 0 ),
						States = { "B", "R" }
					}
				}
			}
		}
	},
}