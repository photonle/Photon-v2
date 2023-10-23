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
		Pod = {
			DeactivationState = "Deactivate"
		}
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
			RequiredBodyGroups = { ["Hotfeet"] = { 0 } }
		},
		ForwardHotFeet = {
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 4.5,
			Height = 4.5/2,
			Scale = 1.2,
			Ratio = 2,
			VisibilityRadius = 0,
			RequiredBodyGroups = { ["Hotfeet"] = { 0 } }
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

COMPONENT.ElementStates = {
	["Bone"] = {
		Deactivate = {
			Activity = "Fixed",
			Target = 0,
			Speed = 200,
			Direction = 1,
			DeactivateOnTarget = true
		},
		Standby = {
			Activity = "Fixed",
			Target = 0,
			Speed = 350,
			Direction = 1
		},
		Point0 ={
			Activity = "Fixed",
			Target = 0,
			Speed = 350,
			Direction = 1
		},
		Point215 = {
			Activity = "Fixed",
			Target = 136,
			Speed = 200,
			Direction = 1
		},
		Point135 = {
			Activity = "Fixed",
			Target = 179,
			Speed = 200,
			Direction = -1
		},
		Point180 = {
			Activity = "Fixed",
			Target = 180,
			Speed = 200,
			Direction = -1
		},
		Point270 = {
			Activity = "Fixed",
			Target = 270,
			Speed = 200,
			Direction = -1
		},
		Point90 = {
			Activity = "Fixed",
			Target = 90,
			Speed = 200,
			Direction = -1
		},
		RotateFast = {
			Activity = "Rotate",
			Speed = 700,
		},
		RotateMedium = {
			Activity = "Rotate",
			Speed = 500,
		},
		RotateStart = {
			Activity = "Rotate",
			Speed = 250,
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
		LVMPD_M1_Pod4 = {
			Activity = "Rotate",
			Speed = 600,
			AngleOutputMap = { { 0, "R" }, { 90, "OFF" }, { 135, "A" }, { 225, "OFF" }, { 315, "R" } }
		},
		LVMPD_M1_Sweep = {
			Activity = "Sweep",
			SweepStart = 145,
			SweepEnd = 215,
			Speed = 300,
			Direction = -1,
			SweepPause = 0.2,
		},
		LVMPD_M2_RA = {
			Activity = "Rotate",
			Speed = 550,
			AngleOutputMap = { { 0, "R" }, { 90, "A"}, { 270, "R" } }
		},
		LVMPD_M3_RR = {
			Activity = "Rotate",
			Speed = 550,
			AngleOutputMap = { { 0, "R" } }
		},
		LVMPD_M2_4_RA = {
			Activity = "Rotate",
			Speed = 400,
			AngleOutputMap = { { 0, "R" }, { 90, "A"}, { 270, "R" } }
		},
		LVMPD_M3_RW = {
			Activity = "Rotate",
			Speed = 550,
			AngleOutputMap = { { 0, "W" }, { 90, "R"}, { 270, "W" } }
		},
		LVMPD_M3_4_RW = {
			Activity = "Rotate",
			Speed = 400,
			AngleOutputMap = { { 0, "W" }, { 90, "R"}, { 270, "W" } }
		},
		RearSweep_2 = {
			Inherit = "RearSweep",
			Speed = 300
		},
		ForwardFlash = {
			Activity = "Rotate",
			Speed = 600,
			AngleOutputMap = { { 0, "R" }, { 90, "OFF" }, { 135, "A" }, { 225, "OFF" }, { 315, "R" } }
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
		},
		Pod1Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 1, Value = "AngleOutput" }
		},
		Pod2Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 7, Value = "AngleOutput" }
		},
		Pod3Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 13, Value = "AngleOutput" }
		},
		Pod4Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 19, Value = "AngleOutput" }		
		},
		Pod5Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 16, Value = "AngleOutput" }
		},
		Pod6Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 10, Value = "AngleOutput" }
		},
		Pod7Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 4, Value = "AngleOutput" }
		},
	},
	["Projected"] = {
		Pod1Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 1, Value = "AngleOutput" }
		},
		Pod2Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 7, Value = "AngleOutput" }
		},
		Pod3Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 13, Value = "AngleOutput" }
		},
		Pod4Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 19, Value = "AngleOutput" }		
		},
		Pod5Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 16, Value = "AngleOutput" }
		},
		Pod6Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 10, Value = "AngleOutput" }
		},
		Pod7Proxy = {
			Proxy = { Type = "FROM_LIGHT", Key = 4, Value = "AngleOutput" }
		},
	}
}

