if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Noble",
	Code = "Noble"
}

COMPONENT.Title = [[Federal Signal MB1 Controller]]
COMPONENT.Category = "Controller"
COMPONENT.Model = "models/noble/fedsig_mb1_controller.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, -90, 45 ),
	Zoom = 4
}

COMPONENT.Templates = {
	["Sub"] = {
		SubMaterial = {}
	}
}

COMPONENT.ElementStates = {
	["Sub"] = {
		["Keypad"] = {
			Material = "noble/photon/fedsig_mb1_controller/buttons_on"
		},
		["Light"] = {
			Material = "photon_ex/fs_scsb/led_stage1_on"
		},
		["Screen"] = {
			Material = "noble/photon/fedsig_mb1_controller/screen_on"
		},
		["Text"] = {
			Material = "noble/photon/fedsig_mb1_controller/screen_text"
		}
	}
}

COMPONENT.Elements = {
	[1] = { "SubMaterial", Indexes = { 0 } }, -- Keypad
	[2] = { "SubMaterial", Indexes = { 5 } }, -- Light
	[3] = { "SubMaterial", Indexes = { 6 } }, -- Screen
	[4] = { "SubMaterial", Indexes = { 7 } }, -- Text
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Lights = {
		Frames = {
			[1] = "1:Keypad 2:Light 3:Screen 4:Text"
		 },
		 Sequences = {
			["ON"] = { 1 }
		 }
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { Lights = "ON" },
		["MODE2"] = { Lights = "ON" },
		["MODE3"] = { Lights = "ON" }
	},
	["Emergency.Directional"] = {
		["LEFT"] = { Lights = "ON" },
		["RIGHT"] = { Lights = "ON" },
		["CENOUT"] = { Lights = "ON" },
	},
	["Emergency.Marker"] = {
		["ON"] = { Lights = "ON" }
	},
}