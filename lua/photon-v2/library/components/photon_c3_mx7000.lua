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
	}
}

COMPONENT.ColorMap = ""

COMPONENT.Lights = {
	[1] = { "Rotator", BoneId = 2, Axis = "z" },
	[2] = { "Rotator", BoneId = 3, Axis = "z" },
	[3] = { "Rotator", BoneId = 4, Axis = "z" },
	[4] = { "Rotator", BoneId = 5, Axis = "z" },
	[5] = { "Rotator", BoneId = 6, Axis = "z" },
}

COMPONENT.Segments = {
	Rotators = {
		Frames = {
			[1] = "1:ROT 2:ROT 3:ROT 4:ROT 5:ROT"
		},
		Sequences = {
			ON = { 1 }
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Rotators = "ON"
		}
	}
}