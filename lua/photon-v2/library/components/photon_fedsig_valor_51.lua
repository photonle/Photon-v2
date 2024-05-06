if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Twurtleee, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Valor (51")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_valor_51.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W",
	[4] = "A",
	[5] = "A",
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.9,
			Height		= 3.3,
			-- Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			VisibilityRadius = 0.5
		},
		HotFoot = {
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5,
			Height = 5/2,
			Scale = 1,
			States = {
				DW = { Inherit = "W", Intensity = 0.4 }
			},
			-- RequiredBodyGroups = {
				-- Requires HotFeet body-group
				-- [2] = 0
			-- }
		}
	}
}


-- function move( vector, angle, distance )
--     local radians = math.rad( angle )
--     local newX = vector.x + math.cos( radians ) * distance
--     local newY = vector.y + math.sin( radians ) * distance
-- 	local result = Vector( newX, newY, vector.z )
--     print( tostring( result ) )
-- 	return result
-- end

local ang = 51.1

COMPONENT.ElementGroups = {
	["Group"] = { 1, 2, 3, 4 },
	["ODD"] = { 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27 },
	["EVEN"] = { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28 },
	["FR_ODD"] = { 1, 3, 5, 7, 9, 11, 13, 15 },
	["FR_EVEN"] = { 2, 4, 6, 8, 10, 12, 14, 16 },
	["OuterL"] = { 11, 13, 15, 17 },
	["OuterR"] = { 12, 14, 16, 18 },
}


