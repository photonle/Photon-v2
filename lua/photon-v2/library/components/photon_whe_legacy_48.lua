if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "OfficerFive0",
	Code = "Schmal"
}

COMPONENT.Title = [[Whelen Legacy (48")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/whelen_legacy_48.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1
}

local priW = 3.1
local priH = priW / 2

local tirW = 3.16
local tirH = tirW / 2

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 	= priW,
			Height	= priH,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/legacy_module_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/legacy_module_detail.png").MaterialName,
			Scale = 0.9,
			ForwardVisibilityOffset = 0,
			VisibilityRadius = 0.6,
			IntensityGainFactor = 3,
			IntensityLossFactor = 3,
		},
		TIR3 = {
			Width 	= tirW,
			Height	= tirH,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/legacy_tir3_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/legacy_tir3_shape.png").MaterialName,
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_detail.png").MaterialName,
			Scale = 2,
			ForwardVisibilityOffset = 0,
			VisibilityRadius = 0.6
		}
	},
	["Projected"] = {
		Illumination = {
			Material = "photon/flashlight/led_linear.png",
			NearZ = 100,
			FOV = 50,
			Brightness = 3
		}
	}
}


COMPONENT.Elements = {
	[1] = { "Primary", Vector( 6.85, 5.67, 0.22 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 6.85, -5.67, 0.22 ), Angle( 0, -90, 0 ) },

	[3] = { "Primary", Vector( 6.85, 8.74, 0.22 ), Angle( 0, -90, 0 ) },
	[4] = { "Primary", Vector( 6.85, -8.74, 0.22 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 6.85, 11.95, 0.22 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 6.85, -11.95, 0.22 ), Angle( 0, -90, 0 ) },
	
	[7] = { "Primary", Vector( 6.85, 15.02, 0.22 ), Angle( 0, -90, 0 ) },
	[8] = { "Primary", Vector( 6.85, -15.02, 0.22 ), Angle( 0, -90, 0 ) },
	
	[9] = { "Primary", Vector( 6.85, 18.25, 0.22 ), Angle( 0, -90, 0 ) },
	[10] = { "Primary", Vector( 6.85, -18.25, 0.22 ), Angle( 0, -90, 0 ) },

	[11] = { "Primary", Vector( 6.85, 21.32, 0.22 ), Angle( 0, -90, 0 ) },
	[12] = { "Primary", Vector( 6.85, -21.32, 0.22 ), Angle( 0, -90, 0 ) },

	[13] = { "Primary", Vector( 6.85, 24.6, 0.22 ), Angle( 0, -90, 0 ) },
	[14] = { "Primary", Vector( 6.85, -24.6, 0.22 ), Angle( 0, -90, 0 ) },
	
	[15] = { "Primary", Vector( 5.72, 27.18, 0.22 ), Angle( 0, -90 + 47.5, 0 ) },
	[16] = { "Primary", Vector( 5.72, -27.18, 0.22 ), Angle( 0, -90 - 47.5, 0 ) },
	
	[17] = { "Primary", Vector( 3.3, 29.4, 0.22 ), Angle( 0, -90 + 47.5, 0 ), Width = 3.5 },
	[18] = { "Primary", Vector( 3.3, -29.4, 0.22 ), Angle( 0, -90 - 47.5, 0 ), Width = 3.5 },

	[19] = { "Primary", Vector( -3.3, 29.4, 0.22 ), Angle( 0, 90 - 47.5, 0 ), Width = 3.5 },
	[20] = { "Primary", Vector( -3.3, -29.4, 0.22 ), Angle( 0, 90 + 47.5, 0 ), Width = 3.5 },

	[21] = { "Primary", Vector( -5.72, 27.18, 0.22 ), Angle( 0, 90 - 47.5, 0 ) },
	[22] = { "Primary", Vector( -5.72, -27.18, 0.22 ), Angle( 0, 90 + 47.5, 0 ) },

	[23] = { "Primary", Vector( -6.85, 24.6, 0.22 ), Angle( 0, 90, 0 ) },
	[24] = { "Primary", Vector( -6.85, -24.6, 0.22 ), Angle( 0, 90, 0 ) },

	[25] = { "Primary", Vector( -6.85, 21.32, 0.22 ), Angle( 0, 90, 0 ) },
	[26] = { "Primary", Vector( -6.85, -21.32, 0.22 ), Angle( 0, 90, 0 ) },

	[27] = { "Primary", Vector( -6.85, 18.25, 0.22 ), Angle( 0, 90, 0 ) },
	[28] = { "Primary", Vector( -6.85, -18.25, 0.22 ), Angle( 0, 90, 0 ) },

	[29] = { "Primary", Vector( -6.85, 15.02, 0.22 ), Angle( 0, 90, 0 ) },
	[30] = { "Primary", Vector( -6.85, -15.02, 0.22 ), Angle( 0, 90, 0 ) },

	[31] = { "Primary", Vector( -6.85, 11.95, 0.22 ), Angle( 0, 90, 0 ) },
	[32] = { "Primary", Vector( -6.85, -11.95, 0.22 ), Angle( 0, 90, 0 ) },

	[33] = { "Primary", Vector( -6.85, 8.74, 0.22 ), Angle( 0, 90, 0 ) },
	[34] = { "Primary", Vector( -6.85, -8.74, 0.22 ), Angle( 0, 90, 0 ) },

	[35] = { "Primary", Vector( -6.85, 5.67, 0.22 ), Angle( 0, 90, 0 ) },
	[36] = { "Primary", Vector( -6.85, -5.67, 0.22 ), Angle( 0, 90, 0 ) },

	[37] = { "Primary", Vector( -6.85, 2.31, 0.22 ), Angle( 0, 90, 0 ) },
	[38] = { "Primary", Vector( -6.85, -2.31, 0.22 ), Angle( 0, 90, 0 ) },

	[39] = { "TIR3", Vector( 6.85, 2.31, 0.23 ), Angle( 0, -90, 0 ) },
	[40] = { "TIR3", Vector( 6.85, -2.34, 0.23 ), Angle( 0, -90, 0 ) },

	[41] = { "TIR3", Vector( 0, 30.75, 0.23 ), Angle( 0, 0, 0 ) },
	[42] = { "TIR3", Vector( 0, -30.75, 0.23 ), Angle( 0, 180, 0 ) },

	[43] = { "Illumination", Vector( 7.5, 0, 0.23 ), Angle( 5, -90, 0 ), },
	[44] = { "Illumination", Vector( 7.5, 0, 0.23 ), Angle( 2, -90, 0 ), FOV = 90, Brightness = 1.5, Material = "photon/flashlight/wide.png" },

	[45] = { "Illumination", Vector( 0, 31, 0.23 ), Angle( 0, 0, 0 ), FOV = 90, Brightness = 1.5},
	[46] = { "Illumination", Vector( 0, -31, 0.23 ), Angle( 5, 180, 0 ), FOV = 90, Brightness = 1.5 },
}


