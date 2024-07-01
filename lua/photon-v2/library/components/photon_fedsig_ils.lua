if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Cj24, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal SpectraLux ILS]]
COMPONENT.Category = "Interior"
COMPONENT.Model = "models/schmal/fedsig_spectralux_ils.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.DefineOptions = {
	["Width"] = {
		Arguments = { { "width", "number" } },
		Description = "Sets the width between each side.",
		Action = function( self, width )
			-- TODO: verify this if this is necessary and/or works
			local scale = self.Scale or 1
			width = width * scale
			self.Bones = self.Bones or {}
			self.Bones["right"] = self.Bones["right"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["left"] = self.Bones["left"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["right"][1][1] = -width
			self.Bones["left"][1][1] = width
		end
	},
	["Angle"] = {
		Arguments = { { "angle", "number" } },
		Description = "Sets the outward angle of the lightbar.",
		Action = function( self, angle )
			local scale = self.Scale or 1
			self.Bones = self.Bones or {}
			self.Bones["right"] = self.Bones["right"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["left"] = self.Bones["left"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["right"][2][2] = -angle
			self.Bones["left"][2][2] = angle
		end
	}
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.2,
			Height		= 2,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.4,
			Ratio 		= 2,
			VisibilityRadius = 0.5
		},
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 1.5,
			VerticalFOV = 90,
			HorizontalFOV = 120
		},
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

COMPONENT.StateMap = "[1/2] 1 3 5 7 [2/1] 2 4 6 8 [W] 9 10"

-- yeah... these bones are fucking flipped

COMPONENT.Elements = {
	[1] = { "Primary", Vector( -5.7, -1.45, -0.63 ), Angle( 0, 180 + 16, 0 ), BoneParent = 2 },
	[2] = { "Primary", Vector( 5.7, -1.45, -0.63 ), Angle( 0, 180 - 16, 0 ), BoneParent = 1 },

	[3] = { "Primary", Vector( -1.7, -1.1, -0.63 ), Angle( 0, 180 - 6, 0 ), BoneParent = 2 },
	[4] = { "Primary", Vector( 1.7, -1.1, -0.63 ), Angle( 0, 180 + 6, 0 ), BoneParent = 1 },

	[5] = { "Primary", Vector( 2.31, -1.53, -0.63 ), Angle( 0, 180 - 6, 0 ), BoneParent = 2 },
	[6] = { "Primary", Vector( -2.31, -1.53, -0.63 ), Angle( 0, 180 + 6, 0 ), BoneParent = 1 },

	[7] = { "Primary", Vector( 6.55, -1.62, -0.63 ), Angle( 0, 180 + 5, 0 ), BoneParent = 2 },
	[8] = { "Primary", Vector( -6.55, -1.62, -0.63 ), Angle( 0, 180 - 5, 0 ), BoneParent = 1 },

	[9] = { "TakedownIllumination", Vector( 0, -1.62, -0.63 ), Angle( 0, 180, 0 ), BoneParent = 2 },
	[10] = { "TakedownIllumination", Vector( 0, -1.62, -0.63 ), Angle( 0, 180, 0 ), BoneParent = 1 },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8",
			[2] = "7 3 2 6",
			[3] = "5 1 4 8",

		},
		Sequences = {
			["ON"] = { 1 },
			["MIX"] = sequence():FlashHold( { 2, 3 }, 2, 4 ),
			["OFF"] = { 0 }
		}
	},
	Pursuit = {
		Off = "PASS",
		Frames = {
			[0] = "[PASS] 1 2 3 4 5 6 7 8",
			[1] = "6 2 1 5",
			[2] = "8 4 3 7",
			[3] = "1 3 5 7",
			[4] = "2 4 6 8"
		},
		Sequences = {
			["PURSUIT"] = sequence()
							:Alternate( 3, 4, 6 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:Alternate( 1, 2, 3 ):Do( 3 )
							:Alternate( 3, 4, 3 ):Do( 5 )
							:FlashHold( 1, 3, 1 )
							:FlashHold( 2, 3, 1 )
							:FlashHold( 1, 3, 1 )
							:FlashHold( 2, 3, 1 )
		}
	},
	["White"] = {
		Off = "PASS",
		Frames = {
			[1] = "[W] 6 2 1 5",
			[2] = "[W] 8 4 3 7",
			[3] = "[W] 1 3 5 7",
			[4] = "[W] 2 4 6 8"
		},
		Sequences = {
			["PURSUIT"] = sequence():Alternate( 4, 3, 6 ):Add( 0 )
				:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
				:Alternate( 2, 1, 3 ):Add( 0 ):Do( 3 )
				:Alternate( 4, 3, 3 ):Add( 0 ):Do( 5 )
				:FlashHold( 2, 3, 0 ):Add( 0 )
				:FlashHold( 1, 3, 0 ):Add( 0 )
				:FlashHold( 2, 3, 0 ):Add( 0 )
				:FlashHold( 1, 3, 0 ):Add( 0 ),
			["OFF"] = { 0 }
		}
	},
	["Illumination"] = {
		Off = "PASS",
		Frames = {
			[1] = "[W] 1 2 5 6 [W*0.5] 9 10",
			[2] = "[W] 1 2 3 4 5 6 7 8 9 10"
		},
		Sequences = {
			["TAKEDOWN"] = { 1 },
			["FLOOD"] = { 2 }
		}
	}
}

COMPONENT.Patterns = {
	["MIX_DOUBLE_FLASH"] = {
		{ "All", "MIX" }
	},
	["PURSUIT"] = {
		{ "Pursuit", "PURSUIT" },
	},
	["PURSUIT_W"] = {
		{ "White", "PURSUIT" },
		{ "Pursuit", "PURSUIT" },
	}
}

COMPONENT.Features = {
	ParkMode = true
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {},
		["MODE2"] = "MIX_DOUBLE_FLASH",
		["MODE3"] = "PURSUIT_W"
	},
	["Emergency.Marker"] = {
		["ON"] = {
			All = "ON"
		}
	},
	["Emergency.ParkedWarning"] = {
		["MODE3"] = {
			White = "OFF"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Illumination = "TAKEDOWN"
		},
		["FLOOD"] = {
			Illumination = "FLOOD"
		}
	},
	["Emergency.Cut"] = {
		["FRONT"] = {
			All = "OFF"
		}
	}
}