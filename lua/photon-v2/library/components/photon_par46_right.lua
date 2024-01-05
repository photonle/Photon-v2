if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[PAR46 Spotlight (Right)]]

COMPONENT.Model = "models/sentry/props/spotlight_right_up.mdl"

COMPONENT.Base = "photon_par46_left"

COMPONENT.Templates = {}

COMPONENT.Elements = {
	[1] = { "Light", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[2] = { "Projected", Vector( 0, 2, 3.9 ), Angle = Angle( 0, 0, 0 ), BoneParent = 4 },
	[3] = { "LightHead", BoneId = 4, Axis = 'y' },
	[4] = { "LightHead", BoneId = 1, Axis = 'p' }
}

COMPONENT.Segments = {}

COMPONENT.Inputs = {}