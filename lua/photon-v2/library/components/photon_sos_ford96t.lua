if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Ford 96T Rear Spoiler Light]]
COMPONENT.Category = "Special"
COMPONENT.Model = "models/schmal/ford_96t.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width = 2.75,
			Height = 1.3525,
			Detail = PhotonMaterial.GenerateLightQuad( "photon/lights/ford96t_detail.png" ).MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad( "photon/lights/ford96t_shape.png" ).MaterialName,
			VisibilityRadius = 0.1
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "A"
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[2] = { "Light", Vector( -5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },

	[3] = { "Light", Vector( 2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[4] = { "Light", Vector( -2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[5] = { "Light", Vector( -0, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[6] = { "Light", Vector( -0, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[7] = { "Light", Vector( -2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[8] = { "Light", Vector( 2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[9] = { "Light", Vector( -5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[10] = { "Light", Vector( 5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
}

COMPONENT.StateMap = "[1/2] 1 3 5 7 9 [2/1] 2 4 6 8 10"

COMPONENT.SubMaterials = {
	-- [1] = "photon/common/blank"
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10",
			[2] = "1 3 5 7 9",
			[3] = "2 4 6 8 10"
		},
		Sequences = {
			["ON"] = { 1 },
			["BLINK"] = { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
			["ALT_SLOW"] = sequence():Alternate( 2, 3, 7 ),
			["QUAD_SOLO"] = sequence():FlashHold( { 2, 3 }, 4, 3 )
		}
	},
	["Traffic"] = {
		Frames = {
			-- Left fill
			[1] = "[A] 10",
			[2] = "[A] 10 8",
			[3] = "[A] 10 8 6",
			[4] = "[A] 10 8 6 4",
			[5] = "[A] 10 8 6 4 2",
			[6] = "[A] 10 8 6 4 2 1",
			[7] = "[A] 10 8 6 4 2 1 3",
			[8] = "[A] 10 8 6 4 2 1 3 5",
			[9] = "[A] 10 8 6 4 2 1 3 5 7",
			[10] = "[A] 10 8 6 4 2 1 3 5 7 9",
			-- Right fill
			[11] = "[A] 9",
			[12] = "[A] 9 7",
			[13] = "[A] 9 7 5",
			[14] = "[A] 9 7 5 3",
			[15] = "[A] 9 7 5 3 1",
			[16] = "[A] 9 7 5 3 1 2",
			[17] = "[A] 9 7 5 3 1 2 4",
			[18] = "[A] 9 7 5 3 1 2 4 6",
			[19] = "[A] 9 7 5 3 1 2 4 6 8",
			[20] = "[A] 9 7 5 3 1 2 4 6 8 10",
			-- Center out fill
			[21] = "[A] 1 2",
			[22] = "[A] 1 2 3 4",
			[23] = "[A] 1 2 3 4 5 6",
			[24] = "[A] 1 2 3 4 5 6 7 8",
			[25] = "[A] 1 2 3 4 5 6 7 8 9 10",
			-- Left move out
			[26] = "[A] 10 8 6 4 2 1 3 5 7",
			[27] = "[A] 10 8 6 4 2 1 3 5",
			[28] = "[A] 10 8 6 4 2 1 3",
			[29] = "[A] 10 8 6 4 2 1",
			[30] = "[A] 10 8 6 4 2",
			[31] = "[A] 10 8 6 4",
			[32] = "[A] 10 8 6",
			[33] = "[A] 10 8",
			[34] = "[A] 10",
			-- Right move out
			[35] = "[A] 9 7 5 3 1 2 4 6 8",
			[36] = "[A] 9 7 5 3 1 2 4 6",
			[37] = "[A] 9 7 5 3 1 2 4",
			[38] = "[A] 9 7 5 3 1 2",
			[39] = "[A] 9 7 5 3 1",
			[40] = "[A] 9 7 5 3",
			[41] = "[A] 9 7 5",
			[42] = "[A] 9 7",
			[43] = "[A] 9",
			-- Center move out
			[44] = "[A] 3 4 5 6 7 8 9 10",
			[45] = "[A] 5 6 7 8 9 10",
			[46] = "[A] 7 8 9 10",
			[47] = "[A] 9 10",
			-- Two-Module Directional
			[48] = "[A] 10",
			[49] = "[A] 10 8",
			[50] = "[A] 8 6",
			[51] = "[A] 6 4",
			[52] = "[A] 4 2",
			[53] = "[A] 2 1",
			[54] = "[A] 1 3",
			[55] = "[A] 3 5",
			[56] = "[A] 5 7",
			[57] = "[A] 7 9",
			[58] = "[A] 9",
			-- Center two-module
			[59] = "[A] 1 2",
			[60] = "[A] 1 2 3 4",
			[61] = "[A] 3 4 5 6",
			[62] = "[A] 5 6 7 8",
			[63] = "[A] 7 8 9 10",
			[64] = "[A] 9 10",
		},
		Sequences = {
			["LEFT_FILL"] = sequence():Sequential( 1, 10 ):Stretch( 2 ):Hold( 6 ):Off( 6 ),
			["RIGHT_FILL"] = sequence():Sequential( 11, 20 ):Stretch( 2 ):Hold( 6 ):Off( 6 ),
			["CENTER_FILL"] = sequence():Sequential( 21, 25 ):Stretch( 3 ):Hold( 6 ):Off( 6 ),

			["LEFT_SWEEP"] = sequence():Sequential( 1, 10 ):Sequential( 35, 43 ):StretchAll( 2 ):Off( 6 ),
			["RIGHT_SWEEP"] = sequence():Sequential( 11, 20 ):Sequential( 26, 34 ):StretchAll( 2 ):Off( 6 ),
			["CENTER_SWEEP"] = sequence():Sequential( 21, 25 ):Sequential( 44, 47 ):StretchAll( 3 ):Off( 6 ),
			
			["LEFT_SINGLE"] = sequence():Sequential( 48, 58 ):Stretch( 2 ):Alternate( 58, 0, 4 ):Do( 3 ),
			["RIGHT_SINGLE"] = sequence():Sequential( 58, 48 ):Stretch( 2 ):Alternate( 48, 0, 4 ):Do( 3 ),
			["CENOUT_SINGLE"] = sequence():Sequential( 59, 64 ):Stretch( 3 ):Alternate( 64, 0, 4 ):Do( 3 ),
			

			["BLINK"] = { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
		}
	
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ALT_SLOW"
		},
		["MODE2"] = {
			All = "QUAD_SOLO"
		},
		["MODE3"] = {
			All = "QUAD_SOLO"
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = {
			Traffic = "LEFT_SINGLE"
		},
		["RIGHT"] = {
			Traffic = "RIGHT_SINGLE"
		},
		["CENOUT"] = {
			Traffic = "CENOUT_SINGLE"
		}
	}
}