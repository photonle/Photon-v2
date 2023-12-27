if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

-- photon_s[ound]o[ff]s[ignal]_mp[ower]f[ascia]4[inch]lic[ense plate]_h[orizontal]
COMPONENT.PrintName = [[Whelen PAR26 LED Spotlight"]]

COMPONENT.Model = "models/sentry/props/spotlightpar46_left_up.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_par46_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_par46_detail.png").MaterialName,
			Width = 7.6,
			Height = 7.6,
			Scale = 2
		}
	},
	["Projected"] = {
		Projected = {

		}
	},
	["Bone"] = {
		LightHead = {}
	}
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[2] = { "Projected", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[3] = { "LightHead", BoneId = 4, Axis = 'y' },
	[4] = { "LightHead", BoneId = 1, Axis = 'p' }
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1:W 2:W",
			[2] = "1:R 2:R",
			[3] = "1:B 2:B",
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = { 1, 1, 1, 0, 0, 0, 2, 2, 2, 0, 0, 0, 3, 3, 3, 0, 0, 0 },
		}
	},
	Rotating = {
		Frames = {
			[1] = "3:ROT 4:ROT"
		},
		Sequences = {
			["ROTATE"] = { 1 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Illuminate"] = {
		["SPOT"] = {
			Light = "ON",
			-- Rotating = "ROTATE"
		}
	}
}