local class = "Photon2UIComponentPreviewer"
local base = "DPanel"

local PANEL = {}

PANEL.AllowAutoRefresh = true

function PANEL:Init()
	self.BaseClass.Init( self )
	local this = self
	self:Setup()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:SetEntry( entryName )
	self:Clear()

	local this = self

	local scrollPanel = vgui.Create( "DScrollPanel", self )
	scrollPanel:Dock( FILL )

	print("Loading: " .. tostring(entryName))
	self.CurrentEntryName = entryName
	self.CurrentEntry = Photon2.Library.Components:GetInherited( entryName )
	print("loaded: " .. tostring( self.CurrentEntry.Title ) )

	local entry = self.CurrentEntry

	local titleLabel = vgui.Create( "DLabel", scrollPanel )
	titleLabel:Dock( TOP )
	-- titleLabel:SetHeight( 30 )
	titleLabel:SetFont( "PhotonUI.Header")
	titleLabel:SetText( entry.Title or "(Untitled)" )
	
	local nameLabel = vgui.Create( "DLabel", scrollPanel )
	nameLabel:Dock( TOP )
	-- nameLabel:SetHeight( 60 )
	nameLabel:SetFont( "PhotonUI.Mono" )
	nameLabel:SetText( entryName )

	if ( entry.Model ) then
		local modelPanel = vgui.Create( "DModelPanel", scrollPanel )
		modelPanel:Dock( TOP )
		modelPanel:SetTall( 100 )
		modelPanel:SetCamPos( Vector( 100, 0, 0 ))
		modelPanel:SetLookAt( Vector( 0, 0, 0 ))
		modelPanel:SetFOV( this.FOV or 45 )
		modelPanel.Angles = angle_zero
		-- modelPanel:SetSize( 200, 200 )
		modelPanel:SetModel( entry.Model )

		function modelPanel:DragMousePress( mouseCode )
			self.PressX, self.PressY = input.GetCursorPos()
			if ( mouseCode == MOUSE_LEFT ) then
				self.Pressed = true
				self.RightPressed = false
			elseif ( mouseCode == MOUSE_RIGHT ) then
				self.Pressed = false
				self.RightPressed = true
			end
		end

		function modelPanel:DragMouseRelease( mouseCode ) 
			if ( mouseCode == MOUSE_LEFT ) then
				self.Pressed = false 
			elseif ( mouseCode == MOUSE_RIGHT ) then
				self.RightPressed = false 
			end
		end

		function modelPanel:LayoutEntity( ent )
			if ( self.bAnimated ) then self:RunAnimation() end

			if ( self.Pressed ) then
				local mx, my = input.GetCursorPos()
				-- self.Angles = self.Angles - Angle( ( ( self.PressY or my ) - my ) / 2, ( ( self.PressX or mx ) - mx ) / 2, 0 )
				-- self.Angles = self.Angles - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )
				-- self.Angles:RotateAroundAxis( angle_zero:Right(), ( ( self.PressY or my ) - my ) / 2 )
				self.Angles:RotateAroundAxis( angle_zero:Up(), ( ( self.PressX or mx ) - mx ) / -2 )
				self.PressX, self.PressY = mx, my
			elseif ( self.RightPressed ) then
				local mx, my = input.GetCursorPos()
				-- self.Angles = self.Angles - Angle( ( ( self.PressY or my ) - my ) / 2, ( ( self.PressX or mx ) - mx ) / 2, 0 )
				-- self.Angles = self.Angles - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )
				self.Angles:RotateAroundAxis( angle_zero:Right(), ( ( self.PressY or my ) - my ) / 2 )
				self.PressX, self.PressY = mx, my
			end

			ent:SetAngles( self.Angles )
		end

		function modelPanel:OnMouseWheeled( delta )
			-- print( tostring( delta ) )
			local fov = math.Clamp( modelPanel:GetFOV() + ( delta * -1 ), 0, 180 )
			modelPanel:SetFOV( fov )
			this.FOV = fov
		end

	end


end

function PANEL:Setup()
	self:DockPadding( 8, 8, 8, 8 )
	if ( self.CurrentEntryName ) then
		self:Clear()
		self:SetEntry( self.CurrentEntryName )
	end
end

derma.DefineControl( class, "Photon 2 component previewer", PANEL, base )
