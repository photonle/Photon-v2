local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_dominator_2"
COMPONENT.Title = "Whelen Dominator (x2)"
COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "A",
	[4] = "A"
}

COMPONENT.Category = "Interior"
COMPONENT.Model = "models/sentry/props/dominator2.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -2),
	Angles = Angle( 0, -90, 0 ),
	Zoom = 1.8
}

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width 	= 3.7,
			Height	= 1.85,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_dominator_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_dominator_shape.png").MaterialName,
			Scale = 1.25,
			ForwardBloomOffset = 0.1,
			ForwardVisibilityOffset = -0.3
		}
	}
}

COMPONENT.StateMap = "[1/3] 1 [2/4] 2"

COMPONENT.Elements = {
	[1] = { "Light", Vector( -2.04, 0.2, 0 ), Angle( 0, 180, 0 ) },
	[2] = { "Light", Vector( 2.04, 0.2, 0 ), Angle( 0, 180, 0 ) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2",
			[2] = "1",
			[3] = "2",
		},
		Sequences = {
			ALL = { 1 },
			ALT = sequence():Alternate( 2, 3, 8 ),
			DOUBLE_FLASH_HOLD = { 2, 0, 2, 2, 2, 3, 0, 3, 3, 3, 0 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ALL"
		},
		["MODE2"] = { All = "ALT" },
		["MODE3"] = { All = "ALT" },
	}
}

Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_dominator_4"
COMPONENT.Title = "Whelen Dominator (x4)"
COMPONENT.Model = "models/sentry/props/dominator4.mdl"
COMPONENT.Base = "photon_whe_dominator_2"
COMPONENT.StateMap = "[1/3] 1 3 [2/4] 2 4"
COMPONENT.Elements = {
	[3] = { "Light", Vector( -6.3, 0.2, 0 ), Angle( 0, 180, 0 ) },
	[4] = { "Light", Vector( 6.3, 0.2, 0 ), Angle( 0, 180, 0 ) },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4",
			[2] = "1 3",
			[3] = "2 4"
		},
		Sequences = {
			ALL = { 1 }
		}
	}
}
Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_dominator_6"
COMPONENT.Title = "Whelen Dominator (x6)"
COMPONENT.Model = "models/sentry/props/dominator6.mdl"
COMPONENT.Base = "photon_whe_dominator_4"
COMPONENT.StateMap = "[1/3] 1 3 5 [2/4] 2 4 6"
COMPONENT.Elements = {
	[5] = { "Light", Vector( -10.5, 0.2, 0 ), Angle( 0, 180, 0 ) },
	[6] = { "Light", Vector( 10.5, 0.2, 0 ), Angle( 0, 180, 0 ) },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6",
			[2] = "1 3 5",
			[3] = "2 4 6"
		},
		Sequences = {
			ALL = { 1 }
		}
	},
}
Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_dominator_8"
COMPONENT.Title = "Whelen Dominator (x8)"
COMPONENT.Model = "models/sentry/props/dominator8.mdl"
COMPONENT.Base = "photon_whe_dominator_6"
COMPONENT.StateMap = "[1/3] 1 3 5 7 [2/4] 2 4 6 8"
COMPONENT.Elements = {
	[7] = { "Light", Vector( -14.7, 0.2, 0 ), Angle( 0, 180, 0 ) },
	[8] = { "Light", Vector( 14.7, 0.2, 0 ), Angle( 0, 180, 0 ) },
}

COMPONENT.ElementGroups = {
	Left = { 1, 3, 5, 7 },
	Right = { 2, 4, 6, 8 },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8",
			[2] = "Left",
			[3] = "Right",
		},
		Sequences = {
			ALL = { 1 },
			ALT_MED = sequence():Alternate( 3, 2, 8 ),
			STEADY_FLASH = sequence():SteadyFlash( 1 ),
			QUAD_FLASH = sequence():Flash( 3, 2, 4 )
		}
	},
	Traffic = {
		Frames = {
			[1] = "7",
			[2] = "7 5",
			[3] = "7 5 3",
			[4] = "7 5 3 1",
			[5] = "7 5 3 1 2",
			[6] = "7 5 3 1 2 4",
			[7] = "7 5 3 1 2 4 6",
			[8] = "7 5 3 1 2 4 6 8",
			[9] = "5 3 1 2 4 6 8",
			[10] = "3 1 2 4 6 8",
			[11] = "1 2 4 6 8",
			[12] = "2 4 6 8",
			[13] = "4 6 8",
			[14] = "6 8",
			[15] = "8",
			[16] = "1 2",
			[17] = "1 2 3 4",
			[18] = "1 2 3 4 5 6",
			[19] = "1 2 3 4 5 6 7 8",
			[20] = "3 4 5 6 7 8",
			[21] = "5 6 7 8",
			[22] = "7 8",
		},
		Sequences = {
			["RIGHT"] = sequence():Sequential( 1, 8 ):Hold( 1 ):Sequential( 9, 15 ):StretchAll( 2 ):Steady( 0, 4 ),
			["LEFT"] = sequence():Sequential( 15, 8 ):Hold( 1 ):Sequential( 7, 1 ):StretchAll( 2 ):Steady( 0, 4 ),
			["CENOUT"] = sequence():Sequential( 16, 19 ):Sequential( 19, 22 ):StretchAll( 3 ):Steady( 0, 4 )
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Directional"] = {
		["LEFT"] = { Traffic = "LEFT" },
		["RIGHT"] = { Traffic = "RIGHT" },
		["CENOUT"] = { Traffic = "CENOUT" },
	}
}

Photon2.RegisterComponent( COMPONENT )