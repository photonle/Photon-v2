local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_sos_mpf4"
COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.Title = [[SoundOff Signal mpower Fascia 4"]]
COMPONENT.Category = "Perimeter"
COMPONENT.Model = "models/sentry/props/soundofffascia.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 3
}

COMPONENT.DefineOptions = {
	Marker = {
		Arguments = { [1] = { "enabled", "boolean" } },
		Description = "Enable or disable the marker light.",
		Action = function( self, enabled )
			if ( not enabled ) then
				self.Inputs["Emergency.Marker"]["ON"] = {}
			end
		end
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

local s = 1.6

local templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_detail.png").MaterialName,
			Width = 6,
			Height = 6,
			Ratio = 1,
			Scale = 1.4,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
		}
	},
	["Projected"] = {
		Illumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 1.5,
			FOV = 45
		}
	}
}

COMPONENT.Templates = templates

COMPONENT.StateMap = "[1/2/3] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[1] 1",
			[2] = "[2] 1",
			[3] = "[3] 1",
			[4] = "[W] 1",
			[5] = "[R] 1"
			-- [1] = { { 1, 4 } },
		},
		Sequences = {
			["TEST"] = { 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
				2, 2, 2, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
				3, 3, 0, 3, 3, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0,
			},
			["MODE1"] = { 1 },
			["W"] = { 4 },
			["R"] = { 5 },
			["1"] = { 1 },
			["2"] = { 2 },
			["3"] = { 3 },
			["DUO_ALT_MED"] = sequence():Alternate( 1, 2, 8 ),
			["TRI_FLASH_SOLO"] = sequence():Add( 1, 1, 0, 1, 1, 0, 1, 1 ):AppendPhaseGap(),
			["DUO_FLASH"] = sequence():FlashHold( { 1, 0, 2, 0 }, 3, 1 ),
			["2FH_2C"] = sequence():FlashHold( { 1, 2 }, 2, 4 ),
			["2FH_2C_FAST"] = sequence():FlashHold( { 1, 2 }, 2, 2 ),
			["SLOW_RUN"] = sequence():Alternate( 1, 0, 8),
			["SUP_SLOW_RUN"] = sequence():Alternate( 1, 0, 10),
			["OFF"] = { 0 },
		}
	},
	-- Using a different segment for overriding keeps the flash pattern synchronized
	-- when the override is removed.
	Override = {
		Frames = {
			[1] = "[1] 1",
			[2] = "[2] 1",
			[3] = "[3] 1",
			[4] = "[W] 1",
			[5] = "[R] 1"
		},
		Sequences = {
			["W"] = { 4 },
			["R"] = { 5 },
		}
	}
}

COMPONENT.Patterns = {
	["R"] = { { "Override", "R" } },
	["W"] = { { "Override", "W" } },
	["DUO_FLASH"] = { { "Light", "DUO_FLASH" } },
	["2FH_2C"] = { { "Light", "2FH_2C" } },
	["2FH_2C_FAST"] = { { "Light", "2FH_2C_FAST" } },
	["SLOW_RUN"] = { { "Light", "SLOW_RUN" } },
	["SUP_SLOW_RUN"] = { { "Light", "SUP_SLOW_RUN" } },
	["OFF"] = { { "Light", "OFF" } }
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = { 1 }
		},
		["MODE2"] = {
			Light = "TRI_FLASH_SOLO"
		},
		["MODE3"] = {
			Light = "TRI_FLASH_SOLO"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "1"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )




--[[
		mPower Fascia 4" (Bracket x2)
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_sos_mpf4_bracket_x2"
COMPONENT.Model = "models/schmal/mpowerf4_bracket_x2.mdl"
COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.Title = [[SoundOff Signal mpower Fascia 4" (Bracket x2)]]
COMPONENT.Category = "Perimeter"

COMPONENT.Templates = templates

COMPONENT.StateMap = "[R/B/W] 1 2"

COMPONENT.Elements = {
	[1] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 1 },
	[2] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 2 },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 [2] 2",
			[2] = "[2] 1 [1] 2"
		},
		Sequences = {
			["ON"] = { 1 },
			["MIX_2FH_2C"] = sequence():FlashHold( { 1, 2 }, 2, 4 ),
			["MIX_2FH_2C_FAST"] = sequence():FlashHold( { 1, 2 }, 2, 2 ),
			["OFF"] = { 0 }
		}
	}
}

