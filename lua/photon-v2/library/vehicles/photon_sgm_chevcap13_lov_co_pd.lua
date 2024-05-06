if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Loveland Police Department - 2013 Chevrolet Caprice PPV"
VEHICLE.Vehicle		= "13caprice_sgm"
-- NOTE: You should change this category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

VEHICLE.Description = [[]]

-- This actually does have a siren
VEHICLE.Siren = { "whelen_epsilon" }



local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_lov_pd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_chevcap13/lov_co_pd.png",
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
	[15] = "photon/common/blank"
}

VEHICLE.Equipment = {
	{
		Category = "Livery",
		Options = {
			{
				Option = "Modern",
				SubMaterials = {
					{ Id = 13, Material = livery.MaterialName }
				}
			}
		}
	},
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
							[0] = "schmal/chevcap13/police_modulate"
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
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									TailLightFlasher = "FLASH_ALT",
									ReverseFlasher = "FLASH_ALT",
									-- They do actually mix a halogen and LED flasher and it does look odd
									TailLightLEDFlasher = "ALT",
								},
								["MODE2"] = {
									TailLightFlasher = "FLASH_ALT",
									ReverseFlasher = "FLASH_ALT",
									-- They do actually mix a halogen and LED flasher and it does look odd
									TailLightLEDFlasher = "ALT",
								},
								["MODE3"] = {
									TailLightFlasher = "FLASH_ALT",
									ReverseFlasher = "FLASH_ALT",
									-- They do actually mix a halogen and LED flasher and it does look odd
									TailLightLEDFlasher = "ALT",
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
						Component = "photon_whe_libertyii_48",
						Position = Vector( 0, -19.2, 71 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 0.96,
						Bones = {
							-- ["foot_l"] = { Vector( -0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							-- ["foot_r"] = { Vector( 0.2, 0, 0), Angle( 0, 0, 0 ), 1 },
							-- ["strap_l"] = { Vector( 0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
							-- ["strap_r"] = { Vector( -0.3, 0, 0), Angle( 0, 0, 0 ), 1 },
						},
						Segments = {

						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						},
						BodyGroups = {

						},
						Inputs = {

						}
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
						Name = "@spotlight",
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
						Scale = 1,
						BodyGroups = {
							wrap = 1
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
				Option = "Ions",
				Components = {
					{
						Name = "@grille_ion",
						Component = "photon_whe_ion_split_surface",
						Position = Vector( -42, 25.8, 47.7 ),
						Angles = Angle( 2, 29, 5 ),
						States = { "R", "W" },
						SubMaterials = {
							[0] = "sentry/13caprice/black"
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = "QUINT_FLASH",
								["MODE3"] = "QUINT_FLASH",
							}
						},
						Scale = 0.8,
					},
					{
						Inherit = "@grille_ion",
						Position = Vector( 42, 25.8, 47.7 ),
						Angles = Angle( -2, -29, 5 ),
						States = { "W", "B" },
						Phase = 45
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
