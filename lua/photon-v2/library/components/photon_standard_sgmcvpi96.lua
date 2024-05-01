if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = "1996 Ford Crown Victoria"
COMPONENT.Category = "Vehicle"
COMPONENT.IsVirtual = true

COMPONENT.ElementStates = {

}

COMPONENT.Templates = {
	["Sub"] = {
		SubMaterial = {}
	},
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/sgmcvpi96_lights.mdl",
			Scale = 1.001,
			IntensityGainFactor = 10,
			IntensityLossFactor = 5,
			DeactivationState = "~OFF"
		}
	},
	["2D"] = {
		["Tail"] = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Scale = 1,
			Width = 1.5,
			Height = 1.5,
		}
	},
	["Projected"] = {
		["HighBeams"] = {
			FOV = 90,
			NearZ = 1,
			Brightness = 1,
			IntensityGainFactor = 10,
			IntensityLossFactor = 5,
			DeactivationState = "~OFF",
			-- TODO:
			-- This is required to prevent the lights from starting ON then fading off..?
			-- Intensity = 1,
		}
	},
	["DynamicLight"] = {
		LicensePlateLight = {
			Brightness = 0.01,
			Size = 80,
		}
	}
}

local amber = { r = 255, g = 200, b = 0 }


COMPONENT.ElementStates = {
	["Sub"] = {
		-- ["Glow"] = { Material = "sentry/96cvpi/glow_on" },
		-- ["Amber"] = { Material = "sentry/96cvpi/glow_on_orange" },
		["Glow"] = { Material = "photon/common/blank" }, ["Amber"] = { Material = "photon/common/blank" }
	},
	["Mesh"] = {
		["~SW"] = { Inherit = "SW", IntensityTransitions = true },
		["~R"] = { Inherit = "R", IntensityTransitions = true },
		["~RD"] = { Inherit = "R", Intensity = 0.5, IntensityTransitions = true },
		["~A"] = { 
			IntensityTransitions = true,
			BloomColor = PhotonColor( 255, 100, 0 ):Blend( amber ):GetBlendColor(),
			DrawColor = PhotonColor( 255, 200, 0 ):Blend( amber ):GetBlendColor(),
		},
		["~AD"] = { Inherit = "~A", Intensity = 0.6, IntensityTransitions = true },
	},
	["Projected"] = {
		["~W"] = { Inherit = "SW", IntensityTransitions = true }
	}
}

COMPONENT.ElementGroups = {
}