COMPONENT.Elements = {
	[1] = { "Primary", Vector( 10.39, 2.37, 1.15 ), Angle( 0, -ang, 0 ), Width = 7.6 },
	[2] = { "Primary", Vector( 10.39, -2.37, 1.15 ), Angle( 0, 180 + ang, 0 ), Width = 7.6 },
	
	[3] = { "Primary", Vector( 6.968, 6.611, 1.15 ), Angle( 0, -ang, 0 ), Width = 6 },
	[4] = { "Primary", Vector( 6.968, -6.611, 1.15 ), Angle( 0, 180 + ang, 0 ), Width = 6 },
	
	[5] = { "Primary", Vector( 3.922, 10.386, 1.15 ), Angle( 0, -ang, 0 ) },
	[6] = { "Primary", Vector( 3.922, -10.386, 1.15 ), Angle( 0, 180 + ang, 0 ) },

	[7] = { "Primary", Vector( 0.87, 14.168, 1.15 ), Angle( 0, -ang, 0 ) },
	[8] = { "Primary", Vector( 0.87, -14.168, 1.15 ), Angle( 0, 180 + ang, 0 ) },

	[9] = { "Primary", Vector( -0.65, 18.45, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	[10] = { "Primary", Vector( -0.65, -18.45, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	
	[11] = { "Primary", Vector( -0.65, 23.4, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	[12] = { "Primary", Vector( -0.65, -23.4, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },

	[13] = { "Primary", Vector( -2.45, 27.75, 1.15 ), Angle( 0, -46, 0 ), Width = 6.6 },
	[14] = { "Primary", Vector( -2.45, -27.75, 1.15 ), Angle( 0, 180 + 46, 0 ), Width = 6.6 },

	[15] = { "Primary", Vector( -7.14, 30.18, 1.15 ), Angle( 0, -10, 0 ), Width = 7.2 },
	[16] = { "Primary", Vector( -7.14, -30.18, 1.15 ), Angle( 0, 180 + 10, 0 ), Width = 7.2 },

	[17] = { "Primary", Vector( -11.98, 27.22, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[18] = { "Primary", Vector( -11.98, -27.22, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[19] = { "Primary", Vector( -11.98, 22.25, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[20] = { "Primary", Vector( -11.98, -22.25, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[21] = { "Primary", Vector( -11.98, 17.3, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[22] = { "Primary", Vector( -11.98, -17.3, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[23] = { "Primary", Vector( -11.98, 12.39, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[24] = { "Primary", Vector( -11.98, -12.39, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[25] = { "Primary", Vector( -11.98, 7.41, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[26] = { "Primary", Vector( -11.98, -7.41, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[27] = { "Primary", Vector( -11.98, 2.45, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[28] = { "Primary", Vector( -11.98, -2.45, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	-- yes... the bones are erroneously named hootfoot instead of hotfoot. It took me a very long time to realize why shit wasn't working because of it.
	[29] = { "HotFoot", Vector( 26.6, -3.48, -1.2 ), Angle( 0, 180, 0 ), BoneParent = "valor_51_hootfoot_fwd_left" },
	[30] = { "HotFoot", Vector( -26.6, -3.48, -1.2 ), Angle( 0, 180, 0 ), BoneParent = "valor_51_hootfoot_fwd_right" },

	[31] = { "HotFoot", Vector( 30.05, 5.2, -1.8 ), Angle( 0, -95, 0 ), BoneParent = "valor_51_hootfoot_alley_left", Width = 4.7 --[[oops]] },
	[32] = { "HotFoot", Vector( -30.05, 5.1, -1.8 ), Angle( 0, 180 - 85, 0 ), BoneParent = "valor_51_hootfoot_alley_right", Width = 4.7 },

	-- [3] Vector( 6.968, 6.611, 1.15 ) w=6.2
	-- [5] Vector( 3.922, 10.386, 1.15 ) w=5.9
	-- [7] Vector( 0.87, 14.168, 1.15 ) w=5.9
	-- [3] = { "Primary", move( Vector( 10.39, 2.37, 1.15 ), -ang, -15.16 ), Angle( 0, -ang, 0 ), Width = 5.9 },
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32"

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
	Command = {
		Frames = {
			[1] = "[G] 12 14 16 18 11 13 15 17"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Breakout = {
		Frames = {
			[1] = "1 5 9 13 17 21 25 28 24 20 16 12 8 4",
			[2] = "3 7 11 15 19 23 27 26 22 18 14 10 6 2",
			[3] = "1 3 9 11 15 17 19 25 27 24 22 14 8 6",
			[4] = "2 4 10 12 16 18 20 26 28 23 21 13 7 5"
		},
		Sequences = {
			["BREAKOUT"] = sequence():Alternate( 1, 2, 4 ):Do( 4 ):Alternate( 3, 4, 1 ):Do( 8 )
		}
	},
	Outer = {
		Frames = {
			[1] = "OuterL",
			[2] = "OuterR"
		},
		Sequences = {
			["ZIGZAG"] = sequence():Alternate( 1, 2, 8 )
		}
	},
	Zigzag = {
		Frames = {
			[1] = "9 7 20 22",
			[2] = "7 5 22 24",
			[3] = "5 3 24 26",
			[4] = "3 1 26 28",
			[5] = "1 2 28 27",
			[6] = "2 4 27 25",
			[7] = "4 6 25 23",
			[8] = "6 8 23 21",
			[9] = "8 10 21 19",
		},
		Sequences = {
			["ZIGZAG"] = sequence():Sequential( 1, 9 ):Sequential( 8, 2 )
		}
	},
	TwoStep = {
		Frames = {
			[1] = "1 5 9 13 17 21 25 28 24 20 16 12 8 4",
			[2] = "3 7 11 15 19 23 27 26 22 18 14 10 6 2",
			[3] = "3 1 2 4 13 11 12 14 17 19 25 27 28 26 20 18",
			[4] = "9 7 5 6 8 10 15 16 21 23 24 22"
		},
		Sequences = {
			["TWOSTEP"] = sequence():Alternate( 1, 2, 4 ):Do( 4 ):Add( 0, 3, 3, 0, 3, 3, 0, 4, 4, 0, 4, 4 )
		}
	},
	Sequence = {
		Frames = {
			[1] = "1 3 5 7 9 11 13 15 17 19 21 23 25 27",
			[2] = "2 4 6 8 10 12 14 16 18 20 22 24 26 28",

			[3] = "1 3 5 7 23 25 27 2 4 6 8 24 26 28",
			[4] = "9 11 13 15 17 19 21 10 12 14 16 18 20 22",

			[5] = "1 3 5 7 23 25 27 10 12 14 16 18 20 22",
			[6] = "2 4 6 8 24 26 28 9 11 13 15 17 19 21"
		},
		Sequences = {
			["SEQUENCE"] = sequence():Alternate( 2, 1, 10 ):Do( 2 ):Add( 0, 3, 3, 0, 3, 3, 0, 3, 3, 0, 4, 4, 0, 4, 4, 0, 4, 4 ):Do( 2 ):Alternate( 5, 6, 10 ):Do( 2 ),
		}
	},
	Revolution = {
		Frames = {
			[1] = "15 17 19 21 14 12 10 8",
			[2] = "17 19 21 23 12 10 8 6",
			[3] = "19 21 23 25 10 8 6 4",
			[4] = "21 23 25 27 8 6 4 2",
			[5] = "23 25 27 28 6 4 2 1",
			[6] = "25 27 28 26 4 2 1 3",
			[7] = "27 28 26 24 2 1 3 5",
			[8] = "28 26 24 22 1 3 5 7",
			[9] = "26 24 22 20 3 5 7 9",
			[10] = "24 22 20 18 5 7 9 11",
			[11] = "22 20 18 16 7 9 11 13",
			[12] = "20 18 16 14 9 11 13 15",
			[13] = "18 16 14 12 11 13 15 17",
			[14] = "16 14 12 10 13 15 17 19",
			[15] = "14 12 10 8 15 17 19 21",
			[16] = "12 10 8 6 17 19 21 23",
			[17] = "10 8 6 4 19 21 23 25",
			[18] = "8 6 4 2 21 23 25 27",
			[19] = "6 4 2 1 23 25 27 28",
			[20] = "4 2 1 3 25 27 28 26",
			[21] = "2 1 3 5 27 28 26 24",
			[22] = "1 3 5 7 28 26 24 22",
			[23] = "3 5 7 9 26 24 22 20",
			[24] = "5 7 9 11 24 22 20 18",
			[25] = "7 9 11 13 22 20 18 16",
		},
		Sequences = {
			["REVOLUTION"] = sequence():Sequential( 1, 25 ):Sequential( 24, 2 )
		}
	},
	Checkered = {
		Frames = {
			[1] = "1 3 9 11 13 19 21 28 26 24 18 16 8 6",
			[2] = "2 4 10 12 14 20 22 27 25 23 17 15 7 5",
		},
		Sequences = {
			["CHECKERED"] = sequence():Add(1):Do(8):Add(0):Add(2):Do(8):Add(0),
		}
	},
	ColorBurst = {
		Frames = {
			[1] = "ODD",
			[2] = "EVEN"
		},
		Sequences = {
			-- ["COLORBURST"] = sequence():Alternate( 1, 2, 2 ):Do( 4 ):FlashHold( { 1, 2 }, 3, 4 ):Do( 2 ):ToClipboard(),
			["COLORBURST"] = { 
				1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 
				1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 
				2, 0, 2, 0, 2, 0, 2, 2, 2, 2, 0, 
				1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 
				2, 0, 2, 0, 2, 0, 2, 2, 2, 2, 0 
			}
		}
	},
	ColorBurstW = {
		Frames = {
			[0] = "[PASS] ODD EVEN",
			[1] = "[W] FR_ODD",
			[2] = "[W] FR_EVEN",
			[3] = "[W] 1 3 9 11",
			[4] = "[W] 5 7 13 15",
			[5] = "[W] 2 4 10 12",
			[6] = "[W] 6 8 14 16"
		},
		Sequences = {
			["COLORBURST"] = {
				6, 3, 3, 5, 5, 4, 4, 6, 6, 3, 3, 5, 5, 4, 4, 6,
				-- 0, 3, 0, 5, 0, 4, 0, 6, 0, 3, 0, 5, 0, 4, 0, 6,
				0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 
				0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 
				0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 
				0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 
			},
		}
	},
	Storm = {
		Frames = {
			[1] = "1 3 5 7 9 11 13 15 17 19 21 23 25 27",
			[2] = "2 4 6 8 10 12 14 16 18 20 22 24 26 28",

			[3] = "1 3 5 7 23 25 27 2 4 6 8 24 26 28",
			[4] = "9 11 13 15 17 19 21 10 12 14 16 18 20 22",

			[5] = "1 3 5 7 23 25 27 10 12 14 16 18 20 22",
			[6] = "2 4 6 8 24 26 28 9 11 13 15 17 19 21"
		},
		Sequences = {
			
		}
	}
}


COMPONENT.Patterns = {
	PATTERN26 = {
		{ "P26_EDGE", "P26" },
		{ "P26_FRONT", "P26" },
		{ "P26_REAR", "P26" },
	},
	-- ("Sweep" is the new FS Convergence Network name for Pattern 26)
	SWEEP = {
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
	SWEEPW = {
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
	},
	BREAKOUT = {
		{ "Breakout", "BREAKOUT" }
	},
	ZIGZAG = {
		{ "Outer", "ZIGZAG" },
		{ "Zigzag", "ZIGZAG" },
	},
	TWOSTEP = { { "TwoStep", "TWOSTEP" } },
	SEQUENCE = { { "Sequence", "SEQUENCE" } },
	REVOLUTION = { { "Revolution", "REVOLUTION" } },
	CHECKERED = { { "Checkered", "CHECKERED" } },
	COLORBURST = { { "ColorBurst", "COLORBURST" } },
	COLORBURSTW = { 
		{ "ColorBurst", "COLORBURST" },
		{ "ColorBurstW", "COLORBURST" },
	},
}

COMPONENT.InputPriorities = {
	["Emergency.Command"] = 41
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
	["Emergency.Command"] = {
		["ON"] = {
			Command = "ON"
		}
	}
}