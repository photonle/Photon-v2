print("[EX VGUI] exd_menuoption.lua")


local class = "EXDMenuOption"
local base = "EXDButton"
local PANEL = {}

AccessorFunc( PANEL, "m_pMenu", "Menu" )
AccessorFunc( PANEL, "m_bChecked", "Checked" )
AccessorFunc( PANEL, "m_bCheckable", "IsCheckable" )

function PANEL:Init()

	self:SetContentAlignment( 4 )
	self:SetTextInset( 30, 0 )			-- Room for icon on left
	self:SetTextColor( Color( 10, 10, 10 ) )
	self:SetChecked( false )

end

function PANEL:SetShortcutText(shortcutText)
	if (shortcutText ~= nil) and (shortcutText ~= "") then
		if not self.m_ShortcutLabel then
			local l = vgui.Create("DLabel", self)
			l:Dock(RIGHT)
			l:DockMargin(8, 0, 8, 0)
			l:SetContentAlignment(6)
			-- l:SetWide(64)
			-- l:SetZPos(100)
			self.m_ShortcutLabel = l
		end
		self.m_ShortcutLabel:SetText(shortcutText)
	else
		if IsValid(self.m_ShortcutLabel) then
			self.m_ShortcutLabel:Remove()
		end
	end
	self.m_ShortcutText = shortcutText
	if IsValid(self.m_ShortcutLabel) then
		self.m_ShortcutLabel:SizeToContents()
		-- self.m_ShortcutLabel:InvalidateLayout(true)
		self:InvalidateLayout(true)
		local curWidth = self:GetParent():GetParent():GetMinimumWidth()
		local newWidth = self:GetWide() + self.m_ShortcutLabel:GetWide()
		if (newWidth > curWidth) then
			self:GetParent():GetParent():SetMinimumWidth(newWidth)
		end
		self:InvalidateLayout(true)
	end
end

function PANEL:SetSubMenu( menu )

	self.SubMenu = menu

	if ( !self.SubMenuArrow ) then

		self.SubMenuArrow = vgui.Create( "DPanel", self )
		self.SubMenuArrow.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "MenuRightArrow", panel, w, h ) end

	end

end

function PANEL:AddSubMenu()

	local SubMenu = DermaMenu( self )
		SubMenu:SetVisible( false )
		SubMenu:SetParent( self )

	self:SetSubMenu( SubMenu )

	return SubMenu

end

function PANEL:OnCursorEntered()

	if ( IsValid( self.ParentMenu ) ) then
		self.ParentMenu:OpenSubMenu( self, self.SubMenu )
		return
	end

	self:GetParent():OpenSubMenu( self, self.SubMenu )

end

function PANEL:OnCursorExited()
end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "MenuOption", self, w, h )

	--
	-- Draw the button text
	--
	return false

end

function PANEL:OnMousePressed( mousecode )

	self.m_MenuClicking = true

	DButton.OnMousePressed( self, mousecode )

end

function PANEL:OnMouseReleased( mousecode )

	DButton.OnMouseReleased( self, mousecode )

	if ( self.m_MenuClicking && mousecode == MOUSE_LEFT ) then

		self.m_MenuClicking = false
		CloseDermaMenus()

	end

end

function PANEL:DoRightClick()

	if ( self:GetIsCheckable() ) then
		self:ToggleCheck()
	end

end

function PANEL:DoClickInternal()

	if ( self:GetIsCheckable() ) then
		self:ToggleCheck()
	end

	if ( self.m_pMenu ) then

		self.m_pMenu:OptionSelectedInternal( self )

	end

end

function PANEL:ToggleCheck()

	self:SetChecked( !self:GetChecked() )
	self:OnChecked( self:GetChecked() )

end

function PANEL:OnChecked( b )
end

function PANEL:PerformLayout()

	self:SizeToContents()
	self:SetWide( self:GetWide() + 30 )

	local w = math.max( self:GetParent():GetWide(), self:GetWide() )

	self:SetSize( w, 26 )

	if ( self.SubMenuArrow ) then

		self.SubMenuArrow:SetSize( 15, 15 )
		self.SubMenuArrow:CenterVertical()
		self.SubMenuArrow:AlignRight( 4 )

	end

	DButton.PerformLayout( self )

end

function PANEL:GenerateExample()

	-- Do nothing!

end

derma.DefineControl( class, "", PANEL, base )