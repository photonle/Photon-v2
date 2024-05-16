if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Tyler Designs, Roegen, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Whelen Liberty (48")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/whelen_liberty_48.mdl"

local w = 9.3
local h = w/2

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "R",
	[4] = "B"
}

COMPONENT.Templates = {
	["2D"] = {
		["Main"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_detail.png").MaterialName,
			Width = w,
			Height = h,
			Scale = 1.8,
			Ratio = 1.5
		},
		["Corner"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_corner_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_corner_detail.png").MaterialName,
			Width = w * 1.1,
			Height = h * 1.1,
			Ratio = 1.6,
			Scale = 2
		},
		["Takedown"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_shape.png").MaterialName,
			Width = 2,
			Height = 2,
			Scale = 1.5
		},
		["TakedownDouble"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_dbl_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_dbl_shape.png").MaterialName,
			Width = 7,
			Height = 3.5,
			Scale = 1.5
		},
		["TakedownFull"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_full_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_lib_tkdn_full_shape.png").MaterialName,
			Width = 7,
			Height = 3.5,
			Scale = 1.5
		}
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 2
		},
		-- Inner takedown only uses one projected texture
		InnerTakedown = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 4
		},
	}
}

COMPONENT.StateMap = "[1] 1 3 5 7 [3] 9 11 13 15 [2] 2 4 6 8 10 [4] 12 14 16"

