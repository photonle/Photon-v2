if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Title = "Whelen PAR46 LED Spotlight (Right)"
COMPONENT.Base = "photon_whe_par46_left"
COMPONENT.Category = "Spotlight"
COMPONENT.Model = "models/sentry/props/spotlightpar46_right_up.mdl"

-- Most other properties are set in the par46_left file. The ones here
-- are just the differences to override the base.

COMPONENT.Templates = {
	["Bone"] = {
		Shaft = {
			States = {
				-- Speed is intentionally slower because it looks too artificial if
				-- both left and right sides move identically.
				["DOWN"] = { Activity = "Fixed", Target = 80, Speed = 75, DeactivateOnTarget = true, Direction = 1 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = 300, Direction = -1 }
			},
		},
		Lamp = {
			States = {
				["DOWN"] = { Activity = "Fixed", Target = 270, Speed = 200, DeactivateOnTarget = true, Direction = 0 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = 300, Direction = 0 },
			},
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.SceneForward"] = {
		["ON"] = {}, -- Off for normal takedown
	},
	["Emergency.SceneLeft"] = {
		["ON"] = {}
	},
	["Emergency.SceneRight"] = {
		["ON"] = {
			Light = "DELAY",
			Lamp = "RIGHT"
		}
	}
}