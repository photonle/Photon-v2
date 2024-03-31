local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Name = "photon_whe_ion_split"
COMPONENT.Title = "Whelen Ion"
COMPONENT.Credits = {
	Model = "Sentry",
	Code = "Schmal"
}
COMPONENT.Model = "models/sentry/props/ion_photon.mdl"

local size = 6

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size/4,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_half_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_half_shape.png").MaterialName,
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
}

COMPONENT.StateMap = "[1/2] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 0.5, 0 ), Angle( 0, 0, 0 ) }
}


COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[1] 1",
			[2] = "[2] 1",
		},
		Sequences = {
			ON = { 1 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
		},
		["MODE2"] = {
		},
		["MODE3"] = {
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

--[[
		SURFACE MOUNT VARIANT
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_ion_split_surface"

COMPONENT.WorkshopRequirements = {
	[2932505261] = "Anemolis Prop Pack"
}

COMPONENT.Author = "Photon"
COMPONENT.Title = "Whelen Ion (Surface)"
COMPONENT.Base = "photon_whe_ion"
COMPONENT.Credits = {
	Model = "Mighty/SGM/Anemolis",
	Code = "Schmal"
}
COMPONENT.Category = "Perimeter"
COMPONENT.Model = "models/anemolis/props/anemolis_surfaceion.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}


COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}






Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Title = "Whelen Ion (Surface Bracket)"
COMPONENT.Name = "photon_whe_ion_split_surface_bracket"
COMPONENT.Base = "photon_whe_ion_split_surface"
COMPONENT.Model = "models/anemolis/props/anemolis_lsurfaceion.mdl"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )