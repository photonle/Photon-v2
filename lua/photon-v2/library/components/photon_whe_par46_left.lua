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
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_par46_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_par46_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_par46_bloom.png").MaterialName,
			Width = 7.6,
			Height = 7.6,
			Scale = 2
		}
	},
	["Projected"] = {
		Projected = {

		}
	}
}

COMPONENT.Lights = {
	[1] = { "Light", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	-- [1] = { "Light", Vector( -5.35, 8, 4.445 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[2] = { "Projected", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 }
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
			-- ["R"] = { 2 },
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Illuminate"] = {
		["SPOT"] = {
			Light = "FLASH"
		}
	}
}