COMPONENT.ElementStates = {
	["2D"] = {
		["~TA"] = {
			Inherit = "A",
			IntensityTransitions = true,
			IntensityGainFactor = 5,
			IntensityLossFactor = 5,
		}
	},
	["Bone"] = {
		[1] = {
			Inherit = "B",
			SuppressInheritanceFailure = true
		}
	}
}

COMPONENT.ElementGroups = {
	["@01"] = { 1, 3 },
	["@02"] = { 2, 4 },
	["@03"] = { 5, 7 },
	["@04"] = { 6, 8 },
	["@05"] = { 9, 11 },
	["@06"] = { 10, 12 },
	["@07"] = { 13, 15, 17 },
	["@08"] = { 14, 16, 18 },
	["@09"] = { 19, 21, 23 },
	["@10"] = { 20, 22, 24 },
	["@11"] = { 25, 27 },
	["@12"] = { 26, 28 },
	["@13"] = { 29, 31 },
	["@14"] = { 30, 32 },
	["@15"] = { 33, 35 },
	["@16"] = { 34, 36 },
	["@17"] = { 37 },
	["@18"] = { 38 },
	["Takedown"] = { 39, 40 },
	["Left"] = { 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37 },
	["Left_Front"] = { 1, 3, 5, 7, 9, 11, 13, 15, 17 },
	["Left_Rear"] = { 19, 21, 23, 25, 27, 29, 31, 33, 35, 37 },
	["Left_Corner"] = { 13, 15, 17, 19, 21, 23 },
	["Left_Alley"] = { 41 },
	["Right"] = { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38 },
	["Right_Front"] = { 2, 4, 6, 8, 10, 12, 14, 16, 18 },
	["Right_Rear"] = { 20, 22, 24, 26, 28, 30, 32, 34, 36, 38 },
	["Right_Alley"] = { 42 },
	["Right_Corner"] = { 14, 16, 18, 20, 22, 24 },
}

