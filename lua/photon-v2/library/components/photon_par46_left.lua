if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[PAR46 Spotlight (Left)]]

COMPONENT.Model = "models/sentry/props/spotlight_left_up.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Width = 7.6,
			Height = 7.6,
			Scale = 2
		}
	},
	["Projected"] = {
		Projected = {

		}
	},
	["Bone"] = {
		LightHead = {}
	}
}

COMPONENT.StateMap = "[SW] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[2] = { "Projected", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[3] = { "LightHead", BoneId = 4, Axis = 'y' },
	[4] = { "LightHead", BoneId = 1, Axis = 'p' }
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Rotating = {
		Frames = {
			[1] = "3:ROT 4:ROT"
		},
		Sequences = {
			["ROTATE"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Illuminate"] = {
		["SPOT"] = {
			Light = "ON",
		},	
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Light = "ON",
		},
		["FLOOD"] = {
			Light = "ON",
		},
	}
}