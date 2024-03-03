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

	self.CurrentEntryName = entryName
	self.CurrentEntry = Photon2.Library.Components:GetInherited( entryName )

	local entry = self.CurrentEntry

	local titleLabel = vgui.Create( "DLabel", scrollPanel )
	titleLabel:Dock( TOP )
	-- titleLabel:SetHeight( 30 )
	titleLabel:SetFont( "PhotonUI.Header")
	titleLabel:SetText( entry.Title or "(Untitled)" )
	
	local activeComponent
	local modelPanel

	if ( entry.Model ) then
		modelPanel = vgui.Create( "DAdjustableModelPanel", scrollPanel )
		modelPanel:Dock( TOP )
		modelPanel:SetTall( 100 )
		modelPanel:SetCamPos( Vector( -60, 0, 20 ) )
		modelPanel:SetLookAng( Angle( 20, 0, 0 ) )
		modelPanel:SetFOV( 60 )
		modelPanel:SetAnimated( false )

		
		-- modelPanel:SetFOV( this.FOV or 45 )
		-- modelPanel.Angles = angle_zero
		-- modelPanel:SetSize( 200, 200 )
		-- modelPanel:SetModel( entry.Model )
		function modelPanel:Paint( w, h )

			if ( !IsValid( self.Entity ) ) then return end
		
			local x, y = self:LocalToScreen( 0, 0 )
		
			self:LayoutEntity( self.Entity )
		
			local ang = self.aLookAngle
			if ( !ang ) then
				ang = ( self.vLookatPos - self.vCamPos ):Angle()
			end
		
			cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )
		
			render.SuppressEngineLighting( true )
			render.SetLightingOrigin( self.Entity:GetPos() )
			render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
			render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
			render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) ) -- * surface.GetAlphaMultiplier()
		
			for i = 0, 6 do
				local col = self.DirectionalLight[ i ]
				if ( col ) then
					render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
				end
			end
			
			self.Entity:SetupBones()
			self:DrawModel()
			
			Photon2.RenderLightMesh.OnPreRender()
			Photon2.RenderLightMesh.DrawUI()
			Photon2.RenderLight2D.OnPreRender()
			Photon2.RenderLight2D.DrawUI()
			
			render.SuppressEngineLighting( false )
			cam.End3D()
		
			self.LastPaint = RealTime()
		
		end

		function modelPanel:SetComponent( componentId )
			if ( IsValid( PHOTON2_PREVIEW_COMPONENT ) ) then
				PHOTON2_PREVIEW_COMPONENT:Remove()
			end
			local component = Photon2.GetComponent( componentId )
			local ent = component:CreateForUI()
			ent:SetScale( ent.Preview.Zoom )
			self.Entity = ent
			PHOTON2_PREVIEW_COMPONENT = ent
			ent:SetChannelMode( "Emergency.Warning", "MODE3" )
			-- ent:SetMoveType( MOVETYPE_NONE )
			-- ent:SetAngles( Angle( 0.0001, 0.0001, 0.0001 ))
			-- ent:SetPos( Vector( 0, 0, 50 ) )
			-- local newZoomX = ( 10 * ent.Preview.Zoom ) - 70
			-- self:SetCamPos( Vector( newZoomX, 0,  20 ) )
			local newZ = ent.Preview.Position.Z + 20
			self:SetLookAng( Angle( newZ, 0, 0 ) )
			self:SetCamPos( Vector( -60, 0, newZ ) )
			hook.Add( "Think", ent, function() 
				ent:ManualThink()
				-- ent:SetupBones()
				-- ent:SetPropertiesFromEquipment( component )
			end)
			hook.Add( "Photon2:ComponentReloaded", self, function( hookName, id )
				if ( id == entryName or component.Ancestors[id] ) then
					this:SetEntry( entryName )
				end
			end )
			activeComponent = ent
		end

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

		modelPanel:SetComponent( entryName )


		function modelPanel:LayoutEntity()
			self.Entity:SetPos( self.Entity.Preview.Position )
			self.Entity:SetAngles( self.Entity.Preview.Angles )
		end
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
	overviewTab:SetPaintBackground( false )

	-- local modelTab = vgui.Create( "DPanel", scrollPanel )
	-- modelTab:DockMargin( -4, -4, 0, 0 )

	local propertySheet = vgui.Create ("DPropertySheet", scrollPanel )
	propertySheet:DockMargin( 0, 8, 0, 0 )
	propertySheet:Dock( FILL )
	propertySheet:AddSheet( "Component", overviewTab )
	-- propertySheet:AddSheet( "Model", modelTab )
	propertySheet:DockPadding( 0, 0, 0, 0 )

	local tree = vgui.Create( "EXDTree", overviewTab )
	tree:SetLineHeight( 22 )
	tree:Dock( FILL )
	

	local componentInfoPanel = vgui.Create( "DPanel", overviewTab )
	componentInfoPanel:Dock( TOP )
	componentInfoPanel:SetHeight( 48 )
	componentInfoPanel:DockMargin( 0, 0, 0, 4 )
	componentInfoPanel:DockPadding( 8, 4, 8, 4 )
	componentInfoPanel:SetCursor( "hand" )

	local nameLabel = vgui.Create( "DLabel", componentInfoPanel )
	nameLabel:Dock( TOP )
	-- nameLabel:SetHeight( 60 )
	nameLabel:SetFont( "PhotonUI.Mono" )
	nameLabel:SetText( entryName )

	local authorLabel = vgui.Create( "DLabel", componentInfoPanel )
	authorLabel:Dock( TOP )
	local function setAuthorLabelText()
		local authorText = "Author: " .. ( entry.Author or "Unknown" )
		if ( entry.Credits ) then
			for credit, name in pairs( entry.Credits ) do
				authorText = authorText .. " | " .. tostring( credit ) .. ": " .. tostring( name )
			end
		end
		authorLabel:SetText( authorText )
	end
	setAuthorLabelText()

	function componentInfoPanel:OnCursorEntered()
		authorLabel:SetText( "Click to copy component name..." )
	end
	
	function componentInfoPanel:OnCursorExited()
		setAuthorLabelText()
	end
	
	function componentInfoPanel:OnMousePressed( keyCode )
		if ( keyCode == MOUSE_LEFT ) then
			authorLabel:SetText( "" )
			SetClipboardText( entryName )
		end
	end

	function componentInfoPanel:OnMouseReleased( keyCode )
		if ( keyCode == MOUSE_LEFT ) then
			authorLabel:SetText( "Copied." )
		end
	end

	-- Override function because selecting a node will do nothing
	-- function tree:SetSelectedItem( node ) 
	-- 	-- if ( not node.Selectable ) then return end
	-- end

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
			local modeNode = channelNode:AddNode( modeName, "chevron-right-circle-outline" )
			function modeNode:OnNodeSelected()
				if ( activeComponent.CurrentModes[channelName] ~= modeName ) then
					if ( activeComponent ) then
						activeComponent:SetChannelMode( channelName, modeName, true )
					end
				else
					if ( activeComponent ) then
						activeComponent:ClearAllModes()
					end
					modeNode:SetSelected( false )
				end
			end
			if ( istable( sequences ) ) then
				for k, v in pairs( sequences ) do
					modeNode:AddNode( string.format("%s/%s", k, v), "filmstrip" )
					function modeNode:OnNodeSelected()
						if( modelPanel ) then
							Photon2.ComponentBuilder.ApplyDebugSequences( entryName, { [k] = v } )
							modelPanel:SetComponent( entryName )
							modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
						end
					end
				end
			elseif ( isstring( sequences ) ) then
				modeNode:AddNode( sequences, "play-box" )
				function modeNode:OnNodeSelected()
					if( modelPanel ) then
						Photon2.ComponentBuilder.ApplyDebugSequences( entryName, sequences )
						modelPanel:SetComponent( entryName )
						modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
					end
				end
			end
		end
		-- channelNode:SetExpanded( true )
	end
	-- inputsNode:SetExpanded( true )

	if ( entry.Patterns ) then
		local patternsNode = tree:AddNode( "Patterns", "animation-play", true )
		for patternName, sequences in pairs( entry.Patterns ) do
			local patternNode = patternsNode:AddNode( patternName, "play-box" )
			for i, sequence in pairs( sequences or {} ) do
				local sequenceNode = patternNode:AddNode( string.format("%s/%s", sequence[1], sequence[2] ), "filmstrip" )
				function sequenceNode:OnNodeSelected()
					if( modelPanel ) then
						Photon2.ComponentBuilder.ApplyDebugSequences( entryName, { [sequence[1]] = sequence[2] } )
						modelPanel:SetComponent( entryName )
						modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
					end
				end
			end
			function patternNode:OnNodeSelected()
				if( modelPanel ) then
					Photon2.ComponentBuilder.ApplyDebugSequences( entryName, patternName )
					modelPanel:SetComponent( entryName )
					modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
				end
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
			function sequenceNode:OnNodeSelected()
				if( modelPanel ) then
					Photon2.ComponentBuilder.ApplyDebugSequences( entryName, { [segmentName] = sequenceName } )
					modelPanel:SetComponent( entryName )
					modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
				end
			end
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
