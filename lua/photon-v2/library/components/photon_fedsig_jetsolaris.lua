if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Modified by Schmal",
	Code = "Schmal"
}

-- Printed name of component ONLY. Reference component
-- using its filename or directory/filename.
COMPONENT.PrintName = "Federal Signal Jet Solaris"

COMPONENT.Model = "models/schmal/fedsig_jetsolaris.mdl"

COMPONENT.Templates = {
	["2D"] = {
		Main = {
			Width 		= 7.4,
			Height		= 7.4,
			Detail 	= "photon/lights/legend_wide_leds",
			Shape 			= "sprites/emv/legend_wide",
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0)
		},
		Edge = {
			Width 		= 7.2,
			Height		= 7.2,
			Detail 	= "photon/lights/legend_narrow_leds",
			Shape 	= "sprites/emv/legend_narrow",
			Scale 		= 1,
			Ratio 		= 1,
			Inverse		= Angle(0, 180, 0)
		}
	}
}

COMPONENT.ElementStates = {
	["2D"] = {
		["R0.5"] = {
			Inherit = "R",
			Intensity = 1,
			IntensityTransitions = true,
		},
		["W0"] = {
			Inherit = "W",
			Intensity = 1,
			IntensityTransitions = false
		}
	}
}

COMPONENT.Elements = {
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

	--[[
		
		==== The "Build" Scripting Syntax Concept ====

		Instead of the traditional format of { "Meta", Vector(), Angle() },
		the Build feature internally parses a string to accomplish this,
		making light creation less repetitive and potentially easier.

		Furthermore, the Build syntax allows lights to reference specific
		existing values of sibling lights, and even invert them
		by use of the - sign. 

		For example, a standard linear bar (that's correctly centered and oriented)
		will typically have four congruent lights: forward-left, forward-right,
		rear-left, rear-right. Apart from the positive or negative X/Y placement and 
		Yaw rotation, these lights are otherwise identical (congruent). 

		By simplying referencing the values of a "master" light (usually forward-left),
		you can skip the steps of repetitively copying and pasting values when making
		adjustments.

	--]]

	
	-- [1] = { Build = "Main [0 6.11 0] {0 0 0}" },


	-- [2] = { Build = "@ [-6.58 Y Z] {P Y R}" },
	-- [3] = { Mirror = { 2, 2 } },
	-- -- [3] = { Build = "@ [-X Y Z] {P Y R}" },

	-- [4] = { Build = "Edge [-12.75 3.71 .06] {0 74 0}" },
	-- [5] = { Build = "[-X Y Z] {P -Y R}"},

	-- [6] = { Build = "[-13.24 0 R] {0 90 0}" },
	-- [7] = { Build = "[-X Y Z] {P -Y R}" },

	-- [8] = { Build = "^4 -@ [X -Y Z] {P -Y R}" },
	-- [9] = { Build = "@ [X -Y Z] {P -Y R}" },

	-- [10] = { Build = "^2 -@ [X -Y Z] {P Y R}" },
	-- [11] = { Build = "^3 -@ [X -Y Z] {P Y R}" },

	-- [12] = { Build = "^1 -@ [X -Y Z] {P Y R}" },

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
	
}

COMPONENT.ColorMap = "[R] 2 5 9 10 7 [B] 3 4 8 11 6 [A] 12 [W] 1"

-- Allows for multiple lights to be treated as one when desired
COMPONENT.LightGroups = {
	["LeftEdge"] = { 5, 7, 9 },
	["RightEdge"] = { 4, 6, 8 },
	["Left"] = { 4, 6, 8, 10, 11 },
	["Right"] = { 4, 6, 8, 10, 11 },
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
			["STEADY"] = { 4 },
			["SLOW"] = sequence():Alternate( 1, 2, 5 )
		},
	
	},
	Edge = {
		Frames = {
			[1] = "LeftEdge",
			[2] = "RightEdge",
			[3] = "9 4",
			[4] = "7 6",
			[5] = "5 8",
		},
		Sequences = {
			["Flash1"] = sequence():Alternate(1,2,4):Do(4):Add(0):Flash(1,2,3):Do(3),
			["Rotate"] = { 3, 4, 5, },
			["Slow"] = sequence():Alternate( 2, 1, 5 )
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
			[3] = "3 10",
			[4] = "12 1",
			[5] = "11 2",
		},
		Sequences = {
			["Flash1"] = sequence():Alternate(1,2,4):Do(4):Add(0):Flash(1,2,3):Do(3),
			["Rotate"] = { 3, 4, 5 }
		}
	}
}


-- Alternate(1,2,4)
-- Flash(1,2,3)
-- Alternate(1,2,4):Do(3)
-- Flash(1,2,3):Do(3)

COMPONENT.Patterns = {
	-- ["Emergency.Auxiliary"] = {
	-- 	["LEFT"] = { 
	-- 		-- All = "STEADY",
	-- 		-- All = "PATTERN_1",

	-- 		Edge = "Rotate", 
	-- 		Inner = "Rotate" 
	-- 	}
	-- },
	["Vehicle.Elements"] = {
		["HEADLIGHTS"] = {
			All = "SLOW"
			-- All = "PATTERN_1",
			
			-- TODO: MAKE THIS ERROR
			-- Edge = "Slow",
			
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