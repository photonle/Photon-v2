if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "Khuutznetsov",
}

COMPONENT.Phase = nil

COMPONENT.PrintName = [[Federal Signal X-Stream Single]]

COMPONENT.Model = "models/schmal/fedsig_xstream_single.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_xstream_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/fs_xstream_detail.png").MaterialName,
			Width = 6,
			Height = 1.5
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0.55, 0, -0.05 ), Angle( 0, -90, 0 ) }
}

COMPONENT.ElementStates = {}

COMPONENT.ColorMap = "[R] 1"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	["Light"] = {
		Frames = {
			[1] = "1"
		},
		Sequences = {
			["ON"] = { 1 },
			["FLASH"] = sequence():QuadFlash( 1, 0 ),
			["FLASH:A"] = { 1, 1, 1, 1, 0, 0, 0, 0 },
			["FLASH:B"] = { 0, 0, 0, 0, 1, 1, 1, 1 },
			["FLASH1"] = { 1 },
			["FLASH1:A"] = { 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			["FLASH1:B"] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1 },

		}
	}
}

COMPONENT.InputPriorities = {
	["Virtual.Siren"] = 200
}

COMPONENT.VirtualOutputs = {
	-- Virtual channel name
	["Virtual.Siren"] = {
		{
			Mode = "T1",
			Conditions = {
				["Emergency.Siren"] = { "T1" },
				["Emergency.Warning"] = { "MODE1", "MODE2", "MODE3" }
			}
		}
		-- Mode
		-- ["T1"] = { -- T1 is active when...
		-- 	{ -- (Condition #1)
		-- 		-- Siren mode is set to T1...
		-- 		["Emergency.Siren"] = { "T1" },
		-- 		-- AND Warning mode is MODE1, MODE2 or MODE3
		-- 	}
		-- }
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "FLASH"
		},
		["MODE2"] = {
			Light = "FLASH"
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "ON"
		}
	}
	-- ["Virtual.Siren"] = {
	-- 	["T1"] = {
	-- 		Light = "ON"
	-- 	}
	-- }
}