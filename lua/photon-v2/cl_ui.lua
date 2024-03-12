Photon2.UI = Photon2.UI or {
	CursorReleased = false,
	HUD = {}
}

Photon2.UI.Icons = Photon2.UI.Icons or {
	Index = {}
}

surface.CreateFont( "Photon2.UI:Medium", {
	font = "Roboto Black",
	size = 14,
	weight = 100
} );

surface.CreateFont( "Photon2.UI:MediumSmall", {
	font = "Roboto Black",
	size = 12,
	weight = 900,
	additive = true
} );

surface.CreateFont( "Photon2.UI:Small", {
	font = "Roboto",
	size = 11,
	weight = 900
} );

surface.CreateFont( "Photon2.UI:ExtraSmall", {
	font = "Roboto Bold",
	size = 10,
	weight = 100
} );

--[[
	SETUP PROCEDURE
	1.
--]]

local function utfChar(code)
	return utf8.char(tonumber(code, 16))
end

function Photon2.UI.Icons.GenerateMap()
	local rawFile = file.Read("addons/Photon-2/data_static/photon_v2/misc/mdi_7_3_67.json", "MOD")
	if not rawFile then error("file didn't load - path is probably incorrect") end
	local asTable = util.JSONToTable( rawFile )
	local result = {}
	for i=1, #asTable do
		local entry = asTable[i]
		result[entry.name] = tonumber( "0x" .. entry.hex, 16 )
		-- result[entry.name] = utf8.char( tonumber( "0x" .. entry.hex, 16 ) )
	end
	local asJson = util.TableToJSON( result, true )
	SetClipboardText( asJson )
end
-- Photon2.UI.Icons.GenerateMap()

---@param keyName string
---@param style? "box" | "box-outline"
---@param fallback? string
function Photon2.UI.FindInputIcon( keyName, style, fallback )
	local icon = fallback or "keyboard-variant"
	style = style or "box"
	style = "-" .. style
	local arrowIcons = {
		UPARROW = "arrow-up-bold",
		RIGHTARROW = "arrow-right-bold",
		LEFTARROW = "arrow-left-bold",
		DOWNARROW = "arrow-down-bold"
	}
	if ( exui.FindIcon("alpha-" .. keyName .. style) ) then
		icon = "alpha-" .. keyName .. style
	elseif ( exui.FindIcon("numeric-" .. keyName .. style) ) then
		icon = "numeric-" .. keyName .. style
	elseif ( arrowIcons[keyName] ) then
		icon = arrowIcons[keyName] .. "-box-outline"
	elseif ( string.find( keyName, "MOUSE") == 1 ) then
		icon = "mouse"
	end
	return icon
end

Photon2.UI.DialogBox = {}

function Photon2.UI.DialogBox.UserError( message )
	local dialog = vgui.Create( "Photon2UIDialogWindow" )
	dialog:SetupDialog()
	dialog:SetTitle("Error")
	dialog:SetMainText( message )
	dialog:SetHeight( 128 )
	dialog:SetWidth( 250 )
	dialog:Center()
	dialog:DoModal()
	dialog:AddButton( "OK", function()
		dialog:Close()
	end)
	return dialog
end

function Photon2.UI.DialogBox.ConfirmSave( name, onSave, onDoNotSave, onCancel )
	local dialog = vgui.Create( "Photon2UIDialogWindow" )
	dialog:SetupDialog()
	dialog:SetTitle( "Save changes?" )
	if ( name == nil ) then name = "untitled" end
	dialog:SetMainText( "Do you want to save the changes you made to " .. tostring( name ) .. "?" )
	dialog:SetHeight( 128 )
	dialog:SetWidth( 320 )
	dialog:Center()
	dialog:DoModal()
	dialog:AddButton( "Cancel", function()
		if ( isfunction( onCancel ) ) then
			onCancel()
		end
		dialog:Close()
	end )
	dialog:AddButton( "Don't Save", function()
		if ( isfunction( onDoNotSave ) ) then
			onDoNotSave()
		end
		dialog:Close()
	end )
	dialog:AddButton( "Save", function()
		if ( isfunction( onSave ) ) then
			onSave()
		end
		dialog:Close()
	end )
	return dialog
end

