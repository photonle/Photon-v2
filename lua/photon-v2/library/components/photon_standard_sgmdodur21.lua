if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2021 Dodge Durango (PPV)"

COMPONENT.IsVirtual = true

-- Special component attributes
COMPONENT.Flags = {
	AutomaticHeadlights = true
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.StateMap = "[1] 20 [2] 19"

local red = { r = 255, g = 0, b = 0 }

COMPONENT.Templates = {
	["2D"] = {
		Marker = {
			Width = 0.7,
			Height = 0.7,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/dodur21_marker_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/dodur21_marker_shape.png").MaterialName,
			Scale = 0.35
		}
	},
	["Sub"] = {
		SubMaterial = {}
	},
	["Mesh"] = {
		["Model"] = {
			Model = "models/sentry/21durango.mdl",
			States = {
				["A"] = {
					Inherit = "A",
					-- DrawMaterial = "photon/common/bloom"
				}
			}
		},
		["Emis"] = {
			Model = "models/schmal/dodur21_emis.mdl",
			IntensityGainFactor = 10,
			IntensityLossFactor = 10,
			States = {
				["~A"] = {
					Inherit = "A",
					Intensity = 1,
					IntensityTransitions = true
				},
				["~AD"] = {
					Inherit = "A",
					Intensity = 0.6,
					IntensityTransitions = true
				},
				["WD"] = {
					Inherit = "W",
					Intensity = 0.7
				},
				-- ["R"] = {
				-- 	BloomColor = PhotonColor( 255, 0, 32 ):Blend( red ):GetBlendColor(),
				-- 	DrawColor = PhotonColor( 255, 128, 32 ):Blend( red ):GetBlendColor(),
				-- }
			}
		}
	}
}

COMPONENT.ElementStates = {
	["Sub"] = {
		["OFF"] = { Material = nil },
		["DRL"] = {
			Material = "sentry/21durango/lights_on"
			-- Material = "photon/common/glow"
		},
		["Tail_Red"] = {
			Material = "sentry/21durango/lights_on"
		},
		["On"] = {
			Material = "sentry/21durango/lights_on"
		},
		["Ridges_White"] = {
			Material = "sentry/21durango/lights_ridges_white_on"
		},
		["Ridges_Red"] = {
			Material = "sentry/21durango/lights_ridges_on"

		},
		Hide = {
			Material = "photon/common/blank"
		}
	}
}


COMPONENT.Elements = {
	[1] = { "SubMaterial", Indexes = { 12 } }, -- DRL R
	[2] = { "SubMaterial", Indexes = { 13 } }, -- DRL L
	
	[3] = { "SubMaterial", Indexes = { 4 } }, -- Brake R
	[4] = { "SubMaterial", Indexes = { 5 } }, -- Brake L
	
	[5] = { "SubMaterial", Indexes = { 7 } }, -- Reverse L
	[6] = { "SubMaterial", Indexes = { 6 } }, -- Reverse R
	
	[7] = { "SubMaterial", Indexes = { 8 } }, -- Tail L
	[8] = { "SubMaterial", Indexes = { 11 } }, -- Tail R
	
	[9] = { "SubMaterial", Indexes = { 9 } }, -- Tail Center Top
	[10] = { "SubMaterial", Indexes = { 10 } }, -- Tail Center Bottom

	[11] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_ct", DrawMaterial = "sentry/21durango/lights_on" },
	[12] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_cb", DrawMaterial = "sentry/21durango/lights_on" },
	
	[13] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_l", DrawMaterial = "sentry/21durango/lights_on" },
	[14] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_r", DrawMaterial = "sentry/21durango/lights_on" },
	
	[15] = { "Emis", Vector( 0, .1, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl" },
	[16] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr" },

	[17] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/reverse_l", DrawMaterial = "sentry/21durango/lights_ridges_white_on" },
	[18] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/reverse_r", DrawMaterial = "sentry/21durango/lights_ridges_white_on" },

	[19] = { "Model", Vector( 0, -0.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/brake_r", DrawMaterial = "photon/common/ridges" },
	[20] = { "Model", Vector( 0, -0.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/brake_l", DrawMaterial = "photon/common/ridges" },
	
	[21] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc" },
	
	[22] = { "Emis", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[23] = { "Emis", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr", DrawMaterial = "photon/common/glow_gradient_a" },

	[24] = { "Emis", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fl", DrawMaterial = "photon/common/glow_gradient_a", BloomMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF" },
	[25] = { "Emis", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hib_fr", DrawMaterial = "photon/common/glow_gradient_a", BloomMaterial = "photon/common/glow_gradient_a", DeactivationState = "~OFF" },

	[26] = { "Marker", Vector( -45.65, 92.8, 34.6 ), Angle( 7, 85, -30 ) },
	[27] = { "Marker", Vector( 45.66, 92.8, 34.6 ), Angle( 7, -85, -30 ) },

}

COMPONENT.ElementGroups = {

}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Parking = {
		Frames = {
			[1] = "26:A 27:A 24:~AD 25:~AD 7:Tail_Red 13:R 8:Tail_Red 14:R 9:Tail_Red 10:Tail_Red 11:R 12:R",
			[2] = "[A] 26 27 [~AD] 24 25 [Tail_Red] 7 8 [R] 11 12 13 14"
		},
		Sequences = {
			ON = { 2 }
		}
	},
	Headlights = {
		Frames = {
			[1] = "22:W 23:W 1:Hide 16:W 2:Hide 15:W",
			[2] = "[WD] 15 16 [W] 22 23 [Hide] 1 2"
		},
		Sequences = {
			ON = { 2 }
		}
	},
	HeadlightL = {
		Frames = {
			[1] = "22:W 24:~AD 26:A"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	HeadlightR = {
		Frames = {
			[1] = "23:W 27:A"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Signal_L = {
		Frames = {
			[0] = "24:PASS 20:OFF 4:OFF",
			[1] = "24:~AD",
			[2] = "24:~A 20:R 4:Ridges_Red",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 2, 0, 10 )
		}
	},
	Signal_R = {
		Frames = {
			[0] = "25:PASS 19:OFF 3:OFF",
			[1] = "25:~AD",
			[2] = "25:~A 19:R 3:Ridges_Red",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 2, 0, 10 )
		}
	},
	DRL = {
		Frames = {
			[1] = "[Hide] 1 2 [WD] 15 16",
			[2] = "[Hide] 1 [W] 15",
			[3] = "[Hide] 2 [W] 16",
		},
		Sequences = {
			ON = { 1 },
			FLASH = sequence():Alternate( 2, 3, 8 )
		}
	},
	Brake = {
		Frames = {
			[1] = "[Ridges_Red] 3 4 [R] 19 20 21"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Brake_R = {
		Frames = {
			[1] = "3:Hide [1] 19",
			[2] = "3:Hide [W] 19"
		 },
		 Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():Flash( 2, 1, 3 ),
			["STEADY"] = { 1 },
		}
	},
	Brake_L = {
		Frames = {
			[1] = "4:Hide [1] 20",
			[2] = "4:Hide [W] 20",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():Flash( 1, 2, 3 ),
			["STEADY"] = { 1 },
		 }
	},
	Tail_L = {
		Frames = {
			[1] = "7:Tail_Red 13:R"
		 },
		 Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():Flash( 0, 1, 4 ):Do( 4 ):Alternate( 0, 1, 2 ):Do( 4 )
		}
	},
	Tail_R = {
		Frames = {
			[1] = "8:Tail_Red 14:R"
		},
		Sequences = {
			 ["ON"] = { 1 },
			 ["FLASH"]  = sequence():Flash( 0, 1, 4 ):Do( 4 ):Alternate( 0, 1, 2 ):Do( 4 )
		},
	},
	Tail_Center = {
		Frames = {
			[1] = "9:Tail_Red 10:Tail_Red 11:R 12:R"
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():Flash( 1, 0, 4 ):Do( 4 ):Alternate( 1, 0, 2 ):Do( 4 )
		}
	},
	Reverse_L = {
		Frames = {
			[1] = "5:Ridges_White 17:W"
		 },
		 Sequences = {
			["ON"]  = { 1 }
		 }
	},
	Reverse_R = {
		Frames = {
			[1] = "6:Ridges_White 18:W"
		 },
		 Sequences = {
			["ON"] = { 1 }
		 }
	},
}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Parking = "ON",
			Headlights = "ON"
		},
		["PARKING"] = {
			Parking = "ON"
		},
		["AUTO"] = {
			DRL = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Signal_L = "SIGNAL"
		},
		["RIGHT"] = {
			Signal_R = "SIGNAL"
		},
		["HAZARD"] = {
			Signal_R = "SIGNAL",
			Signal_L = "SIGNAL"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brake = "ON"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			["Reverse_L"] = "ON",
			["Reverse_R"] = "ON"
		}
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			Brake_R = "STEADY",
			Brake_L = "STEADY",
		},
		["MODE2"] = {
			Brake_R = "FLASH",
			Brake_L = "FLASH",
		},
		["MODE3"] = {
			["DRL"] = "FLASH",
			Brake_R = "FLASH",
			Brake_L = "FLASH",
			Tail_L = "FLASH",
			Tail_R = "FLASH",
			Tail_Center = "FLASH",
		}
	}
}