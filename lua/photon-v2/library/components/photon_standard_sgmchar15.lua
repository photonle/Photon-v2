if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Title = "Dodge Charger (2015)"
COMPONENT.Author = "Photon"
COMPONENT.IsVirtual = true
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}
COMPONENT.Category = "Vehicle"

COMPONENT.Features = {
	AutomaticHeadlights = true
}

COMPONENT.Templates = {
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/sgm_char15_emis.mdl",
			IntensityGainFactor = 10,
			IntensityLossFactor = 5,
			-- DeactivationState = "~OFF",
			ManipulateAlpha = false,
			DrawMaterial = "photon/common/glow_gradient_f",
			States = {}
		}
	}
}
 -- 2962795021
COMPONENT.StateMap = "[W*0.5] 1 2 [W] 3 4 11 12 [A] 5 6 9 [R] 7 8 10 13 14 15 16 17"

COMPONENT.Elements = {
	[1] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/drl_fl", DrawMaterial = "photon/common/glow" },
	[2] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/drl_fr", DrawMaterial = "photon/common/glow" },

	[3] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[4] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr", DrawMaterial = "photon/common/glow_gradient_a"  },

	[5] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow"  },
	[6] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow"  },

	[7] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl" },
	[8] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr" },

	[9] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_fl" },
	[10] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/mar_rl" },

	[11] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl" },
	[12] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr" },

	[13] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/tai_ru", DrawMaterial = "photon/lights/char15_tail"  },
	[14] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/tai_rb", DrawMaterial = "photon/lights/char15_tail"  },

	[15] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/lights/char15_tail" },
	[16] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/lights/char15_tail" },

	[17] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17"
		},
		Sequences = {
			ALL = { 1 }
		}
	},
	["Brake"] = {
		Off = "PASS",
		Frames = {
			[1] = "7 8 17",
		},
		Sequences = {
			["BRAKE"] = { 1 }
		}
	},
	["Reverse"] = {
		Frames = {
			[1] = "11 12",
		},
		Sequences = {
			["REVERSE"] = { 1 }
		}
	},
	["Lights"] = {
		Frames = {
			[1] = "1 2 9 10 13 14 15 16",
			[2] = "1 2 3 4 9 10 13 14 15 16",
		},
		Sequences = {
			["PARKING"] = { 1 },
			["HEADLIGHTS"] = { 2 },
		}
	},
	["DRL"] = {
		Frames = {
			[1] = "1 2",
		},
		Sequences = {
			["DRL"] = { 1 },
		}
	},
	-- Here is an example of handling joint brake/turn lights
	["Signal"] = {
		Off = "PASS",
		Frames = {
			[1] = "5 7",
			[2] = "[OFF] 5 7",
			[3] = "6 8",
			[4] = "[OFF] 6 8",
			[5] = "5 6 7 8",
			[6] = "[OFF] 5 6 7 8"
		},
		Sequences = {
			["LEFT"] = sequence():Alternate( 1, 2, 10 ),
			["RIGHT"] = sequence():Alternate( 3, 4, 10 ),
			["HAZARD"] =sequence():Alternate( 5, 6, 10 )
		}
	
	},
	WigWag = {
		Frames = {
			[1] = "[W] 1",
			[2] = "[W] 2",
		},
		Sequences = {
			["WIGWAG"] = sequence():Alternate( 1, 2, 8 )
		}
	},
	ReverseFlasher = {
		Frames = {
			[1] = "11",
			[2] = "12",
			[3] = "11 12"
		},
		Sequences = {
			["QUAD_FLASH"] = sequence():QuadFlash( 3, 0 ),
			["OFF"] = { 0 }
		}
	}, 
	BrakeFlasher = {
		Frames = {
			[1] = "7",
			[2] = "8",
			[3] = "7 8",
		},
		Sequences = {
			["QUAD_FLASH"] = sequence():QuadFlash( 0, 3 ),
			["OFF"] = { 0 }
		}
	},
	TailFlasher = {
		Frames = {
			[1] = "13 14 15 16"
		},
		Sequences = {
			["FLASH"] = sequence()
				:FlashHold( 1, 3, 2 ):Off( 4 )
				:FlashHold( 1, 3, 2 ):Off( 4 )
				:FlashHold( 1, 3, 2 ):Off( 4 )
				:Alternate( 1, 0, 3 ):Do( 6 ),
			["OFF"] = { 0 }
		}
	}
}

COMPONENT.Inputs = {
	["Vehicle.Brake"] = {
		["BRAKE"] = { Brake = "BRAKE" }
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = { Reverse = "REVERSE" }
	},
	["Vehicle.Lights"] = {
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
	["Vehicle.Signal"] = {
		["LEFT"] = { Signal = "LEFT" },
		["RIGHT"] = { Signal = "RIGHT" },
		["HAZARD"] = { Signal = "HAZARD" }
	},
	["Emergency.Warning"] = {
		["MODE2"] = {
			ReverseFlasher = "QUAD_FLASH",
			BrakeFlasher = "QUAD_FLASH",
		},
		["MODE3"] = {
			WigWag = "WIGWAG",
			ReverseFlasher = "QUAD_FLASH",
			BrakeFlasher = "QUAD_FLASH",
			TailFlasher = "FLASH"
		}
	},
	["Emergency.Cut"] = {
		["REAR"] = {
			TailFlasher = "OFF",
			BrakeFlasher = "OFF",
			ReverseFlasher = "OFF"
		}
	}
}
