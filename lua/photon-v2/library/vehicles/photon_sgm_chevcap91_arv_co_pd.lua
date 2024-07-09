if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Arvada Police - Chevrolet Caprice (1991)"
VEHICLE.Vehicle		= "91caprice_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

-- i have no idea what siren this thing actually used
VEHICLE.Siren = { "whelen_ws295mp" }


local livery = PhotonMaterial.New({
	Name = "schmal_chevcap91_arv_co_pd",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_chevcap91/arvada_pd.png",
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
}

VEHICLE.Equipment = {
	{
		Category = "Core",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_hud_default"
					},
					{
						Component = "photon_standard_chevcap91"
					}
				},
				InteractionSounds = {
					{ Class = "Controller", Profile = "click" }
				},
				SubMaterials = {
					{ Id = 20, Material = livery.MaterialName }
				}
			}
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Whelen Edge 9000",
				Components = {
					{
						Component = "photon_whe_edge",
						Position = Vector( 0, -20, 58.6 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1,
						SubMaterials = {
							-- [2] = "photon/common/blank"
							[2] = "schmal/photon/sgm_whelen_edge/lens_rba"
						}
					}
				}
				
			},
		}
	},
	{
		Category = "Spotlight",
		Options = {
			{
				Option = "Spotlight",
				Components = {
					{
						Component = "photon_par46_left",
						Position = Vector( -37.5, 30, 42 ),
						Angles = Angle( 0, 0, 0 ),
						Scale = 1,
						SubMaterials = {
							[5] = "sentry/shared/env_cubemap_model"
						}
					},
				}
				
			},
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
						Position = Vector( 0, 113, 10 ),
						Angles = Angle(),
						Scale = 1
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
						Position = Vector( 0, -122.9, 25 ),
						Angles = Angle( 0, 0, 87 ),
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
						Position = Vector( 0, 115, 12 ),
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
		Category = "Siren",
		Options = {
			{
				Option = "Siren Prototype",
				Components = {
					{
						Component = "siren_prototype",
						Position = Vector(-6, 100.7, 20),
						Angles = Angle(0, -90, 0),
						Scale = 1.3,
						Siren = 1
					},
				}
			}
		}
	}
}
