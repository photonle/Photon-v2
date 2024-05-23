if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "anemolis72, Schmal",
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
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/opticom_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/opticom_detail.png").MaterialName,
			Width = 45,
			Height = -11.4,
			Ratio = .4,
			Scale = .4,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
		},
	}
}

COMPONENT.StateMap = "[R*0.2] 1"

COMPONENT.Elements = {
	[1] = { "main", Vector(-38, 0, 0.3 ), Angle( 0, 90, 0 ) },
}

COMPONENT.Segments = {
	Opticom = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "[1] 1",
			[2] = "[#DEBUG] 1"
		},
		Sequences = {
			["FLASH"] = { 1, 0, 0 },
			["DEBUG"] = { 2 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE2"] = { Opticom = "FLASH" },
		["MODE3"] = { Opticom = "FLASH" }
	},
}