if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "Khuutznetsov",
}

COMPONENT.PrintName = [[Federal Signal X-Stream Single]]

COMPONENT.Model = "models/schmal/fedsig_xstream_single.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_xstream_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_xstream_detail.png").MaterialName,
			Width = 6,
			Height = 1.5
		}
	}
}

COMPONENT.Lights = {
	[1] = { "Light", Vector( 0.55, 0, -0.05 ), Angle( 0, -90, 0 ) }
}

COMPONENT.LightStates = {}

COMPONENT.ColorMap = "[R] 1"

COMPONENT.Segments = {
	["Light"] = {
		Frames = {
			[1] = "1"
		},
		Sequences = {
			["ON"] = { 1 } 
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ON"
		}
	}
}