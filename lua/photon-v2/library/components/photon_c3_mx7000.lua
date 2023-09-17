if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[Code 3 MX7000]]

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

COMPONENT.LightStates = {
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
			BloomColor = PhotonColor( 0, 190, 255 ):Blend( blue ):GetBlendColor(),
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
			IntensityLossFactor = 5
		}
	}
}

COMPONENT.ColorMap = "[ROT] 1 2 3 4 5 [~SW] 6 11 12 13 14 15 16 17 18 19 20 33 34 47 48 [~R] 7 9 21 23 35 37 39 41 43 45 [~B] 8 10 22 24 36 38 40 42 44 46 [~A] 25 26 27 28 29 30 31 32"

local fov = 180

COMPONENT.Lights = {
	[1] = { "Rotator", BoneId = 2, Axis = "z", Speed = 700 },
	[2] = { "Rotator", BoneId = 3, Axis = "z", Speed = 710 },
	[3] = { "Rotator", BoneId = 4, Axis = "z", Speed = 440 },
	[4] = { "Rotator", BoneId = 5, Axis = "z", Speed = 690 },
	[5] = { "Rotator", BoneId = 6, Axis = "z", Speed = 450 },

	[6] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/rc", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 2 },
	[7] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1l", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 3 },
	[8] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1r", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 5 },
	[9] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2l", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 4 },
	[10] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2r", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 6 },

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

	[33] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m1", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 105, fov } },
	[34] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m2", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 295, fov } },
	
	[35] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m3", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 295, fov } },
	[36] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m4", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 105, fov } },
	
	[37] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m5", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 105, fov } },
	[38] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m6", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 295, fov }  },
	
	[39] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m7", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 3, "Value" } }, Mirror2 = { 295, fov }  },
	[40] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m8", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 5, "Value" } }, Mirror2 = { 105, fov }  },
	
	[41] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m9", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 3, "Value" } }, Mirror2 = { 325, fov } },
	[42] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m10", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 5, "Value" } }, Mirror2 = { 75, fov } },
	
	[43] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m11", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 75, fov } },
	[44] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m12", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 325, fov }  },
	
	[45] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m13", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 2, "Value" } }, Mirror2 = { 295, fov }  },
	[46] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m14", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 4, "Value" } }, Mirror2 = { 75, fov } },
	
	[47] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m15", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 75, fov } },
	[48] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m16", DrawMaterial = "photon/common/glow_gradient_a", Proxies = { R = { 1, "Value" } }, Mirror2 = { 325, fov } },

}

local BoneLightMirror = {
	Light = 1,
	Peak = 112.65,
	FOV = 90
}

COMPONENT.LightGroups = {
	["RC"] = { 1, 6, 33, 34, 47, 48 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
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
			TEST = sequence():Alternate( 1, 2, 8 )
		}
	},
	LowerFront = {
		Frames = {
			[0] = "[~OFF] 21 22 23 24",
			[1] = "21 22",
			[2] = "23 24",
		},
		Sequences = {
			INOUT = sequence():Alternate( 1, 2, 7 )
		}
	},
	MirrorTesting = {
		Frames = {
			[1] = "1 6 33 34 2 7 37 4 8 38 3 9 39 5 10 40 45 46 47 48 44 36 42 35 41 43",
			[2] = "1 6 33 34",
		},
		Sequences = {
			TEST = sequence():Add( 1 )
		}
	},
	ArrowStik = {
		Frames = {
			[0] = "[~OFF] 27 28 29 30 31 32",
			[1] = "27 28 29 30 31 32"
		},
		Sequences = {
			FLASH = sequence():Alternate( 1, 0, 6 )
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
			WARN = sequence():Alternate( 2, 3, 9 )
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
			WARN = sequence():Alternate( 2, 3, 9 )
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

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Takedown = "TEST",
			LowerFront = "INOUT",
			-- Rotators = "ON",
			-- Rotators = "ON",
			-- Mesh = "ON"
			MirrorTesting = "TEST",
			RearWarning = "FLASH",
			ArrowStik = "FLASH",
			Alley_L = "WARN",
			Alley_R = "WARN",
			CenterFlashers = "WARN"
		}
	}
}