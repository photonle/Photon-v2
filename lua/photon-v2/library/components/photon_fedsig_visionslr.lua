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
			Model = "models/schmal/fedsig_visionslr_pod_emis.mdl",
			DrawMaterial = "schmal/photon/fedsig_visionslr/pod_emis",
			
		}
	},
	["2D"] = {
		SignalMaster = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Width = 4.7,
			Height = 4.5/2,
		},
		AlleyHotFeet = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 4.7,
			Height = 4.5/2,
		},
		ForwardHotFeet = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 4.5,
			Height = 4.5/2,
			Scale = 1.2,
			Ratio = 2,
			VisibilityRadius = 0
		}
	},
	["Projected"] = {
		PodProjected = {
			HorizontalFOV = 40,
			VerticalFOV = 120,
			Brightness = 0.22,
			FarZ = 500,
			NearZ = 1
		}
	}
}

COMPONENT.LightStates = {
	["Bone"] = {
		Point90 = {
			Activity = "Fixed",
			Target = 360,
			Speed = 200,
			Direction = -1
		},
		SweepForward = {
			Activity = "Sweep",
			SweepStart = 315,
			SweepEnd = 45,
			Speed = 300,
			Direction = -1,
			SweepPause = 0.2,
			AngleOutputMap = { { 0, "W" }, { 25, "R" }, { 135, "A" }, { 225, "B" }, { 335, "W" } }
		},
		RearSweep = {
			Activity = "Sweep",
			SweepStart = 145,
			SweepEnd = 215,
			Speed = 300,
			Direction = -1,
			SweepPause = 0.2,
			-- AngleOutputMap = { { 0, "W" }, { 25, "R" }, { 135, "A" }, { 225, "B" }, { 335, "W" } }
		},
		FixedRear = {
			Activity = "Fixed",
			Target = 180,
			Speed = 200,
			Direction = -1
		}
	},
	["Mesh"] = {
		ProxyTest = {
			Proxy = { Type = "FROM_LIGHT", Key = 1, Value = "AngleOutput" }		
		}
	},
}

