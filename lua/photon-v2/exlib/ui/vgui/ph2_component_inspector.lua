local class = "Photon2UIComponentInspector"
local base = "Photon2UIWindow"

local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.TitleMain = "Photon 2"
PANEL.TitleSuffix = " - Inspector"

function PANEL:Init()
	self.BaseClass.Init( self )
	self.AllowAutoRefresh = true
	local this = self

	self:SetTitle("Component Inspector - Photon 2")
	self:SetMinWidth( 352 )
	self:SetMinHeight( 340 )

	self:Setup()

	self:MakePopup()

end

function PANEL:Setup()
	local this = self
	self:SetupMenuBar()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:ShowOpenBrowser()
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "Components", "OPEN" )
end

function PANEL:SetupMenuBar()
	local this = self
	if ( IsValid( self.Menubar ) ) then self.MenuBar:Remove() end

	local menubar = self:GetOrBuildMenuBar()

	local fileMenu = menubar:AddMenu( "File" )

	fileMenu:AddOption( "Open...", function()
		this:ShowOpenBrowser()
	end)

end

derma.DefineControl( class, "Photon 2 component inspector", PANEL, base )
