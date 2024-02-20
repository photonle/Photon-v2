if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	-- Inner modules from RoegonTV
	Model = "RoegonTV, Schmal",
	Code = "Schmal"
}

COMPONENT.PrintName = [[Federal Signal Legend (45")]]

COMPONENT.Model = "models/schmal/fedsig_legend_45in.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Main = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/legend_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/legend_shape.png").MaterialName,
			Width = 6.5,
			Height = 3.25,
			Scale = 1.5
		},
		Narrow = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/legend_narrow_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/legend_narrow_shape.png").MaterialName,
			Width = 3.25,
			Height = 3.25,
			Scale = 1
		},
		HotFoot = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.7,
			Height = 5.7/2,
			Scale = 1,
			States = {
				DW = { Inherit = "W", Intensity = 0.4 }
			}
		}
	},
	["Projected"] = {
		TakedownIllumination = {
			Brightness = 2
		},
		AlleyIllumination = {
			Brightness = 1,
			FOV = 45
		}
	}
}

COMPONENT.StateMap = "[R] 3 5 7 9 11 15 17 19 21 23 25 [B] 4 6 8 10 12 16 18 20 22 24 26 [W] 1 2 13 14 27 28 29 30 31 32 33"

COMPONENT.Elements = {
	[1] = { "Main", Vector( 6.7, 3.85, 0.15 ), Angle( 0, -90, 0 ) },
	[2] = { "Main", Vector( 6.7, -3.85, 0.15 ), Angle( 0, -90, 0 ) },

	[3] = { "Main", Vector( 6.7, 10.6, 0.15 ), Angle( 0, -90, 0 ) },
	[4] = { "Main", Vector( 6.7, -10.6, 0.15 ), Angle( 0, -90, 0 ) },

	[5] = { "Main", Vector( 6.7, 17.4, 0.15 ), Angle( 0, -90, 0 ) },
	[6] = { "Main", Vector( 6.7, -17.4, 0.15 ), Angle( 0, -90, 0 ) },

	[7] = { "Narrow", Vector( 6.49, 22.9, 0.15 ), Angle( 0, -79, 0 ), Width = 2.5 },
	[8] = { "Narrow", Vector( 6.49, -22.9, 0.15 ), Angle( 0, -101, 0 ), Width = 2.5 },

	[9] = { "Narrow", Vector( 5.3, 25.8, 0.15 ), Angle( 0, -56, 0 ), Width = 2.5 },
	[10] = { "Narrow", Vector( 5.3, -25.8, 0.15 ), Angle( 0, -124, 0 ), Width = 2.5 },

	[11] = { "Narrow", Vector( 3.3, 28, 0.15 ), Angle( 0, -28, 0 ), Width = 1.9 },
	[12] = { "Narrow", Vector( 3.3, -28, 0.15 ), Angle( 0, -152, 0 ), Width = 1.9 },

	[13] = { "Narrow", Vector( 0, 28.8, 0.15 ), Angle( 0, 0, 0 ), Width = 2.4 },
	[14] = { "Narrow", Vector( 0, -28.8, 0.15 ), Angle( 0, -180, 0 ), Width = 2.4 },

	[15] = { "Narrow", Vector( -3.3, 28, 0.15 ), Angle( 0, 28, 0 ), Width = 1.9 },
	[16] = { "Narrow", Vector( -3.3, -28, 0.15 ), Angle( 0, 152, 0 ), Width = 1.9 },

	[17] = { "Narrow", Vector( -5.3, 25.8, 0.15 ), Angle( 0, 56, 0 ), Width = 2.5 },
	[18] = { "Narrow", Vector( -5.3, -25.8, 0.15 ), Angle( 0, 124, 0 ), Width = 2.5 },

	[19] = { "Narrow", Vector( -6.49, 22.9, 0.15 ), Angle( 0, 79, 0 ), Width = 2.5 },
	[20] = { "Narrow", Vector( -6.49, -22.9, 0.15 ), Angle( 0, 101, 0 ), Width = 2.5 },

	[21] = { "Main", Vector( -6.7, 17.4, 0.15 ), Angle( 0, 90, 0 ) },
	[22] = { "Main", Vector( -6.7, -17.4, 0.15 ), Angle( 0, 90, 0 ) },

	[23] = { "Main", Vector( -6.7, 10.6, 0.15 ), Angle( 0, 90, 0 ) },
	[24] = { "Main", Vector( -6.7, -10.6, 0.15 ), Angle( 0, 90, 0 ) },

	[25] = { "Main", Vector( -6.7, 3.85, 0.15 ), Angle( 0, 90, 0 ) },
	[26] = { "Main", Vector( -6.7, -3.85, 0.15 ), Angle( 0, 90, 0 ) },

	[27] = { "HotFoot", Vector( 7.2, 28, -2.4 ), Angle( 0, -90, 0 ) },
	[28] = { "HotFoot", Vector( 7.2, -28, -2.4 ), Angle( 0, -90, 0 ) },

	[29] = { "HotFoot", Vector( -4.5, 31, -2.4 ), Angle( 0, -10, 0 ) },
	[30] = { "HotFoot", Vector( -4.5, -31, -2.4 ), Angle( 0, 190, 0 ) },

	[31] = { "TakedownIllumination", Vector( 6.7, 0, 0.15 ), Angle( 0, -90, 0 ) },

	[32] = { "AlleyIllumination", Vector( 0, 28.8, 0.15 ), Angle( 15, 0, 0 ) },
	[33] = { "AlleyIllumination", Vector( 0, -28.8, 0.155 ), Angle( 15, -180, 0 ) },
}

