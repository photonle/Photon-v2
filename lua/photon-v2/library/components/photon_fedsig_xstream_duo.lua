if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "Khuutznetsov",
}

COMPONENT.Title = [[Federal Signal x-Stream Duo]]

COMPONENT.Model = "models/schmal/fedsig_xstream_duo.mdl"

COMPONENT.States = { "R", "B", "W" }

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/fs_xstream_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/fs_xstream_detail.png").MaterialName,
			Width = 6,
			Height = 1.5
		}
	}
}

COMPONENT.StateMap = "[1/2/3] 1 [2/1/3] 2"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0.55, -3.1, -1.2 ), Angle( 0, -90, 0 ) },
	[2] = { "Light", Vector( 0.55, 3.1, -1.2 ), Angle( 0, -90, 0 ) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["Light"] = {
		Frames = {
			[1] = "1 2"
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():QuadFlash( 1, 0 ),
			["FLASH:A"] = { 1, 1, 1, 1, 0, 0, 0, 0 },
			["FLASH:B"] = { 0, 0, 0, 0, 1, 1, 1, 1 },
			["FLASH1"] = { 1 },
			["FLASH1:A"] = { 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			["FLASH1:B"] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1 },
			["CRUISE"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ON"
		},
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "CRUISE"
		}
	}
}