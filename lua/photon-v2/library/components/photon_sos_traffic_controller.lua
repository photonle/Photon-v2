if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()


COMPONENT.Name = "photon_sos_mptc_x8"
COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Noble, SGM",
	Code = "Noble"
}

COMPONENT.Title = [[SoundOff Signal mpower Traffic Controller (x8)]]
COMPONENT.Category = "Traffic"
COMPONENT.Model = "models/noble/sos_traffic_controller_8x.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.5
}

-- ParkMode on by default, NightParkMode off by default
-- Enable NightParkMode per component in vehicle file
COMPONENT.Features = {
    ParkMode = true,
    NightParkMode = false
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W",
    [4] = "A"
}

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf4_detail.png").MaterialName,
			Width = 6.2,
			Height = 6,
			Ratio = 1,
			Scale = 1.4,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
		}
	}
}

COMPONENT.StateMap = "[1] 7 5 3 1 [2] 2 4 6 8"

COMPONENT.Elements = {
	[1] = { "Light", Vector(0.5, -2.765, 0), Angle(0, -90, 0) },
    [2] = { "Light", Vector(0.5, 2.765, 0), Angle(0, -90, 0) },
    [3] = { "Light", Vector(0.5, -8.3, 0), Angle(0, -90, 0) },
    [4] = { "Light", Vector(0.5, 8.3, 0), Angle(0, -90, 0) },
    [5] = { "Light", Vector(0.5, -13.835, 0), Angle(0, -90, 0) },
    [6] = { "Light", Vector(0.5, 13.835, 0), Angle(0, -90, 0) },
    [7] = { "Light", Vector(0.5, -19.37, 0), Angle(0, -90, 0) },
    [8] = { "Light", Vector(0.5, 19.37, 0), Angle(0, -90, 0) },
}