function Photon2.UI.DialogBox.OpenReadOnly( name, onOpenReadOnly, onOpenCopy, onCancel )
	local dialog = vgui.Create( "Photon2UIDialogWindow" )
	dialog:SetupDialog()
	dialog:SetTitle( "Read-Only File" )
	dialog:SetMainText( tostring( name ) .. " is read-only and you will not be able to modify it.")
	dialog:SetHeight( 128 )
	dialog:SetWidth( 320 )
	dialog:Center()
	dialog:DoModal()
	dialog:AddButton( "Cancel", function()
		if ( isfunction( onCancel ) ) then
			onCancel()
		end
		dialog:Close()
	end)
	dialog:AddButton( "OK", function()
		if ( isfunction( onOpenReadOnly ) ) then
			onOpenReadOnly()
		end
		dialog:Close()
	end)
	dialog:AddButton( "Open as Copy", function()
		if ( isfunction( onOpenCopy ) ) then
			onOpenCopy()
		end
		dialog:Close()
	end)
end

function Photon2.UI.DialogBox.Confirm( title, message, onYes, onNo )
	local dialog = vgui.Create( "Photon2UIDialogWindow" )
	dialog:SetupDialog()
	dialog:SetTitle( title )
	dialog:SetMainText( message )
	dialog:SetHeight( 128 )
	dialog:SetWidth( 256 )
	dialog:Center()
	dialog:DoModal()
	dialog:AddButton( "No", function() 
		if ( isfunction( onNo ) ) then
			onNo()
		end
		dialog:Close()
	end )
	dialog:AddButton( "Yes", function() 
		if ( isfunction( onYes ) ) then
			onYes()
		end
		dialog:Close()
	end )
end

---@param text string
---@param onConfirm? function
---@param onCancel? function
function Photon2.UI.DialogBox.ButtonInput( text, onConfirm, onCancel )
	local dialog = vgui.Create( "Photon2UIDialogWindow" )
	dialog:SetupDialog()
	dialog:SetTitle( "Select a Key/Button" )
	dialog:SetWidth( 300 )
	dialog:SetHeight( 150 )
	dialog:Center()
	dialog:DoModal()
	dialog.ContentContainer:DockPadding( 8, 8, 8, 8 )
	-- local label = vgui.Create( "DLabel", dialog.ContentContainer )
	-- label:Dock( TOP )
	-- label:SetText( "Click the button below and press a key or button:")
	-- label:DockMargin( 0, 0, 0, 8 )
	local binder = vgui.Create( "DBinder", dialog.ContentContainer )
	binder:Dock( FILL )
	dialog:AddButton( "Cancel", function ()
		if onCancel and isfunction( onCancel ) then onCancel() end
		dialog:Close()
	end )
	dialog:AddButton( "Accept", function ()
		if onConfirm and isfunction( onConfirm ) then onConfirm( binder:GetValue() ) end
		dialog:Close()
	end )
	binder:DoClick()
end

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

function Photon2.UI.ReloadMenubar()
	-- Photon2.Debug.Print("\t" .. tostring(Photon2.UI.MenuBar))
	if (IsValid(Photon2.UI.MenuBar)) then
		-- Photon2.Debug.Print("\tMenuBar is valid..")
		Photon2.UI.MenuBar:Clear()
		timer.Simple(0.5, function()
			-- Photon2.UI.Menubar:Remove()
			-- Photon2.Debug.Print("\tRe-populating MenuBar...")
			Photon2.UI.PopulateMenuBar()
		end)
	end
end