COMPONENT.StateMap = "[1/2] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 [1/2] 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 [W] 39 40 41 42"

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42",
			[2] = "[1] Left_Front [2] Right_Rear",
			[3] = "[2] Right_Front [1] Left_Rear",
			[4] = "[1] Left_Front Left_Rear [2] Right_Front Right_Rear",

		},
		Sequences = {
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 2, 3, 2 ),
			["BLINK"] = sequence():Alternate( 4, 0, 4 ),
			-- ["ALT"] = sequence():Alternate( 4, 5, 12 )
		}
	},
	Cut = {
		Frames = {
			[1] = "[OFF] Left_Front Right_Front",			
		},
		Sequences = {
			["FRONT"] = { 1 },
		}
	},
	Cut_Front = {
		Frames = {
			[1] = "[OFF] Left_Front Right_Front 39 40 43 44"
		},
		Sequences = {
			["ENABLED"] = { 1 }
		}
	},
	Cut_Rear = {
		Frames = {
			[1] = "[OFF] Left_Rear Right_Rear"
		},
		Sequences = {
			["ENABLED"] = { 1 }
		}
	},
	DVI = {
		Off = "~OFF",
		Frames = {
			[1] = "[~1] @01 @03 @05 @07 @09 @11 @13 @15 @17",
			[2] = "[~2] @02 @04 @06 @08 @10 @12 @14 @16 @18",

			[3] = "[~1] @01 @03 @13 @15 @17 [~2] @02 @04 @14 @16 @18",
			[4] = "[~1] @05 @07 @09 @11 [~2] @06 @08 @10 @12",

			[5] = "[~1] @01 @05 @09 @13 @17 [~2] @04 @08 @12 @16",
			[6] = "[~1] @03 @07 @11 @15 [~2] @02 @06 @10 @14 @18",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 01, 02, 12 ),
			["CEN"] = sequence():Alternate( 03, 04, 12 ),
			["MIX"] = sequence():Alternate( 05, 06, 12 ),
		}
	},
	DVI_Marker = {
		Frames = {
			[0] = "[~1*0.5] Left [~2*0.5] Right",
			[1] = "[~1] @01 @03 @13 @15 @17 [~2] @02 @04 @14 @16 @18",
			[2] = "[~1] @05 @07 @09 @11 [~2] @06 @08 @10 @12",
		},
		Sequences = {
			["CEN"] = sequence():Alternate( 1, 2, 12 ),
		}
	},
	Full = {
		Frames = {
			[1] = "[1] Left_Front [2] Right_Rear",
			[2] = "[2] Right_Front [1] Left_Rear",

			[3] = "[1] @01 @03 @13 @15 @17 [2] @02 @04 @14 @16 @18",
			[4] = "[1] @05 @07 @09 @11 [2] @06 @08 @10 @12",

			[5] = "[1] @01 @05 @09 @13 @17 [2] @04 @08 @12 @16",
			[6] = "[1] @03 @07 @11 @15 [2] @02 @06 @10 @14 @18",

			[7] = "[1] Left [2] Right",

			[8] = "[1] @01 @03 @05 @09 [2] @08 @18 @16 @14 @12",
			[9] = "[2] @02 @04 @06 @10 [1] @11 @13 @15 @17 @07"
		},
		Sequences = {
			["SCAN"] = sequence()
				:FlashHold( { 5, 6 }, 2, 4 ):Do( 2 ):Gap()
				:Alternate( 3, 4, 9 ):Do( 2 ):Gap()
				:FlashHold( 7, 3, 6 ):Gap( 6 ):FlashHold( 7, 3, 6 ):Gap( 6 )
				:Alternate( 1, 2, 9 ):Do( 2 ):Gap(),
			["SCAN_FAST"] = sequence()
				:FlashHold( { 5, 6 }, 2, 2 ):Do( 2 ):Gap()
				:Alternate( 3, 4, 4 ):Do( 2 ):Gap()
				:FlashHold( 7, 3, 4 ):Gap( 3 ):FlashHold( 7, 3, 4 ):Gap( 3 )
				:Alternate( 1, 2, 4 ):Do( 2 ):Gap(),
			["STEADYBURN"] = { 7 },
			["YELP"] = { 7, 7, 7, 0, 0, 7, 7, 7, 0, 0 },
			["WAIL"] = sequence():Add( 1, 1, 0, 2, 2, 0 ):SetVariableTiming( 1/32, 1/12, 0.66 ),
			["ALERT"] = { 7, 7, 0 },
			["PIER"] = { 7, 0 },
			["TIMING"] = sequence():Alternate( 1, 2 ):SetVariableTiming( 1/24, 1/4, 1 ),
			["HORN"] = { 7 },
			["T4"] = sequence():FlashHold( { 1, 2 }, 3, 4 ),
			-- Based on USCP patterns
			["QUAD"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_MODIFIED"] = sequence():QuadFlash( 8, 9 ),
			["TRIP_MODIFIED"] = sequence():TripleFlash( 8, 9 ),
		}
	},
	Takedown = {
		Frames = {
			[1] = "[W] 39",
			[2] = "[W] 40",
			[3] = "[W] 39 40 43",
		},
		Sequences = {
			["OFF"] = { 0 },
			["ON"] = { 3 },
			["ALT"] = sequence():Alternate( 1, 2, 8 ),
			["TRI_FLASH"] = sequence():TripleFlash( 2, 1 ),
		}
	},
	Flood = {
		Frames = {
			[1] = "[W] Left_Front Right_Front 39 40 44"
		},
		Sequences = {
			["FLOOD"] = { 1 },
		}
	},
	Flood_Left = {
		Frames = {
			[1] = "[W] 41 @07 @09 45"
		},
		Sequences = {
			["FULL"] = { 1 },
		}
	},
	Flood_Right = {
		Frames = {
			[1] = "[W] 42 @08 @10 46"
		},
		Sequences = {
			["FULL"] = { 1 },
		}
	},
	Alley_Left = {
		Frames = {
			[1] = "[W] 41",
		},
		Sequences = {
			["OFF"] = { 0 },
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 0, 1, 8 )
		}
	},
	Alley_Right = {
		Frames = {
			[1] = "[W] 42",
		},
		Sequences = {
			["OFF"] = { 0 },
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 0, 1, 8 )
		}
	},
	Left = {
		Frames = {
			[1] = "[1] Left_Front Left_Rear"
		},
		Sequences = {
			["FLASH"] = sequence():Alternate( 1, 0, 16 )
		}
	},
	Right = {
		Frames = {
			[1] = "[2] Right_Front Right_Rear"
		},
		Sequences = {
			["FLASH"] = sequence():Alternate( 1, 0, 16 )
		}
	},
	White = {
		Off = "PASS",
		-- FrameDuration = 1/24,
		Frames = {
			[1] = "[W] @01 @05 @04 @08 @09",
			[2] = "[W] @02 @06 @03 @07 @10",
			[3] = "[W] @01 @08 @09",
			[4] = "[W] @03 @06",
			[5] = "[W] @04 @05",
			[6] = "[W] @02 @07 @10",
			[7] = "[W] Left_Front @10",
			[8] = "[W] Right_Front @09",
			[9] = "[W] @07 @05 @02 @04 @10",
			[10] = "[W] @05 @03 @04 @06",
			[11] = "[W] @03 @01 @06 @08 @09",
			[12] = "[W] Left_Front @10 Right_Front @09",
			[13] = "[W] @09 @07 @05 @02 @04",
			[14] = "[W] @01 @03 @05 @07 @09 @02 @04 @06 @08 @10",
			[15] = "[W] @03 @01 @06 @08 @10",
			[16] = "[W] @07 @09 @08 @10 @01 @02",
			[17] = "[W] @07 @05 @06 @08",
			[18] = "[W] @05 @03 @04 @06",
			[19] = "[W] @03 @01 @02 @04",
		},
		Sequences = {
			["FLASH"] = sequence()
							:Add( 9, 9, 0, 10, 10, 0, 11, 11, 0, 10, 10, 0 ):Do( 4 )
							:FlashHold( { 1, 2 }, 3, 4 ):Do( 2 )
							:Add( 9, 9, 0, 10, 10, 0, 11, 11, 0, 10, 10, 0 ):Do( 4 )
							:Alternate( 7, 8, 10 ):Do( 2 ),
			["YELP"] = sequence():Add( 1, 1, 1, 0, 0, 2, 2, 2, 0, 0 ),
			["WAIL"] = sequence():Add( 8, 8, 0, 7, 7, 0 ):SetVariableTiming( 1/32, 1/12, 0.66 ),
			["PIER"] = sequence():Add( 16, 17, 18, 19 ),
			-- ["PIER"] = sequence():Add( 13, 0, 13, 0, 14, 0, 15, 0, 15, 0, 14, 0 ),
			["ALERT"] = sequence():Add( 0, 12 ),
			["T4"] = sequence():FlashHold( { 8, 7 }, 3, 4 ),
			["HORN"] = { 12 }
		}
	},
	Traffic_DVI = {
		Off = "~OFF",
		Frames = {
			-- [0] = "[~R] @11 @13 @15 @17 [~B] @18 @16 @14 @12",
			[1] = "[~TA] @12",
			[2] = "[~TA] @12 @14",
			[3] = "[~TA] @12 @14 @16",
			[4] = "[~TA] @12 @14 @16 @18 @17",
			[5] = "[~TA] @12 @14 @16 @18 @17 @15",
			[6] = "[~TA] @12 @14 @16 @18 @17 @15 @13",
			[7] = "[~TA] @12 @14 @16 @18 @17 @13 @15 @11",
			[8] = "[~TA] @14 @16 @18 @17 @13 @15 @11",
			[9] = "[~TA] @16 @18 @17 @13 @15 @11",
			[10] = "[~TA] @18 @17 @15 @13 @11",
			[11] = "[~TA] @15 @13 @11",
			[12] = "[~TA] @13 @11",
			[13] = "[~TA] @11",
			[14] = "[~TA] @17 @18",
			[15] = "[~TA] @15 @17 @18 @16",
			[16] = "[~TA] @13 @15 @17 @18 @16 @14",
			[17] = "[~TA] @11 @13 @15 @17 @18 @16 @14 @12",
			[18] = "[~TA] @11 @13 @15 @16 @14 @12",
			[19] = "[~TA] @11 @13 @14 @12",
			[20] = "[~TA] @11 @12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 13 ):Add( 0, 13, 0, 13, 0 ):StretchAll( 4 ),
			["RIGHT"] = sequence():Sequential( 13, 1 ):Add( 0, 1, 0, 1, 0 ):StretchAll( 4 ),
			["CENOUT"] = sequence():Sequential( 14, 20 ):Add( 0, 20, 0, 20, 0 ):StretchAll( 6 )
		}
	},
	Traffic = {
		Frames = {
			-- [0] = "[~R] @11 @13 @15 @17 [~B] @18 @16 @14 @12",
			[1] = "[A] @12",
			[2] = "[A] @12 @14",
			[3] = "[A] @12 @14 @16",
			[4] = "[A] @12 @14 @16 @18 @17",
			[5] = "[A] @12 @14 @16 @18 @17 @15",
			[6] = "[A] @12 @14 @16 @18 @17 @15 @13",
			[7] = "[A] @12 @14 @16 @18 @17 @13 @15 @11",
			[8] = "[A] @14 @16 @18 @17 @13 @15 @11",
			[9] = "[A] @16 @18 @17 @13 @15 @11",
			[10] = "[A] @18 @17 @15 @13 @11",
			[11] = "[A] @15 @13 @11",
			[12] = "[A] @13 @11",
			[13] = "[A] @11",
			[14] = "[A] @17 @18",
			[15] = "[A] @15 @17 @18 @16",
			[16] = "[A] @13 @15 @17 @18 @16 @14",
			[17] = "[A] @11 @13 @15 @17 @18 @16 @14 @12",
			[18] = "[A] @11 @13 @15 @16 @14 @12",
			[19] = "[A] @11 @13 @14 @12",
			[20] = "[A] @11 @12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 13 ):Add( 0, 13, 0, 13, 0 ):StretchAll( 3 ),
			["RIGHT"] = sequence():Sequential( 13, 1 ):Add( 0, 1, 0, 1, 0 ):StretchAll( 3 ),
			["CENOUT"] = sequence():Sequential( 14, 20 ):Add( 0, 20, 0, 20, 0 ):StretchAll( 4 )
		}
	},
	Brake = {
		Frames = {
			[1] = "[1] @11 @13 @15 @17 [2] @18 @16 @14 @12"
		},
		Sequences = {
			BRAKE = sequence():Add( 1, 0, 1, 0, 1 ):SetRepeating( false )
		}
	},
	Test = {
		Frames = {
			[1] = "[~(1,1)B*0.5] @01 @02 @03 @04",
			[2] = "[~(1,1)B*0.9] @01 @02 @03 @04",
			[3] = "[B] @01 @02 @03 @04 @05 @06 @07 @08 @09",
			[4] = "[G] @01 @02 @03 @04 @05 @06 @07 @08 @09",
		},
		Sequences = {
			["TEST"] = sequence():Alternate( 1, 2 ):SetTiming( 1 ),
			["PHASE"] = sequence():Alternate( 3, 4, 16 ),
			["PHASE:A"] = sequence():Alternate( 3, 4, 16 ),
		}
	},
	Marker = {
		Frames = {
			[1] = "[1*0.6] @07 @09 [2*0.6] @08 @10",
			[2] = "[1*0.6] @01 @03 @05 @07 @09 @11 @13 @15 @17 [2*0.6] @02 @04 @06 @08 @10 @12 @14 @16 @18",
		},
		Sequences = {
			["CORNER"] = { 1 },
			["FULL"] = { 2 }
		}
	}
}


