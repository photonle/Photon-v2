local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Name = "photon_code3_xt3"
COMPONENT.Title = "Code 3 XT3"
COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "Cj24",
	Code = "Schmal"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/schmal/code3_xt3.mdl"

local size = 3

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size/2,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt3_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt3_shape.png").MaterialName,
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

COMPONENT.StateMap = "[1/2/3] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0.5, 0, 0 ), Angle( 0, -90, 0 ) }
}

COMPONENT.ElementGroups = {
	Light = { 1 }
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "Light",
			[2] = "[2] Light",
			[3] = "[3] Light",
			[4] = "[OFF] Light"
		},
		Sequences = {
			ON = { 1 },
			["STEADY_FLASH"] = sequence():SteadyFlash( 1 ),
			["QUAD_FLASH"] = sequence():QuadFlash( 1, 0 ),
			["QUAD_FLASH:A"] = sequence():QuadFlash( 1, 0 ),
			["QUAD_FLASH:B"] = sequence():QuadFlash( 0, 1 ),
			["QUAD_FLASH_DUO"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_FLASH_DUO:A"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_FLASH_DUO:B"] = sequence():QuadFlash( 2, 1 ),
			["ALT_MED"] = sequence():Alternate( 1, 0, 8 ),
			["ALT_MED:B"] = sequence():Alternate( 0, 1, 8 ),
			["ALT_MED_DUO"] = sequence():Alternate( 1, 2, 8 ),
			["ALT_MED_DUO:B"] = sequence():Alternate( 2, 1, 8 ),
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 1 ):AppendPhaseGap(),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( 1, 2, 3 ):AppendPhaseGap(),
			["TRI_FLASH"] = sequence():DoubleFlash( 1 ):AppendPhaseGap(),
			["TRI_FLASH_HOLD"] = sequence():FlashHold( { 1 }, 3, 4 ):AppendPhaseGap(),
			["TRI_FLASH_HOLD:A"] = sequence():FlashHold( { 1, 0 }, 3, 4 ),
			["TRI_FLASH_HOLD:B"] = sequence():FlashHold( { 0, 1 }, 3, 4 ),
			["VARIABLE_SINGLE"] = sequence():Add( 0, 1, 1, 1, 1, 0, 0, 0, 0, 0 ):SetVariableTiming( 1/12, 1/40, 0.66 ),
			["OFF"] = { 4 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "STEADY_FLASH"
		},
		["MODE2"] = {
			Light = "TRI_FLASH_HOLD"
		},
		["MODE3"] = {
			Light = "DOUBLE_FLASH_HOLD"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

--[[
		XT4
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_code3_xt4"
COMPONENT.Base = "photon_code3_xt3"
COMPONENT.Model = "models/schmal/code3_xt4.mdl"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0.5, -0.9, 0 ), Angle( 0, -90, 0 ) },
	[2] = { "Light", Vector( 0.5, 0.9, 0 ), Angle( 0, -90, 0 ) },
}

COMPONENT.ElementGroups = {
	Light = { 1, 2 }
}

size = 3

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size/2,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt2_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt2_shape.png").MaterialName,
			Ratio = 1.5,
			Scale = 1.3
		}
	}
}

COMPONENT.StateMap = "[1/2/3] 1 [2/1/3] 2"

COMPONENT.Segments = {
	Split = {
		Frames = {
			[1] = "1",
			[2] = "2",
		},
		Sequences = {
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 1, 2 ),
			["TRIPLE_FLASH"] = sequence():TripleFlash( 1, 2 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Split = "TRIPLE_FLASH" },
		["MODE2"] = { Split = "TRIPLE_FLASH" },
		["MODE3"] = { Split = "TRIPLE_FLASH" },
	}
}

Photon2.RegisterComponent( COMPONENT )


--[[
		XT6
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_code3_xt6"
COMPONENT.Base = "photon_code3_xt4"
COMPONENT.Model = "models/schmal/code3_xt6.mdl"

size = 3

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size/2,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt3_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/code3_xt3_shape.png").MaterialName,
			Ratio = 1,
			Scale = 1
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0.5, -1.32, 0 ), Angle( 0, -90, 0 ) },
	[2] = { "Light", Vector( 0.5, 1.32, 0 ), Angle( 0, -90, 0 ) },
}

COMPONENT.ElementGroups = {
	Light = { 1, 2 }
}

COMPONENT.Segments = {
	XT6 = {
		Frames = {
			[1] = "[#DEBUG] 1 2"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		-- ["MODE1"] = { XT6 = "ON" },
		-- ["MODE2"] = { XT6 = "ON" },
		-- ["MODE3"] = { XT6 = "ON" },
	}
}

Photon2.RegisterComponent( COMPONENT )