if (Photon2.ReloadComponentFile()) then return end
---@class PhotonHUD : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Code = "Schmal",
}

COMPONENT.Title = [[Photon 2 HUD]]

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["Virtual"] = {
		["Default"] = {}
	}
}

COMPONENT.Elements = {
	[1] = { "Default" },
	[2] = { "Default" },
	[3] = { "Default" },
	[4] = { "Default" },
	[5] = { "Default" },
	[6] = { "Default" },
	[7] = { "Default" },
	[8] = { "Default" }
}

COMPONENT.ElementStates = {

}

COMPONENT.StateMap = "[ON] 1 2 3 4 5 6 7 8"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Default = {
		Frames = {
			[1] = "4 5 3 6 2 7 1 8",
			[2] = "2 7 1 8",
			[3] = "4 5 3 6",
			[4] = "4 3 2 1",
			[5] = "5 6 7 8",
			[6] = "2 1",
			[7] = "7 8",
			[8] = "1",
			[9] = "8",
			-- L
			[10] = "8",
			[11] = "8 7",
			[12] = "8 7 6",
			[13] = "8 7 6 5",
			[14] = "8 7 6 5 4",
			[15] = "8 7 6 5 4 3 ",
			[16] = "8 7 6 5 4 3 2",
			[17] = "8 7 6 5 4 3 2 1",
			-- R
			[18] = "1",
			[19] = "1 2",
			[20] = "1 2 3",
			[21] = "1 2 3 4",
			[22] = "1 2 3 4 5",
			[23] = "1 2 3 4 5 6",
			[24] = "1 2 3 4 5 6 7",
			[25] = "1 2 3 4 5 6 7 8",
			-- CO
			[26] = "4 5",
			[27] = "3 4 5 6",
			[28] = "2 3 4 5 6 7",
			[29] = "1 2 3 4 5 6 7 8",
		},
		Sequences = {
			ALL = { 1 },
			WARN1 = sequence():Alternate( 8, 9, 8 ),
			WARN2 = sequence():Alternate( 6, 7, 8 ),
			WARN3 = sequence():Alternate( 4, 5, 8 ),
			WARN4 = sequence():Alternate( 2, 3, 8 ),
			LEFT = sequence():Sequential( 10, 17 ):Stretch( 4 ):Hold( 8 ):Add( 0 ):Hold( 4 ),
			RIGHT = sequence():Sequential( 18, 25 ):Stretch( 4 ):Hold( 8 ):Add( 0 ):Hold( 4 ),
			CENOUT = sequence():Sequential( 26, 29 ):Stretch( 8 ):Hold( 8 ):Add( 0 ):Hold( 4 )
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Default = "WARN1" },
		["MODE2"] = { Default = "WARN2" },
		["MODE3"] = { Default = "WARN4" },
	},
	["Emergency.Directional"] = {
		["LEFT"] = { Default = "LEFT" },
		["RIGHT"] = { Default = "RIGHT" },
		["CENOUT"] = { Default = "CENOUT" },
	},
}