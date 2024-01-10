if (Photon2.ReloadNewComponentFile()) then return end
local COMPONENT = Photon2.LibraryNewComponent()

COMPONENT.Base = "photon_newcom_b"

COMPONENT.Inputs = {
	["Emergency.Warning"] = {
		["MODE1"] = {
			All = "ALT3"
		}
	}
}