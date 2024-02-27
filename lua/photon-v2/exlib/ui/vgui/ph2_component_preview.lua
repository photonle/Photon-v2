local class = "Photon2UIComponentPreviewer"
local base = "DPanel"

local PANEL = {}

PANEL.AllowAutoRefresh = true

function PANEL:Init()
	self.BaseClass.Init( self )
	local this = self
	self:Setup()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:Setup()

end

derma.DefineControl( class, "Photon 2 component previewer", PANEL, base )
