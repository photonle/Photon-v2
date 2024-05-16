local info, warn, warnonce = Photon2.Debug.Declare( "SirenPreviewer" )

local defaultVolume = 33

---@class PhotonUISirenPreview : Panel
local PANEL = {
	AllowAutoRefresh = true
}

function PANEL:Init()
	self.BaseClass.Init( self )
	local this = self
	self:Setup()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:Setup()
	self:DockPadding( 8, 8, 8, 8 )
	if ( self.CurrentEntryName ) then
		self:Clear()
		self:SetEntry( self.CurrentEntryName )
	end
end

function PANEL:SetEntry( sirenName )
	self:Clear()

	self.CurrentEntryName = sirenName
	self.CurrentEntry = Photon2.GetSiren( sirenName )
	-- PrintTable( self.CurrentEntry )

	local content = vgui.Create( "DPanel", self )
	content:SetPaintBackground( false )
	content:Dock( FILL )

	local makeLabel = vgui.Create( "DLabel", content )
	makeLabel:Dock( TOP )
	makeLabel:SetText( self.CurrentEntry.Make or "Unknown")

	local titleLabel = vgui.Create( "DLabel", content )
	titleLabel:Dock( TOP )
	titleLabel:SetFont( "PhotonUI.Header" )
	titleLabel:SetText( self.CurrentEntry.Model or "Unknown" )

	---@type Photon2UILibraryMetaPanel
	local metaPanel = vgui.Create( "Photon2UILibraryMetaPanel", content )
	metaPanel:Dock( TOP )
	metaPanel:DockMargin( 0, 8, 0, 8 )
	metaPanel:SetValue( self.CurrentEntry.Name, "Author: " .. tostring( self.CurrentEntry.Author or "Unknown" ) )

	
	local tonesPanel = vgui.Create( "DPanel" )
	tonesPanel:SetPaintBackground( false )

	local tabControl = vgui.Create( "DPropertySheet", content )
	tabControl:SetFadeTime( 0 )
	tabControl:Dock( FILL )


	local bottomControls = vgui.Create( "DPanel", content )
	bottomControls:Dock( BOTTOM )
	bottomControls:SetHeight( 32 )
	bottomControls:DockMargin( 0, 8, 0, 0)
	bottomControls:DockPadding( 8, 0, 8, 0)

	local bottomVolumeSlider = vgui.Create( "DNumSlider", bottomControls )
	bottomVolumeSlider:SetText( "Volume:" )
	bottomVolumeSlider:Dock( FILL )
	bottomVolumeSlider:SetDecimals( 0 )
	bottomVolumeSlider:SetMin( 0 )
	bottomVolumeSlider:SetMax( 100 )
	bottomVolumeSlider:SetValue( cookie.GetNumber( "photon_siren_preview_volume", defaultVolume ) )
	function bottomVolumeSlider:OnValueChanged( val )
		cookie.Set( "photon_siren_preview_volume", val )
	end

	local tonesTab = tabControl:AddSheet( "Tones", tonesPanel )

	local tonesContent = vgui.Create( "DScrollPanel", tonesPanel )
	tonesContent:SetPaintBackground( false )
	tonesContent:Dock( FILL )

	local function addSoundPanel( parent, icon, code, name, soundPath )
		local this = vgui.Create( "DPanel", parent )
		this:DockPadding( 8, 8, 8, 8 )

		-- This is the absolute dumbest fucking shit but
		-- it's the only way to get padding to work correctly
		function this:PerformLayout( w, h )
			if ( parent:GetVBar():IsVisible() ) then
				this:DockMargin( 0, 0, 8, 4 )
			else
				this:DockMargin( 0, 0, 0, 4 )
			end
		end

		this:Dock( TOP )
		this:SetHeight( 44 )
		this:DockMargin( 0, 0, 0, 8 )

		local iconImage = Photon2.HUD.ToneIcons.siren
		if ( icon and Photon2.HUD.ToneIcons[icon] ) then
			iconImage = Photon2.HUD.ToneIcons[icon]
		end

		local iconPanel = vgui.Create( "DImage", this )
		iconPanel:SetImageColor( Color( 0, 0, 0, 128 ) )
		iconPanel:DockMargin( 0, 2, 0, 2 )
		iconPanel:SetMaterial( iconImage )
		iconPanel:Dock( LEFT )
		iconPanel:SetWidth( 24 )

		local nameLabel = vgui.Create( "DLabel", this )
		nameLabel:SetFont( "PhotonUI.Mono" )
		nameLabel:Dock( LEFT )
		nameLabel:SetText( code )
		nameLabel:DockMargin( 4, 0, 0, 0 )
		nameLabel:SetWidth( 40 )

		local detailPanel = vgui.Create( "DPanel", this )
		detailPanel:Dock( FILL )
		detailPanel:DockMargin( 0, -8, 8, -8 )
		detailPanel:SetPaintBackground( false )

		local soundNameLabel = vgui.Create ("DLabel", detailPanel )
		soundNameLabel:Dock( TOP )
		soundNameLabel:DockMargin( 0, 4, 0, 0 )
		soundNameLabel:SetFont( "PhotonUI.Header" )
		soundNameLabel:SetText( name or "Unknown" )
		
		local soundPathLabel = vgui.Create( "DLabel", detailPanel )
		soundPathLabel:Dock( BOTTOM )
		soundPathLabel:DockMargin( 0, 0, 0, 4 )
		soundPathLabel:SetText( soundPath )

		local playerButton = vgui.Create( "EXDButton", this )
		playerButton:SetText("")
		playerButton:SetIcon( "play" )
		playerButton:Dock( RIGHT )
		playerButton:SetWidth( 28 )

		function playerButton:OnDepressed()
			local snd = CreateSound( LocalPlayer(), soundPath )
			snd:PlayEx( cookie.GetNumber( "photon_siren_preview_volume", defaultVolume ) / 100, 100 )
			self.ActiveSound = snd
		end

		function playerButton:OnReleased()
			if ( self.ActiveSound ) then
				self.ActiveSound:Stop()
			end
		end
	end

	for tone, data in SortedPairs( self.CurrentEntry.Tones or {} ) do
		if ( tone == "OFF" ) then continue end
		addSoundPanel( tonesContent, data.Icon, tone, data.Name, data.Sound )
	end

	local extraSounds = 0

	for name, data in pairs( self.CurrentEntry.Sounds ) do
		if ( tone == "OFF" or data.Default ) then continue end
		extraSounds = extraSounds + 1
	end

	if ( extraSounds > 0 ) then
		local soundsPanel = vgui.Create( "DPanel" )
		soundsPanel:SetPaintBackground( false )

		local soundsTab = tabControl:AddSheet( "Extra", soundsPanel )

		local soundsContent = vgui.Create( "DScrollPanel", soundsPanel )
		soundsContent:SetPaintBackground( false )
		soundsContent:Dock( FILL )

		for tone, data in SortedPairs( self.CurrentEntry.Sounds or {} ) do
			if ( tone == "OFF" or data.Default ) then continue end
			addSoundPanel( soundsContent, data.Icon, data.Default or "", data.Name, data.Sound )
		end
	end
end

derma.DefineControl( "Photon2UISirenPreviewer", "Photon 2 siren previewer", PANEL, "DPanel" )
