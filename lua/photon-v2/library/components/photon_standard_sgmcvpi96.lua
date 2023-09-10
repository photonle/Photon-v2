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
			Model = "models/sentry/96cvpi.mdl",
			Scale = 0.9
		}
	},
	["2D"] = {
		["Tail"] = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/bulb_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/bulb_detail.png").MaterialName,
			Scale = 1,
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

	[11] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/headlight_l", 7 }, DrawMaterial = "photon/common/glow" },
	[12] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/headlight_r", 7 }, DrawMaterial = "photon/common/glow" },

	[13] = { "Model", Vector(0, 0.1, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/marker_l", 7 }, DrawMaterial = "photon/common/glow" },
	[14] = { "Model", Vector(0, 0.1, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/marker_r", 7 }, DrawMaterial = "photon/common/glow" },

	[15] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/turnsig_l", 7 }, DrawMaterial = "photon/common/glow" },
	[16] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/turnsig_r", 7 }, DrawMaterial = "photon/common/glow" },

	[17] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/taillight_l", 7 }, DrawMaterial = "photon/common/glow" },
	[18] = { "Model", Vector(0, 0, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/taillight_r", 7 }, DrawMaterial = "photon/common/glow" },

	[19] = { "Model", Vector(0, -0.1, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/reverse_l", 7 }, DrawMaterial = "photon/common/glow" },
	[20] = { "Model", Vector(0, -0.1, 0), Angle( 0, 90, 0 ), { "sentry/96cvpi/reverse_r", 7 }, DrawMaterial = "photon/common/glow" },

	[21] = { "Tail", Vector( -30, -126, 35 ), Angle( 0, 180, 0 ) }
	
}

COMPONENT.ColorMap = "[Glow] 1 2 7 8 9 10 [Amber] 3 4 5 6 [R] 17 18 21 [SW] 11 12 19 20 [A] 13 14 15 16"

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
			[1] = "17"
		},
		Sequences = {
			ON = { 1 }
		}
	},
	["Tail_R"] = {
		Frames = {
			[1] = "18"
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
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["ON"] = {
			Headlights = "ON",
			Tail_L = "ON",
			Tail_R = "ON",
			Marker_L = "ON",
			Marker_R = "ON"
			-- Signal_L = "ON",
			-- Signal_R = "ON",
		}
	}
}