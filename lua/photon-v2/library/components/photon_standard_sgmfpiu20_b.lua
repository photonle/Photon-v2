if (Photon2.ReloadComponentFile()) then return end
---@class PhotonStandardSGMFPIU20 : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2020 Ford Police Interceptor Utility"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["2D"] = {
		Reverse = {
			Width = 5.4,
			Height = 5.4,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_detail.png").MaterialName,
			Scale = 2,
			ForwardBloomOffset = 0.5
		},
		Turn = {
			Width = 6.3,
			Height = 6.3,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rsig_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rsig_detail.png").MaterialName,
			Scale = 2,
			ForwardBloomOffset = 0.3
		},
		Headlight = {
			Width = 6.8,
			Height = 3.4,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_detail.png").MaterialName,
			Scale = 0.5,
			LightMatrix = {
				Vector( 1 * 1, 0, 0 ), Vector( -1 * 1, 0, 0 ), 
			},
			ForwardVisibilityOffset = -1,
			ForwardBloomOffset = 0.5,
			Persist = true
		},
		ForwardMarker = {
			Width = 3.2,
			Height = 3.2,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_detail.png").MaterialName,
			Scale = 0.4,
			LightMatrix = {
				Vector( .9, 0, 0 ), Vector( -.9, 0, 0 )
			}
		},
	},
	["Mesh"] = {
		Model = {
			Model = "models/sentry/20fpiu_new.mdl",
			States = {
				["BRIGHT"] = {
					DrawColor = PhotonColor( 255, 180, 0 ),
					BloomColor = PhotonColor( 512, 0, 0 ),
					-- Material = "photon/common/blank",
					DrawMaterial = "photon/common/glow",
				},
				["DIM"] = {
					DrawColor = PhotonColor( 180, 255, 0 ),
					BloomColor = PhotonColor( 96, 0, 0 )
				}
			}
		},
		MeshExtra = {
			Model = "models/schmal/sgmfpiu20_lights.mdl"
		}
	},
	["Sub"] = {
		TailSubMaterial = {
			States = {
				["BRIGHT"] = { Material = "photon/common/blank" },
				["DIM"] = { Material = "photon/common/blank" }
			}
		}
	},
}

COMPONENT.ElementStates = {
	["Sub"] = { HIDE = { Material = "photon/common/blank" } }
}

COMPONENT.LightGroups = {
	["HeadL"] = { 1, 3 },
	["HeadR"] = { 2, 4 },

	["HighL"] = { 5, 6 },
	["HighR"] = { 7, 8 },

	["SigFL"] = { 9, 11 },
	["SigFR"] = { 10, 12 },

	["SigRL"] = { 13 },
	["SigRR"] = { 14 },

	["RevL"] = { 15 },
	["RevR"] = { 16 },

	["TailL"] = { 17, 19 },
	["TailR"] = { 18, 20 },

	["BrakeC"] = { 21 }
}

COMPONENT.Elements = {
	-- Headlights
	[1] = { "Headlight", Vector( -28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Persist = true, Scale = 1 }, -- headlight upper
	[2] = { "Headlight", Vector( 28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Scale = 1 }, -- headlight upper

	[3] = { "Headlight", Vector( -28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 }, -- headlight lower
	[4] = { "Headlight", Vector( 28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 },-- headlight lower
	
	-- Highbeams
	[5] = { "Headlight", Vector( -36.4, 99.5, 49.2), Angle( 0, 0, 0 ) }, -- high-beam upper
	[6] = { "Headlight", Vector( 36.4, 99.5, 49.2 ), Angle( 0, 0, 0 ) }, -- high-beam upper

	[7] = { "Headlight", Vector( -36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower
	[8] = { "Headlight", Vector( 36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower

	-- Signal Forward
	[9] = { "MeshExtra", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl" },
	[10] = { "MeshExtra", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr" },

	-- Marker Forward
	[11] = { "Marker", Vector( -43.4, 92.8, 49.3), Angle( -20, 72, 6 ) },
	[12] = { "Marker", Vector( 43.4, 92.8, 49.3), Angle( 180+20, 180-72, -6 ) },

	-- Signal Rear
	[13] = { "Turn", Vector( -36.4, -122.6, 52.4 ), Angle( 0, 180-22.5, 0 ) },
	[14] = { "Turn", Vector( 36.4, -122.6, 52.4 ), Angle( 0, 180+22.5, 0 ), FlipHorizontal = true },

	-- Reverse
	[15] = { "Reverse", Vector( -36.4, -122.9, 47.9 ), Angle( 0, 180-22.5, 0 ) },
	[16] = { "Reverse", Vector( 36.4, -122.9, 47.9 ), Angle( 0, 180+22.5, 0 ), FlipHorizontal = true },

	-- Tail
	[17] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 90, 0 ), "sentry/20fpiu_new/tail_l", DrawMaterial = "photon/materials/sgm_fpiu20_tail_bright" },
	[18] = { "Model", Vector( 0, 0, 0 ), Angle( 0, 90, 0 ), "sentry/20fpiu_new/tail_r", DrawMaterial = "photon/materials/sgm_fpiu20_tail_bright" },

	-- Tail Sub-Materials
	[19] = { "TailSubMaterial", Indexes = { 17 } },
	[20] = { "TailSubMaterial", Indexes = { 19 } },

	-- Center Brake
	[21] = { "MeshExtra", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc" }
}