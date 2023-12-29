local class = "Photon2UIWelcome"
local base = "Photon2UIWindow"

---@class Photon2UIDesktop : Photon2UIWindow
local PANEL = {}

PANEL.AllowAutoRefresh = true

function PANEL:Setup()
	
end

function PANEL:Init()
	self.BaseClass.Init( self )

	local container = vgui.Create( "DPanel", self )
	container:Dock( FILL )
	container:SetPaintBackground( false )
	self.ContentContainer = container

	self:Setup()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end


derma.DefineControl( class, "Photon 2 welcome window.", PANEL, base )