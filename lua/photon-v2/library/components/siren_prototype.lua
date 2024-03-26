if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibrarySirenComponent]]

COMPONENT.Class = "Siren"

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "TDM",
	Code = "Schmal",
}

COMPONENT.Siren = "fedsig_touchmaster_delta"
COMPONENT.Category = "Speaker"
COMPONENT.Title = "Photon Siren Prototype"

COMPONENT.Model = "models/tdmcars/emergency/equipment/dynamax_siren.mdl"

COMPONENT.Templates = {
	["Sound"] = { 
		Tone = {
			DSP = 118,
			Pitch = 100
		} 
	}
}

COMPONENT.StateMap = "[ON] 1 2 3 4 5 6 7 8 9 10"

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
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Siren = {
		Frames = { [0] = "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" },
		Sequences = {
			["KILL"] = { 0 },
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
	["Virtual.SirenOverride"] = 62,
	["Emergency.SirenParkKill"] = 63,
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
	},
	["Emergency.SirenParkKill"] = {
		{
			Mode = "PARK",
			Conditions = {
				["Vehicle.Transmission"] = { "PARK" }
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
	},
	["Emergency.SirenParkKill"] = {
		-- ["PARK"] = { Siren = "KILL" }
	}
}