if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "U.S. Capitol Police - Ford Police Interceptor (2020)"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonMaterial.New({
	Name = "schmal_fpiu20_uscp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu20/uscp.png",
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

local usGovPlate = PhotonMaterial.New({
	Name = "schmal_us_gov",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "photon/license/plates/usgov.png"
	}
})

VEHICLE.Siren = { "whelen_epsilon" }

VEHICLE.Livery = livery.MaterialName

VEHICLE.Equipment = {
	{
		Category = "Controller Sound",
		Options = {
			{
				Option = "Whelen",
				InteractionSounds = {
					{ Class = "Controller", Profile = "whelen_cencom" }
				}
			}
		}
	},
	{
		Category = "Rims",
		Options = {
			{
				Option = "Silver",
				BodyGroups = {
					{ BodyGroup = "hubcaps", Value = 0 }
				}
			}
		}
	},
	{
		Category = "Fog Lights",
		Options = {
			{
				Option = "Enabled",
				BodyGroups = {
					{ BodyGroup = "foglights", Value = 1 }
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
							-- [1] = "",
							-- [1] = usGovPlate.MaterialName
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
						Angles = Angle(0, 0, 0),
						SubMaterials = {
							[1] = "schmal/sgm_fpiu20/uscp_glass"
						}
					}
				},
			}
		}
	},
	{
		Category = "Grille",
		Options = {
			{
				Option = "mPower",
				Components = {
					{
						Component = "photon_sos_mpf4",
						Position = Vector( -11, 114.8, 48.7 ),
						Angles = Angle( -10, 90+8, 0 ),
						Scale = 0.9,
						Flags = {
						}
					},
					{
						Component = "photon_sos_mpf4",
						Position = Vector( 11, 114.8, 48.7 ),
						Angles = Angle( -10, 90-8, 0 ),
						Scale = 0.9,
						Flags = {
						}
					},
				}
			}
		}
	},
	{
		Category = "Mirror",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Component = "photon_whe_ion_surface",
						Position = Vector( -51.47, 32.5, 62.3 ),
						Angles = Angle( 1, 30, 0 ),
						Scale = 0.7,
						SubMaterials = {
							[0] = "sentry/20fpiu_new/black"
						}
					},
					{
						Component = "photon_whe_ion_surface",
						Position = Vector( 51.47, 32.5, 62.3 ),
						Angles = Angle( -1, -30, 0 ),
						Scale = 0.7,
						SubMaterials = {
							[0] = "sentry/20fpiu_new/black"
						}
					}
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
				},
				SubMaterials = {
					{ Id = 3, Material = "photon/common/blank" },
					-- { Id = 1, Material = "photon/common/blank" },
				}
			}
		}
	},
	{
		Category = "Hide-aways",
		Options = {
			{
				Option = "Option",
				Components = {
					{
						Component = "photon_sos_mpf4",
						Position = Vector( -41.4, 88.4, 51.9 ),
						Angles = Angle( -10, 165, 2 ),
						Scale = 0.9,
					},
					{
						Component = "photon_sos_mpf3",
						Position = Vector( -39.6, 94.3, 51.7 ),
						Angles = Angle( -10, 157, 2 ),
						Scale = 0.9,
					},
					{
						Component = "photon_sos_mpf4",
						Position = Vector( 41.4, 88.4, 51.9 ),
						Angles = Angle( -10, 180 - 165, -2 ),
						Scale = 0.9,
					},
					{
						Component = "photon_sos_mpf3",
						Position = Vector( 39.6, 94.3, 51.7 ),
						Angles = Angle( -10, 180 - 157, -2 ),
						Scale = 0.9,
					}
				}
			},
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
					}
				},
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
						Model = "models/sentry/props/whelensa315p_mounta.mdl",
						Position = Vector(-11, 113, 39.5),
						Angles = Angle(0, 0, 10),
						Scale = 1,
						-- Siren = "fedsig_smartsiren"
						Siren = 1
					},
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Legacy (48\")",
				Components = {
					{
						Component = "photon_whe_legacy_48",
						Position = Vector( 0, -15, 87.7 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1.02,
						Bones = {
							[11] = { Vector( 1, 0, 0 ), Angle( 0, 0, 0 ) },
							[10] = { Vector( -1, 0, 0 ), Angle( 0, 0, 0 ) },
						},
					}
				},
			},
		}
	},
	{
		Category = "Side Lighting",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( -33.8, -77, 75.4 ),
						Angles = Angle( 178, 90, 0 ),
						Scale = 0.8
					},
					{
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( 33.8, -77, 75.4 ),
						Angles = Angle( 182, -90, 0 ),
						Scale = 0.8
					}
				}
			},
		}
	},
	{
		Category = "Rear Inner",
		Options = {
			{
				Option = "Ion",
				Components = {
					{
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( -8, -107, 76.2 ),
						Angles = Angle( 180, 180, 0 ),
						Scale = 0.8
					},
					{
						Component = "photon_whe_ion_surface_bracket",
						Position = Vector( 8, -107, 76.2 ),
						Angles = Angle( 180, 180, 0 ),
						Scale = 0.8
					}
				}
			},
		}
	},
	{
		Category = "Antennas",
		Options = {
			{
				Option = "Antennas",
				Props = {
					{
						Model = "models/sentry/antenna.mdl",
						Position = Vector( 0, -35, 86 ),
						Angles = Angle( 0, 0, 3 ),
						Scale = 1.2
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna9.mdl",
						Position = Vector( -13, -50, 86.5 ),
						Angles = Angle( 0, 0, 3 ),
						Scale = 1.4
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna1.mdl",
						Position = Vector( 13, -50, 96.8 ),
						Angles = Angle( 0, 0, 3 ),
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna4.mdl",
						Position = Vector( 25, 9, 84.1 ),
						Angles = Angle( 8, 0, -12 ),
					},
					{
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( 0, 9, 83.9 ),
						Angles = Angle( 0, 0, -12 ),
						Scale = 0.8
					}
				}
			},
		}
	},
}