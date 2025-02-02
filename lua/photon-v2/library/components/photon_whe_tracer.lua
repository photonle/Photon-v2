local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Name = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 5"
COMPONENT.Category = "Perimeter"
COMPONENT.Author = "SGM"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer5.mdl"

local size = 14.72

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size + 2,
			Detail = PhotonMaterial.GenerateLightQuad("sentry/props/tracer/detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("sentry/props/tracer/bloom.png").MaterialName,
			Scale = 0.75,
			Ratio = 1.0,
			DrawLightPoints = true,
			VisibilityRadius = 0.1,
			LightMatrix = {
				Vector(-6.5,0,0),
				Vector(-4.875,0,0),
				Vector(-3.25,0,0),
				Vector(-1.625,0,0),
				Vector(1.625,0,0),
				Vector(3.25,0,0),
				Vector(4.875,0,0),
				Vector(6.5,0,0),
			}
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "R",
	[3] = "B",
	[4] = "W",
}

local offset = 14.883

COMPONENT.Elements = {
	[1] = { "Light", Vector( offset * -2, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10,},
	[2] = { "Light", Vector( offset * -1, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, },
	[3] = { "Light", Vector( 0, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, },
	[4] = { "Light", Vector( offset * 1, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, },
	[5] = { "Light", Vector( offset * 2, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, },
	[6] = { "Light", Vector( offset * -3, 1.3, -0.0111 ), Angle( 0, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10,},
}

COMPONENT.StateMap = "[R] 1 3 5 [B] 2 4 6"

COMPONENT.ElementGroups = {
	Light = { 1, 3, 5 },
	Inner = { 2, 4, },
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] Light",
			[2] = "[3] Inner",
			[3] = "[3] Light",
			[4] = "[2] Inner",

			[5] = "[~R] Light",
			[6] = "[~B] Inner",
			[7] = "[~B] Light",
			[8] = "[~R] Inner",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ALTERNATE"
		},
		["MODE2"] = {
			Light = "FLASH"
		},
		["MODE3"] = {
			Light = "VARIABLE"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_tracer3"
COMPONENT.Base = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 3"

COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer3.mdl"

COMPONENT.ElementGroups = {
	Inner = { 2, 4 },
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] 3",
			[2] = "[3] Inner",
			[3] = "[3] 3",
			[4] = "[2] Inner",

			[5] = "[~R] 3",
			[6] = "[~B] Inner",
			[7] = "[~B] 3",
			[8] = "[~R] Inner",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

Photon2.RegisterComponent( Photon2.Util.UniqueCopy(COMPONENT) )

local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_tracer1"
COMPONENT.Base = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 1"

COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer1.mdl"

COMPONENT.ElementGroups = {
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] 3",
			[2] = "",
			[3] = "[3] 3",
			[4] = "",

			[5] = "[~R] 3",
			[6] = "",
			[7] = "[~B] 3",
			[8] = "",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

Photon2.RegisterComponent( Photon2.Util.UniqueCopy(COMPONENT) )

local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_tracer6"
COMPONENT.Base = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 6"

COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer6.mdl"

COMPONENT.ElementGroups = {
	Inner = { 2, 4, 6 },
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] Light",
			[2] = "[3] Inner",
			[3] = "[3] Light",
			[4] = "[2] Inner",

			[5] = "[~R] Light",
			[6] = "[~B] Inner",
			[7] = "[~B] Light",
			[8] = "[~R] Inner",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

Photon2.RegisterComponent( Photon2.Util.UniqueCopy(COMPONENT) )

local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_tracer4"
COMPONENT.Base = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 4"

COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer4.mdl"

COMPONENT.ElementGroups = {
	Light4 = { 5, 3 },
	Inner = { 2, 4 },
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] Light4",
			[2] = "[3] Inner",
			[3] = "[3] Light4",
			[4] = "[2] Inner",

			[5] = "[~R] Light4",
			[6] = "[~B] Inner",
			[7] = "[~B] Light4",
			[8] = "[~R] Inner",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

Photon2.RegisterComponent( Photon2.Util.UniqueCopy(COMPONENT) )

local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_tracer2"
COMPONENT.Base = "photon_whe_tracer5"
COMPONENT.Title = "Whelen Tracer 2"

COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/whelentracer2.mdl"

COMPONENT.ElementGroups = {

}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[2] 3",
			[2] = "[3] 2",
			[3] = "[3] 3",
			[4] = "[2] 2",

			[5] = "[~R] 3",
			[6] = "[~B] 2",
			[7] = "[~B] 3",
			[8] = "[~R] 2",
		},
		Sequences = {
			ON = { 1 },
			["ALTERNATE"] = sequence():Alternate(5,6,8),
			["FLASH"] = sequence():QuadFlash( 1, 4 ):QuadFlash( 3, 2 ),
			["VARIABLE"] = sequence():Add(1,4,3,2):SetVariableTiming( 1/4, 1/15, 0.66 ),
		}
	}
}

Photon2.RegisterComponent( Photon2.Util.UniqueCopy(COMPONENT) )