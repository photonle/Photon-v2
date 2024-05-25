local class = "Photon2UIDesktop"
local base = "Photon2UIWindow"

---@class Photon2UIDesktop : Photon2UIWindow
---@field ActiveTabName string
local PANEL = {}

PANEL.AllowAutoRefresh = true

function PANEL:SetTab( tab )
	if ( IsValid( self.Tabs ) ) then
		self.Tabs:SwitchToName( tab )
	end
end

function PANEL:Setup()
	self:SetupMenuBar()
	if ( IsValid( self.ContentContainer ) ) then self.ContentContainer:Clear() end
	
	local container = self.ContentContainer
	local this = self

	self:SetTitle("Menu - Photon 2")
	self:SetSize( 400, 500 )
	self:Center()

	local logoContainer = vgui.Create( "DPanel", container )
	logoContainer:SetPaintBackground( false )
	logoContainer:Dock( TOP )
	logoContainer:SetContentAlignment( 5 )
	logoContainer:SetHeight( 100 )

	local logo = vgui.Create( "DImage", logoContainer )
	logo:SetWidth( 300 )
	logo:SetHeight( 100 )
	logo:SetImage( "photon/ui/ui_logo.png" )
	logo:SetKeepAspect( true )
	logo:SetContentAlignment( 5 )

	local versionLabel = vgui.Create( "DLabel", logoContainer )
	versionLabel:Dock( BOTTOM )
	versionLabel:SetText( "Photon v" .. Photon2.Version )
	versionLabel:SetContentAlignment( 5 )

	function logoContainer:PerformLayout( w, h )
		logo:Center()
	end

	self:SetupMainPage()
	self:SetupRenderOptions()
	self:SetupHudOptions()

	local propertySheet = vgui.Create( "DPropertySheet", container )
	propertySheet:Dock( FILL )
	propertySheet:DockMargin( 0, 8, 0, 0 )
	self.Tabs = propertySheet
	propertySheet:AddSheet( "Photon 2", self.MainPage )
	propertySheet:AddSheet( "HUD", self.HudPage )
	propertySheet:AddSheet( "Graphics", self.RenderPage )

	function propertySheet:OnActiveTabChanged( old, new )
		-- This stupid shit is required to get the current tab name
		local name
		for i=1, #self.Items do
			local item = self.Items[i]
			if ( item.Tab == new ) then
				name = item.Name
				break
			end
		end
		this.ActiveTabName = name
	end

	self:SetTab( self.ActiveTabName )

end

function PANEL:Init()
	self.BaseClass.Init( self )

	local container = vgui.Create( "DPanel", self )
	container:Dock( FILL )
	container:SetPaintBackground( false )
	self.ContentContainer = container
	self.ActiveTabName = "Photon 2"
	self:Setup()
end

function PANEL:SetupMenuBar()
	local this = self
	if ( IsValid( self.MenuBar ) ) then self.MenuBar:Remove() end

	-- local menubar = self:GetOrBuildMenuBar()
	
	-- local fileMenu = menubar:AddMenu("File")
end

function PANEL:SetupRenderOptions()
	local panel = vgui.Create( "DScrollPanel", self )
	self.RenderPage = panel
	panel:Dock( FILL )

end

