-- This line is required here for save-reloading to work.
if (Photon2.ReloadComponent("photon_fedsig_jetsolaris")) then return end

---@type PhotonLibraryComponent
COMPONENT = COMPONENT

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
			Material 	= "sprites/emv/legend_wide",
			Scale 		= 1.5,
			Ratio 		= 1.5
		},
		Edge = {
			Width 		= 7.2,
			Height		= 7.2,
			Material 	= "sprites/emv/legend_narrow",
			Scale 		= 1.5,
			Ratio 		= 1
		}
	}
}

COMPONENT.Lights = {
	[ 1] = { "Main", Vector(0, 6.11, 0), Angle(0, 0, 0) },
	[ 2] = { "Main", Vector(-6.58, 6.11, 0), Angle(0, 0, 0) },
	[ 3] = { "Main", Vector(6.58, 6.11, 0), Angle(0, 0, 0) },

	[ 4] = { "Edge", Vector(-12.75, 3.71, 0.06), Angle(0, 74, 0) },
	[ 5] = { "Edge", Vector(12.75, 3.71, 0.06), Angle(0, -74, 0) },

	[ 6] = { "Edge", Vector(-13.24, 3.71, 0.06), Angle(0, 90, 0) },
	[ 7] = { "Edge", Vector(13.24, 3.71, 0.06), Angle(0, -90, 0) },
	
	[ 8] = { "Edge", Vector(-12.75, -3.71, 0.06), Angle(0, -74, 0) },
	[ 9] = { "Edge", Vector(12.75, -3.71, 0.06), Angle(0, 74, 0) },

	[10] = { "Main", Vector(-6.58, -6.11, 0), Angle(0, 0, 0) },
	[11] = { "Main", Vector(6.58, -6.11, 0), Angle(0, 0, 0) },
	[12] = { "Main", Vector(0, -6.11, 0), Angle(0, 0, 0) },

	-- Macro function concept
	--[13] = MacroFunc({ "param", Vector(), Angle()})
}

COMPONENT.ColorMap = {
	[ 1] = { "R" },
	[ 2] = { "R" },
	[ 3] = { "R" },
	[ 4] = { "R" },
	[ 5] = { "R" },
	[ 6] = { "R" },
	[ 7] = { "R" },
	[ 8] = { "R" },
	[ 9] = { "R" },
	[10] = { "R" },
	[11] = { "R" },
	[12] = { "B" },
}

-- Allows for multiple lights to be treated as one when desired
COMPONENT.LightGroups = {
	["LeftEdge"] = { 5, 7, 9 },
	["RightEdge"] = { 4, 6, 8 },
}

local function alternate()
	return  { 1, 1, 1, 2, 2, 2 }
end

COMPONENT.Segments = {
	Edge = {
		Frames = {
			-- Frame[0] defines the segment's default state (usually all lights off)
			-- it's only here for reference, as this will ultimately be handled automatically
			[0] = { {1, "OFF"}, {2, "OFF"}, {3, "OFF"}, {4, "OFF"}, {5, "OFF"}, {6, "OFF"}, {7, "OFF"}, {8, "OFF"}, {9, "OFF"}, {10, "OFF"}, {11, "OFF"}, {12, "OFF"} },
			[1] = { { 4, "R" }, { 6, "R" }, { 8, "R" } },
			-- [1] = { ["R"] = { 4, 5, 6 } },
			[2] = { { 5, "B" }, { 7, "B" }, { 9, "B" } },
			-- [1] = { ["B"] = { 5, 7, 9 } },
			[3] = {  },
			[4] = {  }, 
		},
		Sequences = {
			["ALT"] = {1, 1, 1, 2, 2, 2}
		},
		--[[ 
			PatternConditionals = {
				?????
			},
			Patterns = {
				["Emergency.Warning:STAGE_1"] = "ALT"
			},
		]]
	}
}

COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["STAGE_1"] = {
			Edge = "ALT"
			-- Stored internally as Emergency.Warning:STAGE_1
			-- TODO: conditional pattern implementation
			-- Edge = {
			-- 	Sequence = "ALT",
			-- 	If = {
			-- 		["Vehicle.Brake"] = { "Off" }
			-- 	}
			-- }
		}
	},
	["Emergency.Auxiliary"] = {
		["LEFT"] = { Edge = "ALT" }
	}
}
