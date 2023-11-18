if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Ford Crown Victoria 2010"
VEHICLE.Vehicle		= "lvs_sgm_cvpi"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Vehicle2 = {
	Class = "lvs_wheeldrive_cvpi"
}

VEHICLE.Equipment = {
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Federal Signal Vision SLR",
				Components = {
					{
						Component = "photon_fedsig_visionslr",
						Position = Vector( 0, -19, 69.2 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1,
						Bones = {
							["hook_mount_foot_lf"] = { Vector( -0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_rf"] = { Vector( 0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_lr"] = { Vector( -0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
							["hook_mount_foot_rr"] = { Vector( 0.2, 0, 0.7 ), Angle( 0, 0, 0 ), 1 },
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
					},
				}
				
			}

		}
	}
}