COMPONENT.ElementGroups = {
	["#A"] = { 1, 2, 25, 26 },
	["#B"] = { 3, 4, 23, 24 },
	["#C"] = { 5, 6, 21, 22 },
	["#D"] = { 7, 9, 11, 15, 17, 19, 8, 10, 12, 16, 18, 20 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33",
			[2] = "5 7 9 11 16 18 20 22",
			[3] = "6 8 10 12 15 17 19 21",
		},
		Sequences = {
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 2, 3, 8 )
		}
	},
	P1 = {
		Frames = {
			[1] = "5 7 9 11 16 18 20 22",
			[2] = "6 8 10 12 15 17 19 21",
		},
		Sequences = {
			["P1"] = sequence():Alternate( 1, 2, 8 )
		}
	},
	SignalMaster = {
		Frames = {
			[1] = "21",
			[2] = "21 23",
			[3] = "21 23 25",
			[4] = "21 23 25 26",
			[5] = "21 23 25 26 24",
			[6] = "21 23 25 26 24 22",
			[7] = "22",
			[8] = "24 22",
			[9] = "26 24 22",
			[10] = "25 26 24 22",
			[11] = "23 25 26 24 22",
			[12] = "21 23 25 26 24 22",
			[13] = "25 26",
			[14] = "23 25 26 24",
			[15] = "21 23 25 26 24 22",
		},
		Sequences = {
			["RIGHT"] = sequence():Add( 0 ):Sequential( 1, 6 ):StretchAll( 3 ):Hold( 8 ),
			["LEFT"] = sequence():Add( 0 ):Sequential( 7, 12 ):StretchAll( 3 ):Hold( 8 ),
			["CENOUT"] = sequence():Add( 0 ):Sequential( 13, 15 ):StretchAll( 5 ):Hold( 8 )
		}
	},
	Corner = {
		Frames = {
			[1] = "7 9 11 15 17 19",
			[2] = "8 10 12 16 18 20",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 4 )
		}
	},
	Warning = {
		FrameDuration = 1/44,
		Frames = {
			[1] = "4 6 8 10 12 13 15 17 19 21 23 25",
			[2] = "14 16 18 20 22 24 26 3 5 7 9 11 ",
		},
		Sequences = {
			["P22"] = { 1, 1, 0, 2, 2, 0 }
		}
	},
	P20 = {
		FrameDuration = 1/48,
		Frames = {
			-- Sweep
			[1] = "#A",
			[2] = "#A #B",
			[3] = "#A #B #C",
			[4] = "#A #B #C #D",
			[5] = "#B #C #D",
			[6] = "#C #D",
			[7] = "#D",
			-- Interrupt
			[8] = "#C #D",
			[9] = "#A #C #D",
			[10] = "#A #B",
			[11] = "#A #B #C #D",
			[12] = "#A #C #D",
			[13] = "#C #D",
			[14] = "#B #C #D",
			[15] = "#B #C"
		},
		Sequences = {
			["P20"] = sequence()
				:Sequential( 1, 4 ):Hold( 3 ):Sequential( 4, 7 ):Add( 0 ):Hold( 3 )
				:Sequential( 7, 4 ):Hold( 3 ):Sequential( 4, 1 ):Add( 0 ):Hold( 3 )
				:Sequential( 1, 4 ):Hold( 3 ):Sequential( 4, 7 ):Add( 0 ):Hold( 3 )
				:Sequential( 7, 4 ):Hold( 3 ):Sequential( 4, 1 ):Add( 0 ):Hold( 3 )
				:Sequential( 1, 4 ):Hold( 3 ):Sequential( 4, 7 ):Add( 0 ):Hold( 3 )
				:Sequential( 7, 4 ):Hold( 3 ):Sequential( 4, 1 ):Add( 0 ):Hold( 3 )
				:Add( 8, 0, 8, 9, 0, 10, 10, 11, 12, 0, 13, 13, 14, 0, 15, 15 ):Stretch( 2 )
		}
	},
	Inner = {
		Frames = {
			[1] = "3 5 21 23 25",
			[2] = "4 6 22 24 26",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 2 )
		}
	},
	Takedown = {
		Frames = {
			[1] = "1",
			[2] = "2",
		},
		Sequences = {
			["OFF"] = { 0 },
			["ALT"] = sequence():Alternate( 1, 2, 3 )
		}
	},
	Alley = {
		Frames = {
			[1] = "13",
			[2] = "14",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 8 )
		}
	},
	ForwardHotFeet = {
		Frames = {
			[1] = "27",
			[2] = "28",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 2 )
		}
	},
	AlleyHotFeet = {
		Frames = {
			[1] = "29",
			[2] = "30",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 2, 1, 3 )
		}
	},
	SceneForward = {
		Frames = {
			[1] = "1 2 27 28 31",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	SceneLeft = {
		Frames = {
			[1] = "13 29 32",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	SceneRight = {
		Frames = {
			[1] = "14 30 33",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
}

COMPONENT.Patterns = {
	["P1"] = {
		{ "P1", "P1" }
	},
	["P20"] = {
		{ "P20", "P20" },
		{ "Takedown", "OFF" },
	},
	["P20W"] = {
		{ "P20", "P20" },
		{ "Takedown", "ALT" },
		{ "Alley", "ALT" },
		{ "ForwardHotFeet", "ALT" },
		{ "AlleyHotFeet", "ALT" },
	},
	["P22"] = {
		{ "Warning", "P22" },
		{ "Takedown", "OFF" },
	},
	["P22W"] = {
		{ "Warning", "P22" },
		{ "Takedown", "ALT" },
		{ "Alley", "ALT" },
		{ "ForwardHotFeet", "ALT" },
		{ "AlleyHotFeet", "ALT" },
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = "P1",
		["MODE2"] = "P1",
		["MODE3"] = "P20W",
	},
	["Emergency.Directional"] = {
		["LEFT"] = { SignalMaster = "LEFT" },
		["RIGHT"] = { SignalMaster = "RIGHT" },
		["CENOUT"] = { SignalMaster = "CENOUT" },
	},
	["Emergency.SceneForward"] = {
		["ON"] = { SceneForward = "ON" },
		["FLOOD"] = { SceneForward = "ON" },
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { SceneLeft = "ON" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { SceneRight = "ON" }
	}
}