if (Photon2.ReloadComponentFile()) then return end
---@class PhotonHUD : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Code = "Schmal",
}

COMPONENT.PrintName = [[Photon 2 HUD]]

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

COMPONENT.ColorMap = "[ON] 1 2 3 4 5 6 7 8"

COMPONENT.Segments = {
	Default = {
		Frames = {
			[1] = "1 2 3 4",
			[2] = "5 6 7 8",
		},
		Sequences = {
			["FLASH"] = { 1, 1, 1, 1, 2, 2, 2, 2 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Default = "FLASH" }
	}
}