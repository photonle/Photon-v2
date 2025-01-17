local class = "Photon2UIWindow"
local base = "DFrame"

-- forget about this. it sucks
local enableBackgroundBlur = false

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

-- Note: this is NOT related to window position saving. This is for the window state.
function PANEL:RecordState()
	self.RestorePlacement = {
		State = "NORMAL",
		W = self:GetWide(),
		H = self:GetTall(),
		X = self:GetX(),
		Y = self:GetY()
	}
end

function PANEL:Maximize()

	if ( self.IsMinimized ) then
		self:UnMinimize()
	else
		self:RecordState()
	end

	self:SetPos( 0, 0 )
	self:SetSize( ScrW(), ScrH() )
	self.WindowState = "MAX"
	self:SetDraggable( false )
	self:SetSizable( false )
end

function PANEL:Restore()
	if ( not self.RestorePlacement ) then return end
	self.WindowState = self.RestorePlacement.State
	self:SetSize( self.RestorePlacement.W, self.RestorePlacement.H )
	self:SetPos( self.RestorePlacement.X, self.RestorePlacement.Y )
	self:SetDraggable( true )
	self:SetSizable( true )
	if ( self.IsMinimized ) then self:UnMinimize() end
end

function PANEL:Minimize()
	if ( self.WindowState == "NORMAL" ) then self:RecordState() end
	local visiblePanels = {}
	for _, pnl in pairs( self:GetChildren() ) do
		if ( pnl:IsVisible() ) then
			if ( self.EssentialChildren[pnl] ) then continue end
			visiblePanels[#visiblePanels+1] = pnl
			pnl:SetVisible( false )
		end
	end
	self.MinimizedPanels = visiblePanels
	self.IsMinimized = true
	self.btnMinim:SetEnabled( false )
	self:SetSize( 260, 48 )
	self:SetPos( 4, ScrH() - 24 )
	self:SetDraggable( false )
	self:SetSizable( false )
end

function PANEL:UnMinimize()
	for i=1, #self.MinimizedPanels do
		if ( IsValid( self.MinimizedPanels[i] ) ) then
			self.MinimizedPanels[i]:SetVisible( true )
		end
	end
	self.IsMinimized = false
	self.btnMinim:SetEnabled( true )
	self:SetDraggable( true )
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
	self:SetMinHeight( 8 )
	self.WindowState = "NORMAL"
	self:SetSize( 400, 600 )
	self:SetScreenLock( true )
	self:Center()
	self:SetSizable(true)
	self:SetBackgroundBlur( enableBackgroundBlur )

	if ( not Photon2.UI.CursorReleased ) then
		Photon2.UI.ToggleCursorRelease()
	end
	hook.Add( "OnTextEntryGetFocus", self, function( panel ) 
		self:StartKeyFocus( panel )
	end )
	
	hook.Add( "OnTextEntryLoseFocus", self, function( panel) 
		self:EndKeyFocus( panel )
	end )

	self.EssentialChildren = {
		[self.btnClose] = true,
		[self.btnMaxim] = true,
		[self.btnMinim] = true,
		[self.lblTitle] = true,
		[(self.imgIcon)] = true
	}

	local this = self
	function self.btnClose:DoClick()
		this:DoClose()
	end

	self.btnMaxim:SetEnabled( true )
	function self.btnMaxim:DoClick()
		if ( this.IsMinimized ) then
			if ( this.WindowState == "MAX" ) then return this:Maximize() end
			return this:Restore()
		end
		if ( this.WindowState == "MAX" ) then return this:Restore() end
		return this:Maximize()
	end

	function self.btnMaxim:Paint( w, h )
		if ( this.IsMinimized ) then
			if ( this.WindowState == "MAX" ) then
				derma.SkinHook( "Paint", "WindowMaximizeButton", self, w, h )
			else
				derma.SkinHook( "Paint", "WindowRestoreButton", self, w, h )
			end
		else
			if ( this.WindowState == "MAX" ) then
				derma.SkinHook( "Paint", "WindowRestoreButton", self, w, h )
			else
				derma.SkinHook( "Paint", "WindowMaximizeButton", self, w, h )
			end
		end
		
	end

	self.btnMinim:SetEnabled( true )
	function self.btnMinim:DoClick()
		if ( this.IsMinimized ) then
			this:UnMinimize()
		else
			this:Minimize()
		end
	end

	-- Pretty but negates translucency 
	self:SetPaintShadow( false )

	if ( IsValid( self.CursorInfoPanel ) ) then 
		self.CursorInfoPanel:Remove() 
	end

	local cursorInfoPanel = vgui.Create( "DPanel", self )
	cursorInfoPanel:Dock( BOTTOM )
	cursorInfoPanel:SetHeight( 24 )
	cursorInfoPanel:DockMargin( 0, 0, 0, 0 )
	cursorInfoPanel:DockPadding( 0, 0, 0, 0 )
	cursorInfoPanel:SetPaintBackground( false )
	local cursorInfoText = vgui.Create( "DLabel", cursorInfoPanel )
	cursorInfoText:Dock( FILL )
	cursorInfoText:SetContentAlignment( 5 )
	cursorInfoText:SetText( "Press F3 to release your cursor." )
	cursorInfoPanel:SetVisible( false )
	self.CursorInfoPanel = cursorInfoPanel

	hook.Run( "Photon2.WindowCreated", self )


	-- -- 
	hook.Add( "OnContextMenuOpen", self, function()
		self:AlphaTo( 64, 0.5, 0 )
	end )

	hook.Add( "OnContextMenuClose", self, function()
		self:AlphaTo( 255, 0.5, 0 )
	end )

	-- Manages the "Press F3 to release cursor."
	hook.Add( "Think", self , function ()
		if ( vgui.CursorVisible() and ( not self.HandledHiddenCursor ) ) then
			self.CursorInfoPanel:SetVisible( false )
			self.CursorInfoPanel:SetHeight( 0 )
			self:GetParent():InvalidateChildren( true )
			self.HandledVisibleCursor = false
			self.HandledHiddenCursor = true
		elseif ( ( not vgui.CursorVisible() ) and not self.HandledVisibleCursor ) then
			self.CursorInfoPanel:SetVisible( true )
			self.CursorInfoPanel:SetHeight( 24 )
			self:GetParent():InvalidateChildren( true )
			self.HandledVisibleCursor = true
			self.HandledHiddenCursor = false
		end
	end)

	-- -- this didn't do a goddamn thing

	-- hook.Add ("OnContextMenuClose", self, function()
	-- -- 	if ( IsValid( actualParent ) ) then
	-- -- 		-- print("parent is now the original")
	-- -- 		-- self:SetParent( actualParent )
	-- -- 	end
	-- end )

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

function PANEL:OnMousePressed()

	local screenX, screenY = self:LocalToScreen( 0, 0 )
	local isOverTitlebar = gui.MouseY() < ( screenY + 24 )

	if ( isOverTitlebar ) then
		if ( self.LastClickTime and SysTime() - self.LastClickTime < 0.2 ) then
			if ( self.WindowState == "MAX" ) then
				self:Restore()
			else
				self:Maximize()
			end
		end
		self.LastClickTime = SysTime()
	end

	if ( self.m_bSizable && gui.MouseX() > ( screenX + self:GetWide() - 20 ) && gui.MouseY() > ( screenY + self:GetTall() - 20 ) ) then
		self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
		self:MouseCapture( true )
		return
	end

	if ( isOverTitlebar and self:GetDraggable() ) then
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	end


end

function PANEL:OnMouseReleased()
	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )
