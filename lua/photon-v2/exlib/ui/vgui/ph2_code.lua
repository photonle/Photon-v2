local class = "Photon2UICode"
local base = "Photon2UIWindow"

local theme = {
	Background = Color( 255, 255, 255 ),
	Mono1 = Color( 56, 58, 66 ),
	Mono2 = Color( 105, 108, 119 ),
	Mono3 = Color( 160, 161, 167 ),
	Cyan = Color( 1, 132, 188 ),
	Blue = Color( 64, 120, 242 ),
	Purple = Color( 166, 38, 164 ),
	Green = Color( 80, 161, 79 ),
	Red1 = Color( 228, 86, 79 ),
	Red2 = Color( 202, 18, 67 ),
	Orange1 = Color( 152, 104, 1 ),
	Orange2 = Color( 193, 132, 1 )
}

---@class Photon2UICode : Photon2UIWindow
local PANEL = {}

PANEL.AllowAutoRefresh = true
PANEL.TitleMain = "Code Viewer"

function PANEL:Init()
	self.BaseClass.Init( self )
	self:Setup()
end

function PANEL:Setup()
	if ( IsValid( self.Content ) ) then self.Content:Remove() end
	self:MakePopup()
	self:SetTitleMain( self.TitleMain )

	local this = self
	local content = vgui.Create( "DPanel", self )
	content:Dock( FILL )
	content:SetPaintBackground( false )
	content:DockPadding( 4, 4, 4, 4 )
	self.Content = content

	local textPanel = vgui.Create( "DPanel", content )
	textPanel:Dock( FILL )
	textPanel:DockPadding( 2, 2, 2, 2 )

	local richText = vgui.Create( "RichText", textPanel )
	richText:Dock( FILL )
	self.RichText = richText

	function richText:InsertColorChangeEx( color )
		self:InsertColorChange( color.r, color.g, color.b, color.a )
	end

	self.RichText.Paint = function( panel )

	    -- panel.m_FontName = DBugR.Prefix .. "LuaViewFont"
	    -- panel:SetFontInternal( DBugR.Prefix .. "LuaViewFont" )	
	    panel:SetBGColor( Color( theme.Background.r, theme.Background.g, theme.Background.b, 255 ) );
	    -- panel.Paint = nil

	end

	local buttonsPanel = vgui.Create( "DPanel", content )
	buttonsPanel:Dock( BOTTOM )
	buttonsPanel:SetTall( 36 )
	buttonsPanel:SetPaintBackground( false )

	local closeButton = vgui.Create( "EXDButton", buttonsPanel )
	closeButton:Dock( RIGHT )
	closeButton:SetWide( 96 )
	closeButton:SetText( "Close" )
	closeButton:SetIcon( "close" )
	closeButton:DockMargin( 0, 8, 0, 0 )

	function closeButton:DoClick()
		this:Close()
	end

	local copyButton = vgui.Create( "EXDButton", buttonsPanel )
	copyButton:Dock( RIGHT )
	copyButton:SetWide( 140 )
	copyButton:SetText( "    Copy to Clipboard" )
	copyButton:SetIcon( "content-copy" )
	copyButton:DockMargin( 0, 8, 4, 0 )

	function copyButton:DoClick()
		SetClipboardText( this.Code )
		if ( not IsValid( self ) ) then return end
		self:SetText( "Copied" )
		self:SetIcon( "checkbox-marked-circle" )
		self:SetEnabled( false )
		timer.Simple( 0.5, function()
			if ( not IsValid( self ) ) then return end
			self:SetText( "Copy to Clipboard" )
			self:SetIcon( "content-copy" )
			self:SetEnabled( true )
		end)
	end

	if ( self.Code ) then
		self:SetCode( self.Code )
	end
end


local function startsWith(str, start)
	return string.sub(str, 1, string.len(start)) == start
end

local function splitLine(line)
    local parts = {}
    for part in string.gmatch(line, "[^%s%.]+") do
        table.insert(parts, part)
    end
    return parts
end

function PANEL:SetCode( code, title )
	if ( title ) then self:SetMainTitle( title ) end
	self.Code = code
	if ( not IsValid( self.RichText ) ) then self:Setup() end
	local asLines = string.Explode( "\n", code, false )
	for lineNumber, line in pairs( asLines ) do
		-- Handle comments
		if ( startsWith( string.Trim( line ), "--" ) ) then
			if ( string.match( line, "^%-%-%s*(%d+)%." ) ) then
				self.RichText:InsertColorChangeEx( theme.Red1 )
			else
				self.RichText:InsertColorChangeEx( theme.Mono3 )
			end
			self.RichText:AppendText( line .. "\n" )
		else
			-- for i, part in pairs( splitLine( line ) ) do
			-- 	self.RichText:AppendText( part )
			-- 	-- self.RichText:AppendText( part )
			-- end
			self.RichText:InsertColorChangeEx( theme.Mono1 )
			self.RichText:AppendText( line .. "\n" )
		end
	end
	-- self.RichText:InsertColorChange( theme.Mono2.r, theme.Mono2.g, theme.Mono2.b, 255 )
	-- self.RichText:AppendText( code )
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

derma.DefineControl( class, "Photon 2 code viewer/editor.", PANEL, base )
