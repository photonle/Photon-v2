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

		function modelPanel:LayoutEntity()

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

	local propertySheet = vgui.Create ("DPropertySheet", scrollPanel )
	propertySheet:DockMargin( 0, 8, 0, 0 )
	propertySheet:Dock( FILL )
	propertySheet:AddSheet( "Overview", overviewTab )

	local tree = vgui.Create( "EXDTree", overviewTab )
	tree:SetLineHeight( 22 )
	tree:Dock( FILL )

	if ( entry.Patterns ) then
		local patternsNode = tree:AddNode( "Patterns" )
		for patternName, sequences in pairs( entry.Patterns ) do
			local patternNode = patternsNode:AddNode( patternName )
			for i, sequence in pairs( sequences or {} ) do
				patternNode:AddNode( string.format("[%s]: %s", sequence[1], sequence[2] ) )
			end
			-- for segmentName, sequence in 
		end
	end

	local segmentsNode = tree:AddNode( "Segments" )
	for segmentName, segment in pairs( entry.Segments or {} ) do
		local segmentNode = segmentsNode:AddNode( segmentName )
		for sequenceName, sequence in pairs( segment.Sequences or {}) do
			local sequenceNode = segmentNode:AddNode( sequenceName )
		end
	end

	local inputsNode = tree:AddNode( "Inputs" )
	for channelName, modes in pairs( entry.Inputs or {} ) do
		local channelNode = inputsNode:AddNode( channelName )
		for modeName, sequences in pairs( modes ) do
			local modeNode = channelNode:AddNode( modeName )
			if ( istable( sequences ) ) then
				for k, v in pairs( sequences ) do
					modeNode:AddNode( string.format("[%s]: %s", k, v))
				end
			elseif ( isstring( sequences ) ) then
				modeNode:AddNode( sequences )
			end
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
