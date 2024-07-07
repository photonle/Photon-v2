if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.PrintName = [[SoundOff Signal nERGY]]

COMPONENT.Model = "models/sentry/props/sosnergy.mdl"

COMPONENT.ElementStates = {
	["Mesh"] = {
		["G"] = {
			Inherit = "G",
			Intensity = 0.75,
		}
	}
}

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Width = 0.22,
			Height = 0.22,
			Ratio = 1,
			Scale = 0.02,
		}
	},
	["Mesh"] = {
		Mesh = {
			Model = "models/sentry/props/sosnergy_mesh.mdl"
		},
	},
	["Bone"] = {
		Lever = {
			Bone = "lever",
			Axis = "y",
			States = {
				["OFF"] = { Activity = "Fixed", Target = 0, Speed = 200, DeactivateOnTarget = true, Direction = 0 },
				["M1"] = { Activity = "Fixed", Target = 13.33, Speed = 200, Direction = 0 },
				["M2"] = { Activity = "Fixed", Target = 26.66, Speed = 200, Direction = 0 },
				["M3"] = { Activity = "Fixed", Target = 40, Speed = 200, Direction = 0 }
			},
			DeactivationState = "OFF"
		},
	},
}

COMPONENT.StateMap = "[R] 1 2 3 4 8 9 10 11 12 13 14 15 16 [G] 5 6 17 [A] 7 18 19 20 21 22 [M1] 23"

