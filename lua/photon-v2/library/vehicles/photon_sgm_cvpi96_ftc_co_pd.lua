if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Fort Collins Police Department - Ford Crown Victoria (1996)"
VEHICLE.Vehicle		= "96cvpi_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local fcpd = PhotonDynamicMaterial.Generate("schmal_cvpi96_fcpd", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sgm_cvpi96/ftc_co_pd.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[6] = fcpd.Name,
}

VEHICLE.Selections = {
	{
		Category = "Lighting",
		Options = {
			{
				Option = "Default",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmcvpi96",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1
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
						}
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
				Props = {
					{
						Model = "models/sentry/props/spotlight_left_up.mdl",
						Position = Vector( -36, 28, 50 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[5] = "sentry/shared/env_cubemap_model"
						}
					},
					{
						Model = "models/sentry/props/spotlight_right_up.mdl",
						Position = Vector( 36, 28, 50 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[5] = "sentry/shared/env_cubemap_model",
							[7] = "photon/common/red_glass",
						}
					},
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
						Position = Vector( 0, -17, 66.8 ),
						Angles = Angle( 0, 180, 0 ),
						Scale = 1.14
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
	}
}