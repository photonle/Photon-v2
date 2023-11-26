if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal nForce (48")]]

COMPONENT.Model = "models/photon/sentry/nforce.mdl"

local s = 1.2

COMPONENT.Templates = {
	["2D"] = {
		Main = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sos_nforce_main_bloom.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 2.4,
			Scale = 1.2,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.5,
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1
		},
		Corner3 = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sos_nforce_corner3_bloom.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 1,

			Scale = 1,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.5
		}
	}
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 [B] 2 4 6 8 10 12 14 16 18 20 22 24 [W] 25 26"

COMPONENT.Elements = {
	[1] = { "Main", Vector( -3.56, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[2] = { "Main", Vector( 3.56, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	
	[3] = { "Main", Vector( -11.17, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[4] = { "Main", Vector( 11.17, 6.6, -0.2 ), Angle( 0, 0, 0 ) },

	[5] = { "Main", Vector( -18.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[6] = { "Main", Vector( 18.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	
	[7] = { "Corner3", Vector( -23.6, 6.1, -0.2 ), Angle( 0, 16, 0 ) },
	[8] = { "Corner3", Vector( 23.6, 6.1, -0.2 ), Angle( 0, -16, 0 ) },

	[9] = { "Corner3", Vector( -25.98, 4.75, -0.2 ), Angle( 0, 43, 0 ) },
	[10] = { "Corner3", Vector( 25.98, 4.75, -0.2 ), Angle( 0, -43, 0 ) },

	[11] = { "Corner3", Vector( -27.34, 2.43, -0.2 ), Angle( 0, 77, 0 ) },
	[12] = { "Corner3", Vector( 27.34, 2.43, -0.2 ), Angle( 0, -77, 0 ) },

	[13] = { "Corner3", Vector( -27.34, -2.43, -0.2 ), Angle( 0, 180-77, 0 ) },
	[14] = { "Corner3", Vector( 27.34, -2.43, -0.2 ), Angle( 0, 180+77, 0 ) },

	[15] = { "Corner3", Vector( -25.98, -4.75, -0.2 ), Angle( 0, 180-43, 0 ) },
	[16] = { "Corner3", Vector( 25.98, -4.75, -0.2 ), Angle( 0, 180+43, 0 ) },

	[17] = { "Corner3", Vector( -23.6, -6.1, -0.2 ), Angle( 0, 180-16, 0 ) },
	[18] = { "Corner3", Vector( 23.6, -6.1, -0.2 ), Angle( 0, 180+16, 0 ) },

	[19] = { "Main", Vector( -18.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[20] = { "Main", Vector( 18.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[21] = { "Main", Vector( -11.17, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[22] = { "Main", Vector( 11.17, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[23] = { "Main", Vector( -3.56, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[24] = { "Main", Vector( 3.56, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[25] = { "Corner3", Vector( -27.65, 0, -0.2 ), Angle( 0, 90, 0 ), Width = 7.3 },
	[26] = { "Corner3", Vector( 27.65, 0, -0.2 ), Angle( 0, -90, 0 ), Width = 7.3 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
			[2] = ""
		},
		Sequences = {
			["STEADY"] = { 1 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "STEADY"
		},
	},
}