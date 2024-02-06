if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.Templates = {
	["Mesh"] = {
		Mesh = {
			Model = "models/schmal/sgm_fpiu13_emis.mdl"
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc" },
	[2] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[3] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_a" },

	[4] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr", DrawMaterial = "photon/common/glow_gradient_a" },
	[5] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[6] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[7] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr" },
	
	[8] = { "Mesh", Vector( -0.3, 1.3, 0.2 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", Scale = 0.995, DrawMaterial = "photon/common/glow_gradient_a" },
	[9] = { "Mesh", Vector( 0.3, 1.3, 0.2 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", Scale = 0.995, DrawMaterial = "photon/common/glow_gradient_a"  },
}

COMPONENT.StateMap = "[R] 1 2 3 [SW] 4 5 [A] 6 7 8 9"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Reverse = {
		Frames = {
			[1] = "4 5"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Signal = {
		Frames = {
			[1] = "6 7 8 9",
			[2] = "6 8",
			[3] = "7 9"
		},
		Sequences = {
			["ON"] = { 1 },
			["LEFT"] = sequence():Alternate( 2, 0, 8 ),
			["RIGHT"] = sequence():Alternate( 3, 0, 8 ),
			["HAZARD"] = { 1 },
			-- ["HAZARD"] = sequence():Alternate( 1, 0, 8 ),
		}
	},
}

COMPONENT.Inputs = {
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			All = "ON"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Signal = "LEFT",
		},
		["RIGHT"] = {
			Signal = "RIGHT",
		},
		["HAZARD"] = {
			Signal = "HAZARD"
		}
	}
}

hook.Add( "HUDPaint", "Photon2.FPIU13RefractFix", function() 

	local target  = Material( "sentry/13fpiu/lights_refract" )
	target:SetInt( "$nowritez", 1 )

	hook.Remove( "HUDPaint", "Photon2.FPIU13RefractFix" )
end)