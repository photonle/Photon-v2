if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Frost88, Schmal",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal Intersector (Surface)]]

COMPONENT.Model = "models/schmal/sos_int_surf.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

COMPONENT.Templates = {
	["2D"] = {
		LED_Main = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 1.3,
			VisibilityRadius = 0
		},
		LED = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 0.5,
			VisibilityRadius = 0
		},
		Effect_Edge = {
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 0.3,
			VisibilityRadius = 0
		}
	},
	["Sub"] = {
		LEDs = {
			States = {
				["R"] = { Material = "schmal/photon/sos_int/emis_red" },
				["B"] = { Material = "schmal/photon/sos_int/emis_blu" },
				["W"] = { Material = "schmal/photon/sos_int/emis_whi" },
				["A"] = { Material = "schmal/photon/sos_int/emis_amb" },
				["G"] = { Material = "schmal/photon/sos_int/emis_gre" },
			}
		},
		Lens = {
			States = {
				["R"] = { Material = "schmal/photon/sos_int/lens_red" },
				["B"] = { Material = "schmal/photon/sos_int/lens_blu" },
				["W"] = { Material = "schmal/photon/sos_int/lens_whi" },
				["A"] = { Material = "schmal/photon/sos_int/lens_amb" },
				["G"] = { Material = "schmal/photon/sos_int/lens_gre" },
			}
		}
	},
	["Mesh"] = {
		Mesh = {
			Model = "models/schmal/sos_int_surf.mdl",
			Scale = 1.1
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Lens", Indexes = { 3 } }, -- lens,
	[2] = { "Mesh", Vector( 0, 0, 0 ), Angle( 0, -90, 0 ), "schmal/photon/sos_int/reflector", DrawMaterial = "schmal/photon/sos_int/emis_bloom" }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.ElementGroups = {
	["Intersector"] = { 1, 2 },
}

COMPONENT.StateMap = "[1/2/3] Intersector"

COMPONENT.Segments = {
	Intersector = {
		Frames = {
			[1] = "Intersector",
			[2] = "Intersector:2",
			[3] = "Intersector:3",
			[4] = "Intersector:W",
			[5] = "Intersector:A",
			[6] = "Intersector:G",
		},
		Sequences = {
			["FLASH1"] = { 1 },
			["STEADY_FLASH"] = sequence():SteadyFlash( 1 )
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2):Add(3):Do(4):Add(0):Do(2):Add(4):Do(4):Add(0):Do(2):Add(5):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Alternate( 1, 0, 5 )
			-- ["FLASH1"] = sequence():Flash( 1, 0, 3 ):Add( 0 ):Do( 4 )
		}
	},
	Light = {
		Frames = {
			[1] = "Intersector",
			[2] = "Intersector:2",
			[3] = "Intersector:3",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():Alternate( 1, 0, 8 ),
			["STEADY_FLASH"] = sequence():SteadyFlash( 1 ),
			["QUAD_FLASH_DUO"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_FLASH_DUO:B"] = sequence():QuadFlash( 2, 1 )
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ON"
		},
		["MODE2"] = {
			Light = "FLASH"
		},
		["MODE3"] = {
			Light = "FLASH"
		}
	}
}