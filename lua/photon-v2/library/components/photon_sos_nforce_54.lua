if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = [[SoundOff Signal nForce (54")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/sentry/props/nforce_suv.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 1
}

local domeParameters = { 
	Shader = "VertexLitGeneric",
	["$basetexture"] 			= "sentry/props/nforce/top",
	["$bumpmap"] 				= "sentry/props/nforce/top_nm",
	["$phong"] 					= 1,
	["$phongexponent"] 			= 7,
	["$phongboost"] 			= 1,
	["$phongfresnelranges"] 	= Vector( 0.05, 0.3, 1 ),
	["$rimlight"]        		= 1,
	["$rimlightexponent"]   	= 17,
	["$rimlightboost"]   		= 1.2,
	["$blendtintbybasealpha"] 	= 1,
	["$color2"] 				= Vector( 0.14, 0.14, 0.14 )
}

local Domes = {
	Black = PhotonMaterial.GenerateWithTemplate( "ph2_sos_nforce_dome_blk", domeParameters, { ["$color2"] = Vector( 0.15, 0.15, 0.15 )} ).Name,
	Blue = PhotonMaterial.GenerateWithTemplate( "ph2_sos_nforce_dome_blu", domeParameters, { ["$color2"] = Vector( 0.18, 0.27, 0.64 )} ).Name,
	Amber = PhotonMaterial.GenerateWithTemplate( "ph2_sos_nforce_dome_amb", domeParameters, { ["$color2"] = Vector( 0.84, 0.49, 0.05 )} ).Name,
	Red = PhotonMaterial.GenerateWithTemplate( "ph2_sos_nforce_dome_red", domeParameters, { ["$color2"] = Vector( 0.64, 0.15, 0.0 )} ).Name,
	White = PhotonMaterial.GenerateWithTemplate( "ph2_sos_nforce_dome_whi", domeParameters, { ["$color2"] = Vector( 0.74, 0.74, 0.74 )} ).Name
}

COMPONENT.SubMaterials = {
	-- [1] = "photon/common/blank",
	-- [2] = "photon/common/blank",
	-- [6] = "photon/common/blank",
	[3] = Domes.Black,
	[4] = Domes.Black,
	[8] = Domes.Black,
	[10] = "photon/common/matte_dark",
}

COMPONENT.ElementStates = {
	["2D"] = {
		["B0.5"] = {
			Inherit = "B",
			Intensity = 0.75
		}
	}
}

local s = 1.2

COMPONENT.Templates = {
	["2D"] = {
		Main = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_detail.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 2.4,
			Scale = 2.5,
			ForwardVisibilityOffset = -0.1,
			-- ForwardBloomOffset = 0.5,
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		},
		Corner3 = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_detail.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 1,

			Scale = 1,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.5
		}
	},
	["Projected"] = {
		Illumination = {
			Material = "photon/flashlight/led_linear.png",
			NearZ = 100,
			FOV = 50,
			Brightness = 1.5
		}
	}
}

-- COMPONENT.StateMap = "[B] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26"

COMPONENT.StateMap = "[1/2/W] 1 2 4 6 8 10 12 14 16 18 [1/2/A] 20 22 24 26 [2/1/W] 3 5 7 9 11 13 15 17 19 [2/1/A] 21 23 25"

