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

local s = 1

-- Templates
-- Each name must be unique, even they aren't the same light class.
COMPONENT.Templates = {
	["2D"] = {
		TailLights = {
			Width = 20,
			Height = 20,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			-- Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			Scale 		= 2,
			Ratio 		= 1,
			Inverse		= Angle(0, 180, 0),
			DrawLightPoints = false,
			ForwardBloomOffset = 0
		},
		TailLightsAlt = {
			Width = 20,
			Height = 20,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_alt_shape.png").MaterialName,
			-- Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_tail_shape.png").MaterialName,
			Scale 		= 2,
			Ratio 		= 1,
			Inverse		= Angle(0, 180, 0),
			DrawLightPoints = false,
			ForwardBloomOffset = 0
		},
		TailLightEdge = {
			Width = 3,
			Height = 11,
			DrawLightPoints = false
		},
		Turn = {
			Width = 6.3,
			Height = 6.3,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_turn_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_turn_detail.png").MaterialName,
			Scale = 2,
			ForwardBloomOffset = 0.3
		},
		Reverse = {
			Width = 5.4,
			Height = 5.4,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_rev_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_rev_bloom.png").MaterialName,
			Scale = 2,
			ForwardBloomOffset = 0.5
		},
		Brake = {
			Width = 11.2,
			Height = 1.8,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_brake_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_brake_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_brake_bloom.png").MaterialName,
			Scale = 0.5,
			LightMatrix = {
				-- Vector( s * 1, 0, 0 ), Vector( -s * 1, 0, 0 ), 
				Vector( s * 2, 0, 0 ), Vector( -s * 2, 0, 0 ), 
				-- Vector( s * 3, 0, 0 ), Vector( -s * 3, 0, 0 ), 
				Vector( s * 4, 0, 0 ), Vector( -s * 4, 0, 0 ), 
			},
			LightMatrixScaleMultiplier = 2
		},
		Marker = {
			Width = 3.2,
			Height = 3.2,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_marker_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_marker_bloom.png").MaterialName,
			Scale = 0.4,
			LightMatrix = {
				Vector( .9, 0, 0 ), Vector( -.9, 0, 0 )
			}
		},
		Park = {
			Width = 5,
			Height = 1.5,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_park_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_park_detail.png").MaterialName,
			MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_park_bloom.png").MaterialName,
			Scale = 0.2,
			LightMatrix = {
				Vector( 1 * 1, 0, 0 ), Vector( -1 * 1, 0, 0 ), 
			},
			LightMatrixScaleMultiplier = 2
		},
		Headlight = {
			Width = 6.8,
			Height = 3.4,
			Shape = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_shape.png").MaterialName,
			Detail = PhotonDynamicMaterial.GenerateLightQuad("photon/lights/sgm_fpiu20_headlight_detail.png").MaterialName,
			-- MaterialBloom = PhotonDynamicMaterial.GenerateBloomQuad("photon/lights/sgm_fpiu20_headlight_bloom.png").MaterialName,
			Scale = 0.5,
			LightMatrix = {
				Vector( 1 * 1, 0, 0 ), Vector( -1 * 1, 0, 0 ), 
			},
			ForwardVisibilityOffset = -1,
			ForwardBloomOffset = 0.5,
			Persist = true
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

COMPONENT.ElementStates = {
	["2D"] = {
		["TD"] = {
			Inherit = "R",
			Intensity = 0.5
		},
		["TB"] = { Inherit = "R" },
		["A0.5"] = {
			Inherit = "A",
			Intensity = 0.8
		},
		["A1.2"] = {
			Inherit = "A",
			Intensity = 1.2
		}
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
	["Fwd_L"] = { 13, 15, 17, 19 },
	["Fwd_R"] = { 14, 16, 18, 20 }
}

COMPONENT.Elements = {
	[1] = { "TailLights", Vector( -38, -121.6, 50.8 ), Angle( 0, 180-25, 0 ) },
	[2] = { "TailSubMat", Indexes = { 17 } },
	[3] = { "TailLightEdge", Vector( -41.7, -119.5, 51.5 ), Angle( 0, 180-81, 0 ) },
	[4] = { "TailLightsAlt", Vector( 38, -121.6, 50.8 ), Angle( 0, 180+25, 0 ) },
	[5] = { "TailSubMat", Indexes = { 19 } },
	[6] = { "TailLightEdge", Vector( 41.7, -119.5, 51.5 ), Angle( 0, 180+81, 0 ) },

	[7] = { "Turn", Vector( -36.4, -122.9, 47.9 ), Angle( 0, 180-22.5, 0 ) },
	[8] = { "Turn", Vector( 36.4, -122.9, 47.9 ), Angle( 0, 180+22.5, 0 ), FlipHorizontal = true },

	[9] = { "Reverse", Vector( -36.4, -122.6, 52.4 ), Angle( 0, 180-22.5, 0 ) },
	[10] = { "Reverse", Vector( 36.4, -122.6, 52.4 ), Angle( 0, 180+22.5, 0 ), FlipHorizontal = true },
	
	[11] = { "Brake", Vector( -5, -112, 78.1), Angle( 0, 180-4, 0 ) },
	[12] = { "Brake", Vector( 5, -112, 78.1), Angle( 0, 180+4, 0 ), FlipHorizontal = true },

	[13] = { "Marker", Vector( -43.4, 92.8, 49.3), Angle( -20, 72, 6 ) },
	[14] = { "Marker", Vector( 43.4, 92.8, 49.3), Angle( 180+20, 180-72, -6 ) },
	
	[15] = { "Park", Vector( -27, 110.6, 50.35), Angle( 0, 25, 1.5 ) },
	[16] = { "Park", Vector( 27, 110.6, 50.35), Angle( 180, 180-25, -1.5 ) },
	[17] = { "Park", Vector( -24.2, 111.7, 50.28), Angle( 0, 15, 1.5 ), Width = 2.8 },
	[18] = { "Park", Vector( 24.2, 111.7, 50.28), Angle( 180, 180-15, -1.5 ), Width = 2.8 },
	[19] = { "Park", Vector( -29.94, 109.08, 50.44), Angle( 0, 31, 1.8 ), Width = 3.5 },
	[20] = { "Park", Vector( 29.94, 109.08, 50.44), Angle( 180, 180-31, -1.8 ), Width = 3.5 },
	
	[21] = { "Headlight", Vector( -28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Persist = true, Scale = 1 }, -- headlight upper
	[22] = { "Headlight", Vector( 28.8, 105.1, 48.6 ), Angle( 0, 0, 0 ), Scale = 1 }, -- headlight upper

	[23] = { "Headlight", Vector( -28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 }, -- headlight lower
	[24] = { "Headlight", Vector( 28.8, 105.1, 46.9 ), Angle( 0, 0, 180 ), Scale = 1 },-- headlight lower
	
	[25] = { "Headlight", Vector( -36.4, 99.5, 49.2), Angle( 0, 0, 0 ) }, -- high-beam upper
	[26] = { "Headlight", Vector( 36.4, 99.5, 49.2 ), Angle( 0, 0, 0 ) }, -- high-beam upper

	[27] = { "Headlight", Vector( -36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower
	[28] = { "Headlight", Vector( 36.4, 99.5, 47.3 ), Angle( 0, 0, 180 ) }, -- high-beam lower

}

COMPONENT.ColorMap = "[R] 1"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Headlights = {
		Frames = {
			-- [0] = "Tail_L:OFF Tail_R:OFF",
			[1] = "Tail_L:TD Tail_R:TD"
		},
		Sequences = {
			["HEADLIGHTS"] = { 1 },
			["PARKING"] = { 1 }
		}
	},
	Tail_L = {
		Frames = {
			[0] = "Tail_L:PASS",
			[1] = "Tail_L:TB"
		},
		Sequences = {
			["BRAKE"] = { 1 },
			-- ["FLASH"] = { 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0 }
			["FLASH"] = sequence():Alternate( 0, 1, 5 )
		}
	},
	Tail_R = {
		Frames = {
			[0] = "Tail_R:PASS",
			[1] = "Tail_R:TB"
		},
		Sequences = {
			["BRAKE"] = { 1 },
			-- ["FLASH"] = { 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0 }
			["FLASH"] = sequence():Alternate( 0, 1, 5 )

		}
	},
	Turn_L = {
		Frames = {
			[1] = "7:A",
			[2] = "7:B"
		},
		Sequences = {
			["ON"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
			-- ["FLASH"] = { 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, }
			["FLASH"] = sequence():Alternate( 2, 0, 5 )
		}
	},
	Turn_R = {
		Frames = {
			[1] = "8:A",
			[2] = "8:B",
		},
		Sequences = {
			["ON"] = { 1 },
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 ),
			["FLASH"] = sequence():Alternate( 2, 0, 5 )

		}
	},
	Reverse_L = {
		Frames = { [1] = "9:W", [2] = "9:B" },
		Sequences = { 
			["ON"] = { 1 },
			["FLASH"] = { 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0 }
		}
	},
	Reverse_R = {
		Frames = { [1] = "10:W", [2] = "10:B" },
		Sequences = { 
			["ON"] = { 1 },
			["FLASH"] = { 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0 }
		}
	},
	Brake = {
		Frames = { [1] = "11:R 12:R" },
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Marker = {
		Frames = { [1] = "13:A0.5 14:A0.5" },
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Parking_L = {
		Frames = { [1] = "15:A0.5 17:A0.5 19:A0.5" },
		Sequences = {
			["ON"] = { 1 }
		}
	},
	Parking_R = {
		Frames = {
			[1] = "16:A0.5 18:A0.5 20:A0.5"
		},
		Sequences = {
			["ON"] = { 1 }
		}
	},
	HighBeam_L = {
		Frames = {
			[1] = "21:W 23:W",
		},
		Sequences = {
			["ON"] = { 1 },
			["WIG-WAG"] = sequence():Alternate( 1, 0, 6 )
		}
	},
	HighBeam_R = {
		Frames = {
			[1] = "22:W 24:W"
		},
		Sequences = {
			["ON"] = { 1 },
			["WIG-WAG"] = sequence():Alternate( 0, 1, 6 )
		}
	},
	Headlight_L = {
		Frames = {
			[1] = "25:W 27:W",
		},
		Sequences = {
			["ON"] = { 1 },
			["WIG-WAG"] = sequence():Alternate( 0, 1, 6 )
		}
	},
	Headlight_R = {
		Frames = {
			[1] = "26:W 28:W"
		},
		Sequences = {
			["ON"] = { 1 },
			["WIG-WAG"] = sequence():Alternate( 1, 0, 6 )
		}
	},
	FwdSignal_L = {
		Frames = {
			[0] = "13:PASS 15:PASS 17:PASS 19:PASS",
			[1] = "13:A1.2 15:A1.2 17:A1.2 19:A1.2"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 )
		}
	},
	FwdSignal_R = {
		Frames = {
			[0] = "14:PASS 16:PASS 18:PASS 20:PASS",
			[1] = "14:A1.2 16:A1.2 18:A1.2 20:A1.2"
		},
		Sequences = {
			["SIGNAL"] = sequence():Alternate( 1, 0, 8 )
		}
	}
	-- Parking_R = {

	-- }
}

--TODO: verify that sequences exist on compilation
COMPONENT.Inputs = {
	["Vehicle.Elements"] = {
		["HEADLIGHTS"] = {
			Headlights = "HEADLIGHTS",
			Marker = "ON",
			Parking_L = "ON",
			Parking_R = "ON",
			Headlight_L = "ON",
			Headlight_R = "ON",
		},
		["PARKING"] = {
			Headlights = "HEADLIGHTS",
			Marker = "ON",
			Parking_L = "ON",
			Parking_R = "ON",
		}
	},
	["Vehicle.HighBeam"] = {
		["HIGH_BEAMS"] = {
			HighBeam_L = "ON",
			HighBeam_R = "ON"
		}
	},
	["Emergency.Warning"] = {
		["MODE1"] = {
			Tail_L = "FLASH",
			Tail_R = "FLASH",
			Turn_L = "FLASH",
			Turn_R = "FLASH",
		},
		["MODE3"] = {
			HighBeam_L = "WIG-WAG",
			HighBeam_R = "WIG-WAG",
			Tail_L = "FLASH",
			Tail_R = "FLASH",
			Turn_L = "FLASH",
			Turn_R = "FLASH",
		}
	},
	["Vehicle.Brake"] = {
		["BRAKE"] = {
			Tail_L = "BRAKE",
			Tail_R = "BRAKE",
			Brake  = "ON"
		}
	},
	["Vehicle.Signal"] = {
		["LEFT"] = {
			Turn_L = "SIGNAL",
			FwdSignal_L = "SIGNAL"
		},
		["RIGHT"] = {
			Turn_R = "SIGNAL",
			FwdSignal_R = "SIGNAL"
		},
		["HAZARD"] = {
			Turn_L = "SIGNAL",
			Turn_R = "SIGNAL",
			FwdSignal_L = "SIGNAL",
			FwdSignal_R = "SIGNAL"
		}
	},
	["Vehicle.Transmission"] = {
		["REVERSE"] = {
			Reverse_L = "ON",
			Reverse_R = "ON",
		}
	}
}