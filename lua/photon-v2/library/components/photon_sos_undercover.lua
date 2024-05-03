if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[SoundOff Signal Universal Undercover]]
COMPONENT.Category = "Perimeter"
COMPONENT.Model = "models/schmal/sos_undercover.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -4),
	Angles = Angle( 0, 0, 0 ),
	Zoom = 3
}

COMPONENT.States = { "R", "B", "W" }

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
	},
	["Mesh"] = {
		Model = {
			Model = "models/schmal/sos_undercover.mdl"
		}
	}
}

COMPONENT.Elements = {
	[1] = { "LED", Indexes = { 2 } },
	[2] = { "Lens", Indexes = { 3 } }, -- lens,
	[3] = { "Mid", Vector( 0, 0, 1.2 ), Angle( -90, 0, 0 ) },
	[4] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "schmal/photon/sos_underco/glass", DrawMaterial = "photon/common/glow_gradient_additive_a" }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.StateMap = "[1/2/3] Light"

COMPONENT.ElementGroups = {
	Light = { 1, 2, 3, 4 }
}

COMPONENT.Segments = {
	Undercover = {
		Frames = {
			-- [0] = "1:OFF 2:OFF 3:OFF",
			[1] = "Light:B",
			[2] = "Light:R",
			[3] = "Light:W",
			[4] = "Light:A",
			[5] = "Light:G",
		},
		Sequences = {
			-- ["FLASH1"] = { 1 },
			["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2):Add(3):Do(4):Add(0):Do(2):Add(4):Do(4):Add(0):Do(2):Add(5):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Alternate( 1, 0, 5 )
			-- ["FLASH1"] = sequence():Flash( 1, 0, 3 ):Add( 0 ):Do( 4 )
		}
	},
	Light = {
		Frames = {
			[1] = "Light",
			[2] = "[W] Light",
			[3] = "Light:2"
		},
		Sequences = {
			["MARKER"] = { 1 },
			["SCENE"] = { 2 },
			["MED_ALT"] = sequence():Alternate( 1, 0, 2),
			["MED_ALT:B"] = sequence():Alternate( 0, 1, 2),
			["DUO_ALT_MED"] = sequence():Alternate( 1, 3, 8 ),
			["SOS_FLASH_TRIO"] = sequence()
						:FlashHold( { 1, 3, 2, 3 }, 3, 2 )
						:Do( 4 )
						:Alternate( 1, 3, 1 )
						:Do( 2 )
						:Alternate( 2, 3, 1 )
						:Do( 2 )
						:Alternate( 1, 3, 1 )
						:Do( 2 )
						:Alternate( 2, 3, 1 )
						:Do( 2 ),
			["SOS_FLASH_TRIO:B"] = sequence()
						:FlashHold( { 3, 1, 3, 2 }, 3, 2 )
						:Do( 4 )
						:Alternate( 3, 1, 1 )
						:Do( 2 )
						:Alternate( 3, 2, 1 )
						:Do( 2 )
						:Alternate( 3, 1, 1 )
						:Do( 2 )
						:Alternate( 3, 2, 1 )
						:Do( 2 )
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "MARKER"
		},
		["MODE2"] = {
			Light = "DUO_ALT_MED"
		},
		["MODE3"] = {
			Light = "SOS_FLASH_TRIO"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "MARKER"
		}
	}
}