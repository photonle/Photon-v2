if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Ford 96T Rear Spoiler Light]]
COMPONENT.Category = "Special"
COMPONENT.Model = "models/schmal/ford_96t.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width = 2.75,
			Height = 1.3525,
			Detail = PhotonMaterial.GenerateLightQuad( "photon/lights/ford96t_detail.png" ).MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad( "photon/lights/ford96t_shape.png" ).MaterialName,
			VisibilityRadius = 0.1
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "A"
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[2] = { "Light", Vector( -5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },

	[3] = { "Light", Vector( 2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[4] = { "Light", Vector( -2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[5] = { "Light", Vector( -0, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[6] = { "Light", Vector( -0, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[7] = { "Light", Vector( -2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[8] = { "Light", Vector( 2.95, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
	
	[9] = { "Light", Vector( -5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 0 },
	[10] = { "Light", Vector( 5.92, -1.25, -.02 ), Angle( 0, 180, 0 ), BoneParent = 1 },
}

COMPONENT.StateMap = "[1/2] 1 3 5 7 9 [2/1] 2 4 6 8 10"

COMPONENT.SubMaterials = {
	-- [1] = "photon/common/blank"
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10",
			[2] = "1 3 5 7 9",
			[3] = "2 4 6 8 10"
		},
		Sequences = {
			["ON"] = { 1 },
			["BLINK"] = { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
			["ALT_SLOW"] = sequence():Alternate( 2, 3, 7 ),
			["QUAD_SOLO"] = sequence():FlashHold( { 2, 3 }, 4, 3 )
		}
	},
	-- ["Traffic"] = {
	-- 	Frames = {
	-- 		[1] = "1",
	-- 		[2] = "1 2",
	-- 		[3] = "1 2 3",
	-- 		[4] = "1 2 3 4",
	-- 		[5] = "1 2 3 4 5",
	-- 	},
	-- 	Sequences = {
	-- 		["LEFT"] = { 1 },
	-- 		["BLINK"] = { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	-- 	}
	
	-- }
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ALT_SLOW"
		},
		["MODE2"] = {
			All = "QUAD_SOLO"
		},
		["MODE3"] = {
			All = "QUAD_SOLO"
		}
	}
}