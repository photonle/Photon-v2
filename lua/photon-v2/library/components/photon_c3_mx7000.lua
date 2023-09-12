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
	-- [2] = "photon/textures/mx7000",
	-- [0] = nil,
	-- [2] = nil
}

COMPONENT.LightStates = {
	["Mesh"] = {
		["~SW"] = {
			Inherit = "SW",
			IntensityTransitions = true,
		}
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
			IntensityGainFactor = 200,
			IntensityLossFactor = 1
		}
	}
}

COMPONENT.ColorMap = "[ROT] 1 2 3 4 5 [SW] 6 11 12 13 14 15 16 17 18 19 20 33 34 47 48 [R] 7 9 21 23 35 37 39 41 43 45 [B] 8 10 22 24 36 38 40 42 44 46 [A] 25 26 27 28 29 30 31 32"

COMPONENT.Lights = {
	[1] = { "Rotator", BoneId = 2, Axis = "z", Speed = 400 },
	[2] = { "Rotator", BoneId = 3, Axis = "z", Speed = 425 },
	[3] = { "Rotator", BoneId = 4, Axis = "z", Speed = 475 },
	[4] = { "Rotator", BoneId = 5, Axis = "z", Speed = 450 },
	[5] = { "Rotator", BoneId = 6, Axis = "z", Speed = 500 },

	[6] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/rc", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 2 },
	[7] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1l", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 3 },
	[8] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r1r", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 5 },
	[9] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2l", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 4 },
	[10] = { "Mesh", Vector( 0.3, 0, 0.1 ), Angle( 0, 90, 90 ), "photon/generic/r2r", DrawMaterial = "photon/common/glow_gradient_a", BoneParent = 6 },

	[11] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h1", DrawMaterial = "photon/common/glow_gradient_a" },
	[12] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/h2", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[13] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h3", DrawMaterial = "photon/common/glow_gradient_a" },
	[14] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h4", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[15] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h5", DrawMaterial = "photon/common/glow_gradient_a" },
	[16] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h6", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[17] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h7", DrawMaterial = "photon/common/glow_gradient_a" },
	[18] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/h8", DrawMaterial = "photon/common/glow_gradient_a" },

	[19] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l1", DrawMaterial = "photon/common/glow_gradient_a" },
	[20] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l2", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[21] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l3", DrawMaterial = "photon/common/glow_gradient_a" },
	[22] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l4", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[23] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l5", DrawMaterial = "photon/common/glow_gradient_a" },
	[24] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l6", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[25] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l7", DrawMaterial = "photon/common/glow_gradient_a" },
	[26] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l8", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[27] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l9", DrawMaterial = "photon/common/glow_gradient_a" },
	[28] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l10", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[29] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l11", DrawMaterial = "photon/common/glow_gradient_a" },
	[30] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l12", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[31] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l13", DrawMaterial = "photon/common/glow_gradient_a" },
	[32] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/l14", DrawMaterial = "photon/common/glow_gradient_a" },

	[33] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m1", DrawMaterial = "photon/common/glow_gradient_a" },
	[34] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m2", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[35] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m3", DrawMaterial = "photon/common/glow_gradient_a" },
	[36] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m4", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[37] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m5", DrawMaterial = "photon/common/glow_gradient_a" },
	[38] = { "Mesh", Vector( 0, -0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m6", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[39] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m7", DrawMaterial = "photon/common/glow_gradient_a" },
	[40] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m8", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[41] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m9", DrawMaterial = "photon/common/glow_gradient_a" },
	[42] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m10", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[43] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m11", DrawMaterial = "photon/common/glow_gradient_a" },
	[44] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m12", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[45] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m13", DrawMaterial = "photon/common/glow_gradient_a" },
	[46] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/generic/m14", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[47] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m15", DrawMaterial = "photon/common/glow_gradient_a" },
	[48] = { "Mesh", Vector( 0, 0.1, 0 ), Angle( 0, 0, 0 ), "photon/generic/m16", DrawMaterial = "photon/common/glow_gradient_a" },

}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Rotators = {
		Frames = {
			[1] = ""
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
	Test = {
		Frames = {
			[0] = "[~OFF] 11 12",
			[1] = "[~SW] 11 12"
		},
		Sequences = {
			TEST = sequence():Alternate( 1, 0, 12 )
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Test = "TEST"
			-- Rotators = "ON",
			-- Mesh = "ON"
		}
	}
}