COMPONENT.Patterns = {
	["DVI/ALT"] = { { "DVI", "ALT" } },
	["DVI/CEN"] = { { "DVI", "CEN" } },
	["DVI/MIX"] = { { "DVI", "MIX" } },
	["DVI/REAR_ALT"] = { 
		{ "DVI", "ALT" },
		{ "Cut", "FRONT" }
	},
	["DVI/REAR_MIX"] = { 
		{ "DVI", "MIX" },
		{ "Cut", "FRONT" }
	},
	["SCAN"] = { { "Full", "SCAN" } },
	["PHASETEST"] = {
		{ "Left", "FLASH:180" },
		{ "Right", "FLASH" },
	},
	["CLEAR"] = {
		{ "Full", "SCAN_FAST" },
		{ "White", "FLASH" },
		{ "Takedown", "ALT" },
		{ "Alley_Left", "ALT" },
		{ "Alley_Right", "ALT" }
	},
	["WAIL"] = {
		{ "Full", "WAIL" },
		{ "White", "WAIL" }
	},
	["YELP"] = {
		{ "Full", "YELP" },
		{ "White", "YELP" }
	},
	["PIER"] = {
		{ "Full", "PIER" },
		{ "White", "PIER" }
	},
	["ALERT"] = {
		{ "Full", "ALERT" },
		{ "White", "ALERT" },
	},
	["T4"] = {
		{ "Full", "T4" },
		{ "White", "T4" }
	}
}

