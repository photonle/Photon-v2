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

COMPONENT.StateMap = "[R] 1 [B] 2"

COMPONENT.Elements = {
	[1] = { "Main", Vector( -7.7, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[2] = { "Main", Vector( 7.7, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2",
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