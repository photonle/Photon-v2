if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "JohnAfro"
}

COMPONENT.PrintName = "2017 Dodge Demon"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["2D"] = {
		Light_invis = {
			-- Shape = "sprites/emv/sgm_headlight",
			-- Detail = "sprites/emv/sgm_headlight",
			-- MaterialBloom = "sprites/emv/sgm_headlight",
			Width = 7.7,
			Height = 7.7,
			Scale = 1.0,
		},
	},
	["Projected"] = {
		Projected = {
			FOV = 80,
			Texture = "effects/flashlight/soft",
			NearZ = 4,
			FarZ = 2000,
			Brightness = 3,
			IntensityGainFactor = 12,
			IntensityLossFactor = 6,
			
		}
	},
	["Mesh"] = {
		Mesh_static = {
			Model = "models/johnafro/2017demon_lights/2017demon_lights.mdl",
			Scale = 1.0,
		},
		Mesh_static_fast = {
			Model = "models/johnafro/2017demon_lights/2017demon_lights.mdl",
			Scale = 1.0,
			IntensityGainFactor = 12,
			IntensityLossFactor = 6,
			
		},
	},
	["Sub"] = {
		Dials = {
			States = {
				["ON"] = { Material = "sentry/demon_fh3/gauges_lite" }
			}
		},
		Dials2 = {
			States = {
				["ON"] = { Material = "sentry/demon_fh3/symbols_lite" }
			}
		},
	},
}

local wScale = 0.9
local bScale = 0.66
local rScale = 0.66

local amber = { r = 255, g = 200, b = 0 }

local white = { r = 255, g = 255, b = 255 }

