if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal nForce (48")]]

COMPONENT.Model = "models/photon/sentry/nforce.mdl"

local s = 1.2

COMPONENT.Templates = {
	["2D"] = {
		Main = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_main_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sos_nforce_main_bloom.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 2.4,
			Scale = 1.2,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.5,
			LightMatrix = { Vector(s, 0, 0), Vector(-s, 0, 0),  },
			LightMatrixScaleMultiplier = 1,
		},
		Corner3 = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sos_nforce_corner3_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sos_nforce_corner3_bloom.png").MaterialName,
			Width = 9.9,
			Height = 9.9,
			Ratio = 1,

			Scale = 1.2,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.5
		}
	}
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 [B] 2 4 6 8 10 12 14 16 18 20 22 24 [W] 25 26"

COMPONENT.Elements = {
	[1] = { "Main", Vector( -3.56, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[2] = { "Main", Vector( 3.56, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	
	[3] = { "Main", Vector( -11.17, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[4] = { "Main", Vector( 11.17, 6.6, -0.2 ), Angle( 0, 0, 0 ) },

	[5] = { "Main", Vector( -18.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	[6] = { "Main", Vector( 18.4, 6.6, -0.2 ), Angle( 0, 0, 0 ) },
	
	[7] = { "Corner3", Vector( -23.6, 6.1, -0.2 ), Angle( 0, 16, 0 ) },
	[8] = { "Corner3", Vector( 23.6, 6.1, -0.2 ), Angle( 0, -16, 0 ) },

	[9] = { "Corner3", Vector( -25.98, 4.75, -0.2 ), Angle( 0, 43, 0 ) },
	[10] = { "Corner3", Vector( 25.98, 4.75, -0.2 ), Angle( 0, -43, 0 ) },

	[11] = { "Corner3", Vector( -27.34, 2.43, -0.2 ), Angle( 0, 77, 0 ) },
	[12] = { "Corner3", Vector( 27.34, 2.43, -0.2 ), Angle( 0, -77, 0 ) },

	[13] = { "Corner3", Vector( -27.34, -2.43, -0.2 ), Angle( 0, 180-77, 0 ) },
	[14] = { "Corner3", Vector( 27.34, -2.43, -0.2 ), Angle( 0, 180+77, 0 ) },

	[15] = { "Corner3", Vector( -25.98, -4.75, -0.2 ), Angle( 0, 180-43, 0 ) },
	[16] = { "Corner3", Vector( 25.98, -4.75, -0.2 ), Angle( 0, 180+43, 0 ) },

	[17] = { "Corner3", Vector( -23.6, -6.1, -0.2 ), Angle( 0, 180-16, 0 ) },
	[18] = { "Corner3", Vector( 23.6, -6.1, -0.2 ), Angle( 0, 180+16, 0 ) },

	[19] = { "Main", Vector( -18.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[20] = { "Main", Vector( 18.4, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[21] = { "Main", Vector( -11.17, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[22] = { "Main", Vector( 11.17, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[23] = { "Main", Vector( -3.56, -6.6, -0.2 ), Angle( 0, 180, 0 ) },
	[24] = { "Main", Vector( 3.56, -6.6, -0.2 ), Angle( 0, 180, 0 ) },

	[25] = { "Corner3", Vector( -27.65, 0, -0.2 ), Angle( 0, 90, 0 ), Width = 7.3 },
	[26] = { "Corner3", Vector( 27.65, 0, -0.2 ), Angle( 0, -90, 0 ), Width = 7.3 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.ElementGroups = {

}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
			[2] = "[R] 1 5 7 9 11 13 15 17 19 21 23 25 [W] 3",
			[3] = "2 4:W 6 8 10 12 14 16 18 20 22 24 26",
			
		},
		Sequences = {
			["STEADY"] = { 3 },
			-- ["MODE6"] = sequence():SingleFlash( 2, 6 ):Do( 8 ):DoubleFlash( 2, 6 ):Do( 4 ):TripleFlash( 2, 6 ):Do( 2 )
		}
	},
	ForwardIllumination = {
		Frames = {
			[1] = "[W] 1 2 3 4 5 6 7 8 9 10 11 12",
			[2] = "[W] 3 4",
		},
		Sequences = {
			["FLOOD"] = { 1 },
			["TKDN"] = { 2 }
		}
	},
	-- "Wireless Advanced Communications" patterns
	WAC = {
		Frames = {
			[1] = "[R] 1 5 25 19 23 7 9 11 [A] 21 [W] 3 13 15 17",
			[2] = "[B] 2 6 26 20 24 8 10 12 [A] 22 [W] 4 14 16 18",
			[3] = "[W] 5 25 [A] 19 23 [R] 1 21 3 7 9 11 13 15 17",
			[4] = "[W] 6 26 [A] 20 24 [B] 2 22 4 8 10 12 14 16 18",
			[5] = "6 2 3:W 7 9 11 19:A 23 22:A 18 16 14",
			[6] = "5 1 4:W 8 10 12 20:A 24 21:A 17 15 13"
		},
		Sequences = {
			["MODE2"] = sequence():SingleFlash( 5, 6 ):Do( 8 ):DoubleFlash( 5, 6 ):Do( 4 ):TripleFlash( 5, 6 ):Do( 2 ),
			["MODE3"] = sequence()
						:SingleFlash( 1, 2 ):Do( 4 ):DoubleFlash( 1, 2 ):Do( 3 ):TripleFlash( 1, 2 ):Do( 2 )
						:SingleFlash( 3, 4 ):Do( 4 ):DoubleFlash( 3, 4 ):Do( 3 ):TripleFlash( 3, 4 ):Do( 2 ),
		}
	},
	WACFront = {
		Frames = {
			[1] = "6 2 3 7 9 11 19 23 22:A 18 16 14",
			[2] = "5 1 4 8 10 12 20 24 21:A 17 15 13",
			[3] = "19 23 22:A 18 16 14",
			[4] = "20 24 21:A 17 15 13",
			[5] = "1 2"
		},
		Sequences = {
			["MODE1"] = { 5 },
			["MODE2"] = sequence()
						:SingleFlash( 1, 2 ):Do( 4 ):DoubleFlash( 1, 2 ):Do( 3 ):TripleFlash( 1, 2 ):Do( 2 ),
			["DEV"] = { 4 }
		},
	},
	WACRear = {
		Frames = {
			[1] = "19 23 22 18 16 14",
			[2] = "20 24 21 17 15 13",
			[3] = "18 16 14 [A] 19 23 22",
			[4] = "17 15 13 [A] 20 24 21",
		},
		Sequences = {
			["MODE1"] = sequence()
					:SingleFlash( 1, 2 ):Do( 4 ):DoubleFlash( 1, 2 ):Do( 3 ):TripleFlash( 1, 2 ):Do( 2 )
					:SingleFlash( 3, 4 ):Do( 4 ):DoubleFlash( 3, 4 ):Do( 3 ):TripleFlash( 3, 4 ):Do( 2 ),
		}
	},
	WACBrake = {
		Frames = {
			[1] = "19 20 21 22 23 24"
		},
		Sequences = {
			["BRAKE"] = { 1 }
		}
	}
}

COMPONENT.InputPriorities = {
	["Virtual.Warning+Brake"] = 101,
}

COMPONENT.VirtualOutputs = {
	["Virtual.Warning+Brake"] = {
		{
			Mode = "BRAKE",
			Conditions = {
				["Emergency.Warning"] = { "MODE2", "MODE3" },
				["Vehicle.Brake"] = { "BRAKE" }
			}
		}
	}
}

COMPONENT.Inputs = {
	["Virtual.Warning+Brake"] = {
		["BRAKE"] = {
			WACBrake = "BRAKE"
		}
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			WACFront = "MODE1",
			WACRear = "MODE1"
		},
		["MODE2"] = {
			WACFront = "MODE2",
			WACRear = "MODE1"
		},
		["MODE3"] = {
			WAC = "MODE3"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = { ForwardIllumination = "FLOOD" }
	},
	
}