function Photon2.UI.PopulateMenuBar()
	-- Necesssary due to debugMenu:SetDeleteSelf( false )
	-- TODO: populate on each open to resolve
	timer.Simple(0.01, function ()
		local menu = Photon2.UI.MenuBar
		

		local inputConfigOption = menu:AddOption( "Open Control Options", function()
			local form = vgui.Create ( "Photon2UIInputConfiguration" )
		end)

		local openDesktopWindow = menu:AddOption( "Open Photon 2 Menu", function()
			local form = vgui.Create ( "Photon2UIDesktop" )
			form:MakePopup()
			form:SetKeyBoardInputEnabled( false )
		end)

		local openWelcome = menu:AddOption( "Open Welcome Menu", function()
			local form = vgui.Create ( "Photon2UIWelcome" )
			-- form:SetAlpha( 0 )
			-- form:AlphaTo( 255, 2, 0, function()
			-- 	form:MakePopup()
			-- end)
		end)

		menu:AddSpacer()

		local inputProfileOption = menu:AddOption("Input Control Profiles")
		local inputProfileMenu = inputProfileOption:AddSubMenu()
		inputProfileMenu:SetDeleteSelf( false )

		for name, config in pairs( Photon2.Library.InputConfigurations.Repository ) do
			local opt = inputProfileMenu:AddOption( config.Title or "ERROR" )
			local men = opt:AddSubMenu()
			men:SetDeleteSelf( false )
			men:AddOption( "Set for Current Vehicle", function()
				if ( IsValid(Photon2.ClientInput.TargetController) ) then
					Photon2.ClientInput.SetProfilePreference( Photon2.ClientInput.TargetController:GetProfileName(), name )
				else
					print( "You must be in a vehicle." )
				end
			end )
			men:AddOption( "Set as Default", function()
				Photon2.ClientInput.SetProfilePreference( "#global", name )
			end )
		end

		menu:AddSpacer()

		local renderOptionsMenuOption = menu:AddOption( "Render Options" )
		local renderOptionsMenu = renderOptionsMenuOption:AddSubMenu()
		renderOptionsMenu:SetDeleteSelf( false )

		renderOptionsMenu:AddCVar( "Enable Projected Textures in MP", "ph2_enable_projectedtextures_mp", "1", "0" )
		renderOptionsMenu:AddCVar( "Enable Subtractive Rendering", "ph2_enable_subtractive_sprites", "1", "0" )
		renderOptionsMenu:AddCVar( "Enable 2D Lighting", "ph2_draw_light2d", "1", "0" )		

		local bloomOptionsMenuOption = renderOptionsMenu:AddOption( "Bloom Options" )
		local bloomOptionsMenu = bloomOptionsMenuOption:AddSubMenu()
		bloomOptionsMenu:SetDeleteSelf( false )
		bloomOptionsMenu:AddOption( "High Performance", function()
			Photon2.Render.ApplyBloomSettings( "HighPerformance" )
		end)

		bloomOptionsMenu:AddOption( "Balanced (Default)", function()
			Photon2.Render.ApplyBloomSettings( "Default" )
		end)

		bloomOptionsMenu:AddOption( "Vivid", function()
			Photon2.Render.ApplyBloomSettings( "Vivid" )
		end)

		bloomOptionsMenu:AddOption( "Max", function()
			Photon2.Render.ApplyBloomSettings( "Max" )
		end)

		-- local inputConfigSetDefaultOption = inputConfigMenu:AddOption( "Set Global" )
		-- local inputConfigSetDefaultMenu = inputConfigSetDefaultOption:AddSubMenu()
		-- inputConfigSetDefaultMenu:SetDeleteSelf( false )

		-- for name, config in pairs( Photon2.Library.InputConfigurations ) do
		-- 	inputConfigSetDefaultMenu:AddOption( config.Title, function()
		-- 		Photon2.ClientInput.SetProfilePreference( "#default", name )
		-- 	end)
		-- end

		-- local inputCurrentConfigSetDefaultOption = inputConfigMenu:AddOption( "Set for Current Vehicle" )
		-- local inputCurrentConfigSetDefaultMenu = inputCurrentConfigSetDefaultOption:AddSubMenu()
		-- inputCurrentConfigSetDefaultMenu:SetDeleteSelf( false )

		-- for name, config in pairs( Photon2.Library.InputConfigurations ) do
		-- 	inputCurrentConfigSetDefaultMenu:AddOption( config.Title, function()
		-- 		-- Photon2.ClientInput.SetProfilePreference( "#default", name )
		-- 	end)
		-- end

		local loggingOption = menu:AddOption( "Logging & Errors" )
		local loggingMenu = loggingOption:AddSubMenu()
		loggingMenu:SetDeleteSelf( false )

		local printLog = loggingMenu:AddCVar( "Display Log in Console", "ph2_enable_print_log", "1", "0" )
		local errorChat = loggingMenu:AddCVar( "Display Errors in Chat", "ph2_enable_chat_errors", "1", "0" )


		if not PHOTON2_STUDIO_ENABLED then return end

		menu:AddSpacer()

		-- local openStudioOption = menu:AddOption("Open Photon Studio", function()
		-- 	Photon2.Studio:Initialize()
		-- end)

		local debugOption = menu:AddOption( "Developer" )
		local debugMenu = debugOption:AddSubMenu()
		debugMenu:SetDeleteSelf( false )

		debugMenu:AddOption( "Open Channel Controller", function() 
			local form = vgui.Create( "Photon2ChannelController" )
		end)

		debugMenu:AddOption( "Open Component Browser", function() 
			RunConsoleCommand( "ph2_component_browser" )
		end)

		-- debugMenu:AddOption( "Open Component Inspector", function() 
		-- 	local form = vgui.Create( "Photon2UIComponentInspector" )
		-- end)

		local newComponentPrintOption = debugMenu:AddOption( "Print Component to Console" )
		local newComponentPrintOptionMenu = newComponentPrintOption:AddSubMenu()
		newComponentPrintOptionMenu:SetDeleteSelf( false )

		for id, entry in pairs( Photon2.Library.Components.Repository ) do
			local innerOption = newComponentPrintOptionMenu:AddOption( id )
			local innerOptionMenu = innerOption:AddSubMenu()
			innerOptionMenu:SetDeleteSelf( false )
			local printRepo = innerOptionMenu:AddOption( "Raw", function()
				PrintTable( Photon2.Library.Components:Get( id ) )
			end )
			local printCompiled = innerOptionMenu:AddOption( "Compiled", function()
				PrintTable( Photon2.GetComponent( id ) )
			end )
		end

		local light2dDebugOption = debugMenu:AddCVar("Display Light Overlay", "ph2_debug_light_overlay", "1", "0")
		local drawInput = debugMenu:AddCVar( "Display Button Inputs", "ph2_display_input", "1", "0" )

		debugMenu:AddOption( "Clear Mesh Cache", function()
			Photon2.MeshCache.ClearCache()
		end)

		debugMenu:AddSpacer()
		debugMenu:AddOption( "Refresh Menubar", function()
			Photon2.UI.ReloadMenubar()
		end)

	end)
	
