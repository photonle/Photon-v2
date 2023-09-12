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

COMPONENT.LightStates = {}

COMPONENT.Templates = {
	["Bone"] = {
		Rotator = {}
	},
	["Mesh"] = {
		Mesh = {
			Model = "models/schmal/mx7000_lights.mdl",
			Scale = 1.001
		}
	}
}

COMPONENT.ColorMap = "[ROT] 1 2 3 4 5 [SW] 6 11 12 13 14 15 16 17 18 [R] 7 9 [B] 8 10"

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

}

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
			[1] = "6 7 8 9 10 11 12 13 14 15 16 17 18 1 2 3 4 5 6"
		},
		Sequences = {
			ON = { 1 }
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			-- Rotators = "ON",
			Mesh = "ON"
		}
	}
}