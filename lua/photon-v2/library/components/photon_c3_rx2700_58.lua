if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Title = "Code 3 RX2700 (58\")"
COMPONENT.Model = "models/schmal/code3_rx2700_58.mdl"

COMPONENT.Author = "Photon"
COMPONENT.Category = "Lightbar"

COMPONENT.Credits = {
	Model = "Cj24, Schmal",
	Code = "Schmal"
}


COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

local w = 7.1
local h = w/2

COMPONENT.Templates = {
	["2D"] = {
		["Linear"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/rx2700_linear_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/rx2700_linear_detail.png").MaterialName,
			Width = w,
			Height = h,
			Scale = 1.8,
			Ratio = 1.5
		},
		["Takedown"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/rx2700_takedown_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/rx2700_takedown_shape.png").MaterialName,
			Width = 2,
			Height = 2,
			Scale = 2,
		}
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 2
		},
		AlleyIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 4
		},
	}
}

local domeColors = {
	["black"] = "schmal/photon/code3_rx2700/dome_color_black",
	["red"] = "schmal/photon/code3_rx2700/dome_color_red",
	["blue"] = "schmal/photon/code3_rx2700/dome_color_blue",
	["clear"] = "schmal/photon/code3_rx2700/dome_color_clear",
	["amber"] = "schmal/photon/code3_rx2700/dome_color_amber",
}

COMPONENT.DefineOptions = {
	["Feet"] = {
		Arguments = { { "width", "number" } },
		Description = "Sets the width of the feet placement.",
		Action = function( self, width )
			-- TODO: verify this if this is necessary and/or works
			-- local scale = self.Scale or 1
			-- width = width * scale
			self.Bones = self.Bones or {}
			self.Bones["right_foot"] = { Vector( width, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["left_foot"] = { Vector( -width, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["left_original_foot"] = { Vector( width, 0, 0 ), Angle( 0, 0, 0 ), scale }
			self.Bones["right_original_foot"] = { Vector( -width, 0, 0 ), Angle( 0, 0, 0 ), scale }
		end
	},
	["Mount"] = {
		Arguments = { { "mount", "string" } },
		Description = "Sets mounting feet type. (normal, no-hook, classic, none)",
		Action = function( self, mount )
			self.BodyGroups = self.BodyGroups or {}
			if ( mount == "no-hook" ) then
				self.BodyGroups["Feet"] = 1
			elseif ( mount == "classic" ) then
				self.BodyGroups["Feet"] = 2
			elseif ( mount == "none" ) then
				self.BodyGroups["Feet"] = 3
			else
				self.BodyGroups["Feet"] = 0
			end
		end
	},
	["Domes"] = {
		Arguments = { 
			{ "left", "string" },
			{ "center", "string" },
			{ "right", "string" },
		},
		Description = "Changes the dome material. (black, red, blue, clear, amber)",
		Action = function( self, left, center, right )
			self.SubMaterials = self.SubMaterials or {}
			self.SubMaterials[7] = domeColors[left]
			self.SubMaterials[8] = domeColors[center or left]
			self.SubMaterials[9] = domeColors[right or left]
		end
	}
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 [B] 2 4 6 8 10 12 14 16 [W] 17 18 19 20 21 22 23"

COMPONENT.Elements = {
	[1] = { "Linear", Vector( 6.62, 6.15, -1.36 ), Angle( 0, -90, 180 ) },
	[2] = { "Linear", Vector( 6.62, -6.15, -1.36 ), Angle( 0, -90, 0 ) },

	[3] = { "Linear", Vector( 6.62, 16.15, -1.36 ), Angle( 0, -90, 0 ) },
	[4] = { "Linear", Vector( 6.62, -16.15, -1.36 ), Angle( 0, -90, 0 ) },

	[5] = { "Linear", Vector( 6.62, 23.02, -1.36 ), Angle( 0, -90, 0 ) },
	[6] = { "Linear", Vector( 6.62, -23.02, -1.36 ), Angle( 0, -90, 0 ) },

	[7] = { "Linear", Vector( 4.25, 29.8, -1.36 ), Angle( 0, -90 + 45, 0 ) },
	[8] = { "Linear", Vector( 4.25, -29.8, -1.36 ), Angle( 0, -90 - 45, 0 ) },

	[9] = { "Linear", Vector( -4.25, 29.8, -1.36 ), Angle( 0, 90 - 45, 0 ) },
	[10] = { "Linear", Vector( -4.25, -29.8, -1.36 ), Angle( 0, 90 + 45, 0 ) },

	[11] = { "Linear", Vector( -6.62, 23.02, -1.36 ), Angle( 0, 90, 0 ) },
	[12] = { "Linear", Vector( -6.62, -23.02, -1.36 ), Angle( 0, 90, 0 ) },

	[13] = { "Linear", Vector( -6.62, 16.15, -1.36 ), Angle( 0, 90, 0 ) },
	[14] = { "Linear", Vector( -6.62, -16.15, -1.36 ), Angle( 0, 90, 0 ) },

	[15] = { "Linear", Vector( -6.62, 6.15, -1.36 ), Angle( 0, 90, 0 ) },
	[16] = { "Linear", Vector( -6.62, -6.15, -1.36 ), Angle( 0, 90, 180 ) },

	[17] = { "Takedown", Vector( 0, 31.2, -1.35 ), Angle( 0, 0, 0 ) },
	[18] = { "Takedown", Vector( 0, -31.2, -1.35 ), Angle( 0, 180, 0 ) },

	[19] = { "AlleyIllumination", Vector( 0, 25, -1.35 ), Angle( 0, 0, 0 ) },
	[20] = { "AlleyIllumination", Vector( 0, -25, -1.35 ), Angle( 0, 180, 0 ) },
}


local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
			[2] = "[#DEBUG] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20"
		},
		Sequences = {
			["ON"] = { 1 },
			["DEBUG"] = { 2 }
		}
	},
	FrontCorner = {
		Frames = {
			[1] = "7",
			[2] = "8",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 5 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 3 ),
		}
	},
	FrontOuter = {
		Frames = {
			[1] = "5",
			[2] = "6",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 2 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 0 ),
		}
	},
	FrontMid = {
		Frames = {
			[1] = "3",
			[2] = "4",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 3 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 1 ),
		}
	},
	FrontInner = {
		Frames = {
			[1] = "1",
			[2] = "2"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 4 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 2 ),
		}
	},
	RearCorner = {
		Frames = {
			[1] = "9",
			[2] = "10",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 4 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 2 ),
		}
	},
	RearOuter = {
		Frames = {
			[1] = "11",
			[2] = "12",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 5 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 3 ),

		}
	},
	RearMid = {
		Frames = {
			[1] = "13",
			[2] = "14",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 3 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 1, 2 }, 2, 1 ),
		}
	},
	RearInner = {
		Frames = {
			[1] = "15",
			[2] = "16",
			[3] = "15 16"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 3 ),
			["FLASH"] = sequence():Alternate( 3, 0, 4 ),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( { 3, 0 }, 2, 2 ),
		}
	},
	Marker = {
		Frames = {
			[1] = "7 8 9 10",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	AlleyLeft = {
		Frames = {
			[1] = "",
			[2] = "17 19",
		},
		Sequences = {
			["ON"] = { 1 },
			["ILLUM"] = { 2 },
		}
	},
	AlleyRight = {
		Frames = {
			[1] = "",
			[2] = "18 20",
		},
		Sequences = {
			["ON"] = { 1 },
			["ILLUM"] = { 2 },
		}
	},
	Alley = {
		Frames = {
			[1] = "17",
			[2] = "18",
		},
		Sequences = {
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 1, 2, 7 )
		}
	},
	ArrowStik = {
		Frames = {
			[1] = "12",
			[2] = "14 12",
			[3] = "16 14 12",
			[4] = "15 16 14 12",
			[5] = "13 15 16 14 12",
			[6] = "11 13 15 16 14 12",
			[7] = "11",
			[8] = "11 13",
			[9] = "11 13 15",
			[10] = "11 13 15 16",
			[11] = "11 13 15 16 14",
			[12] = "11 13 15 16 14 12",
			[13] = "15 16",
			[14] = "13 15 16 14",
			[15] = "11 13 15 16 14 12",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential( 1, 6 ):Hold( 2 ):StretchAll( 3 ):Off( 4 ),
			["RIGHT"] = sequence():Sequential( 7, 12 ):Hold( 2 ):StretchAll( 3 ):Off( 4 ),
			["CENOUT"] = sequence():Sequential( 13, 15 ):Hold( 2 ):StretchAll( 4 ):Off( 4 ),
		}
	},
	FrontCut = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 17 18 19 20",
		},
		Sequences = {
			["CUT"] = { 0 }
		}
	},
	RearCut = {
		Frames = {
			[1] = "9 10 11 12 13 14 15 16",
		},
		Sequences = {
			["CUT"] = { 0 }
		}
	}
}

