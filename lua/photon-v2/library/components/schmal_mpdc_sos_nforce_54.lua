if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[[MPDC] SoundOff Signal nForce (54")]]

COMPONENT.Base = "photon_sos_nforce_54"

local sequence = Photon2.SequenceBuilder.New


COMPONENT.SubMaterials = {
	[3] = "!photon_material/ph2_sos_nforce_dome_red",
	[4] = "!photon_material/ph2_sos_nforce_dome_blu",
	[8] = "!photon_material/ph2_sos_nforce_dome_blk"
}

COMPONENT.ElementGroups = {
	MP_A = { 1, 26 },
	MP_B = { 3, 2, 24, 25 },
	MP_C = { 5, 4, 22, 23 },
	MP_D = { 7, 6, 20, 21 },
	MP_E = { 9, 11, 13, 8, 10, 12, 14, 16, 18, 15, 17, 19 },
	MP_F = {  },
}

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25",
			[2] = "1 26 2 6 14 16 18 22 25 21 13 11 9 5",
			[3] = "1 26 3 7 15 17 19 23 24 20 8 10 12 4",
			[4] = "1:2 26:2 2 6 14 16 18 22 25 21 13 11 9 5",
			[5] = "1:2 26:2 3 7 15 17 19 23 24 20 8 10 12 4",
			[6] = "[3] 1 26 2 6 14 16 18 22 25 21 13 11 9 5",
			[7] = "[3] 1 26 3 7 15 17 19 23 24 20 8 10 12 4",
		},
		Sequences = {
			["ON"] = { 1 },
			["ALT_EO"] = sequence():Alternate( 2, 3, 8 ):Alternate( 4, 5, 8 ),
			["MODE3"] = sequence()
							:Flash( 2, 3, 2 ):Do( 2 )
							:Flash( 6, 7, 2 ):Do( 1 )
							:Flash( 4, 5, 2 ):Do( 2 )
							:Flash( 6, 7, 2 ):Do( 1 )
							:Flash( 2, 3, 1 ):Do( 2 )
							:Flash( 6, 7, 2 ):Do( 1 )
							:Flash( 4, 5, 1 ):Do( 5 )
							:Flash( 6, 7, 1 ):Do( 1 )
		}
	},
	MPDC_A = {
		Frames = {
			[1] = "[1] MP_A",
			[2] = "[2] MP_A",
			[3] = "[3] MP_A",
		},
		Sequences = {
			["ON"] = { 1 },
			["C1"] = sequence()
							:Blink( 1, 3 ):Blink( 3, 3 )
							:Off( 2 )
							:Blink( 2, 3 ):Blink( 3, 3 )
							:Off( 2 )
		}
	},
	MPDC_B = {
		Frames = {
			[1] = "[1] 3 25",
			[2] = "[1] 2 24",
			[3] = "[3] 3 25",
			[4] = "[3] 2 24",
		},
		Sequences = {
			["ON"] = { 1 },
			["C1"] = sequence()
						:Alternate( 1, 2, 4 ):Do( 3 )
						:Flash( 3, 4, 3),
		}
	},
	MPDC_C = {
		Frames = {
			[1] = "[1] MP_C",
			[2] = "[3] MP_C",
		},
		Sequences = {
			["ON"] = { 1 },
			["C1"] = sequence()
						:FlashHold( 1, 3, 4 )
						:Off( 3 )
						:FlashHold( 2, 2, 3 )
						:Off( 5 )
		}
	},
	MPDC_D = {
		Frames = {
			[1] = "[1] MP_D",
			[2] = "[3] MP_D",
		},
		Sequences = {
			["ON"] = { 1 },
			["C1"] = sequence()
						:Alternate( 1, 0, 4 )
						:Off( 2 )
						:Alternate( 2, 0, 4 )
						:Off( 2 )
						:Flash( 1, 2, 2 ):Do( 3 )
						:Off( 2 )
		}
	},
	MPDC_E = {
		Frames = {
			[1] = "[1] MP_E",
			[2] = "[3] MP_E",
		},
		Sequences = {
			["ON"] = { 1 },
			["C1"] = sequence()
						:FlashHold( 1, 4, 5 )
						:Off( 4 )
						:FlashHold( 2, 3, 3 )
						:Off( 2 )
		}
	},
	MPDC = {
		Frames = {
			[1] = "5:B0.5 4:B0.5 22:B0.5 23:B0.5",
		},
		Sequences = {
			CRUISE = { 1 },
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Marker"] = {
		["ON"] = {
			-- All = UNSET,
			MPDC = "CRUISE"
		}
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ON",
		},
		["MODE2"] = {
			All = "ALT_EO",
		},
		["MODE3"] = {
			MPDC_A = "C1",
			MPDC_B = "C1",
			MPDC_C = "C1",
			MPDC_D = "C1",
			MPDC_E = "C1",
		},
		-- ["MODE3"] = {
		-- 	MPDC = "MODE1"
		-- }
	}
}