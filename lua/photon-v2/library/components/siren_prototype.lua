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

COMPONENT.Lighting = {
	["Sound"] = {
		Speaker = {}
	}
}

COMPONENT.Lights = {
	[1] = { "Speaker", "emv/sirens/federal sig ss/emv_wail.wav" },
	[2] = { "Speaker", "emv/sirens/federal sig ss/emv_yelp.wav" },
	[3] = { "Speaker", "emv/sirens/federal sig ss/emv_priority.wav" },
}

COMPONENT.Segments = {
	Siren = {
		Frames = {
			[1] = "1:ON",
			[2] = "2:ON",
			[3] = "3:ON",
		},
		Sequences = {
			["WAIL"] = { 1 },
			["YELP"] = { 2 },
			["PRIORITY"] = { 3 },
		}
	}
}

COMPONENT.Sounds = {
	[1] = { File = "emv/sirens/federal sig ss/emv_wail.wav", Name = "Wail" },
	[2] = { File = "emv/sirens/federal sig ss/emv_yelp.wav", Name = "Yelp" },
	[3] = { File = "emv/sirens/federal sig ss/emv_priority.wav", Name = "Priority" },
	[4] = { File = "emv/sirens/federal sig ss/emv_hilo.wav", Name = "Hi-Lo" },
	[5] = { File = "emv/sirens/federal sig ss/emv_horn.wav", Name = "Horn" },
	[6] = { File = "emv/sirens/federal sig ss/emv_manual.wav", Name = "Manual" },
}

COMPONENT.Patterns = {
	["Emergency.Siren"] = {
		["WAIL"] = { Siren = "WAIL" },
		["YELP"] = { Siren = "YELP" },
		["PRIORITY"] = { Siren = "PRIORITY" },
	}
}