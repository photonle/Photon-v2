local class = "EXDHorizontalDivider"
local base = "DPanel"
local description = "Horizontal Divider"

local PANEL = {}

AccessorFunc( PANEL, "m_pLeft",				"Left" )
AccessorFunc( PANEL, "m_pRight",			"Right" )
AccessorFunc( PANEL, "m_pMiddle",			"Middle" )
AccessorFunc( PANEL, "m_iDividerWidth",		"DividerWidth" )
AccessorFunc( PANEL, "m_iAnchorWidth",		"AnchorWidth" )
AccessorFunc( PANEL, "m_sAnchorType",		"Anchor")
AccessorFunc( PANEL, "m_bDragging",			"Dragging", FORCE_BOOL )

AccessorFunc( PANEL, "m_iLeftWidthMin",		"LeftMin" )
AccessorFunc( PANEL, "m_iRightWidthMin",	"RightMin" )

AccessorFunc( PANEL, "m_iHoldPos",			"HoldPos" )

function PANEL:Init()

	self:SetDividerWidth( 8 )
	self:SetAnchorWidth( 100 )

	self:SetLeftMin( 50 )
	self:SetRightMin( 50 )

	self:SetPaintBackground( false )

	self.m_DragBar = vgui.Create( "DHorizontalDividerBar", self )

end

function PANEL:LoadCookies()

	self:SetAnchorWidth( self:GetCookieNumber( "LeftWidth", self:GetAnchorWidth() ) )

end

function PANEL:SetLeft( pnl )

	self.m_pLeft = pnl

	if ( IsValid( self.m_pLeft ) ) then
		self.m_pLeft:SetParent( self )
	end

end

function PANEL:SetMiddle( Middle )

	self.m_pMiddle = Middle

	if ( IsValid( self.m_pMiddle ) ) then
		self.m_pMiddle:SetParent( self.m_DragBar )
	end

end

function PANEL:SetRight( pnl )

	self.m_pRight = pnl

	if ( IsValid( self.m_pRight ) ) then
		self.m_pRight:SetParent( self )
	end

end

PANEL.m_sAnchorType = "L"

function PANEL:PerformLayout()

	if self.m_sAnchorType == "L" then
		
		self:SetAnchorWidth( math.Clamp( self:GetAnchorWidth(), self:GetLeftMin(), math.max( self:GetWide() - self:GetRightMin() - self:GetDividerWidth(), self:GetLeftMin() ) ) )
		
		if ( IsValid( self.m_pLeft ) ) then

			self.m_pLeft:StretchToParent( 0, 0, nil, 0 )
			self.m_pLeft:SetWide( self:GetAnchorWidth() )
			self.m_pLeft:InvalidateLayout()
	
		end
	
		self.m_DragBar:SetPos( self:GetAnchorWidth(), 0 )
		self.m_DragBar:SetSize( self:GetDividerWidth(), self:GetTall() )
		self.m_DragBar:SetZPos( -1 )
	
		if ( IsValid( self.m_pRight ) ) then
	
			self.m_pRight:StretchToParent( self:GetAnchorWidth() + self.m_DragBar:GetWide(), 0, 0, 0 )
			self.m_pRight:InvalidateLayout()
	
		end

	elseif self.m_sAnchorType == "R" then
		
		self:SetAnchorWidth(math.Clamp(self:GetAnchorWidth(), self:GetRightMin(), math.max(self:GetWide() - self:GetLeftMin() - self:GetDividerWidth(), self:GetRightMin())))

		if (IsValid(self.m_pRight)) then
			self.m_pRight:StretchToParent(nil, 0, 0, 0)
			self.m_pRight:SetWide(self:GetAnchorWidth())
			self.m_pRight:AlignRight(0)
			self.m_pRight:InvalidateLayout()
		end

		self.m_DragBar:SetPos(self:GetWide() - self:GetAnchorWidth() - self:GetDividerWidth(), 0)
		self.m_DragBar:SetSize( self:GetDividerWidth(), self:GetTall() )
		self.m_DragBar:SetZPos( -1 )

		if IsValid(self.m_pLeft) then
			self.m_pLeft:StretchToParent(0, 0, self:GetAnchorWidth() + self:GetDividerWidth(), 0)
			self.m_pLeft:InvalidateLayout()
		end

	end

	if ( IsValid( self.m_pMiddle ) ) then

		self.m_pMiddle:StretchToParent( 0, 0, 0, 0 )
		self.m_pMiddle:InvalidateLayout()

	end

end

function PANEL:OnCursorMoved( x, y )

	if ( !self:GetDragging() ) then return end

	local oldLeftWidth
	if (self.m_sAnchorType == "L") then
		oldLeftWidth = self:GetAnchorWidth()
	elseif (self.m_sAnchorType == "R") then
		oldLeftWidth = self.m_pLeft:GetWide()
	end

	x = math.Clamp( x - self:GetHoldPos(), self:GetLeftMin(), self:GetWide() - self:GetRightMin() - self:GetDividerWidth() )

	if (self.m_sAnchorType == "L") then
		self:SetAnchorWidth(x)
	elseif (self.m_sAnchorType == "R") then
		self:SetAnchorWidth(self:GetWide() - x - self:GetDividerWidth())
	end

	if ( oldLeftWidth != x ) then self:InvalidateLayout() end

end

function PANEL:StartGrab()

	self:SetCursor( "sizewe" )

	local x, y = self.m_DragBar:CursorPos()
	self:SetHoldPos( x )

	self:SetDragging( true )
	self:MouseCapture( true )

end

function PANEL:OnMouseReleased( mcode )

	if ( mcode == MOUSE_LEFT ) then
		self:SetCursor( "none" )
		self:SetDragging( false )
		self:MouseCapture( false )
		self:SetCookie( "LeftWidth", self:GetAnchorWidth() )
	end

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:SetSize( 256, 256 )
	ctrl:SetLeft( vgui.Create( "DButton" ) )
	ctrl:SetRight( vgui.Create( "DButton" ) )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( class, description, PANEL, base )