if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Fort Collins Community Service Officer - 2013 Chevrolet Caprice PPV"
VEHICLE.Vehicle		= "13caprice_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

VEHICLE.Description = [[
Fort Collins Community Service Officers (CSOs) are civilian police employees who respond to traffic accidents, assist with crime scene investigation, and a perform variety of non-enforcement duties.

This is a rather fascinating vehicle, as it features an amber-only lightbar (except for takedowns) but red/white/blue lighting everywhere else. It also has a siren, although it's seemingly never used. 

Special thanks to Fort Collins Police for giving me very precise answers to some questions I couldn't figure out.
]]

-- This actually does have a siren
VEHICLE.Siren = { "whelen_epsilon" }


local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_ftc_cso",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_chevcap13/ftc_co_cso.png",
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
						Scale = 1
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
						Bones = {
							["foot_l"] = { Vector( -0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							["foot_r"] = { Vector( 0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_l"] = { Vector( 0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_r"] = { Vector( -0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						},
						BodyGroups = {
							["front_inner"] = 0,
							["front_middle"] = 2,
							["front_outer"] = 0,
						},
						States = { "A", "A", "A", "A" }
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
					{
						Component = "photon_par46_right",
						Position = Vector( 32, 27, 53 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[7] = "photon/common/red_glass",
						},
						States = {
							"~HR"
						},
						Templates = {
							Bone = {
								Shaft = { DeactivationState = "UP" },
								Lamp = { DeactivationState = "UP" },
								Handle = { DeactivationState = "UP" },
							}
						},
						Inputs = {
							-- Clear the default illumination mode
							["Emergency.SceneForward"] = { ["ON"] = {} },
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Light = "ON" },
								["MODE3"] = { Flasher = "FLASH" },
							}
						}
					}
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
						Model = "models/schmal/chevcap13_pushbar.mdl",
						Position = Vector( 0, 114, 25 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1
					}
				}
			}

		}
	},
	{
		Category = "Grille",
		Options = {
			{
				Option = "Ions",
				Components = {
					{
						Name = "@grille_ion",
						Component = "photon_whe_ion_split",
						Position = Vector( -10, 102.3, 30 ),
						Angles = Angle( 4, 8, 15 ),
						States = { "R", "B" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = "DOUBLE_FLASH_MED",
								["MODE2"] = "DOUBLE_FLASH_MED",
								["MODE3"] = "DOUBLE_FLASH_MED",
							}
						},
						Scale = 0.8,
					},
					{
						Inherit = "@grille_ion",
						Position = Vector( 10, 102.3, 30 ),
						Angles = Angle( -4, -8, 15 ),
						-- This is truly the light color configuration
						States = { "W", "R" },
					},
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
		Category = "Rear",
		Options = {
			{
				Option = "Dominator",
				Components = {
					{
						Component = "photon_whe_dominator_4",
						Position = Vector( 0, -86, 54.2 ),
						Angles = Angle( 180, 0, 0 ),
						Scale = 0.9,
						RenderGroup = RENDERGROUP_OPAQUE,
						States = { "B", "R" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = { All = "DOUBLE_FLASH_HOLD" },
								["MODE2"] = { All = "DOUBLE_FLASH_HOLD" },
								["MODE3"] = { All = "DOUBLE_FLASH_HOLD" },
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
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna6.mdl",
						Position = Vector( 0, -34, 69.7 ),
						Angles = Angle( 0, 0, 2 ),
						Scale = 1
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna3.mdl",
						Position = Vector( 0, -43, 69 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 1
					}
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
	hook.Remove( "HUDPaint", "Photon2:SGMChevCap13MatOverride" )
end)