COMPONENT.Patterns = {
	["Default"] = {
		{ "FrontCorner", "ALT" },
		{ "FrontOuter", "ALT" },
		{ "FrontMid", "ALT" },
		{ "FrontInner", "ALT" },
		{ "RearCorner", "ALT" },
		{ "RearOuter", "ALT" },
		{ "RearMid", "ALT" },
		{ "RearInner", "ALT" },
	},
	["DefaultR"] = {
		{ "RearCorner", "ALT" },
		{ "RearOuter", "ALT" },
		{ "RearMid", "ALT" },
		{ "RearInner", "FLASH" },
	},
	["DefaultW"] = {
		{ "FrontCorner", "DOUBLE_FLASH_HOLD" },
		{ "FrontOuter", "DOUBLE_FLASH_HOLD" },
		{ "FrontMid", "DOUBLE_FLASH_HOLD" },
		{ "FrontInner", "DOUBLE_FLASH_HOLD" },
		{ "RearCorner", "DOUBLE_FLASH_HOLD" },
		{ "RearOuter", "DOUBLE_FLASH_HOLD" },
		{ "RearMid", "DOUBLE_FLASH_HOLD" },
		{ "RearInner", "DOUBLE_FLASH_HOLD" },
		{ "Alley", "ALT" },
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = "DefaultR",
		["MODE2"] = "Default",
		["MODE3"] = "DefaultW",
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { AlleyLeft = "ILLUM" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { AlleyRight = "ILLUM" }
	},
	["Emergency.Marker"] = {
		["ON"] = { Marker = "ON" }
	},
	["Emergency.Directional"] = {
		["LEFT"] = { ArrowStik = "LEFT" },
		["RIGHT"] = { ArrowStik = "RIGHT" },
		["CENOUT"] = { ArrowStik = "CENOUT" },
	},
	["Emergency.Cut"] = {
		["FRONT"] = { FrontCut = "CUT" },
		["REAR"] = { RearCut = "CUT" },
	}
}