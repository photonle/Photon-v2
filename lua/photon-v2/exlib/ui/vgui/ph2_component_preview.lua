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

	local scrollPanel = vgui.Create( "DPanel", self )
	scrollPanel:SetPaintBackground( false )
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
		local modelPanel = vgui.Create( "DAdjustableModelPanel", scrollPanel )
		modelPanel:Dock( TOP )
		modelPanel:SetTall( 100 )
		modelPanel:SetCamPos( Vector( -50, 0, 5 ) )
		modelPanel:SetLookAng( Angle( 5, 0, 0 ) )
		modelPanel:SetFOV( 50 )
		modelPanel:SetAnimated( false )
		-- modelPanel:SetFOV( this.FOV or 45 )
		-- modelPanel.Angles = angle_zero
		-- modelPanel:SetSize( 200, 200 )
		modelPanel:SetModel( entry.Model )

		function modelPanel:FirstPersonControls()

			local x, y = self:CaptureMouse()
		
			local scale = self:GetFOV() / 180
			x = x * -0.5 * scale
			y = y * 0.5 * scale
		
			if ( self.MouseKey == MOUSE_LEFT ) then
		
				if ( input.IsShiftDown() ) then y = 0 end
		
				self.aLookAngle = self.aLookAngle + Angle( y * 1, x * 1, 0 )
		
				self.vCamPos = self.OrbitPoint - self.aLookAngle:Forward() * self.OrbitDistance
		
				return
			end
		
			-- Look around
			self.aLookAngle = self.aLookAngle + Angle( y, x, 0 )
			self.aLookAngle.p = math.Clamp( self.aLookAngle.p, -90, 90 )
		
			local Movement = vector_origin
		
			if ( IsKeyBindDown( "+forward" ) or input.IsKeyDown( KEY_UP ) ) then
				Movement = Movement + self.aLookAngle:Forward()
			end
		
			if ( IsKeyBindDown( "+back" ) or input.IsKeyDown( KEY_DOWN ) ) then
				Movement = Movement - self.aLookAngle:Forward()
			end
		
			if ( IsKeyBindDown( "+moveleft" ) or input.IsKeyDown( KEY_LEFT ) ) then
				Movement = Movement - self.aLookAngle:Right()
			end
		
			if ( IsKeyBindDown( "+moveright" ) or input.IsKeyDown( KEY_RIGHT ) ) then
				Movement = Movement + self.aLookAngle:Right()
			end
		
			if ( IsKeyBindDown( "+jump" ) or input.IsKeyDown( KEY_SPACE ) ) then
				Movement = Movement + vector_up
			end
		
			if ( IsKeyBindDown( "+duck" ) or input.IsKeyDown( KEY_LCONTROL ) ) then
				Movement = Movement - vector_up
			end
		
			local speed = 0.5
			if ( input.IsShiftDown() ) then speed = 4.0 end
		
			self.vCamPos = self.vCamPos + Movement * speed
		
		end

		-- function modelPanel:LayoutEntity()

		-- end
		-- function modelPanel:DragMousePress( mouseCode )
		-- 	self.PressX, self.PressY = input.GetCursorPos()
		-- 	if ( mouseCode == MOUSE_LEFT ) then
		-- 		self.Pressed = true
		-- 		self.RightPressed = false
		-- 	elseif ( mouseCode == MOUSE_RIGHT ) then
		-- 		self.Pressed = false
		-- 		self.RightPressed = true
		-- 	end
		-- end

		-- function modelPanel:DragMouseRelease( mouseCode ) 
		-- 	if ( mouseCode == MOUSE_LEFT ) then
		-- 		self.Pressed = false 
		-- 	elseif ( mouseCode == MOUSE_RIGHT ) then
		-- 		self.RightPressed = false 
		-- 	end
		-- end

		-- function modelPanel:LayoutEntity( ent )
		-- 	if ( self.bAnimated ) then self:RunAnimation() end

		-- 	if ( self.Pressed ) then
		-- 		local mx, my = input.GetCursorPos()
		-- 		-- self.Angles = self.Angles - Angle( ( ( self.PressY or my ) - my ) / 2, ( ( self.PressX or mx ) - mx ) / 2, 0 )
		-- 		-- self.Angles = self.Angles - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )
		-- 		-- self.Angles:RotateAroundAxis( angle_zero:Right(), ( ( self.PressY or my ) - my ) / 2 )
		-- 		self.Angles:RotateAroundAxis( angle_zero:Up(), ( ( self.PressX or mx ) - mx ) / -2 )
		-- 		self.PressX, self.PressY = mx, my
		-- 	elseif ( self.RightPressed ) then
		-- 		local mx, my = input.GetCursorPos()
		-- 		-- self.Angles = self.Angles - Angle( ( ( self.PressY or my ) - my ) / 2, ( ( self.PressX or mx ) - mx ) / 2, 0 )
		-- 		-- self.Angles = self.Angles - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )
		-- 		self.Angles:RotateAroundAxis( angle_zero:Right(), ( ( self.PressY or my ) - my ) / 2 )
		-- 		self.PressX, self.PressY = mx, my
		-- 	end

		-- 	ent:SetAngles( self.Angles )
		-- end

		-- function modelPanel:OnMouseWheeled( delta )
		-- 	-- print( tostring( delta ) )
		-- 	local fov = math.Clamp( modelPanel:GetFOV() + ( delta * -1 ), 0, 180 )
		-- 	modelPanel:SetFOV( fov )
		-- 	this.FOV = fov
		-- end

	end

	local overviewTab = vgui.Create( "DPanel", scrollPanel )
	local modelTab = vgui.Create( "DPanel", scrollPanel )
	-- modelTab:DockMargin( -4, -4, 0, 0 )

	local propertySheet = vgui.Create ("DPropertySheet", scrollPanel )
	propertySheet:DockMargin( 0, 8, 0, 0 )
	propertySheet:Dock( FILL )
	propertySheet:AddSheet( "Component", overviewTab )
	propertySheet:AddSheet( "Model", modelTab )
	propertySheet:DockPadding( 0, 0, 0, 0 )

	local tree = vgui.Create( "EXDTree", overviewTab )
	tree:SetLineHeight( 22 )
	tree:Dock( FILL )
	


	-- Override function because selecting a node will do nothing
	function tree:SetSelectedItem( node ) end

	if ( entry.States ) then
		local slotsNode = tree:AddNode( "State Slots", "numeric", true )
		for i, state in ipairs( entry.States ) do
			local stateNode = slotsNode:AddNode( state, "numeric-" .. tostring( i ) .. "-circle-outline")
		end
		slotsNode:SetExpanded( true )
	end

	local inputsNode = tree:AddNode( "Inputs", "power-plug", true )
	for channelName, modes in pairs( entry.Inputs or {} ) do
		local channelNode = inputsNode:AddNode( channelName, "ray-vertex", true )
		for modeName, sequences in SortedPairs( modes ) do
			local modeNode = channelNode:AddNode( modeName, "chevron-right-circle-outline", true )
			if ( istable( sequences ) ) then
				for k, v in pairs( sequences ) do
					modeNode:AddNode( string.format("%s/%s", k, v), "filmstrip" )
				end
			elseif ( isstring( sequences ) ) then
				modeNode:AddNode( sequences, "play-box" )
			end
		end
		-- channelNode:SetExpanded( true )
	end
	-- inputsNode:SetExpanded( true )

	if ( entry.Patterns ) then
		local patternsNode = tree:AddNode( "Patterns", "animation-play", true )
		for patternName, sequences in pairs( entry.Patterns ) do
			local patternNode = patternsNode:AddNode( patternName, "play-box", true )
			for i, sequence in pairs( sequences or {} ) do
				patternNode:AddNode( string.format("[%s]: %s", sequence[1], sequence[2] ), "filmstrip" )
			end
			-- for segmentName, sequence in 
		end
		-- patternsNode:SetExpanded( true )
	end

	local segmentsNode = tree:AddNode( "Sequences", "movie-roll", true )
	for segmentName, segment in SortedPairs( entry.Segments or {} ) do
		local segmentNode = segmentsNode:AddNode( segmentName, "film", true )
		for sequenceName, sequence in SortedPairs( segment.Sequences or {}) do
			local sequenceNode = segmentNode:AddNode( sequenceName, "filmstrip" )
		end
	end
	-- segmentsNode:SetExpanded( true )


	-- Model Tab
	-- local pform = vgui.Create( "EXPForm", modelTab )
	-- pform:AddEXPControl( "Test", "EXDPField", "Test String", "Value", "Main" )
	-- pform:AddEXPControl( "Test1", "EXDPAngle", "Test String", Angle(1,1,1), "Main" )
end

function PANEL:Setup()
	self:DockPadding( 8, 8, 8, 8 )
	if ( self.CurrentEntryName ) then
		self:Clear()
		self:SetEntry( self.CurrentEntryName )
	end
end

derma.DefineControl( class, "Photon 2 component previewer", PANEL, base )
