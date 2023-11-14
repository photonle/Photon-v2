if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.PrintName = [[SoundOff Signal mpower Fascia 4"]]

COMPONENT.Model = "models/sentry/props/soundofffascia.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

local s = 1.6

COMPONENT.Templates = {
	["2D"] = {
		Full = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_mpf4_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_mpf4_detail.png").MaterialName,
			Width = 6,
			Height = 6,
			Ratio = 1,
			Scale = 1,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			-- LightMatrixScaleMultiplier = 0.6
		}
	}
}

COMPONENT.StateMap = ""

COMPONENT.Elements = {
	[1] = { "Full", Vector(0.5, 0, 0), Angle(0, -90, 0) }
}

COMPONENT.Segments = {
	Full = {
		Frames = {
			[1] = "[1] 1",
			[2] = "[2] 1",
			[3] = "[3] 1",
			-- [1] = { { 1, 4 } },
		},
		Sequences = {
			["TEST"] = { 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
				2, 2, 2, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
				3, 3, 0, 3, 3, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0,
			}
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE3"] = {
			Full = "TEST"
			-- All = "STEADY"
		}
	}
}