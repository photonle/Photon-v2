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

COMPONENT.Segments = {
	MPDC = {
		Frames = {
			[1] = "5:B0.5 4:B0.5 22:B0.5 23:B0.5",
			[2] = "5:R 4:B 22:R 23:R"
		},
		Sequences = {
			CRUISE = { 1 },
			MODE3 = { 2 },
			MODE1 = { 2 }
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
		-- ["MODE1"] = {
		-- 	-- All = UNSET,
		-- 	MPDC = "MODE1",
		-- },
		-- ["MODE2"] = {
		-- 	All = UNSET,
		-- 	MPDC = "MODE1",
		-- },
		-- ["MODE3"] = {
		-- 	MPDC = "MODE1"
		-- }
	}
}