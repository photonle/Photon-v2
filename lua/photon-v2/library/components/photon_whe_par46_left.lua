if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.Title = [[Whelen PAR46 LED Spotlight (Left)]]
COMPONENT.Category = "Spotlight"
COMPONENT.Model = "models/sentry/props/spotlightpar46_left_up.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 1
}

local downSpeed = 100
local upSpeed = 400

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_par46_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_par46_detail.png").MaterialName,
			Width = 7.6,
			Height = 7.6,
			Scale = 2
		}
	},
	["Projected"] = {
		Projected = {
			NearZ = 200,
			FOV = 30
		}
	},
	["Bone"] = {
		Shaft = {
			Bone = "shaft",
			Axis = "p",
			States = {
				["DOWN"] = { Activity = "Fixed", Target = 280, Speed = downSpeed, DeactivateOnTarget = true, Direction = -1 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = upSpeed, Direction = 1 }
			},
			DeactivationState = "DOWN"
		},
		Lamp = {
			Bone = "lamp",
			Axis = "y",
			States = {
				["DOWN"] = { Activity = "Fixed", Target = 90, Speed = downSpeed * 2, DeactivateOnTarget = true, Direction = 0 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = upSpeed, Direction = 0 },
				["LEFT"] = { Activity = "Fixed", Target = 271, Speed = upSpeed, Direction = 0 },
				["RIGHT"] = { Activity = "Fixed", Target = 89, Speed = 300, Direction = 0 },
			},
			DeactivationState = "DOWN"
		},
		-- The handle does indeed rotate even though it's impossible to notice.
		Handle = {
			Bone = "grip",
			Axis = "p",
			States = {
				["DOWN"] = { Activity = "Fixed", Target = 90, Speed = downSpeed, DeactivateOnTarget = true, Direction = 0 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = upSpeed, Direction = 0 },
				["LEFT"] = { Activity = "Fixed", Target = 271, Speed = upSpeed, Direction = 0 },
				["RIGHT"] = { Activity = "Fixed", Target = 89, Speed = upSpeed * 0.75, Direction = 0 },
			},
			DeactivationState = "DOWN"
		}
	}
}

COMPONENT.States = {
	[1] = "W"
}

COMPONENT.StateMap = "[1] 1 2 [UP] 3 4 5"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[2] = { "Projected", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[3] = { "Shaft" },
	[4] = { "Lamp" },
	[5] = { "Handle" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1",
			[2] = "1 2",
		},
		Sequences = {
			["ON"] = { 1 },
			["DELAY"] = sequence():Add( 1 ):Do( 6 ):Add( 2 ):SetRepeating( false ),
		}
	},
	Lamp = {
		Frames = {
			[1] = "3 4 5",
			[2] = "[UP] 3 [LEFT] 4",
			[3] = "[UP] 3 [RIGHT] 4",
		},
		Sequences = {
			["UP"] = { 1 },
			["LEFT"] = { 2 },
			["RIGHT"] = { 3 },
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Illuminate"] = {
		["SPOT"] = {
			Light = "DELAY",
			Lamp = "UP"
		},
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Light = "DELAY",
			Lamp = "UP"
		},
		["FLOOD"] = {
			Light = "DELAY",
			Lamp = "UP"
		},
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {
			Light = "DELAY",
			Lamp = "LEFT"
		}
	}
}