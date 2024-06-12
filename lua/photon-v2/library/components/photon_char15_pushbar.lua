if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "SGM/Mighty/???, Schmal, et. al",
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Title = [[Push Bumper - 2015 Dodge Charger Pursuit]]
COMPONENT.Category = "Bumper"
COMPONENT.Model = "models/schmal/char15_pushbar_pit.mdl"

COMPONENT.BodyGroups = {
	["upper_lights"] = "upper_impaxx",
	["side_lights"] = "side_impaxx",
}

COMPONENT.Templates = {
	["2D"] = {
		Impaxx = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.4,
			Height = 5.4/2,
		},
	}
}

COMPONENT.Elements = {
	[1] = { "Impaxx", Vector( -12.9, -9.45, 12.25 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["upper_lights"] = 1 } },
	[2] = { "Impaxx", Vector( -12.9, 9.45, 12.25 ), Angle( 0, 90, 0 ), RequiredBodyGroups = { ["upper_lights"] = 1 } },
	
	[3] = { "Impaxx", Vector( -11.75, -21.7, 7.05 ), Angle( 0, 180 - 38, 0 ), RequiredBodyGroups = { ["side_lights"] = 1 } },
	[4] = { "Impaxx", Vector( -11.75, 21.7, 7.05 ), Angle( 0, 38, 0 ), RequiredBodyGroups = { ["side_lights"] = 1 } },
}

COMPONENT.StateMap = "[1/2] 1 3 [2/1] 2 4"

COMPONENT.Features = {
	ParkMode = true
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Impaxx = {
		Frames = {
			[1] = "1 2 3 4"
		},
		Sequences = {
			ALL = { 1 }
		}
	},
	ImpaxxUpper = {
		Frames = {
			[1] = "1",
			[2] = "2",
			[3] = "[2] 1",
			[4] = "[2] 2",
			[5] = "[W] 1",
			[6] = "[W] 2",
			[7] = "[W] 1 2"
		},
		Sequences = {
			ALL = { 1 },
			FLASH = sequence():FlashHold( { 1, 2, 3, 4 }, 3, 2 ),
			FLASHW = sequence():FlashHold( { 1, 2, 3, 4, 5, 6 }, 3, 2 ),
			ILLUM = { 7 },
		}
	},
	ImpaxxSide = {
		Frames = {
			[1] = "4",
			[2] = "3",
			[3] = "[2] 4",
			[4] = "[2] 3",
			[5] = "[W] 4",
			[6] = "[W] 3",
			[7] = "[W] 3 4",
		},
		Sequences = {
			ALL = { 1 },
			FLASH = sequence():FlashHold( { 1, 2, 3, 4 }, 3, 2 ),
			FLASHW = sequence():FlashHold( { 1, 2, 5, 6, 3, 4 }, 3, 2 ),
			ILLUM = { 7 },
		}
	},
	Cut = {
		Frames = {
			[1] = "[OFF] 1 2 3 4"
		},
		Sequences = {
			["ENABLED"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE2"] = {
			ImpaxxUpper = "FLASH",
			ImpaxxSide = "FLASH"
		},
		["MODE3"] = {
			ImpaxxUpper = "FLASHW",
			ImpaxxSide = "FLASHW"
		}
	},
	["Emergency.ParkedWarning"] = {
		["MODE3"] = {
			ImpaxxUpper = "FLASH",
			ImpaxxSide = "FLASH"
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			ImpaxxUpper = "ILLUM",
		},
		["FLOOD"] = {
			ImpaxxUpper = "ILLUM",
			ImpaxxSide = "ILLUM"
		}
	},
	["Emergency.Cut"] = {
		["FRONT"] = {
			Cut = "ENABLED"
		}
	}
}