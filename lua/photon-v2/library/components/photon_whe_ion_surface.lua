local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Name = "photon_whe_ion_surface"

COMPONENT.WorkshopRequirements = {
	[2932505261] = "Anemolis Prop Pack"
}

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Model = "Anemolis",
	Code = "Schmal"
}

COMPONENT.Model = "models/anemolis/props/anemolis_surfaceion.mdl"

local size = 6

COMPONENT.Templates = {
	["2D"] = {
		Light = {
			Width 	= size,
			Height	= size/4,
			Detail = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_detail.png").MaterialName,
			Shape = PhotonMaterial.GenerateLightQuad("photon/lights/whe_ion_shape.png").MaterialName,
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
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

local sequence = Photon2.SequenceBuilder.New

COMPONENT.Segments = {
	Light = {
		Frames = {
			[1] = "1",
			[2] = "[2] 1",
		},
		Sequences = {
			ON = { 1 },
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
			["TRI_FLASH_HOLD"] = sequence():FlashHold( { 1 }, 3, 4 ),
			["TRI_FLASH_HOLD:A"] = sequence():FlashHold( { 1, 0 }, 3, 4 ),
			["TRI_FLASH_HOLD:B"] = sequence():FlashHold( { 0, 1 }, 3, 4 ),
		}
	}
}

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			Light = "ON"
		}
	}
}

Photon2.RegisterComponent( COMPONENT )

COMPONENT = Photon2.LibraryComponent()
COMPONENT.Name = "photon_whe_ion_surface_bracket"
COMPONENT.Base = "photon_whe_ion_surface"
COMPONENT.Model = "models/anemolis/props/anemolis_lsurfaceion.mdl"

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 1.8, 0 ), Angle( 0, 0, 0 ) }
}

Photon2.RegisterComponent( COMPONENT )