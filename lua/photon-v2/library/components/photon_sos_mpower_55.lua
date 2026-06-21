if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "SGM"
}

COMPONENT.PrintName = [[SoundOff Signal mpower Lightbar 55"]]

COMPONENT.Model = "models/sentry/props/mpower_55.mdl"

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

local s = 7.4

COMPONENT.Templates = {
	["2D"] = {
		Light_1 = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_1.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_1.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.5,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.0,
			LightMatrix = {
				Vector(-3.16,0,0),
				Vector(3.16,0,0),
			}
		},
		Light_side_1 = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_1.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_1.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.0,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			LightMatrix = {
				Vector(-1.15,0,0),
				Vector(1.15,0,0),
			}
		},
		Light_2 = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_2.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_2.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.5,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.0,
			LightMatrix = {
				Vector(-3.16,0,0),
				Vector(3.16,0,0),
			}
		},
		Light_side_2 = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_2.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_2.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.0,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			LightMatrix = {
				Vector(-1.15,0,0),
				Vector(1.15,0,0),
			}
		},
		Light_c = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_c.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_6_c.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.5,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.0,
			LightMatrix = {
				Vector(-3.16,0,0),
				Vector(3.16,0,0),
			}
		},
		Light_side_c = {
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_c.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/sos_mpower_3_c.png").MaterialName,
			Width = s,
			Height = s * 0.125,
			Ratio = 1,
			Scale = 1.0,
			ForwardVisibilityOffset = -0.1,
			ForwardBloomOffset = 0.1,
			LightMatrix = {
				Vector(-1.15,0,0),
				Vector(1.15,0,0),
			}
		},
	},
	["Projected"] = {
		Projected = {
			FOV = 120,
			Texture = "effects/flashlight/soft",
			NearZ = 4,
			FarZ = 1000,
			Brightness = 3,
			IntensityGainFactor = 12,
			IntensityLossFactor = 6,
			DeactivationState = "OFF",
		}
	},
}

COMPONENT.StateMap = "[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 [2] 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 [3] 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 [W] 25 26 27 28 29"

local gap = 8.112

COMPONENT.Elements = {
	-- front
	[1] = { "Light_1", Vector(-6.47, gap*-3, 0), Angle(0, 90, 0), },
	[2] = { "Light_1", Vector(-6.47, gap*-2, 0), Angle(0, 90, 0) },
	[3] = { "Light_1", Vector(-6.47, gap*-1, 0), Angle(0, 90, 0) },
	[4] = { "Light_1", Vector(-6.47, gap*0, 0), Angle(0, 90, 0) },
	[5] = { "Light_1", Vector(-6.47, gap*1, 0), Angle(0, 90, 0) },
	[6] = { "Light_1", Vector(-6.47, gap*2, 0), Angle(0, 90, 0) },
	[7] = { "Light_1", Vector(-6.47, gap*3, 0), Angle(0, 90, 0) },
	-- rear
	[8] = { "Light_1", Vector(6.47, gap*-3, 0), Angle(0, -90, 0) },
	[9] = { "Light_1", Vector(6.47, gap*-2, 0), Angle(0, -90, 0) },
	[10] = { "Light_1", Vector(6.47, gap*-1, 0), Angle(0, -90, 0) },
	[11] = { "Light_1", Vector(6.47, gap*0, 0), Angle(0, -90, 0) },
	[12] = { "Light_1", Vector(6.47, gap*1, 0), Angle(0, -90, 0) },
	[13] = { "Light_1", Vector(6.47, gap*2, 0), Angle(0, -90, 0) },
	[14] = { "Light_1", Vector(6.47, gap*3, 0), Angle(0, -90, 0) },
	-- driver side
	[15] = { "Light_side_1", Vector(-5.863, -30.334, 0), Angle(0, 107, 0) },
	[16] = { "Light_side_1", Vector(-3.62, -33.512, 0), Angle(0, 143, 0) },
	[17] = { "Light_side_1", Vector(0, -34.697, 0), Angle(0, 180, 0) },
	[18] = { "Light_side_1", Vector(3.62, -33.512, 0), Angle(0, -143, 0) },
	[19] = { "Light_side_1", Vector(5.863, -30.334, 0), Angle(0, -107, 0) },
	-- pass side
	[20] = { "Light_side_1", Vector(-5.863, 30.334, 0), Angle(0, 73, 0) },
	[21] = { "Light_side_1", Vector(-3.62, 33.512, 0), Angle(0, 37, 0) },
	[22] = { "Light_side_1", Vector(0, 34.697, 0), Angle(0, 0, 0) },
	[23] = { "Light_side_1", Vector(3.62, 33.512, 0), Angle(0, -37, 0) },
	[24] = { "Light_side_1", Vector(5.863, 30.334, 0), Angle(0, -73, 0) },
	--takedowns
	[25] = { "Projected", Vector( -6.47, gap*2, 0 ), Rotation = Angle( 0, 180, 0 ), FOV = 90, },
	[26] = { "Projected", Vector( -6.47, gap*-2, 0 ), Rotation = Angle( 0, 180, 0 ), FOV = 90, },
	[27] = { "Projected", Vector( -6.47, gap*0, 0 ), Rotation = Angle( 0, 180, 0 ), FOV = 150,},
	[28] = { "Projected", Vector( 0, -34.697, 0 ), Rotation = Angle( 0, -90, 0 ), FOV = 120,},
	[29] = { "Projected", Vector( 0, 34.697, 0 ), Rotation = Angle( 0, 90, 0 ), FOV = 120,},
	-- front
	[30] = { "Light_2", Vector(-6.47, gap*-3, 0), Angle(0, 90, 0), },
	[31] = { "Light_2", Vector(-6.47, gap*-2, 0), Angle(0, 90, 0) },
	[32] = { "Light_2", Vector(-6.47, gap*-1, 0), Angle(0, 90, 0) },
	[33] = { "Light_2", Vector(-6.47, gap*0, 0), Angle(0, 90, 0) },
	[34] = { "Light_2", Vector(-6.47, gap*1, 0), Angle(0, 90, 0) },
	[35] = { "Light_2", Vector(-6.47, gap*2, 0), Angle(0, 90, 0) },
	[36] = { "Light_2", Vector(-6.47, gap*3, 0), Angle(0, 90, 0) },
	-- rear
	[37] = { "Light_2", Vector(6.47, gap*-3, 0), Angle(0, -90, 0) },
	[38] = { "Light_2", Vector(6.47, gap*-2, 0), Angle(0, -90, 0) },
	[39] = { "Light_2", Vector(6.47, gap*-1, 0), Angle(0, -90, 0) },
	[40] = { "Light_2", Vector(6.47, gap*0, 0), Angle(0, -90, 0) },
	[41] = { "Light_2", Vector(6.47, gap*1, 0), Angle(0, -90, 0) },
	[42] = { "Light_2", Vector(6.47, gap*2, 0), Angle(0, -90, 0) },
	[43] = { "Light_2", Vector(6.47, gap*3, 0), Angle(0, -90, 0) },
	-- driver side
	[44] = { "Light_side_2", Vector(-5.863, -30.334, 0), Angle(0, 107, 0) },
	[45] = { "Light_side_2", Vector(-3.62, -33.512, 0), Angle(0, 143, 0) },
	[46] = { "Light_side_2", Vector(0, -34.697, 0), Angle(0, 180, 0) },
	[47] = { "Light_side_2", Vector(3.62, -33.512, 0), Angle(0, -143, 0) },
	[48] = { "Light_side_2", Vector(5.863, -30.334, 0), Angle(0, -107, 0) },
	-- pass side
	[49] = { "Light_side_2", Vector(-5.863, 30.334, 0), Angle(0, 73, 0) },
	[50] = { "Light_side_2", Vector(-3.62, 33.512, 0), Angle(0, 37, 0) },
	[51] = { "Light_side_2", Vector(0, 34.697, 0), Angle(0, 0, 0) },
	[52] = { "Light_side_2", Vector(3.62, 33.512, 0), Angle(0, -37, 0) },
	[53] = { "Light_side_2", Vector(5.863, 30.334, 0), Angle(0, -73, 0) },

	-- front
	[54] = { "Light_c", Vector(-6.47, gap*-3, 0), Angle(0, 90, 0), },
	[55] = { "Light_c", Vector(-6.47, gap*-2, 0), Angle(0, 90, 0) },
	[56] = { "Light_c", Vector(-6.47, gap*-1, 0), Angle(0, 90, 0) },
	[57] = { "Light_c", Vector(-6.47, gap*0, 0), Angle(0, 90, 0) },
	[58] = { "Light_c", Vector(-6.47, gap*1, 0), Angle(0, 90, 0) },
	[59] = { "Light_c", Vector(-6.47, gap*2, 0), Angle(0, 90, 0) },
	[60] = { "Light_c", Vector(-6.47, gap*3, 0), Angle(0, 90, 0) },
	-- rear
	[61] = { "Light_c", Vector(6.47, gap*-3, 0), Angle(0, -90, 0) },
	[62] = { "Light_c", Vector(6.47, gap*-2, 0), Angle(0, -90, 0) },
	[63] = { "Light_c", Vector(6.47, gap*-1, 0), Angle(0, -90, 0) },
	[64] = { "Light_c", Vector(6.47, gap*0, 0), Angle(0, -90, 0) },
	[65] = { "Light_c", Vector(6.47, gap*1, 0), Angle(0, -90, 0) },
	[66] = { "Light_c", Vector(6.47, gap*2, 0), Angle(0, -90, 0) },
	[67] = { "Light_c", Vector(6.47, gap*3, 0), Angle(0, -90, 0) },
	-- driver side
	[68] = { "Light_side_c", Vector(-5.863, -30.334, 0), Angle(0, 107, 0) },
	[69] = { "Light_side_c", Vector(-3.62, -33.512, 0), Angle(0, 143, 0) },
	[70] = { "Light_side_c", Vector(0, -34.697, 0), Angle(0, 180, 0) },
	[71] = { "Light_side_c", Vector(3.62, -33.512, 0), Angle(0, -143, 0) },
	[72] = { "Light_side_c", Vector(5.863, -30.334, 0), Angle(0, -107, 0) },
	-- pass side
	[73] = { "Light_side_c", Vector(-5.863, 30.334, 0), Angle(0, 73, 0) },
	[74] = { "Light_side_c", Vector(-3.62, 33.512, 0), Angle(0, 37, 0) },
	[75] = { "Light_side_c", Vector(0, 34.697, 0), Angle(0, 0, 0) },
	[76] = { "Light_side_c", Vector(3.62, 33.512, 0), Angle(0, -37, 0) },
	[77] = { "Light_side_c", Vector(5.863, 30.334, 0), Angle(0, -73, 0) },
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.ElementGroups = {
	["Pri_1"] = { 1 },
	["Pri_2"] = { 2 },
	["Pri_3"] = { 3 },
	["Pri_4"] = { 4 },
	["Pri_5"] = { 5 },
	["Pri_6"] = { 6 },
	["Pri_7"] = { 7 },
	["Pri_8"] = { 8 },
	["Pri_9"] = { 9 },
	["Pri_10"] = { 10 },
	["Pri_11"] = { 11 },
	["Pri_12"] = { 12 },
	["Pri_13"] = { 13 },
	["Pri_14"] = { 14 },
	["Pri_15"] = { 15 },
	["Pri_16"] = { 16 },
	["Pri_17"] = { 17 },
	["Pri_18"] = { 18 },
	["Pri_19"] = { 19 },
	["Pri_20"] = { 20 },
	["Pri_21"] = { 21 },
	["Pri_22"] = { 22 },
	["Pri_23"] = { 23 },
	["Pri_24"] = { 24 },

	["Sec_1"] = { 30 },
	["Sec_2"] = { 31 },
	["Sec_3"] = { 32 },
	["Sec_4"] = { 33 },
	["Sec_5"] = { 34 },
	["Sec_6"] = { 35 },
	["Sec_7"] = { 36 },
	["Sec_8"] = { 37 },
	["Sec_9"] = { 38 },
	["Sec_10"] = { 39 },
	["Sec_11"] = { 40 },
	["Sec_12"] = { 41 },
	["Sec_13"] = { 42 },
	["Sec_14"] = { 43 },
	["Sec_15"] = { 44 },
	["Sec_16"] = { 45 },
	["Sec_17"] = { 46 },
	["Sec_18"] = { 47 },
	["Sec_19"] = { 48 },
	["Sec_20"] = { 49 },
	["Sec_21"] = { 50 },
	["Sec_22"] = { 51 },
	["Sec_23"] = { 52 },
	["Sec_24"] = { 53 },
	
	["Cen_1"] = { 54 },
	["Cen_2"] = { 55 },
	["Cen_3"] = { 56 },
	["Cen_4"] = { 57 },
	["Cen_5"] = { 58 },
	["Cen_6"] = { 59 },
	["Cen_7"] = { 60 },
	["Cen_8"] = { 61 },
	["Cen_9"] = { 62 },
	["Cen_10"] = { 63 },
	["Cen_11"] = { 64 },
	["Cen_12"] = { 65 },
	["Cen_13"] = { 66 },
	["Cen_14"] = { 67 },
	["Cen_15"] = { 68 },
	["Cen_16"] = { 69 },
	["Cen_17"] = { 70 },
	["Cen_18"] = { 71 },
	["Cen_19"] = { 72 },
	["Cen_20"] = { 73 },
	["Cen_21"] = { 74 },
	["Cen_22"] = { 75 },
	["Cen_23"] = { 76 },
	["Cen_24"] = { 77 },
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "Pri_1 Pri_2 Pri_3 Pri_4 Pri_8 Pri_9 Pri_10 Pri_11 Pri_15 Pri_16 Pri_17 Pri_18 Pri_19",
			[2] = "Pri_5 Pri_6 Pri_7 Pri_12 Pri_13 Pri_14 Pri_20 Pri_21 Pri_22 Pri_23 Pri_24",
			[3] = "Sec_1 Sec_2 Sec_3 Sec_4 Sec_8 Sec_9 Sec_10 Sec_11 Sec_15 Sec_16 Sec_17 Sec_18 Sec_19",
			[4] = "Sec_5 Sec_6 Sec_7 Sec_12 Sec_13 Sec_14 Sec_20 Sec_21 Sec_22 Sec_23 Sec_24",
			[5] = "[W] Cen_1 Cen_2 Cen_3 Cen_4 Cen_15 Cen_16 Cen_17 Cen_18 Cen_19 [A] Cen_8 Cen_9 Cen_10 Cen_11",
			[6] = "[W] Cen_5 Cen_6 Cen_7 Cen_20 Cen_21 Cen_22 Cen_23 Cen_24 [A] Cen_12 Cen_13 Cen_14",
			[7] = "Pri_1 Pri_2 Pri_3 Pri_4 Sec_5 Sec_6 Sec_7 Pri_8 Pri_9 Pri_10 Pri_11 Sec_12 Sec_13 Sec_14 Pri_15 Pri_16 Pri_17 Pri_18 Pri_19 Sec_20 Sec_21 Sec_22 Sec_23 Sec_24",
			[8] = "Pri_1 Pri_2 Pri_3 Pri_4 Pri_5 Pri_6 Pri_7 Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14 Pri_15 Pri_16 Pri_17 Pri_18 Pri_19 Pri_20 Pri_21 Pri_22 Pri_23 Pri_24",
			[9] = "Sec_1 Sec_2 Sec_3 Sec_4 Sec_5 Sec_6 Sec_7 Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14 Sec_15 Sec_16 Sec_17 Sec_18 Sec_19 Sec_20 Sec_21 Sec_22 Sec_23 Sec_24",
			[10] = "[W] Cen_1 Cen_2 Cen_3 Cen_4 Cen_5 Cen_6 Cen_7 Cen_15 Cen_16 Cen_17 Cen_18 Cen_19 Cen_20 Cen_21 Cen_22 Cen_23 Cen_24 [A] Cen_8 Cen_9 Cen_10 Cen_11 Cen_12 Cen_13 Cen_14",
			[11] = "Pri_1 Pri_3 Pri_5 Pri_7 Pri_16 Pri_18 Pri_21 Pri_23 [A] Cen_8 Cen_10 Cen_12 Cen_14",
			[12] = "Pri_2 Pri_4 Pri_6 Pri_9 Pri_11 Pri_13 Pri_15 Pri_17 Pri_19 Pri_20 Pri_22 Pri_24",
			[13] = "Sec_1 Sec_3 Sec_5 Sec_7 Sec_8 Sec_10 Sec_12 Sec_14 Sec_16 Sec_18 Sec_21 Sec_23",
			[14] = "Sec_2 Sec_4 Sec_6 Sec_9 Sec_11 Sec_13 Sec_15 Sec_17 Sec_19 Sec_20 Sec_22 Sec_24",
			[15] = "[W] Cen_1 Cen_3 Cen_5 Cen_7 Cen_16 Cen_18 Cen_21 Cen_23 [A] Cen_8 Cen_10 Cen_12 Cen_14",
			[16] = "[W] Cen_2 Cen_4 Cen_6 Cen_15 Cen_17 Cen_19 Cen_20 Cen_22 Cen_24 [A] Cen_9 Cen_11 Cen_13",
		},
		Sequences = {
			["1"] = sequence():SteadyFlash(7),
			["2"] = sequence():DoubleFlash(1,2):DoubleFlash(3,4):DoubleFlash(5,6),
			["3"] = sequence()
			:Alternate(1,2,4,1):Alternate(3,4,4,1):Alternate(1,2,4,1):Alternate(5,6,4,1)
			:Alternate(9,10,4,1):Steady(9,4):Steady(0,1)
			:QuadFlash(1,2):QuadFlash(3,4):QuadFlash(1,2)
			:Alternate(3,4,2,1):Alternate(1,2,2,1):Alternate(3,4,2,1):Alternate(5,6,2,1)
			:Alternate(8,9,4,1):Steady(8,4):Steady(0,1)
			:QuadFlash(13,14):QuadFlash(11,12):QuadFlash(13,14)
			:QuadFlash(1,2):QuadFlash(3,4)
			:QuadFlash(15,16)
			:Steady(0,1)
			,

		}
	},
	Takedown = {
		Frames = {
			[0] = "[PASS] Cen_1 Cen_2 Cen_3 Cen_4 Cen_5 Cen_6 Cen_7 Cen_15 Cen_16 Cen_17 Cen_18 Cen_19 Cen_20 Cen_21 Cen_22 Cen_23 Cen_24",
			[1] = "[W] Cen_2 Cen_6 25 26 [OFF] Pri_2 Pri_6 Sec_2 Sec_6",
			[2] = "[W] Cen_1 Cen_2 Cen_3 Cen_4 Cen_5 Cen_6 Cen_7 Cen_15 Cen_16 Cen_17 Cen_18 Cen_19 Cen_20 Cen_21 Cen_22 Cen_23 Cen_24 27 28 29 [OFF]  Pri_1 Pri_2 Pri_3 Pri_4 Pri_5 Pri_6 Pri_7 Pri_15 Pri_16 Pri_17 Pri_18 Pri_19 Pri_20 Pri_21 Pri_22 Pri_23 Pri_24  Sec_1 Sec_2 Sec_3 Sec_4 Sec_5 Sec_6 Sec_7 Sec_15 Sec_16 Sec_17 Sec_18 Sec_19 Sec_20 Sec_21 Sec_22 Sec_23 Sec_24",
		},
		Sequences = {
			["ON"] = { 1, },
			["FLOOD"] = { 2, },

		}
	},
	Traffic = {
		Frames = {
			[1] = "[A] Cen_14 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[2] = "[A] Cen_13 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[3] = "[A] Cen_12 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[4] = "[A] Cen_11 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[5] = "[A] Cen_10 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[6] = "[A] Cen_9 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[7] = "[A] Cen_8 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[8] = "[A] Cen_8 Cen_9 Cen_10 Cen_11 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[9] = "[A] Cen_11 Cen_12 Cen_13 Cen_14 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[10] = "[A] Cen_8 Cen_9 Cen_10 Cen_11 Cen_12 Cen_13 Cen_14 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[11] = "[A] Cen_11 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[12] = "[A] Cen_10 Cen_11 Cen_12 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[13] = "[A] Cen_10 Cen_12 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[14] = "[A] Cen_9 Cen_10 Cen_12 Cen_13 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[15] = "[A] Cen_9 Cen_13 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[16] = "[A] Cen_8 Cen_9 Cen_13 Cen_14 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
			[17] = "[A] Cen_8 Cen_14 [OFF] Pri_8 Pri_9 Pri_10 Pri_11 Pri_12 Pri_13 Pri_14  Sec_8 Sec_9 Sec_10 Sec_11 Sec_12 Sec_13 Sec_14",
		},
		Sequences = {
			["LEFT"] = sequence():Sequential(1,7):Stretch(1):Do(4):QuadFlash(8,9):Do(2):DoubleFlash(8,9):Do(4):DoubleFlash(10,0):Do(4),
			["RIGHT"] = sequence():Sequential(7,1):Stretch(1):Do(4):QuadFlash(8,9):Do(2):DoubleFlash(8,9):Do(4):DoubleFlash(10,0):Do(4),
			["CENOUT"] = sequence():Sequential(11,17):Stretch(1):Do(4):QuadFlash(8,9):Do(2):DoubleFlash(8,9):Do(4):DoubleFlash(10,0):Do(4),

		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "1"
		},
		["MODE2"] = {
			Light = "2"
		},
		["MODE3"] = {
			Light = "3",
		}
	},
	["Emergency.Marker"] = {
		["ON"] = {
			Light = "1"
		}
	},
	["Emergency.Directional"] = {
		["LEFT"] = {
			Traffic = "LEFT",
		},
		["RIGHT"] = {
			Traffic = "RIGHT",
		},
		["CENOUT"] = {
			Traffic = "CENOUT",
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ON",
		},
		["FLOOD"] = {
			Takedown = "FLOOD",
		},
	},
}