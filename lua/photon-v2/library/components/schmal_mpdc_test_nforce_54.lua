if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.Title = [[[MPDC] SoundOff Signal nForce (54")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Base = "schmal_mpdc_sos_nforce_54"

local sequence = Photon2.SequenceBuilder.New


COMPONENT.SubMaterials = {
	[3] = "!ph2_sos_nforce_dome_red",
	[4] = "!ph2_sos_nforce_dome_blu",
	[8] = "!ph2_sos_nforce_dome_blk"
}

COMPONENT.Segments = {}
COMPONENT.Inputs = {}

COMPONENT.Segments = {
	MPDC = {
		Frames = {
			[1] = "5:B0.5 4:B0.5 22:B0.5 23:B0.5",
			[2] = "5:R 4:R 22:R 23:R"
		},
		Sequences = {
			CRUISE = { 1 },
			MODE3 = { 2 }
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Marker"] = {
		["CRUISE"] = {
			-- All = UNSET,
			-- MPDC = "CRUISE"
			All = "STEADY"
		}
	},
	["Emergency.Warning"] = {
		["MODE3"] = {
			MPDC = "MODE3"
		}
	}
}

-- COMPONENT.Inputs = {}