local class = "Photon2HUD"
local base = "DPanel"
local description = "Generic form because DForm is an unmaintained shit show."

local hudMaterial = Material("photon/ui/hud")

local convarAnchor = GetConVar( "ph2_hud_anchor" )
local convarOffsetX = GetConVar( "ph2_hud_offset_x" )
local convarOffsetY = GetConVar( "ph2_hud_offset_y" )
local convarDraggable = GetConVar( "ph2_hud_draggable" )

---@class Photon2HUD : Panel
local PANEL = {}
PANEL.AllowAutoRefresh = true
PANEL.PrimaryWidth = 150
PANEL.CanvasSize = { Width = 340, Height = 210 }


function PANEL:Init()
	self:Setup()
end

-- Changes the horizontal layout depending on which side the HUD is on
function PANEL:CheckLayout()
	local parentW, parentH = self:GetParentSize()
	local oldValue = Photon2.HUD.FromRight
	if ( self:GetX() + ( self:GetWide() / 2 ) ) > ( parentW / 2 ) then
		Photon2.HUD.FromRight = true
	else
		Photon2.HUD.FromRight = false
	end
end

-- If the panel can be dragged using the cursor
function PANEL:GetMoveable()
	return convarDraggable:GetBool()
end

-- Checks if the cursor is in the _primary_ display area, as the actual panel size
-- is larger and transparent than would be intuively expected
function PANEL:CursorWithinInteractionZone()
	if ( Photon2.HUD.FromRight ) then
		return ( ( gui.MouseX() - self.x ) >= self:GetWide() - self.PrimaryWidth )
	else
		return ( ( gui.MouseX() - self.x ) < self.PrimaryWidth )
	end
end

-- Saves the corrent location into appropriate convars
function PANEL:SavePosition()
	local x = self:GetX()
	local y = self:GetY()

	local anchorTop = ( y < ScrH() / 2 )
	local anchorLeft = ( x < ScrW() / 2 )

	local anchorString
	if ( anchorTop ) then 
		anchorString = "top_"
	else
		y = ScrH() - y
		anchorString = "bottom_"
	end
	
	if ( anchorLeft ) then 
		anchorString = anchorString .. "left"
	else
		x = ScrW() - x
		anchorString = anchorString .. "right"
	end

	convarAnchor:SetString( anchorString )
	convarOffsetX:SetInt( x )
	convarOffsetY:SetInt( y )
end

-- Retrieves and applies the saved position from convars
function PANEL:RestorePosition()
	-- local anchorString = convarAnchor:GetString()
	local anchorString = convarAnchor:GetString()
	local x = convarOffsetX:GetInt()
	local y = convarOffsetY:GetInt()
	-- local x = convarOffsetX:GetInt()
	-- local y = convarOffsetY:GetInt()

	local anchorTop = anchorString:find( "top" ) ~= nil
	local anchorLeft = anchorString:find( "left" ) ~= nil

	if ( not anchorTop ) then
		y = ScrH() - y
	end

	if ( not anchorLeft ) then
		x = ScrW() - x
	end

	self:SetPos( 
		math.Clamp( x, 0, ScrW() - self:GetWide() ),
		math.Clamp( y, 0, ScrH() - self:GetTall() )
	)
	self:CheckLayout()
end

function PANEL:Setup()
	-- self:SetMouseInputEnabled( false )
	self.ScreenLock = true
	self:SetSize( self.CanvasSize.Width, self.CanvasSize.Height )
	local originBottom = false
	local textureSize = 496 
	self:SetPaintBackground( false )
	self:CheckLayout()
	local x, y
	function self:Paint( w, h )
		if ( not self.HudPaint ) then return end

		if ( Photon2.HUD.FromRight ) then
			x = w - textureSize
		else
			x = 0
		end

		if ( originBottom ) then
			y = h - textureSize
		else
			y = 0
		end

		if ( self.Dragging ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 128 ) )
			-- surface.SetDrawColor( 0, 0, 0, 128 )
			-- surface.Draw( x, y, textureSize, textureSize )
			-- surface.SetDrawColor( 255, 255, 255, 255 )
			-- surface.DrawRect( 0, 0, w, 1 )
			-- surface.DrawRect( w - 1, 0, 1, h )
		end
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( hudMaterial )
		surface.DrawTexturedRect( x, y, 496, 496 )
		surface.SetAlphaMultiplier( 0 )

		self.HudPaint = false
	end

	hook.Add( "HUDPaint", self, function() 
		self.HudPaint = true
	end)

	cvars.AddChangeCallback( "ph2_hud_offset_x", function() self:RestorePosition() end, "Photon2.HUD" )
	cvars.AddChangeCallback( "ph2_hud_offset_y", function() self:RestorePosition() end, "Photon2.HUD" )
	cvars.AddChangeCallback( "ph2_hud_anchor", function() self:RestorePosition() end, "Photon2.HUD" )