COMPONENT.ElementStates = {
	["Projected"] = {
		["~W"] = {
			Inherit = "SW",
			IntensityTransitions = true,
		},
		["~WD"] = {
			Inherit = "SW",
			IntensityTransitions = true,
			Intensity = 0.8,
		},
		["~W2"] = {
			Inherit = "SW",
			IntensityTransitions = true,
			Intensity = 1.25,
		}
	},
	["2D"] = {
		["~OFF"] = {
			Intensity = 0,
			IntensityTransitions = true,
			IntensityGainFactor = 8,
			IntensityLossFactor = 3,
		},
		["~OFF_FAST"] = {
			Intensity = 0,
			IntensityTransitions = true,
			IntensityGainFactor = 8,
			IntensityLossFactor = 6,
		},
		["~W"] = {
			Blend = Color( 200, 200, 255 ),
			SourceDetailColor = PhotonColor(255,245,205):Blend(white):GetBlendColor(),
			SourceFillColor = PhotonColor( 255, 245, 205 ):Blend(white):GetBlendColor(),
			GlowColor = PhotonColor(150*wScale, 150*wScale, 150*wScale):Blend(white):GetBlendColor(),
			InnerGlowColor = PhotonColor(255*wScale, 245*wScale, 205*wScale):Blend(white):GetBlendColor(),
			ShapeGlowColor = PhotonColor(120*wScale, 120*wScale, 120*wScale):Blend(white):GetBlendColor(),
			Intensity = 1,
			IntensityTransitions = true,
			IntensityGainFactor = 8,
			IntensityLossFactor = 3,
		},
		["~A"] = {
			Inherit = "A",
			Intensity = 1,
			IntensityTransitions = true,
			IntensityGainFactor = 12,
			IntensityLossFactor = 6,
		},
		["~G"] = {
			Inherit = "G",
			Intensity = 1,
			IntensityTransitions = true,
			IntensityGainFactor = 12,
			IntensityLossFactor = 3,
		},
	},
	["Mesh"] = {
		["~OFF"] = { Intensity = 0, IntensityTransitions = true },
		["~SW"] = {
			Inherit = "SW",
			Intensity = 1,
			IntensityTransitions = true,
		},
		["~WD"] = {
			Inherit = "SW",
			Intensity = 0.75,
			IntensityTransitions = true,
		},
		["~W"] = {
			Inherit = "SW",
			Intensity = 1.0,
			IntensityTransitions = true,
		},
		["~W2"] = {
			Inherit = "SW",
			Intensity = 1.0,
			IntensityTransitions = true,
		},
		["~R"] = {
			Inherit = "R",
			Intensity = 0.8,
			IntensityTransitions = true,
			
		},
		["~DA"] = {
			Intensity = 0.6,
			IntensityTransitions = true,
			BloomColor = PhotonColor( 255, 150, 0 ),
			DrawColor = PhotonColor( 255, 150, 0 ),
		},
		["~A"] = {
			Intensity = 1,
			IntensityTransitions = true,
			BloomColor = PhotonColor( 255, 150, 0 ),
			DrawColor = PhotonColor( 255,150, 0 ),
		},
		["~DW"] = {
			Inherit = "W",
			Intensity = 0.6,
			IntensityTransitions = true,
		},
		["~DR"] = {
			Inherit = "R",
			Intensity = 0.6,
			IntensityTransitions = true,
		},
	}
}
local offset = .2
COMPONENT.Elements = {
	[1] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fl_headlight", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1, DeactivationState = "~OFF" },
	[2] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fr_headlight", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1, DeactivationState = "~OFF" },

	[3] = { "Mesh_static_fast", Vector( 0, offset, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fl_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[4] = { "Mesh_static_fast", Vector( 0, offset, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fr_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },	

	[5] = { "Mesh_static_fast", Vector( 0, offset, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/ml_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[6] = { "Mesh_static_fast", Vector( 0, offset, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/mr_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[7] = { "Mesh_static_fast", Vector( 0, -.15, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/cbrake", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[8] = { "Projected", Vector( -37.529, 108.96, 32.281 ), Rotation = Angle( 0, 90, 0 ), DeactivationState = "~OFF" },
	[9] = { "Projected", Vector( 37.529, 108.96, 32.281 ), Rotation = Angle( 0, 90, 0 ), DeactivationState = "~OFF" },

	[10] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rr_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[11] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rl_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[12] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rml_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[13] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/mrr_running", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[14] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rr_reverse", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[15] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rl_reverse", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[16] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rl_brake", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[17] = { "Mesh_static_fast", Vector( 0, -.05, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/rr_brake", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	
	[18] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fl_turn", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[19] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fr_turn", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },

	[20] = { "Dials", Indexes = { 12 } },
	[21] = { "Dials2", Indexes = { 9 } },

	[22] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fl_headlight", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },
	[23] = { "Mesh_static_fast", Vector( 0, .2, 0 ), Angle( 0, 90, 0 ), "johnafro/2017demon_lights/fr_headlight", DrawMaterial = "johnafro/2017demon_lights/lightglow", BoneParent = -1 },



	

}

COMPONENT.StateMap = "[W] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 22 23 [ON] 20 21"

COMPONENT.ElementGroups = {
	["LOW_L"] = {1,8},
	["LOW_R"] = {2,9},
	
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["Headlights"] = {
		Frames = {
			[0] = "[~OFF] LOW_L LOW_R",
			[1] = "[~WD] LOW_L LOW_R",
		},
		Sequences = {
				HEADLIGHTS = {
					1
				},
		}
	},
	["Brakes"] = {
		Frames = {
			[1] = "[R] 7 16 17",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["Markers"] = {
		Frames = {
			[1] = "[W] 5 6 3 4 [~DR] 10 11 12 13 [ON] 20 21",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["RunningBois"] = {
		Frames = {
			[1] = "[W] 5 6 3 4",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},	
	["Reverse"] = {
		Frames = {
			[1] = "14 15",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["Signal_L"] = {
		Frames = {
			--[0] = "[PASS] 18 16",
			[1] = "[DA] 18 [DR] 16",
			[2] = "[A] 18 [R] 16",
		},
		Sequences = {
				DIM = {
					1
				},
				SIGNAL = {
					2,2,2,2,2,2,2,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,
				},
		}
	},
	["Signal_R"] = {
		Frames = {
			--[0] = "[PASS] 19 17",
			[1] = "[DA] 19 [DR] 17",
			[2] = "[A] 19 [R] 17",
		},
		Sequences = {
				DIM = {
					1
				},
				SIGNAL = {
					2,2,2,2,2,2,2,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,
				},
		}
	},
	["Signal_L_DIM"] = {
		Frames = {
			[0] = "[PASS] 18",
			[1] = "[~DA] 18",
			[2] = "[~A] 18",
		},
		Sequences = {
				DIM = {
					1
				},
				SIGNAL = {
					2,2,2,2,2,2,2,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,
				},
		}
	},
	["Signal_R_DIM"] = {
		Frames = {
			[0] = "[PASS] 19",
			[1] = "[~DA] 19",
			[2] = "[~A] 19",
		},
		Sequences = {
				DIM = {
					1
				},
				SIGNAL = {
					2,2,2,2,2,2,2,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,
				},
		}
	},
	["Headlight_flashers"] = {
		Frames = {
			[0] = "[PASS] LOW_L LOW_R",
			[1] = "[~W2] LOW_L",
			[2] = "[~W2] LOW_R",
		},
		Sequences = {
				FLASH = {
					1,1,1,1,1,1,
					2,2,2,2,2,2,
				},
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE3"] = {
			Headlight_flashers = "FLASH",
			-- Taillight_flashers = "FLASH",
			--Taillight_flashers_strobe = "FLASH",
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brakes = "ON",
		}
	},
	["Vehicle.Engine"] = {
		["ON"] = {
			RunningBois = "ON",
		}
	},
	
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Headlights = "HEADLIGHTS",
			Markers = "ON",
			---Signal_L_DIM = "DIM",
			--Signal_R_DIM = "DIM",
		},
		["PARKING"] = {
			--Headlights = "HEADLIGHTS",
			Markers = "ON",
			--Signal_L_DIM = "DIM",
			--Signal_R_DIM = "DIM",
			-- Interior = "ON",
			-- Plate = "ON",
			-- LightSwitch = "PARKING",
		},
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Signal_L = "SIGNAL",
		},
		["RIGHT"] = {
			Signal_R = "SIGNAL",
		},
		["HAZARD"] = {
			Signal_L = "SIGNAL",
			Signal_R = "SIGNAL",
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse = "ON",
		},
		-- ["PARK"] = {
		-- 	Gear = "PARK",
		-- },
	},
}