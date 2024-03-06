if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Noble",
	Code = "Noble"
}

COMPONENT.Title = [[Federal Signal MB1]]
COMPONENT.Category = "Matrix"
COMPONENT.Model = "models/noble/fedsig_mb1.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -3),
	Angles = Angle( 0, -90, 0 ),
	Zoom = 1.4
}

COMPONENT.Templates = {
	["2D"] = {
		POLICE_ANIM = {
			Shape = "photon/textures/mb1_police_anim_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		POLICE = {
			Shape = "photon/textures/mb1_police_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		KEEP = {
			Shape = "photon/textures/mb1_keep_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		BACK = {
			Shape = "photon/textures/mb1_back_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		ARROW = {
			Shape = "photon/textures/mb1_arrow_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		ARROW_R = {
			Shape = "photon/textures/mb1_arrow_2d",
			Width = -35.9,
			Height = 9,
			Scale = 0,
		},
		SPLIT = {
			Shape = "photon/textures/mb1_split_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		TRAFFIC = {
			Shape = "photon/textures/mb1_traffic_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		NYPD = {
			Shape = "photon/textures/mb1_nypd_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
		NYPD_ANIM = {
			Shape = "photon/textures/mb1_nypd_anim_2d",
			Width = 35.9,
			Height = 9,
			Scale = 0,
		},
	},
	["Sub"] = {
		SubMaterial = {}
	},
	["Mesh"] = {
		LEDs = {
			Model = "models/noble/fedsig_mb1_mesh.mdl",
			States = {
				["POLICE_ANIM"] = {
					DrawMaterial = "photon/textures/mb1_police_anim",
					BloomMaterial = "photon/textures/mb1_police_anim",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["POLICE"] = {
					DrawMaterial = "photon/textures/mb1_police",
					BloomMaterial = "photon/textures/mb1_police",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["KEEP"] = {
					DrawMaterial = "photon/textures/mb1_keep",
					BloomMaterial = "photon/textures/mb1_keep",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["BACK"] = {
					DrawMaterial = "photon/textures/mb1_back",
					BloomMaterial = "photon/textures/mb1_back",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["ARROW"] = {
					DrawMaterial = "photon/textures/mb1_arrow",
					BloomMaterial = "photon/textures/mb1_arrow",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["ARROW_R"] = {
					DrawMaterial = "photon/textures/mb1_arrow_r",
					BloomMaterial = "photon/textures/mb1_arrow_r",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["SPLIT"] = {
					DrawMaterial = "photon/textures/mb1_split",
					BloomMaterial = "photon/textures/mb1_split",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["TRAFFIC"] = {
					DrawMaterial = "photon/textures/mb1_traffic",
					BloomMaterial = "photon/textures/mb1_traffic",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["NYPD"] = {
					DrawMaterial = "photon/textures/mb1_nypd",
					BloomMaterial = "photon/textures/mb1_nypd",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				},
				["NYPD_ANIM"] = {
					DrawMaterial = "photon/textures/mb1_nypd_anim",
					BloomMaterial = "photon/textures/mb1_nypd_anim",
					DrawColor = PhotonColor( 0, 255, 255 ),
					BloomColor = PhotonColor( 0, 0, 255 ),
				}
			}
		}
	}
}

COMPONENT.ElementStates = {
	
}

COMPONENT.Elements = {
	[1] = { "LEDs", Vector( 0, -.05, 0 ), Angle( 0, 0, 0 ), "noble/photon/fedsig_mb1/mesh" },

	[2] = { "POLICE_ANIM", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[3] = { "POLICE", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[4] = { "KEEP", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[5] = { "BACK", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },

	[6] = { "ARROW", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[7] = { "ARROW_R", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[8] = { "SPLIT", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[9] = { "TRAFFIC", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },

	[10] = { "NYPD", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) },
	[11] = { "NYPD_ANIM", Vector( 0, -.5, 1.97 ), Angle( 0, 180, 0 ) }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	LEDs = {
		Frames = {
			[1] = "[POLICE_ANIM] 1 2:B",
			[2] = "[POLICE] 1 3:B",
			[3] = "[KEEP] 1 4:B",
			[4] = "[BACK] 1 5:B",
			[5] = "[ARROW] 1 6:B",
			[6] = "[ARROW_R] 1 7:B",
			[7] = "[SPLIT] 1 8:B",
			[8] = "[TRAFFIC] 1 9:B",
			[9] = "[NYPD] 1 10:B",
			[10] = "[NYPD_ANIM] 1 11:B"
		},
		Sequences = {
			["ANIM"] = { 1 },
			["ANIM:NYPD"] = { 9 },
			["ANIM_3"] = { 1 },
			["ANIM_3:NYPD"] = { 9 },
			["FLASH"] = sequence():Add(2):Do(24):Add(0):Do(4):Add(3):Do(24):Add(0):Do(4):Add(4):Do(24):Add(0):Do(4),
			["FLASH:NYPD"] = { 9 },
			["MARKER"] = { 2 },
			["MARKER:NYPD"] = { 10 },
			["ARROW_LEFT"] = { 5 },
			["ARROW_RIGHT"] = { 6 },
			["SPLIT_TRAFFIC"] = sequence():Add(7):Do(14):Add(8):Do(14):Add(0):Do(20),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { LEDs = "FLASH" },
		["MODE2"] = { LEDs = "ANIM" },
		["MODE3"] = { LEDs = "ANIM_3" }
	},
	["Emergency.Directional"] = {
		["LEFT"] = { LEDs = "ARROW_LEFT" },
		["RIGHT"] = { LEDs = "ARROW_RIGHT" },
		["CENOUT"] = { LEDs = "SPLIT_TRAFFIC" },
	},
	["Emergency.Marker"] = {
		["ON"] = { LEDs = "MARKER" }
	},
}