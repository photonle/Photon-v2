local class = "Photon2UISeparator"
local base = "DPanel"
local description = "A visual separator element."
local PANEL = {}



derma.DefineControl( class, "", PANEL, base )

function PANEL:Paint( w, h )
	
	return false
end