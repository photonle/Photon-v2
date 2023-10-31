if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

--[[
		SIREN PROTOTYPE
		
		TODO: Add templating or macroing for sirens
		COMPONENT.Sounds = ...
--]]


COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "TDM",
	Code = "Schmal",
	Audio = "Schmal/Federal Signal",
}

COMPONENT.Category = "Siren"

COMPONENT.PrintName = "Photon Siren Prototype"

COMPONENT.Model = "models/tdmcars/emergency/equipment/dynamax_siren.mdl"

COMPONENT.Templates = {
	["Sound"] = {
		Speaker = {
			States = {
				["ON-90"] = { Pitch = 97, Play = true, Mute = false },
				["ON+5"] = { Pitch = 101, Play = true, Mute = false },
				["ON+10"] = { Pitch = 102, Play = true, Mute = false },
				["ON+15"] = { Pitch = 103, Play = true, Mute = false },
				["ON+20"] = { Pitch = 104, Play = true, Mute = false },
				["ON+25"] = { Pitch = 105, Play = true, Mute = false },
				["ON+30"] = { Pitch = 106, Play = true, Mute = false },
				["ON-5"] = { Pitch = 107, Play = true, Mute = false },
				["ON-10"] = { Pitch = 108, Play = true, Mute = false },
				["ON-15"] = { Pitch = 109, Play = true, Mute = false },
				["ON-20"] = { Pitch = 110, Play = true, Mute = false },
				["ON-25"] = { Pitch = 111, Play = true, Mute = false },
				["ON-30"] = { Pitch = 112, Play = true, Mute = false },
			}
		}
	}
}

COMPONENT.ColorMap = " [HORN] 5 [ON] 1 2 3 4 5 6"

COMPONENT.Elements = {
	[1] = { "Speaker", "emv/sirens/federal sig ss/emv_wail.wav" },
	[2] = { "Speaker", "emv/sirens/federal sig ss/emv_yelp.wav" },
	[3] = { "Speaker", "emv/sirens/federal sig ss/emv_priority.wav" },
	[4] = { "Speaker", "emv/sirens/federal sig ss/emv_hilo.wav" },
	[5] = { "Speaker", "emv/sirens/federal sig ss/emv_horn.wav" },
	[6] = { "Speaker", "emv/sirens/federal sig ss/emv_manual.wav" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Siren = {
		Frames = { "1", "2", "3", "4", "5", "6" },
		Sequences = {
			["WAIL"] = { 1 },
			["YELP"] = { 2 },
			["PRIORITY"] = { 3 },
			["HILO"] = { 4 },
			["AIRHORN"] = { 5 },
			["MANUAL"] = { 6 },
			-- ["DEMO"] = sequence():Add(3):Do(16):Add(1):Do(16)
		}
	}
}

COMPONENT.InputPriorities = {
	["Virtual.SirenOverride"] = 52
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

COMPONENT.Inputs = { -- InputActions
	["Emergency.Siren"] = {
		["T1"] = { Siren = "WAIL" },
		["T2"] = { Siren = "YELP" },
		["T3"] = { Siren = "PRIORITY" },
		["T4"] = { Siren = "HILO" },
		-- ["DEMO"] = { Siren = "DEMO" }
	},
	["Emergency.SirenOverride"] = {
		["AIR"] = { Siren = "AIRHORN" },
		["MAN"] = { Siren = "MANUAL" },
	},
	["Virtual.SirenOverride"] = {
		["MANOVRD"] = { Siren = "PRIORITY" }
	}
}