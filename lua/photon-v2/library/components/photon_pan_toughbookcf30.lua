if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Schmal"

COMPONENT.Credits = {
	Code = "Schmal", Model = "Cj24"
}

COMPONENT.Title = [[Panasonic Toughbook CF-30]]
COMPONENT.Category = "Computer"
COMPONENT.Model = "models/schmal/cj24_toughbook_cf30.mdl"

COMPONENT.DefineOptions = {
	Pole = {
		Arguments = { { "height", "number" } },
		Description = "Adjusts the mounting pole height.",
		Action = function( self, height )
			self.Bones = self.Bones or {}
			self.Bones["base"] = self.Bones["base"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["base"][1] = Vector( height, 0, 0 )
		end
	},
	Base = {
		Arguments = { { "angle", "number" } },
		Description = "Adjusts the base mount's rotation.",
		Action = function( self, angle )
			self.Bones = self.Bones or {}
			self.Bones["base"] = self.Bones["base"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["base"][2] = Angle( 0, 0, angle )
		end
	},
	Screen = {
		Arguments = { { "material", "string" } },
		Description = "Changes the screen material (the screen is 1024x768 centered in a 1024x1024 texture).",
		Action = function( self, material )
			self.Elements[3].DrawMaterial = Material( material )
			self.Elements[3].BloomMaterial = Material( material )
		end
	}
}

COMPONENT.Templates = {
	["Mesh"] = {
		Model = {
			Model = "models/schmal/cj24_toughbook_cf30.mdl",
			DeactivationState = "~OFF",
			IntensityTransitions = true,
			States = {
				ON = {
					DrawColor = PhotonColor( 128, 128, 128 ),
					BloomColor = PhotonColor( 40, 40, 40 ),
					Intensity = 1,
					IntensityTransitions = true,

				}
			}
		}
	},
	["DynamicLight"] = {
		Dynamic = {
			Brightness = 8,
			Size = 20,
			InnerAngle = 0,
			OuterAngle = 60,
		}
	},
	["Bone"] = {
		Lid = {
			Bone = "screen",
			Axis = "r",
			States = {
				["DOWN"] = { Activity = "Fixed", Target = 95, Speed = 140, DeactivateOnTarget = true, Direction = 1 },
				["UP"] = { Activity = "Fixed", Target = 0, Speed = 140, Direction = -1 }
			},
			DeactivationState = "DOWN"
		}
	},
	["Sub"] = {
		["Sub"] = {
			States = {
				["ON"] = { Material = "schmal/toughbook_cf30/emis_on" }
			}
		}
	}
}

COMPONENT.SubMaterials = {
	[5] = "schmal/toughbook_cf30/black"
}

COMPONENT.StateMap = ""

COMPONENT.Elements = {
	[1] = { "Dynamic", Vector( 0, 6, 5 ), Angle( -90, -90, 0 ), BoneParent = "screen" },
	[2] = { "Lid" },
	[3] = { "Model", Vector( 0, 4.5, -1.15 ), Angle( 0, 0, 0 ), "schmal/toughbook_cf30/laptop_screen", 
		DrawMaterial = "schmal/toughbook_cf30/laptop_screen",
		BloomMaterial = "schmal/toughbook_cf30/laptop_screen",
		BoneParent = "screen" 
	},
	[4] = { "Sub", Indexes = { 4 } }
}

COMPONENT.Segments = {
	Screen = {
		Frames = {
			-- The dynamic light is really cool but I'm ignoring it for now because
			-- it's hard to justify the performance trade-off for such a tiny detail
			[1] = "[UP] 2 [ON] 3 4 [W] 1",
			[2] = "[UP] 2 [ON] 3 4",
		},
		Sequences = {
			["ON"] = { 2 },
		}
	}
}

COMPONENT.Inputs = {
	["Vehicle.Engine"] = {
		["ON"] = {
			Screen = "ON"
		},
	}
}