if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Twurtleee, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Integrity (51")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_integrity_51.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.Poses = {
	Height = {
		[""] = {}
	}
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 6.25,
			Height		= 3.4,
			-- Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
		},
		HotFoot = {
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.3,
			Height = 5.3/2,
			Scale = 1,
			States = {
				DW = { Inherit = "W", Intensity = 0.4 }
			},
			RequiredBodyGroups = {
				-- Requires HotFeet body-group
				[2] = 0
			}
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 5.8, 2.7, 1.5 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 5.8, -2.7, 1.5 ), Angle( 0, -90, 0 ) },

	[3] = { "Primary", Vector( 5.8, 8.1, 1.5 ), Angle( 0, -90, 0 ) },
	[4] = { "Primary", Vector( 5.8, -8.1, 1.5 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 5.8, 13.48, 1.5 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 5.8, -13.48, 1.5 ), Angle( 0, -90, 0 ) },

	[7] = { "Primary", Vector( 5.8, 18.76, 1.5 ), Angle( 0, -90, 0 ) },
	[8] = { "Primary", Vector( 5.8, -18.76, 1.5 ), Angle( 0, -90, 0 ) },

	[9] = { "Primary", Vector( 5.8, 24.08, 1.5 ), Angle( 0, -90, 0 ), Width = 6.3 },
	[10] = { "Primary", Vector( 5.8, -24.08, 1.5 ), Angle( 0, -90, 0 ), Width = 6.3 },

	[11] = { "Primary", Vector( 3.94, 28.82, 1.5 ), Angle( 0, -90 + 44, 0 ), Width = 6.9 },
	[12] = { "Primary", Vector( 3.94, -28.82, 1.5 ), Angle( 0, -90 - 44, 0 ), Width = 6.9 },

	[13] = { "Primary", Vector( -0.96, 31.36, 1.5 ), Angle( 0, -90 + 80, 0 ), Width = 7.5 },
	[14] = { "Primary", Vector( -0.96, -31.36, 1.5 ), Angle( 0, -90 - 80, 0 ), Width = 7.5 },

	[15] = { "Primary", Vector( -6.05, 28.35, 1.5 ), Angle( 0, 90, 0 ) },
	[16] = { "Primary", Vector( -6.05, -28.35, 1.5 ), Angle( 0, 90, 0 ) },

	[17] = { "Primary", Vector( -6.05, 23.2, 1.5 ), Angle( 0, 90, 0 ) },
	[18] = { "Primary", Vector( -6.05, -23.2, 1.5 ), Angle( 0, 90, 0 ) },

	[19] = { "Primary", Vector( -6.05, 18.04, 1.5 ), Angle( 0, 90, 0 ) },
	[20] = { "Primary", Vector( -6.05, -18.04, 1.5 ), Angle( 0, 90, 0 ) },

	[21] = { "Primary", Vector( -6.05, 12.9, 1.5 ), Angle( 0, 90, 0 ) },
	[22] = { "Primary", Vector( -6.05, -12.9, 1.5 ), Angle( 0, 90, 0 ) },

	[23] = { "Primary", Vector( -6.05, 7.73, 1.5 ), Angle( 0, 90, 0 ) },
	[24] = { "Primary", Vector( -6.05, -7.73, 1.5 ), Angle( 0, 90, 0 ) },

	[25] = { "Primary", Vector( -6.05, 2.57, 1.5 ), Angle( 0, 90, 0 ) },
	[26] = { "Primary", Vector( -6.05, -2.57, 1.5 ), Angle( 0, 90, 0 ) },

	[27] = { "HotFoot", Vector( 29.66, -6.5, -0.67 ), Angle( 0, 180, 0 ), BoneParent = "51_hotfoot_left" },
	[28] = { "HotFoot", Vector( -29.66, -6.5, -0.67 ), Angle( 0, 180, 0 ), BoneParent = "51_hotfoot_right" },
	
	[29] = { "HotFoot", Vector( 32.3, 4, -0.67 ), Angle( 0, -100, 0 ), BoneParent = "51_hotfoot_left" },
	[30] = { "HotFoot", Vector( -32.3, 4, -0.67 ), Angle( 0, 100, 0 ), BoneParent = "51_hotfoot_right" },
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30"

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Front = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "14 12 10 8 6 4 2",
			[2] = "1 3 5 7 9 11 13",
			[3] = "6 4 2 7 9 11 13",
			[4] = "14 12 10 8 3 5 7",
		},
		Sequences = {
			["Flash_Pattern_1"] = {
				2,2,2,2,2,2,2,2,2,2,
				1,1,1,1,1,1,1,1,1,1,
				2,2,2,2,2,2,2,2,2,2,
				1,1,1,1,1,1,1,1,1,1,

				3,3,0,0,3,3,0,0,3,3,3,3,3,0,0,0,0,4,4,0,0,4,4,0,0,4,4,4,0,0,0,0,
				3,3,0,0,3,3,0,0,3,3,3,3,3,0,0,0,0,4,4,0,0,4,4,0,0,4,4,4,0,0,0,0,
			},
		}
	},
	Rear = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "16 18 20 22 24 26",
			[2] = "25 23 21 19 17 15",
			[3] = "22 24 26 19 17 15",
			[4] = "16 18 20 23 21 19",
		},
		Sequences = {
			["Flash_Pattern_1"] = {
				2,2,2,2,2,2,2,
				1,1,1,1,1,1,1,
				2,2,2,2,2,2,2,
				1,1,1,1,1,1,1,
				2,2,2,2,2,2,2,
				1,1,1,1,1,1,1,
				-- Zig Zag
				3,3,0,0,3,3,0,0,3,3,3,3,3,0,0,4,4,0,0,4,4,0,0,4,4,0,0,
				3,3,0,0,3,3,0,0,3,3,3,3,3,0,0,4,4,0,0,4,4,0,0,4,4,0,0,
			},
		}
	},
	Front_ALT = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "14 12 10 8 6 4 2",
			[2] = "1 3 5 7 9 11 13",
		},
		Sequences = {
			["Flash_Pattern_2"] = sequence():Alternate(1, 2, 5)
		}
	},
	Rear_ALT = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "16 18 20 22 24 26",
			[2] = "25 23 21 19 17 15",
		},
		Sequences = {
			["Flash_Pattern_2"] = sequence():Alternate(1, 2, 5)
		}
	},
	HotfootF = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "28",
			[2] = "27",
		},
		Sequences = {
			["Flash_Pattern"] = sequence():Alternate(1, 2, 13)
		}
	},
	HotfootS = {
		FrameDuration = 1/30,
		Frames = {
			[1] = "30",
			[2] = "29",
		},
		Sequences = {
			["Flash_Pattern"] = sequence():Alternate(1, 2, 13)
		}
	},
	Traffic = Photon2.SegmentBuilder.SignalMaster(19,21,23,25,26,24,22,20)
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Rear_ALT = "Flash_Pattern_2",
		},
		["MODE2"] = {
			Front_ALT = "Flash_Pattern_2",
			Rear_ALT = "Flash_Pattern_2",
			HotfootF = "Flash_Pattern",
			HotfootS = "Flash_Pattern",
		},
		["MODE3"] = {
			Front = "Flash_Pattern_1",
			Rear = "Flash_Pattern_1",
			HotfootF = "Flash_Pattern",
			HotfootS = "Flash_Pattern",
		},
	},
	["Emergency.Directional"] = {
		["LEFT"] = { Traffic = "LEFT" },
		["RIGHT"] = { Traffic = "RIGHT" },
		["CENOUT"] = { Traffic = "CENOUT" },
	},
}