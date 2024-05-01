if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Base = "photon_whe_par46_left"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = [[PAR46 Spotlight (Left)]]
COMPONENT.Category = "Spotlight"
COMPONENT.Model = "models/sentry/props/spotlight_left_up.mdl"

COMPONENT.States = {
	[1] = "~SW"
}

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Width = 7.6,
			Height = 7.6,
			Scale = 2,
			IntensityGainFactor = 8,
			IntensityLossFactor = 2,
			DeactivationState = "~OFF",
			Intensity = 0,
			States = {
				["~SW"] = {
					Inherit = "SW",
					IntensityTransitions = true,
				},
				["~HR"] = {
					Inherit = "HR",
					IntensityTransitions = true,
				}
			}
		}
	},
	["Projected"] = {
		Projected = {
			States = {
				["~SW"] = {
					Inherit = "SW",
					IntensityTransitions = true,
				},
				["~HR"] = {
					Inherit = "R",
					IntensityTransitions = true,
				}
			}
		}
	}
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Flasher = {
		Frames = {
			[0] = "[~OFF] 1",
			[1] = "1",
		},
		Sequences = {
			["FLASH"] = sequence():Alternate( 1, 0, 12 ),
		}
	}
}