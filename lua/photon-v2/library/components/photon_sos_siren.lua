if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibrarySirenComponent]]

COMPONENT.Class = "Siren"

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "TDM",
	Code = "Schmal",
}

COMPONENT.Siren = "fedsig_touchmaster_delta"

COMPONENT.Category = "Siren"

COMPONENT.PrintName = "Photon Siren Prototype"

COMPONENT.Model = "models/tdmcars/emergency/equipment/dynamax_siren.mdl"

COMPONENT.Templates = {
	["Sound"] = { 
		Tone = {
			DSP = 118,
			Pitch = 100,
			Volume = 0.9
		},
		Secondary = {
			Pitch = 100,
			Volume = 0.9,
			DSP = 118,
		}
	}
}

COMPONENT.StateMap = "[ON] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19"

COMPONENT.Elements = {
	[1] = { "Tone", Tone = "T1" },
	[2] = { "Tone", Tone = "T2" },
	[3] = { "Tone", Tone = "T3" },
	[4] = { "Tone", Tone = "T4" },
	[5] = { "Tone", Tone = "T5" },
	[6] = { "Tone", Tone = "T6" },
	[7] = { "Tone", Tone = "T7" },
	[8] = { "Tone", Tone = "T8" },
	[9] = { "Tone", Tone = "AIR" },
	[10] = { "Tone", Tone = "MAN" },
	[11] = { "Secondary", Tone = "TS1" },
	[12] = { "Secondary", Tone = "TS2" },
	[13] = { "Secondary", Tone = "TS3" },
	[14] = { "Secondary", Tone = "TS4" },
	[15] = { "Secondary", Tone = "T5" },
	[16] = { "Secondary", Tone = "T6" },
	[17] = { "Secondary", Tone = "T7" },
	[18] = { "Secondary", Tone = "T8" },
	[19] = { "Secondary", Tone = "SAIR" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Siren = {
		Frames = { 
			[1] = "1 11", 
			[2] = "2 12", 
			[3] = "3 13", 
			[4] = "4 14", 
			[5] = "5", 
			[6] = "6", 
			[7] = "7", 
			[8] = "8", 
			[9] = "9 19", 
			[10] = "10",
			[11] = "1 11",
		},
		Sequences = {
			["T1"] = { 1 },
			["T2"] = { 2 },
			["T3"] = { 3 },
			["T4"] = { 4 },
			["T5"] = { 5 },
			["T6"] = { 6 },
			["T7"] = { 7 },
			["T8"] = { 8 },
			["AIR"] = { 9 },
			["MAN"] = { 10 },
		}
	}
}

COMPONENT.InputPriorities = {
	["Virtual.SirenOverride"] = 62
}

COMPONENT.VirtualOutputs = {
	["Virtual.SirenOverride"] = {
		{
			Mode = "MANOVRD",
			Conditions = {
				["Emergency.Siren"] = { "T1", "T2", "T4" },
				["Emergency.SirenOverride"] = { "MAN" }
			}
		}
	}
}

COMPONENT.Inputs = { 
	["Emergency.Siren"] = {
		["T1"] = { Siren = "T1" },
		["T2"] = { Siren = "T2" },
		["T3"] = { Siren = "T3" },
		["T4"] = { Siren = "T4" },
		["T5"] = { Siren = "T5" },
		["T6"] = { Siren = "T6" },
		["T7"] = { Siren = "T7" },
		["T8"] = { Siren = "T8" },
	},
	["Emergency.SirenOverride"] = {
		["AIR"] = { Siren = "AIR" },
		["MAN"] = { Siren = "MAN" },
	},
	["Virtual.SirenOverride"] = {
		["MANOVRD"] = { Siren = "T3" }
	}
}