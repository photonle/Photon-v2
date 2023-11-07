if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal"
}

COMPONENT.PrintName = [[Siren #2 Speaker]]

COMPONENT.Base = "siren_prototype"


COMPONENT.InputPriorities = {
	["Virtual.SirenOverride"] = UNSET,
	["Virtual.Siren2Override"] = 52
}

COMPONENT.VirtualOutputs = {
	["Virtual.SirenOverride"] = UNSET,
	["Virtual.Siren2Override"] = {
		{
			Mode = "MANOVRD",
			Conditions = {
				["Emergency.Siren2"] = { "T1", "T2", "T4" },
				["Emergency.Siren2Override"] = { "MAN" }
			}
		}
	}
}

COMPONENT.Inputs = { 
	["Emergency.Siren"] = UNSET,
	["Emergency.Siren2"] = {
		["T1"] = { Siren = "T1" },
		["T2"] = { Siren = "T2" },
		["T3"] = { Siren = "T3" },
		["T4"] = { Siren = "T4" },
		["T5"] = { Siren = "T5" },
		["T6"] = { Siren = "T6" },
		["T7"] = { Siren = "T7" },
		["T8"] = { Siren = "T8" },
	},
	["Emergency.SirenOverride"] = UNSET,
	["Emergency.Siren2Override"] = {
		["AIR"] = { Siren = "AIR" },
		["MAN"] = { Siren = "MAN" },
	},
	["Virtual.SirenOverride"] = UNSET, 
	["Virtual.Siren2Override"] = {
		["MANOVRD"] = { Siren = "T3" }
	}
}