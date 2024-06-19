if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "U.S. Secret Service Police - 2013 Ford Police Interceptor Sedan"
VEHICLE.Vehicle		= "13fpis_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Siren = { "code3_z3" }

local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_va_vsp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpis13/usss_police.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.3, 0.3, 0.35 ),
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
		Category = "Lightbar",
		Options = {
			{
				Option = "Code 3 RX2700",
				Components = {
					{
						Component = "photon_c3_rx2700_47",
						Position = Vector( 0, -8, 74.4 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 1.17,
						Options = {
							Feet = -1,
							Mount = "classic",
							Domes = "black",
							-- To configure domes individually:
							-- Domes = { "red", "clear", "blue" }
						},
						-- SubMaterials = {
						-- 	-- [6] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[7] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[8] = "schmal/photon/code3_rx2700/black_plastic",
						-- 	[9] = "schmal/photon/code3_rx2700/black_plastic",
						-- }
					}
				}
			},
		}
	},
	{
		Category = "Default",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_fpis13",
						States = {},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {
									TailFlasher = "ALT"
								},
								["MODE3"] = {
									TailFlasher = "ALT"
								}
							},
						}
					}
				},
				Props = {
					{
						Model = "models/schmal/sgm_fpis13_glass.mdl",
						Position = Vector( 0, 0, -5 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1
					}
				},
				Bones = {
					-- { Bone = "pushbar_wrap", Position = Vector( 0, 0, 0 ), Angles = Angle( 0, 0, 0 ), Scale = 0.8 }
				},
				BodyGroups = {
					{ BodyGroup = "lightbar", Value = 1 },
					{ BodyGroup = "grillelights", Value = 1 },
					{ BodyGroup = "spotlight_l", Value = 1 },
					{ BodyGroup = "spotlight_r", Value = 1 },
					{ BodyGroup = "rearwindowlights", Value = 1 },
					{ BodyGroup = "pushbar", Value = 0 },
					{ BodyGroup = "badge", Value = 1 },
					
				},
				SubMaterials = {
					{ Id = 4, Material = "photon/common/blank" },
					{ Id = 1, Material = "schmal/sgm_fpis13/chrome" },
					{ Id = 8, Material = "schmal/sgm_fpis13/forward_signal" },
					{ Id = 9, Material = "schmal/sgm_fpis13/forward_signal" },
					{ Id = 27, Material = livery.MaterialName }
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
}