if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.Title = [[SoundOff Signal mpower Fascia 4" - Vertical License Mount]]
COMPONENT.Category = "Perimeter"
COMPONENT.Model = "models/sentry/props/soundofffascia_plate_vertical.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.5
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

local s = 2

COMPONENT.Templates = {
	["2D"] = {
		Full = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_detail.png").MaterialName,
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

COMPONENT.StateMap = "[1/2] 1 [2/1] 2"

COMPONENT.Elements = {
	[1] = { "Full", Vector(0.5,0,0), Angle(0, -90, 0), BoneParent = 1 },
	[2] = { "Full", Vector(0.5, 0,0), Angle(0, -90, 0), BoneParent = 0 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Full = {
		Frames = {
			[1] = "[1] 1 2",
			[2] = "[1] 1 2",
			[3] = "[2] 1 2"
		},
		Sequences = {
			["STEADY"] = { 1 },
			["COLOR_ALT"] = sequence():Alternate( 2, 3, 5 ),
			["DUO_ALT_MED"] = sequence():Alternate( 2, 3, 8 ),
			["SOS_FLASH_DUO"] = sequence():FlashHold( { 2, 3 }, 3, 2 ):Do( 8 ):Alternate( 2, 3, 2 ):Do( 4 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Full = "STEADY" },
		["MODE2"] = { Full = "DUO_ALT_MED" },
		["MODE3"] = { Full = "SOS_FLASH_DUO" },
	}
}