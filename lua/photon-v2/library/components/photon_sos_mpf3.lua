if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "anemolis72"
}

COMPONENT.PrintName = [[SoundOff Signal mpower Fascia 3"]]

COMPONENT.Model = "models/sentry/props/soundofffascia_small.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

local s = 1.6

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf3_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpf3_detail.png").MaterialName,
			Width = 6,
			Height = 6,
			Ratio = 1,
			Scale = 1.4,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
		}
	}
}

COMPONENT.StateMap = "[1/2/3] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector(0.5, 0, 0), Angle(0, -90, 0) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "[1] 1",
			[2] = "[2] 1",
			[3] = "[3] 1",
			[4] = "[W] 1",
			[5] = "[R] 1"
			-- [1] = { { 1, 4 } },
		},
		Sequences = {
			["TEST"] = { 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
				2, 2, 2, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
				3, 3, 0, 3, 3, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0,
			},
			["MODE3"] = sequence():Alternate( 1, 2, 8 ),
			["MODE3:A"] = { 1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0 },
			["MODE3:B"] = { 0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0 },
			["W"] = { 4 },
			["R"] = { 5 },
			["1"] = { 1 },
			["2"] = { 2 },
			["3"] = { 3 },

		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "MODE3"
		},
		["MODE2"] = {
			Light = "MODE3"
		},
		["MODE3"] = {
			Light = "MODE3"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "1"
		}
	}
}