if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = "2013 Ford Police Interceptor Sedan"
COMPONENT.Category = "Vehicle"
COMPONENT.IsVirtual = true

-- -- Special component attributes
-- COMPONENT.Flags = {
-- 	AutomaticHeadlights = true
-- }

COMPONENT.States = {
	[1] = "W",
	[2] = "W"
}

COMPONENT.Templates = {
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/fpis13_emis.mdl",
			DeactivationState = "~OFF",
			ManipulateAlpha = false,
			DrawMaterial = "photon/common/glow_gradient_f",
			IntensityGainFactor = 10,
			IntensityLossFactor = 10,
		}
	},
	["2D"] = {
		["Headlights"] = {
			-- Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Width = 4.2,
			Height = 4.2,
			DeactivationState = "~OFF",
			IntensityGainFactor = 10,
			IntensityLossFactor = 10,
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

COMPONENT.StateMap = "[~SW] 1 2 3 4 5 6 15 16 [~A*0.5] 7 8 9 10 [~R] 11 12 19 20 21 [~R*0.7] 17 18 [~A] 13 14"

COMPONENT.Elements = {
	-- Normal headlights
	[1] = { "Model", Vector( 0, 0.2, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fl" },
	[2] = { "Model", Vector( 0, 0.2, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fr" },

	-- Whatever the fuck the side white lighting is on the headlight assemblyu
	[3] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl" },
	[4] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr" },

	-- 2D light for high-beams because the model was setup for VCMod sub-materials
	-- and therefore causes all sorts of fucking problems when using 2D for normal headlights
	[5] = { "Headlights", Vector( -33.35, 106, 32.65 ), Angle( 0, 0, 0 ) },
	[6] = { "Headlights", Vector( 33.35, 106, 32.65 ), Angle( 0, 0, 0 ) },

	-- Forward signals
	[7] = { "Model", Vector( 0, 0.1, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl" },
	[8] = { "Model", Vector( 0, 0.1, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr" },

	-- Forward markers
	[9] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_fl" },
	[10] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_fr" },

	-- Rear taillight halo
	[11] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/halo_rl" },
	[12] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/halo_rr" },

	-- Rear Signal
	[13] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl" },
	[14] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr" },

	-- Reverse
	[15] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl" },
	[16] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr" },

	-- Rear markers
	[17] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_rl" },
	[18] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_rr" },

	-- Brake
	[19] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl" },
	[20] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr" },
	[21] = { "Model", Vector( 0, 0, -5 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow_gradient_e" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 17 18 [~R*0.6] 19 20",
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Lights = {
		Frames = {
			[1] = "1 2 3 4 7 8 9 10 17 18 [~R*0.6] 19 20",
			[2] = "7 8 9 10 17 18 [~R*0.6] 19 20"
		},
		Sequences = {
			["PARKING"] = { 1 },
			["HEADLIGHTS"] = { 2 }
		}
	},
	Brake = {
		Frames = {
			[1] = "[~R] 19 20 21",
		},
		Sequences = {
			["BRAKE"] = { 1 },
		}
	},
	Reverse = {
		Frames = {
			[1] = "15 16",
		},
		Sequences = {
			["REVERSE"] = { 1 },
		}
	},
	Signal = {
		Off = "PASS",
		Frames = {
			[1] = "[A] 7 13 9",
			[2] = "[A] 8 14 10",
			[3] = "[A] 7 8 9 10 13 14"
		},
		Sequences = {
			LEFT = sequence():Alternate( 1, 0, 10 ),
			RIGHT = sequence():Alternate( 2, 0, 10 ),
			HAZARD = sequence():Alternate( 3, 0, 10 )
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ON"
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
}

-- This is not working and it's pissing me the fuck off
hook.Add( "HUDPaint", "Photon2:FPIS13MaterialOverride", function()
	Material( "sentry/13fpis/red_glass" ):SetInt( "$nowritez", 1 )
	timer.Simple( 5, function()
		Material( "sentry/13fpis/red_glass" ):SetInt( "$nowritez", 1 )
	end)
	hook.Remove( "HUDPaint", "Photon2:FPIS13MaterialOverride" )
end)