end

function Photon2.UI.OnPopulateMenuBar( menubar )
	Photon2.UI.MenuBar = menubar:AddOrGetMenu( "Photon 2" )
	Photon2.UI.PopulateMenuBar()
	-- Photon2.Debug.Print("PopulateMenuBar called.")
end

concommand.Add("ph2_debug_reloadmenubar", function()
	Photon2.UI.ReloadMenubar()
end)

hook.Add( "PopulateMenuBar", "Photon2:PopulateMenuBar", Photon2.UI.OnPopulateMenuBar )

concommand.Add("ph2_component_browser", function() 
	local browser = vgui.Create( "Photon2UILibraryBrowser" )
	browser:Setup( "Components", "BROWSE" )
	browser:SetSizing( 1280, 700, 400 )
end)

--[[
	Sandbox Properties Context Menu 
--]]

properties.Add("photon2_equipment", {
	MenuLabel = "Equipment",
	MenuIcon = "photon/ui/photon_2_icon_16.png",
	Order = 60,
	Filter = function(self, ent, ply)
		if (not IsValid( ent:GetPhotonController() )) then
			return false
		end
		return true
	end,
	Action = function()
	end,
	---@param ent PhotonController
	MenuOpen = function(self, option, ent)
		local hasAnyOptions = false
		local controller = ent:GetPhotonController()
		local currentSelections = controller.CurrentSelections
		local selections = controller:GetProfile().EquipmentSelections
		-- Required so child elements can be applied
		local subMenu = option:AddSubMenu()
		for i, category in ipairs( selections ) do
			if ( not category.Options ) or ( #category.Options < 2 ) then continue end
			hasAnyOptions = true
			-- Create category's sub-menu
			local categoryMenu = subMenu:AddSubMenu( category.Category )
			-- Process each option
			for _i, opt in ipairs( category.Options ) do
				-- Process variants if applicable
				if (opt.Variants) then
					local optMenu = categoryMenu:AddSubMenu( opt.Option )
					for __i, variant in ipairs(opt.Variants) do
						local this = optMenu:AddOption( variant.Variant, function()
							Photon2.cl_Network.SetControllerSelection( controller, { { i, variant.Selection } } )
						end)
						if (currentSelections[i] == variant.Selection ) then
							this:SetChecked( true )
						end
					end
				else
					if ( not opt.Option ) then continue end
					-- Process option if applicable
					local this = categoryMenu:AddOption( opt.Option, function() 
						Photon2.cl_Network.SetControllerSelection( controller,  { { i, opt.Selection } }  )
					end)

					if (currentSelections[i] == opt.Selection) then
						this:SetChecked( true )
					end

				end
			end
		end
		if ( not hasAnyOptions ) then
			subMenu:AddOption( "(No equipment options)" )
		end
	end
})

--[[
		Desktop Windows
--]]
list.Set("DesktopWindows", "Photon2", {
	title = "Photon 2",
	icon = "photon/ui/photon_2_icon_64.png",
	onewindow = true,
	init = function( icon, window )
		-- Needs a hacky workaround because the window is a defined Derma panel
		-- and not just a mutated DFrame.
		local parent = window:GetParent()
		window:Remove()
		if ( IsValid( icon.Photon2Window ) ) then
			icon.Photon2Window:Center()
			return
		end
		window = parent:Add( "Photon2UIDesktop" )
		window.ContextParent = parent
		icon.Photon2Window = window
	end
})

if PHOTON2_STUDIO_ENABLED then
	-- list.Set("DesktopWindows", "PhotonStudio", {
	-- 	title = "Photon Studio",
	-- 	icon = "photon/ui/photon_studio_icon_64.png",
	-- 	init = function( icon, window )
	-- 		Photon2.Studio:Setup( window )
	-- 	end
	-- })
end
--[[
		Photon Studio Window
--]]

Photon2.Studio = Photon2.Studio or {}

local Studio = Photon2.Studio
function Studio:Initialize()
	if not ( PHOTON2_STUDIO_ENABLED ) then return end
	if (IsValid(self.Window)) then
		self.Window:Remove()
	end
	local frame = vgui.Create("DFrame")
	Studio:Setup( frame )
end

function Studio:Setup( frame )
	if ( not PHOTON2_STUDIO_ENABLED ) then frame:Remove() return end
	frame:SetSize( 388, 512 )
	frame:SetPos( ScrW() - 450, 100 )
	frame:SetSkin("PhotonStudio")
	frame:SetIcon("photon/ui/studio_icon_16.png")

	-- frame:MakePopup()
	frame:SetSizable(true)
	frame:SetTitle("Photon 2 Studio")


	local lp, tp, rp, bp = frame:GetDockPadding()
	frame:DockPadding(1, tp - 5, 1, 1)
	local menubar = vgui.Create( "EXDMenuBar", frame )
	menubar:SetSkin(frame:GetSkin().ID)
	menubar:Dock(TOP)
	
	local fileMenu = menubar:AddMenu("File")
	fileMenu:AddOption("Close", function()
		frame:Remove()
	end)
	fileMenu:AddOption("Reload Window", function()
		timer.Simple(0.1, function()
			if IsValid( Sudio.Window ) then
				Studio.Window:Remove()
			end
			Studio:Initialize()
		end)
	end)

	local viewMenu = menubar:AddMenu("View")
	viewMenu:AddOption("Default", function()
		frame:Remove()
	end)

	local studioMenu = menubar:AddMenu("Debug")
	fileMenu:AddOption("Default", function()
		frame:Remove()
	end)

	self.Window = frame
end

local reloadStudioOnSave = true

if (reloadStudioOnSave) then
	if (IsValid( Studio.Window )) then
		Studio.Window:Remove()
		Studio:Initialize()
	end
end

if ( PHOTON2_STUDIO_ENABLED ) then
	-- PHOTON2_CL_CVAR_SRCBLEND = CreateClientConVar( "ph2_render_blend_srcblend", "0", true, false, "Source Blend Mode", 0, 10 )
	-- PHOTON2_CL_CVAR_DSTBLEND = CreateClientConVar( "ph2_render_blend_dstblend", "0", true, false, "Destination Blend Mode", 0, 10 )
	-- PHOTON2_CL_CVAR_BLENDFUNC = CreateClientConVar( "ph2_render_blend_blendfunc", "0", true, false, "Blend Function", 0, 4 )
	-- PHOTON2_CL_CVAR_SRCBLENDA = CreateClientConVar( "ph2_render_blend_srcblendalpha", "0", true, false, "Source Blend Mode", 0, 10 )
	-- PHOTON2_CL_CVAR_DSTBLENDA = CreateClientConVar( "ph2_render_blend_dstblendalpha", "0", true, false, "Destination Blend Mode", 0, 10 )
	-- PHOTON2_CL_CVAR_ABLENDFUNC = CreateClientConVar( "ph2_render_blend_blendfuncalpha", "0", true, false, "Blend Function", 0, 4 )

	-- local blendFunctions = {
	-- 	{ "BLENDFUNC_ADD" 				, 0 },
	-- 	{ "BLENDFUNC_SUBTRACT" 			, 1 },
	-- 	{ "BLENDFUNC_REVERSE_SUBTRACT" 	, 2 },
	-- 	{ "BLENDFUNC_MIN" 				, 3 },
	-- 	{ "BLENDFUNC_MAX" 				, 4 }
	-- }

	-- local blendOptions = {
	-- 	{ "BLEND_ZERO", 				0 },
	-- 	{ "BLEND_ONE",					1 },
	-- 	{ "BLEND_DST_COLOR",			2 },
	-- 	{ "BLEND_ONE_MINUS_DST_COLOR",	3 },
	-- 	{ "BLEND_SRC_ALPHA",				4 },
	-- 	{ "BLEND_ONE_MINUS_SRC_ALPHA",	5 },
	-- 	{ "BLEND_DST_ALPHA",			6 },
	-- 	{ "BLEND_ONE_MINUS_DST_ALPHA",	7 },
	-- 	{ "BLEND_SRC_ALPHA_SATURATE",	8 },
	-- 	{ "BLEND_SRC_COLOR",			9 },
	-- 	{ "BLEND_ONE_MINUS_SRC_COLOR",	10 }
	-- }

	-- local blendControllerOptions = {
	-- 	{ "Source Blend", "ph2_render_blend_srcblend", blendOptions },
	-- 	{ "Destination Blend", "ph2_render_blend_dstblend", blendOptions },
	-- 	{ "Blend Function", "ph2_render_blend_blendfunc", blendFunctions },
	-- 	{ "Source Blend Alpha", "ph2_render_blend_srcblendalpha", blendOptions },
	-- 	{ "Destination Blend Alpha", "ph2_render_blend_dstblendalpha", blendOptions },
	-- 	{ "Alpha Blend Function", "ph2_render_blend_blendfuncalpha", blendFunctions },
	-- }

	-- ---@param panel DForm
	-- function Photon2.UI.BuildBlendingController( panel )
	-- 	panel:Clear()
	-- 	for _, option in pairs( blendControllerOptions ) do
	-- 		local combobox, label = panel:ComboBox( option[1], option[2] )
	-- 		combobox:GetParent():SetHeight( 32 )
	-- 		for __, innerOption in pairs( option[3] ) do
	-- 			combobox:AddChoice( innerOption[1], innerOption[2] )
	-- 		end
	-- 		local wang, nlabel = panel:NumSlider( "", option[2], 0, #option[3]-1, 0 )
	-- 	end
	-- end

	-- function Photon2.UI.GetBlendingConfiguration()
	-- 	return PHOTON2_CL_CVAR_SRCBLEND:GetInt(),
	-- 		PHOTON2_CL_CVAR_DSTBLEND:GetInt(),
	-- 		PHOTON2_CL_CVAR_BLENDFUNC:GetInt(),
	-- 		PHOTON2_CL_CVAR_SRCBLENDA:GetInt(),
	-- 		PHOTON2_CL_CVAR_DSTBLENDA:GetInt(),
	-- 		PHOTON2_CL_CVAR_ABLENDFUNC:GetInt()
	-- end

	-- hook.Add( "PopulateToolMenu", "Photon2:ToolMenu", function() 
	-- 	spawnmenu.AddToolMenuOption( "Utilities", "Photon 2", "photon2_utilities_blendining", "Blending Options", "", "", Photon2.UI.BuildBlendingController )
	-- end )
end
PHOTON2_CL_CVAR_F3CURSORTOGGLE = CreateClientConVar( "ph2_f3cursor_enable", "0", true, false, "Toggle cursor with F3", 0, 1 )

function Photon2.UI.ToggleCursorRelease()
	if ( Photon2.UI.CursorReleased ) then RememberCursorPosition() end
	Photon2.UI.CursorReleased = !Photon2.UI.CursorReleased
	gui.EnableScreenClicker( Photon2.UI.CursorReleased )
	if ( Photon2.UI.CursorReleased ) then RestoreCursorPosition() end
end

hook.Add( "PlayerBindPress", "Photon2.UI:F3CursorRelease", function( ply, bind, press )
	if ( PHOTON2_CL_CVAR_F3CURSORTOGGLE:GetBool() ) then
		if ( string.find( bind, "gm_showspare1" ) ) then
			Photon2.UI.ToggleCursorRelease()
		end
	end
end)