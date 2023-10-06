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

COMPONENT.ColorMap = "[ON] 1 2 3"

COMPONENT.Lights = {
	[1] = { "Speaker", "emv/sirens/federal sig ss/emv_wail.wav" },
	[2] = { "Speaker", "emv/sirens/federal sig ss/emv_yelp.wav" },
	[3] = { "Speaker", "emv/sirens/federal sig ss/emv_priority.wav" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Siren = {
		Frames = {
			[1] = "1",
			[2] = "2",
			[3] = "3",
		},
		Sequences = {
			["WAIL"] = { 1 },
			["YELP"] = { 2 },
			["PRIORITY"] = { 3 },
			["DEMO"] = sequence():Add(3):Do(16):Add(1):Do(16)
		}
	}
}

COMPONENT.Patterns = { -- Inputs
	["Emergency.Siren"] = {
		["T1"] = { Siren = "WAIL" },
		["T2"] = { Siren = "YELP" },
		["T3"] = { Siren = "PRIORITY" },
		["DEMO"] = { Siren = "DEMO" }
	}
}