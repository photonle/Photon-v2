if (Photon2.ReloadComponentFile()) then return end
local COMPONENT = Photon2.LibraryComponent() --[[@as PhotonLibraryComponent]]

COMPONENT.Author = "Photon"
COMPONENT.Credits = {
	Vehicle = "SGM",
	Code = "Schmal"
}

COMPONENT.PrintName = "2021 Dodge Durango (PPV)"

COMPONENT.IsVirtual = true

COMPONENT.Templates = {}
COMPONENT.Lights = {}
COMPONENT.Segments = {}
COMPONENT.Patterns = {}