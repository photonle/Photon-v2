local startTime = SysTime()
if (Photon2.ReloadComponentFile()) then return end
---@class PhotonStandardSGMFPIU20 : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SuperMighty",
	Code = "Schmal"
}

-- Material changes:

local function runMaterialOverride()
	Material("models/supermighty/2016_fpiu/red_glass"):SetInt( "$nowritez", 1 )
end


COMPONENT.PrintName = "2016 Ford Police Interceptor Utility"

-- Virtual component means the component doesn't spawn a model,
-- and will instead manipulate the existing vehicle entity.
COMPONENT.IsVirtual = true

local s = 1

-- Templates
-- Each name must be unique, even they aren't the same light class.
COMPONENT.Templates = {
	["2D"] = {

	},
	["Sub"] = {
		SubMat = {}
	},
	["Mesh"] = {
		ModelMesh = {
			Model = "models/smcars/2016_fpiu.mdl"
		},
		Emis = {
			Model = "models/schmal/sm_fpiu16_emis.mdl",
			DrawMaterial = "photon/common/glow_gradient_a",
			Scale = 1.002
		}
	}
}


COMPONENT.ElementStates = {
	["2D"] = {

	},
	["Sub"] = {
		["OFF"] = {
			Material = nil
		},
		["HIDE"] = {
			Material = "photon/common/blank"
		}
	},
	["Mesh"] = {
		["A_D"] = {
			Inherit = "A",
			Intensity = 0.7
		},
		["W_D"] = {
			Inherit = "W",
			Intensity = 0.9
		},
		["~SW"] = {
			Inherit = "SW", 
			IntensityTransitions = true,
			Intensity = 1
		}
	}
}

COMPONENT.LightGroups = {
	["Tail_L"] = { 1, 2, 22 },
	["Tail_R"] = { 3, 4, 23 },
	["Brake_L"] = { 5, 6 },
	["Brake_R"] = { 7, 8 },
	["Brake_C"] = { 15 },
	["Fwd_L"] = { },
	["Fwd_R"] = { }
}

