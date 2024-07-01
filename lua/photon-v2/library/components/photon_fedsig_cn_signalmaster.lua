if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Cj24, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal CN SignalMaster]]
COMPONENT.Category = "Traffic"
COMPONENT.Model = "models/schmal/fedsig_cn_signalmaster.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.DefineOptions = {

}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.2,
			Height		= 2,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			VisibilityRadius = 0.5
		},
	},
	["Projected"] = {
		TakedownIllumination = {
			Material = "photon/flashlight/led_linear.png",
			Brightness = 1.5,
			FOV = 45
		},
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

COMPONENT.StateMap = "[1/2/3] 1 3 5 7 [2/1/3] 2 4 6 8"

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 1.7, -2.28, 0 ), Angle( 0, -90, 0 ) },
	[2] = { "Primary", Vector( 1.7, 2.28, 0 ), Angle( 0, -90, 0 ) },

	[3] = { "Primary", Vector( 1.7, -6.35, 0 ), Angle( 0, -90, 0 ) },
	[4] = { "Primary", Vector( 1.7, 6.35, 0 ), Angle( 0, -90, 0 ) },

	[5] = { "Primary", Vector( 1.7, -10.45, 0 ), Angle( 0, -90, 0 ) },
	[6] = { "Primary", Vector( 1.7, 10.45, 0 ), Angle( 0, -90, 0 ) },

	[7] = { "Primary", Vector( 1.7, -14.52, 0 ), Angle( 0, -90, 0 ) },
	[8] = { "Primary", Vector( 1.7, 14.52, 0 ), Angle( 0, -90, 0 ) },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8",
			[2] = "7 3 2 6",
			[3] = "5 1 4 8",
			[4] = "[1] 7 3 [2] 2 6",
			[5] = "[1] 5 1 [2] 4 8",
			[6] = "[2] 7 3 [1] 2 6",
			[7] = "[2] 5 1 [1] 4 8",
		},
		Sequences = {
			["ON"] = { 1 },
			["MIX_2FH"] = sequence():FlashHold( { 2, 3 }, 2, 4 ),
			["MIX_2FH_2C"] = sequence():FlashHold( { 4, 5, 6, 7 }, 2, 4 ),
			["OFF"] = { 0 }
		}
	},
	["Pursuit"] = {
		Frames = {
			[1] = "[1] 1 3 5 7",
			[2] = "[2] 2 4 6 8",
			[3] = "[2] 1 3 5 7",
			[4] = "[1] 2 4 6 8",
			[5] = "[1] 6 2 1 5",
			[6] = "[1] 8 4 3 7",
			[7] = "[2] 6 2 1 5",
			[8] = "[2] 8 4 3 7",
		},
		Sequences = {
			["PURSUIT"] = sequence()
				:Alternate( 1, 2, 6 )
				:Alternate( 3, 4, 6 )
				:Alternate( 1, 2, 6 )
				:Alternate( 3, 4, 6 )
				:Alternate( 7, 6, 4 )
				:Alternate( 5, 8, 4 )
				:Alternate( 1, 2, 2 )
				:Alternate( 3, 4, 2 )
				:Alternate( 1, 2, 2 )
				:Alternate( 3, 4, 2 )
				:FlashHold( { 5, 8 }, 2, 1 )
				:FlashHold( { 6, 7 }, 2, 1 )
				:Add( 6, 6, 8, 5, 5, 7, 8, 8, 6, 7, 7, 5 ):Do ( 2 )
		}
	},
	["SignalMaster"] = Photon2.SegmentBuilder.SignalMaster( 7, 5, 3, 1, 2, 4, 6, 8 ),

}

COMPONENT.Patterns = {
	["MIX_DOUBLE_FLASH"] = { { "All", "MIX_2FH" } },
	["MIX_2FH_2C"] = { { "All", "MIX_2FH_2C" } },
	["PURSUIT"] = { { "Pursuit", "PURSUIT" } },
	["OFF"] = { { "All", "OFF" } },
	
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { All = "ON" },
		["MODE2"] = "MIX_DOUBLE_FLASH",
		["MODE3"] = "PURSUIT"
	},
	["Emergency.Marker"] = {
		["ON"] = {
			All = "ON",
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = { SignalMaster = "LEFT" },
		["RIGHT"] = { SignalMaster = "RIGHT" },
		["CENOUT"] = { SignalMaster = "CENOUT" }
	},
	["Emergency.Cut"] = {
		["REAR"] = "OFF"
	},
	["Emergency.SceneForward"] = {
		["ON"] = {

		},
		["FLOOD"] = {
			
		}
	}
}