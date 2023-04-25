if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2020 Ford Police Interceptor Utility"

COMPONENT.IsVirtual = true

COMPONENT.Lighting = {
	["2D"] = {
		TailLights = {
			Width = 8,
			Height = 8,
			Material 			= "sprites/emv/legend_wide",
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0)
		}
	}
}

COMPONENT.Lights = {
	[1] = { "TailLights", Vector( 0, 0, 100 ), Angle( 0, 0, 0 ) }
}

COMPONENT.ColorMap = "[R] 1"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	TailLights = {
		Frames = {
			[1] = "1"
		},
		Sequences = {
			["ON"] = sequence():Add( 1 )
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			TailLights = "ON"
		}
	}
}