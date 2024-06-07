if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "Twurtleee, Schmal",
	Code = "Schmal"
}

COMPONENT.Title = [[Federal Signal Valor (44")]]
COMPONENT.Category = "Lightbar"
COMPONENT.Model = "models/schmal/fedsig_valor_44.mdl"

COMPONENT.Preview = {
	Position = Vector( 0, 0, -0.5 ),
	Angles = Angle( 0, 180, 0 ),
	Zoom = 1.2
}

-- Prototype of component options
COMPONENT.DefineOptions = {
	-- Unique option name
	Feet = {
		-- Annotations of the function arguments (for possible validation and UI integration later)
		Arguments = { [1] = { "amount", "number" } },
		-- What the option does
		Description = "Adjusts the feet extension height.",
		-- The action performed, which will probably be a function but macros may come later
		Action = function( self, height )
			local scale = self.Scale or 1
			self.Bones = self.Bones or {}
			self.Bones["valor_44_feet_left"] = { Vector( height/-4.2857, 0, height ) * scale, Angle( 0, 0, 0 ), 1 }
			self.Bones["valor_44_feet_right"] = { Vector( height/4.2857, 0, height ) * scale, Angle( 0, 0, 0 ), 1 }
		end
	},
	ForwardHotFeet = {
		Arguments = { [1] = { "enabled", "boolean" } },
		Description = "Enable or disable the forward hotfeet.",
		Action = function( self, enabled )
			self.BodyGroups = self.BodyGroups or {}
			self.BodyGroups["forward_hotfeet"] = enabled and 0 or 1
		end
	},
	AlleyHotFeet = {
		Arguments = { [1] = { "enabled", "boolean" } },
		Description = "Enable or disable the alley hotfeet.",
		Action = function( self, enabled )
			self.BodyGroups = self.BodyGroups or {}
			self.BodyGroups["alley_hotfeet"] = enabled and 0 or 1
		end
	}
}

COMPONENT.Templates = {
	["2D"] = {
		Primary = {
			Width 		= 6.2,
			Height		= 3.3,
			-- Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Detail 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_detail.png").MaterialName,
			Shape 		= PhotonMaterial.GenerateLightQuad("photon/lights/fs_valor_shape.png").MaterialName,
			Scale 		= 1.2,
			Ratio 		= 2,
			VisibilityRadius = 0.5
		},
		HotFoot = {
			-- Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/visionslr_sm_shape.png").MaterialName,
			Width = 5,
			Height = 5/2,
			Scale = 1,
			States = {
				DW = { Inherit = "W", Intensity = 0.4 }
			},
			-- RequiredBodyGroups = {
				-- Requires HotFeet body-group
				-- [2] = 0
			-- }
		}
	}
}

COMPONENT.Elements = {
	[1] = { "Primary", Vector( 10.3, 2.5, 1.2 ), Angle( 0, -53, 0 ), Width = 7.7 },
	[2] = { "Primary", Vector( 10.3, -2.5, 1.2 ), Angle( 0, 180 + 53, 0 ), Width = 7.7 },

	[3] = { "Primary", Vector( 6.91, 7.01, 1.2 ), Angle( 0, -53, 0 ) },
	[4] = { "Primary", Vector( 6.91, -7.01, 1.2 ), Angle( 0, 180 + 53, 0 ) },

	[5] = { "Primary", Vector( 3.9, 11, 1.2 ), Angle( 0, -53, 0 ) },
	[6] = { "Primary", Vector( 3.9, -11, 1.2 ), Angle( 0, 180 + 53, 0 ) },

	[7] = { "Primary", Vector( 0.87, 14.99, 1.2 ), Angle( 0, -53, 0 ) },
	[8] = { "Primary", Vector( 0.87, -14.99, 1.2 ), Angle( 0, 180 + 53, 0 ) },

	[9] = { "Primary", Vector( -0.64, 19.5, 1.2 ), Angle( 0, -90, 0 ), Width = 6.4 },
	[10] = { "Primary", Vector( -0.64, -19.5, 1.2 ), Angle( 0, -90, 0 ), Width = 6.4  },

	[11] = { "Primary", Vector( -2.39, 24.1, 1.2 ), Angle( 0, -48, 0 ), Width = 6.8 },
	[12] = { "Primary", Vector( -2.39, -24.1, 1.2 ), Angle( 0, 180 + 48, 0 ), Width = 6.8  },

	[13] = { "Primary", Vector( -7.06, 26.7, 1.2 ), Angle( 0, -11, 0 ), Width = 7.15 },
	[14] = { "Primary", Vector( -7.06, -26.7, 1.2 ), Angle( 0, 180 + 11, 0 ), Width = 7.15  },

	[15] = { "Primary", Vector( -11.86, 23.54, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2 },
	[16] = { "Primary", Vector( -11.86, -23.54, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2  },

	[17] = { "Primary", Vector( -11.86, 18.28, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2 },
	[18] = { "Primary", Vector( -11.86, -18.28, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2  },

	[19] = { "Primary", Vector( -11.86, 13.07, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2 },
	[20] = { "Primary", Vector( -11.86, -13.07, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2  },
	
	[21] = { "Primary", Vector( -11.86, 7.83, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2 },
	[22] = { "Primary", Vector( -11.86, -7.83, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2  },
	
	[23] = { "Primary", Vector( -11.86, 2.61, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2 },
	[24] = { "Primary", Vector( -11.86, -2.61, 1.2 ), Angle( 0, 90, 0 ), Width = 6.2  },

	[25] = { "HotFoot", Vector( 0, -1.6, 0 ), Angle( 0, 180, 0 ), BoneParent = "valor_44_hootfoot_fwd_left", RequiredBodyGroups = { ["forward_hotfeet"] = 0 } },
	[26] = { "HotFoot", Vector( 0, -1.6, 0 ), Angle( 0, 180, 0 ), BoneParent = "valor_44_hootfoot_fwd_right", RequiredBodyGroups = { ["forward_hotfeet"] = 0 } },

	[27] = { "HotFoot", Vector( 1.62, -0.1, -.35 ), Angle( 0, -95.4, 0 ), BoneParent = "valor_44_hootfoot_alley_left", Width = 4.7, RequiredBodyGroups = { ["alley_hotfeet"] = 0 } },
	[28] = { "HotFoot", Vector( 1.62, -0.1, -.35 ), Angle( 0, -95.4, 0 ), BoneParent = "valor_44_hootfoot_alley_right", Width = 4.7, RequiredBodyGroups = { ["alley_hotfeet"] = 0 } },
}

COMPONENT.StateMap = "[R] 1 3 5 7 9 11 13 15 17 19 21 23 25 27 [B] 2 4 6 8 10 12 14 16 18 20 22 24 26 28"

COMPONENT.Segments = {
	All = {
		Frames = {
			[1] = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28",
			[2] = "1 3 5 7 9 11 13 15 17 19 21 23 25 27",
			[3] = "2 4 6 8 10 12 14 16 18 20 22 24 26 28"
		},
		Sequences = {
			["ON"] = { 1 },
			["ALT"] = sequence():Alternate( 2, 3 ):SetTiming( 1 )
		}
	},
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = { All = "ON" },
		["MODE2"] = { All = "ON" },
		["MODE3"] = { All = "ON" },
	}
}