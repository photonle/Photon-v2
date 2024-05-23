if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

-- Dedicated to the saviors of Capitol Police
-- https://www.youtube.com/watch?v=iaUAwSbEROQ 
VEHICLE.Title 		= "Virginia State Police - 2013 Ford Police Interceptor Sedan"
VEHICLE.Vehicle		= "13fpis_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.WorkshopRequirements = { 

}

VEHICLE.Description = [[]]

VEHICLE.Siren = { "motorola_spectra" }

-- I (schmal) like to use PNGs because they have a smaller file size
-- and I can quickly edit them in Photoshop with a macro. This is not
-- at all required and you can use VTF/VMT files if you prefer.
local livery = PhotonMaterial.New({
	Name = "schmal_chevcap13_va_vsp",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpis13/va_vsp.png",
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

local sequence = Photon2.SequenceBuilder.New

VEHICLE.SubMaterials = {
	-- [7] = "schmal/sgm_fpis13/lights"
	[1] = "schmal/sgm_fpis13/chrome",
	[8] = "schmal/sgm_fpis13/forward_signal",
	[9] = "schmal/sgm_fpis13/forward_signal",
}

-- VEHICLE.Livery = livery.MaterialName

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
		Category = "Default",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_standard_fpis13",
						States = {},
						Inputs = {}
					}
				},
				BodyGroups = {
					{ BodyGroup = "lightbar", Value = 1 },
					{ BodyGroup = "grillelights", Value = 1 },
					{ BodyGroup = "spotlight_l", Value = 1 },
					{ BodyGroup = "spotlight_r", Value = 1 },
					{ BodyGroup = "rearwindowlights", Value = 1 },
					{ BodyGroup = "pushbar", Value = 2}
				},
				SubMaterials = {
					{ Id = 27, Material = livery.MaterialName }
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
						Position = Vector( 0, -7.6, 71 ),
						Angles = Angle( 2, 90, 0 ),
						Scale = 0.91,
						StateMap = "[B] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
						Segments = {
							VSP = {
								Frames = {
									[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
								},
								Sequences = {
									["ON"] = { 1 },
								}
							},
						},
						Bones = {
							["foot_l"] = { Vector( 0, 0, 0), Angle( 0, 0, 0 ), 1 },
							["foot_r"] = { Vector( 0, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_l"] = { Vector( 1.4, 0, 0), Angle( 0, 0, 0 ), 1 },
							["strap_r"] = { Vector( -1.4, 0, 0), Angle( 0, 0, 0 ), 1 },
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {
									VSP = "ON"
								},
								["MODE2"] = {
									VSP = "ON"
								},
								["MODE3"] = {
									VSP = "ON"
								}
							},
							["Emergency.Directional"] = {
								["LEFT"] = { AmberTrafficFill = "LEFT" },
								["RIGHT"] = { AmberTrafficFill = "RIGHT" },
								["CENOUT"] = { AmberTrafficFill = "CENOUT" },
							}
						},
						SubMaterials = {
							-- [3] = "photon/common/blank"
						},
						BodyGroups = {
							["front_inner"] = 4,
							["front_middle"] = 0,
							["front_outer"] = 1,
							["rear_outer"] = 1,
							["rear_inner"] = 1
						},
						-- States = { "A", "A", "A", "A" }
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
							[1] = "photon/license/plates/ph2_wsp"
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
					-- models/sentry/antenna.mdl
					{
						Model = "models/sentry/antenna1.mdl",
						Position = Vector( 0, -5, 67.3 ),
						Angles = Angle( 0, 0, -8 ),
						Scale = Vector( 1, 1, 1.5)
					},
					{
						Model = "models/sentry/antenna.mdl",
						Position = Vector( 0, -38, 68.5 ),
						Angles = Angle( 0, 0, 5 ),
						Scale = 1
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna4.mdl",
						Position = Vector( 12, -45, 69.3 ),
						Angles = Angle( 3, 0, 6 ),
						Scale = 1.2
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna3.mdl",
						Position = Vector( 0, -102, 53 ),
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
						Position = Vector( 0, 3, 68),
						Angles = Angle( 2, 90, 180 ),
						Scale = 1.1
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
