if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Don Patterson, Noble",
	Code = "Noble"
}

COMPONENT.Title = [[Golight 2000GT Searchlight"]]

COMPONENT.Model = "models/noble/golight_2000.mdl"

local baseSpeed = 100
local headSpeed = 40

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/generic_square_256.png").MaterialName,
			Width = 0,
			Height = 0,
			Scale = 1.5,
		},
	},
	["Projected"] = {
		Projected = {
			NearZ = 150,
			FOV = 50
		}
	},
	["Sub"] = {
		SubMaterial = {
			States = {
				["HIDE"] = { Material = "photon/common/blank" },
			}
		}
	},
	["Bone"] = {
		Base = {
			Bone = "base",
			Axis = "z",
			States = {
				["FORWARD"] = { Activity = "Fixed", Target = 0, Speed = baseSpeed, DeactivateOnTarget = true, Direction = 1 },
				["LEFT"] = { Activity = "Fixed", Target = 270, Speed = baseSpeed, Direction = -1 },
                ["RIGHT"] = { Activity = "Fixed", Target = 90, Speed = baseSpeed, Direction = 1 }
			},
			DeactivationState = "FORWARD"
		},
		Head = {
			Bone = "head",
			Axis = "z",
			States = {
				["CENTER"] = { Activity = "Fixed", Target = 0, Speed = headSpeed, DeactivateOnTarget = true, Direction = -1 },
				["DOWN"] = { Activity = "Fixed", Target = 20, Speed = headSpeed, Direction = 1 },
			},
			DeactivationState = "CENTER"
		}
	},
    ["Mesh"] = {
		Reflector = {
			Model = "models/noble/golight_2000_mesh.mdl",
			DrawMaterial = "noble/photon/golight_2000/mesh",
			BloomMaterial = "noble/photon/golight_2000/mesh",
		}
	}
}

COMPONENT.States = {
	[1] = "W"
}

COMPONENT.StateMap = "[1] 1 4 6 [FORWARD] 2 [CENTER] 3 "

COMPONENT.Elements = {
	[1] = { "Projected", Vector( 0, 0, 0 ), Angle = Angle( 0, 0, 0 ), BoneParent = 2 },
	[2] = { "Base" },
	[3] = { "Head" },
    [4] = { "Reflector", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "noble/photon/golight_2000/mesh", BoneParent = 2 },
    [5] = { "SubMaterial", Indexes = { 5 } }, -- Hide the reflector material to prevent z-fighting
	[6] = { "Light", Vector( -3.6, 0, 0 ), Angle( 0, 0, 0 ), BoneParent = 2 },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1 4 6 [HIDE] 5",
			[2] = "1 4 6 [HIDE] 5",
		},
		Sequences = {
			["ON"] = { 1 },
			["ON_LEFT"] = { 1 },
			["ON_RIGHT"] = { 1 }
			--["DELAY"] = sequence():Add( 1 ):Do( 6 ):Add( 2 ):SetRepeating( false ) Opted to remove this for now since there's a noticable flash when toggling directions
		}
	},
	Base = {
		Frames = {
			[1] = "2",
            [2] = "[LEFT] 2",
            [3] = "[RIGHT] 2",
            [4] = "2 [DOWN] 3",
		},
		Sequences = {
			["FORWARD"] = { 1 },
			["LEFT"] = { 2 },
            ["RIGHT"] = { 3 },
            ["ILLUM"] = { 4 }
		}
	},
    Head = {
		Frames = {
			[1] = "3",
            [2] = "[DOWN] 3",
		},
		Sequences = {
			["CENTER"] = { 1 },
			["DOWN"] = { 2 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Illuminate"] = {
		["SPOT"] = {
			Light = "ON",
            Base = "FORWARD",
            Head = "CENTER"
		},
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
            Light = "ON",
			Base = "FORWARD",
            Head = "DOWN"
		},
		["FLOOD"] = {
            Light = "ON",
            Base = "FORWARD",
            Head = "CENTER"
		},
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {
            Light = "ON_LEFT",
			Base = "LEFT",
            Head = "CENTER"
		}
	},
    ["Emergency.SceneRight"] = {
		["ON"] = {
            Light = "ON_RIGHT",
			Base = "RIGHT",
            Head = "CENTER"
		}
	}
}