local COMPONENT = Photon2.LibraryComponent()
local sequence = Photon2.SequenceBuilder.New

COMPONENT.Name = "photon_whe_ion"
COMPONENT.Title = "Whelen Ion"
COMPONENT.Category = "Perimeter"
COMPONENT.Credits = {
	Model = "Sentry",
	Code = "Schmal"
}

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}

COMPONENT.Model = "models/sentry/props/ion_photon.mdl"

local size = 6

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width  = size,
			Height = size/4,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_shape.png").MaterialName,
			Scale = 1.2,
			Ratio = 1.2
		}
	}
}

COMPONENT.States = {
	[1] = "R",
	[2] = "B",
	[3] = "W"
}

COMPONENT.StateMap = "[1/2/3] 1"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 0.5, 0 ), Angle( 0, 0, 0 ) }
}

COMPONENT.ElementGroups = {
	Light = { 1 }
}

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "Light",
			[2] = "[2] Light",
			[3] = "[3] Light",
			[4] = "[OFF] Light"
		},
		Sequences = {
			ON = { 1 },
			["OFF"] = { 4 },
			["STEADY_FLASH"] = sequence():SteadyFlash( 1 ),
			["QUAD_FLASH"] = sequence():QuadFlash( 1, 0 ),
			["QUAD_FLASH:A"] = sequence():QuadFlash( 1, 0 ),
			["QUAD_FLASH:B"] = sequence():QuadFlash( 0, 1 ),
			["QUAD_FLASH_DUO"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_FLASH_DUO:A"] = sequence():QuadFlash( 1, 2 ),
			["QUAD_FLASH_DUO:B"] = sequence():QuadFlash( 2, 1 ),
			["ALT_MED"] = sequence():Alternate( 1, 0, 8 ),
			["ALT_MED:B"] = sequence():Alternate( 0, 1, 8 ),
			["ALT_MED_DUO"] = sequence():Alternate( 1, 2, 8 ),
			["ALT_MED_DUO:B"] = sequence():Alternate( 2, 1, 8 ),
			["DOUBLE_FLASH"] = sequence():DoubleFlash( 1 ):AppendPhaseGap(),
			["DOUBLE_FLASH_HOLD"] = sequence():FlashHold( 1, 2, 3 ):AppendPhaseGap(),
			["TRI_FLASH"] = sequence():DoubleFlash( 1 ):AppendPhaseGap(),
			["TRI_FLASH_HOLD"] = sequence():FlashHold( { 1 }, 3, 4 ):AppendPhaseGap(),
			["TRI_FLASH_HOLD:A"] = sequence():FlashHold( { 1, 0 }, 3, 4 ),
			["TRI_FLASH_HOLD:B"] = sequence():FlashHold( { 0, 1 }, 3, 4 ),
			["VARIABLE_SINGLE"] = sequence():Add( 0, 1, 1, 1, 1, 0, 0, 0, 0, 0 ):SetVariableTiming( 1/12, 1/40, 0.66 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "STEADY_FLASH"
		},
		["MODE2"] = {
			Light = "VARIABLE_SINGLE"
		},
		["MODE3"] = {
			Light = "DOUBLE_FLASH_HOLD"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

--[[
		SURFACE MOUNT VARIANT
--]]

COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_ion_surface"

COMPONENT.WorkshopRequirements = {
	[2932505261] = "Anemolis Prop Pack"
}

COMPONENT.Author = "Photon"
COMPONENT.Title = "Whelen Ion (Surface)"
COMPONENT.Base = "photon_whe_ion"
COMPONENT.Credits = {
	Model = "Mighty/SGM/Anemolis",
	Code = "Schmal"
}
COMPONENT.Category = "Perimeter"
COMPONENT.Model = "models/anemolis/props/anemolis_surfaceion.mdl"

COMPONENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0, 90, 0 ),
	Zoom = 3
}


COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Title = "Whelen Ion (Surface Bracket)"
COMPONENT.Name = "photon_whe_ion_surface_bracket"
COMPONENT.Base = "photon_whe_ion_surface"
COMPONENT.Model = "models/anemolis/props/anemolis_lsurfaceion.mdl"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )


COMPONENT = Photon2.LibraryComponent()
COMPONENT.Title = "Whelen Ion (Spitfire)"
COMPONENT.Name = "photon_whe_ion_spitfire"
COMPONENT.Base = "photon_whe_ion"
COMPONENT.Model = "models/schmal/whelen_spitfire.mdl"
COMPONENT.Author = {
	["Model"] = "Karn14, Schmal",
	["Code"] = "Schmal"
}

COMPONENT.DefineOptions = {
	["Mount"] = {
		Arguments = { { "type", "number" } },
		Description = "Adjusts the mount type.",
		Action = function( self, type )
			self.BodyGroups = self.BodyGroups or {}
			self.BodyGroups["mount"] = type
		end
	},
	["Angle"] = {
		Arguments = { { "angle", "number" } },
		Description = "Adjusts the base mount's rotation.",
		Action = function( self, angle )
			self.Bones = self.Bones or {}
			self.Bones["suction_mount"] = self.Bones["suction_mount"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["suction_mount"][2] = Angle( angle, 0, 0 )
			self.Bones["extended_mount"] = self.Bones["extended_mount"] or { Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 }
			self.Bones["extended_mount"][2] = Angle( angle, 0, 0 )
		end
	}

}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 0.5, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )