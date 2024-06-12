if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Twurtleee, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Integrity (44")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_integrity_44.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.DefineOptions = {
	["HotFeet"] = {
		Arguments = { { "enabled", "boolean" } },
		Description = "Enables or disables the HotFeet.",
		Action = function( self, enabled )
			self.BodyGroups = self.BodyGroups or {}
			if ( !enabled ) then
				self.BodyGroups["44in_feet"] = 1
				self.BodyGroups["44in_straps"] = 1
			else
				self.BodyGroups["44in_feet"] = 0
				self.BodyGroups["44in_straps"] = 0
			end
		end
	},
	["Straps"] = {
		Arguments = { 
			{ "distance", "number" },
			{ "rotation", "number" },
			{ "scale", "number" }
		 },
		Description = "Adjusts side strap positions for the plain feet body group.",
		Action = function( self, distance, rotation, scale )
			scale = scale or 1
			rotation = rotation or 0
			self.BodyGroups = self.BodyGroups or {}
			self.BodyGroups["44in_straps"] = 1
			self.Bones = self.Bones or {}
			self.Bones["44_strap_left"] = { Vector( distance, 0, 0 ), Angle( rotation, 0, 0 ), scale }
			self.Bones["44_strap_right"] = { Vector( -distance, 0, 0 ), Angle( -rotation, 0, 0 ), scale }
		end
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 6.2,
			Height		= 3.3,
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
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 1.5,
			FOV = 45
		},
		FloodIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 4
		},
	}
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 5.8, 2.7, 1.5 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 5.8, -2.7, 1.5 ), Angle( 0, -90, 0 ) },

	[3] = { "Primary", Vector( 5.8, 8.1, 1.5 ), Angle( 0, -90, 0 ) },
	[4] = { "Primary", Vector( 5.8, -8.1, 1.5 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 5.8, 13.47, 1.5 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 5.8, -13.47, 1.5 ), Angle( 0, -90, 0 ) },

	[7] = { "Primary", Vector( 5.8, 18.9, 1.5 ), Angle( 0, -90, 0 ) },
	[8] = { "Primary", Vector( 5.8, -18.9, 1.5 ), Angle( 0, -90, 0 ) },

	[9] = { "Primary", Vector( 3.9, 23.8, 1.5 ), Angle( 0, -90 + 44, 0 ), Width = 6.8 },
	[10] = { "Primary", Vector( 3.9, -23.8, 1.5 ), Angle( 0, -90 - 44, 0 ), Width = 6.8 },

	[11] = { "Primary", Vector( -1.01, 26.3, 1.5 ), Angle( 0, -90 + 80, 0 ), Width = 7.4 },
	[12] = { "Primary", Vector( -1.01, -26.3, 1.5 ), Angle( 0, -90 - 80, 0 ), Width = 7.4 },

	[13] = { "Primary", Vector( -6.01, 23.16, 1.5 ), Angle( 0, 90, 0 ) },
	[14] = { "Primary", Vector( -6.01, -23.16, 1.5 ), Angle( 0, 90, 0 ) },

	[15] = { "Primary", Vector( -6.01, 18.02, 1.5 ), Angle( 0, 90, 0 ) },
	[16] = { "Primary", Vector( -6.01, -18.02, 1.5 ), Angle( 0, 90, 0 ) },

	[17] = { "Primary", Vector( -6.01, 12.9, 1.5 ), Angle( 0, 90, 0 ) },
	[18] = { "Primary", Vector( -6.01, -12.9, 1.5 ), Angle( 0, 90, 0 ) },

	[19] = { "Primary", Vector( -6.01, 7.73, 1.5 ), Angle( 0, 90, 0 ) },
	[20] = { "Primary", Vector( -6.01, -7.73, 1.5 ), Angle( 0, 90, 0 ) },

	[21] = { "Primary", Vector( -6.01, 2.57, 1.5 ), Angle( 0, 90, 0 ) },
	[22] = { "Primary", Vector( -6.01, -2.57, 1.5 ), Angle( 0, 90, 0 ) },

	[23] = { "HotFoot", Vector( 7.3, -6.45, 1.1 ), Angle( 0, 180, 0 ), BoneParent = "44_hotfoot_left" },
	[24] = { "HotFoot", Vector( -7.3, -6.45, 1.1 ), Angle( 0, 180, 0 ), BoneParent = "44_hotfoot_right" },
	
	[25] = { "HotFoot", Vector( 9.85, 4.05, 1.125 ), Angle( 0, -100, 0 ), BoneParent = "44_hotfoot_left" },
	[26] = { "HotFoot", Vector( -9.85, 4.05, 1.125 ), Angle( 0, 100, 0 ), BoneParent = "44_hotfoot_right" },

	[27] = { "TakedownIllumination",  Vector( -0.64, 13.47, 1.2 ), Angle( 0, -90, 0 ) },
	[28] = { "TakedownIllumination",  Vector( -0.64, -13.47, 1.2 ), Angle( 0, -90, 0 ) },

	[29] = { "TakedownIllumination", Vector( -7.06, 26.7, 1.2 ), Angle( 0, -11, 0 ) },
	[30] = { "TakedownIllumination", Vector( -7.06, -26.7, 1.2 ), Angle( 0, 180 + 11, 0 ) },

	[31] = { "FloodIllumination", Vector( 10, 0, 1.2 ), Angle( 0, -90, 0 ), FOV = 90, Brightness = 1.5, Material = "photon/flashlight/wide.png" }
}

