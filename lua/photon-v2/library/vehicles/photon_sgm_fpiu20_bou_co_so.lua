
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Boulder County Sheriff's Office - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"


local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_bcso",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/bou_co_cso.png",
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

VEHICLE.Siren = {
	"sos_nergy400"
}

-- Category -> Option (-> Variant)
VEHICLE.Equipment = {
	{
		Category = "Liveries",
		Options = {
			{
				Option = "Boulder County Sheriff",
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
		Category = "Standard",
		Options = {
			{
				Option = "Vehicle Lighting",
				Components = {
					{
						Component = "photon_standard_sgmfpiu20"
					}
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
							[1] = "photon/license/plates/ph2_co_gvt"
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
		Category = "Forward Lightbar",
		Options = {
			{ Option = "SoundOff Signal nForce", 
				Variants = {
					{
						Variant = "Default",
						Components = {
							{
								Name = "@nforce48",
								Component = "photon_sos_nforce_48",
								Position = Vector( 0, -15, 87.6 ),
								Angles = Angle( 0, 0, -1 ),
								Scale = 1.029,
								Bones = {
									["foot_l"] = { Vector( -3, 0, 0 ), Angle(), 1 },
									["foot_r"] = { Vector( 3, 0, 0 ), Angle(), 1 }
								}
							}
						}
					},
				},
			},
		},
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
						Angles = Angle( 0, 90, 0 ),
						Position = Vector( -11, 120.5, 50.1 ),
						Scale = 1,
						Inputs = {
							["Emergency.SceneForward"] = {
								["ON"] = {
									Light = "W"
								}
							}
						}
					},
					{
						Inherit = "@pushbar_mpf4",
						Position = Vector( 11, 120.5, 50.1 ),
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
	{
		Category = "Side",
		Options = {
			{
				Option = "Side Lighting",
				Components = {
					{
						Name = "@pushbar_mpf4_side",
						Component = "photon_sos_mpf4",
						Angles = Angle( -13, 180+8, 1 ),
						Position = Vector( -38.7, -95, 64.2 ),
						Scale = 1,
						Inputs = {
							-- ["Emergency.SceneLeft"] = "ON[FULL=W]"
							["Emergency.SceneLeft"] = {
								["ON"] = {
									Light = "W"
								}
							}
						}
					},
					{
						Inherit = "@pushbar_mpf4_side",
						Angles = Angle( -13, -8, 0 ),
						Position = Vector( 38.7, -95, 64.2 ),
						Inputs = {
							["Emergency.SceneRight"] = {
								["ON"] = {
									Light = "W"
								}
							}
						}
					}
				}
			},
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
						Position = Vector(-11, 125, 35),
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