COMPONENT.Elements = {
	[1] = { "Main", Vector( 0, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	-- [1] = { "Main", Vector( 0, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[2] = { "Main", Vector( -7.7, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[3] = { "Main", Vector( 7.7, 6.6, -0.2 ), Angle( 0, 0, 0 ) },

	[4] = { "Main", Vector( -15.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[5] = { "Main", Vector( 15.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },

	[6] = { "Main", Vector( -22.5, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[7] = { "Main", Vector( 22.5, 6.6, -0.2 ), Angle( 0, 0, 0 ) },

	[8] = { "Corner3", Vector( -27.75, 6.1, -0.2 ), Angle( 0, 16, 0 ) },
	[9] = { "Corner3", Vector( 27.75, 6.1, -0.2 ), Angle( 0, -16, 0 ) },

	[10] = { "Corner3", Vector( -30.13, 4.75, -0.2 ), Angle( 0, 43, 0 ) },
	[11] = { "Corner3", Vector( 30.13, 4.75, -0.2 ), Angle( 0, -43, 0 ) },

	[12] = { "Corner3", Vector( -31.49, 2.43, -0.2 ), Angle( 0, 77, 0 ) },
	[13] = { "Corner3", Vector( 31.49, 2.43, -0.2 ), Angle( 0, -77, 0 ) },

	[14] = { "Corner3", Vector( -31.49, -2.43, -0.2 ), Angle( 0, 180-77, 0 ) },
	[15] = { "Corner3", Vector( 31.49, -2.43, -0.2 ), Angle( 0, 180+77, 0 ) },

	[16] = { "Corner3", Vector( -30.13, -4.75, -0.2 ), Angle( 0, 180-43, 0 ) },
	[17] = { "Corner3", Vector( 30.13, -4.75, -0.2 ), Angle( 0, 180+43, 0 ) },

	[18] = { "Corner3", Vector( -27.75, -6.1, -0.2 ), Angle( 0, 180-16, 0 ) },
	[19] = { "Corner3", Vector( 27.75, -6.1, -0.2 ), Angle( 0, 180+16, 0 ) },

	[20] = { "Main", Vector( -22.5, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[21] = { "Main", Vector( 22.5, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[22] = { "Main", Vector( -15.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[23] = { "Main", Vector( 15.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[24] = { "Main", Vector( -7.7, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[25] = { "Main", Vector( 7.7, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[26] = { "Main", Vector( 0, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[27] = { "Corner3", Vector( 31.8, 0, -0.2 ), Angle( 0, -90, 0 ), Width = 7.7 },
	[28] = { "Corner3", Vector( -31.8, 0, -0.2 ), Angle( 0, 90, 0 ), Width = 7.7 },

	[29] = { "Illumination", Vector( -7.7, 6.6, -0.2 ), Angle( 5, 0, 0 ) },
	[30] = { "Illumination", Vector( 7.7, 6.6, -0.2 ), Angle( 5, 0, 0 ) },
	[31] = { "Illumination", Vector( 0, 6.6, -0.2 ), Angle( 2, 0, 0 ), FOV = 90, Material = "photon/flashlight/wide.png" },

	[32] = { "Illumination", Vector( -31.8, 0, -0.2 ), Angle( 0, 90, 0 ), FOV = 90 },
	[33] = { "Illumination", Vector( 31.8, 0, -0.2 ), Angle( 5, -90, 0 ), FOV = 90 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "2 3 6 7",
			[2] = "1 4 5",
			[3] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
			[4]  = "3 5 7 9 11 13 15 17 19 21 23 25 1:B 26:B",
			[5]  = "2 4 6 8 10 12 14 16 18 20 22 24 1:R 26:R",
			[6]  = "3:R 5:R 7:R 9:R 11:R 13:R 15:R 17:R 19:R 21:R 23:R 25:R 1:R 26:R",
			[7]  = "2:B 4:B 6:B 8:B 10:B 12:B 14:B 16:B 18:B 20:B 22:B 24:B 1:B 26:B",
		},
		Sequences = {
			["STEADY"] = { 3 },
			["FLASH"] = sequence():Flash( 4, 5, 4 ),
			["FLASH_2"] = sequence():Flash(1, 2, 3):Do(3):Add( 1, 1, 3, 2, 2, 3 ):Do(5),
			["FLASH_3"] = sequence():Flash( 4, 5, 3 ):Flash( 6, 7, 3 ),
			["ALT"] = sequence():Alternate( 4, 5, 5 ),
			["PHOTO"] = { 3 },
			["TEASER"] = { }
		}
	},
	ForwardIllumination = {
		Off = "PASS",
		Frames = {
			[1] = "[W] 1 2 3 4 5 6 7 8 9 10 11 12 13 31",
			[2] = "[W] 2 3 29 30"
		},
		Sequences = {
			["FLOOD"] = { 1 },
			["TKDN"] = { 2 }
		}
	},
	LeftAlley = {
		Off = "PASS",
		Frames = {
			[1] = "[W] 8 10 12 28 14 16 18 32"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	RightAlley = {
		Off = "PASS",
		Frames = {
			[1] = "[W] 9 11 13 27 15 17 19 33"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Traffic = {
		Frames = {
			[1] = "[A] 21",
			[2] = "[A] 23 21",
			[3] = "[A] 25 23 21",
			[4] = "[A] 26 25 23 21",
			[5] = "[A] 24 26 25 23 21",
			[6] = "[A] 22 24 26 25 23 21",
			[7] = "[A] 20 22 24 26 25 23 21",
			[8] = "[A] 20 22 24 26 25 23",
			[9] = "[A] 20 22 24 26 25",
			[10] = "[A] 20 22 24 26",
			[11] = "[A] 20 22 24",
			[12] = "[A] 20 22",
			[13] = "[A] 20",
			[14] = "[A] 26",
			[15] = "[A] 24 26 25",
			[16] = "[A] 22 24 26 25 23",
			[17] = "[A] 20 22 24 26 25 23 21",
			[18] = "[A] 20 22 24 25 23 21",
			[19] = "[A] 20 22 23 21",
			[20] = "[A] 20 21",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 13 ):Add( 0 ):SetTiming( .273 ),
			["RIGHT"] = sequence():Sequential( 13, 1 ):Add( 0 ):SetTiming( .273 ),
			["CENOUT"] = sequence():Sequential( 14, 20 ):Add( 0 ):SetTiming( .273 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ALT"
		},
		["MODE2"] = {
			All = "ALT"
		},
		["MODE3"] = {
			All = "ALT"
		}
	},
	["Emergency.Marker"] = {
		["CRUISE"] = {
			All = "STEADY"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = { ForwardIllumination = "TKDN" },
		["FLOOD"] = { ForwardIllumination = "FLOOD" }
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { LeftAlley = "ON" },
	},
	["Emergency.SceneRight"] = {
		["ON"] = { RightAlley = "ON" },
	},
	["Emergency.Directional"] = {
        ["LEFT"] = { Traffic = "LEFT" },
        ["RIGHT"] = { Traffic = "RIGHT" },
        ["CENOUT"] = { Traffic = "CENOUT" }
	},
}