COMPONENT.Lights = {
	[1] = { "Pod", BoneId = 8, Axis = "y", Speed = 600 },
	[2] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 8 },
	[3] = { "PodEmissive", Vector( -3.99, 23.03, 1.29 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[4] = { "Pod", BoneId = 2, Axis = "y", Speed = 1 },
	[5] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 2 },
	[6] = { "PodEmissive", Vector( -3.99, -23.03, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[7] = { "Pod", BoneId = 7, Axis = "y", Speed = 1 },
	[8] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 7 },
	[9] = { "PodEmissive", Vector( 3.25, 15.37, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[10] = { "Pod", BoneId = 3, Axis = "y", Speed = 1 },
	[11] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 3 },
	[12] = { "PodEmissive", Vector( 3.25, -15.37, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[13] = { "Pod", BoneId = 6, Axis = "y", Speed = 1 },
	[14] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 6 },
	[15] = { "PodEmissive", Vector( 10.45, 7.7, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },
	
	[16] = { "Pod", BoneId = 4, Axis = "y", Speed = 1 },
	[17] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 4 },
	[18] = { "PodEmissive", Vector( 10.45, -7.7, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	[19] = { "Pod", BoneId = 5, Axis = "y", Speed = 1 },
	[20] = { "PodEmissive", Vector( 0.95, 0, 1.87 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/pod_emis", BoneParent = 5 },
	[21] = { "PodEmissive", Vector( 17.68, 0, 1.3 ), Angle( 0, 0, 0 ), "schmal/photon/fedsig_visionslr/leds_emis" },

	-- edge = 17
	[22] = { "SignalMaster", Vector( -11.9, 2.54, 0.05 ), Angle( 0, 90, 0 ) },
	[23] = { "SignalMaster", Vector( -11.9, -2.54, 0.05 ), Angle( 0, 90, 0 ) },

	[24] = { "SignalMaster", Vector( -11.9, 7.35, 0.05 ), Angle( 0, 90, 0 ) },
	[25] = { "SignalMaster", Vector( -11.9, -7.35, 0.05 ), Angle( 0, 90, 0 ) },

	[26] = { "SignalMaster", Vector( -11.9, 12.2, 0.05 ), Angle( 0, 90, 0 ) },
	[27] = { "SignalMaster", Vector( -11.9, -12.2, 0.05 ), Angle( 0, 90, 0 ) },

	[28] = { "SignalMaster", Vector( -11.9, 17, 0.05 ), Angle( 0, 90, 0 ) },
	[29] = { "SignalMaster", Vector( -11.9, -17, 0.05 ), Angle( 0, 90, 0 ) },

	[30] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 8 },
	[31] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 2 },

	[32] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 7 },
	[33] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 3 },

	[34] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 6 },
	[35] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 4 },
	
	[36] = { "PodProjected", Vector( 0.8, 0, 1.8 ), Angle( 0, -90, 0 ), BoneParent = 5 },

	[37] = { "AlleyHotFeet", Vector( -7.3, 27.8, 0 ), Angle( 0, -6, 0 ) },
	[38] = { "AlleyHotFeet", Vector( -7.3, -27.8, 0 ), Angle( 0, 180 + 6, 0 ) },

	[39] = { "ForwardHotFeet", Vector( 5.9, 24.76, -1.49 ), Angle( 0, -90, 0 ) },
	[40] = { "ForwardHotFeet", Vector( 5.9, -24.76, -1.49 ), Angle( 0, -90, 0 ) },
}

COMPONENT.ColorMap = "[ROT] 1 4 7 10 13 16 19 [R] 2 3 5 6 8 9 11 12 20 21 30 31 32 33 36 [B] 14 15 17 18 34 35 [A] 22 23 24 25 26 27 28 29 [W] 37 38 39 40"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Test = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21",
			[2] = "[SweepForward] 1 4 7 10 13 16 19",
			-- [3] = "[RearSweep] 1 [ProxyTest] 2 3"
			[3] = "[RearSweep] 1 4 [FixedRear] 7 10 [R] 2 3 5 6 8 9 11 12 [A] 8 9 11 12"
		},
		Sequences = {
			TEST = { 3 }
		}
	},
	ProjectedTest = {
		Frames = {
			[1] = "30 31 32 33 34 35 36"
		},
		Sequences = {
			TEST = { 1 }
		}
	},
	LVMPD = {
		Frames = {
			[1] = "2 3 5 6 30 31 [ROT] 1 4",
			[2] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 30 31 32 33 34 35 36",
			[3] = "1 2 3 4 5 6 7 10 13 14 15 16 17 18 19 20 21 30 31 34 35 36 [W] 8 9 11 12 32 33",
			[4] = "1 2 3 4 5 6 7 10 13 14 15 16 17 18 19 30 31 34 35 [W] 8 9 11 12 32 33 20 21 36"
		},
		Sequences = {
			MODE1 = { 2 },
			MODE2 = { 3 },
			MODE3 = { 4 }
		}
	},
	SignalMaster = {
		Frames = {
			[1] = "22 23 24 25 26 27 28 29",
			[2] = "26 27 28 29",
			[3] = "22 23 24 25",
			[4] = "22 24 26 28",
			[5] = "23 25 27 29",
			[6] = "26 28",
			[7] = "27 29",
			[8] = "28",
			[9] = "29"
		},
		Sequences = {
			ALL = { 1 },
			WARN1 = sequence():Alternate( 8, 9, 8 ),
			WARN2 = sequence():Alternate( 6, 7, 8 ),
			WARN3 = sequence():Alternate( 4, 5, 8 ),
			WARN4 = sequence():Alternate( 2, 3, 8 ),
		}
	},
	AlleyHotFeet = {
		Frames = {
			[1] = "37 38"
		},
		Sequences = {
			ALL = { 1 }
		}
	},
	ForwardHotFeet = {
		Frames = {
			[1] = "39 40"
		},
		Sequences = {
			ALL = { 1 }
		}
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			LVMPD = "MODE1",
			SignalMaster = "WARN1",
		},
		["MODE2"] = {
			-- LVMPD = "MODE2",
			Test = "TEST",
			-- SignalMaster = "WARN2",
			
		},
		["MODE3"] = {
			LVMPD = "MODE3",
			SignalMaster = "WARN4",
			AlleyHotFeet = "ALL",
			ForwardHotFeet = "ALL",
		}
	}
}