COMPONENT.Elements = {
	[1] = { "SubMat", Indexes = { 11 } },
	[2] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/tail_left" },
	
	[3] = { "SubMat", Indexes = { 12 } },
	[4] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/tail_right" },
	
	[5] = { "SubMat", Indexes = { 10 } },
	[6] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/brake_driver" },

	[7] = { "SubMat", Indexes = { 9 } },
	[8] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/brake_pass" },
	
	[9] = { "SubMat", Indexes = { 4 } },
	[10] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/brake_centre" },
	
	[11] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/rev_rl" },
	[12] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/rev_rr" },
	
	[13] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/sig_rl" },
	[14] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/sig_rr" },

	-- mesh placement is bad for some reason
	[15] = { "Emis", Vector( -0.6, 1, -0.1 ), Angle( 0, -90, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow" },

	[16] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/hdl_fr", IntensityGainFactor = 5, IntensityLossFactor = 5 },
	[17] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/hdl_fl", IntensityGainFactor = 5, IntensityLossFactor = 5 },

	[18] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/hib_fr" },
	[19] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/hib_fl" },

	[20] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/sig_fr" },
	[21] = { "Emis", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "photon/vehicle/sig_fl" },

	[22] = { "Emis", Vector( -0.25, 0.5, 0 ), Angle( 0, -90.1, 0 ), "photon/vehicle/mar_rl" },
	[23] = { "Emis", Vector( 0.4, 0.5, 0 ), Angle( 0, -89.9, 0 ), "photon/vehicle/mar_rr" },

	[24] = { "SubMat", Indexes = { 22 } },
	[25] = { "ModelMesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "models/supermighty/2016_fpiu/drl", DrawMaterial = "schmal/sm_fpiu16/drl", BloomMaterial = "schmal/sm_fpiu16/drl" },


}

COMPONENT.ColorMap = "[R] 2 4 6 8 10 15 22 23 [HIDE] 1 3 5 7 9 24 [W] 11 12 18 19 [A] 13 14 20 21 [~SW] 16 17 [W_D] 25"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Headlights = {
		Frames = {
			
		},
		Sequences = {
			["HEADLIGHTS"] = {},
			["PARKING"] = {}
		}
	},
	Tail_L = {
		Frames = {
			[1] = "Tail_L"
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Tail_R = {
		Frames = {
			[1] = "Tail_R"
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Turn_L = {
		Frames = {
			[1] = "13"
		},
		Sequences = {
			["ON"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
		}
	},
	Turn_R = {
		Frames = {
			[1] = "14"
		},
		Sequences = {
			["ON"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
		}
	},
	Reverse_L = {
		Frames = {
			[1] = "11"
		},
		Sequences = { 
			["ON"] = { 1 },
		}
	},
	Reverse_R = {
		Frames = {
			[1] = "12"
		},
		Sequences = { 
			["ON"] = { 1 },
		}
	},
	Brake = {
		Frames = {
			[1] = "Brake_L Brake_R Brake_C"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Marker = {
		Frames = {
			[1] = "[A_D] 21 20"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	HighBeam_L = {
		Frames = {
			[0] = "[~OFF] 17",
			[1] = "17",
		},
		Sequences = {
			["WIGWAG"] = sequence():Alternate( 1, 0, 10 ),
			["ON"] = { 1 },
		}
	},
	HighBeam_R = {
		Frames = {
			[0] = "[~OFF] 16",
			[1] = "16",
		},
		Sequences = {
			["WIGWAG"] = sequence():Alternate( 0, 1, 10 ),
			["ON"] = { 1 },
		}
	},
	Headlight_L = {
		Frames = {
			[1] = "19"
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Headlight_R = {
		Frames = {
			[1] = "18"
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	FwdSignal_L = {
		Frames = {
			[0] = "[PASS] 21",
			[1] = "21"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
			["ON"] = { 1 }
		}
	},
	FwdSignal_R = {
		Frames = {
			[0] = "[PASS] 20",
			[1] = "20"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
			["ON"] = { 1 }
		}
	},
	DRL = {
		Frames = {
			[1] = "24 25"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	}
	-- Parking_R = {

	-- }
}

--TODO: verify that sequences exist on compilation
COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			-- Headlights = "HEADLIGHTS",
			Marker = "ON",
			Headlight_L = "ON",
			Headlight_R = "ON",
			DRL = "ON",
			Tail_L = "ON",
			Tail_R = "ON",

			-- Brake = "ON",
			-- Reverse_L = "ON",
			-- Reverse_R = "ON",
			-- Turn_L = "ON",
			-- Turn_R = "ON",
			-- HighBeam_L = "ON",
			-- HighBeam_R = "ON",
			-- FwdSignal_L = "ON",
			-- FwdSignal_R = "ON",
		},
		["PARKING"] = {
			-- Headlights = "HEADLIGHTS",
			Marker = "ON",
			Tail_L = "ON",
			Tail_R = "ON",
			DRL = "ON"
		},
		["DRL"] = {
			["DRL"] = "ON"
		}
	},
	["Vehicle.HighBeam"] = {
		["HIGH_BEAMS"] = {
			HighBeam_L = "ON",
			HighBeam_R = "ON"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brake  = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Turn_L = "SIGNAL",
			FwdSignal_L = "SIGNAL"
		},
		["RIGHT"] = {
			Turn_R = "SIGNAL",
			FwdSignal_R = "SIGNAL"
		},
		["HAZARD"] = {
			Turn_L = "SIGNAL",
			Turn_R = "SIGNAL",
			FwdSignal_L = "SIGNAL",
			FwdSignal_R = "SIGNAL"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse_L = "ON",
			Reverse_R = "ON",
		}
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			HighBeam_L = "WIGWAG",
			HighBeam_R = "WIGWAG",
		}
	}
}

hook.Add( "InitPostEntity", "Photon.SMFPIU16:MaterialOverride", runMaterialOverride )
runMaterialOverride()