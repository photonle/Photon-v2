if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal", Model = "Schmal"
}

COMPONENT.PrintName = [[Federal Signal Smart Controller Series B]]

COMPONENT.Model = "models/photon_ex/controllers/fedsig_scsb.mdl"

COMPONENT.Templates = {
	["Sub"] = {
		["Indicators"] = {
			States = {
				["WARN1"] = { Material = "photon_ex/fs_scsb/sm_warn1" },
				["WARN2"] = { Material = "photon_ex/fs_scsb/sm_warn2" },
				["WARN3"] = { Material = "photon_ex/fs_scsb/sm_warn3" },
				["WARN4"] = { Material = "photon_ex/fs_scsb/sm_warn4" },
				["LEFT"] = { Material = "photon_ex/fs_scsb/sm_left" },
				["RIGHT"] = { Material = "photon_ex/fs_scsb/sm_right" },
				["CENOUT"] = { Material = "photon_ex/fs_scsb/sm_co" },
			}
		},
		["Button"] = {
			States = {
				["ON"] = { Material = "photon_ex/fs_scsb/button_on" },
			}
		},
		["Stage"] = {
			States = {
				["STAGE1"] = { Material = "photon_ex/fs_scsb/led_stage1_on" },
				["STAGE2"] = { Material = "photon_ex/fs_scsb/led_stage2_on" },
				["STAGE3"] = { Material = "photon_ex/fs_scsb/led_stage3_on" },
			}
		}
	},
	["Sequence"] = {
		["Sequence"] = {
			States = {
				["STAGE1"] = { Sequence = "stage_1" },
				["STAGE2"] = { Sequence = "stage_2" },
				["STAGE3"] = { Sequence = "stage_3" },
			}
		}
	}
}

COMPONENT.ColorMap = "[ON] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 [STAGE1] 19 [STAGE2] 20 [STAGE3] 21"

COMPONENT.Elements = {
	[1] = { "Button", Indexes = { 11 } },
	[18] = { "Indicators", Indexes = { 2 } },
	[19] = { "Stage", Indexes = { 3 } },
	[20] = { "Stage", Indexes = { 4 } },
	[21] = { "Stage", Indexes = { 5 } },
	[22] = { "Sequence" },
}

COMPONENT.Segments = {
	BTN1 = { Frames = { [1] = "1" }, Sequences = { ON = { 1 } } },
	Indicators = {
		Frames = {
			[1] = "18:WARN1",
			[2] = "18:WARN2",
			[3] = "18:WARN3",
			[4] = "18:WARN4",
			[5] = "18:LEFT",
			[6] = "18:RIGHT",
			[7] = "18:CENOUT",
		},
		Sequences = {
			WARN1 = { 1 },
			WARN2 = { 2 },
			WARN3 = { 3 },
			WARN4 = { 4 },
			LEFT = { 5 },
			CENOUT = { 6 },
			RIGHT = { 7 },
		}
	},
	STG1 = { Frames = { [1] = "19" }, Sequences = { ON = { 1 } } },
	STG2 = { Frames = { [1] = "20" }, Sequences = { ON = { 1 } } },
	STG3 = { Frames = { [1] = "21" }, Sequences = { ON = { 1 } } },
	SlideSwitch = {
		Frames = {
			[1] = "22:STAGE1",
			[2] = "22:STAGE2",
			[3] = "22:STAGE3",
		},
		Sequences = {
			STAGE1 = { 1 },
			STAGE2 = { 2 },
			STAGE3 = { 3 },
		}
	}
}

-- Automatically generates elements and segments for buttons 2-17

for i=2, 17 do
	COMPONENT.Elements[i] = { "Button", Indexes = { 10 + i } }
	COMPONENT.Segments["BTN" .. i] = {
		Frames = { [1] = tostring( i ) },
		Sequences = { ON = { 1 } }
	}
end

COMPONENT.Inputs = {
	["Emergency.Directional"] = {
		["LEFT"] = {
			BTN1 = "ON",
			Indicators = "LEFT"
		},
		["RIGHT"] = {
			BTN1 = "ON",
			Indicators = "RIGHT"
		},
		["CENOUT"] = {
			BTN1 = "ON",
			Indicators = "CENOUT"
		}
	},
	["Emergency.Siren"] = {
		["T1"] = { BTN8 = "ON" },
		["T2"] = { BTN9 = "ON" },
		["T3"] = { BTN10 = "ON" },
		["T4"] = { BTN7 = "ON" },
	},
	["Emergency.SirenOverride"] = {
		["MAN"] = { BTN11 = "ON" },
		["AIR"] = { BTN12 = "ON" },
	},
	["Emergency.Marker"] = {
		["ON"] = { BTN6 = "ON" }
	},
	["Emergency.SceneForward"] = {
		["ON"] = { BTN14 = "ON" },
		["FLOOD"] = { BTN16 = "ON" }
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { BTN13 = "ON" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { BTN15 = "ON" }
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			SlideSwitch = "STAGE1",
			Indicators = "WARN1",
			STG1 = "ON"
		},
		["MODE2"] = {
			SlideSwitch = "STAGE2",
			Indicators = "WARN2",
			STG1 = "ON",
			STG2 = "ON"
		},
		["MODE3"] = {
			SlideSwitch = "STAGE3",
			Indicators = "WARN4",
			STG1 = "ON",
			STG2 = "ON",
			STG3 = "ON",
		}
	}
}