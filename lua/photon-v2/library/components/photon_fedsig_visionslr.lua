if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal",
	Model = "HighSpeedDesigns, Schmal",
}

COMPONENT.PrintName = [[Federal Signal Vision SLR]]

COMPONENT.Model = "models/schmal/fedsig_visionslr.mdl"

COMPONENT.Templates = {
	["Bone"] = {
		Pod = {}
	},
	["Mesh"] = {
		PodEmissive = {
			Model = "models/schmal/fedsig_visionslr_pod_emis.mdl"
		}
	},
	["2D"] = {
		SignalMaster = {
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Width = 4.7,
			Height = 4.5/2,
		}
	}
}

COMPONENT.Lights = {
	[1] = { "Pod", BoneId = 8, Axis = "y", Speed = 500 },
	[2] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 8 },
	[3] = { "PodEmissive", Vector( -4.75, 23.16, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[4] = { "Pod", BoneId = 2, Axis = "y", Speed = 500 },
	[5] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 2 },
	[6] = { "PodEmissive", Vector( -4.75, -23.16, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[7] = { "Pod", BoneId = 7, Axis = "y", Speed = 400 },
	[8] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 7 },
	[9] = { "PodEmissive", Vector( 2.45, 15.4, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[10] = { "Pod", BoneId = 3, Axis = "y", Speed = 400 },
	[11] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 3 },
	[12] = { "PodEmissive", Vector( 2.45, -15.4, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[13] = { "Pod", BoneId = 6, Axis = "y", Speed = 600 },
	[14] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 6 },
	[15] = { "PodEmissive", Vector( 9.85, 7.65, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },
	
	[16] = { "Pod", BoneId = 4, Axis = "y", Speed = 600 },
	[17] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 4 },
	[18] = { "PodEmissive", Vector( 9.85, -7.65, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[19] = { "Pod", BoneId = 5, Axis = "y", Speed = 500 },
	[20] = { "PodEmissive", Vector( 0.8, 0, 1.8 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 5 },
	[21] = { "PodEmissive", Vector( 16.08, 0, 1.25 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	-- edge = 17
	[22] = { "SignalMaster", Vector( -11.9, 2.54, 0.05 ), Angle( 0, 90, 0 ) },
	[23] = { "SignalMaster", Vector( -11.9, -2.54, 0.05 ), Angle( 0, 90, 0 ) },

	[24] = { "SignalMaster", Vector( -11.9, 7.35, 0.05 ), Angle( 0, 90, 0 ) },
	[25] = { "SignalMaster", Vector( -11.9, -7.35, 0.05 ), Angle( 0, 90, 0 ) },

	[26] = { "SignalMaster", Vector( -11.9, 12.2, 0.05 ), Angle( 0, 90, 0 ) },
	[27] = { "SignalMaster", Vector( -11.9, -12.2, 0.05 ), Angle( 0, 90, 0 ) },

	[28] = { "SignalMaster", Vector( -11.9, 17, 0.05 ), Angle( 0, 90, 0 ) },
	[29] = { "SignalMaster", Vector( -11.9, -17, 0.05 ), Angle( 0, 90, 0 ) },
}

COMPONENT.ColorMap = "[ROT] 1 4 7 10 13 16 19 [R] 2 3 5 6 8 9 11 12 20 21 [B] 14 15 17 18 [A] 22 23 24 25 26 27 28 29"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Test = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21"
		},
		Sequences = {
			TEST = { 1 }
		}
	},
	SignalMaster = {
		Frames = {
			[1] = "22 23 24 25 26 27 28 29",
			[2] = "26 27 28 29",
			[3] = "22 23 24 25"
		},
		Sequences = {
			ALL = { 1 },
			WARN4 = sequence():Alternate( 2, 3, 8 )
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE3"] = {
			Test = "TEST",
			SignalMaster = "WARN4",
		}
	}
}