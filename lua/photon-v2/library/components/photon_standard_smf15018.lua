if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = "Ford F150 Police Responder (2018)"
COMPONENT.Category = "Vehicle"
COMPONENT.IsVirtual = true

-- Special component attributes
COMPONENT.Features = {
	AutomaticHeadlights = true
}

COMPONENT.Templates = {
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/f15018_emis.mdl",
			DeactivationState = "~OFF",
			ManipulateAlpha = false,
			DrawMaterial = "photon/common/glow_gradient_a",
			IntensityGainFactor = 8,
			IntensityLossFactor = 8,
			States = {
				["~BR"] = {
					BloomColor = PhotonColor( 512, 0, 0 ):Blend( { r = 512, g = 0, b = 0 } ):GetBlendColor(),
					DrawColor = PhotonColor( 512, 255, 0 ):Blend( { r = 512, g = 0, b = 0 } ):GetBlendColor(),
					IntensityTransitions = true
				}
			}
		}
	},
}

COMPONENT.StateMap = "[~SW] 1 2 3 4 11 12 15 16 20 [~SW*0.4] 21 [~A*0.8] 5 6 [~A*0.5] 7 8 [~R*0.7] 9 10 17 18 [~R*0.85] 13 14 [~R]  19"

local offset = Vector( 0, 0, 0 )

COMPONENT.Elements = {
	-- Headlights
	[1] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl", DrawMaterial = "photon/common/glow_gradient_h" },
	[2] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr", DrawMaterial = "photon/common/glow_gradient_h" },

	-- High beams
	[3] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/hib_fl", DrawMaterial = "photon/common/glow_gradient_h" },
	[4] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/hib_fr", DrawMaterial = "photon/common/glow_gradient_h" },

	-- Forward marker
	[5] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/mar_fl" },
	[6] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/mar_fr" },

	-- Forward signal
	[7] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow_gradient_g" },
	[8] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow_gradient_g" },

	-- Rear signal
	[9] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_h" },
	[10] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/sig_rr", DrawMaterial = "photon/common/glow_gradient_h" },

	-- Reverse
	[11] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/rev_rl", DrawMaterial = "photon/common/glow_gradient_h" },
	[12] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/rev_rr", DrawMaterial = "photon/common/glow_gradient_h" },

	-- Tail
	[13] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/tai_rl", DrawMaterial = "photon/common/glow" },
	[14] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/tai_rr", DrawMaterial = "photon/common/glow" },

	-- Fog
	[15] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/fog_fl" },
	[16] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/fog_fr" },

	-- Brake
	[17] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_h" },
	[18] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_h" },
	[19] = { "Model", Vector( 0, -0.4, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow_gradient_a" },

	-- Bed
	[20] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/bed_rc" },

	-- License
	[21] = { "Model", offset, Angle( 0, 0, 0 ), "photon/vehicle/lic", BloomMaterial = "photon/common/glow_gradient_d" },
}

COMPONENT.ElementGroups = {
	["Tail"] = { 17, 18 },
	["Signal"] = { 7, 8, 9, 10 },
	["Headlight"] = { 1, 2 },
	["HighBeam"] = { 3, 4 },
	["Marker"] = { 5, 6 },
	["Reverse"] = { 11, 12 },
	["Fog"] = { 15, 16 },
	["Brake"] = { 17, 18, 19 },
	["Bed"] = { 20 },
	["License"] = { 21 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 15 16 17 18 19 20 21"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["WIGWAG"] = {
		Off = "~OFF",
		Frames = {
			[1] = "3",
			[2] = "4",
		},
		Sequences = {
			["ALT"] = sequence():Alternate( 1, 2, 7 )
		}
	},
	["Lights"] = {
		Frames = {
			[1] = "1 2 5 6 7 8 9 10 17 18 21",
			[2] = "5 6 7 8 9 10 17 18 21 13 14",
		},
		Sequences = {
			["HEADLIGHTS"] = { 1 },
			["PARKING"] = { 2 }
		}
	},
	["Brake"] = {
		Frames = {
			[1] = "[~R] 19"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["Reverse"] = {
		Frames = {
			[1] = "11 12 20"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["Signal"] = {
		Off = "PASS",
		Frames = {
			[1] = "[~A] 7 8",
			[2] = "[~A] 7",
			[3] = "[~A] 8"
		},
		Sequences = {
			["LEFT"] = sequence():Alternate( 2, 0, 10 ),
			["RIGHT"] = sequence():Alternate( 3, 0, 10 ),
			["HAZARD"] = sequence():Alternate( 1, 0, 10 )
		}
	},
	["Fog"] = {
		Frames = {
			[1] = "15 16"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	["RearLeftSignal"] = {
		Frames = {
			[0] = "[PASS] 9 17",
			[1] = "[~R] 9 17"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 10 ),
			["BRAKE"] = { 1 }
		}
	},
	["RearRightSignal"] = {
		Frames = {
			[0] = "[PASS] 10 18",
			[1] = "[~R] 10 18"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 10 ),
			["BRAKE"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
		},
		["MODE3"] = {
			["WIGWAG"] = "ALT"
		}
	},
	["Vehicle.Lights"] = {
		["PARKING"] = {
			Lights = "PARKING"
		},
		["HEADLIGHTS"] = {
			Lights = "HEADLIGHTS"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse = "ON"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			RearLeftSignal = "BRAKE",
			RearRightSignal = "BRAKE",
			Brake = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = { 
			Signal = "LEFT",
			RearLeftSignal = "SIGNAL"
		},
		["RIGHT"] = { 
			Signal = "RIGHT",
			RearRightSignal = "SIGNAL"
		},
		["HAZARD"] = { 
			Signal = "HAZARD",
			RearLeftSignal = "SIGNAL",
			RearRightSignal = "SIGNAL"
		}
	},
}

hook.Add( "HUDPaint", "Photon2:F150MaterialOverride", function()
	Material( "models/supermighty/f150_responder/sidemarker" ):SetInt( "$nowritez", 1 )
	timer.Simple( 5, function()
		Material( "models/supermighty/f150_responder/reflector" ):SetInt( "$nowritez", 1 )
	end)
	hook.Remove( "HUDPaint", "Photon2:F150MaterialOverride" )
end)