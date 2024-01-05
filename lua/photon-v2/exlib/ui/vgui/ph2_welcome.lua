local class = "Photon2UIWelcome"
local base = "Photon2UIWindow"

---@class Photon2UIDesktop : Photon2UIWindow
local PANEL = {}

PANEL.AllowAutoRefresh = true

local welcomeText = 
[[
Welcome to Photon 2. 

You are seeing this window because Photon 2 has just been installed.

Photon 2 is a new emergency vehicle platform for Garry's Mod and complete rewrite of the Photon Lighting Engine. It provides vehicle lighting, emergency lighting, sirens and more. Compared to Photon Lighting Engine, Photon 2 is designed to be more stable, more compatible, and feature-rich. 

This addon is currently in beta and undergoing active development with many more planned features on the way. Your feedback is welcome.

Multiplayer is supported and has been modestly tested.
]]

local starterText = 
[[
Looking to get started? 

Download the official Starter Pack collection from Workshop to try out the Photon 2 demonstrator vehicles:
]]

local starterText2 = 
[[

A game restart may be required to ensure the new content mounts correctly. The Photon 2 demonstrator vehicles can then be spawned from the Vehicles tab of the spawn menu within Photon 2 category.
]]

local controlsText1 = 
[[
Controls in Photon 2 are highly customizable. You can use any button on a keyboard, mouse, or joystick (32-bit Garry's Mod only), and even setup multi-key combinations.

For advanced users, you can create multiple control profiles and assign them to specific vehicles. 

Photon 2 will display only the essential controls whenever you get in a vehicle. Once you're comfortable, you can check out the Input Configuration editor to view, adjust and manage your controls. Photon 2 has dedicated controls for traffic advisors, scene lighting, cruise lighting, airhorns, manual sirens and more.
]]

local controlsTextVCMod =
[[
VCMod detected!

It looks like you have VCMod Main installed. This might conflict with Photon 2's default controls (e.g. F, R, H). 

Would you like to use Photon 2's alternate input configuration so Photon 2 won't use VCMod's standard keys?
]]

local vcmodText2 = 
[[ 
Note: Photon 2's basic lighting features may still overlap with VCMod's depending on the vehicle configuration. Better integration is a work in progress.
]]

local controlsText2 = 
[[

Want to create your own bindable commands? No problem. Use Photon 2's command framework and create your own. They are server-safe and can be shared on any client.
]]

local helpTextTop = 
[[
Need assistance? Find any bugs? Join our Discord community.
]]

local helpTextMid = 
[[ 
Want to learn more about Photon 2 or begin creating content like vehicles, sirens, components, and more? Check out the Photon 2 Wiki for more information.
]]

local helpTextBottom =
[[ 
Press "Dismiss for Now" to close this window until next game load. 

Press "Close" to close this window and never see it on game load again. (You can always re-open it from the Photon 2 menus later.)

Note: This window only appears automatically in single-player mode. (Server owners )
]]

local function addContentLabel( panel, text )
	local label = vgui.Create( "DLabel", panel )
	label:Dock( TOP )
	label:SetWrap( true )
	label:SetText( text )
	label:SetAutoStretchVertical( true )
	return label
end

function PANEL:SetupTabWelcome( panel )
	local mainText = addContentLabel( panel, welcomeText )
end

function PANEL:SetupTabStarter( panel )
	local intro = addContentLabel( panel, starterText )
	local workshopButton = vgui.Create( "EXDButton", panel )
	workshopButton:Dock( TOP )
	workshopButton:SetText( "Download Starter Pack Collection..." )
	workshopButton:SetIcon( "download" )
	function workshopButton:DoClick()
		gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=3100377468" )
	end
	local mid = addContentLabel( panel, starterText2 )
	local demoImage = vgui.Create( "DImage", panel )
	demoImage:Dock( TOP )
	demoImage:SetHeight( 100 )
	demoImage:SetImage( "photon/ui/welcome/demo_vehicles.png")
	demoImage:SetKeepAspect( true )
end

function PANEL:SetupTabControls( panel )
	local mainText = addContentLabel( panel, controlsText1 )
	local inputConfigButton = vgui.Create( "EXDButton", panel )
	inputConfigButton:Dock( TOP )
	inputConfigButton:SetText( "Open Input Configuration Editor..." )
	inputConfigButton:SetIcon( "keyboard-variant" )
	function inputConfigButton:DoClick()
		vgui.Create( "Photon2UIInputConfiguration" )
	end
	local advancedText = addContentLabel( panel, controlsText2 )
end

function PANEL:SetupTabVCMod( panel )
	local vcmodtext = addContentLabel( panel, controlsTextVCMod )
	local applyVCModConfig = vgui.Create( "EXDButton", panel )
	applyVCModConfig:Dock( TOP )
	applyVCModConfig:SetText( "Apply Alternate Input Configuration" )
	applyVCModConfig:SetIcon( "keyboard" )
	addContentLabel( panel, vcmodText2 )
	function applyVCModConfig:DoClick()
		-- Photon2.ClientInput.SetProfilePreference( "#global", "default_alt" )
		self:SetText( "Alternate Configuration Applied")
		self:SetEnabled( false )
	end
end

function PANEL:SetupTabHelp( panel )
	local helpLabel = addContentLabel( panel, helpTextTop )
	local discordButton = vgui.Create( "EXDButton", panel )
	discordButton:Dock( TOP )
	discordButton:SetText( "Join the Photon Community Discord..." )
	discordButton:SetIcon( "discord" )
	function discordButton:DoClick()
		gui.OpenURL( "https://photon.lighting/discord" )
	end
	local moreLabel = addContentLabel( panel, helpTextMid )
	local wikiButton = vgui.Create( "EXDButton", panel )
	wikiButton:Dock( TOP )
	wikiButton:SetText( "Open the Photon 2 Wiki & Documentation..." )
	wikiButton:SetIcon( "bookshelf" )
	function wikiButton:DoClick()
		gui.OpenURL( "https://photon.lighting/docs" )
	end
	addContentLabel( panel, helpTextBottom )
end

function PANEL:AddTab( name, banner )
	local this = self

	local panel = vgui.Create( "DPanel", self.ContentContainer )
	panel:SetPaintBackground( false )

	local navigationPanel = vgui.Create( "DPanel", panel )
	navigationPanel:Dock( BOTTOM )
	navigationPanel:SetHeight( 32 )
	navigationPanel:SetPaintBackground( false )

	local nextButton = vgui.Create( "EXDButton", navigationPanel )
	nextButton:Dock( RIGHT )
	nextButton:SetText( "Next  ►" )
	nextButton:SetWidth( 96 )
	function nextButton:DoClick()
		this:NavigateNextTab()
	end

	local previousButton = vgui.Create( "EXDButton", navigationPanel )
	previousButton:Dock( LEFT )
	previousButton:SetText( "◄   Previous" )
	previousButton:SetWidth( 96 )
	function previousButton:DoClick()
		this:NavigatePreviousTab()
	end

	local content = vgui.Create( "DScrollPanel", panel )
	content:DockMargin( 0, 0, 0, 8 )
	content:Dock( FILL )

	local addedTab = self.Tabs:AddSheet( name, panel )
	self.TabIndex[#self.TabIndex+1] = name
	
	panel.TabIndex = #self.TabIndex
	addedTab.Tab.TabIndex = #self.TabIndex
	self.TabsByName[name] = addedTab
	self.Banners[#self.TabIndex] = banner

	return content
end

function PANEL:NavigateToTabIndex( index )
	self.Tabs:SwitchToName( self.TabIndex[index] )
end

function PANEL:NavigateNextTab()
	local nextIndex = self.SelectedTabIndex + 1
	if ( nextIndex > #self.TabIndex ) then nextIndex = #self.TabIndex end
	self:NavigateToTabIndex( nextIndex )
end

function PANEL:NavigatePreviousTab()
	local nextIndex = self.SelectedTabIndex - 1
	if ( nextIndex < 1 ) then nextIndex = 1 end
	self:NavigateToTabIndex( nextIndex )
end


function PANEL:SetBannerImage( imgPath )
	if ( not IsValid( self.BannerImage ) ) then return end
	self.BannerImage:SetImage( imgPath, "photon/ui/welcome/banner_default.png" )
end


function PANEL:Setup()
	
	local this = self
	
	local container = self.ContentContainer
	container:Clear()

	self:SetTitle( "Welcome to Photon 2")
	self:SetWidth( 500 )
	self:Center()

	self.TabIndex = {}
	self.TabsByName = {}

	local banner = vgui.Create( "DPanel", container )
	banner:Dock( TOP )
	banner:SetHeight( 200 )
	banner:DockMargin( 0, 0, 0, 4 )

	self.Banners = {}

	local bannerImage = vgui.Create( "DImage", banner )
	bannerImage:Dock( FILL )
	bannerImage:SetKeepAspect( true )
	bannerImage:SetImage( "photon/ui/welcome/banner_default.png" )

	self.BannerImage = bannerImage

	local tabs = vgui.Create( "DPropertySheet", container )
	tabs:Dock( FILL )
	function tabs:OnActiveTabChanged( old, new )
		this.SelectedTabIndex = new.TabIndex
		-- this:SetBannerImage( this.Banners[new.TabIndex] )
	end
	self.Tabs = tabs

	self:SetupTabWelcome( self:AddTab( "Welcome" ) )
	self:SetupTabStarter( self:AddTab( "Starter Pack" ) )
	if ( Photon2.IsVCModInstalled() )  then self:SetupTabVCMod( self:AddTab( "VCMod" ) ) end
	self:SetupTabControls( self:AddTab( "Controls" ) )
	self:SetupTabHelp( self:AddTab( "Help & Support" ) )

	local bottomButtons = vgui.Create( "DPanel", container )
	bottomButtons:SetPaintBackground( false )
	bottomButtons:Dock( BOTTOM )
	bottomButtons:SetHeight( 28 )
	bottomButtons:DockPadding( 0, 4, 0, 0 )

	local dismissButton = vgui.Create( "EXDButton", bottomButtons )
	dismissButton:Dock( RIGHT )
	dismissButton:SetText( "Close" )
	dismissButton:SetWidth( 128 )
	function dismissButton:DoClick()
		this:Close()
		cookie.Set( "Photon2.WelcomeScreenSeen", 1 )
	end

	local laterButton = vgui.Create( "EXDButton", bottomButtons )
	laterButton:Dock( RIGHT )
	laterButton:SetText( "Dismiss for Now" )
	laterButton:SetWidth( 128 )
	laterButton:DockMargin( 0, 0, 4, 0 )
	function laterButton:DoClick()
		this:Close()
		cookie.Set( "Photon2.WelcomeScreenSeen", 0 )
	end

	if ( self.SelectedTabIndex ) then self:NavigateToTabIndex( self.SelectedTabIndex ) end

end

function PANEL:Init()
	self.BaseClass.Init( self )

	local container = vgui.Create( "DPanel", self )
	container:Dock( FILL )
	container:SetPaintBackground( false )
	self.ContentContainer = container
	self.SelectedTabIndex = 1
	self:Setup()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:DoClose()
	cookie.Set( "Photon2.WelcomeScreenSeen", 1 )
	self:Close()
end

derma.DefineControl( class, "Photon 2 welcome window.", PANEL, base )

hook.Add( "HUDPaint", "Photon2.ShowWelcomeScreen", function()
	hook.Remove("HUDPaint", "Photon2.ShowWelcomeScreen")
	if ( ( not game.SinglePlayer() ) or ( cookie.GetNumber( "Photon2.WelcomeScreenSeen", 0 ) ~= 0 ) ) then return end
	local window = vgui.Create( "Photon2UIWelcome" )
	window:SetAlpha( 0 )
	window:AlphaTo( 255, 3, 1, function()
		window:MakePopup()
	end)
end)