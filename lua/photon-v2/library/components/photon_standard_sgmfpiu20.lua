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
	TailLights = {
		Frames = {
			[1] = "2:TD",
			[2] = "Tail_L:TD Tail_R:TD",
			[3] = "Tail_L:TB Tail_R:TB",
			[4] = "2:TD 3:TB 5:R 6:R 1:TD 4:TD",
			[5] = "2:TB 3:TD 1:R 4:R 5:TD 6:TD",
			-- [4] = "5:TAIL_DIM 6 "
			-- [1] = "1:R"
		},
		Sequences = {
			["FLASH"] = sequence():Flash(2, 1, 3):Do(3):Alternate( 2, 1, 6 ):Do(3),
			["ON"] = { 3 },
			-- ["ON"] = sequence():Add(3):Do(12):Add(2):Do(6):Add(0):Do(6):Add(2):Do(6),
			["FLASH_3"] = { 4, 3, 4, 3, 4, 3, 5, 3, 5, 3, 5, 3 }
			-- ["FLASH_3"] = sequence():Flash( 4, 5, 3 )
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