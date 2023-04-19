if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

-- Printed name of component ONLY. Reference component
-- using its filename or directory/filename.
COMPONENT.PrintName = "Federal Signal Jet Solaris"

COMPONENT.Model = "models/schmal/fedsig_jetsolaris.mdl"

COMPONENT.Lighting = {
	["2D"] = {
		Main = {
			Width 		= 7.4,
			Height		= 7.4,
			MaterialOverlay 	= "photon/lights/legend_wide_leds",
			Material 			= "sprites/emv/legend_wide",
			Scale 		= 1.5,
			Ratio 		= 1.5
		},
		Edge = {
			Width 		= 7.2,
			Height		= 7.2,
			MaterialOverlay 	= "photon/lights/legend_narrow_leds",
			Material 	= "sprites/emv/legend_narrow",
			Scale 		= 1.5,
			Ratio 		= 1
		}
	}
}

COMPONENT.Lights = {
	-- [ 1] = { "Main", Vector(0, 6.11, 0), Angle(0, 0, -90) },
	-- [ 2] = { "Main", Vector(-6.58, 6.11, 0), Angle(0, 0, -90) },
	-- [ 3] = { "Main", Vector(6.58, 6.11, 0), Angle(0, 0, -90) },

	-- [ 4] = { "Edge", Vector(-12.75, 3.71, 0.06), Angle(0, 74, -90) },
	-- [ 5] = { "Edge", Vector(12.75, 3.71, 0.06), Angle(0, -74, -90) },

	-- [ 6] = { "Edge", Vector(-13.24, 0, 0.06), Angle(0, 90, -90) },
	-- [ 7] = { "Edge", Vector(13.24, 0, 0.06), Angle(0, -90, -90) },
	
	-- [ 8] = { "Edge", Vector(-12.75, -3.71, 0.06), Angle(0, -74, -90) },
	-- [ 9] = { "Edge", Vector(12.75, -3.71, 0.06), Angle(0, 74, -90) },

	-- [10] = { "Main", Vector(-6.58, -6.11, 0), Angle(0, 0, -90) },
	-- [11] = { "Main", Vector(6.58, -6.11, 0), Angle(0, 0, -90) },
	-- [12] = { "Main", Vector(0, -6.11, 0), Angle(0, 0, -90) },

	[ 1] = { "Main", Vector(0, 6.11, 0), Angle(0, 0, 0) },
	[ 2] = { "Main", Vector(-6.58, 6.11, 0), Angle(0, 0, 0) },
	[ 3] = { "Main", Vector(6.58, 6.11, 0), Angle(0, 0, 0) },

	[ 4] = { "Edge", Vector(-12.75, 3.71, 0.06), Angle(0, 74, 0) },
	[ 5] = { "Edge", Vector(12.75, 3.71, 0.06), Angle(0, -74, 0) },

	[ 6] = { "Edge", Vector(-13.24, 0, 0.06), Angle(0, 90, 0) },
	[ 7] = { "Edge", Vector(13.24, 0, 0.06), Angle(0, -90, 0) },
	
	[ 8] = { "Edge", Vector(-12.75, -3.71, 0.06), Angle(0, 180-74, 0) },
	[ 9] = { "Edge", Vector(12.75, -3.71, 0.06), Angle(0, 180+74, 0) },

	[10] = { "Main", Vector(-6.58, -6.11, 0), Angle(0, 180+0, 0) },
	[11] = { "Main", Vector(6.58, -6.11, 0), Angle(0, 180+0, 0) },
	[12] = { "Main", Vector(0, -6.11, 0), Angle(0, 180+0, 0) },

	
	-- Macro function concept
	--[13] = MacroFunc({ "param", Vector(), Angle()})
}

-- COMPONENT.ColorMap = "[R] 2 4 6 8 10 [B] 3 5 7 9 11 [A] 12 [W] 1"
COMPONENT.ColorMap = "[R] 2 5 6 9 10 [B] 3 4 7 8 11 [A] 12 [W] 1"
-- COMPONENT.ColorMap = "[R] 2 5 6 9 10 [B] 3 4 7 8 11 [A] 12 [W] 1"

-- Allows for multiple lights to be treated as one when desired
COMPONENT.LightGroups = {
	["LeftEdge"] = { 5, 7, 9 },
	["RightEdge"] = { 4, 6, 8 },
	["Left"] = { 4, 6, 8, 10, 11 },
	["All"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	All = {
		Frames = {
			-- [0] = "1:~OFF 2:~OFF 3:~OFF 4:~OFF 5:~OFF 6:~OFF 7:~OFF 8:~OFF 9:~OFF 10:~OFF 11:~OFF 12:~OFF",
			[1] = "3 5 7 9 11",
			[2] = "2 4 6 8 10",
			[3] = "2 3 4 5 6 7 8 9 10 11",
			[4] = "1 2 3 4 5 6 7 8 9 10 11 12"
		},
		Sequences = {
			["PATTERN_1"] = sequence()
				:Alternate(1,2,4):Do(4):Add(0)
				:Flash(1,2,3):Do(3):Add(0)
				:Alternate(3,0,4):Do(4):Add(0)
				:Flash(3,0,3):Do(3):Add(0),
			["STEADY"] = { 4 }
		},
	
	},
	Edge = {
		Frames = {
			[1] = "LeftEdge",
			[2] = "RightEdge",

		},
		Sequences = {
			["Flash1"] = sequence():Alternate(1,2,4):Do(4):Add(0):Flash(1,2,3):Do(3)
		},
		Attributes = {
			Intensity = true
		}
	},
	Inner = {
		Frames = {
			-- [1] = "2=>(0.5,10,20) 3 10 11",
			-- [1] = "[R=>(0.5)] 2 3 10 11",
			-- [1] = { { 1, "R", {0.5,10,10} } },
			[1] = "2 3 10 11",
			[2] = "1 12",
		},
		Sequences = {
			["Flash1"] = sequence():Alternate(1,2,4):Do(4):Add(0):Flash(1,2,3):Do(3)
		}
	}
}


-- Alternate(1,2,4)
-- Flash(1,2,3)
-- Alternate(1,2,4):Do(3)
-- Flash(1,2,3):Do(3)

COMPONENT.Patterns = {
	["Emergency.Auxiliary"] = {
		["LEFT"] = { 
			-- All = "STEADY",
			All = "STEADY",

			-- Edge = "Flash1", 
			-- Inner = "Flash1" 
		}
	},
	["Emergency.Warning"] = {
		["STAGE_1"] = {
			All = "PATTERN_1",
			-- Edge = "Flash1",
			-- Inner = "Flash1"
			-- Stored internally as Emergency.Warning:STAGE_1
			-- TODO: conditional pattern implementation
			-- Edge = {
			-- 	Sequence = "ALT",
			-- 	If = {
			-- 		["Vehicle.Brake"] = { "Off" }
			-- 	}
			-- }
		}
	}
}



			--[[ 
			PatternConditionals = {
				?????
			},
			Patterns = {
				["Emergency.Warning:STAGE_1"] = "ALT"
			},
		]]