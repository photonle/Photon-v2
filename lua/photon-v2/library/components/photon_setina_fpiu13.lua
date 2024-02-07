if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "Mighty, Schmal, et. al",
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.PrintName = [[Setina Push Bumper - 2013 Ford Police Utility]]

COMPONENT.Model = "models/schmal/fpiu13_setina.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Impaxx = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.7,
			Height = 5.7/2,
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Impaxx", Vector( 10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },
	[2] = { "Impaxx", Vector( -10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },

	[3] = { "Impaxx", Vector( 22.31, -0.25, 9.95 ), Angle( 0, -90, 90 ) },
	[4] = { "Impaxx", Vector( -22.31, -0.25, 9.95 ), Angle( 0, 90, 90 ) },
}

COMPONENT.StateMap = "[1/2] 1 2 3 4"

COMPONENT.ElementStates = {}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	UpperLeft = {
		Frames = {
			[1] = "1:1",
			[2] = "1:2",
		},
		Sequences = {
			["SPD"] = { 
				1, 1, 0, 1, 1, 0, 2, 2, 0, 2, 2, 0,
				1, 1, 0, 2, 2, 0, 1, 1, 0, 2, 2, 0
			}
		}
	},
	UpperRight = {
		Frames = {
			[1] = "2:1",
			[2] = "2:2",
		},
		Sequences = {
			["SPD"] = { 
				0, 1, 1, 0, 2, 2, 0, 1, 1, 0, 2, 2,
				0, 1, 1, 0, 1, 1, 0, 2, 2, 0, 2, 2,
			}
		}
	},
	Upper = {
		Frames = {
			[1] = "[1] 1 [OFF] 2",
			[2] = "[1] 1 [1] 2",
			[3] = "[OFF] 1 [1] 2",
			[4] = "[2] 1 [1] 2",
			[5] = "[2] 1 [OFF] 2",
			[6] = "[2] 1 [2] 2",
			[7] = "[OFF] 1 [2] 2",
		},
		Sequences = {

		}
	},
	Side = {
		Frames = {
			[1] = "[R] 3 4",
			[2] = "[B] 3 4",
			[3] = "[R] 3 [B] 4",
		},
		Sequences = {
			FLASH = sequence()
			:TripleFlash( 1, 0 )
			:TripleFlash( 2, 0 ),
			STEADY = { 3 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { },
		["MODE2"] = { 
			UpperLeft = "SPD",
			UpperRight = "SPD",
			Side = "FLASH"
		},
		["MODE3"] = {
			UpperLeft = "SPD",
			UpperRight = "SPD",
			Side = "FLASH"
		},
	},
	["Emergency.SceneForward"] = {
		["ON"] = { },
		["FLOOD"] = { },
	},
	["Emergency.Marker"] = {
		["ON"] = {

		}
	}
}