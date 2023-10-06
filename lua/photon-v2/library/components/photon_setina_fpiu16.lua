if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "Mighty, Schmal, et. al",
}

COMPONENT.PrintName = [[Setina Push Bumper - 2016 Ford Police Utility]]

COMPONENT.Model = "models/schmal/fpiu16_setina.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Impaxx = {
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5.7,
			Height = 5.7/2,
		}
	}
}

COMPONENT.Lights = {
	[1] = { "Impaxx", Vector( 10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },
	[2] = { "Impaxx", Vector( -10.8, 1.3, 17.13 ), Angle( 0, 180, 0 ) },

	[3] = { "Impaxx", Vector( 22.31, -0.25, 9.95 ), Angle( 0, -90, 90 ) },
	[4] = { "Impaxx", Vector( -22.31, -0.25, 9.95 ), Angle( 0, 90, 90 ) },
}

COMPONENT.ColorMap = "[R] 1 3 [B] 2 4"

COMPONENT.LightStates = {}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Upper = {
		Frames = {
			[1] = "[R] 1",
			[2] = "[B] 2",
			[3] = "[W] 1",
			[4] = "[W] 2",
		},
		Sequences = {
			ALL = { 1 },
			FLASH = sequence()
					:Blink( 1, 4 ):Hold( 2 )
					:Blink( 2, 4 ):Hold( 2 )
					:Blink( 3, 4 ):Hold( 2 )
					:Blink( 4, 4 ):Hold( 2 )
			-- FLASH = sequence():Alternate( 1, 2, 8 ):Alternate( 3, 4, 8 )
		}
	},
	Side = {
		Frames = {
			[1] = "[R] 3 4",
			[2] = "[B] 3 4",
		},
		Sequences = {
			FLASH = sequence()
			:TripleFlash( 1, 0 ):Hold( 3 ):Add( 0 ):Hold( 5 )
			:TripleFlash( 2, 0 ):Hold( 3 ):Add( 0 ):Hold( 5 )
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE2"] = { Upper = "FLASH", Side = "FLASH" },
		["MODE3"] = { Upper = "FLASH", Side = "FLASH" },
	}
}