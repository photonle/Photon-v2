local class = "Photon2UIWindow"
local base = "DFrame"

---@class Photon2UIWindow : Panel
---@field MenuBar EXDMenuBar 
local PANEL = {}

PANEL.TitleSuffix = ""
PANEL.TitleMain = ""
PANEL.TitlePrefix = ""

function PANEL:SetTitleMain( text )
	self.TitleMain = text
	self:UpdateTitle()
end

function PANEL:SetTitlePrefix( text )
	self.TitlePrefix = text
	self:UpdateTitle()
end

function PANEL:SetTitleSuffix( text )
	self.TitleSuffix = text
	self:UpdateTitle()
end

function PANEL:UpdateTitle()
	self:SetTitle( self.TitlePrefix .. self.TitleMain .. self.TitleSuffix )
end

function PANEL:GetOrBuildMenuBar()
	if ( not IsValid(self.MenuBar) ) then
		if ( not self.DockPaddingModified ) then
			local lp, tp, rp, bp = self:GetDockPadding()
			self:DockPadding(1, tp - 5, 1, 1)
			self.DockPaddingModified = true
		end
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
	self:SetScreenLock( true )
	self:Center()
	self:SetSizable(true)
	hook.Add( "OnTextEntryGetFocus", self, function( panel ) 
		self:StartKeyFocus( panel )
	end )
	hook.Add( "OnTextEntryLoseFocus", self, function( panel) 
		self:EndKeyFocus( panel )
	end )

	local this = self
	function self.btnClose:DoClick()
		this:DoClose()
	end
	-- Pretty but negates translucency 
	self:SetPaintShadow( false )
end

function PANEL:DoClose()
	self:Close()
end

function PANEL:StartKeyFocus( panel )
	if ( not IsValid( panel ) or not panel:HasParent( self ) ) then return end
	self.KeyFocusPanel = panel
	self:SetKeyboardInputEnabled( true )
end

function PANEL:EndKeyFocus( panel )
	if ( self.KeyFocusPanel ~= panel ) then return end
	self:SetKeyboardInputEnabled( false )
end

derma.DefineControl( class, "Photon 2 Window", PANEL, base )