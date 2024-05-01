if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Fort Collins Police Department - Ford Crown Victoria (1996)"
VEHICLE.Vehicle		= "96cvpi_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = {
	[218869210] = "SGM Shared Textures",
	[2861441761] = "1996 Ford Crown Victoria P71"
}

local livery = PhotonMaterial.New({
	Name = "schmal_cvpi96_fcpd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_cvpi96/ftc_co_pd.png",
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

VEHICLE.Schema = {
	["Emergency.Warning"] = {
		{ Label = "PRIMARY" },
		{ Mode = "MODE1", Label = "STAGE 1" },
		{ Mode = "MODE2", Label = "STAGE 2" },
		{ Mode = "MODE3", Label = "STAGE 3" },
	}
}

VEHICLE.Siren = { "motorola_spectra" }

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
		Category = "Livery",
		Options = {
			{
				Option = "Fort Collins Police Department",
				SubMaterials = {
					{ Id = 6, Material = livery.MaterialName }
				}
			},
			{
				Option = "None",
				SubMaterials = {
					{ Id = 6, Material = nil }
				}
			}
		}
	},
	{
		Category = "Lighting",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_sgmcvpi96",
					}
				}
			}
		}
	},
	{
		Category = "Hubcaps",
		Options = {
			{
				Option = "Silver",
				BodyGroups = {
					{ BodyGroup = "hubcaps_fl", Value = 0 },
					{ BodyGroup = "hubcaps_fr", Value = 1 },
					{ BodyGroup = "hubcaps_rl", Value = 1 },
					{ BodyGroup = "hubcaps_rr", Value = 1 },
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
						Position = Vector( 0, -125.4, 31.7 ),
						Angles = Angle( 0, 0, 89 ),
						Scale = 1.13,
						SubMaterials = {
							[1] = "photon/license/plates/ftc_muni"
						},
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular"
						},
					},
					{
						Inherit = "@rear_plate",
						Angles = Angle( 0, 180, 90 ),
						Position = Vector( 0, 123, 19 ),
						SubMaterials = {
							[1] = "photon/license/plates/ftc_muni_fr"
						},
						BodyGroups = {
							["screws_top"] = 1,
							["screws_bottom"] = 1,
							["face"] = "face_circular",
							["mount"] = "mount"
						}
					},
					-- {
					-- 	Model = "models/license/na_license_plate.mdl",
					-- 	Angles = Angle( 0, 0, 90 ),
					-- 	Position = Vector( 20, -10, 0 ),
					-- 	SubMaterials = {
					-- 		[1] = "photon/license/plates/ftc_muni_fr"
					-- 	},
					-- 	BodyGroups = {
					-- 		["screws_top"] = 1,
					-- 		["screws_bottom"] = 1,
					-- 		["face"] = "face_circular",
					-- 		["mount"] = "mount"
					-- 	},
					-- 	FollowBone = "door_fl"
					-- },
				},
			}
		}
	},
	{
		Category = "Antennas",
		Options = {
			{ -- models/sentry/antenna3.mdl
			Option = "Antennas",
				Props = {
					{
						Model = "models/sentry/antenna3.mdl",
						Scale = 1,
						Position = Vector( 0, -110, 45.8 ),
						Angles = Angle( 0, 0, 5 )
					},
					{
						Model = "models/sentry/antenna.mdl",
						Scale = 1,
						Position = Vector( 0, -40, 68.4 ),
						Angles = Angle( 0, 0, 4 )
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
						Component = "photon_par46_left",
						Position = Vector( -36, 28, 50 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[5] = "sentry/shared/env_cubemap_model"
						}
					},
					{
						Component = "photon_par46_right",
						Position = Vector( 36, 28, 50 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[5] = "sentry/shared/env_cubemap_model",
							[7] = "photon/common/red_glass",
						},
						-- StateMap = "[~HR] 1",
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
								["MODE1"] = { Light = "ON" },
								["MODE2"] = { Light = "ON" },
								["MODE3"] = { Light = "ON" },
							}
						}
					}
				},
				Props = {
					-- {
					-- 	Model = "models/sentry/props/spotlight_right_up.mdl",
					-- 	Position = Vector( 36, 28, 50 ),
					-- 	Angles = Angle( 0, 0, 0 ),
					-- 	Scale = 1,
					-- 	SubMaterials = {
					-- 		[5] = "sentry/shared/env_cubemap_model",
					-- 		[7] = "photon/common/red_glass",
					-- 	}
					-- },
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Code 3 MX7000",
				Components = {
					{
						Component = "photon_c3_mx7000",
						Position = Vector( 0, -17, 66.9 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1.14,
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									ArrowStik = "WARN",
									-- RotatorLeftOuter = "ON",
									-- RotatorRightOuter = "ON",
									-- RotatorCenter = "ON",
									-- RotatorLeftInner = "ON",
									-- RotatorRightInner = "ON",
								}
							}
						}
					}
				}
			}
		}
	},
	{
		Category = "Push Bar",
		Options = {
			{
				Option = "Push Bar",
				Props = {
					{
						Model = "models/schmal/pushbar_cvpi96.mdl",
						Position = Vector( 0, 121, 16 ),
						Angles = Angle(),
						Scale = 1.1
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
						Position = Vector(-11, 110, 25),
						Angles = Angle(1.5, -90, 0),
						Scale = 1.4,
						Siren = 1
					},
				}
			}
		}
	}
}