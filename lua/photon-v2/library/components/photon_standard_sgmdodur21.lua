if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2021 Dodge Durango (PPV)"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {
	["Sub"] = {
		SubMaterial = {}
	},
	["Mesh"] = {
		["Model"] = {
			Model = "models/sentry/21durango.mdl"
		}
	}
}

COMPONENT.ElementStates = {
	["Sub"] = {
		["OFF"] = { Material = nil },
		["DRL"] = {
			Material = "sentry/21durango/lights_on"
			-- Material = "photon/common/glow"
		},
		["Tail_Red"] = {
			Material = "sentry/21durango/lights_on"
		},
		["On"] = {
			Material = "sentry/21durango/lights_on"
		},
		["Ridges_White"] = {
			Material = "sentry/21durango/lights_ridges_white_on"
		},
		["Ridges_Red"] = {
			Material = "sentry/21durango/lights_ridges_on"

		}
	}
}

COMPONENT.Elements = {
	[1] = { "SubMaterial", Indexes = { 12 } }, -- DRL R
	[2] = { "SubMaterial", Indexes = { 13 } }, -- DRL L
	
	[3] = { "SubMaterial", Indexes = { 4 } }, -- Brake R
	[4] = { "SubMaterial", Indexes = { 5 } }, -- Brake L
	
	[5] = { "SubMaterial", Indexes = { 7 } }, -- Reverse L
	[6] = { "SubMaterial", Indexes = { 6 } }, -- Reverse R
	
	[7] = { "SubMaterial", Indexes = { 8 } }, -- Tail L
	[8] = { "SubMaterial", Indexes = { 11 } }, -- Tail R
	
	[9] = { "SubMaterial", Indexes = { 9 } }, -- Tail Center Top
	[10] = { "SubMaterial", Indexes = { 10 } }, -- Tail Center Bottom

	[11] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_ct", DrawMaterial = "sentry/21durango/lights_on" },
	[12] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_cb", DrawMaterial = "sentry/21durango/lights_on" },
	
	[13] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_l", DrawMaterial = "sentry/21durango/lights_on" },
	[14] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/tail_r", DrawMaterial = "sentry/21durango/lights_on" },
	
	[15] = { "Model", Vector( 0, .1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/drl_l", DrawMaterial = "sentry/21durango/lights_on" },
	[16] = { "Model", Vector( 0, .1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/drl_r", DrawMaterial = "sentry/21durango/lights_on" },

	[17] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/reverse_l", DrawMaterial = "sentry/21durango/lights_ridges_white_on" },
	[18] = { "Model", Vector( 0, -.1, 0 ), Angle( 0, 90, 0 ), "sentry/21durango/reverse_r", DrawMaterial = "sentry/21durango/lights_ridges_white_on" },

}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	DRL_R = {
		 Frames = {
			[1] = "1:DRL 16:W"
		 },
		 Sequences = {
			["ON"] =  sequence():Alternate( 0, 1, 8 )
		 }
	},
	DRL_L = {
		Frames = {
			[1] = "2:DRL 15:W"
		 },
		 Sequences = {
			["ON"]  = sequence():Alternate( 1, 0, 8 )
		 }
	},
	Brake_R = {
		Frames = {
			[1] = "3:Ridges_Red"
		 },
		 Sequences = {
			["ON"] = { 1, 1, 1, 1, 0, 0, 0, 0 }
		 }
	},
	Brake_L = {
		Frames = {
			[1] = "4:Ridges_Red"
		 },
		 Sequences = {
			["ON"] = { 1 }
		 }
	},
	Tail_L = {
		Frames = {
			[1] = "7:Tail_Red 13:R"
		 },
		 Sequences = {
			["ON"] = sequence():Alternate( 0, 1, 8 )
		 }
	},
	Tail_R = {
		Frames = {
			[1] = "8:Tail_Red 14:R"
		 },
		 Sequences = {
			["ON"]  = sequence():Alternate( 0, 1, 8 )
		 }
	},
	Tail_Center = {
		Frames = {
			[1] = "9:Tail_Red 10:Tail_Red 11:R 12:R"
		 },
		 Sequences = {
			["ON"] = sequence():Alternate( 0, 1, 8 )
		 }
	},
	Reverse_L = {
		Frames = {
			[1] = "5:Ridges_White 17:W"
		 },
		 Sequences = {
			["ON"]  = { 1 }
		 }
	},
	Reverse_R = {
		Frames = {
			[1] = "6:Ridges_White 18:W"
		 },
		 Sequences = {
			["ON"] = { 1 }
		 }
	},
}

COMPONENT.Inputs = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			["DRL_R"] = "ON",
			["DRL_L"] = "ON",
			["Tail_L"] = "ON",
			["Tail_R"] = "ON",
			["Tail_Center"] = "ON",
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			-- ["Brake_R"] = "ON",
			-- ["Brake_L"] = "ON",
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			["Reverse_L"] = "ON",
			["Reverse_R"] = "ON"
		}
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			["DRL_R"] = "ON",
			["DRL_L"] = "ON",
			["Tail_L"] = "ON",
			["Tail_R"] = "ON",
			["Tail_Center"] = "ON",
		}
	}
}