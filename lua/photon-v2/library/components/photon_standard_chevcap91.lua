if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = "Chevrolet Caprice (1991)"
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
			Model = "models/schmal/sgm_chevcap91_emis.mdl",
			IntensityGainFactor = 10,
			IntensityLossFactor = 8,
			DeactivationState = "~OFF",
			DrawMaterial = "photon/common/glow_gradient_a" 
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
			IntensityLossFactor = 8,
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

local offset = Vector( 0, 0, -5 )

COMPONENT.Elements = {
	[1] = { "Model", offset, Angle(), "photon/vehicle/hdl_fl" },
	[2] = { "Model", offset, Angle(), "photon/vehicle/hdl_fr" },

	[3] = { "Model", offset, Angle(), "photon/vehicle/mar_fl" },
	[4] = { "Model", offset, Angle(), "photon/vehicle/mar_fr" },

	[5] = { "Model", offset, Angle(), "photon/vehicle/sig_fl" },
	[6] = { "Model", offset, Angle(), "photon/vehicle/sig_fr" },

	[7] = { "Model", offset, Angle(), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_f" },
	[8] = { "Model", offset, Angle(), "photon/vehicle/sig_rr", DrawMaterial = "photon/common/glow_gradient_f" },

	[9] = { "Model", offset, Angle(), "photon/vehicle/rev_rl" },
	[10] = { "Model", offset, Angle(), "photon/vehicle/rev_rr" },

	[11] = { "Model", offset, Angle(), "photon/vehicle/mar_rl", DrawMaterial = "photon/common/glow_gradient_f" },
	[12] = { "Model", offset, Angle(), "photon/vehicle/mar_rr", DrawMaterial = "photon/common/glow_gradient_f" },

	[13] = { "Model", offset, Angle(), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_f" },
	[14] = { "Model", offset, Angle(), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_f" },
	[15] = { "Model", offset, Angle(), "photon/vehicle/bra_rc" },
}

COMPONENT.StateMap = "[~SW] 1 2 9 10 [~A] 3 4 5 6 [~R] 7 8 11 12 13 14 15"

COMPONENT.ElementGroups = {

}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Headlights"] = {
		Frames = {
			[1] = "1 2 [~R*0.6] 7 8 11 12 13 14 [~A*0.6] 5 6 3 4",
			[2] = "[~R*0.6] 7 8 11 12 13 14 [~A*0.6] 5 6 3 4"
		},
		Sequences = {
			["ON"] = { 1 },
			["PARK"] = { 2 },
		}
	},
	["WigWag"] = {
		Off = "~OFF",
		Frames = {
			[1] = "1",
			[2] = "2",
			[3] = "[PASS] 1 2"
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 7 ),
			["PASS"] = { 3 }
		}
	},
	["Brake"] = {
		Off = "PASS",
		Frames = {
			[1] = "15"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["Signal"] = {
		Off = "PASS",
		Frames = {
			[1] = "3 5",
			[2] = "4 6",
			[3] = "3 4 5 6"
		},
		Sequences = {
			["LEFT"] = sequence():Alternate( 1, 0, 10 ),
			["RIGHT"] = sequence():Alternate( 2, 0, 10 ),
			["HAZARD"] = sequence():Alternate( 3, 0, 10 ),
		}
	},
	["Tail_L"] = {
		Off = "PASS",
		Frames = {
			[1] = "11 13"
		},
		Sequences = {
			["BRAKE"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 10 )
		}
	},
	["Tail_R"] = {
		Off = "PASS",
		Frames = {
			[1] = "12 14"
		},
		Sequences = {
			["BRAKE"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 10 )
		}
	},
	["Brake_L"] = {
		Frames = {
			[1] = "13",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	["Brake_R"] = {
		Frames = {
			[1] = "14",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	["Reverse_L"] = {
		Off = "~OFF",
		Frames = {
			[1] = "9"
		},
		Sequences = {
			ON = { 1 },
			REVERSE = { 1 },
			FLASH = sequence():Alternate( 0, 1, 8 ),
		}
	},
	["Reverse_R"] = {
		Off = "~OFF",
		Frames = {
			[1] = "10"
		},
		Sequences = {
			ON = { 1 },
			REVERSE = { 1 },
			FLASH = sequence():Alternate( 0, 1, 8 ),
		}
	},
}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["ON"] = {
			["All"] = "ON",
		},
		["HEADLIGHTS"] = {
			["Headlights"] = "ON",
		},
		["PARKING"] = {
			["Headlights"] = "PARK",
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			["Signal"] = "LEFT",
			["Tail_L"] = "SIGNAL",
		},
		["RIGHT"] = {
			["Signal"] = "RIGHT",
			["Tail_R"] = "SIGNAL",
		},
		["HAZARD"] = {
			["Signal"] = "HAZARD",
			["Tail_L"] = "SIGNAL",
			["Tail_R"] = "SIGNAL",
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			["Brake"] = "ON",
			["Tail_L"] = "BRAKE",
			["Tail_R"] = "BRAKE",
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			["Reverse_L"] = "REVERSE",
			["Reverse_R"] = "REVERSE"
		}
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			["Signal"] = "HAZARD",
			["Tail_L"] = "SIGNAL",
			["Tail_R"] = "SIGNAL",
			["WigWag"] = "ALT"
		}
	},
	["Emergency.Cut"] = {
		["FRONT"] = {
			["WigWag"] = "PASS"
		}
	}
}