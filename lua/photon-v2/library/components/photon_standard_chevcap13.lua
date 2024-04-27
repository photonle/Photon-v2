if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = "2013 Chevrolet Caprice"
COMPONENT.Category = "Vehicle"
COMPONENT.IsVirtual = true

-- Special component attributes
COMPONENT.Flags = {
	AutomaticHeadlights = true
}

COMPONENT.Templates = {
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/chevcap13_emis.mdl",
			IntensityGainFactor = 10,
			IntensityLossFactor = 5,
			DeactivationState = "~OFF",
			ManipulateAlpha = false,
			DrawMaterial = "photon/common/glow_gradient_f",
			States = {
				["~AD"] = {
					Inherit = "A",
					Intensity = 0.6,
					IntensityTransitions = true
				},
				["~RD"] = {
					Inherit = "R",
					Intensity = 0.6,
					IntensityTransitions = true
				}
			}
		}
	},
	["2D"] = {
		["Headlights"] = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Width = 4,
			Height = 4,
			DeactivationState = "~OFF",
			IntensityGainFactor = 10,
			Scale = 1.2,
			States = {
				["~SW"] = {
					Inherit = "SW",
					IntensityTransitions = true
				}
			}
		},
	},
	["Sub"] = {
		SubMaterial = {}
	}
}

COMPONENT.StateMap = "[~SW] 1 2 3 4 12 13 [~A] 5 6 7 8 [~RD] 9 10 [R] 11 [W] 14 15 [HIDE] 16 17"

COMPONENT.Elements = {
	[1] = { "Headlights", Vector( -30.2, 90.2, 32.2 ), Angle( 0, 0, 0 ) },
	[2] = { "Headlights", Vector( 30.2, 90.2, 32.2 ), Angle( 0, 0, 0 ) },

	[3] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fl", DrawMaterial = "photon/common/glow_gradient_e", ManipulateAlpha = true },
	[4] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fr", DrawMaterial = "photon/common/glow_gradient_e", ManipulateAlpha = true },

	[5] = { "Model" , Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl" },
	[6] = { "Model" , Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr" },

	[7] = { "Model" , Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl" },
	[8] = { "Model" , Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr" },

	[9] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl" },
	[10] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr" },
	
	[11] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow_gradient_e", DeactivationState = "OFF" },

	[12] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl" },
	[13] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr" },

	[14] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/drl_fl", DeactivationState = "OFF" },
	[15] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/drl_fr", DeactivationState = "OFF" },

	[16] = { "SubMaterial", Indexes = { 25 } },
	[17] = { "SubMaterial", Indexes = { 26 } },

}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17",
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Lights"] = {
		Frames = {
			[1] = "[~AD] 5 6 [~RD] 9 10",
			[2] = "1 2 [~AD] 5 6 [~RD] 9 10"
		},
		Sequences = {
			PARKING = { 1 },
			HEADLIGHTS = { 2 }
		}
	},
	["Brake"] = {
		Off = "PASS",
		Frames = {
			[1] = "11 [~R] 9 10"
		},
		Sequences = {
			BRAKE = { 1 }
		}
	},
	["Reverse"] = {
		Frames = {
			[1] = "12 13"
		},
		Sequences = {
			REVERSE = { 1 }
		}
	},
	["Signal"] = {
		Off = "PASS",
		Frames = {
			[1] = "5 7",
			[2] = "6 8",
			[3] = "5 6 7 8"
		},
		Sequences = {
			LEFT = sequence():Alternate( 1, 0, 10 ),
			RIGHT = sequence():Alternate( 2, 0, 10 ),
			HAZARD = sequence():Alternate( 3, 0, 10 )
		}
	},
	["DRL"] = {
		Frames = {
			[1] = "14 15 16 17"
		},
		Sequences = {
			DRL = { 1 }
		}
	},
	["HighBeams"] = {
		Off = "~OFF",
		Frames = {
			[1] = "3 4",
			[2] = "3",
			[3] = "4"
		},
		Sequences = {
			HIGHBEAMS = { 1 },
			WIGWAG = sequence():Alternate( 2, 3, 8 )
		}
	}
}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["ON"] = {
			Lights = "PARKING"
		},
		["PARKING"] = {
			Lights = "PARKING"
		},
		["HEADLIGHTS"] = {
			Lights = "HEADLIGHTS"
		},
		["DRL"] = {
			DRL = "DRL"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brake = "BRAKE"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse = "REVERSE"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = { Signal = "LEFT" },
		["RIGHT"] = { Signal = "RIGHT" },
		["HAZARD"] = { Signal = "HAZARD" }
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			HighBeams = "WIGWAG"
		}
	}
}