COMPONENT.Elements = {
	[1] = { "SubMaterial", Indexes = { 15 } }, -- Headlight L
	[2] = { "SubMaterial", Indexes = { 17 } }, -- Headlight R
	
	[3] = { "SubMaterial", Indexes = { 12 } }, -- Marker L
	[4] = { "SubMaterial", Indexes = { 14 } }, -- Marker R

	[5] = { "SubMaterial", Indexes = { 16 } }, -- Turn L
	[6] = { "SubMaterial", Indexes = { 18 } }, -- Turn R

	[7] = { "SubMaterial", Indexes = { 26 } }, -- Tail L
	[8] = { "SubMaterial", Indexes = { 27 } }, -- Tail R

	[9] = { "SubMaterial", Indexes = { 21 } }, -- Reverse L
	[10] = { "SubMaterial", Indexes = { 20 } }, -- Reverse R

	[11] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[12] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr", DrawMaterial = "photon/common/glow_gradient_a" },

	[13] = { "Model", Vector(0, 0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow_gradient_f" },
	[14] = { "Model", Vector(0, 0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow_gradient_f" },

	[15] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow_gradient_f" },
	[16] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow_gradient_f" },

	[17] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_f" },
	[18] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_f" },

	[19] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[20] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr", DrawMaterial = "photon/common/glow_gradient_a" },

	[21] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_f" },
	[22] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr", DrawMaterial = "photon/common/glow_gradient_f" },
	
	[23] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow_gradient_a" },

	[24] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hib_fr", DrawMaterial = "photon/common/glow_gradient_a" },
	[25] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hib_fl", DrawMaterial = "photon/common/glow_gradient_a" },

	[26] = { "HighBeams", Vector( -17.5, 111, 31.9 ), Angle( 20, 0, 0 ) },
	[27] = { "HighBeams", Vector( 17.5, 111, 31.9 ), Angle( 20, 0, 0 ) },

	[28] = { "LicensePlateLight", Vector( 0, -127, 34 ), Angle( 0, 0, 0 ) },
}

COMPONENT.StateMap = "[Glow] 1 2 7 8 9 10 [Amber] 3 4 5 6 [~R] 17 18 21 22 23 25 27 [~SW] 11 12 19 20 24 25 [~A] 13 14 15 16 [~W] 26 27 [SW] 28"

COMPONENT.ElementGroups = {
	["TailL"] = { 17, 21 },
	["TailR"] = { 18, 22 },
	["BrakeC"] = { 23 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "7 8 17 18"
			-- [1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["LicensePlate"] = {
		Frames = { [1] = "28" },
		Sequences = { ON = { 1 } }
	},
	["Headlights"] = {
		Frames = {
			[1] = "11 12"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["HighBeams"] = {
		Frames = {
			[0] = "[~OFF] 24 25 [~OFF] 26 27",
			[1] = "25 [~W] 26",
			[2] = "24 [~W] 27",
			[3] = "24 25 26 27",
		},
		Sequences = {
			WIGWAG = sequence():Alternate( 1, 2, 10 ),
			ON = { 3 }
		}
	},
	["Marker_L"] = {
		Frames = {
			[1] = "13",
			[2] = "[~AD] 13"
		},
		Sequences = {
			ON = { 1 },
			DIM = { 2 }
		}
	},
	["Marker_R"] = {
		Frames = {
			[1] = "14",
			[2] = "[~AD] 14"
		},
		Sequences = {
			ON = { 1 },
			DIM = { 2 },
		}
	},
	["Signal_L"] = {
		Frames = {
			[0] = "[~OFF] 15",
			[1] = "15",
			[2] = "[~RD]",
			[3] = "[PASS] 15"
		},
		Sequences = {
			ON = { 1 },
			SIGNAL = sequence():Alternate( 1, 3, 12 ),
			DIM = { 2 }
		}
	},
	["Signal_R"] = {
		Frames = {
			[0] = "[~OFF] 16",
			[1] = "16",
			[2] = "[~RD]",
			[3] = "[PASS] 16",
		},
		Sequences = {
			ON = { 1 },
			SIGNAL = sequence():Alternate( 1, 3, 12 ),
			DIM = { 2 }
		}
	},
	["Reverse_L"] = {
		Frames = {
			[0] = "[~OFF] 19",
			[1] = "19"
		},
		Sequences = {
			ON = { 1 },
			REVERSE = { 1 },
			FLASH = sequence():Alternate( 0, 1, 8 ),
		}
	},
	["Reverse_R"] = {
		Frames = {
			[0] = "[~OFF] 20",
			[1] = "20"
		},
		Sequences = {
			ON = { 1 },
			REVERSE = { 1 },
			FLASH = sequence():Alternate( 0, 1, 8 ),
		}
	},
	["Brake"] = {
		Frames = {
			[1] = "23"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Tail"] = {
		Frames = {
			[1] = "[~RD] TailL TailR"
		},
		Sequences = {
			DIM = { 1 }
		}
	},
	["TailL"] = {
		Frames = {
			[0] = "[~OFF] TailL",
			[1] = "[~RD] TailL",
			[2] = "[~R] TailL",
			[3] = "[PASS] TailL",
		},
		Sequences = {
			DIM = { 1 },
			ON = { 2 },
			SIGNAL = sequence():Alternate( 2, 3, 12 ),
			FLASH = sequence():Alternate( 2, 3, 8 ),
		}
	},
	["TailR"] = {
		Frames = {
			[0] = "[~OFF] TailR",
			[1] = "[~RD] TailR",
			[2] = "[~R] TailR",
			[3] = "[PASS] TailR",
			[4] = "[PASS] TailR"
		},
		Sequences = {
			DIM = { 1 },
			ON = { 2 },
			SIGNAL = sequence():Alternate( 2, 3, 12 ),
			FLASH = sequence():Alternate( 2, 3, 8 ),
		}
	},

}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["ON"] = {
			Tail = "DIM",
			Headlights = "ON",
			Marker_L = "ON",
			Marker_R = "ON",
			Brake = "ON",
			LicensePlate = "ON"
		},
		["HEADLIGHTS"] = {
			Tail = "DIM",
			Marker_L = "DIM",
			Marker_R = "DIM",
			Headlights = "ON",
			LicensePlate = "ON"
		},
		["PARKING"] = {
			Tail = "DIM",
			Marker_L = "DIM",
			Marker_R = "DIM",
			LicensePlate = "ON"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brake = "ON",
			TailL = "ON",
			TailR = "ON",
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			TailL = "SIGNAL",
			Signal_L = "SIGNAL"
		},
		["RIGHT"] = {
			TailR = "SIGNAL",
			Signal_R = "SIGNAL"
		},
		["HAZARD"] = {
			TailL = "SIGNAL",
			TailR = "SIGNAL",
			Signal_L = "SIGNAL",
			Signal_R = "SIGNAL"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse_L = "REVERSE",
			Reverse_R = "REVERSE",
		},
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			HighBeams = "WIGWAG",
			TailL = "FLASH",
			TailR = "FLASH",
			Reverse_L = "FLASH",
			Reverse_R = "FLASH",
		}
	}
}