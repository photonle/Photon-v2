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
	[3] = "!ph2_sos_nforce_dome_red",
	[4] = "!ph2_sos_nforce_dome_blu",
	[8] = "!ph2_sos_nforce_dome_blk"
}

COMPONENT.Segments = {
	MPDC = {
		Frames = {
			[1] = "5:B0.5 4:B0.5 22:B0.5 23:B0.5"
		},
		Sequences = {
			CRUISE = { 1 }
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			MPDC = "CRUISE",
			All = UNSET
		}
	}
}