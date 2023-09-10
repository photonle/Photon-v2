if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent()

COMPONENT.Author = "Photon"

COMPONENT.Credits = {
	Model = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = [[Code 3 MX7000]]

COMPONENT.Model = "models/sentry/props/mx7k.mdl"

COMPONENT.SubMaterials = {
	[0] = "photon/textures/mx7000_glass_colored",
	-- [2] = "photon/textures/mx7000",
	-- [0] = nil,
	-- [2] = nil
}

COMPONENT.LightStates = {}

COMPONENT.Templates = {}

COMPONENT.ColorMap = ""

COMPONENT.Lights = {}

COMPONENT.Segments = {}

COMPONENT.Patterns = {}