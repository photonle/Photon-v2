if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Larimer County Sheriff's Office - 2015 Dodge Charger PPV"
-- VEHICLE.Vehicle		= "fake"
VEHICLE.Vehicle		= "15charger_fm2_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local livery = PhotonMaterial.New({
	Name = "schmal_char15_lcso",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_char15/lar_co_so.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.5, 0.5, 0.5 ),
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

VEHICLE.SubMaterials = {
	
}

VEHICLE.Siren = { "fedsig_pathfinder_ssp" }

VEHICLE.Equipment = {
	-- {
	-- 	Category = "HUD",
	-- 	Options = {
	-- 		{
	-- 			Option = "HUD",
	-- 			Components = {
	-- 				{
	-- 					Component = "photon_hud_default"
	-- 				}
	-- 			}
	-- 		}
	-- 	}		
	-- },
	{
		Category = "Standard",
		Options = {
			{
				Option = "Option",
				Components = {
					{
						Component = "photon_standard_sgmchar15"
					}
				},
				Props = {
					{
						Model = "models/schmal/sgm_char15_glass.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						BodyGroups = {
							["cage"] = 1
						}
					}
				},
				BodyGroups = {
					["wheels_front"] = 3,
					["wheels_rear"] = 3,
					["badge"] = 1
				},
				SubMaterials = {
					{ Id = 2, Material = "photon/common/blank" }
				}
			},
		}
	},
	{
		Category = "Lightbar",
		Options = {
			{
				Option = "Integrity 44\"",
				Components = {
					{
						Name = "@integrity",
						Component = "photon_fedsig_integrity_44",
						Position = Vector( 0, -18, 74.8 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						-- Bones = {
						-- 	["44_strap_left"] = { Vector( 0.7, 0, 0 ), Angle( 10, 0, 0 ), 1 },
						-- 	["44_strap_right"] = { Vector( -0.7, 0, 0 ), Angle( -10, 0, 0 ), 1 },
						-- },
						Options = {
							HotFeet = false,
							Straps = { 0, 9, 1.2 }
						},
					}
				},
			},
			{
				Option = "Valor 44\" (ALPR)",
				Components = {
					{
						Name = "@valor",
						Component = "photon_fedsig_valor_44",
						Position = Vector( 0, -18, 76 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1,
						Options = {
							ForwardHotFeet = false,
							AlleyHotFeet = false,
							Feet = 0.5,
						},
						
					}
				},
				-- This will eventually be replaced
				Props = {
					{
						Model = "models/cefr/paolo/lapd/new_equip/alpr.mdl",
						Position = Vector( 0, -21.6, 74.8 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1.3,
						RenderGroup = RENDERGROUP_OPAQUE,
						SubMaterials = {
							[0] = "schmal/misc/lb_alpr"
						}
					}
				}
			},

			{
				Option = "Valor 44\"",
				Components = {
					{
						Inherit = "@valor",
						Position = Vector( 0, -18, 75.2 ),
						Options = {
							Feet = 1.5
						}
					}
				},

			},

		}
	},

	{
		Category = "Siren",
		Options = {
			{
				Option = "PathFinder SSP",
				Components = {
					{
						-- Model = "models/sentry/props/whelensa315p_mounta.mdl",
						Name = "@siren",
						Component = "siren_prototype",
						Position = Vector(-11, 125, 27.1),
						Angles = Angle(1.5, -90, 180),
						Scale = 1.2,
						Siren = "fedsig_pathfinder_ssp"
					},
				}
			},
			{
				Option = "PathFinder Unitrol",
				Components = {
					{
						Inherit = "@siren",
						Siren = "fedsig_pathfinder_unitrol"
					}
				}
			}
		}
	},
	{
		Category = "Livery",
		Options = {
			{
				Option = "LCSO",
				SubMaterials = {
					{ Id = 4, Material = livery.MaterialName }
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
						Position = Vector( 0, -126.8, 30 ),
						Angles = Angle( 0, 0, 81 ),
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
						Angles = Angle( 0, 180, 90 ),
						Position = Vector( 0, 118.9, 23 ),
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
		Category = "Spotlight",
		Options = {
			{
				Option = "Whelen PAR46",
				Components = {
					{
						Component = "photon_whe_par46_left",
						Position = Vector( -34.5, 28, 58 ),
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
						Model = "models/anemolis/props/antennas/anemolis_antenna9.mdl",
						Position = Vector( 0, -105, 57.5 ),
						Angles = Angle( 0, 0, 4 ),
						Scale = 1.6
					},
					{
						Model = "models/anemolis/props/antennas/anemolis_antenna4.mdl",
						Position = Vector( 0, -47, 74 ),
						Angles = Angle( 0, 0, 9 ),
						Scale = 1.2
					},
					{
						Model = "models/cefr/paolo/lapd/new_equip/antenna_4.mdl",
						Position = Vector( 10, -35, 73.4 ),
						Angles = Angle( 0, 0, 4.5 ),
						Scale = 1
					}
				}
			},
		}
	},
	{
		Category = "Rear Lighting",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Name = "@rear_lplight",
						Component = "photon_sos_mpf4",
						Position = Vector( -11.2, -126.4, 28.4 ),
						Angles = Angle( -7, -95, 0 ),
						Scale = 1,
						Options = {
							Marker = false
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = "DUO_FLASH",
								["MODE2"] = "DUO_FLASH",
								["MODE3"] = "DUO_FLASH",
							},
							["Vehicle.Brake"] = {
								["BRAKE"] = "R"
							},
							["Vehicle.Transmission"] = {
								["REVERSE"] = "W"
							}
						}
					},
					{
						Inherit = "@rear_lplight",
						Position = Vector( 11.2, -126.4, 28.4 ),
						Angles = Angle( -7, -85, 0 ),
						Phase = 90
					},
					
				}
			},
		}
	},
	{
		Category = "Pushbar",
		Options = {
			{
				Option = "Wrap w/ Impaxx",
				Components = {
					{
						Component = "photon_char15_pushbar",
						Position = Vector( 0, 111, 28.5 ),
						Angles = Angle( 0, -90, 0 )
					}
				},
				BodyGroups = {
					{ BodyGroup = "pushbar", Value = 0 }
				}
			},
		}
	},
	{
		Category = "Interior Equipment",
		Options = {
			{
				Option = "Default",
				Components = {
					{
						Component = "photon_fedsig_scsb",
						Position = Vector( 0, 6, 28 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1
					},
					{
						Component = "photon_sos_observe",
						Position = Vector( 0, -5, 71.5 ),
						Angles = Angle( 11, 90, 180 ),
						Scale = 1.1
					},
					{
						Component = "photon_pan_toughbookcf30",
						Position = Vector( 6, 10, 45 ),
						Angles = Angle( 0, 50, 0 ),
						Scale = 1,
						Options = {
							Pole = 2,
							Base = -30,
							-- You can change the screen material by using this option:
							-- Screen = "schmal/toughbook_cf30/laptop_screen_darkmode",
						}
					}
				},
				Props = {
					{
						Model = "models/cefr/paolo/lapd/new_equip/console.mdl",
						RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( 0, 10, 24 ),
						Angles = Angle( 0, -90, 0 ),
						Scale = 1.2,
						BodyGroups = {
							["FS Controller"] = 1,
							["Clavier"] = 1
						}
					},
					{
						Model = "models/tdmcars/emergency/equipment/partition.mdl",
						RenderGroup = RENDERGROUP_OPAQUE,
						Position = Vector( 0, -18, 11 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = Vector( 1, 0.95, 1.1 ),
						SubMaterials = {
							-- This looks very marginally less terrible than buggy glass layering
							[4] = "photon/common/tint_30"
						}
					},
					-- {
					-- 	Model = "models/paolo/props/support_mdt_1.mdl",
					-- 	Position = Vector( 9, -4, 24 ),
					-- 	Angles = Angle( 0, -90, 0 ),
					-- 	Scale = 0.8
					-- }
				}
			},
		}
	},
}