COMPONENT.ElementStates = {
    ["2D"] = {
        ["1*0.6"] = {
            Inherit = "1",
            Intensity = 0.6,
        },
        ["2*0.6"] = {
            Inherit = "2",
            Intensity = 0.6,
        }
    }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
            -- Ordering [7 5 3 1 | 2 4 6 8]
			[1] = "[1] 7 5 3 1",
            [2] = "[2] 2 4 6 8",
            [3] = "[1*0.6] 7 5 3 1 [2] 2 4 6 8",
            [4] = "[1] 7 5 3 1 [2*0.6] 2 4 6 8",
            [5] = "[1*0.6] 7 5 3 1 [2*0.6] 2 4 6 8",
		},
		Sequences = {
            ["ALT_SLOW"] = sequence():Alternate(1, 2):SetTiming(0.429),
            ["ALT_SLOW_DIM"] = sequence():Alternate(4, 3):SetTiming(0.429),
            ["ALT"] = sequence():Alternate(1, 2):SetTiming(0.261),
            ["ALT_FAST"] = sequence():Alternate(1, 2):SetTiming(0.162),
            ["OFF"] = { 0 },
		}
	},
	-- Using a different segment for overriding keeps the flash pattern synchronized
	-- when the override is removed.
	TrafficAdvisor = {
		Frames = {
			-- Ordering [7 5 3 1 | 2 4 6 8]
            [1] = "[4] 7",
            [2] = "[4] 7 5",
            [3] = "[4] 7 5 3",
            [4] = "[4] 7 5 3 1",
            [5] = "[4] 7 5 3 1 2",
            [6] = "[4] 7 5 3 1 2 4",
            [7] = "[4] 7 5 3 1 2 4 6",
            [8] = "[4] 7 5 3 1 2 4 6 8",
            [9] = "[4] 5 3 1 2 4 6 8",
            [10] = "[4] 3 1 2 4 6 8",
            [11] = "[4] 1 2 4 6 8",
            [12] = "[4] 2 4 6 8",
            [13] = "[4] 4 6 8",
            [14] = "[4] 6 8",
            [15] = "[4] 8",

            [16] = "[4] 1 2",
            [17] = "[4] 3 1 2 4",
            [18] = "[4] 5 3 1 2 4 6",
            [19] = "[4] 7 5 3 1 2 4 6 8",
            [20] = "[4] 7 5 3 4 6 8",
            [21] = "[4] 7 5 6 8",
            [22] = "[4] 7 8",
            -- Dimmed TA color version
            [23] = "[4] 7 [1*0.6] 5 3 1 [2*0.6] 2 4 6 8",
            [24] = "[4] 7 5 [1*0.6] 3 1 [2*0.6] 2 4 6 8",
            [25] = "[4] 7 5 3 [1*0.6] 1 [2*0.6] 2 4 6 8",
            [26] = "[4] 7 5 3 1 [2*0.6] 2 4 6 8",
            [27] = "[4] 7 5 3 1 2 [2*0.6] 4 6 8",
            [28] = "[4] 7 5 3 1 2 4 [2*0.6] 6 8",
            [29] = "[4] 7 5 3 1 2 4 6 [2*0.6] 8",
            [30] = "[4] 7 5 3 1 2 4 6 8",
            [31] = "[1*0.6] 7 [4] 5 3 1 2 4 6 8",
            [32] = "[1*0.6] 7 5 [4] 3 1 2 4 6 8",
            [33] = "[1*0.6] 7 5 3 [4] 1 2 4 6 8",
            [34] = "[1*0.6] 7 5 3 1 [4] 2 4 6 8",
            [35] = "[1*0.6] 7 5 3 1 [2*0.6] 2 [4] 4 6 8",
            [36] = "[1*0.6] 7 5 3 1 [2*0.6] 2 4 [4] 6 8",
            [37] = "[1*0.6] 7 5 3 1 [2*0.6] 2 4 6 [4] 8",

            [38] = "[1*0.6] 7 5 3 1 [2*0.6] 2 4 6 8",

            [39] = "[1*0.6] 7 5 3 [4] 1 2 [2*0.6] 4 6 8",
            [40] = "[1*0.6] 7 5 [4] 3 1 2 4 [2*0.6] 6 8",
            [41] = "[1*0.6] 7 [4] 5 3 1 2 4 6 [2*0.6] 8",
            [42] = "[4] 7 5 3 1 2 4 6 8",
            [43] = "[4] 7 5 3 [1*0.6] 1 [2*0.6] 2 [4] 4 6 8",
            [44] = "[4] 7 5 [1*0.6] 3 1 [2*0.6] 2 4 [4] 6 8",
            [45] = "[4] 7 [1*0.6] 5 3 1 [2*0.6] 2 4 6 [4] 8",
            
		},
		Sequences = {
			["LEFT"] = sequence():Sequential(15, 1):Add(0):SetTiming(.273),
            ["RIGHT"] = sequence():Sequential(1, 15):Add(0):SetTiming(.273),
            ["CENOUT"] = sequence():Sequential(16, 22):Add(0):SetTiming(.273),

            ["LEFT_DIM"] = sequence():Sequential(37, 23):Add(38):SetTiming(.273),
            ["RIGHT_DIM"] = sequence():Sequential(23, 37):Add(38):SetTiming(.273),
            ["CENOUT_DIM"] = sequence():Sequential(39, 45):Add(38):SetTiming(.273),
		}
	}
}

COMPONENT.Patterns = {
	["OFF"] = { { "Light", "OFF" } },
}

COMPONENT.VirtualOutputs = {
    -- TA pattern when parked in dark with mode 3 active
	["Emergency.NightParkedDirectional"] = {
        {
			Mode = "LEFT",
			Conditions = {
                ["Emergency.Directional"] = { "LEFT" },
                ["Emergency.NightParkedWarning"] = { "MODE3" }
			}
		},
        {
			Mode = "RIGHT",
			Conditions = {
                ["Emergency.Directional"] = { "RIGHT" },
                ["Emergency.NightParkedWarning"] = { "MODE3" }
			}
		},
        {
			Mode = "CENOUT",
			Conditions = {
                ["Emergency.Directional"] = { "CENOUT" },
				["Emergency.NightParkedWarning"] = { "MODE3" }
			}
		}
	},
}