COMPONENT.Elements = {
	--stby
	[1] = { "Light", Vector(-1.66, -3.05, 0.095), Angle(-90, 0, 0) },
	--yelp
	[2] = { "Light", Vector(-1.66, -1.895, 0.095), Angle(-90, 0, 0) },
	--wail
	[3] = { "Light", Vector(-0.51, -3.05, 0.095), Angle(-90, 0, 0) },
	--tone
	[4] = { "Light", Vector(-0.51, -1.895, 0.095), Angle(-90, 0, 0) },
	--speaker
	[5] = { "Light", Vector(-1.635, -0.88, 0.095), Angle(-90, 0, 0) },
	--m1
	[6] = { "Light", Vector(0.84, -2.93, 0.095), Angle(-90, 0, 0) },
	--m2
	[7] = { "Light", Vector(0.84, -2.345, 0.095), Angle(-90, 0, 0) },
	--m3
	[8] = { "Light", Vector(0.84, -1.73, 0.095), Angle(-90, 0, 0)},
	--diverge
	[9] = { "Light", Vector(-1.13, 0.094, 0.095), Angle(-90, 0, 0) },
	--tkdn
	[10] = { "Light", Vector(-1.13, 1.127, 0.095), Angle(-90, 0, 0) },
	--left
	[11] = { "Light", Vector(-1.13, 2.162, 0.095), Angle(-90, 0, 0) },
	--right
	[12] = { "Light", Vector(-1.13, 3.195, 0.095), Angle(-90, 0, 0) },
	--???
	[13] = { "Light", Vector(-0.23, 0.094, 0.095), Angle(-90, 0, 0) },
	--cruise
	[14] = { "Light", Vector(-0.23, 1.127, 0.095), Angle(-90, 0, 0) },
	--dim
	[15] = { "Light", Vector(-0.23, 2.162, 0.095), Angle(-90, 0, 0) },
	--gun
	[16] = { "Light", Vector(-0.23, 3.195, 0.095), Angle(-90, 0, 0) },
	--mesh
	[17] = { "Mesh", Vector( 0.0, 0.0, 0.0 ), Angle( 0, 90, 0 ), "sentry/props/sosnergy/mesh", DrawMaterial = "sentry/props/sosnergy/mesh_on", BloomMaterial = "sentry/props/sosnergy/mesh_on" },
	--traffic
	[18] = { "Light", Vector(-1.575, 0.66, 0.095), Angle(-90, 0, 0) },
	[19] = { "Light", Vector(-1.575, 1.143, 0.095), Angle(-90, 0, 0) },
	[20] = { "Light", Vector(-1.575, 1.626, 0.095), Angle(-90, 0, 0) },
	[21] = { "Light", Vector(-1.575, 2.115, 0.095), Angle(-90, 0, 0) },
	[22] = { "Light", Vector(-1.575, 2.595, 0.095), Angle(-90, 0, 0) },
	--lever
	[23] = { "Lever" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "15 16",
		},
		Sequences = {
			["ON"] = {
				1,
			}
		}
	},
	Traffic = {
		Frames = {
			[1] = "18",
			[2] = "18 19",
			[3] = "18 19 20",
			[4] = "18 19 20 21",
			[5] = "18 19 20 21 22",
			[6] = "19 20 21 22",
			[7] = "20 21 22",
			[8] = "21 22",
			[9] = "22",
			[10] = "20",
			[11] = "19 20 21",
			[12] = "18 19 20 21 22",
			[13] = "18 19 21 22",
			[14] = "18 22",
		},
		Sequences = {
			["DIVERGE"] = sequence():Sequential(10,14):Add(0,0):StretchAll(4),
			["LEFT"] = sequence():Sequential(9,1):Add(0,0):StretchAll(4),
			["RIGHT"] = sequence():Sequential(1,9):Add(0,0):StretchAll(4),
		}
	},
	Traffic_indicator = {
		Frames = {
			[1] = "9",
			[2] = "11",
			[3] = "12",
		},
		Sequences = {
			["DIVERGE"] = { 1 },
			["LEFT"] = { 2 },
			["RIGHT"] = { 3 },
		}
	},
	Takedown = {
		Frames = {
			[1] = "10",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Cruise = {
		Frames = {
			[1] = "14",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Speaker = {
		Frames = {
			[1] = "5",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Wail = {
		Frames = {
			[1] = "3",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Yelp = {
		Frames = {
			[1] = "2",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Tone = {
		Frames = {
			[1] = "4",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
	Standby = {
		Frames = {
			[1] = "1",
		},
		Sequences = {
			["OFF"] = { 0 },
			["ON"] = { 1 },
		}
	},
	Backlight = {
		Frames = {
			[1] = "17",
			[2] = "[G*0.3] 17",
		},
		Sequences = {
			["ON"] = { 1 },
			["DIM"] = { 2 },
		}
	},
	Mode = {
		Frames = {
			[1] = "6 23:M1",
			[2] = "6 7 23:M2",
			[3] = "6 7 8 23:M3",
		},
		Sequences = {
			["MODE1"] = { 1 },
			["MODE2"] = { 2 },
			["MODE3"] = { 3 },
		}
	},
}
COMPONENT.InputPriorities = {
	["Emergency.Siren"] = 102,
	["Emergency.SirenOverride"] = 101,
}
COMPONENT.Inputs = {
	["Vehicle.Engine"] = {
		["ON"] = {
			Standby = "ON",
			Backlight = "ON",
			Light = "ON",
		},
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			Mode = "MODE1",
			Standby = "ON",
			Backlight = "ON",
			Light = "ON",
		},
		["MODE2"] = {
			Mode = "MODE2",
			Standby = "ON",
			Backlight = "ON",
			Light = "ON",
		},
		["MODE3"] = {
			Mode = "MODE3",
			Standby = "ON",
			Backlight = "ON",
			Light = "ON",
		}
	},
	["Emergency.Siren"] = {
		["T1"] = {
			Wail = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T2"] = {
			Yelp = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T3"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T4"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T5"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T6"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T7"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
		["T8"] = {
			Tone = "ON",
			Speaker = "ON",
			Backlight = "DIM",
			Standby = "OFF",
		},
	},
	["Emergency.SirenOverride"] = {
		["AIR"] = { 
			Backlight = "DIM",
		},
		["MAN"] = { 
			Backlight = "DIM",
		},
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ON",
		},
		["FLOOD"] = {
			Takedown = "ON",
		},
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Cruise = "ON",
		},
	},
	["Emergency.Directional"] = {
		["LEFT"] = {
			Traffic = "LEFT",
			Traffic_indicator = "LEFT",
		},
		["RIGHT"] = {
			Traffic = "RIGHT",
			Traffic_indicator = "RIGHT",
		},
		["CENOUT"] = {
			Traffic = "DIVERGE",
			Traffic_indicator = "DIVERGE",
		}
	},
}