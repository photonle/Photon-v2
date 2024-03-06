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

local function IsKeyBindDown( cmd )

	-- Yes, this is how engine does it for input.LookupBinding
	for keyCode = 1, BUTTON_CODE_LAST do

		if ( input.LookupKeyBinding( keyCode ) == cmd and input.IsKeyDown( keyCode ) ) then
			return true
		end

	end

	return false

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

		function modelPanel:SetComponent( componentId, static )
			if ( IsValid( PHOTON2_PREVIEW_COMPONENT ) ) then
				PHOTON2_PREVIEW_COMPONENT:Remove()
			end
			local component = Photon2.GetComponent( componentId )
			local ent = component:CreateForUI()
			ent:SetScale( ent.Preview.Zoom )
			self.Entity = ent
			
			PHOTON2_PREVIEW_COMPONENT = ent
			
			ent:SetChannelMode( "Emergency.Warning", "MODE3" )

			if ( not static ) then
				local newZ = ent.Preview.Position.Z + 20
				self:SetLookAng( Angle( newZ, 0, 0 ) )
				self:SetCamPos( Vector( -60, 0, newZ ) )
			end

			hook.Add( "Think", ent, function() 
				local index = ent:ManualThink()
				if ( not ent.IsPaused ) then
					this.PlayerControls:SetFrameIndex( index )
				end
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

	local sequencePlayer = vgui.Create( "Photon2UISequencePlayerControls", overviewTab )
	sequencePlayer:Dock( BOTTOM )
	sequencePlayer:DockMargin( 0, 4, 0, 0 )
	sequencePlayer:DockPadding( 4, 0, 4, 0 )

	function sequencePlayer:OnPause() activeComponent:SetPaused( true ) end
	function sequencePlayer:OnPlay() activeComponent:SetPaused( false ) end

	function sequencePlayer:OnForwardOne() activeComponent:IndependentFrameTick( true ) end
	function sequencePlayer:OnBackOne() activeComponent:IndependentFrameTick( true, -1 ) end

	function sequencePlayer:OnFrameSliderChange( value )
		-- activeComponent.FrameIndex = value
		print("setting frame index to: " .. tostring( value ) )
		activeComponent:SetFrameIndex( value - 1 )
		-- ErrorNoHaltWithStack()
	end

	self.PlayerControls = sequencePlayer

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

	local function sequenceSelected( segment, sequence )
		local sequenceData = this.CurrentEntry.Segments[segment].Sequences[sequence]
		this.PlayerControls:SetSequence( sequenceData )
		this.PlayerControls:DoPlay()
		if( modelPanel ) then
			Photon2.ComponentBuilder.ApplyDebugSequences( entryName, { [segment] = sequence } )
			modelPanel:SetComponent( entryName, true )
			modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
		end
	end

	local function segmentSelected( segment )
		this.PlayerControls:SetSliderVisible( false )
		this.PlayerControls:DoPlay()
		if ( modelPanel ) then
			Photon2.ComponentBuilder.ApplyDebugSequences( entryName, segment )
			modelPanel:SetComponent( entryName, true )
			modelPanel.Entity:SetChannelMode( "#DEBUG", "ON", true )
		end
	end

	local function modeSelected( channel, mode )
		this.PlayerControls:SetSliderVisible( false )
		if ( modelPanel ) then
			modelPanel.Entity:SetChannelMode( channel, mode, true )
			self.PlayerControls:Show()
		end
	end
	
	local function modeOff()
		if ( modelPanel ) then
			modelPanel.Entity:ClearAllModes()
			self.PlayerControls:Hide()
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
		if ( channelName == "#DEBUG" ) then continue end
		local channelNode = inputsNode:AddNode( channelName, "ray-vertex", true )
		for modeName, sequences in SortedPairs( modes ) do
			local modeNode = channelNode:AddNode( modeName, "chevron-right-circle-outline" )
			function modeNode:OnNodeSelected()
				if ( activeComponent.CurrentModes[channelName] ~= modeName ) then
					if ( activeComponent ) then
						modeSelected( channelName, modeName )
					end
				else
					modeOff()
					modeNode:SetSelected( false )
				end
			end
			if ( istable( sequences ) ) then
				for k, v in pairs( sequences ) do
					local sequenceNode = modeNode:AddNode( string.format("%s/%s", k, v), "filmstrip" )
					function sequenceNode:OnNodeSelected()
						sequenceSelected( k, v)
					end
				end
			elseif ( isstring( sequences ) ) then
				local patternNode = modeNode:AddNode( sequences, "play-box" )
				function patternNode:OnNodeSelected()
					sequenceSelected( k, v)
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
					sequenceSelected( sequence[1], sequence[2] )
				end
			end
			function patternNode:OnNodeSelected()
				segmentSelected( patternName )
			end
		end
	end

	local segmentsNode = tree:AddNode( "Sequences", "movie-roll", true )
	for segmentName, segment in SortedPairs( entry.Segments or {} ) do
		local segmentNode = segmentsNode:AddNode( segmentName, "film", true )
		for sequenceName, sequence in SortedPairs( segment.Sequences or {}) do
			local sequenceNode = segmentNode:AddNode( sequenceName, "filmstrip" )
			function sequenceNode:OnNodeSelected()
				sequenceSelected( segmentName, sequenceName )
			end
		end
	end
	-- segmentsNode:SetExpanded( true )



end

function PANEL:Setup()
	self:DockPadding( 8, 8, 8, 8 )
	if ( self.CurrentEntryName ) then
		self:Clear()
		self:SetEntry( self.CurrentEntryName )
	end
end


--[[
	Sequence Player Controls
--]]

local PLAYER = {
	AllowAutoRefresh = true
}

function PLAYER:SetSequence( sequence )
	self.CurrentSequence = sequence
	self:SetSequenceLength( #sequence )
	self:SetSliderVisible( true )
end

function PLAYER:Show()
	self:SetVisible( true )
	self:InvalidateParent()
end

function PLAYER:Hide()
	self:SetVisible( false )
	self:InvalidateParent()
end

function PLAYER:SetFrameIndex( index )
	self.Slider.Suppress = true
	self.Slider:SetValue( ( index % self.Slider:GetMax() ) + 1 )
	self.Slider.Suppress = false
end

function PLAYER:OnPause() end

function PLAYER:OnPlay() end

function PLAYER:OnFrameSliderChange( value ) end

function PLAYER:OnForwardOne() end
function PLAYER:OnBackOne() end

function PLAYER:DoPause()
	self.IsPaused = true
	self.PlayButton:SetIcon( "play" )
	self:OnPause()
end

function PLAYER:DoPlay()
	self.IsPaused = false
	self.PlayButton:SetIcon( "pause" )
	self:OnPlay()
end

function PLAYER:DoForwardOne()
	self:DoPause()
	self:SetFrameIndex( self.Slider:GetValue() )
	self:OnForwardOne()
end

function PLAYER:DoBackOne()
	self:DoPause()
	-- This needs to be -2 to work properly because
	-- it's not worth figuring out what's actually happening
	self:SetFrameIndex( self.Slider:GetValue() - 2 )
	self:OnBackOne()
end

-- Sets label of the current *actual* frame.
function PLAYER:SetRealFrame( frame )
	self.RealFrameLabel:SetText( "=[" .. tostring( frame ) .. "]" )
end

-- Sets the current frame index of the sequence.
function PLAYER:SetSequenceFrame( frame )
	self.Slider.Suppress = true
	self.Slider:SetValue( frame )
	self.Slider.Suppress = false
end

function PLAYER:SetSequenceLength( length )
	self.Slider:SetMax( length )
	self.Slider:SetValue( 1 )
end

function PLAYER:SetSliderVisible( visible )
	if ( visible ) then
		self.Slider:SetVisible( true )
		self.RealFrameLabel:SetVisible( true )
		self:SetHeight( 64 )
	else
		self.RealFrameLabel:SetVisible( false )
		self.Slider:SetVisible( false )
		self:SetHeight( 40 )
	end
end

function PLAYER:Init()
	self:Clear()
	
	self:SetHeight( 40 )
	
	local this = self
	self.IsPaused = false

	local sequencePlayer = self

	local slider = vgui.Create( "DNumSlider", sequencePlayer )
	slider:Dock( TOP )
	slider:SetHeight( 24 )
	slider:SetDecimals( 0 )
	slider:SetMax( 1 )
	slider:SetMin( 1 )
	slider:SetDefaultValue( 1 )
	slider.Label:SetVisible( false )
	slider:DockPadding( 0, 0, 0, 0 )
	slider.TextArea:SetWide( 26 )
	slider:SetVisible( false )
	self.Slider = slider

	function slider:OnValueChanged( value )
		value = math.floor( value ) 
		if ( this.LastValue == value ) then return end
		if ( this.CurrentSequence ) then this:SetRealFrame( this.CurrentSequence[value] ) end
		if ( slider.Suppress ) then return end
		this:OnFrameSliderChange( value )
		this.LastValue = value
	end

	local playerControls = vgui.Create( "DPanel", sequencePlayer )
	playerControls:Dock( FILL )
	playerControls:SetPaintBackground( false ) 

	local playButton = vgui.Create( "EXDButton", playerControls )
	playButton:SetIcon( "pause", true )
	playButton:SetSize( 48, 28 )
	playButton:AlignLeft( 2 )
	playButton:AlignTop( 6 )

	self.PlayButton = playButton

	function playButton:OnReleased()
		if ( self.Wait ) then 
			self.Wait = false
			self:SetIcon( "play" )
			return
		end
		if ( not this.IsPaused ) then return end
		this:DoPlay()
		self.Wait = false
	end

	function playButton:OnDepressed()
		if ( this.IsPaused ) then return end
		this.IsPaused = true
		this:OnPause()
		self.Wait = true
	end

	local stepBackButton = vgui.Create( "EXDButton", playerControls )
	stepBackButton:SetIcon( "skip-previous", true )
	stepBackButton:SetSize( 32, 28 )
	stepBackButton:MoveRightOf( playButton, 4 )
	stepBackButton:AlignTop( 6 )

	function stepBackButton:OnDepressed() this:DoBackOne() end

	local stepForwardButton = vgui.Create( "EXDButton", playerControls )
	stepForwardButton:SetIcon( "skip-next", true )
	stepForwardButton:SetSize( 32, 28 )
	stepForwardButton:MoveRightOf( stepBackButton, 4 )
	stepForwardButton:AlignTop( 6 )
	
	function stepForwardButton:OnDepressed() this:DoForwardOne() end


	local currentFrame = vgui.Create( "DLabel", playerControls )
	currentFrame:Dock( RIGHT )
	currentFrame:SetWide( 48 )
	currentFrame:SetText( "= [99]" )
	currentFrame:SetContentAlignment( 5 )
	currentFrame:SetFont( "PhotonUI.Mono" )
	currentFrame:SetVisible( false )
	self.RealFrameLabel = currentFrame
end

function PLAYER:PostAutoRefresh()
	-- print("post auto")
	-- self:Init()
end

derma.DefineControl( "Photon2UISequencePlayerControls", "Photon 2 component previewer", PLAYER, "DPanel" )
derma.DefineControl( class, "Photon 2 component previewer", PANEL, base )