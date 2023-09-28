if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Las Vegas Metropolitan Police - Ford Police Interceptor (2016)"
VEHICLE.Vehicle		= "sm16fpiu"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonDynamicMaterial.Generate("schmal_fpiu16_lvmpd", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sm_fpiu16/lvmpd.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[15] = livery.Name,
	[5] = "photon/common/blank",
	[28] = "photon/common/blank",
}

VEHICLE.Selections = {
	{
		Category = "Windows",
		Options = {
			{
				Option = "LVMPD",
				Props = {
					{
						Model = "models/schmal/sm_fpiu16_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						SubMaterials = {
							[1] = "schmal/liveries/sm_fpiu16/lvmpd_modulate",
							[2] = "schmal/liveries/sm_fpiu16/lvmpd_glass",
							-- [1] = "photon/commmon/blank",
							-- [0] = "photon/commmon/blank",
							-- [2] = "photon/commmon/blank",
							-- [3] = "photon/commmon/blank",
							-- [4] = "photon/commmon/blank",
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
				Option = "Federal Signal Vision SLR",
				Components = {
					{
						Component = "photon_fedsig_visionslr",
						Position = Vector( 0, -15, 87.4 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1.08,
						Bones = {
							["feet_left"] = { Vector( -0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["feet_right"] = { Vector( 0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
						},
						SubMaterials = {
							["schmal/photon/fedsig_visionslr/lens_pod_1"] = "schmal/photon/fedsig_visionslr/lens_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_1_glass"] = "schmal/photon/fedsig_visionslr/glass_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_2"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_2_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_3"] = "schmal/photon/fedsig_visionslr/lens_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_3_glass"] = "schmal/photon/fedsig_visionslr/glass_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_4"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_4_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_5"] = "schmal/photon/fedsig_visionslr/lens_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_5_glass"] = "schmal/photon/fedsig_visionslr/glass_color_blue",
							["schmal/photon/fedsig_visionslr/lens_pod_6"] = "schmal/photon/fedsig_visionslr/lens_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_6_glass"] = "schmal/photon/fedsig_visionslr/glass_color_clear",
							["schmal/photon/fedsig_visionslr/lens_pod_7"] = "schmal/photon/fedsig_visionslr/lens_color_red",
							["schmal/photon/fedsig_visionslr/lens_pod_7_glass"] = "schmal/photon/fedsig_visionslr/glass_color_red",
						}
					}
				}
			}
		}
	},
	{
		Category = "Spotlights",
		Options = {
			{
				Option = "Decorative (Body Group)",
				BodyGroups = {
					{ BodyGroup = "Spotlights", Value = 1 }
				}
			}
		}
	},
	{
		Category = "Push Bar",
		Options = {
			{
				Option = "Setina Push Bar",
				BodyGroups = {
					{ BodyGroup = "Pushbar", Value = 1 }
				}
			}
		}
	},
	{
		Category = "Misc",
		Options = {
			{
				Option = "Default",
				BodyGroups = {
					{ BodyGroup = "Bobblehead", Value = 6 }
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
						Position = Vector(-11, 123, 34.4),
						Angles = Angle(1.5, -90, -180),
						Scale = 1.4,
					}
				}
			}
		}
	}
}