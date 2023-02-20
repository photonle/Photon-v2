-- This line is required here for save-reloading to work.
if (Photon2.ReloadComponent("photon_fedsig_jetsolaris")) then return end

COMPONENT.Author = "Photon"

-- Printed name of component ONLY. Reference component
-- using its filename or directory/filename.
COMPONENT.PrintName = "Federal Signal Jet Solaris"

COMPONENT.Model = "models/schmal/fedsig_jetsolaris.mdl"

COMPONENT.Lighting = {
	-- Light Class
	-- 2D is what's used by Photon v1
	["2D"] = {
		-- Light Template (similar to COMPONENT.Meta)
		-- Name must be unique, regardless of its light class
		Main = {
			Width 		= 7.4,
			Height		= 7.4,

			-- Material is equivalent to Sprite
			-- Specifies the material used for the light source
			Material 	= "sprites/emv/legend_wide",

			-- Scales the size of the light glow
			Scale 		= 1.5,

			-- Ratio is equivalent to WMult
			-- Default is 1. > 1 widens glow, < 1 narrows glow.
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
	-- Default syntax: { Template name, Vector local position, Angle local angle }
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
			[1] = { { 4, "R" }, { 6, "R" }, { 8, "R" } },
			[2] = { { 5, "B"}, { 7, "B" }, { 9, "B" } }
		},
		Sequences = {
			["ALT"] = (alternate())
		},

	}
}

-- TODO
COMPONENT.Patterns = {
	["Emergency.Warning"] = {
		["Mode1"] ={
			-- ["a"] = {}
		}
	}
}

PrintTable(COMPONENT)