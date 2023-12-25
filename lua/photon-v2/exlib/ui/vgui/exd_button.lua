local class = "EXDButton"
local base = "EXDLabelEditable"
local PANEL = {}

AccessorFunc( PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL )

function PANEL:Init()

	self:SetContentAlignment( 5 )

	--
	-- These are Lua side commands
	-- Defined above using AccessorFunc
	--
	
	self:SetDrawBorder( true )
	self:SetPaintBackground( true )

	self:SetTall( 22 )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
	self:SetFont( "DermaDefault" )

	self:SetDoubleClickingEnabled(false)

end

function PANEL:IsDown()

	return self.Depressed

end

function PANEL:SetImage( img )

	if ( !img ) then

		if ( IsValid( self.m_Image ) ) then
			self.m_Image:Remove()
		end

		return
	end

	if ( !IsValid( self.m_Image ) ) then
		self.m_Image = vgui.Create( "DImage", self )
	end

	self.m_Image:SetImage( img )
	self.m_Image:SizeToContentsX()
	self:InvalidateLayout()

end
-- PANEL.SetIcon = PANEL.SetImage

function PANEL:SetIcon(name)
	if not name then
		if IsValid(self.m_Icon) then
			self.m_Icon:Remove()
		end
		return
	end
	if not IsValid(self.m_Icon) then
		self.m_Icon = vgui.Create("EXDIcon", self)
		-- self.m_Icon.UpdateColours = self.UpdateColours
		self.m_Icon:Dock(LEFT)
		self.m_Icon:SetWidth(24)
		self.m_Icon:SetMouseInputEnabled(false)
	end
	self.m_Icon:SetIcon(name)
	self:InvalidateLayout()
	return self.m_Icon
end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "Button", self, w, h )

	--
	-- Draw the button text
	--
	return false

end

function PANEL:UpdateColours( skin )
	if (self.m_StaticColors) then 
		return self:SetTextStyleColor( skin.Colours.Button.Normal )
	end
	if ( !self:IsEnabled() )					then return self:SetTextStyleColor( skin.Colours.Button.Disabled ) end
	if ( self:IsDown() || self.m_bSelected )	then return self:SetTextStyleColor( skin.Colours.Button.Down ) end
	if ( self.Hovered )							then return self:SetTextStyleColor( skin.Colours.Button.Hover ) end

	return self:SetTextStyleColor( skin.Colours.Button.Normal )

end

function PANEL:PerformLayout()

	--
	-- If we have an image we have to place the image on the left
	-- and make the text align to the left, then set the inset
	-- so the text will be to the right of the icon.
	--
	if ( IsValid( self.m_Image ) ) then

		self.m_Image:SetPos( 4, ( self:GetTall() - self.m_Image:GetTall() ) * 0.5 )

		self:SetTextInset( self.m_Image:GetWide() + 16, 0 )

	elseif (IsValid(self.m_Icon)) then
		self.m_Icon:SetPos( 4, ( self:GetTall() - self.m_Icon:GetTall() ) * 0.5 )
		if ( self.m_Icon:GetTall() > 24 ) then
			self.m_Icon:SetWidth( self.m_Icon:GetTall() )
		end
		-- self:SetTextInset( 8, 0 )
		self:SetTextInset( self.m_Icon:GetWide() * 1.5, 0 )
		self:SetContentAlignment( 5 )
	end

	DLabel.PerformLayout( self )

end

function PANEL:SetConsoleCommand( strName, strArgs )

	self.DoClick = function( self, val )
		RunConsoleCommand( strName, strArgs )
	end

end

function PANEL:SizeToContents()
	local w, h = self:GetContentSize()
	self:SetSize( w + 8, h + 4 )
end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:SetText( "Example Button" )
	ctrl:SetWide( 200 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

local PANEL = derma.DefineControl( "DButton", "A standard Button", PANEL, "DLabel" )

PANEL = table.Copy( PANEL )

function PANEL:SetActionFunction( func )

	self.DoClick = function( self, val ) func( self, "Command", 0, 0 ) end

end

-- No example for this control. Should we remove this completely?
function PANEL:GenerateExample( class, tabs, w, h )
end

derma.DefineControl( class, "", PANEL, base )