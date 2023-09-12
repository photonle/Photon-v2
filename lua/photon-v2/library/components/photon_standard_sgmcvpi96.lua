if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "1996 Ford Crown Victoria"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["Sub"] = {
		SubMaterial = {}
	},
	["Mesh"] = {
		["Model"] = {
			Model = "models/schmal/sgmcvpi96_lights.mdl",
			Scale = 1
		}
	},
	["2D"] = {
		["Tail"] = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Scale = 1,
			Width = 1.5,
			Height = 1.5
		}
	}
}

COMPONENT.LightStates = {
	["Sub"] = {
		-- ["Glow"] = { Material = "sentry/96cvpi/glow_on" },
		-- ["Amber"] = { Material = "sentry/96cvpi/glow_on_orange" },
		["Glow"] = { Material = "photon/common/blank" }, ["Amber"] = { Material = "photon/common/blank" }
	}
}

COMPONENT.LightGroups = {

}

COMPONENT.Lights = {
	[1] = { "SubMaterial", Indexes = { 15 } }, -- Headlight L
	[2] = { "SubMaterial", Indexes = { 17 } }, -- Headlight R
	
	[3] = { "SubMaterial", Indexes = { 12 } }, -- Marker L
	[4] = { "SubMaterial", Indexes = { 14 } }, -- Marker R

	[5] = { "SubMaterial", Indexes = { 16 } }, -- Turn L
	[6] = { "SubMaterial", Indexes = { 18 } }, -- Turn R

	[7] = { "SubMaterial", Indexes = { 26 } }, -- Tail L
	[8] = { "SubMaterial", Indexes = { 27 } }, -- Tail R

	[9] = { "SubMaterial", Indexes = { 21 } }, -- Reverse L
	[10] = { "SubMaterial", Indexes = { 20 } }, -- Reverse R

	[11] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[12] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/hdl_fr", DrawMaterial = "photon/common/glow_gradient_a" },

	[13] = { "Model", Vector(0, 0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[14] = { "Model", Vector(0, 0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow_gradient_a" },

	[15] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fl", DrawMaterial = "photon/common/glow_gradient_a" },
	[16] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_fr", DrawMaterial = "photon/common/glow_gradient_a" },

	[17] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[18] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rr", DrawMaterial = "photon/common/glow_gradient_a" },

	[19] = { "Model", Vector(0, -0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/rev_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[20] = { "Model", Vector(0, -0.1, 0), Angle( 0, 0, 0 ), "photon/vehicle/rev_rr", DrawMaterial = "photon/common/glow_gradient_a" },

	[21] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_rl", DrawMaterial = "photon/common/glow_gradient_a" },
	[22] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/sig_rr", DrawMaterial = "photon/common/glow_gradient_a" },
	
	[23] = { "Model", Vector(0, 0, 0), Angle( 0, 0, 0 ), "photon/vehicle/bra_rc", DrawMaterial = "photon/common/glow_gradient_a" },
	
}

COMPONENT.ColorMap = "[Glow] 1 2 7 8 9 10 [Amber] 3 4 5 6 [R] 17 18 21 22 23 [SW] 11 12 19 20 [A] 13 14 15 16"

COMPONENT.Segments = {
	["All"] = {
		Frames = {
			[1] = "7 8 17 18"
			-- [1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Headlights"] = {
		Frames = {
			[1] = "1 2 11 12"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Marker_L"] = {
		Frames = {
			[1] = "13"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Marker_R"] = {
		Frames = {
			[1] = "14"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Tail_L"] = {
		Frames = {
			[1] = "17 21"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Tail_R"] = {
		Frames = {
			[1] = "18 22"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Signal_L"] = {
		Frames = {
			[1] = "15"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Signal_R"] = {
		Frames = {
			[1] = "16"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Reverse_L"] = {
		Frames = {
			[1] = "19"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Reverse_R"] = {
		Frames = {
			[1] = "20"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Brake"] = {
		Frames = {
			[1] = "23"
		},
		Sequences = {
			ON = { 1 }
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["ON"] = {
			Headlights = "ON",
			Tail_L = "ON",
			Tail_R = "ON",
			Marker_L = "ON",
			Marker_R = "ON",
			Brake = "ON"
			-- Signal_L = "ON",
			-- Signal_R = "ON",
		}
	}
}