if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Seattle Police Dept. - Ford Police Utility (2013-2015)"
VEHICLE.Vehicle		= "13fpiu_sgm"
-- NOTE: "Photon 2" is a protected category!
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

local classicLivery = PhotonMaterial.New({
	Name = "schmal_fpiu13_seattlepd_legacy",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu13/seattlepd_legacy.png",
		["$bumpmap"] = "photon/common/flat",
		["$detail"] = "photon/license/reflective_paint",
		
		["$detailblendmode"] = 1,
		["$detailscale"] = 64,
		["$detailblendfactor"] = 1,

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
		["$phongalbedotint"] = 1,

		["$nodecal"] = 1
	}
})

local hybridLivery = PhotonMaterial.New({
	Name = "schmal_fpiu13_seattlepd_hybrid",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu13/seattlepd_hybrid.png",
		["$bumpmap"] = "photon/common/flat",

		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.3, 0.3, 0.4 ),
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

local newLivery = PhotonMaterial.New({
	Name = "schmal_fpiu13_seattlepd_2015",
	Shader = "VertexLitGeneric",
	Parameters = {
		["$basetexture"] = "schmal/liveries/sgm_fpiu13/seattlepd_2015.png",
		["$bumpmap"] = "photon/common/flat",
		
		["$envmap"] = "env_cubemap",
		["$envmaptint"] = Vector( 0.3, 0.3, 0.4 ),
		["$envmapfresnel"] = 1,

		["$phong"] = 1,
		["$phongboost"] = 15,
		["$phongexponent"] = 3,
		["$phongfresnelranges"] = Vector( 0.22, 0.2, 2 ),

		["$rimlight"] = 1,
		["$rimlightexponent"] = 2,
		["$rimlightboost"] = 1,
		["$rimmask"] = 1,

		-- ["$phongexponenttexture"] = "photon/common/flat_exp",
		-- ["$basemapluminancephongmask"] = 1,
		-- ["$phongalbedotint"] = 1,

		["$nodecal"] = 1
	}
})

local prototypeLivery = PhotonMaterial.New({
	Name = "schmal_fpiu13_seattlepd_prototype",
	Shader = "VertexLitGeneric",
	Parameters = {
	["$basetexture"] = "schmal/liveries/sgm_fpiu13/seattlepd_prototype.png",
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$phongfresnelranges"] = Vector( 0.1, 0.6, 0 ),
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.1, 0.1, 0.1),
	["$phongboost"] = 5,
	["$phongexponent"] = 64,
	["$nodecal"] = 1
	}
})

VEHICLE.WorkshopRequirements = {
	[2798400972] = "2013 Ford Police Interceptor Utility"
}

VEHICLE.SubMaterials = {
	[1] = "schmal/liveries/sgm_fpiu13/black_shiny"
}

VEHICLE.Siren = { [1] = "motorola_spectra" }

VEHICLE.Equipment = {
	{
		Category = "Liveries",
		Options = {
			-- {
			-- This one is a half-assed work in progress still
			-- 	Option = "Prototype",
			-- 	SubMaterials = {
			-- 		{ Id = 8, Material = prototypeLivery.MaterialName }
			-- 	},
			-- 	Components = {
			-- 		{
			-- 			Inherit = "@legend"
			-- 		}
			-- 	}
			-- },
			{
				Option = "Classic (2013)",
				SubMaterials = {
					{ Id = 8, Material = classicLivery.MaterialName }
				},
				Components = {
					{
						Name = "@legend",
						Component = "photon_fedsig_legend",
						Position = Vector( 0, -14, 85.1 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 1,
						Bones = {
							["hotfoot_right"] = { Vector(0.2, 0, 0), Angle(0, 0, 0), 1 },
							["hotfoot_left"] = { Vector(-0.2, 0, 0), Angle(0, 0, 0), 1 },
						},
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = "P20",
								["MODE3"] = "P20W"
							}
						}
					}
				}
			},
			{
				Option = "Updated (2015)",
				SubMaterials = {
					{ Id = 8, Material = hybridLivery.MaterialName }
				},
				Components = {
					{
						Inherit = "@legend",
						Name = "@legend_updated",
						Inputs = {
							["Emergency.Warning"] = {
								["MODE2"] = "P1",
								["MODE3"] = "P22W",
							}
						}
					},
					{
						Name = "@cruise_light",
						Component = "photon_sos_undercover",
						Position = Vector( -17, -14, 87.3 ),
						Angles = Angle( 1, 90, 0 ),
						Scale = 0.7,
						States = { "B" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {},
								["MODE3"] = {},
							},
						}
					},
					{
						Inherit = "@cruise_light",
						Name = "@r_cruise_light",
						Position = Vector( 17, -14, 87.3 ),
					}
				}
			},
			{
				Option = "Redesign (2016)",
				SubMaterials = {
					{ Id = 8, Material = newLivery.MaterialName }
				},
				Components = {
					{ Inherit = "@legend_updated" },
					{ Inherit = "@cruise_light" },
					{ Inherit = "@r_cruise_light" },
				},
				Props = {
					{
						Model = "models/schmal/sgm_fpiu13_spoiler.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, -90, 0 ),
						SubMaterials = {
						},
					},
				}
			},
		}
	},
	{
		Category = "Standard Lighting",
		Options = {
			{
				Option = "Enabled",
				Components = {
					{
						Component = "photon_standard_sgmfpiu13",
						Inputs = {
							["Emergency.Warning"] = {
								-- They apparently don't use headlight wig-wags
								["MODE1"] = {
									ReverseFlasher = "FLASH",
									SignalFlasher = "FLASH"
								},
								["MODE2"] = {
									ReverseFlasher = "FLASH",
									SignalFlasher = "FLASH"
								},
								["MODE3"] = {
									ReverseFlasher = "FLASH",
									SignalFlasher = "FLASH"
								}
							}
						}
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
						SubMaterials = {
							[2] = "schmal/liveries/sgm_fpiu13/seattlepd_glass"
						}
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
							-- ["Wrap"] = "wrap"
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
		Category = "Hideaways",
		Options = {
			{
				Option = "Enabled",
				Components = {
					{
						Name = "@forward_hideaway",
						Component = "photon_sos_undercover",
						Position = Vector( -35.8, 103, 40 ),
						Angles = Angle( 53, 180, 27 ),
						Scale = 0.4,
						Phase = "A",
						States = { "W", "W" },
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = {},
								["MODE3"] = { Light = "MED_ALT" },
							},
							["Emergency.Marker"] = {
								["ON"] = {}
							}
						}
					},
					{
						Phase = "B",
						Inherit = "@forward_hideaway",
						Position = Vector( 35.8, 103, 40 ),
						Angles = Angle( 180 +53, 0, 180 + 27 ),
					}
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

				}
			}
		}
	},
	{
		Category = "Cruise Lights",
		Options = {
			{
				Option = "Visible",
				Components = {

				}
			},
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
						Scale = 0.8,
						Phase = "A",
						Inputs = {
							["Emergency.Warning"] = {
								["MODE1"] = {},
								["MODE2"] = { Light = "TRI_FLASH_HOLD" },
								["MODE3"] = { Light = "TRI_FLASH_HOLD" },
							}
						}
					},
					{
						Inherit = "@mirror_ion",
						Position = Vector( 50, 35.5, 57.4 ),
						Angles = Angle( -3, -27.9, 6.5 ),
						Phase = "B",
						States = { "B" }
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
}