if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SuperMighty",
	Code = "Schmal"
}

COMPONENT.Title = [[Whelen Liberty II (48")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/supermighty/whelen_liberty_ii.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 0.9
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "A",
	[4] = "A",
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 	= 8.7,
			Height	= 8.5,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_detail.png").MaterialName,
			Scale = 2
		},
		Corner = {
			Width 	= 12.2,
			Height	= 16,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_detail.png").MaterialName,
		},
		Takedown = {
			Width 	= 7.4,
			Height	= 7.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_6x2_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_6x2_detail.png").MaterialName,
			Scale = 1
		},
		Half = {
			Width 	= 4.4,
			Height	= 4.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_half_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_half_detail.png").MaterialName,
		},
		Alley = {
			Width 	= 3.2,
			Height	= 3.2,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_alley_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_alley_shape.png").MaterialName,
		},
		CornerEdge = {
			Width 	= 4.9,
			Height	= 4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_shape.png").MaterialName,
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_detail.png").MaterialName,
		},
		["Projected"] = {
			TakedownIllumination = {
				Brightness = 2
			},
			AlleyIllumination = {}
		}
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 2,
			FOV = 60,

		},
		AlleyIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 1.5,
			FOV = 80,
		},
		Flood = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 5,
			HorizontalFOVFOV = 130,
			VerticalFOV = 60,
			NearZ = 140
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 6.33, 4.3, 0.36 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 6.33, -4.3, 0.36 ), Angle( 0, -90, 0 ) },

	-- Middle
	[3] = { "Takedown", Vector( 6.33, 11.37, 0.4 ), Angle( 0, -90, 0 ) },
	[4] = { "Takedown", Vector( 6.33, -11.37, 0.4 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 6.33, 18.44, 0.36 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 6.33, -18.44, 0.36 ), Angle( 0, -90, 0 ) },

	[7] = { "Corner", Vector( 4.18, 26.5, 0.39 ), Angle( 0, -90 + 45.9, 0 ) },
	[8] = { "Corner", Vector( 4.18, -26.5, 0.39 ), Angle( 0, -90 - 45.9, 0 ) },

	[9] = { "Corner", Vector( -4.18, 26.5, 0.39 ), Angle( 0, 90 - 45.9, 0 ) },
	[10] = { "Corner", Vector( -4.18, -26.5, 0.39 ), Angle( 0, 90 + 45.9, 0 ) },

	[11] = { "Primary", Vector( -6.33, 18.44, 0.36 ), Angle( 0, 90, 0 ) },
	[12] = { "Primary", Vector( -6.33, -18.44, 0.36 ), Angle( 0, 90, 0 ) },

	[13] = { "Primary", Vector( -6.33, 11.37, 0.36 ), Angle( 0, 90, 0 ) },
	[14] = { "Primary", Vector( -6.33, -11.37, 0.36 ), Angle( 0, 90, 0 ) },

	[15] = { "Primary", Vector( -6.33, 4.3, 0.36 ), Angle( 0, 90, 0 ) },
	[16] = { "Primary", Vector( -6.33, -4.3, 0.36 ), Angle( 0, 90, 0 ) },

	[17] = { "Alley", Vector( 0, 28.8, 0.38 ), Angle( 0, 0, 0 ) },
	[18] = { "Alley", Vector( 0, -28.8, 0.38 ), Angle( 0, 180, 0 ) },

	[19] = { "CornerEdge", Vector( 6.33, 23.79, 0.36 ), Angle( 0, -90, 0 ) },
	[20] = { "CornerEdge", Vector( 6.33, -23.79, 0.36 ), Angle( 0, -90, 0 ), Width = -4.9 },

	[21] = { "CornerEdge", Vector( 1.4, 28.52, 0.39 ), Angle( 0, 0, 0 ), Width = -4.9 },
	[22] = { "CornerEdge", Vector( 1.4, -28.52, 0.39 ), Angle( 0, 180, 0 ) },

	[23] = { "CornerEdge", Vector( -1.4, 28.52, 0.39 ), Angle( 0, 0, 0 ) },
	[24] = { "CornerEdge", Vector( -1.4, -28.52, 0.39 ), Angle( 0, 180, 0 ), Width = -4.9  },

	[25] = { "CornerEdge", Vector( -6.33, 23.79, 0.36 ), Angle( 0, 90, 0 ), Width = -4.9  },
	[26] = { "CornerEdge", Vector( -6.33, -23.79, 0.36 ), Angle( 0, 90, 0 ) },

	[27] = { "AlleyIllumination", Vector( 0, 28.8, 0.38 ), Angle( 0, 0, 0 ) },
	[28] = { "AlleyIllumination", Vector( 0, -28.8, 0.38 ), Angle( 0, 180, 0 ) },

	-- Middle
	[29] = { "TakedownIllumination", Vector( 6.33, 11.37, 0.4 ), Angle( 0, -90, 0 ) },
	[30] = { "TakedownIllumination", Vector( 6.33, -11.37, 0.4 ), Angle( 0, -90, 0 ) },

	-- Flood
	[31] = { "Flood", Vector( 10, 0, 1 ), Angle( 2, -90, 0 ) },

}