function PANEL:SetupHudOptions()
	local panel = vgui.Create( "DPanel", self )
	self.HudPage = panel
	panel:Dock( FILL )
	panel:DockMargin( 4, -4, 4, 4 )
	panel:DockPadding( 3, 3, 3, 3 )
	
	-- local container = vgui.Create( "DScrollPanel", panel )
	-- container:Dock( FILL )

	---@type Photon2UIFormPanel
	local form = vgui.Create( "Photon2UIFormPanel", panel )
	form.LabelWidth = 120
	form:Dock( FILL )

	form:CreateCheckBoxProperty( { "ph2_hud_enabled", "Bool" }, "Visible", Photon2.HudEnabled, { Descriptor = "Show in-vehicle HUD"} )
	form:CreateCheckBoxProperty( { "ph2_hud_draggable", "Bool" }, "Draggable", Photon2.HudDraggable, { Descriptor = "Enable HUD dragging" } )
	form:AddDivider()
	form:CreateColorProperty( { "ph2_hud_color_panel_active", "String" }, "Panel" )
	form:CreateColorProperty( { "ph2_hud_color_panel_inactive", "String" }, "Panel (Inactive)" )
	form:CreateColorProperty( { "ph2_hud_color_panel_alt_active", "String" }, "Panel Alt" )
	form:CreateColorProperty( { "ph2_hud_color_panel_alt_inactive", "String" }, "Panel Alt (Inactive)" )
	form:CreateColorProperty( { "ph2_hud_color_accent", "String" }, "Accent" )
	form:CreateColorProperty( { "ph2_hud_color_accent_inactive", "String" }, "Accent (Inactive)" )
	form:CreateColorProperty( { "ph2_hud_color_accent_alt", "String" }, "Accent (Alt)" )
	form:AddButton( "Reset to Default", function()
		RunConsoleCommand( "ph2_hud_color_panel_active", "64,64,64,200" )
		RunConsoleCommand( "ph2_hud_color_panel_inactive", "64,64,64,100" )
		RunConsoleCommand( "ph2_hud_color_panel_alt_active", "16,16,16,200" )
		RunConsoleCommand( "ph2_hud_color_panel_alt_inactive", "16,16,16,100" )
		RunConsoleCommand( "ph2_hud_color_accent", "255,255,255,255" )
		RunConsoleCommand( "ph2_hud_color_accent_inactive", "0,0,0,128" )
		RunConsoleCommand( "ph2_hud_color_accent_alt", "255,255,255,96" )
	end)
	form:AddDivider()
	form:CreateComboBoxProperty( { "ph2_hud_anchor", "String" }, "Anchor", "Bottom Left", { 
		{ "Bottom Left", "bottom_left" },
		{ "Bottom Right", "bottom_right" },
		{ "Top Left", "top_left" },
		{ "Top Right", "top_right" }
	} )
	form:CreateNumberSliderProperty( { "ph2_hud_offset_x", "Int" }, "X Offset", 0, 0, ScrW(), 0 )
	form:CreateNumberSliderProperty( { "ph2_hud_offset_y", "Int" }, "Y Offset", 0, 0, ScrH(), 0 )
	form:AddButton( "Reset to Default", function()
		print("Resetting to default...")
		RunConsoleCommand( "ph2_hud_enabled", "1" )
		RunConsoleCommand( "ph2_hud_offset_x", "360" )
		RunConsoleCommand( "ph2_hud_offset_y", "385" )
		RunConsoleCommand( "ph2_hud_anchor", "bottom_right" )
	end)
end

function PANEL:SetupMainPage()
	local panel = vgui.Create( "DPanel", self )
	panel:DockPadding( 8, 8, 8, 8 )
	self.MainPage = panel
	local mainText = vgui.Create( "DLabel", panel )
	mainText:Dock( FILL )
	mainText:SetWrap( true )
	mainText:SetText("You are running Photon 2. This addon is a platform for emergency vehicles and related functionality.\n\nPhoton 2 is currently in a public beta phase.")
	mainText:SetContentAlignment( 7 )
	function panel:AddButton( label, icon, onClick )
		local button = vgui.Create( "EXDButton", panel )
		button:Dock( BOTTOM )
		button:SetHeight( 40 )
		button:DockMargin( 0, 8, 0, 0 )
		button:SetText( label )
		if ( icon ) then button:SetIcon( icon ) end
		function button:DoClick()
			if ( isfunction( onClick ) ) then
				onClick()
			end
		end
	end

	panel:AddButton( "Join the Photon Discord Server", "discord", function() gui.OpenURL( "https://photon.lighting/discord" ) end )
	panel:AddButton( "Open Documentation", "bookshelf", function() gui.OpenURL( "https://photon.lighting/docs") end )
	panel:AddButton( "Key Bindings & Input Configurations", "keyboard-variant", 
		function() 
			-- if ( self.ContextParent ) then
			-- 	local window = self.ContextParent:Add( "Photon2UIInputConfiguration" )
			-- 	window:MakePopup()
			-- else
				vgui.Create( "Photon2UIInputConfiguration" ) 
			-- end
		end 
	)
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

derma.DefineControl( class, "", PANEL, base )
