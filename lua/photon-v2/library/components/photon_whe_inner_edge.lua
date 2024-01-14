local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_inner_edge_left"
COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "SuperMighty",
	Code = "Schmal"
}

COMPONENT.PrintName = "Whelen Inner Edge"

COMPONENT.Model = "models/supermighty/photon/inner_edge_driver.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Takedown = {
			Width 	= 4,
			Height	= 2,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_inner_edge_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_inner_edge_detail.png").MaterialName,
			Scale = 2
		},
		Normal = {
			Width 	= 4.3,
			Height	= 4.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sm_whe_lib_ii_primary_detail.png").MaterialName,
			Scale = 1.25
		}
	}
}

COMPONENT.StateMap = "[W] 1 [R] 2 3 4 5 6"

COMPONENT.Elements = {
	[1] = { "Takedown", Vector( 2.25, -10.6, -0.06 ), Angle( 0, -85, 0 ) },
	[2] = { "Normal", Vector( 1.5, -6.7, -0.06 ), Angle( 0, -84, 0 ) },
	[3] = { "Normal", Vector( 0.66, -3, -0.06 ), Angle( 0, -84, 0 ) },
	[4] = { "Normal", Vector( -0.18, 0.75, -0.06 ), Angle( 0, -84, 0 ) },
	[5] = { "Normal", Vector( -1.02, 4.6, -0.06 ), Angle( 0, -84, 0 ) },
	[6] = { "Normal", Vector( -1.86, 8.45, -0.06 ), Angle( 0, -84, 0 ) },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6"
		},
		Sequences = {
			ON = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ON"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_inner_edge_right"
COMPONENT.Base = "photon_whe_inner_edge_left"
COMPONENT.Model = "models/supermighty/photon/inner_edge_passenger.mdl"

COMPONENT.StateMap = "[W] 1 [B] 2 3 4 5 6"

COMPONENT.Elements = {
	[1] = { "Takedown", Vector( 2.25, 10.6, -0.06 ), Angle( 0, -95, 0 ) },
	[2] = { "Normal", Vector( 1.5, 6.7, -0.06 ), Angle( 0, -96, 0 ) },
	[3] = { "Normal", Vector( 0.66, 3, -0.06 ), Angle( 0, -96, 0 ) },
	[4] = { "Normal", Vector( -0.18, -0.75, -0.06 ), Angle( 0, -96, 0 ) },
	[5] = { "Normal", Vector( -1.02, -4.6, -0.06 ), Angle( 0, -96, 0 ) },
	[6] = { "Normal", Vector( -1.86, -8.45, -0.06 ), Angle( 0, -96, 0 ) },
}

Photon2.RegisterComponent( COMPONENT )