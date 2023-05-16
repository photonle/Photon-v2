if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.PrintName = [[SoundOff Signal mpower Fascia 4" - Horizontal License Mount]]

COMPONENT.Model = "models/sentry/props/soundofffascia_plate_horizontal.mdl"

local s = 1.6

COMPONENT.Lighting = {
	["2D"] = {
		Full = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_mpf4_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_mpf4_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sos_mpf4_bloom.png").MaterialName,
			Width = 6,
			Height = 6,
			Ratio = 1,
			Scale = 1,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 0.6
		}
	}
}

COMPONENT.ColorMap = "[R] 1 [B] 2"

COMPONENT.Lights = {
	[1] = { "Full", Vector(2.4, 9.94,3), Angle(0, -90, 0) },
	[2] = { "Full", Vector(2.4, -9.94,3), Angle(0, -90, 0) }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Full = {
		Frames = {
			[1] = "1 2",
			[2] = "1:B 2:R",
			[3] = "1:R 2:B"
		},
		Sequences = {
			["STEADY"] = { 1 },
			["COLOR_ALT"] = sequence():Flash( 2, 3, 6 )
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			-- Full = "COLOR_ALT"
			Full = "STEADY"
		}
	}
}