COMPONENT.StateMap = "[1/W] 1 3 5 7 9 11 13 15 17 19 21 23 25 [2/W] 2 4 6 8 10 12 14 16 18 20 22 24 26 [W] 27 28 29 30 31"

local sequence = Photon2.SequenceBuilder.New()

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
			[2] = "1 3 5 7 9 11 13 15 17 19 21 23 25",
			[3] = "2 4 6 8 10 12 14 16 18 20 22 24 26",
			[4] = "1 5 9 13 17 21 24 20 16 12 8 4",
			[5] = "2 6 10 14 18 22 23 19 15 11 7 3"
		},
		Sequences = {
			["ON"] = { 1 },
			["TRI_FLASH"] = sequence():TripleFlash( 2, 3 ),
			["QUAD_FLASH"] = sequence():QuadFlash( 2, 3 ),
			["ALT"] = sequence():Alternate( 2, 3 ):SetTiming( 1 ),
			["MIX"] = sequence():FlashHold( { 4, 5 }, 2, 3 )
		}
	},
	Rear = {
		Frames = {
			[1] = "13 15 17 22 20 18",
			[2] = "17 19 21 18 16 14",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():FlashHold( { 1, 2 }, 3, 3 )
		}
	},
	["Pursuit"] = {
		Frames = {
			[0] = "[PASS] 1 2 3 4 5 6 7 8 9 10 11 12 [OFF] 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
			[1] = "1 5 9 13 17 21 25 4 8 12 16 20 24",
			[2] = "3 7 11 15 19 23 2 6 10 14 18 22 26",
			[3] = "1 3 5 7 9 11 13 15 17 19 21 23 25",
			[4] = "2 4 6 8 10 12 14 16 18 20 22 24 26"
		},
		Sequences = {
			["PURSUIT"] = sequence()
							:Alternate( 3, 4, 6 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:Alternate( 1, 2, 3 ):Do( 3 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:FlashHold( 1, 3, 2 )
							:FlashHold( 2, 3, 2 )
						}
	},
	["White"] = {
		Frames = {
			[1] = "[W] 1 5 9 4 8 12",
			[2] = "[W] 3 7 11 2 6 10",
			[3] = "[W] 1 3 5 7 9 11",
			[4] = "[W] 2 4 6 8 10 12"
		},
		Sequences = {
			["PURSUIT"] = sequence()
							:Alternate( 4, 3, 6 ):Add( 0 )
							:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
							:Alternate( 2, 1, 3 ):Add( 0 ):Do( 3 )
							:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
							:FlashHold( 2, 3, 1 ):Add( 0 )
							:FlashHold( 1, 3, 1 ):Add( 0 ),
			["OFF"] = {}
		}
	},
	["Takedown"] = {
		Frames = {
			[1] = "[W] 5 6 27 28"
		},
		Sequences = {
			["TAKEDOWN"] = { 1 }
		}
	},
	["Flood"] = {
		Frames = {
			[1] = "[W] 1 2 3 4 5 6 7 8 9 10 31"
		},
		Sequences = {
			["FLOOD"] = { 1 }
		}
	},
	["LeftAlley"] = {
		Frames = {
			[1] = "[W] 9 11 29"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["RightAlley"] = {
		Frames = {
			[1] = "[W] 10 12 30"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["Marker"] = {
		Frames = {
			[1] = "7 8 9 10 11 12 13 14",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	["FrontCut"] = {
		Frames = {
			[1] = "[OFF] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 25 26 27 28 29 30 31",
		},
		Sequences = {
			["ENABLED"] = { 1 },
		}
	},
	["RearCut"] = {
		Frames = {
			[1] = "[OFF] 13 14 15 16 17 18 19 20 21 22",
		},
		Sequences = {
			["ENABLED"] = { 1 },
		}
	},
	["SignalMaster"] = Photon2.SegmentBuilder.SignalMaster( 15, 17, 19, 21, 22, 20, 18, 16 )
}

COMPONENT.Patterns = {
	["PURSUIT"] = {
		{ "Pursuit", "PURSUIT" },
	},
	["PURSUIT_W"] = {
		{ "White", "PURSUIT" },
		{ "Pursuit", "PURSUIT" },
	},
}

COMPONENT.Features = {
	ParkMode = true
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Rear = "FLASH"
		},
		["MODE2"] = {
			All = "QUAD_FLASH"
		},
		["MODE3"] = "PURSUIT_W"
		
	},
	["Emergency.ParkedWarning"] = {
		["MODE3"] = {
			White = "OFF"
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = { SignalMaster = "LEFT" },
		["RIGHT"] = { SignalMaster = "RIGHT" },
		["CENOUT"] = { SignalMaster = "CENOUT" },
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { LeftAlley = "ON" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { RightAlley = "ON" }
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "TAKEDOWN",
		},
		["FLOOD"] = {
			Flood = "FLOOD"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = { Marker = "ON" }
	},
	["Emergency.Cut"] = {
		["FRONT"] = { FrontCut = "ENABLED" },
		["REAR"] = { RearCut = "ENABLED" }
	},
}