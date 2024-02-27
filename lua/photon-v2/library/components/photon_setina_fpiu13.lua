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

COMPONENT.Title = [[Setina Push Bumper - 2013 Ford Police Utility]]

COMPONENT.Model = "models/schmal/fpiu13_setina.mdl"

COMPONENT.BodyGroups = {
	["Side"] = "vertical_ions",
	["Front"] = "horizontal_ions",
	["Wrap"] = "wrap"
}

COMPONENT.Templates = {
	["2D"] = {
		Impaxx = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.7,
			Height = 5.7/2,
		},
		Ion = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_half_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_half_shape.png").MaterialName,
			Width = 2.7,
			Height = 1.35,
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Impaxx", Vector( 10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },
	[2] = { "Impaxx", Vector( -10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },
	
	[3] = { "Impaxx", Vector( 22.31, -0.25, 9.95 ), Angle( 0, -90, 90 ) },
	[4] = { "Impaxx", Vector( -22.31, -0.25, 9.95 ), Angle( 0, 90, 90 ) },
	
	[5] = { "Ion", Vector( 9.5, 1.4, 17.13 ), Angle( 0, 180, 0 ) },
	[6] = { "Ion", Vector( 12.15, 1.4, 17.13 ), Angle( 0, 180, 180 ) },

	[7] = { "Ion", Vector( -9.5, 1.4, 17.13 ), Angle( 0, 180, 0 ) },
	[8] = { "Ion", Vector( -12.15, 1.4, 17.13 ), Angle( 0, 180, 180 ) },
	
	[9] = { "Ion", Vector( 22.6, -0.23, 11.1 ), Angle( 0, -90, -90 ) },
	[10] = { "Ion", Vector( 22.6, -0.23, 8.5 ), Angle( 0, -90, 90 ) },

	[11] = { "Ion", Vector( -22.6, -0.23, 11.1 ), Angle( 0, 90, -90 ) },
	[12] = { "Ion", Vector( -22.6, -0.23, 8.5 ), Angle( 0, 90, 90 ) },
}

COMPONENT.StateMap = "[1/2] 1 2 3 4 6 7 10 11 [2/1] 5 8 9 12"

COMPONENT.ElementStates = {}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	IonTest = {
		Frames = {
			[1] = "5 6 7 8 9 10 11 12",
			[2] = "5 8 10 11",
			[3] = "6 7 9 12",
		},
		Sequences = {
			["ON"] = { 2 },
			["ALT"] = sequence():FlashHold( { 2, 3 }, 2, 2 )
		}
	},
	IonUpperLeft = {
		Frames = {
			[1] = "8",
			[2] = "7",
		},
		Sequences = {
			["ALT_OFFSET"] = { 1, 0, 1, 0, 1, 1, 0, 2, 0, 2, 0, 2, 2, 0 },
		}
	},
	IonUpperRight = {
		Frames = {
			[1] = "5",
			[2] = "6",
		},
		Sequences = {
			["ALT_OFFSET"] = { 1, 0, 1, 1, 0, 2, 0, 2, 0, 2, 2, 0, 1, 0 },

		}
	},
	IonLowerLeft = {
		Frames = {
			[1] = "9",
			[2] = "10",
		},
		Sequences = {
			["ALT_OFFSET"] = { 1, 1, 0, 2, 0, 2, 0, 2, 2, 0, 1, 0, 1, 0,  },
		}
	},
	IonLowerRight = {
		Frames = {
			[1] = "12",
			[2] = "11",
		},
		Sequences = {
			["ALT_OFFSET"] = { 0, 2, 0, 2, 2, 0, 1, 0, 1, 0, 1, 1, 0, 2 },
		}
	},
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
		["MODE1"] = { 
			-- IonTest = "ALT"
		},
		["MODE2"] = { 
			-- IonTest = "ALT"
			-- UpperLeft = "SPD",
			-- UpperRight = "SPD",
			-- Side = "FLASH",
			IonUpperLeft = "ALT_OFFSET",
			IonUpperRight = "ALT_OFFSET",
			IonLowerLeft = "ALT_OFFSET",
			IonLowerRight = "ALT_OFFSET",
		},
		["MODE3"] = {
			IonUpperLeft = "ALT_OFFSET",
			IonUpperRight = "ALT_OFFSET",
			IonLowerLeft = "ALT_OFFSET",
			IonLowerRight = "ALT_OFFSET",
			-- IonTest = "ALT"
			-- UpperLeft = "SPD",
			-- UpperRight = "SPD",
			-- Side = "FLASH"
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