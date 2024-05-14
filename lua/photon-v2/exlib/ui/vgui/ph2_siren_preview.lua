local info, warn, warnonce = Photon2.Debug.Declare( "SirenPreviewer" )

local defaultVolume = 0.33

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
	PrintTable( self.CurrentEntry )

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

	-- local soundsPanel = vgui.Create( "DPanel" )
	local tonesPanel = vgui.Create( "DPanel" )
	tonesPanel:SetPaintBackground( false )

	local tabControl = vgui.Create( "DPropertySheet", content )
	tabControl:Dock( FILL )


	local bottomControls = vgui.Create( "DPanel", content )
	bottomControls:Dock( BOTTOM )
	bottomControls:SetHeight( 32 )
	bottomControls:DockMargin( 0, 8, 0, 0)
	bottomControls:DockPadding( 8, 0, 8, 0)

	local bottomVolumeSlider = vgui.Create( "DNumSlider", bottomControls )
	bottomVolumeSlider:SetText( "Volume:" )
	bottomVolumeSlider:Dock( FILL )
	bottomVolumeSlider:SetValue( cookie.GetNumber( "photon_siren_preview_volume", defaultVolume ) )
	function bottomVolumeSlider:OnValueChanged( val )
		cookie.Set( "photon_siren_preview_volume", val )
	end

	local tonesTab = tabControl:AddSheet( "Tones", tonesPanel )
	-- local soundsTab = tabControl:AddSheet( "Sounds", soundsPanel )

	local tonesContent = vgui.Create( "DScrollPanel", tonesPanel )
	-- tonesContent:DockPadding( 0, 0, 0, 0 )
	-- tonesContent:DockMargin( 0, 0, 8, 0 )
	tonesContent:SetPaintBackground( false )
	tonesContent:Dock( FILL )


	local isFirst = true
	for tone, data in SortedPairs( self.CurrentEntry.Tones or {} ) do
		if ( tone == "OFF" ) then continue end
		local toneEntry = vgui.Create( "DPanel", tonesContent )
		toneEntry:DockPadding( 8, 8, 8, 8 )
		-- This is the absolute dumbest fucking shit but
		-- it's the only way to get padding to work correctly
		function toneEntry:PerformLayout( w, h )
			if tonesContent:GetVBar():IsVisible() then
				toneEntry:DockMargin( 0, 0, 8, 4 )
			else
				toneEntry:DockMargin( 0, 0, 0, 4 )
			end
		end

		toneEntry:Dock( TOP )
		toneEntry:SetHeight( 44 )
		toneEntry:DockMargin( 0, 0, 0, 8 )
		
		local iconImage = Photon2.HUD.ToneIcons.siren
		if ( data.Icon and Photon2.HUD.ToneIcons[data.Icon] ) then
			iconImage = Photon2.HUD.ToneIcons[data.Icon]
		end
		local icon = vgui.Create( "DImage", toneEntry )
		icon:SetImageColor( Color( 0, 0, 0, 128 ) )
		icon:DockMargin( 0, 2, 0, 2 )
		icon:SetMaterial( iconImage )
		icon:Dock( LEFT )
		icon:SetWidth( 24 )

		local nameLabel = vgui.Create( "DLabel", toneEntry )
		nameLabel:SetFont( "PhotonUI.Mono" )
		nameLabel:Dock( LEFT )
		nameLabel:SetText( tone )
		nameLabel:DockMargin( 4, 0, 0, 0 )
		nameLabel:SetWidth( 40 )

		local detailPanel = vgui.Create( "DPanel", toneEntry )
		detailPanel:Dock( FILL )
		detailPanel:DockMargin( 0, -8, 8, -8 )
		detailPanel:SetPaintBackground( false )

		local soundNameLabel = vgui.Create ("DLabel", detailPanel )
		soundNameLabel:Dock( TOP )
		soundNameLabel:DockMargin( 0, 4, 0, 0 )
		soundNameLabel:SetFont( "PhotonUI.Header" )
		soundNameLabel:SetText( data.Name or "Unknown" )
		
		local soundPathLabel = vgui.Create( "DLabel", detailPanel )
		soundPathLabel:Dock( BOTTOM )
		soundPathLabel:DockMargin( 0, 0, 0, 4 )
		soundPathLabel:SetText( data.Sound )

		local playerButton = vgui.Create( "EXDButton", toneEntry )
		playerButton:SetText("")
		playerButton:SetIcon( "play" )
		playerButton:Dock( RIGHT )
		playerButton:SetWidth( 28 )

		function playerButton:OnDepressed()
			local snd = CreateSound( LocalPlayer(), data.Sound )
			snd:PlayEx( cookie.GetNumber( "photon_siren_preview_volume", defaultVolume ), 100 )
			self.ActiveSound = snd
		end

		function playerButton:OnReleased()
			if ( self.ActiveSound ) then
				self.ActiveSound:Stop()
			end
		end

	end

	local soundsContent = vgui.Create( "DScrollPanel", soundsPanel )
	soundsContent:SetPaintBackground( false )
	soundsContent:Dock( FILL )
end

derma.DefineControl( "Photon2UISirenPreviewer", "Photon 2 siren previewer", PANEL, "DPanel" )
