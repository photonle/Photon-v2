local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_ion_surface"

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "Anemolis",
	Code = "Schmal"
}

COMPONENT.Model = "models/anemolis/props/anemolis_surfaceion.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {

		}
	}
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) }
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1",
		},
		Sequences = {
			ON = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ON"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )