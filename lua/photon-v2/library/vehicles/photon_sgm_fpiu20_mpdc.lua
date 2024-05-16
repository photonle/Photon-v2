
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "D.C. Metropolitan Police - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_mpdc",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/mpdc.png",
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

-- VEHICLE.Schema = {
-- 	["Emergency.Warning"] = {
-- 		{ Label = "PRIMARY" },
-- 		{ Mode = "MODE1", Label = "STAGE 1" },
-- 		{ Mode = "MODE2", Label = "STAGE 2" },
-- 		{ Mode = "MODE3", Label = "STAGE 3" },
-- 		{ Mode = "MODE4", Label = "STAGE 4" },
-- 	}
-- }

-- VEHICLE.SubMaterials = {
-- 	[3] = "photon/common/blank"
-- -- 	-- [3] = "photon/common/blank"
-- }

VEHICLE.Siren = { "sos_nergy400" }

VEHICLE.Livery = livery.MaterialName

-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	-- {
	-- 	Category = "Liveries",
	-- 	Options = {
	-- 		{
	-- 			Option = "MPDC",
	-- 			SubMaterials = {
	-- 				{ Id = "SKIN", Material = livery.MaterialName },
	-- 			}
	-- 		},
	-- 		{
	-- 			Option = "None",
	-- 			SubMaterials = {
	-- 				{ Id = 20, Material = nil }
	-- 			}
	-- 		}
	-- 	}
	-- },
	{
		Category = "Controller Sound",
		Options = {
			{
				Option = "SoundOff Signal",
				InteractionSounds = {
					{ Class = "Controller", Profile = "sos_nergy" }
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
							[1] = "",
							-- [1] = "photon/license/plates/mpdc_demo"
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
						Angles = Angle(0, 0, 0)
					}
				},
				Components = {
					{
						Component = "photon_sos_mpf4_lic_h",
						Angles = Angle( 0, -90, 0 ),
						Position = Vector( 0, -125, 49 ),
						Scale = 0.96,
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
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
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				Components = {
					{
						Component = "photon_standard_sgmfpiu20",
						States = { "B", "B" },
						Inputs = {
							["Emergency.Marker"] = { ON = {} }
						},
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					}
				}
			}
		}
	},
	{
		Category = "Grille",
		Options = {
			{
				Option = "Intersectors",
				Components = {
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( -11, 116.2, 48 ),
						Angles = Angle( 0, 7, 12 ),
						Scale = 1,
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 11, 116.2, 48 ),
						Angles = Angle( 0, -7, 12 ),
						States = { "B", "R" },
						Phase = "B",
						Scale = 1,
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					}
				}
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
						Component = "photon_sos_undercover",
						Position = Vector( -41.4, 90, 51.5 ),
						Angles = Angle( 0, 74, -76 ),
						Scale = 0.4,
						Inputs = {
							["Emergency.Marker"] = { ON = {} }
						},
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					},
					{
						Component = "photon_sos_undercover",
						Position = Vector( 41.4, 90, 51.5 ),
						Angles = Angle( 0, -74, -76 ),
						States = { "B", "R" },
						Scale = 0.4,
						Inputs = {
							["Emergency.Marker"] = { ON = {} }
						},
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
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
						Position = Vector( -45.5, 34.5, 57.3 ),
						Angles = Angle( 1, 90, 2 ),
						Scale = 1,
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 45.5, 34.5, 57.3 ),
						Angles = Angle( -1, -90, 2 ),
						Scale = 1,
						States = { "B", "R" },
						Bones = {
							["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
						},
						Flags = {
							ParkMode = { "Emergency.Warning", "MODE2" },
						}
					},
				}
			}
		}
	},
	-- {
	-- 	Category = "Build",
	-- 	Options = {
	-- 		{
	-- 			Option = "mpower Fascia 4\"",
	-- 			Components = {
	-- 				{
	-- 					Component = "photon_sos_mpf4",
	-- 					Position = Vector( 0, 0, 120 ),
	-- 					Angles = Angle( 0, 90, 0 ),
	-- 					Scale = 1
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- },
	{
		Category = "Forward Lightbar",
		Options = {
			
			{ Option = "SoundOff Signal nForce", 
				Variants = {
					{
						Variant = "MPDC",
						Components = {
							{
								Inherit = "@nforce54",
								Component = "schmal_mpdc_sos_nforce_54",
								Inputs = {
									["Emergency.Warning"] = {
										["MODE4"] = {
											All = "ON"
										}
									}
								}
							},
						}
					},
					{
						Variant = "Default",
						Components = {
							{
								Name = "@nforce54",
								Component = "photon_sos_nforce_54",
								Position = Vector( 0, -15, 87.55 ),
								Angles = Angle( 0, 0, -1 ),
								Scale = 1.029,
								Flags = {
									ParkMode = { "Emergency.Warning", "MODE2" },
								}
							}
						}
					},
					
				},
			},
		},
	},
	{
		Category = "Antennas",
		Options = {
			{
				Option = "MPDC",
				Props = {
					{
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( -22.6, -91, 82.6 ),
						Angles = Angle( -5, 0, 6 ),
						Scale = 0.8
					},
					{
						Model = "models/sentry/antenna5.mdl",
						Position = Vector( 22.6, -91, 82.6 ),
						Angles = Angle( 5, 0, 6 ),
						Scale = 0.6
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
						Scale = 1.1,
						-- Model = "models/sentry/props/spotlightpar46_left_up.mdl",
						-- Bones = {
						-- 	["base"] = { Vector(0, 0, 0), Angle(0, 0, 0), 1 },
						-- 	["shaft"] = { Vector(0, 0, 0), Angle(80, 0, 0), 1 },
						-- 	["handle"] = { Vector(0, 0, 0), Angle(0, 0, 0), 1 },
						-- 	["grip"] = { Vector(0, 0, 0), Angle(0, 0, 0), 1 },
						-- 	["lamp"] = { Vector(0, 0, 0), Angle(0, 270, 0), 1 },

						-- }
					},
					{
						Component = "photon_whe_par46_right",
						Position = Vector( 39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				},
				-- Props = {

				-- 	{
				-- 		Model = "models/sentry/props/spotlightpar46_right_down.mdl",
				-- 		Position = Vector( 39.4, 37, 63 ),
				-- 		Angles = Angle( 0, 0, 0 ),
				-- 		Scale = 1.1
				-- 	}
				-- }
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
						Component = "photon_sos_siren",
						Position = Vector(-11, 115, 38),
						Angles = Angle(1.5, -90, 0),
						Scale = 1.4,
						-- Siren = "fedsig_smartsiren"
						Siren = 1
					},
				}
			}
		}
	}
	-- },
	-- {
	-- 	Category = "Rear Lightbar",
	-- 	Options = {
	-- 		{
	-- 			Option = "None",
	-- 			Components = {}
	-- 		},
	-- 		{
	-- 			Option = "JetSolaris",
	-- 			Components = {
	-- 				{
	-- 					Inherit 	= "@jetsolaris_front",
	-- 					Position	= Vector(0, -65, 91),
	-- 				}
	-- 			}
	-- 		},
			
			
			
	-- 	}
	-- },
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false