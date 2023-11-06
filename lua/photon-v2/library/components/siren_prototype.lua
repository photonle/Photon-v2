if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

--[[
		SIREN PROTOTYPE
		
		TODO: Add templating or macroing for sirens
		COMPONENT.Sounds = ...
--]]

-- COMPONENT.Class = "Siren"

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
		Speaker = {}
	}
}

COMPONENT.ColorMap = " [HORN] 5 [ON] 1 2 3 4 5 6"

COMPONENT.Elements = {
	[1] = { "Speaker", Tone = "fedsig_touchmaster_delta/wail" },
	-- [1] = { "Speaker", "photon/sirens/fedsig_tmd/wail.wav" },
	-- [1] = { "Speaker", "emv/sirens/federal sig ss/emv_wail.wav" },
	[2] = { "Speaker", Tone = "fedsig_touchmaster_delta/yelp" },
	[3] = { "Speaker", Tone = "fedsig_touchmaster_delta/scan" },
	[4] = { "Speaker", "emv/sirens/federal sig ss/emv_hilo.wav" },
	[5] = { "Speaker", "emv/sirens/federal sig ss/emv_horn.wav" },
	[6] = { "Speaker", "emv/sirens/federal sig ss/emv_manual.wav" },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Siren = {
		Frames = { "1", "2", "3", "4", "5", "6" },
		Sequences = {
			["T1"] = { 1 },
			["T2"] = { 2 },
			["T3"] = { 3 },
			["T4"] = { 4 },
			["AIR"] = { 5 },
			["MAN"] = { 6 },
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
		["T1"] = { Siren = "T1" },
		["T2"] = { Siren = "T2" },
		["T3"] = { Siren = "T3" },
		["T4"] = { Siren = "T4" },
		-- ["DEMO"] = { Siren = "DEMO" }
	},
	["Emergency.SirenOverride"] = {
		["AIR"] = { Siren = "AIR" },
		["MAN"] = { Siren = "MAN" },
	},
	["Virtual.SirenOverride"] = {
		["MANOVRD"] = { Siren = "T3" }
	}
}