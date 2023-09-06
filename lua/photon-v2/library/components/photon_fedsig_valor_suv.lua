if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Model = "Twurtleee",
	Code = "Schmal"
}

COMPONENT.PrintName = [[Federal Signal Valor (51")]]

COMPONENT.Model = "models/schmal/fedsig_valor_51in.mdl"

local s = 1.5

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.5,
			Height		= 2.8,
			MaterialOverlay 	= PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			-- MaterialOverlay 	= "photon/lights/legend_wide_leds",
			Material 			= PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/fs_valor_bloom.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0),
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		},
		Rear = {
			Width 		= 5.8,
			Height		= 2.9,
			-- MaterialOverlay 	= "photon/lights/legend_wide_leds",
			-- Material 			= "sprites/emv/legend_wide",
			MaterialOverlay 	= PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Material 			= PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/fs_valor_bloom.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		}
	}
}

local mult56 = 0.8

COMPONENT.Lights = {
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
}

COMPONENT.ColorMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28"

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
			["DEV"] = { 5, 5 },
			-- ["T"] = { 6, 5 },
			["MIX"] = { 2, 0, 2, 0, 2, 2, 2, 2, 0, 3, 0, 3, 0, 3, 3, 3, 3 },
			-- ["MIX"] = sequence():Add(2):Do(16):Add(3):Do(16)
			-- ["MI2"] = { 5, 0, 5, 0, 5, 5, 5, 5, 0, 6, 0, 6, 0, 6, 6, 6, 6 }
			-- ["MIX"] = { 5, 0, 5, 0, 5, 5, 5, 5, 0, 6, 0, 6, 0, 6, 6, 6, 6 }
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
			[1] = "[W] 9 11 13 15 10 12 14 16",
			[2] = "[OFF] 9 11 13 15 10 12 14 16"
		},
		Sequences = {
			-- ["P26"] = { 1, 1, 1, 0, 0, 0, 0, 1 }

			["P26"] = { 0, 0, 0, 1, 2, 1, 2, 0 }
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			-- All = "MIX"
			P26_EDGE = "P26",
			P26_FRONT = "P26",
			P26_REAR = "P26",
		},
		["MODE3"] = {
			-- All = "MIX"
			P26_EDGE = "P26",
			P26_FRONT = "P26",
			P26_REAR = "P26",
		}
	},
	["Emergency.Siren"] = {
		["T1"] = {
			P26_WOR = "P26",
		}
	}
}