end

function PANEL:ShowContextMenu()
	if ( IsValid( self.ContextMenu ) ) then
		self.ContextMenu:Remove()
	end
	local contextMenu = DermaMenu( false )
	local customize = contextMenu:AddOption( "Customize HUD...", function() 
		local menu = Photon2.UI.GetOrCreatePhotonMenu()
		menu:SetTab( "HUD" )
	end )
	customize:SetIcon( "photon/ui/photon_2_icon_16.png" )
	contextMenu:AddCVar( "Draggable", "ph2_hud_draggable", "1", "0" )
	contextMenu:AddOption( "Close", function()
		if ( IsValid( self ) ) then
			self:Remove()
		end
	end)
	self.ContextMenu = contextMenu
	contextMenu:SetPos( gui.MouseX(), gui.MouseY() )
	-- why the fuck isn't this default behavior?
	timer.Simple( 0, function()
		-- TODO: might as well throw this into the Photon UI library
		if ( not IsValid( contextMenu ) ) then return end
		if ( gui.MouseX() + contextMenu:GetWide() > ScrW() ) then
			contextMenu:SetX( ScrW() - contextMenu:GetWide() )
		end
		if ( gui.MouseY() + contextMenu:GetTall() > ScrH() ) then
			contextMenu:SetY( ScrH() - contextMenu:GetTall() )
		end
	end )

end

function PANEL:OnMousePressed( keyCode )
	if ( not self:CursorWithinInteractionZone() ) then
		self:SetCursor( "arrow" )
		return
	end
	if ( keyCode == MOUSE_LEFT ) then
		if ( not self:GetMoveable() ) then return end
		local screenX, screenY = self:LocalToScreen( 0, 0 )
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	elseif ( keyCode == MOUSE_RIGHT ) then
		self:ShowContextMenu()
	end
end

function PANEL:OnMouseReleased( keyCode )
	if ( keyCode == MOUSE_LEFT ) then
		self:MouseCapture( false )
		if ( self.Dragging ) then self:SavePosition() end
		self.Dragging = nil
		-- if ( not self:CursorWithinInteractionZone() ) then
		-- 	self:SetCursor( "arrow" )
		-- end
	end
end

function PANEL:GetParentSize()
	local w = ScrW()
	local h = ScrH()
	if ( IsValid( self:GetParent() ) ) then
		w = self:GetParent():GetWide()
		h = self:GetParent():GetTall()
	end
	return w, h
end

function PANEL:Think()


	if ( self.Dragging ) then
		local mouseX = math.Clamp( gui.MouseX(), 1, ScrW() - 1 )
		local mouseY = math.Clamp( gui.MouseY(), 1, ScrH() - 1 )
		local x = mouseX - self.Dragging[1]
		local y = mouseY - self.Dragging[2]
		Photon2.HUD.StartTime = 0
		if ( self.ScreenLock ) then
			local maxW, maxH = self:GetParentSize()
			x = math.Clamp( x, 0, maxW - self:GetWide() )
			y = math.Clamp( y, 0, maxH - self:GetTall() )
		end
		self:SetCursor( "sizeall" )
		self:SetPos( x, y )
		self:CheckLayout()
	end

	-- self.Hovered is absolutely fucking broken
	if ( self.Hovered ) then
		if ( self.Dragging ) then
			self:SetCursor( "sizeall" )
			-- sometimes self.Hovered is false when it should be true
			-- so this is a (hopefully) cheap workaround
			self.ModifiedCursor = true
		else
			if ( self:CursorWithinInteractionZone() ) then
				if ( self:GetMoveable() ) then
					self:SetCursor( "sizeall" )
					self.ModifiedCursor = true
				else
					self:SetCursor( "arrow" )
				end
			else
				self:SetCursor( "arrow" )
			end
		end
	elseif ( self.ModifiedCursor and not self.Dragging ) then
		self:SetCursor( "arrow" )
		self.ModifiedCursor = false
	end
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

derma.DefineControl( class, description, PANEL, base )

class = "Photon2HUDWindow"
base = "Photon2UIWindow"
description = "HUD control"

PANEL = {}
PANEL.AllowAutoRefresh = true

function PANEL:Init()
	self.BaseClass.Init( self )
	local this = self
	self:Setup()
end

function PANEL:Setup()	self:SetSize( 720, 720 )
	self:SetSize( 720, 720 )
	self:Center()
	if ( IsValid( self.Content ) ) then
		self.Content:Remove()
	end
	local content = vgui.Create( "Photon2HUD", self )
	self.Content = content
	content:SetPos( 0, 24 )
	content:SetSize( 340, 210 )
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

derma.DefineControl( class, description, PANEL, base )
