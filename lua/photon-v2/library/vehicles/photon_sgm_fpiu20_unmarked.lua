
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Unmarked - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

-- VEHICLE.Siren = { "code3_z3" }
-- VEHICLE.Siren = { "dr_iqelitepro" }
-- VEHICLE.Siren = { "motorola_spectra" }
VEHICLE.Siren = { "whelen_epsilon" }
-- VEHICLE.Siren = {
	-- This an example of using mixed siren tones (also a real-world recreation)
	-- [1] = {
	-- 	T1 = "fedsig_touchmaster_delta/wail",
	-- 	T2 = "fedsig_touchmaster_delta/yelp",
	-- 	T3 = "fedsig_smartsiren/priority",
	-- 	T4 = "fedsig_smartsiren/hilo",
	-- 	AIR = "fedsig_smartsiren/airhorn",
	-- 	MAN = "fedsig_touchmaster_delta/manual",
	-- },
-- }

-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Legacy (48\")",
				Components = {
					{
						Component = "photon_whe_legacy_48",
						Position = Vector( 0, -15, 87.7 ),
						-- Position = Vector( 0, -15, 100 ),
						Angles = Angle( 1, 90, 0 ),
						-- Angles = Angle( 0, 90, 0 ),
						-- Scale = 1,
						Scale = 1.02,
						Bones = {
							[11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							[10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
					}
				},
			},
			{
				Option = "Legacy (44\")",
				Components = {
					{
						Component = "photon_whe_legacy_44",
						-- Position = Vector( 0, -15, 87.7 ),
						Position = Vector( 0, -15, 100 ),
						-- Angles = Angle( 1, 90, 0 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						-- Scale = 1.02,
						Bones = {
							-- [11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							-- [10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
					}
				},
			},
			{
				Option = "Liberty (48\")",
				Components = {
					{
						Component = "photon_whe_libertyii_48",
						-- Position = Vector( 0, -15, 87.7 ),
						Position = Vector( 0, -15, 100 ),
						-- Angles = Angle( 1, 90, 0 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						-- Scale = 1.02,
						Bones = {
							-- [11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							-- [10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
					}
				},
			},
			{
				Option = "Legacy (54\")",
				Components = {
					{
						Component = "photon_whe_legacy_54",
						-- Position = Vector( 0, -15, 87.7 ),
						Position = Vector( 0, -15, 100 ),
						-- Angles = Angle( 1, 90, 0 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						-- Scale = 1.02,
						Bones = {
							-- [11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							-- [10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
					}
				},
			},
			{
				Option = "Integrity (51\")",
				Components = {
					{
						Component = "photon_fedsig_integrity_51",
						Position = Vector( 0, -15, 100 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						Bones = {

						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						}
					}
				},
			},
			{
				Option = "Valor (51\")",
				Components = {
					{
						Component = "photon_fedsig_valor_51",
						Position = Vector( 0, -15, 90 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						Bones = {

						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						}
					}
				},
			},
			{
				Option = "Valor (44\")",
				Components = {
					{
						Component = "photon_fedsig_valor_44",
						Position = Vector( 0, -15, 100 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						Bones = {

						},
					}
				},
			},
			{
				Option = "Integrity (44\")",
				Components = {
					{
						Component = "photon_fedsig_integrity_44",
						Position = Vector( 0, -15, 100 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						Bones = {

						},
					}
				},
			},

			{
				Option = "Liberty II",
				Components = {
					{
						Component = "photon_sm_liberty_ii_suv",
						Position = Vector( 0, -15, 88 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.1,
						
					}
				},
				
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
					}
				},
				Components = {
					{
						Component = "photon_sos_mpf4_lic_h",
						Angles = Angle( 0, -90, 0 ),
						Position = Vector( 0, -125, 49 ),
						Scale = 0.96
					}
				}
			}
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "None",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 0 }
				}
			},
			{
				Option = "Pushbar",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 1 }
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{ Option = "None" },
			{
				Option = "nForce 54\"",
				Components = {
					{
						Name = "@nforce54",
						Component = "photon_sos_nforce_54",
						Position = Vector( 0, -15, 87.55 ),
						Angles = Angle( 0, 0, -1 ),
						Scale = 1.029
					}
				}
			}
		}
	},
	{
		Category = "Spotlight",
		Options = {
			{
				Option = "None"
			},
			{
				Option = "Whelen PAR6",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -39.4, 37, 63 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
						-- not: 3
						Bones = {
							-- YAW ( yaw axis )
							-- [4] = { Vector(0, 0, 0), Angle(0, 30, 0), 1 },
							-- ROLL ( pitch axis )
							-- [1] = { Vector(0, 0, 0), Angle(40, 0, 0), 1 },
						},
					}
				}
			},
			{ Option = "None" },
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
						Position = Vector(-11, 110, 35),
						Angles = Angle(1.5, -90, 0),
						Scale = 1.4,
						-- Siren = "fedsig_smartsiren"
						Siren = 1
					},
					-- {
					-- 	Component = "photon_siren_secondary",
					-- 	Position = Vector(11, 110, 35),
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
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				Components = {
					{
						Component = "photon_standard_sgmfpiu20"
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
						Scale = 1
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 11, 116.2, 48 ),
						Angles = Angle( 0, -7, 12 ),
						Scale = 1
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
						Scale = 0.4
					},
					{
						Component = "photon_sos_undercover",
						Position = Vector( 41.4, 90, 51.5 ),
						Angles = Angle( 0, -74, -76 ),
						Scale = 0.4
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
					},
					{
						Component = "photon_sos_intersector_surf",
						Position = Vector( 45.5, 34.5, 57.3 ),
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
	-- {
	-- 	Category = "Standard",
	-- 	Options = {
	-- 		{
	-- 			Option = "Standard Lighting",
	-- 			VirtualComponents = {
	-- 				{
	-- 					Component = "photon_standard_sgmfpiu20"
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- },
	-- {
	-- 	Category = "Grille",
	-- 	Options = {
	-- 		{
	-- 			Option = "Intersectors",
	-- 			Components = {
	-- 				{
	-- 					Component = "photon_sos_intersector_surf",
	-- 					-- inheritance ID concept...
	-- 					-- component < vehicle : equipmentId >
	-- 					-- photon_sos_intersector_surf<photon_sgm_fpiu_unmarked:12>
	-- 					Position = Vector( -11, 116.2, 48 ),
	-- 					Angles = Angle( 0, 7, 12 ),
	-- 					Scale = 1,
	-- 					StateMap = "[A] Intersector",
	-- 					-- Properties = {
	-- 					-- 	StateMap = "[A] Intersector"
	-- 					-- }
	-- 				},
	-- 				{
	-- 					Component = "photon_sos_intersector_surf",
	-- 					Position = Vector( 11, 116.2, 48 ),
	-- 					Angles = Angle( 0, -7, 12 ),
	-- 					Scale = 1,
	-- 					StateMap = "[G] Intersector"

	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- },
	-- {
	-- 	Category = "Mirror",
	-- 	Options = {
	-- 		{
	-- 			Option = "Intersectors (Surface)",
	-- 			Components = {
	-- 				{
	-- 					Component = "photon_sos_intersector_surf",
	-- 					Position = Vector( -45.5, 34.5, 57.3 ),
	-- 					Angles = Angle( 1, 90, 2 ),
	-- 					Scale = 1,
	-- 					Bones = {
	-- 						["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
	-- 					},
	-- 					StateMap = "[B] Intersector"
	-- 				},
	-- 				{
	-- 					Component = "photon_sos_intersector_surf",
	-- 					Position = Vector( 45.5, 34.5, 57.3 ),
	-- 					Angles = Angle( -1, -90, 2 ),
	-- 					Scale = 1,
	-- 					Bones = {
	-- 						["mount"] = { Vector(0, 1, 1), Angle(0, 0, 0), 1 },
	-- 					},
	-- 					StateMap = "[R] Intersector"

	-- 				},
	-- 			}
	-- 		}
	-- 	}
	-- },
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
	-- {
	-- 	Category = "Forward Lightbar",
	-- 	Options = {
			
	-- 		{ Option = "SoundOff Signal nForce", 
	-- 			Variants = {
	-- 				{
	-- 					Variant = "MPDC",
	-- 					Components = {
	-- 						{
	-- 							Inherit = "@nforce54",
	-- 							Component = "schmal_mpdc_sos_nforce_54",
	-- 						},
	-- 					}
	-- 				},
	-- 				{
	-- 					Variant = "Default",
	-- 					Components = {
	-- 						{
	-- 							Name = "@nforce54",
	-- 							Component = "photon_sos_nforce_54",
	-- 							Position = Vector( 0, -15, 87.55 ),
	-- 							Angles = Angle( 0, 0, -1 ),
	-- 							Scale = 1.029
	-- 						}
	-- 					}
	-- 				},
					
	-- 			},
	-- 		},
	-- 		{ Option = "JetSolaris", Variants = {
	-- 				{ Variant = "Front",
	-- 					Components = {
	-- 						{
	-- 							Name 		= "@jetsolaris_front",
	-- 							Component	= "photon_fedsig_jetsolaris",
	-- 							Position	= Vector(0, -15, 91),
	-- 							Angles		= Angle(0, 0, 0),
	-- 							Scale		= 1
	-- 						},
	-- 					}
						
	-- 				},
	-- 				{ Variant = "Alternate",
	-- 					Components = {
	-- 						{
	-- 							Inherit 	= "@jetsolaris_front",
	-- 							Scale		= 0.5,
	-- 							Position	= Vector(0, -15, 100 )
	-- 						}
	-- 					}
	-- 				},
	-- 			}
	-- 		},
	-- 		{ Option = "None",
			
	-- 		},
	-- 	},
	-- }
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