COMPONENT.InputPriorities = {
    -- Had to restate ParkedWarning and NightParkedWarning priorities since it was throwing errors without them
    ["Emergency.ParkedWarning"] = 45,
    ["Emergency.NightParkedWarning"] = 46,
	["Emergency.NightParkedDirectional"] = 81,
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ALT_SLOW"
		},
		["MODE2"] = {
			Light = "ALT"
		},
		["MODE3"] = {
			Light = "ALT_FAST"
		}
	},
    ["Emergency.ParkedWarning"] = {
		["MODE3"] = {
            Light = "ALT_SLOW"
        }
	},
    ["Emergency.NightParkedWarning"] = {
		["MODE3"] = {
            Light = "ALT_SLOW_DIM"
        }
	},
    ["Emergency.Directional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT",
        }
	},
    ["Emergency.NightParkedDirectional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT_DIM",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT_DIM",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT_DIM",
        }
    },
    ["Emergency.Cut"] = {
		["REAR"] = "OFF"
	},
}

Photon2.RegisterComponent( COMPONENT )



--[[
		mpower Trafifc Controller (x6)
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Base = "photon_sos_mptc_x8"
COMPONENT.Name = "photon_sos_mptc_x6"

COMPONENT.Title = [[SoundOff Signal mpower Traffic Controller (x6)]]
COMPONENT.Model = "models/noble/sos_traffic_controller_6x.mdl"

COMPONENT.Preview = {
	Zoom = 2
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
            -- Ordering [7 5 3 1 | 2 4 6 8]
			[1] = "[1] 5 3 1",
            [2] = "[2] 2 4 6",
            [3] = "[1*0.6] 5 3 1 [2] 2 4 6",
            [4] = "[1] 5 3 1 [2*0.6] 2 4 6",
            [5] = "[1*0.6] 5 3 1 [2*0.6] 2 4 6",
		},
	},
	-- Using a different segment for overriding keeps the flash pattern synchronized
	-- when the override is removed.
	TrafficAdvisor = {
		Frames = {
			-- Ordering [7 5 3 1 | 2 4 6 8]
            [1] = "[4] 5",
            [2] = "[4] 5 3",
            [3] = "[4] 5 3 1",
            [4] = "[4] 5 3 1 2",
            [5] = "[4] 5 3 1 2 4",
            [6] = "[4] 5 3 1 2 4 6",
            [7] = "[4] 3 1 2 4 6",
            [8] = "[4] 1 2 4 6",
            [9] = "[4] 2 4 6",
            [10] = "[4] 4 6",
            [11] = "[4] 6",

            [12] = "[4] 1 2",
            [13] = "[4] 3 1 2 4",
            [14] = "[4] 5 3 1 2 4 6",
            [15] = "[4] 5 3 4 6",
            [16] = "[4] 5 6",
            -- Dimmed TA color version
            [17] = "[4] 5 [1*0.6] 3 1 [2*0.6] 2 4 6",
            [18] = "[4] 5 3 [1*0.6] 1 [2*0.6] 2 4 6",
            [19] = "[4] 5 3 1 [2*0.6] 2 4 6",
            [20] = "[4] 5 3 1 2 [2*0.6] 4 6",
            [21] = "[4] 5 3 1 2 4 [2*0.6] 6",
            [22] = "[4] 5 3 1 2 4 6",
            [23] = "[1*0.6] 5 [4] 3 1 2 4 6",
            [24] = "[1*0.6] 5 3 [4] 1 2 4 6",
            [25] = "[1*0.6] 5 3 1 [4] 2 4 6",
            [26] = "[1*0.6] 5 3 1 [2*0.6] 2 [4] 4 6",
            [27] = "[1*0.6] 5 3 1 [2*0.6] 2 4 [4] 6",

            [28] = "[1*0.6] 5 3 1 [2*0.6] 2 4 6",

            [29] = "[1*0.6] 5 3 [4] 1 2 [2*0.6] 4 6",
            [30] = "[1*0.6] 5 [4] 3 1 2 4 [2*0.6] 6",
            [31] = "[4] 5 3 1 2 4 6",
            [32] = "[4] 5 3 [1*0.6] 1 [2*0.6] 2 [4] 4 6",
            [33] = "[4] 5 [1*0.6] 3 1 [2*0.6] 2 4 [4] 6",
            
		},
		Sequences = {
			["LEFT_6"] = sequence():Sequential(11, 1):Add(0):SetTiming(.273),
            ["RIGHT_6"] = sequence():Sequential(1, 11):Add(0):SetTiming(.273),
            ["CENOUT_6"] = sequence():Sequential(12, 16):Add(0):SetTiming(.273),

            ["LEFT_DIM_6"] = sequence():Sequential(27, 17):Add(28):SetTiming(.273),
            ["RIGHT_DIM_6"] = sequence():Sequential(17, 27):Add(28):SetTiming(.273),
            ["CENOUT_DIM_6"] = sequence():Sequential(29, 33):Add(28):SetTiming(.273),
		}
	}
}