COMPONENT.DefineOptions = {
}

COMPONENT.Patterns = {
	["MIX_2FH_2C"] = { { "All", "MIX_2FH_2C" } },
	["MIX_2FH_2C_FAST"] = { { "All", "MIX_2FH_2C_FAST" } },
	["ON"] = { { "All", "ON" } },
	["OFF"] = { { "All", "OFF" } },
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			["All"] = "ON",
		},
		["MODE2"] = "MIX_2FH_2C",
		["MODE3"] = "MIX_2FH_2C_FAST",
	},
	["Emergency.Marker"] = {
		["ON"] = "ON"
	},
}

Photon2.RegisterComponent( COMPONENT )



--[[
		mPower Fascia 4" (x4)
--]]

-- This uses four mPowers positioned using bones, which reduces overhead
COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_sos_mpf4_x4"
COMPONENT.Model = "models/schmal/sentry_mpower4_x4.mdl"
COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.Title = [[SoundOff Signal mpower Fascia 4" (x4)]]
COMPONENT.Category = "Perimeter"

COMPONENT.Templates = templates

COMPONENT.States = { "R", "B", "W" }

COMPONENT.StateMap = "[1/3] 1 3 [2/3] 2 4"

COMPONENT.Features = {
	ParkMode = true
}

COMPONENT.Elements = {
	[1] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 1 },
	[2] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 2 },
	[3] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 3 },
	[4] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0), BoneParent = 4 },
	[5] = { "Illumination", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), HorizontalFOV = 160, VerticalFOV = 90 },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 3 2 4",
			[2] = "1 3",
			[3] = "2 4",
			[4] = "1 3 [2] 2 4",
			[5] = "2 4 [2] 1 3",
			[6] = "[W] 1 2 3 4 5",
		},
		Sequences = {
			["ON"] = { 1 },
			["MIX_2FH"] = sequence():FlashHold( { 2, 3 }, 2, 4 ),
			["MIX_2FH_FAST"] = sequence():FlashHold( { 2, 3 }, 2, 2 ),
			["MIX_2FH_2C_FAST"] = sequence():FlashHold( { 4, 5 }, 2, 2 ),
			["ILLUM"] = { 6 },
			["OFF"] = { 0 }
		}
	}
}

COMPONENT.DefineOptions = {
	["Spacing"] = {
		Arguments = {
			{ "spread", "number" },
			{ "innerSpread", "number" },
		},
		Description = "Adjusts the spacing between the mPowers.",
		Action = function( self, spread, innerSpread )
			spread = spread * 4 or 0
			if ( innerSpread ) then innerSpread = innerSpread * 2 end
			innerSpread = innerSpread or spread * 0.3333
			self.Bones = self.Bones or {}
			self.Bones[1] = { Vector( 0, -spread, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones[2] = { Vector( 0, -innerSpread, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones[3] = { Vector( 0, innerSpread, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones[4] = { Vector( 0, spread, 0 ), Angle( 0, 0, 0 ), 1 }
		end
	}
}

COMPONENT.Patterns = {
	["MIX_2FH"] = { { "All", "MIX_2FH" } },
	["MIX_2FH_2C_FAST"] = { { "All", "MIX_2FH_2C_FAST" } },
	["MIX_2FH_FAST"] = { { "All", "MIX_2FH_FAST" } },
	["OFF"] = { { "All", "OFF" } },
	["ILLUM"] = { { "All", "ILLUM" } },
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			["All"] = "ON",
		},
		["MODE2"] = "MIX_2FH",
		["MODE3"] = "MIX_2FH_2C_FAST"
	},
	["Emergency.ParkedWarning"] = {
		-- TODO: this doesn't work when only a pattern is used
		["MODE3"] = { 
			["All"] = "MIX_2FH_FAST"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			["All"] = "ON",
		}
	},
}

Photon2.RegisterComponent( COMPONENT )
