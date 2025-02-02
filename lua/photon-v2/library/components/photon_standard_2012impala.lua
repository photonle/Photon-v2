if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "Super Mighty",
	Code = "JohnAfro"
}

COMPONENT.PrintName = "2012 Chevrolet Impala"

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
			DeactivationState = "~OFF",
		}
	},
	["Mesh"] = {
		Mesh_static = {
			Model = "models/johnafro/impala_lights.mdl",
			Scale = 1.0,
		},
		Mesh_static_fast = {
			Model = "models/johnafro/impala_lights.mdl",
			Scale = 1.0,
			IntensityGainFactor = 12,
			IntensityLossFactor = 6,
			DeactivationState = "~OFF",
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

COMPONENT.Elements = {
	[1] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fl_lowbeam", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[2] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fr_lowbeam", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[3] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/bl_brake", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[4] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/br_brake", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[5] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/bl_turn", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[6] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/br_turn", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },	

	[7] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fl_turn", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[8] = { "Projected", Vector( -34.201, 99.818, 37.33 ), Rotation = Angle( 0, 90, 0 ), },
	[9] = { "Projected", Vector( 34.201, 99.818, 37.33 ), Rotation = Angle( 0, 90, 0 ), },

	[10] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/bl_brake", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[11] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/br_brake", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[12] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fr_turn", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[13] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/bl_reverse", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[14] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/br_reverse", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[15] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/c_brake", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[16] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fl_highbeam", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },
	[17] = { "Mesh_static_fast", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "johnafro/impala_lights/fr_highbeam", DrawMaterial = "johnafro/impala_lights/glow_gradient_a", BloomMaterial = "johnafro/impala_lights/glow_gradient_a", BoneParent = -1 },

	[18] = { "Projected", Vector( -28.541, 106.02, 36.281 ), Rotation = Angle( 0, 90, 0 ), },
	[19] = { "Projected", Vector( 28.541, 106.02, 36.281 ), Rotation = Angle( 0, 90, 0 ), },
}

COMPONENT.StateMap = "[~WD] 8 9 18 19 [~WD] 1 2 16 17 [W] 3 4 5 6 7 10 11 12 13 14 15"

COMPONENT.ElementGroups = {
	["LOW_L"] = {1,8},
	["LOW_R"] = {2,9},
	["HIGH_L"] = {16,18},
	["HIGH_R"] = {17,19},
	
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["Headlights"] = {
		Frames = {
			[0] = "[~OFF] LOW_L LOW_R",
			[1] = "LOW_L LOW_R",
		},
		Sequences = {
				HEADLIGHTS = {
					1
				},
		}
	},
	["Brakes"] = {
		Frames = {
			[1] = "[~R] 10 11 15",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["Markers"] = {
		Frames = {
			[1] = "[~DR] 3 4 [~DA] 7 12",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["Reverse"] = {
		Frames = {
			[1] = "13 14",
		},
		Sequences = {
				ON = {
					1
				},
		}
	},
	["Signal_L"] = {
		Frames = {
			[0] = "[PASS] 5 7",
			[1] = "[~DR] 5 [~DA] 7",
			[2] = "[~R] 5 [~A] 7",
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
			[0] = "[PASS] 6 12",
			[1] = "[~DR] 6 [~DA] 12",
			[2] = "[~R] 6 [~A] 12",
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
			[0] = "[PASS] 5 7",
			[1] = "[~DR] 5 [~DA] 7",
			[2] = "[~R] 5 [~A] 7",
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
			[0] = "[PASS] 6 12",
			[1] = "[~DR] 6 [~DA] 12",
			[2] = "[~R] 6 [~A] 12",
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
			[0] = "[PASS] HIGH_L HIGH_R 10 11 [OFF] 3 4",
			[1] = "[~W2] HIGH_L 10:~R [OFF] 3 4",
			[2] = "[~W2] HIGH_R 11:~R [OFF] 3 4",
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
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Headlights = "HEADLIGHTS",
			Markers = "ON",
		},
		["PARKING"] = {
			--Headlights = "HEADLIGHTS",
			Markers = "ON",
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