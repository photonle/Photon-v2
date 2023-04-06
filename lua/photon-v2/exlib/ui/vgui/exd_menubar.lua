print("[EX VGUI] exd_menubar.lua")


local class = "EXDMenuBar"
local base = "DPanel"
local PANEL = {}

AccessorFunc( PANEL, "m_bBackground",		"PaintBackground",	FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground",		"DrawBackground",	FORCE_BOOL ) -- deprecated
AccessorFunc( PANEL, "m_bIsMenuComponent",	"IsMenu",			FORCE_BOOL )

Derma_Hook( PANEL, "Paint", "Paint", "MenuBar" )

function PANEL:Init()

	self:Dock( TOP )
	self:SetTall( 24 )

	self.Menus = {}

end

function PANEL:GetOpenMenu()

	for k, v in pairs( self.Menus ) do
		if ( v:IsVisible() ) then return v end
	end

	return nil

end

function PANEL:AddOrGetMenu( label )

	if ( self.Menus[ label ] ) then return self.Menus[ label ] end
	return self:AddMenu( label )

end

function PANEL:AddMenu( label )
	local this = self
	local m = EXDermaMenu()
	m:SetDeleteSelf( false )
	m:SetDrawColumn( true )
	m:Hide()
	self.Menus[ label ] = m

	local b = self:Add( "DButton" )
	b.m_StaticColors = true
	b:SetText( label )
	b:Dock( LEFT )
	b:DockMargin( 0, 0, 0, 0 )
	b:SetIsMenu( true )
	function b:Paint(w, h)
		derma.SkinHook("Paint", "MenuBarTitle", self, w, h)
	end
	b.UpdateColours = function(self, skin)
		return self:SetTextStyleColor( skin.Colours.Label.Default )
	end
	-- b:SetPaintBackground( false )
	b:SizeToContentsX( 16 )
	b.OnDepressed = function()

		if ( m:IsVisible() ) then
			m:Hide()
			return
		end

		local x, y = b:LocalToScreen( 0, 0 )
		m:Open( x, y + b:GetTall() - 1, false, b )
		m:SetSkin(this:GetSkin().ID)
	end

	b.OnCursorEntered = function()
		local opened = self:GetOpenMenu()
		if ( !IsValid( opened ) || opened == m ) then return end
		opened:Hide()
		b:OnDepressed()
	end

	m.m_PrimaryHeader = b

	return m

end

function PANEL:OnRemove()

	for id, pnl in pairs( self.Menus ) do
		pnl:Remove()
	end

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local pnl = vgui.Create( "Panel" )
	pnl:Dock( FILL )
	pnl:DockMargin( 2, 22, 2, 2 )

	local ctrl = pnl:Add( ClassName )
	local m = ctrl:AddMenu( "File" )
	m:AddOption( "New", function() MsgN( "Chose New" ) end )
	m:AddOption( "File", function() MsgN( "Chose File" ) end )
	m:AddOption( "Exit", function() MsgN( "Chose Exit" ) end )

	local m2 = ctrl:AddMenu( "Edit" )
	m2:AddOption( "Copy", function() MsgN( "Chose Copy" ) end )
	m2:AddOption( "Paste", function() MsgN( "Chose Paste" ) end )
	m2:AddOption( "Blah", function() MsgN( "Chose Blah" ) end )

	local sub = m:AddSubMenu( "Sub Menu" )
	sub:SetDeleteSelf( false )
	for i = 0, 5 do
		sub:AddOption( "Option " .. i, function() MsgN( "Chose sub menu option " .. i ) end )
	end

	PropertySheet:AddSheet( ClassName, pnl, nil, true, true )

end

derma.DefineControl( class, "", PANEL, base )
