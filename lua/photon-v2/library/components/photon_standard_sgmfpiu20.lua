local startTime = SysTime()
if (Photon2.ReloadComponentFile()) then return end
---@class PhotonStandardSGMFPIU20 : PhotonLibraryComponent
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]
print("Component took: " .. tostring(SysTime() - startTime))

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2020 Ford Police Interceptor Utility"

-- Virtual component means the component doesn't spawn a model,
-- and will instead manipulate the existing vehicle entity.
COMPONENT.IsVirtual = true

-- Templates
-- Each name must be unique, even they aren't the same light class.
COMPONENT.Lighting = {
	["2D"] = {
		TailLights = {
			Width = 8,
			Height = 8,
			Material 			= "sprites/emv/legend_wide",
			MaterialOverlay 	= "sprites/emv/legend_wide",
			Scale 		= 1.2,
			Ratio 		= 2,
			Inverse		= Angle(0, 180, 0)
		}
	},
	["Sub"] = {
		TailSubMat = {}
	},
	["Mesh"] = {
		TailMesh = {}
	}
}

COMPONENT.Materials = {
	["@tail"] = {
		"UnlitGeneric",
		["$basetexture"] = "photon/whi_16px.png",
		["$vertexalpha"] = 1,
		["$vertexcolor"] = 1,
		["$color2"] = Vector( 255, 255, 0 )
	}
}

COMPONENT.LightStates = {
	["Sub"] = {
		["TAIL_OFF"] = {
			Material = nil
		},
		["TAIL_ON"] = {
			Material = "sentry/20fpiu_new/tail_on"
		}
	},
	["Mesh"] = {

	}
}

COMPONENT.Lights = {
	[1] = { "TailLights", Vector( -50, -100, 40 ), Angle( 0, 180, 0 ) },
	[2] = { "TailSubMat", Indexes = { 17 } },
	[3] = { "TailSubMat", Indexes = { 19 } },
	-- [3] = { "TailMesh", Vector(0, 0, 0), Angle(0, 90, 0) }
}

COMPONENT.ColorMap = "[R] 1"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	TailLights = {
		Frames = {
			[0] = "1:OFF 2:TAIL_OFF 3:TAIL_OFF",
			[1] = "2:TAIL_ON",
			[2] = "3:TAIL_ON",
			-- [1] = "1:R"
		},
		Sequences = {
			["ON"] = sequence():Flash(2, 1, 3):Do(3):Alternate( 2, 1, 6 ):Do(3)
		}
	}
}

COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			TailLights = "ON"
		}
	}
}