COMPONENT.Inputs = {
    ["Emergency.Directional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT_6",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT_6",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT_6",
        }
	},
    ["Emergency.NightParkedDirectional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT_DIM_6",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT_DIM_6",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT_DIM_6",
        }
    }
}

Photon2.RegisterComponent( COMPONENT )



--[[
		mpower Trafifc Controller (x4)
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Base = "photon_sos_mptc_x8"
COMPONENT.Name = "photon_sos_mptc_x4"

COMPONENT.Title = [[SoundOff Signal mpower Traffic Controller (x4)]]
COMPONENT.Model = "models/noble/sos_traffic_controller_4x.mdl"

COMPONENT.Preview = {
	Zoom = 3
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
            -- Ordering [7 5 3 1 | 2 4 6 8]
			[1] = "[1] 3 1",
            [2] = "[2] 2 4",
            [3] = "[1*0.6] 3 1 [2] 2 4",
            [4] = "[1] 3 1 [2*0.6] 2 4",
            [5] = "[1*0.6] 3 1 [2*0.6] 2 4",
		},
	},
	-- Using a different segment for overriding keeps the flash pattern synchronized
	-- when the override is removed.
	TrafficAdvisor = {
		Frames = {
			-- Ordering [7 5 3 1 | 2 4 6 8]
            [1] = "[4] 3",
            [2] = "[4] 3 1",
            [3] = "[4] 3 1 2",
            [4] = "[4] 3 1 2 4",
            [5] = "[4] 1 2 4",
            [6] = "[4] 2 4",
            [7] = "[4] 4",

            [8] = "[4] 1 2",
            [9] = "[4] 3 1 2 4",
            [10] = "[4] 3 4",
            -- Dimmed TA color version
            [11] = "[4] 3 [1*0.6] 1 [2*0.6] 2 4",
            [12] = "[4] 3 1 [2*0.6] 2 4",
            [13] = "[4] 3 1 2 [2*0.6] 4",
            [14] = "[4] 3 1 2 4",
            [15] = "[1*0.6] 3 [4] 1 2 4",
            [16] = "[1*0.6] 3 1 [4] 2 4",
            [17] = "[1*0.6] 3 1 [2*0.6] 2 [4] 4",

            [18] = "[1*0.6] 3 1 [2*0.6] 2 4",

            [19] = "[1*0.6] 3 [4] 1 2 [2*0.6] 4",
            [20] = "[4] 3 1 2 4",
            [21] = "[4] 3 [1*0.6] 1 [2*0.6] 2 [4] 4",
            
		},
		Sequences = {
			["LEFT_4"] = sequence():Sequential(7, 1):Add(0):SetTiming(.273),
            ["RIGHT_4"] = sequence():Sequential(1, 7):Add(0):SetTiming(.273),
            ["CENOUT_4"] = sequence():Sequential(8, 10):Add(0):SetTiming(.273),

            ["LEFT_DIM_4"] = sequence():Sequential(17, 11):Add(18):SetTiming(.273),
            ["RIGHT_DIM_4"] = sequence():Sequential(11, 17):Add(18):SetTiming(.273),
            ["CENOUT_DIM_4"] = sequence():Sequential(19, 21):Add(18):SetTiming(.273),
		}
	}
}

COMPONENT.Inputs = {
    ["Emergency.Directional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT_4",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT_4",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT_4",
        }
	},
    ["Emergency.NightParkedDirectional"] = {
        ["LEFT"] = {
            TrafficAdvisor = "LEFT_DIM_4",
        },
        ["RIGHT"] = {
            TrafficAdvisor = "RIGHT_DIM_4",
        },
        ["CENOUT"] = {
            TrafficAdvisor = "CENOUT_DIM_4",
        }
    }
}

Photon2.RegisterComponent( COMPONENT )