-- This model is so realistic, the modules aren't even centered accurately :)
COMPONENT.Elements = {
	[1] = { "Main", Vector( 8.6, 4.02, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 0 } },
	[2] = { "Main", Vector( 8.6, -4.1, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 0 } },

	[3] = { "Main", Vector( 8.6, 12.08, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 0 }  },
	[4] = { "Main", Vector( 8.6, -12.15, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 0 } },

	[5] = { "Main", Vector( 8.6, 20.04, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 0 } },
	[6] = { "Main", Vector( 8.6, -20.1, 1.35 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 0 } },

	[7] = { "Corner", Vector( 4.9, 30, 1.35 ), Angle( 0, -90 + 36, 0 ) },
	[8] = { "Corner", Vector( 4.9, -30, 1.35 ), Angle( 0, -90 - 36, 0 ) },

	[9] = { "Corner", Vector( -4.9, 30, 1.35 ), Angle( 0, 90 - 36, 0 ) },
	[10] = { "Corner", Vector( -4.9, -30, 1.35 ), Angle( 0, 90 + 36, 0 ) },

	[11] = { "Main", Vector( -8.6, 20.1, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_inner"] = 0 } },
	[12] = { "Main", Vector( -8.6, -20.04, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_inner"] = 0 } },

	[13] = { "Main", Vector( -8.6, 12.15, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_middle"] = 0 } },
	[14] = { "Main", Vector( -8.6, -12.08, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_middle"] = 0 } },

	[15] = { "Main", Vector( -8.6, 4.1, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_outer"] = 0 } },
	[16] = { "Main", Vector( -8.6, -4.02, 1.35 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["rear_outer"] = 0 } },

	[17] = { "Takedown", Vector( 0, 34.2, 1.37 ), Angle( 0, 0, 0 ) },
	[18] = { "Takedown", Vector( 0, -34.2, 1.37 ), Angle( 0, 180, 0 ) },

	[19] = { "Takedown", Vector( 8.6, 4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 1 } },
	[20] = { "Takedown", Vector( 8.6, -4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 1 } },

	[21] = { "TakedownDouble", Vector( 8.6, 4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 2 } },
	[22] = { "TakedownDouble", Vector( 8.6, -4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 2 } },

	[23] = { "TakedownFull", Vector( 8.4, 4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 3 } },
	[24] = { "TakedownFull", Vector( 8.4, -4.05, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = 3 } },

	[25] = { "Takedown", Vector( 8.6, 12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 1 } },
	[26] = { "Takedown", Vector( 8.6, -12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 1 } },

	[27] = { "TakedownDouble", Vector( 8.6, 12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 2 } },
	[28] = { "TakedownDouble", Vector( 8.6, -12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 2 } },

	[29] = { "TakedownFull", Vector( 8.4, 12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 3 } },
	[30] = { "TakedownFull", Vector( 8.4, -12.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = 3 } },

	[31] = { "Takedown", Vector( 8.6, 20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 1 } },
	[32] = { "Takedown", Vector( 8.6, -20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 1 } },

	[33] = { "TakedownDouble", Vector( 8.6, 20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 2 } },
	[34] = { "TakedownDouble", Vector( 8.6, -20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 2 } },

	[35] = { "TakedownFull", Vector( 8.4, 20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 3 } },
	[36] = { "TakedownFull", Vector( 8.4, -20.07, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = 3 } },

	[37] = { "TakedownIllumination", Vector( 8.6, 16.5, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = { 1, 2, 3 } } },
	[38] = { "TakedownIllumination", Vector( 8.6, -16.5, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_outer"] = { 1, 2, 3 } } },
	
	[39] = { "TakedownIllumination", Vector( 8.6, 10.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = { 1, 2, 3 } } },
	[40] = { "TakedownIllumination", Vector( 8.6, -10.1, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_middle"] = { 1, 2, 3 } } },
	
	[41] = { "TakedownIllumination", Vector( 0, 34.2, 1.37 ), Angle( 0, 0, 0 ) },
	[42] = { "TakedownIllumination", Vector( 0, -34.2, 1.37 ), Angle( 0, 180, 0 ) },
	
	[43] = { "TakedownIllumination", Vector( 8.6, 0, 1.38 ), Angle( 0, -90, 0 ), RequiredBodyGroups = { ["front_inner"] = { 1, 2, 3 } } },

}

COMPONENT.ElementGroups = {
	["TakedownLeft"] = { 19, 21, 23, 25, 27, 29, 31, 33, 35 },
	["TakedownRight"] = { 20, 22, 24, 26, 28, 30, 32, 34, 36 },
	["TakedownLeftIllum"] = { 37, 39, 43 },
	["TakedownRightIllum"] = { 38, 40, 43 },
	["AlleyLeft"] = { 17 },
	["AlleyRight"] = { 18 },
	["AlleyLeftIllum"] = { 41 },
	["AlleyRightIllum"] = { 42 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 [W] 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43",
			[2] = "1 3 5 7 9 11 13 15",
			[3] = "2 4 6 8 10 12 14 16",
			-- [1] = "17 18",
		},
		Sequences = {
			["ON"] = { 1 },
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 2, 3 ),
			["TRIPLE_FLASH"] = sequence():TripleFlash( 2, 3 ),
		}
	},
	Takedown = {
		Frames = {
			[1] = "[W] TakedownLeft",
			[2] = "[W] TakedownRight",
			[3] = "[W] TakedownLeft TakedownRight TakedownLeftIllum TakedownRightIllum"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 7 ),
			["TRIPLE_FLASH"] = sequence():TripleFlash( 1, 2 ),
			["ILLUM"] = { 3 }
		}
	},
	Alley = {
		Frames = {
			[1] = "[W] AlleyLeft",
			[2] = "[W] AlleyRight",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 7 ),
			["TRIPLE_FLASH"] = sequence():TripleFlash( 1, 2 ),
		}
	},
	AlleyLeft = {
		Frames = {
			[1] = "[W] AlleyLeft",
			[2] = "[W] AlleyLeft AlleyLeftIllum"
		},
		Sequences = {
			["ON"] = { 1 },
			["ILLUM"] = { 2 }
		}
	},
	AlleyRight = {
		Frames = {
			[1] = "[W] AlleyRight",
			[2] = "[W] AlleyRight AlleyRightIllum"
		},
		Sequences = {
			["ON"] = { 1 },
			["ILLUM"] = { 2 }
		}
	},
	Marker = {
		Frames = {
			[1] = "7 8 9 10",
		},
		Sequences = {
			["CORNER"] = { 1 },
		}
	},
	Traffic = {
		Frames = {
			[1] = "12",
			[2] = "14",
			[3] = "16",
			[4] = "15",
			[5] = "13",
			[6] = "11",
			[7] = "15 16",
			[8] = "13 14",
			[9] = "11 12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 6 ):Stretch( 2 ):Hold( 1 ):Alternate( 0, 6, 4):Do( 2 ):Off( 1 ),
			["RIGHT"] = sequence():Sequential( 6, 1 ):Stretch( 2 ):Hold( 1 ):Alternate( 0, 1, 4):Do( 2 ):Off( 1 ),
			["CENOUT"] = sequence():Sequential( 7, 9 ):Stretch( 3 ):Hold( 1 ):Alternate( 0, 9, 4):Do( 2 ):Off( 1 ),
		}
	},
	AmberTrafficFill = {
		Frames = {
			[1] = "[A] 12",
			[2] = "[A] 12 14",
			[3] = "[A] 12 14 16",
			[4] = "[A] 12 14 16 15",
			[5] = "[A] 12 14 16 15 13",
			[6] = "[A] 12 14 16 15 13 11",
			[7] = "[A] 11",
			[8] = "[A] 11 13",
			[9] = "[A] 11 13 15",
			[10] = "[A] 11 13 15 16",
			[11] = "[A] 11 13 15 16 14",
			[12] = "[A] 11 13 15 16 14 12",
			[13] = "[A] 15 16",
			[14] = "[A] 13 15 16 14",
			[15] = "[A] 11 13 15 16 14 12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 6 ):Add( 5, 6, 5, 6, 5, 6 ):Off( 1 ):StretchAll( 3 ),
			["RIGHT"] = sequence():Sequential( 7, 12 ):Add( 11, 12, 11, 12, 11, 12 ):Off( 1 ):StretchAll( 3 ),
			["CENOUT"] = sequence():Sequential( 13, 15 ):Add( 14, 15, 14, 15 ):Off( 1 ):StretchAll( 4 ),
		}
	},
	FrontCut = {
		Frames = {
			[1] = "[OFF] 1 2 3 4 5 6 7 8 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43",
		},
		Sequences = {
			["CUT"] = { 1 },
		}
	},
	RearCut = {
		Frames = {
			[1] = "[OFF] 17 9 11 13 15 16 14 12 10 17 18",
		},
		Sequences = {
			["CUT"] = { 1 },
		}
	},
	Rear = {
		Frames = {
			[1] = "9 11 13 15",
			[2] = "10 12 14 16",
		},
		Sequences = {
			["ON"] = { 1 },
			["TRIPLE_FLASH"] = sequence():TripleFlash( 1, 2 ),
		}
	}
}

COMPONENT.Patterns = {
	["ALT_W"] = {
		{ "All", "TRIPLE_FLASH" },
		{ "Takedown", "TRIPLE_FLASH" },
		{ "Alley", "TRIPLE_FLASH:180"}
	},
	["ALT"] = {
		{ "All", "TRIPLE_FLASH" },
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { 
			Rear = "TRIPLE_FLASH"
		},
		["MODE2"] = {
			"ALT"
		},
		["MODE3"] = {
			"ALT_W"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ILLUM"
		},
		["FLOOD"] = {
			Takedown = "ILLUM"
		}
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {
			AlleyLeft = "ILLUM"
		},
	},
	["Emergency.SceneRight"] = {
		["ON"] = {
			AlleyRight = "ILLUM"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Marker = "CORNER"
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = {
			Traffic = "LEFT"
		},
		["RIGHT"] = {
			Traffic = "RIGHT"
		},
		["CENOUT"] = {
			Traffic = "CENOUT"
		}
	},
	["Emergency.Cut"] = {
		["FRONT"] = { FrontCut = "CUT" },
		["REAR"] = { RearCut = "CUT" },
	}
}