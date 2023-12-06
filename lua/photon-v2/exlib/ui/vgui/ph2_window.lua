local class = "Photon2UIWindow"
local base = "DFrame"

---@class Photon2UIWindow : Panel
---@field MenuBar EXDMenuBar 
local PANEL = {}

function PANEL:GetOrBuildMenuBar()
	if ( not self.MenuBar ) then
		local lp, tp, rp, bp = self:GetDockPadding()
		self:DockPadding(1, tp - 5, 1, 1)
		local menubar = vgui.Create( "EXDMenuBar", self ) --[[@as EXDMenuBar]]
		menubar:SetSkin( self:GetSkin().ID )
		menubar:Dock( TOP )
		self.MenuBar = menubar
	end
	return self.MenuBar
end

function PANEL:Init()
	self:SetSkin("PhotonStudio")
	self:SetIcon("photon/ui/photon_2_icon_16.png")
	self:SetSize( 400, 600 )
	self:Center()
	self:SetSizable(true)
end

derma.DefineControl( class, "Photon 2 Window", PANEL, base )