COMPONENT.InputPriorities = {
	["Virtual.WarningSiren"] = 63,
	["Virtual.Brake"] = 101,
	["Virtual.ParkedWarning"] = 64,
	["Virtual.NightParkedWarning"] = 65,
}

COMPONENT.VirtualOutputs = {
	["Virtual.WarningSiren"] = {
		{
			Mode = "AIR",
			Conditions = {
				["Emergency.Warning"] = { "MODE3" },
				["Emergency.SirenOverride"] = { "AIR", "MAN" }
			}
		},
		{
			Mode = "T1",
			Conditions = {
				["Emergency.Warning"] = { "MODE3" },
				["Emergency.Siren"] = { "T1" }
			}
		},
		{
			Mode = "T2",
			Conditions = {
				["Emergency.Warning"] = { "MODE3" },
				["Emergency.Siren"] = { "T2" }
			}
		},
		{
			Mode = "T3",
			Conditions = {
				["Emergency.Warning"] = { "MODE3" },
				["Emergency.Siren"] = { "T3" }
			}
		},
		{
			Mode = "T4",
			Conditions = {
				["Emergency.Warning"] = { "MODE3" },
				["Emergency.Siren"] = { "T4" }
			}
		},
	},
	["Virtual.Brake"] = {
		{
			Mode = "BRAKE",
			Conditions = {
				["Vehicle.Brake"] = { "BRAKE" },
				["Emergency.Warning"] = { "MODE1", "MODE2", "MODE3" }
			}
		}
	},
	["Virtual.ParkedWarning"] = {
		{
			Mode = "MODE3",
			Conditions = {
				["Vehicle.Transmission"] = { "PARK" },
				["Emergency.Warning"] = { "MODE3" }
			}
		}
	},
	["Virtual.NightParkedWarning"] = {
		{
			Mode = "MODE3",
			Conditions = {
				["Vehicle.Transmission"] = { "PARK" },
				["Emergency.Warning"] = { "MODE3" },
				["Vehicle.Ambient"] = { "DARK" }
			}
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		-- ["MODE1"] = { ["DVI_Marker"] = "CEN" },
		["MODE1"] = "DVI/REAR_ALT",
		["MODE2"] = "SCAN",
		["MODE3"] = "CLEAR",
	},
	["Virtual.WarningSiren"] = {
		["T1"] = "WAIL",
		["T2"] = "YELP",
		["T3"] = "PIER",
		["T4"] = "T4",
		["AIR"] = "ALERT",
	},
	["Emergency.SirenOverride"] = {
		["AIR"] = { White = "HORN" },
		["MAN"] = { Full = "STEADYBURN" }
	},
	["Emergency.SceneForward"] = {
		["ON"] = { Takedown = "ON" },
		["FLOOD"] = { Flood = "FLOOD" }
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { Flood_Left = "FULL" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { Flood_Right = "FULL" }
	},
	["Emergency.Directional"] = {
		["LEFT"] = { Traffic = "LEFT" },
		["RIGHT"] = { Traffic = "RIGHT" },
		["CENOUT"] = { Traffic = "CENOUT" }
	},
	["Emergency.Marker"] = {
		["ON"] = { Marker = "CORNER" }
	},
	["Virtual.Brake"] = {
		["BRAKE"] = { Brake = "BRAKE" }
	},
	["Emergency.Cut"] = {
		["FRONT"] = { Cut_Front = "ENABLED" },
		["REAR"] = { Cut_Rear = "ENABLED" }
	},
	["Virtual.ParkedWarning"] = {
		["MODE3"] = { 
			DVI_Marker = "CEN",
			Takedown = "OFF",
			Alley_Left = "OFF",
			Alley_Right = "OFF"
		},
	},
	["Virtual.NightParkedWarning"] = {
		["MODE3"] = { 
			DVI_Marker = "CEN",
			Takedown = "OFF",
			Alley_Left = "OFF",
			Alley_Right = "OFF"
		},
	}
}