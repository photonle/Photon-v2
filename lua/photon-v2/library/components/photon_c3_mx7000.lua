if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.WorkshopRequirements = {
	[2821476376] = "Code 3 MX7000 Model"
}

COMPONENT.Title = [[Code 3 MX7000]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/sentry/props/mx7k.mdl"

COMPONENT.SubMaterials = {
	[0] = "photon/textures/mx7000_glass_colored",
	[1] = "photon/textures/mx7000_glass_outer",
	[2] = "photon/textures/mx7k",
	[3] = "photon/textures/glass_mx7000",
	-- [2] = "photon/textures/mx7000",
	-- [0] = nil,
	-- [2] = nil
}

local blue = { r = 0, g = 255, b = 255 }
local red = { r = 255, g = 64, b = 0 }
local amber = { r = 255, g = 100, b = 0 }

COMPONENT.ElementStates = {
	["Mesh"] = {
		["OFF"] = { Intensity = 0, IntensityTransitions = true },
		["~SW"] = { Inherit = "SW", IntensityTransitions = true },
		["~R"] = { 
			Intensity = 1,
			IntensityTransitions = true,
			BloomColor = PhotonColor( 255, 0, 0 ):Blend( red ):GetBlendColor(),
			DrawColor = PhotonColor( 255, 225, 100 ):Blend( red ):GetBlendColor(),
		},
		["~B"] = { 
			Intensity = 1,
			IntensityTransitions = true,
			BloomColor = PhotonColor( 0, 150, 255 ):Blend( blue ):GetBlendColor(),
			DrawColor = PhotonColor( 205, 255, 255 ):Blend( blue ):GetBlendColor(),
		},
		["~A"] = {
			Intensity = 1,
			IntensityTransitions = true, 
			BloomColor = PhotonColor( 255, 100, 0 ):Blend( amber ):GetBlendColor(),
			DrawColor = PhotonColor( 255, 200, 0 ):Blend( amber ):GetBlendColor(),
		},
	}
}

COMPONENT.Templates = {
	["Bone"] = {
		Rotator = {}
	},
	["Mesh"] = {
		Mesh = {
			Model = "models/schmal/mx7000_lights.mdl",
			Scale = 1.001,
			IntensityGainFactor = 5,
			IntensityLossFactor = 5,
			DeactivationState = "~OFF"
		},
		Reflector = {
			Model = "models/schmal/mx7000_lights.mdl",
			Scale = 1.001,
			IntensityGainFactor = 5,
			IntensityLossFactor = 5,
			DeactivationState = "OFF"
		}
	},
	["Projected"] = {
		Projected = {
			-- FOV = 120,
			HorizontalFOV = 45,
			VerticalFOV = 45,
			NearZ = 200,
			FarZ = 800,
			Brightness = 0.25,
			DeactivationState = "~OFF",
			-- TODO:
			-- This is required to prevent the lights from starting ON then fading off..?
			Intensity = 0,
			States = {
				["~R"] = {
					Color = PhotonColor( 255, 48, 48 )
				},
				["~B"] = {
					Color = PhotonColor( 64, 96, 255 )
				},
				["~SW"] = {
					Color = PhotonColor( 255, 225, 200)
				},
				ProxyC = {
					Proxy = { Type = "FROM_LIGHT", Key = 1, Value = "AngleOutput" }
				},
				ProxyLI = {
					Proxy = { Type = "FROM_LIGHT", Key = 2, Value = "AngleOutput" }
				},
				ProxyLO = {
					Proxy = { Type = "FROM_LIGHT", Key = 3, Value = "AngleOutput" }
				},
				ProxyRI = {
					Proxy = { Type = "FROM_LIGHT", Key = 4, Value = "AngleOutput" }
				},
				ProxyRO = {
					Proxy = { Type = "FROM_LIGHT", Key = 5, Value = "AngleOutput" }
				}
			}
		},
		ForwardIllumination = {
			HorizontalFOV = 90,
			VerticalFOV = 10,
			NearZ = 10,
			FarZ = 800,
			Brightness = 0.5,
			DeactivationState = "~OFF",
			-- TODO:
			-- This is required to prevent the lights from starting ON then fading off..?
			Intensity = 0,
			States = {
				["~SW"] = {
					Inherit = "SW",
					IntensityTransitions = true,
					Intensity = 0.6

				},
				["~BRIGHT"] = {
					Color = PhotonColor( 255, 225, 200),
					IntensityTransitions = true,
					Intensity = 1
				}
			}
		}
	}
}

COMPONENT.StateMap = "[ROT] 1 2 3 4 5 [~SW] 6 11 12 13 14 15 16 17 18 19 20 33 34 47 48 54 55 56 [~R] 7 9 21 23 35 37 39 41 43 45 [~B] 8 10 22 24 36 38 40 42 44 46 [~A] 25 26 27 28 29 30 31 32 [ProxyC] 53 [ProxyLI] 51 [ProxyRI] 52 [ProxyLO] 49 [ProxyRO] 50"

local fov = 180

COMPONENT.Elements = {
	[1] = { "Rotator", BoneId = 2, Axis = "z", Speed = 700, AngleOutputMap = { { 0, "~SW" }, { 45, "OFF" }, { 135, "~SW" }, { 225, "OFF" }, { 315, "~SW" } } },
	[2] = { "Rotator", BoneId = 3, Axis = "z", Speed = 710, AngleOutputMap = { { 0, "~R" }, { 45, "OFF" }, { 135, "~R" }, { 225, "OFF" }, { 315, "~R" } } },
	[3] = { "Rotator", BoneId = 4, Axis = "z", Speed = 440, AngleOutputMap = { { 0, "~R" }, { 225, "OFF" }, { 315, "~R" } } },
	[4] = { "Rotator", BoneId = 5, Axis = "z", Speed = 690, AngleOutputMap = { { 0, "~B" }, { 45, "OFF" }, { 135, "~B" }, { 225, "OFF" }, { 315, "~B" } } },
	[5] = { "Rotator", BoneId = 6, Axis = "z", Speed = 450, AngleOutputMap = { { 0, "~B" }, { 45, "OFF" }, { 135, "~B" } } },

	[6] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/rc", BoneParent = 2, DrawMaterial = "photon/common/glow_gradient_a" },
	[7] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1l", BoneParent = 3, DrawMaterial = "photon/common/glow_gradient_a" },
	[8] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1r", BoneParent = 5, DrawMaterial = "photon/common/glow_gradient_a" },
	[9] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2l", BoneParent = 4, DrawMaterial = "photon/common/glow_gradient_a" },
	[10] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2r", BoneParent = 6, DrawMaterial = "photon/common/glow_gradient_a" },

	[11] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h1", DrawMaterial = "photon/common/glow_gradient_a" },
	[12] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h2", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[13] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h3", DrawMaterial = "photon/common/glow_gradient_a" },
	[14] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h4", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[15] = { "Mesh", Vector( 0.1, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h5", DrawMaterial = "photon/common/glow_gradient_a" },
	[16] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h6", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[17] = { "Mesh", Vector( .10, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h7", DrawMaterial = "photon/common/glow_gradient_a" },
	[18] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h8", DrawMaterial = "photon/common/glow_gradient_a" },

	[19] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l1", DrawMaterial = "photon/lights/halogen_diffuse" },
	[20] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l2", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[21] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l3", DrawMaterial = "photon/lights/halogen_diffuse" },
	[22] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l4", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[23] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l5", DrawMaterial = "photon/lights/halogen_diffuse" },
	[24] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l6", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[25] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l7", DrawMaterial = "photon/lights/halogen_diffuse" },
	[26] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l8", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[27] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l9", DrawMaterial = "photon/lights/halogen_diffuse" },
	[28] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l10", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[29] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l11", DrawMaterial = "photon/lights/halogen_diffuse" },
	[30] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l12", DrawMaterial = "photon/lights/halogen_diffuse" },
	
	[31] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l13", DrawMaterial = "photon/lights/halogen_diffuse" },
	[32] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/l14", DrawMaterial = "photon/lights/halogen_diffuse" },

	[33] = { "Reflector", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m1", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 105, fov } },
	[34] = { "Reflector", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m2", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 295, fov } },
	
	[35] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m3", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 295, fov } },
	[36] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m4", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 105, fov } },
	
	[37] = { "Reflector", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m5", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 105, fov } },
	[38] = { "Reflector", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m6", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 295, fov }  },
	
	[39] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m7", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 3, "Value" } }, Mirror2 = { 295, fov }  },
	[40] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m8", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 5, "Value" } }, Mirror2 = { 105, fov }  },
	
	[41] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m9", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 3, "Value" } }, Mirror2 = { 325, fov } },
	[42] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m10", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 5, "Value" } }, Mirror2 = { 75, fov } },
	
	[43] = { "Reflector", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m11", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 75, fov } },
	[44] = { "Reflector", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m12", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 325, fov }  },
	
	[45] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m13", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 295, fov }  },
	[46] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m14", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 75, fov } },
	
	[47] = { "Reflector", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m15", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 75, fov } },
	[48] = { "Reflector", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m16", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 325, fov } },

	-- Left Outer
	[49] = { "Projected", Vector( 0, 0, 0 ), Angle( 90, 0, 0 ), BoneParent = 4 },
	-- Right Outer
	[50] = { "Projected", Vector( 0, 0, 0 ), Angle( 90, 0, 0 ), BoneParent = 6 },

	-- Left Inner
	[51] = { "Projected", Vector( 0, 0, 0 ), Angle( 90, 0, 0 ), BoneParent = 3 },
	-- Right Inner
	[52] = { "Projected", Vector( 0, 0, 0 ), Angle( 90, 0, 0 ), BoneParent = 5 },

	-- Center
	[53] = { "Projected", Vector( 0, 0, 0 ), Angle( 90, 0, 0 ), BoneParent = 2 },

	-- Illumination Center
	[54] = { "ForwardIllumination", Vector( 0, -60, 10 ), Angle( 10, 180, 0 ) },
	-- Left Alley
	[55] = { "ForwardIllumination", Vector( 0, 0, 0 ), Angle( 10, 90, 0 ) },
	-- Right Alley
	[56] = { "ForwardIllumination", Vector( 0, 0, 0 ), Angle( 10, -90, 0 ) },
}

local BoneLightMirror = {
	Light = 1,
	Peak = 112.65,
	FOV = 90
}

COMPONENT.ElementGroups = {
	-- Center
	["RC"] = { 1, 6, 33, 34, 47, 48, 53 },
	-- Left Outer
	["RLO"] = { 3, 39, 41, 9, 49 },
	-- Left Inner
	["RLI"] = { 2, 7, 35, 37, 43, 51 },
	-- Right Outer
	["RRO"] = { 5, 40, 42, 10, 50 },
	-- Right Inner
	["RRI"] = { 4, 8, 36, 38, 44, 52 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Illumination = {
		Frames = { 
			[1] = "54", 
			[2] = "[~BRIGHT] 54" 
	},
		Sequences = { ON = { 1 }, FLOOD = { 2 } }
	},
	LeftAlley = {
		Frames = { 
			-- [0] = "[~OFF] 55", 
			[1] = "55" 
		},
		Sequences = { ON = { 1 } }
	},
	RightAlley = {
		Frames = { [0] = "[~OFF] 56", [1] = "56" },
		Sequences = { ON = { 1 } }
	},
	RotatorCenter = {
		Frames = {
			[1] = "RC"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	RotatorLeftOuter = {
		Frames = {
			[1] = "RLO"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	RotatorLeftInner = {
		Frames = {
			[1] = "RLI"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	RotatorRightOuter = {
		Frames = {
			[1] = "RRO"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	RotatorRightInner = {
		Frames = {
			[1] = "RRI"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Rotators = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Mesh = {
		Frames = {
			[1] = "6 7 8 9 10 11 12 13 14 15 16 17 18 1 2 3 4 5 6 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Takedown = {
		Frames = {
			[0] = "[~OFF] 11 12",
			[1] = "[~SW] 11",
			[2] = "[~SW] 12",
			[3] = "[~SW] 11 12",
		},
		Sequences = {
			TEST = sequence():Alternate( 1, 2, 11 ),
			ON = { 3 },
		}
	},
	LowerFront = {
		Frames = {
			[0] = "[~OFF] 21 22 23 24",
			[1] = "21 22",
			[2] = "23 24",
			[3] = "21 24",
			[4] = "22 23",
			[5] = "21 22 23 24",
		},
		Sequences = {
			INOUT = sequence():Alternate( 1, 2, 7 ),
			WARN = sequence():Alternate( 3, 4, 7 ),
			FLASH = sequence():Alternate( 5, 0, 7 ),
			ON = { 5 }
		}
	},
	MirrorTesting = {
		Frames = {
			[1] = "1 6 33 34 2 7 37 4 8 38 3 9 39 5 10 40 45 46 47 48 44 36 42 35 41 43 49 50 51",
			[2] = "1 6 33 34",
		},
		Sequences = {
			TEST = sequence():Add( 1 )
		}
	},
	ArrowStik = {
		Frames = {
			[0] = "[~OFF] 25 27 29 31 32 30 28 26",
			[1] = "25 27 29 31 32 30 28 26",
			[2] = "25 29 32 28",
			[3] = "27 31 30 26",
			[4] = "25 26 27 28",
			-- RIGHT
			[5] = "25",
			[6] = "25 27",
			[7] = "25 27 29",
			[8] = "25 27 29 31",
			[9] = "25 27 29 31 32",
			[10] = "25 27 29 31 32 30",
			[11] = "25 27 29 31 32 30 28",
			[12] = "25 27 29 31 32 30 28 26",
			-- LEFT
			[13] = "26",
			[14] = "26 28",
			[15] = "26 28 30",
			[16] = "26 28 30 32",
			[17] = "26 28 30 32 31",
			[18] = "26 28 30 32 31 29",
			[19] = "26 28 30 32 31 29 27",
			[20] = "26 28 30 32 31 29 27 25",
			-- CEN/OUT
			[21] = "31 32",
			[22] = "29 31 32 30",
			[23] = "27 29 31 32 30 28",
			[24] = "25 27 29 31 32 30 28 26",
		},
		Sequences = {
			FLASH = sequence():Alternate( 1, 0, 6 ),
			WARN = sequence():Alternate( 2, 3, 7 ),
			MARKER = { 4 },
			LEFT = sequence():Sequential( 13, 20 ):Stretch( 6 ):Hold( 12 ):Add( 0 ):Hold( 6 ),
			RIGHT = sequence():Sequential( 5, 12 ):Stretch( 6 ):Hold( 12 ):Add( 0 ):Hold( 6 ),
			CENOUT = sequence():Sequential( 21, 24 ):Stretch( 8 ):Hold( 12 ):Add( 0 ):Hold( 6 ),
		}

	},
	RearWarning = {
		Frames = {
			[0] = "[~OFF] 25 26",
			[1] = "25 26",
		},
		Sequences = {
			FLASH = sequence():Alternate( 1, 0, 6 )
		}
	},
	Alley_L = {
		Frames = {
			[0] = "[~OFF] 13 15 17",
			[1] = "[~SW] 13 15 17",
			[2] = "[~SW] 13 17",
			[3] = "[~SW] 15",
		},
		Sequences = {
			WARN = sequence():Alternate( 2, 3, 9 ),
			ON = { 1 },
		}
	},
	Alley_R = {
		Frames = {
			[0] = "[~OFF] 14 16 18",
			[1] = "[~SW] 14 16 18",
			[2] = "[~SW] 14 18",
			[3] = "[~SW] 16",
		},
		Sequences = {
			WARN = sequence():Alternate( 2, 3, 9 ),
			ON = { 1 },
		}
	},
	CenterFlashers = {
		Frames = {
			[0] = "[~OFF] 19 20",
			[1] = "19 20"
		},
		Sequences = {
			WARN = sequence():Alternate( 0, 1, 7 ),
			ON = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			ArrowStik = "WARN",
			LowerFront = "WARN",
			RotatorCenter = "ON"
		},
		["MODE2"] = {
			ArrowStik = "WARN",
			RotatorLeftOuter = "ON",
			RotatorRightOuter = "ON",
			RotatorLeftInner = "ON",
			RotatorRightInner = "ON",
			LowerFront = "WARN"
		},
		["MODE3"] = {
			Takedown = "TEST",
			LowerFront = "WARN",
			RotatorLeftOuter = "ON",
			RotatorRightOuter = "ON",
			RotatorCenter = "ON",
			RotatorLeftInner = "ON",
			RotatorRightInner = "ON",
			RearWarning = "FLASH",
			ArrowStik = "FLASH",
			Alley_L = "WARN",
			Alley_R = "WARN",
			CenterFlashers = "WARN"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			LowerFront = "ON",
			ArrowStik = "MARKER"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ON",
			Illumination = "ON",
		},
		["FLOOD"] = {
			CenterFlashers = "ON",
			Illumination = "FLOOD",
			Takedown = "ON",
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = {
			ArrowStik = "LEFT"
		},
		["RIGHT"] = {
			ArrowStik = "RIGHT"
		},
		["CENOUT"] = {
			ArrowStik = "CENOUT"
		}
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {
			Alley_L = "ON",
			RightAlley = "ON",
		}
	},
	["Emergency.SceneRight"] = {
		["ON"] = {
			Alley_R = "ON",
			LeftAlley = "ON",
		}
	},
}