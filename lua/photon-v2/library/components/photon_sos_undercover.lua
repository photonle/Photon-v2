if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Schmal",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal Universal Undercover]]

COMPONENT.Model = "models/schmal/sos_undercover.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Mid = {
			Width = 3,
			Height = 3,
			Scale = 4,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_undercover_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_undercover_bloom.png").MaterialName,
		}
	},
	["Sub"] = {
		LED = {
			States = {
				["B"] = { Material = "schmal/photon/sos_underco/emis_blu" },
				["R"] = { Material = "schmal/photon/sos_underco/emis_red" },
				["W"] = { Material = "schmal/photon/sos_underco/emis_whi" },
				["A"] = { Material = "schmal/photon/sos_underco/emis_amb" },
				["G"] = { Material = "schmal/photon/sos_underco/emis_gre" }
			}
		},
		Lens = {
			States = {
				["B"] = { Material = "schmal/photon/sos_underco/lens_blu" },
				["R"] = { Material = "schmal/photon/sos_underco/lens_red" },
				["W"] = { Material = "schmal/photon/sos_underco/lens_whi" },
				["A"] = { Material = "schmal/photon/sos_underco/lens_amb" },
				["G"] = { Material = "schmal/photon/sos_underco/lens_gre" },
			}
		}
	}
}

COMPONENT.ElementStates = {}

COMPONENT.Elements = {
	[1] = { "LED", Indexes = { 2 } },
	[2] = { "Lens", Indexes = { 3 } }, -- lens,
	[3] = { "Mid", Vector(0,0,1.2), Angle(-90,0,0) }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Undercover = {
		Frames = {
			-- [0] = "1:OFF 2:OFF 3:OFF",
			[1] = "1:B 2:B 3:B",
			[2] = "1:R 2:R 3:R",
			[3] = "1:W 2:W 3:W",
			[4] = "1:A 2:A 3:A",
			[5] = "1:G 2:G 3:G",
		},
		Sequences = {
			-- ["FLASH1"] = { 1 },
			["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2):Add(3):Do(4):Add(0):Do(2):Add(4):Do(4):Add(0):Do(2):Add(5):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Alternate( 1, 0, 5 )
			-- ["FLASH1"] = sequence():Flash( 1, 0, 3 ):Add( 0 ):Do( 4 )
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Undercover = "FLASH1"
		},
		["MODE2"] = {
			Undercover = "FLASH1"
		}
	}
}