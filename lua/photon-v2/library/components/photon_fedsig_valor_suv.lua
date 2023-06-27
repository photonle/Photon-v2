if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Model = "Twurtleee",
	Code = "Schmal"
}

COMPONENT.PrintName = [[Federal Signal Valor (51")]]

COMPONENT.Model = "models/schmal/fedsig_valor_51in.mdl"

local s = 1.2

COMPONENT.Lighting = {
	["2D"] = {
		Primary = {
			Width 		= 5.2,
			Height		= 4,
			MaterialOverlay 	= "photon/lights/legend_wide_leds",
			Material 			= "sprites/emv/legend_wide",
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0),
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		},
		Rear = {
			Width 		= 5.4,
			Height		= 4,
			MaterialOverlay 	= "photon/lights/legend_wide_leds",
			Material 			= "sprites/emv/legend_wide",
			Scale 		= 1.2,
			Ratio 		= 2,
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 0.5
		}
	}
}

local mult56 = 0.8

COMPONENT.Lights = {
	[1] = { "Primary", Vector( 11.3, 2.3, 1.9 ), Angle( 0, -54, 0 ), Width = 6.5 },
	[2] = { "Primary", Vector( 11.3, -2.3, 1.9 ), Angle( 0, 180 + 54, 0 ), Width = 6.5 },

	[3] = { "Primary", Vector( 8.3, 6.4, 1.9 ), Angle( 0, -54, 0 ) },
	[4] = { "Primary", Vector( 8.3, -6.4, 1.9 ), Angle( 0, 180 + 54, 0 ) },

	[5] = { "Primary", Vector( 5.6, 10, 1.9 ), Angle( 0, -54, 0 ) },
	[6] = { "Primary", Vector( 5.6, -10, 1.9 ), Angle( 0, 180 + 54, 0 ) },

	[7] = { "Primary", Vector( 2.98, 13.625, 1.9 ), Angle( 0, -54, 0 ) },
	[8] = { "Primary", Vector( 2.98, -13.625, 1.9 ), Angle( 0, 180 + 54, 0 ) },

	[9] = { "Primary", Vector( 1.7, 17.9, 1.9 ), Angle( 0, -90, 0 ) },
	[10] = { "Primary", Vector( 1.7, -17.9, 1.9 ), Angle( 0, -90, 0 ) },

	[11] = { "Primary", Vector( 1.7, 22.6, 1.9 ), Angle( 0, -90, 0 ) },
	[12] = { "Primary", Vector( 1.7, -22.6, 1.9 ), Angle( 0, -90, 0 ) },

	[13] = { "Primary", Vector( 0.2, 26.90, 1.9 ), Angle( 0, -49, 0 ) },
	[14] = { "Primary", Vector( 0.2, -26.90, 1.9 ), Angle( 0, 180+49, 0 ) },

	[15] = { "Primary", Vector( -4, 29.25, 1.9 ), Angle( 0, -10.8, 0 ), Width = 5.8 },
	[16] = { "Primary", Vector( -4, -29.25, 1.9 ), Angle( 0, 180+10.8, 0 ), Width = 5.8 },

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
}

COMPONENT.ColorMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28"

local sequence = Photon2.SequenceBuilder.New


COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1:R 2:B 3:R 4:B 5:R 6:B 7:R 8:B 9:R 10:B 11:R 12:B 13:R 14:B 15:R 16:B 17:R 18:B 19:R 20:B 21:R 22:B 23:R 24:B 25:R 26:B 27:R 28:B",
			[2] = "1 4 5 8 9 12 13 16 17 20 21 24 25 28",
			[3] = "2 3 6 7 10 11 14 15 18 19 22 23 26 27"
		},
		Sequences = {
			["DEV"] = { 3 },
			["MIX"] = { 2, 0, 2, 0, 2, 2, 2, 2, 0, 3, 0, 3, 0, 3, 3, 3, 3 }
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "MIX"
		}
	}
}