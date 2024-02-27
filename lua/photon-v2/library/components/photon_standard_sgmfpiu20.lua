if (Photon2.ReloadComponentFile()) then return end
---@class PhotonStandardSGMFPIU20 : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B"
}

COMPONENT.Title = "2020 Ford Police Interceptor Utility"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["2D"] = {
		Reverse = {
			Width = 5.4,
			Height = 5.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_detail.png").MaterialName,
			Scale = 2,
			ForwardBloomOffset = 0.5
		},
		Turn = {
			Width = 6.3,
			Height = 6.3,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rsig_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rsig_detail.png").MaterialName,
			Scale = 1,
			ForwardBloomOffset = 0.3
		},
		Headlight = {
			Width = 6.8,
			Height = 3.4,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_detail.png").MaterialName,
			Scale = 0.75,
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
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_detail.png").MaterialName,
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
					DrawColor = PhotonColor( 255, 116, 0 ),
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
	["Sub"] = { HIDE = { Material = "photon/common/blank" } },
	["2D"] = {
		["A0.5"] = {
			Inherit = "A",
			Intensity = 0.8
		},
	},
	["Mesh"] = {
		["A0.5"] = {
			Inherit = "A",
			Intensity = 0.7
		}
	}
}


COMPONENT.ElementGroups = {
	["HeadL"] = { 1, 3 },
	["HeadR"] = { 2, 4 },
	
	["HighL"] = { 5, 7 },
	["HighR"] = { 6, 8 },
	
	["SigFL"] = { 9, 11 },
	["SigFR"] = { 10, 12 },
	
	["SigRL"] = { 13 },
	["SigRR"] = { 14 },
	
	["RevL"] = { 15 },
	["RevR"] = { 16 },
	["Reverse"] = { 15, 16 },
	
	["TailL"] = { 17, 19 },
	["TailR"] = { 18, 20 },
	
	["BrakeC"] = { 21 },
	["Brake"] = { 17, 18, 19, 20, 21 }
}

COMPONENT.StateMap = "[DIM] TailL TailR [W] HeadL HeadR HighL HighR [W/1/2] RevL [W/2/1] RevR [R] 21 [A] SigFL SigFR [A/1/2] SigRL [A/2/1] SigRR"

COMPONENT.Elements = {	
	-- Headlights
	[1] = { "Headlight", Vector( -36.4, 99.5, 49.2), Angle( 0, 0, 0 ) }, -- high-beam upper
	[2] = { "Headlight", Vector( 36.4, 99.5, 49.2 ), Angle( 0, 0, 0 ) }, -- high-beam upper

	[3] = { "Headlight", Vector( -36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower
	[4] = { "Headlight", Vector( 36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower

	-- Highbeams
	[5] = { "Headlight", Vector( -28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Persist = true, Scale = 1 }, -- headlight upper
	[6] = { "Headlight", Vector( 28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Scale = 1 }, -- headlight upper

	[7] = { "Headlight", Vector( -28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 }, -- headlight lower
	[8] = { "Headlight", Vector( 28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 },-- headlight lower

	-- Signal Forward
	[9] = { "MeshExtra", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl" },
	[10] = { "MeshExtra", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr" },

	-- Marker Forward
	[11] = { "ForwardMarker", Vector( -43.4, 92.8, 49.3), Angle( -20, 72, 6 ) },
	[12] = { "ForwardMarker", Vector( 43.4, 92.8, 49.3), Angle( 180+20, 180-72, -6 ) },

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
	[21] = { "MeshExtra", Vector( 0, 1.1, -1 ), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", Scale = 1.012 }
}

local sequence = Photon2.SequenceBuilder.New

-- Special component attributes
COMPONENT.Flags = {
	AutomaticHeadlights = true
}
COMPONENT.Segments = {
	Headlights = {
		Frames = {
			[1] = "HeadL HeadR TailL TailR [A0.5] SigFL SigFR",
			[2] = "HeadL HeadR HighL HighR TailL TailR [A0.5] SigFL SigFR",
			[3] = "TailL TailR [A0.5] SigFL SigFR"
		},
		Sequences = {
			["HEADLIGHTS"] = { 1 },
			["HIGH"] = { 2 },
			["PARK"] = { 3 }
		}
	},
	Brake = {
		Frames = {
			[1] = "[BRIGHT] TailL TailR [R] BrakeC"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	Reverse = {
		Frames = {
			[1] = "Reverse",
			[2] = "[2] Reverse"
		},
		Sequences = {
			ON = { 1 },
			CRUISE = { 2 }
		}
	},
	RearSignalL = {
		Frames = {
			[0] = "[PASS] SigRL",
			[1] = "SigRL",
			[2] = "[2] SigRL",
			[3] = "[3] SigRL",
			[4] = "[W] SigRL",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 1, 0, 8 ),
			CRUISE = { 2 }
		}
	},
	RearSignalR = {
		Frames = {
			[0] = "[PASS] SigRR",
			[1] = "SigRR",
			[2] = "[2] SigRR",
			[3] = "[3] SigRR",
			[4] = "[W] SigRR",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 1, 0, 8 ),
			CRUISE = { 2 }
		}
	},
	ForwardSignalL = {
		Frames = {
			[0] = "[PASS] SigFL",
			[1] = "SigFL",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 1, 0, 8 )
		}
	},
	ForwardSignalR = {
		Frames = {
			[0] = "[PASS] SigFR",
			[1] = "SigFR",
		},
		Sequences = {
			SIGNAL = sequence():Alternate( 1, 0, 8 )
		}
	},
	HeadlightL = {
		Frames = {
			-- Use PASS so the the headlight won't turn off
			-- if the vehicle's headlights are already on.
			[0] = "[PASS] HeadL",
			[1] = "HeadL"
		},
		Sequences = {
			PASS = { 0 },
			WIGWAG = sequence():Alternate( 1, 0, 8, 2 ),
			ON = { 1 }
		}
	},
	HeadlightR = {
		Frames = {
			-- Use PASS so the the headlight won't turn off
			-- if the vehicle's headlights are already on.
			[0] = "[PASS] HeadR",
			[1] = "HeadR"
		},
		Sequences = {
			PASS = { 0 },
			WIGWAG = sequence():Alternate( 0, 1, 8, 2 ),
			ON = { 1 }
		}
	},
	HighBeamL = {
		Frames = {
			[0] = "[PASS] HighL",
			[1] = "HighL"
		},
		Sequences = {
			PASS = { 0 },
			WIGWAG = sequence():Alternate( 1, 0, 8, 2 ),
			ON = { 1 }
		}
	},
	HighBeamR = {
		Frames = {
			[0] = "[PASS] HighR",
			[1] = "HighR"
		},
		Sequences = {
			PASS = { 0 },
			WIGWAG = sequence():Alternate( 0, 1, 8, 2 ),
			ON = { 1 }
		}
	},
	ReverseFlasher = {
		-- RevL and RevR and element groups defined in photon_standard_sgmfpiu20
		Frames = {
			[1] = "[2] RevL",
			[2] = "[2] RevR",
			[3] = "[2] RevL [W] RevR",
			[4] = "[W] RevL [2] RevR",
		},
		Sequences = {
			-- Slow left-right pattern (10 frames per side)
			["MODE1"] = sequence():Add( 1 ):Do( 10 ):Add( 2 ):Do( 10 ),
			["MODE2"] = sequence():FlashHold( 2, 1, 5 ):FlashHold( 1, 1, 5 ),
			["MODE3"] = sequence():FlashHold( 3, 2, 3 ):FlashHold( 4, 2, 3 )
		}
	}
}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Headlights = "HEADLIGHTS"
		},
		["PARKING"] = {
			Headlights = "PARK"
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Brake = "ON"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			RearSignalL = "SIGNAL",
			ForwardSignalL = "SIGNAL",
		},
		["RIGHT"] = {
			RearSignalR = "SIGNAL",
			ForwardSignalR = "SIGNAL",
		},
		["HAZARD"] = {
			ForwardSignalR = "SIGNAL",
			ForwardSignalL = "SIGNAL",
			RearSignalL = "SIGNAL",
			RearSignalR = "SIGNAL",
		}
	},
	["Emergency.Warning"] = {
		["MODE2"] = {
			HighBeamL = "PASS",
			HighBeamR = "PASS",
			HeadlightL = "PASS",
			HeadlightR = "PASS",
		},
		["MODE3"] = {
			HighBeamL = "WIGWAG",
			HighBeamR = "WIGWAG",
			HeadlightL = "WIGWAG",
			HeadlightR = "WIGWAG",
		}
	},
	["Emergency.SceneForward"] = {
		["FLOOD"] = {
			HighBeamL = "ON",
			HighBeamR = "ON",
			HeadlightL = "ON",
			HeadlightR = "ON",
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Reverse = "CRUISE"
		}
	}
}