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

-- local tailDimMaterial = PhotonDynamicMaterial.Create("sgm_fpiu20_tail_dim", {
-- 	"VertexLitGeneric",
-- 	["$basetexture"] = Material("photon/textures/sgm_fpiu20_tail_dim.png", "noclamp nocull"),
-- 	["$bumpmap"] = "sentry/shared/skin_nm",
-- 	["$translucent"] = "1",
-- 	["$color2"] = "[2 2 0]",
-- 	["Proxies"] = {
-- 		["Equals"] = {
-- 			["srcVar1"] = "$color2",
-- 			["resultVar"] = "$color"
-- 		}
-- 	}
-- })

-- local tailBrightMaterial = PhotonDynamicMaterial.Create("sgm_fpiu20_tail_bright", {
-- 	"UnlitGeneric",
-- 	["$basetexture"] = "photon/materials/sgm_fpiu20_tail_dim",
-- 	-- ["$basetexture"] = "photon/textures/sgm_fpiu20_tail_bright.png",
-- 	["$bumpmap"] = "sentry/shared/skin_nm",
-- 	["$translucent"] = 1,
-- 	["$color2"] = "[2 2 0]",
-- 	["Proxies"] = {
-- 		["Equals"] = {
-- 			["srcVar1"] = "$color2",
-- 			["resultVar"] = "$color"
-- 		}
-- 	}
-- })

local testMat

if CLIENT then
		
	-- local brightTexture = Material("photon/textures/sgm_fpiu20_tail_bright.png"):GetTexture("$basetexture"):GetName()
	-- local dimTexture = Material("photon/textures/sgm_fpiu20_tail_dim.png"):GetTexture("$basetexture"):GetName()


	-- testMat = CreateMaterial("tail_testsxyza", "UnlitGeneric", {
	-- 	-- ["$basetexture"] = "photon/materials/sgm_fpiu20_tail_dim",
	-- 	["$basetexture"] = brightTexture,
	-- 	-- ["$basetexture"] = "photon/textures/sgm_fpiu20_tail_bright.png",
	-- 	["$bumpmap"] = "sentry/shared/skin_nm",
	-- 	["$translucent"] = "1",
	-- 	["$color2"] = Vector(0, 0, 0),
	-- 	-- ["$color2"] = "[10 10 0]",
	-- 	["Proxies"] = {
	-- 		["Equals"] = {
	-- 			["srcVar1"] = "$color2",
	-- 			["resultVar"] = "$color",
	-- 		}
	-- 	}
	-- })

	-- testMat:SetVector("$color2", Vector(0.9, 0.9, 0))
	-- -- testMat:SetString("$color2", "[10 10 0]")
	-- -- testMat:Recompute()

	-- testMat = testMat:GetName()
end

-- Templates
-- Each name must be unique, even they aren't the same light class.
COMPONENT.Lighting = {
	["2D"] = {
		TailLights = {
			Width = 20,
			Height = 19,
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			-- MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_tail_bloom.png").MaterialName,
			Scale 		= 2,
			Ratio 		= 1,
			Inverse		= Angle(0, 180, 0),
			DrawLightPoints = false,
			ForwardBloomOffset = 0
		},
		TailLightsAlt = {
			Width = 20,
			Height = 19,
			Material = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_alt_shape.png").MaterialName,
			-- MaterialOverlay = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_tail_alt_bloom.png").MaterialName,
			Scale 		= 2,
			Ratio 		= 1,
			Inverse		= Angle(0, 180, 0),
			DrawLightPoints = false,
			ForwardBloomOffset = 0
		},
		TailLightEdge = {
			Width = 3,
			Height = 11,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/generic_square_256.png").MaterialName,
			DrawLightPoints = false
		},
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
		["$color2"] = Vector( 10, 10, 0 )
	}
}

COMPONENT.LightStates = {
	["2D"] = {
		["TD"] = {
			Inherit = "R",
			Intensity = 0.5
		},
		["TB"] = { Inherit = "R" }
	},
	["Sub"] = {
		["OFF"] = {
			Material = nil
		},
		["TD"] = {
			-- Material = tailDimMaterial.MaterialName
			-- Material = "!" .. testMat
			-- Material = "!" .. testMat
			Material = "photon/materials/sgm_fpiu20_tail_dim"
		},
		["TB"] = {
			Material = "photon/materials/sgm_fpiu20_tail_bright"
		}
	},
	["Mesh"] = {

	}
}

COMPONENT.LightGroups = {
	["Tail_L"] = { 1, 2, 3 },
	["Tail_R"] = { 4, 5, 6 },
}

COMPONENT.Lights = {
	[1] = { "TailLights", Vector( -38.3, -121.6, 50.8 ), Angle( 0, 180-27, 0 ) },
	[2] = { "TailSubMat", Indexes = { 17 } },
	[3] = { "TailLightEdge", Vector( -41.7, -119.5, 51.5 ), Angle( 0, 180-81, 0 ) },
	[4] = { "TailLightsAlt", Vector( 38.3, -121.6, 50.8 ), Angle( 0, 180+27, 0 ) },
	[5] = { "TailSubMat", Indexes = { 19 } },
	[6] = { "TailLightEdge", Vector( 41.7, -119.5, 51.5 ), Angle( 0, 180+81, 0 ) },
	-- [3] = { "TailMesh", Vector(0, 0, 0), Angle(0, 90, 0) }
}

COMPONENT.ColorMap = "[R] 1"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Tail = {
		Frames = {
			[1] = "Tail_L:TB",
			[2] = "Tail_R:TB",
			[3] = "Tail_L:TB Tail_R:TB",
			[4] = "Tail_L:TD Tail_R:TD",
		},
		Sequences = {
			["TAIL"] = { 4 },
			["BRAKE"] = { 3 },
			["BRAKE2"] = { 3 },
			["LEFT"] = sequence():Alternate( 1, 0, 8 ),
			["RIGHT"] = sequence():Alternate( 2, 0, 8 ),
			["HAZARD"] = sequence():Alternate( 3, 0, 8 ),
		}
	}
}

--TODO: verify that sequences exist on compilation
COMPONENT.Patterns = {
	["Vehicle.Lights"] = {
		["HEADLIGHTS"] = {
			Tail = "TAIL",
			-- { "Tail", "TAIL" },
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Tail = "BRAKE"
		},
		["BRAKE2"] = {
			Tail = "BRAKE2"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Tail = "LEFT"
		},
		["RIGHT"] = {
			Tail = "RIGHT"

		},
		["HAZARD"] = {
			Tail = "HAZARD"

		}
	}
}