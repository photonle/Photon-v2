if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Twurtleee, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Valor (51")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_valor_51.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 5.9,
			Height		= 3.3,
			-- Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			VisibilityRadius = 0.5
		},
		HotFoot = {
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5,
			Height = 5/2,
			Scale = 1,
			States = {
				DW = { Inherit = "W", Intensity = 0.4 }
			},
			-- RequiredBodyGroups = {
				-- Requires HotFeet body-group
				-- [2] = 0
			-- }
		}
	}
}


function move( vector, angle, distance )
    local radians = math.rad( angle )
    local newX = vector.x + math.cos( radians ) * distance
    local newY = vector.y + math.sin( radians ) * distance
	local result = Vector( newX, newY, vector.z )
    print( tostring( result ) )
	return result
end

local ang = 51.1

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 10.39, 2.37, 1.15 ), Angle( 0, -ang, 0 ), Width = 7.6 },
	[2] = { "Primary", Vector( 10.39, -2.37, 1.15 ), Angle( 0, 180 + ang, 0 ), Width = 7.6 },
	
	[3] = { "Primary", Vector( 6.968, 6.611, 1.15 ), Angle( 0, -ang, 0 ), Width = 6 },
	[4] = { "Primary", Vector( 6.968, -6.611, 1.15 ), Angle( 0, 180 + ang, 0 ), Width = 6 },
	
	[5] = { "Primary", Vector( 3.922, 10.386, 1.15 ), Angle( 0, -ang, 0 ) },
	[6] = { "Primary", Vector( 3.922, -10.386, 1.15 ), Angle( 0, 180 + ang, 0 ) },

	[7] = { "Primary", Vector( 0.87, 14.168, 1.15 ), Angle( 0, -ang, 0 ) },
	[8] = { "Primary", Vector( 0.87, -14.168, 1.15 ), Angle( 0, 180 + ang, 0 ) },

	[9] = { "Primary", Vector( -0.65, 18.45, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	[10] = { "Primary", Vector( -0.65, -18.45, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	
	[11] = { "Primary", Vector( -0.65, 23.4, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },
	[12] = { "Primary", Vector( -0.65, -23.4, 1.15 ), Angle( 0, -90, 0 ), Width = 6 },

	[13] = { "Primary", Vector( -2.45, 27.75, 1.15 ), Angle( 0, -46, 0 ), Width = 6.6 },
	[14] = { "Primary", Vector( -2.45, -27.75, 1.15 ), Angle( 0, 180 + 46, 0 ), Width = 6.6 },

	[15] = { "Primary", Vector( -7.14, 30.18, 1.15 ), Angle( 0, -10, 0 ), Width = 7.2 },
	[16] = { "Primary", Vector( -7.14, -30.18, 1.15 ), Angle( 0, 180 + 10, 0 ), Width = 7.2 },

	[17] = { "Primary", Vector( -11.98, 27.22, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[18] = { "Primary", Vector( -11.98, -27.22, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[19] = { "Primary", Vector( -11.98, 22.25, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[20] = { "Primary", Vector( -11.98, -22.25, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[21] = { "Primary", Vector( -11.98, 17.3, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[22] = { "Primary", Vector( -11.98, -17.3, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[23] = { "Primary", Vector( -11.98, 12.39, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[24] = { "Primary", Vector( -11.98, -12.39, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[25] = { "Primary", Vector( -11.98, 7.41, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[26] = { "Primary", Vector( -11.98, -7.41, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[27] = { "Primary", Vector( -11.98, 2.45, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },
	[28] = { "Primary", Vector( -11.98, -2.45, 1.15 ), Angle( 0, 90, 0 ), Width = 6 },

	[29] = { "HotFoot", Vector( 26.6, -3.48, -1.2 ), Angle( 0, 180, 0 ), BoneParent = "valor_44_hotfoot_fwd_left" },
	[30] = { "HotFoot", Vector( -26.6, -3.48, -1.2 ), Angle( 0, 180, 0 ), BoneParent = "valor_44_hotfoot_fwd_right" },

	[31] = { "HotFoot", Vector( 30.05, 5.2, -1.8 ), Angle( 0, -95, 0 ), BoneParent = "valor_44_hotfoot_alley_left", Width = 4.7 --[[oops]] },
	[32] = { "HotFoot", Vector( -30.05, 5.1, -1.8 ), Angle( 0, 180 - 85, 0 ), BoneParent = "valor_44_hotfoot_alley_right", Width = 4.7 },

	-- [3] Vector( 6.968, 6.611, 1.15 ) w=6.2
	-- [5] Vector( 3.922, 10.386, 1.15 ) w=5.9
	-- [7] Vector( 0.87, 14.168, 1.15 ) w=5.9
	-- [3] = { "Primary", move( Vector( 10.39, 2.37, 1.15 ), -ang, -15.16 ), Angle( 0, -ang, 0 ), Width = 5.9 },
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32"

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32",
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