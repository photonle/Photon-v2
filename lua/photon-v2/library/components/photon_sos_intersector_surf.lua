if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Frost88, Schmal",
	Code = "Schmal"
}

COMPONENT.PrintName = [[SoundOff Signal Intersector (Surface)]]

COMPONENT.Model = "models/schmal/sos_int_surf.mdl"

COMPONENT.Lighting = {
	["2D"] = {
		LED_Main = {
			-- Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			-- MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 1.3,
			VisibilityRadius = 0
		},
		LED = {
			-- Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_shape.png").MaterialName,
			-- MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 0.5,
			VisibilityRadius = 0
		},
		Effect_Edge = {
			-- MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/led_detail.png").MaterialName,
			Width = 0.5,
			Height = 0.5,
			Scale = 0.3,
			VisibilityRadius = 0
		}
	},
	["Sub"] = {
		LightSubMat = {}
	}
}

COMPONENT.LightStates = {
	["Sub"] = {
		["OFF"] = {
			Material = nil
		},
		["BLUE"] = {
			Material = "schmal/photon/sos_int/emis_blu"
		},
		["RED"] = {
			Material = "schmal/photon/sos_int/emis_red"
		},
		["WHI"] = {
			Material = "schmal/photon/sos_int/emis_whi"
		},
		["AMB"] = {
			Material = "schmal/photon/sos_int/emis_amb"
		},
		["GRE"] = {
			Material = "schmal/photon/sos_int/emis_gre"
		},
		["L_DEF"] = {
			Material = "schmal/photon/sos_int/lens"
		},
		["L_BLU"] = {
			Material = "schmal/photon/sos_int/lens_blu"
		},
		["L_RED"] = {
			Material = "schmal/photon/sos_int/lens_red"
		},
		["L_WHI"] = {
			Material = "schmal/photon/sos_int/lens_whi"
		},
		["L_AMB"] = {
			Material = "schmal/photon/sos_int/lens_amb"
		},
		["L_GRE"] = {
			Material = "schmal/photon/sos_int/lens_gre"
		}
	}
}

COMPONENT.Lights = {
	[1] = { "LightSubMat", Indexes = { 1 } },
	[2] = { "LED_Main", Vector( 0, 0.75, 0.02 ), Angle( 0, 0, 0 ) },
	[3] = { "LED", Vector( 0.64, 0.44, 0.02 ), Angle( 0, -60, 0 ) },
	[4] = { "LED", Vector( -0.64, 0.44, 0.02 ), Angle( 0, 60, 0 ) },
	[5] = { "Effect_Edge", Vector( 1.01, 0.07, 0.02 ), Angle( 0, 0, 0 ) },
	[6] = { "Effect_Edge", Vector( -1.01, 0.07, 0.02 ), Angle( 0, 0, 0 ) },
	[7] = { "LightSubMat", Indexes = { 3 } }, -- lens
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Intersector = {
		Frames = {
			[0] = "1:OFF 2:OFF 3:OFF 4:OFF 5:OFF 6:OFF 7:L_DEF",
			[1] = "1:BLUE 2:B 3:B 4:B 5:B 6:B 7:L_BLU",
			[2] = "1:RED 2:R 3:R 4:R 5:R 6:R 7:L_RED",
			[3] = "1:WHI 2:W 3:W 4:W 5:W 6:W 7:L_WHI",
			[4] = "1:AMB 2:A 3:A 4:A 5:A 6:A 7:L_AMB",
			[5] = "1:GRE 2:G 3:G 4:G 5:G 6:G 7:L_GRE",
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

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Intersector = "FLASH1"
		}
	}
}