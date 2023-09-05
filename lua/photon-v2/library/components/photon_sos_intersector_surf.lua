if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Frost88, Schmal",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal Intersector (Surface)]]

COMPONENT.Model = "models/schmal/sos_int_surf.mdl"

COMPONENT.Templates = {
	["2D"] = {
		LED_Main = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 1.3,
			VisibilityRadius = 0
		},
		LED = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 0.5,
			VisibilityRadius = 0
		},
		Effect_Edge = {
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
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
	}
}

COMPONENT.LightStates = {}

COMPONENT.Lights = {
	[1] = { "LEDs", Indexes = { 1 } },
	[2] = { "LED_Main", Vector( 0, 0.75, 0.02 ), Angle( 0, 0, 0 ) },
	[3] = { "LED", Vector( 0.64, 0.44, 0.02 ), Angle( 0, -60, 0 ) },
	[4] = { "LED", Vector( -0.64, 0.44, 0.02 ), Angle( 0, 60, 0 ) },
	[5] = { "Effect_Edge", Vector( 1.01, 0.07, 0.02 ), Angle( 0, 0, 0 ) },
	[6] = { "Effect_Edge", Vector( -1.01, 0.07, 0.02 ), Angle( 0, 0, 0 ) },
	[7] = { "Lens", Indexes = { 3 } }, -- lens
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.LightGroups = {
	["Intersector"] = { 1, 2, 3, 4, 5, 6, 7 }
}

COMPONENT.ColorMap = "[W] Intersector"

COMPONENT.Segments = {
	Intersector = {
		Frames = {
			[1] = "Intersector",
			[2] = "Intersector:B",
			[3] = "Intersector:R",
			[4] = "Intersector:W",
			[5] = "Intersector:A",
			[6] = "Intersector:G",
		},
		Sequences = {
			["FLASH1"] = { 1 },
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Add( 1 ):Do(4):Add(0):Do(2):Add(2):Do(4):Add(0):Do(2):Add(3):Do(4):Add(0):Do(2):Add(4):Do(4):Add(0):Do(2):Add(5):Do(4):Add(0):Do(2)
			-- ["FLASH1"] = sequence():Alternate( 1, 0, 5 )
			-- ["FLASH1"] = sequence():Flash( 1, 0, 3 ):Add( 0 ):Do( 4 )
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Intersector = "FLASH1"
		}
	}
}