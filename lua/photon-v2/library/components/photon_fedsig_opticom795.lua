if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "anemolis72",
	Model = "Schmal",
}

COMPONENT.Title = [[Federal Signal Opticom 795]]
COMPONENT.Category = "Special"
COMPONENT.Model = "models/schmal/fedsig_opticom795.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 0, 0 ),
	Zoom = 0.3
}

COMPONENT.States = {
	[1] = "W",
}

local s = 1.6

COMPONENT.Templates = {
	["2D"] = {
		main = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/fs_xstream_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/fs_xstream_detail.png").MaterialName,
			Width = 45,
			Height = 10.8,
			Ratio = .4,
			Scale = .4,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			-- LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			-- LightMatrixScaleMultiplier = 0.6
		},
	}
}

COMPONENT.StateMap = "[W] 1"

COMPONENT.Elements = {
	[1] = { "main", Vector(-38, 0, 0 ), Angle(0, 90, 0) },
}

COMPONENT.Segments = {
	Opticom = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "[1] 1",
		},
		Sequences = {
			["ON"] = { 1,0,0 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Opticom = "ON"
		},
		["MODE2"] = {
			Opticom = "ON"
		},
		["MODE3"] = {
			Opticom = "ON"
		}
	},
}