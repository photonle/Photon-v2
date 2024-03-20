if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SuperMighty",
	Code = "Schmal"
}

COMPONENT.Title = [[Whelen Liberty II (48")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/supermighty/whelen_liberty_ii.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 	= 8.7,
			Height	= 8.5,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_detail.png").MaterialName,
			Scale = 2
		},
		Corner = {
			Width 	= 12.2,
			Height	= 16,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_detail.png").MaterialName,
		},
		Takedown = {
			Width 	= 7.4,
			Height	= 7.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_6x2_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_6x2_detail.png").MaterialName,
			Scale = 1
		},
		Half = {
			Width 	= 4.4,
			Height	= 4.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_half_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_half_detail.png").MaterialName,
		},
		Alley = {
			Width 	= 3.2,
			Height	= 3.2,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_alley_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_alley_shape.png").MaterialName,
		},
		CornerEdge = {
			Width 	= 4.9,
			Height	= 4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_shape.png").MaterialName,
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_corner_edge_detail.png").MaterialName,
		},
	},
	["Projected"] = {
		TakedownIllumination = {
			Brightness = 2
		},
		AlleyIllumination = {}
	}
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 6.33, 4.3, 0.36 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 6.33, -4.3, 0.36 ), Angle( 0, -90, 0 ) },

	[3] = { "Takedown", Vector( 6.33, 11.37, 0.4 ), Angle( 0, -90, 0 ) },
	[4] = { "Takedown", Vector( 6.33, -11.37, 0.4 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 6.33, 18.44, 0.36 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 6.33, -18.44, 0.36 ), Angle( 0, -90, 0 ) },

	[7] = { "Corner", Vector( 4.18, 26.5, 0.39 ), Angle( 0, -90 + 45.9, 0 ) },
	[8] = { "Corner", Vector( 4.18, -26.5, 0.39 ), Angle( 0, -90 - 45.9, 0 ) },

	[9] = { "Corner", Vector( -4.18, 26.5, 0.39 ), Angle( 0, 90 - 45.9, 0 ) },
	[10] = { "Corner", Vector( -4.18, -26.5, 0.39 ), Angle( 0, 90 + 45.9, 0 ) },

	[11] = { "Primary", Vector( -6.33, 18.44, 0.36 ), Angle( 0, 90, 0 ) },
	[12] = { "Primary", Vector( -6.33, -18.44, 0.36 ), Angle( 0, 90, 0 ) },

	[13] = { "Primary", Vector( -6.33, 11.37, 0.36 ), Angle( 0, 90, 0 ) },
	[14] = { "Primary", Vector( -6.33, -11.37, 0.36 ), Angle( 0, 90, 0 ) },

	[15] = { "Primary", Vector( -6.33, 4.3, 0.36 ), Angle( 0, 90, 0 ) },
	[16] = { "Primary", Vector( -6.33, -4.3, 0.36 ), Angle( 0, 90, 0 ) },

	[17] = { "Alley", Vector( 0, 28.8, 0.38 ), Angle( 0, 0, 0 ) },
	[18] = { "Alley", Vector( 0, -28.8, 0.38 ), Angle( 0, 180, 0 ) },

	[19] = { "CornerEdge", Vector( 6.33, 23.79, 0.36 ), Angle( 0, -90, 0 ) },
	[20] = { "CornerEdge", Vector( 6.33, -23.79, 0.36 ), Angle( 0, -90, 0 ), Width = -4.9 },

	[21] = { "CornerEdge", Vector( 1.4, 28.52, 0.39 ), Angle( 0, 0, 0 ), Width = -4.9 },
	[22] = { "CornerEdge", Vector( 1.4, -28.52, 0.39 ), Angle( 0, 180, 0 ) },

	[23] = { "CornerEdge", Vector( -1.4, 28.52, 0.39 ), Angle( 0, 0, 0 ) },
	[24] = { "CornerEdge", Vector( -1.4, -28.52, 0.39 ), Angle( 0, 180, 0 ), Width = -4.9  },

	[25] = { "CornerEdge", Vector( -6.33, 23.79, 0.36 ), Angle( 0, 90, 0 ), Width = -4.9  },
	[26] = { "CornerEdge", Vector( -6.33, -23.79, 0.36 ), Angle( 0, 90, 0 ) },
}

COMPONENT.StateMap = "[1] 1 5 7 9 11 13 15 19 21 23 25 [2] 2 6 8 10 12 14 16 20 22 24 26 [W] 3 4 17 18"

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26",
		},
		Sequences = {
			["ON"] = { 1 },
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { All = "ON" },
		["MODE2"] = { All = "ON" },
		["MODE3"] = { All = "ON" },
	}
}