COMPONENT.StateMap = "[1] 1 5 7 9 19 21 23 25 [2] 2 6 8 10 20 22 24 26 [1/3] 11 13 15 [2/4] 12 14 16 [W] 3 4 17 18 27 28 29 30"

COMPONENT.ElementGroups = {
	FLCorner = { 7, 19, 21 },
	FRCorner = { 8, 20, 22 },
	RLCorner = { 9, 23, 25 },
	RRCorner = { 10, 24, 26 },
	LCorner = { 7, 9, 19, 21, 23, 25 },
	RCorner = { 8, 20, 22, 10, 24, 26 },
	TakedownLeft = { 3 },
	TakedownRight = { 4 },
	TakedownLeftIllum = { 29 },
	TakedownRightIllum = { 30 },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Main = {
		Frames = {
			[1] = "1 5 7 9 11 13 15 19 21 23 25",
			[2] = "2 6 8 10 12 14 16 20 22 24 26",
			[3] = "1 19 7 21 11 15 14 26 10 24 6",
			[4] = "2 20 8 22 12 16 13 25 9 23 5",
			[5] = "11 15 14 26 10 24",
			[6] = "12 16 13 25 9 23"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 8 ),
			["MIX_ALT"] = { 3, 3, 0, 4, 4, 0 },
			["MIX_ALT_REAR"] = { 5, 5, 0, 6, 6, 0 }
		}
	},
	Corner = {
		Frames = {
			[1] = "7 8 9 10",
			[2] = "7 8 9 10"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 4 )
		}
	
	},
	Takedown = {
		Frames = {
			[1] = "3",
			[2] = "4",
			[3] = "3 4",
			[4] = "TakedownLeft TakedownLeftIllum TakedownRight TakedownRightIllum"
		},
		Sequences = {
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 1, 2 ),
			["ILLUM"] = { 4 }
		}
	},
	Alley = {
		Frames = {
			[1] = "17",
			[2] = "18",
			[3] = "17 18"
		},
		Sequences = {
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 1, 2 )
		}
	},
	Flood = {
		Frames = {
			[1] = "[W] 31 TakedownLeft TakedownRight FLCorner FRCorner 1 2 5 6"
		},
		Sequences = {
			["FLOOD"] = { 1 }
		}
	},
	AlleyLeft = {
		Frames = {
			[1] = "17 27",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	AlleyRight = {
		Frames = {
			[1] = "18 28",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Marker = {
		Frames = {
			[1] = "LCorner RCorner"
		},
		Sequences = {
			["CORNER"] = { 1 }
		}
	},
	FrontCut = {
		Frames = {
			[1] = "[OFF] 1 2 3 4 5 6 FLCorner FRCorner 17 18 27 28",
		},
		Sequences = {
			["CUT"] = { 1 },
		}
	},
	RearCut = {
		Frames = {
			[1] = "[OFF] 11 12 13 14 15 16 RLCorner RRCorner 17 18 27 28",
		},
		Sequences = {
			["CUT"] = { 1 },
		}
	},
	Traffic = {
		Frames = {
			[1] = "[2] 12",
			[2] = "[2] 14",
			[3] = "[2] 16",
			[4] = "[2] 15",
			[5] = "[2] 13",
			[6] = "[2] 11",
			[7] = "[2] 15 16",
			[8] = "[2] 13 14",
			[9] = "[2] 11 12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 6 ):Stretch( 2 ):Hold( 1 ):Alternate( 0, 6, 4):Do( 2 ):Off( 1 ),
			["RIGHT"] = sequence():Sequential( 6, 1 ):Stretch( 2 ):Hold( 1 ):Alternate( 0, 1, 4):Do( 2 ):Off( 1 ),
			["CENOUT"] = sequence():Sequential( 7, 9 ):Stretch( 3 ):Hold( 1 ):Alternate( 0, 9, 4):Do( 2 ):Off( 1 ),
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Main = "MIX_ALT_REAR" },
		["MODE2"] = { Main = "MIX_ALT" },
		["MODE3"] = { 
			Main = "MIX_ALT",
			Takedown = "DOUBLE_FLASH",
			Alley = "DOUBLE_FLASH"
		},
	},
	["Emergency.SceneForward"] = {
		["ON"] = { 
			Takedown = "ILLUM" 
		},
		["FLOOD"] = {
			Flood = "FLOOD"
		}
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {
			AlleyLeft = "ON"
		}
	},
	["Emergency.SceneRight"] = {
		["ON"] = {
			AlleyRight = "ON"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = { Marker = "CORNER" }
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