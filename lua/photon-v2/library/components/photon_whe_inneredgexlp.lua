if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "SGM"

COMPONENT.Credits = {
	Code = "SGM",
	Model = "SGM",
}

COMPONENT.Phase = nil

COMPONENT.PrintName = [[Whelen Inner Edge XLP]]

COMPONENT.Model = "models/sentry/props/inneredgexlp.mdl"

COMPONENT.RenderGroup = RENDERGROUP_OPAQUE

COMPONENT.DefineOptions = {
	Offset = {
		Arguments = { { "offset", "number" } },
		Description = "Adjusts the width.",
		Action = function( self, offset )
			self.Bones = self.Bones or {}
			self.Bones["left"] = self.Bones["left"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["left"][1] = Vector( offset, 0, -offset/2 )
			self.Bones["right"] = self.Bones["right"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["right"][1] = Vector( -offset, 0, -offset/2 )
		end
	},
}

COMPONENT.Templates = {
	["2D"] = {
		Light_full = {
		    Width = 2.7,
			Height = 1.375,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail.png").MaterialName,
			Scale = 1,
			VisibilityRadius = 0.5,
			ForwardVisibilityOffset = -0.5,
		},
		Light = {
		    Width = 2.7,
			Height = 1.375,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail2.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail2.png").MaterialName,
			Scale = 1,
			VisibilityRadius = 0.5,
			ForwardVisibilityOffset = -0.5,
		},
		Light2 = {
		    Width = 2.7,
			Height = 1.375,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail3.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/inneredge_detail3.png").MaterialName,
			Scale = 1,
			VisibilityRadius = 0.5,
			ForwardVisibilityOffset = -0.5,
		},
    }
}

COMPONENT.Elements = {
	[1] = { "Light_full", Vector( 6.4399, -0.54376, -2.1988 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[2] = { "Light", Vector( 3.6149, -0.54376, -1.3364 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[3] = { "Light", Vector( 0.789, -0.54376, -0.47393 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[4] = { "Light", Vector( -2.0351, -0.54376, 0.38852 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[5] = { "Light", Vector( -4.8601, -0.54376, 1.251 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[6] = { "Light", Vector( -7.6851, -0.54376, 2.1134 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },

	[7] = { "Light_full", Vector( -6.4399, -0.54376, -2.1988 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[8] = { "Light", Vector( -3.6149, -0.54376, -1.3364 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[9] = { "Light", Vector( -0.789, -0.54376, -0.47393 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[10] = { "Light", Vector( 2.0351, -0.54376, 0.38852 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[11] = { "Light", Vector( 4.8601, -0.54376, 1.251 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[12] = { "Light", Vector( 7.6851, -0.54376, 2.1134 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },

	[13] = { "Light2", Vector( 3.6149, -0.54376, -1.3364 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[14] = { "Light2", Vector( 0.789, -0.54376, -0.47393 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[15] = { "Light2", Vector( -2.0351, -0.54376, 0.38852 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[16] = { "Light2", Vector( -4.8601, -0.54376, 1.251 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },
	[17] = { "Light2", Vector( -7.6851, -0.54376, 2.1134 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "left", },

	[18] = { "Light2", Vector( -3.6149, -0.54376, -1.3364 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[19] = { "Light2", Vector( -0.789, -0.54376, -0.47393 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[20] = { "Light2", Vector( 2.0351, -0.54376, 0.38852 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[21] = { "Light2", Vector( 4.8601, -0.54376, 1.251 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
	[22] = { "Light2", Vector( 7.6851, -0.54376, 2.1134 - 0.5 ), Angle( 90, 0, 0 ), IntensityGainFactor = 10, IntensityLossFactor = 10, BoneParent = "right", },
}

COMPONENT.ElementStates = {
	["2D"] = {

	}
}

COMPONENT.StateMap = "[W] 1 7 13 14 15 16 17 18 19 20 21 22 [R] 2 3 4 5 6 [B] 8 9 10 11 12"

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12",
			[2] = "2 3 4 5 6",
			[3] = "8 9 10 11 12",
			[4] = "[~R] 2 3 4 5 6",
			[5] = "[~B] 8 9 10 11 12",
			[6] = "[W] 1 7 13 14 15 16 17 18 19 20 21 22",
		},
		Sequences = {
			["ON"] = { 1 },
			["QUADFLASH"] = sequence():QuadFlash(2, 3),
			["ALT"] = sequence():Alternate(4,5,8),
			["FLOOD"] = { 6 },
		}
	},
	Inner = {
		Frames = {
			[1] = "2 3",
			[2] = "8 9",
		},
		Sequences = {
			["FLASH"] = sequence():TripleFlash(1):Add(1):Hold(4):AppendPhaseGap():TripleFlash(2):Add(2):Hold(4):AppendPhaseGap(),
		}
	},
	Center = {
		Frames = {
			[1] = "4 5",
			[2] = "10 11",
		},
		Sequences = {
			["FLASH"] = sequence():TripleFlash(1):Add(1):Hold(4):AppendPhaseGap():TripleFlash(2):Add(2):Hold(4):AppendPhaseGap(),
		}
	},
	Outer = {
		Frames = {
			[1] = "6",
			[2] = "12",
		},
		Sequences = {
			["FLASH"] = sequence():TripleFlash(1):Add(1):Hold(4):AppendPhaseGap():TripleFlash(2):Add(2):Hold(4):AppendPhaseGap(),
		}
	},
	Takedown = {
		Frames = {
			[1] = "1",
			[2] = "7",
			[3] = "1 7",
		},
		Sequences = {
			["ALT"] = sequence():Alternate(1,2,5),
			["ON"] = { 3 },
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ALT"
		},
		["MODE2"] = {
			Light = "QUADFLASH"
		},
		["MODE3"] = {
			Takedown = "ALT",
			Inner = "FLASH:90",
			Center = "FLASH:45",
			Outer = "FLASH:0",
		}
	},
	["Emergency.SceneForward"] = {
		["ON"] = {
			Takedown = "ON"
		},
		["FLOOD"] = {
			Light = "FLOOD"
		}
	},
}