COMPONENT.LightGroups = {
	["POD1_Light"] = { 2, 3, 30 },
	-- ["POD1_Light"] = { 2, 3 },
	["POD1"] = { 1 },
	-- ["POD7_Light"] = { 5, 6 },
	["POD7_Light"] = { 5, 6, 31 },
	["POD7"] = { 4 },
	-- ["POD2_Light"] = { 8, 9 },
	["POD2_Light"] = { 8, 9, 32 },
	["POD2"] = { 7 },
	-- ["POD6_Light"] = { 11, 12 },
	["POD6_Light"] = { 11, 12, 33 },
	["POD6"] = { 10 },
	-- ["POD3_Light"] = { 14, 15 },
	["POD3_Light"] = { 14, 15, 34 },
	["POD3"] = { 13 },
	-- ["POD5_Light"] = { 17, 18 },
	["POD5_Light"] = { 17, 18, 35 },
	["POD5"] = { 16 },
	["POD4_Light"] = { 20, 21, 36 },
	-- ["POD4_Light"] = { 20, 21 },
	["POD4"] = { 19 },
}

COMPONENT.Elements = {
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
			[3] = "[RearSweep] 1 4 [FixedRear] 7 10 [R] 2 3 5 6 8 9 11 12 [A] 8 9 11 12",
			[4] = "[RotateStart] POD1"
		},
		Sequences = {
			TEST = { 4 }
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
	Pods = {
		Frames = {
			[0] = "[Standby] POD1 POD2 POD3 POD4 POD5 POD6 POD7"
		},
		Sequences = {
			OFF = { 0 }
		}
	},
	-- LVMPD = {
	-- 	Frames = {
	-- 		[1] = "2 3 5 6 30 31 [ROT] 1 4",
	-- 		[2] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 30 31 32 33 34 35 36",
	-- 		[3] = "1 2 3 4 5 6 7 10 13 14 15 16 17 18 19 20 21 30 31 34 35 36 [W] 8 9 11 12 32 33",
	-- 		[4] = "1 2 3 4 5 6 7 10 13 14 15 16 17 18 19 30 31 34 35 [W] 8 9 11 12 32 33 20 21 36",
	-- 		[5] = "[RearSweep] POD1 POD7 [RearSweep_2] POD2 POD6 [ForwardFlash] POD4 [R] POD1_Light POD7_Light [A] POD2_Light POD6_Light [Pod4Proxy] POD4_Light",
	-- 		[6] = "[Point135] POD1 POD2 [Point215] POD6 POD7 [ForwardFlash] POD4 [R] POD1_Light POD7_Light [A] POD2_Light POD6_Light [Pod4Proxy] POD4_Light"
	-- 	},
	-- 	Sequences = {
	-- 		MODE1 = sequence():Add(6):Hold(40):Add(5):SetRepeating( false ),
	-- 		MODE2 = { 3 },
	-- 		MODE3 = { 4 }
	-- 	}
	-- },
	LVMPD_Lights = {
		Frames = {
			-- [1] = "[R] POD1_Light",
			-- [2] = "[R] POD1_Light [A] POD2_Light",
			-- [3] = "[R] POD1_Light [A] POD2_Light [Pod4Proxy] POD4_Light",
			-- [4] = "[R] POD1_Light [A] POD2_Light POD6_Light [Pod4Proxy] POD4_Light",
			-- [5] = "[R] POD1_Light POD7_Light [A] POD2_Light POD6_Light [Pod4Proxy] POD4_Light",
			
			[1] = "[R] POD1_Light",
			[2] = "[R] POD1_Light POD2_Light",
			[3] = "[R] POD1_Light POD2_Light POD4_Light",
			[4] = "[R] POD1_Light POD2_Light POD4_Light POD6_Light",
			[5] = "[R] POD1_Light POD2_Light POD4_Light POD6_Light POD7_Light",

			[6] = "[R] POD1_Light",
			[7] = "[R] POD1_Light POD2_Light",
			[8] = "[R] POD1_Light POD2_Light [OFF] POD3_Light",
			[9] = "[R] POD1_Light POD2_Light [OFF] POD3_Light [R] POD4_Light",
			[10] = "[R] POD1_Light POD2_Light [OFF] POD3_Light [R] POD4_Light [OFF] POD5_Light",
			[11] = "[R] POD1_Light POD2_Light [OFF] POD3_Light [R] POD4_Light [OFF] POD5_Light [R] POD6_Light",
			[12] = "[R] POD1_Light POD2_Light [OFF] POD3_Light [R] POD4_Light [OFF] POD5_Light [R] POD6_Light POD7_Light",
			
			[13] = "[R] POD1_Light POD7_Light [B] POD3_Light POD5_Light [Pod2Proxy] POD2_Light [Pod4Proxy] POD4_Light [Pod6Proxy] POD6_Light",
			
			[14] = "[R] POD1_Light POD7_Light [A] POD2_Light POD6_Light [Pod4Proxy] POD4_Light",
			
			[15] = "[R] POD1_Light POD2_Light [B] POD3_Light [R] POD4_Light [B] POD5_Light [R] POD6_Light POD7_Light",
			-- [13] = "[R] POD1_Light POD7_Light POD2_Light POD6_Light POD4_Light [B] POD3_Light POD5_Light "
			-- [7] = "[R] POD1_Light POD7_Light [B] POD3_Light POD5_Light",
		},
		Sequences = {
			MODE1 = sequence():Add( 1, 2, 3, 4, 5 ):Hold( 40 ):Add( 14 ):SetRepeating( false ),
			MODE2 = sequence():Add( 0 ):Hold( 10 ):Add( 6, 7, 8, 9, 10, 11, 12 ):Hold( 20 ):Add( 15 ):Hold( 30 ):Add( 13 ):SetRepeating( false ),
			MODE3 = sequence():Add( 12 ):Hold( 30 ):Add( 15 ):SetRepeating( false ),
			MODE4 = sequence():Add( 12 ):Hold( 30 ):Add( 15 ):Hold( 20 ):Add( 13 ):SetRepeating( false ),
		}
	},
	LVMPD_Pods = {
		Frames = {
			[1] = "[Point135] POD1 POD2 [Point215] POD6 POD7 [RotateStart] POD4",
			[2] = "[RearSweep] POD1 POD2 POD6 POD7 [LVMPD_M1_Pod4] POD4 [Standby] POD3 POD5",
			-- Mode 2
			[3] = "[Standby] POD1 POD2 POD3 POD4 POD5 POD6 POD7",
			[4] = "[LVMPD_M2_RA] POD2 POD6 [LVMPD_M2_4_RA] POD4 [RotateMedium] POD1 POD7 [RotateFast] POD3 POD5",
			-- Mode 3
			[5] = "[Standby] POD1 POD2 POD3 POD4 POD5 POD6 POD7",
			[6] = "[LVMPD_M3_RW] POD2 POD6 [LVMPD_M3_4_RW] POD4 [RotateMedium] POD1 POD7 [RotateFast] POD3 POD5",
			-- Ramp All
			[7] = "[RotateStart] POD1",
			[8] = "[RotateStart] POD1 POD2",
			[9] = "[RotateStart] POD1 POD2 POD3",
			[10] = "[RotateStart] POD1 POD2 POD3 POD4",
			[11] = "[RotateStart] POD1 POD2 POD3 POD4 POD5",
			[12] = "[RotateStart] POD1 POD2 POD3 POD4 POD5 POD6",
			[13] = "[RotateStart] POD1 POD2 POD3 POD4 POD5 POD6 POD7",
			-- Ramp Mode 2
			-- [6] = "[LVMPD_M3_4_RW] POD4 [LVMPD_M3_RW] POD2 POD6 [RotateMedium] POD1 POD7 [RotateFast] POD3 POD5",
			[14] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1",
			[15] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6",
			[16] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6 [RotateFast] POD3",
			[17] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6 [RotateFast] POD3 [LVMPD_M2_RA] POD4",
			[18] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6 [RotateFast] POD3 [LVMPD_M2_RA] POD4 [RotateFast] POD5",
			[19] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6 [RotateFast] POD3 [LVMPD_M2_RA] POD4 [RotateFast] POD5 [LVMPD_M2_RA] POD2",
			[20] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M2_RA] POD6 [RotateFast] POD3 [LVMPD_M2_RA] POD4 [RotateFast] POD5 [LVMPD_M2_RA] POD2 [RotateMedium] POD7",
			-- Ramp Mode 3
			[21] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1",
			[22] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6",
			[23] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6 [RotateFast] POD3",
			[24] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6 [RotateFast] POD3 [LVMPD_M3_RR] POD4",
			[25] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6 [RotateFast] POD3 [LVMPD_M3_RR] POD4 [RotateFast] POD5",
			[26] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6 [RotateFast] POD3 [LVMPD_M3_RR] POD4 [RotateFast] POD5 [LVMPD_M3_RR] POD2",
			[27] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RR] POD6 [RotateFast] POD3 [LVMPD_M3_RR] POD4 [RotateFast] POD5 [LVMPD_M3_RR] POD2 [RotateMedium] POD7",

			-- Ramp Mode 4
			[28] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1",
			[29] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6",
			[30] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6 [RotateFast] POD3",
			[31] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6 [RotateFast] POD3 [LVMPD_M3_4_RW] POD4",
			[32] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6 [RotateFast] POD3 [LVMPD_M3_4_RW] POD4 [RotateFast] POD5",
			[33] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6 [RotateFast] POD3 [LVMPD_M3_4_RW] POD4 [RotateFast] POD5 [LVMPD_M3_RW] POD2",
			[34] = "[RotateStart] POD2 POD3 POD4 POD5 POD6 POD7 [RotateMedium] POD1 [LVMPD_M3_RW] POD6 [RotateFast] POD3 [LVMPD_M3_4_RW] POD4 [RotateFast] POD5 [LVMPD_M3_RW] POD2 [RotateMedium] POD7",
		},
		Sequences = {
			MODE1 = sequence():Add( 1 ):Hold( 30 ):Add( 2 ):SetRepeating( false ),
			MODE2 = sequence():Add( 3 ):Hold( 20 ):Add( 13 ):Hold( 20 ):Add( 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20 ):SetRepeating( false ),
			MODE3 = sequence():Add( 3 ):Hold( 20 ):Add( 13 ):Hold( 20 ):Add( 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27 ):SetRepeating( false ),
			MODE4 = sequence():Add( 3 ):Hold( 20 ):Add( 13 ):Hold( 20 ):Add( 28, 28, 29, 29, 30, 30, 31, 31, 32, 32, 33, 33, 34 ):SetRepeating( false ),
			-- MODE3 = sequence():Add( 13 ):Hold( 10 ):Add( 4 ):SetRepeating( false ),
			-- MODE4 = sequence():Add( 13 ):Hold( 10 ):Add( 6 ):SetRepeating( false ),
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
			[9] = "29",
			-- L
			[10] = "29",
			[11] = "29 27",
			[12] = "29 27 25",
			[13] = "29 27 25 23",
			[14] = "29 27 25 23 22",
			[15] = "29 27 25 23 22 24 ",
			[16] = "29 27 25 23 22 24 26",
			[17] = "29 27 25 23 22 24 26 28",
			-- R
			[18] = "28",
			[19] = "28 26",
			[20] = "28 26 24",
			[21] = "28 26 24 22",
			[22] = "28 26 24 22 23",
			[23] = "28 26 24 22 23 25",
			[24] = "28 26 24 22 23 25 27",
			[25] = "28 26 24 22 23 25 27 29",
			-- CO
			[26] = "22 23",
			[27] = "24 22 23 25",
			[28] = "26 24 22 23 25 27",
			[29] = "28 26 24 22 23 25 27 29",
		},
		Sequences = {
			ALL = { 1 },
			WARN1 = sequence():Alternate( 8, 9, 8 ),
			WARN2 = sequence():Alternate( 6, 7, 8 ),
			WARN3 = sequence():Alternate( 4, 5, 8 ),
			WARN4 = sequence():Alternate( 2, 3, 8 ),
			LEFT = sequence():Sequential( 10, 17 ):Stretch( 4 ):Hold( 8 ):Add( 0 ):Hold( 4 ),
			RIGHT = sequence():Sequential( 18, 25 ):Stretch( 4 ):Hold( 8 ):Add( 0 ):Hold( 4 ),
			CENOUT = sequence():Sequential( 26, 29 ):Stretch( 8 ):Hold( 8 ):Add( 0 ):Hold( 4 )
		}
	},
	AlleyHotFeet = {
		Frames = {
			[1] = "37 38",
		},
		Sequences = {
			ALL = { 1 },
			FLASH = { 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, }
		}
	},
	ForwardHotFeet = {
		Frames = {
			[1] = "39 40"
		},
		Sequences = {
			ALL = { 1 },
			FLASH = { 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, }
		}
	},
	SceneLeft = {
		Frames = {
			[1] = "[W] POD2_Light POD4_Light 37 [Point270] POD2 POD4"
		},
		Sequences = {
			SCENE_LEFT = { 1 }
		}
	},
	SceneRight = {
		Frames = {
			[1] = "[W] POD6_Light POD4_Light 38 [Point90] POD6 POD4"
		},
		Sequences = {
			SCENE_RIGHT = { 1 }
		}
	},
	SceneForward = {
		Frames = {
			[1] = "[W] POD4_Light POD6_Light POD2_Light 39 40 [Point0] POD4 POD2 POD6"
		},
		Sequences = {
			SCENE_FORWARD = { 1 }
		}
	},
	Pod4 = {
		Frames = {
			[1] = "[W] POD4_Light [Point0] POD4"
		},
		Sequences = {
			SCENE_FORWARD = { 1 },
		}
	}
}

