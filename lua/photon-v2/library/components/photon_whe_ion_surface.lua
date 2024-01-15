local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_ion_surface"

COMPONENT.WorkshopRequirements = {
	[2932505261] = "Anemolis Prop Pack"
}

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "Anemolis",
	Code = "Schmal"
}

COMPONENT.Model = "models/anemolis/props/anemolis_surfaceion.mdl"

local size = 6

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width 	= size,
			Height	= size/4,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_shape.png").MaterialName,
		}
	}
}

COMPONENT.StateMap = "[R] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
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

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_ion_surface_bracket"
COMPONENT.Base = "photon_whe_ion_surface"
COMPONENT.Model = "models/anemolis/props/anemolis_lsurfaceion.mdl"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )