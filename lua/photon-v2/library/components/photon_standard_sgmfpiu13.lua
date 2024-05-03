if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Title = "Ford Explorer (2013)"
COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}
COMPONENT.Category = "Vehicle"

-- Special component attributes
COMPONENT.Flags = {
	AutomaticHeadlights = true
}

COMPONENT.Templates = {
	["Mesh"] = {
		Mesh = {
			Model = "models/schmal/sgm_fpiu13_emis.mdl",
			IntensityGainFactor = 10,
			IntensityLossFactor = 10,
			States = {
				RD = {
					Inherit = "R",
					Intensity = 0.7
				},
				["~SW"] = {
					Inherit = "SW",
					IntensityTransitions = true
				},
				["~AD"] = {
					IntensityTransitions = true,
					Inherit = "A",
					Intensity = 0.6
				},
				["~A"] = {
					IntensityTransitions = true,
					Inherit = "A",
					Intensity = 1
				}
			}
		}
	},
	["2D"] = {
		Headlights = {
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
		RearMarker = {
			-- :-)
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_inner_edge_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/fpiu13_rear_marker_detail.png").MaterialName,
			Width = 3.4,
			Height = 1.6,
			Intensity = 1,
			Scale = 1,
			States = {
				RD = {
					Inherit = "R",
					Intensity = 0.9
				}
			}
		},
		ForwardMarker = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/fpiu13_forward_marker_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/fpiu13_forward_marker_detail.png").MaterialName,
			Width = 2,
			Height = 2,
			States = {
				AD = {
					Inherit = "A",
					Intensity = 0.7
				}
			}
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc" },
	[2] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_c" },
	[3] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_c" },

	[4] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr", DrawMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF" },
	[5] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl", DrawMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF" },
	
	[6] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_b", DeactivationState = "~OFF" },
	[7] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr", DrawMaterial = "photon/common/glow_gradient_b", DeactivationState = "~OFF" },
	
	[8] = { "Mesh", Vector( -0.3, 0.8, 0.2 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", Scale = 0.995, DrawMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF" },
	[9] = { "Mesh", Vector( 0.3, 0.8, 0.2 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", Scale = 0.995, DrawMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF"  },

	[10] = { "Headlights", Vector( -32.95, 105.5, 37.9 ), Angle( 0, 0, 0 ) },
	[11] = { "Headlights", Vector( 32.95, 105.5, 37.9 ), Angle( 0, 0, 0 ) },

	[12] = { "RearMarker", Vector( -40.35, -113, 49.92 ), Angle( -14, 117, 0 ) },
	[13] = { "RearMarker", Vector( 40.35, -113, 49.92 ), Angle( -14, 180 + ( 180 - 117 ), 0 ) },

	[14] = { "ForwardMarker", Vector( -38.84, 96, 44.3 ), Angle( -23, 65, 0 ) },
	[15] = { "ForwardMarker", Vector( 38.84, 96, 44.3 ), Angle( -23, 180 + ( 180 - 65 ), 0 ) },
}

COMPONENT.StateMap = "[R] 1 2 3 12 13 [~SW] 4 5 10 11 [~A] 6 7 8 9 [AD] 14 15"

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
	Lights = {
		Frames = {
			[0] = "[OFF] 2 3 12 13 14 15 [~OFF] 6 7 8 9",
			[1] = "14 15 [RD] 2 3 12 13 [~AD] 8 9",
			[2] = "14 15 10 11 [RD] 2 3 12 13 [~AD] 8 9",
		},
		Sequences = {
			["PARK"] = { 1 },
			["HEADLIGHTS"] = { 2 }
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
	ReverseFlasher = {
		Frames = {
			[1] = "[B] 4 5",
			[2] = "[B] 4",
			[3] = "[B] 5",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():TripleFlash( 2, 3 ):SetTiming( 1/30 )
		}
	},
	SignalFlasher = {
		Frames = {
			[1] = "[R] 6 7",
			[2] = "[R] 6",
			[3] = "[R] 7",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():FlashHold( { 2, 3 }, 2, 3 )
		}
	},
	WigWag = {
		Frames = {
			[0] = "[~OFF] 10 11",
			[1] = "10",
			[2] = "11",
		},
		Sequences = {
			["WIGWAG"] = sequence():Alternate( 1, 2, 9 ),
		}
	},
	Signal = {
		Frames = {
			[0] = "[PASS] 6 7 8 9",
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
	},
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Lights = "HEADLIGHTS"
		},
		["PARKING"] = {
			Lights = "PARK"
		}
	},
	-- ["Emergency.Warning"] = {
	-- 	["MODE1"] = {
	-- 		ReverseFlasher = "FLASH",
	-- 		SignalFlasher = "FLASH"
	-- 	},
	-- 	["MODE2"] = {
	-- 		ReverseFlasher = "FLASH",
	-- 		SignalFlasher = "FLASH"
	-- 	},
	-- 	["MODE3"] = {
	-- 		ReverseFlasher = "FLASH",
	-- 		SignalFlasher = "FLASH",
	-- 		WigWag = "WIGWAG"
	-- 	}
	-- }
}

hook.Add( "HUDPaint", "Photon2.FPIU13RefractFix", function() 

	local target  = Material( "sentry/13fpiu/lights_refract" )
	target:SetInt( "$nowritez", 1 )

	hook.Remove( "HUDPaint", "Photon2.FPIU13RefractFix" )
end)