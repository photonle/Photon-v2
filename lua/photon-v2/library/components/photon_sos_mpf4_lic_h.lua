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

local s = 2

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
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 0.6
		}
	}
}

COMPONENT.ColorMap = "[R] 1 [B] 2"

COMPONENT.Lights = {
	[1] = { "Full", Vector(0.5,0,0), Angle(0, -90, 0), BoneParent = 0 },
	[2] = { "Full", Vector(0.5, 0,0), Angle(0, -90, 0), BoneParent = 1 }
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
			["COLOR_ALT"] = sequence():Alternate( 2, 3, 5 )
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			-- Full = "COLOR_ALT"
			Full = "COLOR_ALT"
		}
	}
}