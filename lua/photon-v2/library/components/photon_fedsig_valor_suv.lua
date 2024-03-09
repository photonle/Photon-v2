if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Model = "Twurtleee",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Valor (51")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_valor_51in.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W",
	[4] = "A",
	[5] = "A",
}

COMPONENT.Preview = {
	Position = Vector( 0, 0, -2),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1
}

local s = 1.5

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.5,
			Height		= 2.8,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0),
		},
		Rear = {
			Width 		= 5.8,
			Height		= 2.9,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		}
	},
	["Projected"] = {
		Illumination = {
			States = {
				TAKEDOWN = {
					Color = PhotonColor( 105, 105, 125 )
				},
				FLOOD = {
					Color = PhotonColor( 235, 235, 255 )
				},
				ALLEY = {
					Color = PhotonColor( 105, 105, 125 )
				}
			}
		}
	},
	["Pose"] = {
		Pose = {
			Parameter = "extend_feet"
		}
	}
}

local mult56 = 0.8

COMPONENT.ElementGroups = {
	["Group"] = { 1, 2, 3, 4 },
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 11.3, 2.3, 1.85 ), Angle( 0, -54, 0 ), Width = 7 },
	[2] = { "Primary", Vector( 11.3, -2.3, 1.85 ), Angle( 0, 180 + 54, 0 ), Width = 7 },

	[3] = { "Primary", Vector( 8.3, 6.4, 1.85 ), Angle( 0, -54, 0 ) },
	[4] = { "Primary", Vector( 8.3, -6.4, 1.85 ), Angle( 0, 180 + 54, 0 ) },

	[5] = { "Primary", Vector( 5.6, 10, 1.85 ), Angle( 0, -54, 0 ) },
	[6] = { "Primary", Vector( 5.6, -10, 1.85 ), Angle( 0, 180 + 54, 0 ) },

	[7] = { "Primary", Vector( 2.98, 13.625, 1.85 ), Angle( 0, -54, 0 ) },
	[8] = { "Primary", Vector( 2.98, -13.625, 1.85 ), Angle( 0, 180 + 54, 0 ) },

	[9] = { "Primary", Vector( 1.7, 17.87, 1.85 ), Angle( 0, -90, 0 ), Width = 5.8 },
	[10] = { "Primary", Vector( 1.7, -17.87, 1.85 ), Angle( 0, -90, 0 ), Width = 5.8 },

	[11] = { "Primary", Vector( 1.7, 22.68, 1.85 ), Angle( 0, -90, 0 ), Width = 5.8 },
	[12] = { "Primary", Vector( 1.7, -22.68, 1.85 ), Angle( 0, -90, 0 ), Width = 5.8},

	[13] = { "Primary", Vector( 0.2, 26.90, 1.85 ), Angle( 0, -49, 0 ) },
	[14] = { "Primary", Vector( 0.2, -26.90, 1.85 ), Angle( 0, 180+49, 0 ) },

	[15] = { "Primary", Vector( -3.95, 29.25, 1.85 ), Angle( 0, -11.5, 0 ), Width =6.2 },
	[16] = { "Primary", Vector( -3.95, -29.25, 1.85 ), Angle( 0, 180+11.5, 0 ), Width = 6.2 },

	[17] = { "Rear", Vector( -8.2, 26.35, 1.85 ), Angle( 0, 90, 0 ) },
	[18] = { "Rear", Vector( -8.2, -26.35, 1.85 ), Angle( 0, 90, 0 ) },

	[19] = { "Rear", Vector( -8.2, 21.55, 1.85 ), Angle( 0, 90, 0 ) },
	[20] = { "Rear", Vector( -8.2, -21.55, 1.85 ), Angle( 0, 90, 0 ) },

	[21] = { "Rear", Vector( -8.2, 16.75, 1.85 ), Angle( 0, 90, 0 ) },
	[22] = { "Rear", Vector( -8.2, -16.75, 1.85 ), Angle( 0, 90, 0 ) },

	[23] = { "Rear", Vector( -8.2, 11.95, 1.85 ), Angle( 0, 90, 0 ) },
	[24] = { "Rear", Vector( -8.2, -11.95, 1.85 ), Angle( 0, 90, 0 ) },

	[25] = { "Rear", Vector( -8.2, 7.15, 1.85 ), Angle( 0, 90, 0 ) },
	[26] = { "Rear", Vector( -8.2, -7.15, 1.85 ), Angle( 0, 90, 0 ) },

	[27] = { "Rear", Vector( -8.2, 2.35, 1.85 ), Angle( 0, 90, 0 ) },
	[28] = { "Rear", Vector( -8.2, -2.35, 1.85 ), Angle( 0, 90, 0 ) },

	[29] = { "Illumination", Vector( 11.3, 2.3, 1.85 ), Angle( 0, -90, 0 ) },
	
	-- [30] = { "Illumination", Vector( 11.3, 2.3, 1.85 ), Angle( 0, -90, 0 ) },
	-- [31] = { "Illumination", Vector( 11.3, 2.3, 1.85 ), Angle( 0, -90, 0 ) },

	[30] = { "Pose" }
}

-- COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28"

COMPONENT.StateMap = "[1/2/3]  3 5 7 9 11 13 15 [1/2/4] 21 23 25 27  [2/1/3] 2 4 6 8 10 12 14 16 [2/1/5] 22 24 26 28 [1/2/1] 17 19 [2/1/2] 18 20 [ON] 30"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1:R 2:B 3:R 4:B 5:R 6:B 7:R 8:B 9:R 10:B 11:R 12:B 13:R 14:B 15:R 16:B 17:R 18:B 19:R 20:B 21:R 22:B 23:R 24:B 25:R 26:B 27:R 28:B",
			[2] = "1 3 5 7 9 11 13 15 17 19 21 23 25 27",
			[3] = "2 4 6 8 10 12 14 16 18 20 22 24 26 28",
			[4] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28",
			[5] = "1 5 9 13 17 21 25 4 8 12 16 20 24 28",
			[6] = "2 6 10 14 18 22 26 3 7 11 15 19 23 27",
			-- [7] = "1 5 9 13 17 21 25 4 8 12 16 20 24 28"
		},
		Sequences = {
			["DEV"] = { 2, 3 },
			-- ["DEV"] = sequence():Alternate( 2, 3, 10 ),
			-- ["T"] = { 6, 5 },
			["MIX"] = { 2, 0, 2, 0, 2, 2, 2, 2, 0, 3, 0, 3, 0, 3, 3, 3, 3 },
			-- ["MIX"] = sequence():Add(2):Do(16):Add(3):Do(16)
			-- ["MI2"] = { 5, 0, 5, 0, 5, 5, 5, 5, 0, 6, 0, 6, 0, 6, 6, 6, 6 }
			-- ["MIX"] = { 5, 0, 5, 0, 5, 5, 5, 5, 0, 6, 0, 6, 0, 6, 6, 6, 6 }
		}
	},
	["Cruise"] = {
		Frames = {
			[1] = "11 13 15 17 12 14 16 18"
		},
		Sequences = {
			["CRUISE"] = { 1 }
		}
	},
	["P26_EDGE"] = {
		Frames = {
			[1] = "9 11 13 15 17 19 10 12 14 16 18 20"
		},
		Sequences = {
			["P26"] = { 1, 1, 1, 0, 0, 0, 0, 1 }
		}
	},
	["P26_FRONT"] = {
		Frames = {
			[1] = "1 2",
			[2] = "1 2 3 4",
			[3] = "1 2 3 4 5 6",
			[4] = "1 2 3 4 5 6 7 8",
			[5] = "1 2 3 4 5 6",
			[6] = "3 4 5 6",
			[7] = "5 6 7 8",
			[8] = "7 8",
		},
		Sequences = {
			["P26"] = { 1, 2, 3, 4, 5, 6, 7, 8 }
		}
	},
	["P26_REAR"] = {
		Frames = {
			[1] = "27 28",
			[2] = "27 28 25 26",
			[3] = "27 28 25 26 23 24",
			[4] = "27 28 25 26 23 24 21 22",
			[5] = "27 28 25 26 23 24",
			[6] = "25 26 23 24",
			[7] = "23 24 21 22",
			[8] = "21 22",
		},
		Sequences = {
			["P26"] = { 1, 2, 3, 4, 5, 6, 7, 8 }
		}
	},
	["P26_WOR"] = {
		Frames = {
			[0] = "[PASS] 9 11 13 15 10 12 14 16",
			[1] =    "[W] 9 11 13 15 10 12 14 16",
			[2] =  "[OFF] 9 11 13 15 10 12 14 16"
		},
		Sequences = {
			-- ["P26"] = { 1, 1, 1, 0, 0, 0, 0, 1 }

			["P26"] = { 0, 0, 0, 1, 2, 1, 2, 0 },
			-- ["ON"] = { 1 },
		}
	},
	["Demo"] = {
		Frames = {
			[1] = "[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28",
			[2] = "[2] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28",
		},
		Sequences = {
			["1"] = { 1 },
			["2"] = { 2 }
		}
	},
	["SteadyBurn"] = {
		Frames = { 
			[1] = "[1] 9 10 11 12",
			[2] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28"
		},
		Sequences = {
			["STEADY"] = { 1 },
			["FULL"] = { 2 }
		}
	},
	["Flood"] = {
		Frames = {
			[1] = "[W] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 [FLOOD] 29",
			[2] = "[W] 1 2 3 4 5 6 7 8 9 10 11 12 13 14",
		},
		Sequences = {
			["FLOOD"] = { 1 },
		}
	},
	-- Identical to flood but intended to skip illumination
	-- for performance.
	["Alert"] = {
		Frames = {
			[1] = "[W] 1 2 3 4 5 6 7 8 9 10 11 12 13 14",
		},
		Sequences = {
			["ALERT"] = { 1 },
		}
	},
	-- Takedown and flood should not be in the same segment
	-- or else the unused flood lights in takedown mode
	-- will be forcefully turned off
	["Takedown"] = {
		Frames = {
			[1] = "[W] 9 10 11 12 [TAKEDOWN] 29",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	["AlleyLeft"] = {
		Frames = { [1] = "[W] 13 15", },
		Sequences = { ["ON"] = { 1 } }
	},
	["AlleyRight"] = {
		Frames = { [1] = "[W] 14 16", },
		Sequences = { ["ON"] = { 1 } }
	},
	-- RE = Recreational Electrical, an actual outfitter.
	-- These patterns are based on their setups.
	["RE_Rear"] = {
		Frames = {
			[1] = "17 19 21 28 26 24",
			[2] = "23 25 27 22 20 18",
			[3] = "17 21 25 28 24 20",
			[4] = "19 23 27 26 22 18"
		},
		Sequences = {
			["MODE1"] = sequence():FlashHold( { 3, 4, 3, 4, }, 2, 5 ):Alternate( 1, 2, 10 ):Do( 2 ),
			["MODE2"] = sequence():FlashHold( 4, 1, 5 ):FlashHold( 3, 1, 5 )
		}
	},
	["RE_Front"] = {
		Frames = {
			[1] = "2 6 10 14 3 7 11 15",
			[2] = "16 12 8 4 1 5 9 13",
		},
		Sequences = {
			["MODE2"] = sequence():FlashHold( 1, 1, 5 ):FlashHold( 2, 1, 5 )
		}
	},
	["RE_Traffic"] = {
		Frames = {
			-- LEFT AND RIGHT
			[1] = "[3] 19 21 23 25 27",
			[2] = "[3] 21 23 25 27 28",
			[3] = "[3] 23 25 27 28 26",
			[4] = "[3] 25 27 28 26 24",
			[5] = "[3] 27 28 26 24 22",
			[6] = "[3] 28 26 24 22 20",
			[7] = "[3] 26 24 22 20 19",
			[8] = "[3] 24 22 20 19 21",
			[9] = "[3] 22 20 19 21 23",
			[10] = "[3] 20 19 21 23 25",
			-- CENTER OUT
			[11] = "[3] 23 25 27 28 26 24",
			[12] = "[3] 21 23 25 26 24 22",
			[13] = "[3] 19 21 23 24 22 20",
			[14] = "[3] 27 19 21 22 20 28",
			[15] = "[3] 25 27 19 20 28 26",

		},
		Sequences = {
			["RIGHT"] = sequence():Sequential( 1, 10 ):Stretch( 2 ),
			["LEFT"] = sequence():Sequential( 10, 1 ):Stretch( 2 ),
			["CENOUT"] = sequence():Sequential( 11, 15 ):Stretch( 3 ),
		}
	},
	-- Dedicated to the "Pursuit" pattern
	["Pursuit"] = {
		Frames = {
			[0] = "[PASS] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28",
			[1] = "1 5 9 13 17 21 25 4 8 12 16 20 24 28",
			[2] = "3 7 11 15 19 23 27 2 6 10 14 18 22 26",
			[3] = "1 3 5 7 9 11 13 15 17 19 21 23 25 27",
			[4] = "2 4 6 8 10 12 14 16 18 20 22 24 26 28"
		},
		Sequences = {
			["PURSUIT"] = sequence()
							:Alternate( 3, 4, 6 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:Alternate( 1, 2, 3 ):Do( 3 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:FlashHold( 1, 3, 2 )
							:FlashHold( 2, 3, 2 )
						}
	},
	-- Pursuit - white override
	["PursuitWO"] = {
		Frames = {
			[1] = "[W] 1 5 9 13 4 8 12 16",
			[2] = "[W] 3 7 11 15 2 6 10 14",
			[3] = "[W] 1 3 5 7 9 11 13 15",
			[4] = "[W] 2 4 6 8 10 12 14 16"
		},
		Sequences = {
			["PURSUIT"] = sequence()
							:Alternate( 4, 3, 6 ):Add( 0 )
							:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
							:Alternate( 2, 1, 3 ):Add( 0 ):Do( 3 )
							:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
							:FlashHold( 2, 3, 1 ):Add( 0 )
							:FlashHold( 1, 3, 1 ):Add( 0 )
						}
	},
	PoseTest = {
		Frames = {
			[1] = "30",
		},
		Sequences = {
			["ON"] = sequence():Alternate( 0, 1, 16 ),
		}
	},
}


COMPONENT.Patterns = {
	PATTERN26 = {
		{ "P26_EDGE", "P26" },
		{ "P26_FRONT", "P26" },
		{ "P26_REAR", "P26" },
	},
	PATTERN26W = {
		{ "P26_EDGE", "P26" },
		{ "P26_FRONT", "P26" },
		{ "P26_REAR", "P26" },
		{ "P26_WOR", "P26" },
	},
	PURSUIT = {
		{ "Pursuit", "PURSUIT" }
	},
	PURSUITW = {
		{ "PursuitWO", "PURSUIT" },
		{ "Pursuit", "PURSUIT" }
	}
}


COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = "PATTERN26",
		["MODE2"] = "PATTERN26",
		["MODE3"] = "PATTERN26W"
	},
	["Emergency.Marker"] = { ["ON"] = { Cruise = "CRUISE" } },
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ON"
		},
		["FLOOD"] = {
			Flood = "FLOOD"
		}
	},
	["Emergency.SceneLeft"] = { ["ON"] = { AlleyLeft = "ON" } },
	["Emergency.SceneRight"] = { ["ON"] = { AlleyRight = "ON" } },
}