COMPONENT.InputPriorities = {
	["Virtual.Warning+Siren"] = 43,
	["Virtual.SceneLeft+Forward"] = 142,
	["Virtual.SceneRight+Forward"] = 141,
	["Emergency.SceneLeft"] = 140,
	["Emergency.SceneRight"] = 130,
	["Emergency.SceneForward"] = 120,
}

COMPONENT.VirtualOutputs = {
	["Virtual.Warning+Siren"] = {
		{
			Mode = "MODE3",
			Conditions = {
				["Emergency.Siren"] = { "T1", "T2", "T3", "T4", "AH", "MA"},
				["Emergency.Warning"] = { "MODE3" }
			}
		}
	},
	["Virtual.SceneLeft+Forward"] = {
		{
			Mode = "ON",
			Conditions = {
				["Emergency.SceneForward"] = { "ON" },
				["Emergency.SceneLeft"] = { "ON" },
			}
		}
	},
	["Virtual.SceneRight+Forward"] = {
		{
			Mode = "ON",
			Conditions = {
				["Emergency.SceneForward"] = { "ON" },
				["Emergency.SceneRight"] = { "ON" },
			}
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["OFF"] = {
			Pods = "OFF"
		},
		["MODE1"] = {
			LVMPD_Lights = "MODE1",
			LVMPD_Pods = "MODE1",
			SignalMaster = "WARN1",
		},
		["MODE2"] = {
			SignalMaster = "WARN2",
			LVMPD_Lights = "MODE2",
			LVMPD_Pods = "MODE2",
		},
		["MODE3"] = {
			SignalMaster = "WARN2",
			LVMPD_Lights = "MODE3",
			LVMPD_Pods = "MODE3",
			SignalMaster = "WARN4",
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = { SignalMaster = "LEFT" },
		["RIGHT"] = { SignalMaster = "RIGHT" },
		["CENOUT"] = { SignalMaster = "CENOUT" },
	},
	["Emergency.SceneLeft"] = {
		["ON"] = { SceneLeft = "SCENE_LEFT" }
	},
	["Emergency.SceneRight"] = {
		["ON"] = { SceneRight = "SCENE_RIGHT" }
	},
	["Emergency.SceneForward"] = {
		["ON"] = { SceneForward = "SCENE_FORWARD" }
	},
	["Virtual.Warning+Siren"] = {
		["MODE3"] = {
			LVMPD_Lights = "MODE4",
			LVMPD_Pods = "MODE4",
			AlleyHotFeet = "FLASH",
			ForwardHotFeet = "FLASH",
		}
	},
	["Virtual.SceneLeft+Forward"] = { ["ON"] = { Pod4 = "SCENE_FORWARD" } },
	["Virtual.SceneRight+Forward"] = { ["ON"] = { Pod4 = "SCENE_FORWARD" } },
}