if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "TDM",
	Code = "Schmal",
	Audio = "Schmal/Federal Signal",
}

COMPONENT.Category = "Siren"

COMPONENT.PrintName = "Photon Siren Prototype"

COMPONENT.Model = "models/tdmcars/emergency/equipment/dynamax_siren.mdl"

COMPONENT.Sounds = {
	[1] = { File = "emv/sirens/federal sig ss/emv_wail.wav", Name = "Wail" },
	[2] = { File = "emv/sirens/federal sig ss/emv_yelp.wav", Name = "Yelp" },
	[3] = { File = "emv/sirens/federal sig ss/emv_priority.wav", Name = "Priority" },
	[4] = { File = "emv/sirens/federal sig ss/emv_hilo.wav", Name = "Hi-Lo" },
	[4] = { File = "emv/sirens/federal sig ss/emv_horn.wav", Name = "Horn" },
	[4] = { File = "emv/sirens/federal sig ss/emv_manual.wav", Name = "Manual" },
}