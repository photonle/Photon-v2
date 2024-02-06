if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Seattle Police Department - Ford Police Utility (2013) "
VEHICLE.Vehicle		= "13fpiu_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local legacyLivery = PhotonMaterial.New({
	Name = "schmal_fpiu13_seattlepd_legacy",
	Shader = "VertexLitGeneric",
	Parameters = {
	["$basetexture"] = "schmal/liveries/sgm_fpiu13/seattlepd_legacy.png",
	["$bumpmap"] = "photon/common/flat",
	["$detail"] = "photon/license/reflective_paint",
	["$detailblendmode"] = 1,
	["$detailscale"] = 64,
	["$phong"] = 1,
	["$phongfresnelranges"] = Vector( 0.1, 0.6, 0 ),
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.033, 0.066, 0.1),
	["$phongboost"] = 5,
	["$phongexponent"] = 64,
	["$nodecal"] = 1
	}
})

VEHICLE.WorkshopRequirements = {
	[2798400972] = "2013 Ford Police Interceptor Utility"
}

VEHICLE.Siren = { [1] = "motorola_spectra" }

VEHICLE.Equipment = {
	{
		Category = "Liveries",
		Options = {
			{
				Option = "Legacy (2014)",
				SubMaterials = {
					{ Id = 8, Material = legacyLivery.MaterialName }
				}
			},
		}
	},
	{
		Category = "Standard Lighting",
		Options = {
			{
				Option = "Enabled",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmfpiu13"
					}
				}
			},
		}
	},
	{
		Category = "License Plates",
		Options = {
			{
				Option = "Washington",
				Props = {
					{
						Name = "@license_plate",
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, 121, 23.7 ),
						Angles = Angle( 0, 180, 90 ),
						Scale = 1.3,
						SubMaterials = {
							[1] = "photon/license/plates/ph2_wa"
						},
					},
					{
						Inherit = "@license_plate",
						Position = Vector( 0, -124, 44.5 ),
						Angles = Angle( 0, 0, 80 ),
						Scale = 1.2,
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular"
						}
					}
				}
			},
		}
	},
	{
		Category = "Windows",
		Options = {
			{
				Option = "Override",
				Props = {
					{
						Model = "models/schmal/sgm_fpiu13_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						
					},
					-- {
					-- 	Model = "models/schmal/sgm_fpiu13_emis.mdl",
					-- 	Position = Vector( 0, 0, 0 ),
					-- 	Angles = Angle( 0, 0, 0 ),						
					-- }
				},
				SubMaterials = {
					{ Id = 7, Material = "photon/common/blank" }
				}
			},
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Setina - IMPAXX",
				Components = {
					{
						Component = "photon_setina_fpiu13",
						Position = Vector( 0, 121.3, 29.5 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 0.98,
						BodyGroups = {
							["Wrap"] = "wrap"
						}
					}
				},
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 0 }
				}
			},
			{
				Option = "No Lights",
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 1 }
				}
			},
		}
	},
	{
		Category = "Turn Signal",
		Options = {
			{
				Option = "Amber",
				BodyGroups = {
					{ BodyGroup = "turnsig", Value = 1 }
				}
			},
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Federal Signal Legend",
				Components = {
					{
						Component = "photon_fedsig_legend",
						Position = Vector( 0, -14, 85.1 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1,
						Bones = {
							["foot_right"] = { Vector(0.2, 0, 0), Angle(0, 0, 0), 1 },
							["foot_left"] = { Vector(-0.2, 0, 0), Angle(0, 0, 0), 1 },
						},
					}
				}
			}
		}
	},
	{
		Category = "Mirror Lights",
		Options = {
			{
				Option = "Whelen Ion Surface",
				Components = {
					{
						Name = "@mirror_ion",
						Component = "photon_whe_ion_surface",
						Position = Vector( -50, 35.5, 57.4 ),
						Angles = Angle( 3, 27.9, 6.5 ),
						Scale = 0.8
					},
					{
						Inherit = "@mirror_ion",
						Position = Vector( 50, 35.5, 57.4 ),
						Angles = Angle( -3, -27.9, 6.5 ),
					}
				}
			},
		}
	},
	{
		Category = "Siren Speaker",
		Options = {
			{
				Option = "Federal Signal Dynamax",
				Components = {
					{
						Component = "siren_prototype",
						Position = Vector( -14, 124, 31 ),
						Angles = Angle( 0, -90, -180 ),
						Scale = 1.7,
						Siren = 1
					}
				}
			},
		}
	},
	{
		Category = "Spotlights",
		Options = {
			{
				Option = "PAR46 LED",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -39, 38, 60 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					},
					{
						Component = "photon_whe_par46_right",
						Position = Vector( 39, 38, 60 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1.1,
					}
				},
			},
		}
	},
	{
		Category = "Antennas",
		Options = {
			{
				Option = "Normal",
				Props = {
					{
						Model = "models/sentry/antenna4.mdl",
						Position = Vector( -19.2, -54, 80.4 ),
						Angles = Angle( -4, 0, 0 ),
						Scale = 1.8,
						SubMaterials = {
							-- [0] = "photon/common/white_gloss"
						}
					},
					{
						Model = "models/sentry/antenna5.mdl",
						Position = Vector( 0, -30, 81.2 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 0.6
					},
					{
						Model = "models/sentry/antenna5.mdl",
						Position = Vector( 19.2, -54, 80.4 ),
						Angles = Angle( 3, 0, 0 ),
						Scale = 0.6
					},
					{
						Model = "models/sentry/antenna6.mdl",
						Position = Vector( 0, -70, 80.5 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 0.7
					},
					{
						Model = "models/sentry/antenna2.mdl",
						Position = Vector( 0, -87, 79.7 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 0.8
					}
				}
			}
		}
	},
}