end

-- Moves the window to its saved position and ensures it's within screen bounds.
function PANEL:RestoreSavedPosition()
	if ( not self:GetCookieName() or self:GetCookieName() == "" ) then 
		error( "Window's cookie name needs to be set using :SetCookieName() first.")
		return
	end
	local x = self:GetCookieNumber( "window.x", ScrW() / 2 - self:GetWide() / 2 )
	local y = self:GetCookieNumber( "window.y", ScrH() / 2 - self:GetTall() / 2 )
	x = math.Clamp( x, 0, ScrW() - self:GetWide() )
	y = math.Clamp( y, 0, ScrH() - self:GetTall() )
	self:SetPos( x, y )
end

-- Saves the window's position.
function PANEL:SavePosition()
	if ( not self:GetCookieName() or self:GetCookieName() == "" ) then 
		error( "Window's cookie name needs to be set using :SetCookieName() first.")
		return
	end
	self:SetCookie( "window.x", self.x )
	self:SetCookie( "window.y", self.y )
end

-- function PANEL:Think()
-- 	print("panel think")
-- end

function PANEL:OnKeyCodePressed( keyCode )
	if ( keyCode == KEY_F3 ) then
		Photon2.UI.ToggleCursorRelease()
	end
end

function PANEL:OnThink()
	
end

derma.DefineControl( class, "Photon 2 Window", PANEL, base )