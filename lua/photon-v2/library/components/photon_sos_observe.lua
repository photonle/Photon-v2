if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal", Model = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal obSERVE Dome Light]]

COMPONENT.Model = "models/schmal/sos_observe.mdl"

COMPONENT.Templates = {
	["Mesh"] = {
		Model = {
			Model = "models/schmal/sos_observe.mdl",
			States = {
				-- R = {
				-- 	DrawColor = PhotonColor( 255, 0, 0 ),
				-- 	BloomColor = PhotonColor( 255, 0, 0 )
				-- }
			}
		}
	},
	["DynamicLight"] = {
		Dynamic = {
			Brightness = 9,
			Size = 40,
			InnerAngle = 60,
			OuterAngle = 90,
		}
	},
	["Sequence"] = {
		["Sequence"] = {
			States = {
				["MODE1"] = { Sequence = "mode_2" },
				["MODE2"] = { Sequence = "mode_1" },
			}
		}
	},
	["Sub"] = {
		SubMaterial = {
			States = {
				HIDE = { Material = "photon/common/blank" }
			}
		}
	}
}

COMPONENT.StateMap = ""

COMPONENT.Elements = {
	[1] = { "Sequence" },
	[2] = { "SubMaterial", Indexes = { 1 } },
	[3] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "schmal/photon/sos_observe/dome", DrawMaterial = "schmal/photon/sos_observe/light", BloomMaterial = "schmal/photon/sos_observe/light" },
	[4] = { "Dynamic", Vector( 0, 0, 1 ), Angle( 0, 0, 0 ) }
}

COMPONENT.Segments = {
	Switch = {
		Frames = {
			[1] = "1:MODE2 2:HIDE 3:W 4:W",
			[2] = "1:MODE1 2:HIDE 3:R 4:R",
		},
		Sequences = {
			MODE1 = { 1 },
			MODE2 = { 2 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Auxiliary"] = {
		["MODE1"] = {
			Switch = "MODE2"
		},
		["MODE2"] = {
			Switch = "MODE1"
		},
	}
}