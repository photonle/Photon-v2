Photon2.UI = Photon2.UI or {
	CursorReleased = false,
	HUD = {}
}

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
		

		local openStudioOption = menu:AddOption("Open Studio", function()
			Photon2.Studio:Initialize()
		end)

		local debugOption = menu:AddOption( "Debug" )
		local debugMenu = debugOption:AddSubMenu()
		debugMenu:SetDeleteSelf( false )

		debugMenu:AddOption( "Open Channel Controller", function() 
			local form = vgui.Create( "Photon2ChannelController" )
		end)

		debugMenu:AddOption( "Print Profiles to Console", function()
			PrintTable( Photon2.Index.Profiles )
		end)
		debugMenu:AddOption( "Print Vehicle Index to Console", function()
			PrintTable( Photon2.Index.Vehicles )
		end)
		debugMenu:AddOption( "Reload Components", function()
			Photon2.LoadComponentLibrary()
		end)
		debugMenu:AddOption( "Reload Vehicles", function()
			Photon2.LoadVehicleLibrary()
		end)
		local printOption = debugMenu:AddOption( "Print to Console" )
		local printMenu = printOption:AddSubMenu()
		printMenu:SetDeleteSelf( false )
		for id, entry in pairs( Photon2.Index.Components ) do
			printMenu:AddOption( id, function()
				PrintTable( Photon2.Index.Components[id] )
			end)
		end

		local light2dDebugOption = debugMenu:AddCVar("Display Light Overlay", "ph2_debug_light_overlay", "1", "0")
		local drawLight2d = debugMenu:AddCVar( "Draw 2D Lighting", "ph2_draw_light2d", "1", "0" )		

		menu:AddOption( "Refresh Menubar", function()
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



--[[
	Sandbox Properties Context Menu 
--]]

properties.Add("photon2_equipment", {
	MenuLabel = "Equipment",
	Order = 60,
	Filter = function(self, ent, ply)
		if (not IsValid( ent:GetPhotonController() )) then
			return false
		end
		return true
	end,
	---@param ent PhotonController
	MenuOpen = function(self, option, ent)
		local controller = ent:GetPhotonController()
		local currentSelections = controller.CurrentSelections
		local selections = controller:GetProfile().Selections
		-- Required so child elements can be applied
		local subMenu = option:AddSubMenu()
		for i, category in ipairs( selections ) do
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
	end
})

--[[
		Desktop Windows
--]]
list.Set("DesktopWindows", "Photon2", {
	title = "Photon 2",
	icon = "photon/ui/photon_2_icon_64.png",
	init = function( icon, window )
		Photon2.Studio:Setup( window )
	end
})

list.Set("DesktopWindows", "PhotonStudio", {
	title = "Photon Studio",
	icon = "photon/ui/photon_studio_icon_64.png",
	init = function( icon, window )
		Photon2.Studio:Setup( window )
	end
})

--[[
		Photon Studio Window
--]]

Photon2.Studio = Photon2.Studio or {}

local Studio = Photon2.Studio
function Studio:Initialize()
	if (IsValid(self.Window)) then
		self.Window:Remove()
	end
	local frame = vgui.Create("DFrame")
	Studio:Setup( frame )
end

function Studio:Setup( frame )
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

PHOTON2_CL_CVAR_SRCBLEND = CreateClientConVar( "ph2_render_blend_srcblend", "0", true, false, "Source Blend Mode", 0, 10 )
PHOTON2_CL_CVAR_DSTBLEND = CreateClientConVar( "ph2_render_blend_dstblend", "0", true, false, "Destination Blend Mode", 0, 10 )
PHOTON2_CL_CVAR_BLENDFUNC = CreateClientConVar( "ph2_render_blend_blendfunc", "0", true, false, "Blend Function", 0, 4 )
PHOTON2_CL_CVAR_SRCBLENDA = CreateClientConVar( "ph2_render_blend_srcblendalpha", "0", true, false, "Source Blend Mode", 0, 10 )
PHOTON2_CL_CVAR_DSTBLENDA = CreateClientConVar( "ph2_render_blend_dstblendalpha", "0", true, false, "Destination Blend Mode", 0, 10 )
PHOTON2_CL_CVAR_ABLENDFUNC = CreateClientConVar( "ph2_render_blend_blendfuncalpha", "0", true, false, "Blend Function", 0, 4 )

local blendFunctions = {
	{ "BLENDFUNC_ADD" 				, 0 },
	{ "BLENDFUNC_SUBTRACT" 			, 1 },
	{ "BLENDFUNC_REVERSE_SUBTRACT" 	, 2 },
	{ "BLENDFUNC_MIN" 				, 3 },
	{ "BLENDFUNC_MAX" 				, 4 }
}

local blendOptions = {
	{ "BLEND_ZERO", 				0 },
	{ "BLEND_ONE",					1 },
	{ "BLEND_DST_COLOR",			2 },
	{ "BLEND_ONE_MINUS_DST_COLOR",	3 },
	{ "BLEND_SRC_ALPHA",				4 },
	{ "BLEND_ONE_MINUS_SRC_ALPHA",	5 },
	{ "BLEND_DST_ALPHA",			6 },
	{ "BLEND_ONE_MINUS_DST_ALPHA",	7 },
	{ "BLEND_SRC_ALPHA_SATURATE",	8 },
	{ "BLEND_SRC_COLOR",			9 },
	{ "BLEND_ONE_MINUS_SRC_COLOR",	10 }
}

local blendControllerOptions = {
	{ "Source Blend", "ph2_render_blend_srcblend", blendOptions },
	{ "Destination Blend", "ph2_render_blend_dstblend", blendOptions },
	{ "Blend Function", "ph2_render_blend_blendfunc", blendFunctions },
	{ "Source Blend Alpha", "ph2_render_blend_srcblendalpha", blendOptions },
	{ "Destination Blend Alpha", "ph2_render_blend_dstblendalpha", blendOptions },
	{ "Alpha Blend Function", "ph2_render_blend_blendfuncalpha", blendFunctions },
}

---@param panel DForm
function Photon2.UI.BuildBlendingController( panel )
	panel:Clear()
	for _, option in pairs( blendControllerOptions ) do
		local combobox, label = panel:ComboBox( option[1], option[2] )
		combobox:GetParent():SetHeight( 32 )
		for __, innerOption in pairs( option[3] ) do
			combobox:AddChoice( innerOption[1], innerOption[2] )
		end
		local wang, nlabel = panel:NumSlider( "", option[2], 0, #option[3]-1, 0 )
	end
end

function Photon2.UI.GetBlendingConfiguration()
	return PHOTON2_CL_CVAR_SRCBLEND:GetInt(),
		PHOTON2_CL_CVAR_DSTBLEND:GetInt(),
		PHOTON2_CL_CVAR_BLENDFUNC:GetInt(),
		PHOTON2_CL_CVAR_SRCBLENDA:GetInt(),
		PHOTON2_CL_CVAR_DSTBLENDA:GetInt(),
		PHOTON2_CL_CVAR_ABLENDFUNC:GetInt()
end

hook.Add( "PopulateToolMenu", "Photon2:ToolMenu", function() 
	spawnmenu.AddToolMenuOption( "Utilities", "Photon 2", "photon2_utilities_blendining", "Blending Options", "", "", Photon2.UI.BuildBlendingController )
end )

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

local hudMaterial = Material("photon/ui/hud")

local hudRT = GetRenderTargetEx( "Photon2HUD" .. CurTime(), 512, 512, 
0, MATERIAL_RT_DEPTH_NONE, 32768 + 2048 + 4 + 8 + 1, 0, IMAGE_FORMAT_RGBA8888 )

local hudRT2 = GetRenderTarget( "Photon2HUD", 512, 512 )

local hudMaterial2 = Material("photon/ui/hud.png")
-- local hudRTId = 
local illumRearOff = Material("photon/ui/hud_icon_illum_rear_off.png")
local illumLeftOff = Material("photon/ui/hud_icon_illum_left_off.png")
local illumRightOff = Material("photon/ui/hud_icon_illum_right_off.png")
local illumFrontOff = Material("photon/ui/hud_icon_illum_front_off.png")
local illumRearOn = Material("photon/ui/hud_icon_illum_rear_on.png")
local illumLeftOn = Material("photon/ui/hud_icon_illum_left_on.png")
local illumRightOn = Material("photon/ui/hud_icon_illum_right_on.png")
local illumFrontOn = Material("photon/ui/hud_icon_illum_front_on.png")
local illumFlood = Material("photon/ui/hud_icon_illum_flood.png")

local vehicleIcon = Material("photon/ui/hud_veh_icon.png")

local wailIcon = Material("photon/ui/hud_icon_wail.png")
local yelpIcon = Material("photon/ui/hud_icon_yelp.png")
local hiloIcon = Material("photon/ui/hud_icon_hilo.png")
local pcallIcon = Material("photon/ui/hud_icon_pcall.png")
local toneIcon = Material("photon/ui/hud_icon_tone.png")
local boltIcon = Material("photon/ui/hud_icon_bolt.png")
local speakerIcon = Material("photon/ui/hud_icon_speaker.png")
local hornIcon = Material("photon/ui/hud_icon_horn.png")
local manualIcon = Material("photon/ui/hud_icon_manual.png")

local lastUpdate = 0

local cornerRadius = 4

surface.CreateFont( "Photon2.UI:Medium", {
	font = "Roboto Bold",
	size = 14,
	weight = 700
} );

surface.CreateFont( "Photon2.UI:Small", {
	font = "Roboto Bold",
	size = 12,
	weight = 100
} );

surface.CreateFont( "Photon2.UI:ExtraSmall", {
	font = "Roboto Bold",
	size = 10,
	weight = 100
} );

local icons = {
	wail = Material("photon/ui/hud_icon_wail.png"),
	yelp =  Material("photon/ui/hud_icon_yelp.png"),
	hilo =  Material("photon/ui/hud_icon_hilo.png"),
	pcall =  Material("photon/ui/hud_icon_pcall.png"),
	tone =  Material("photon/ui/hud_icon_tone.png"),
	bolt =  Material("photon/ui/hud_icon_bolt.png"),
	speaker =  Material("photon/ui/hud_icon_speaker.png"),
	horn =  Material("photon/ui/hud_icon_horn.png"),
	manual =  Material("photon/ui/hud_icon_manual.png"),
	siren =  Material("photon/ui/hud_icon_siren.png"),
}


local smartSirenIndicator = {
	Channel = "Emergency.Siren",
	Markers = { "T1", "T2", "T3", "T4" },
	MarkerMap= { ["T1"] = 1, ["T2"] = 2, ["T3"] = 3, ["T4"] = 4 },
	Map = {
		["T1"] = { Label = "WAIL", Icon = "wail" },
		["T2"] = { Label = "YELP", Icon = "yelp" },
		["T3"] = { Label = "PRTY", Icon = "bolt" },
		["T4"] = { Label = "HILO", Icon = "hilo" },
		["AIR"] = { Label = "AIR", Icon = "horn" },
		["MAN"] = { Label = "MAN", Icon = "manual" },
		["OFF"] = { Label = "STBY", Icon = "siren"}
	}
}

local ellipseActive = Material("photon/ui/hud_ellipse_active.png")
local ellipseInactive = Material("photon/ui/hud_ellipse_inactive.png")

local white = Color( 255, 255, 255 )

local dimColor = Color( 255, 255, 255, 96 )
local inactiveColor = Color( 0, 0, 0, 128 )

local HUD = Photon2.UI.HUD

local stageIndicators = {
	[1] = { 48, 0 },
	[2] = { 21, 6 },
	[3] = { 12, 6 },
	[4] = { 8, 5 },
	[5] = { 7, 3 },
}

function HUD.LightsIndicator( x, y, width, height, gap, count )
	for i=1, count do
		draw.RoundedBox( 0, x + ( ( i - 1 ) * ( width + gap ) ), y, width, height, inactiveColor )
	end
end

function HUD.LightStageIndicator( x, y, width, priLabel, priCount, priSelected, secLabel, secCount, secSelected )
	draw.RoundedBox( cornerRadius, x, y, width, 64, Color( 64, 64, 64, 200 ) )
	draw.DrawText( priLabel, "Photon2.UI:Medium", x + 40, y + 8, white )
	draw.DrawText( secLabel, "Photon2.UI:Medium", x + 40, y + 42, white )

	local stageDimensions = stageIndicators[priCount]
	local drawColor = white
	for i=1, priCount do
		if ( i <= priSelected ) then
			drawColor = white
		else
			drawColor = inactiveColor
		end
		draw.RoundedBox( 2, x + 8, y + 8 + ( ( i - 1 ) * ( stageDimensions[1] + stageDimensions[2] ) ), 26, stageDimensions[1], drawColor )
	end

	HUD.LightsIndicator( x + 40, y + 31, 11, 2, 2, 8 )

	surface.SetMaterial( ellipseInactive )
	surface.SetDrawColor( dimColor )

	secSelected = ( secCount + 1 ) - secSelected

	for i=1, secCount do
		if ( i == secSelected ) then
			surface.SetMaterial( ellipseActive )
			surface.SetDrawColor( white )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( i - 1 ) * 12 ), y + 46, 8, 8 )

		if ( i == secSelected ) then
			surface.SetMaterial( ellipseInactive)
			surface.SetDrawColor( dimColor )
		end
	end
end

---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param columns integer
---@param columnWidth integer
---@param functions table<table<string, boolean>>
function HUD.FunctionsIndicator( x, y, width, height, columns, columnWidth, functions )
	
	draw.RoundedBox( cornerRadius, x, y, width, height, Color( 64, 64, 64, 200 ) )
	
	local row = 1
	local column = 1

	surface.SetDrawColor( 255, 255, 255, 255 )
	local textColor = white	
	for i=1, #functions do
		
		if ( functions[i][2] ) then
			surface.SetMaterial( ellipseActive )
			surface.SetDrawColor( white )
			textColor = white
		else
			surface.SetMaterial( ellipseInactive )
			surface.SetDrawColor( dimColor )
			textColor = dimColor
		end

		surface.DrawTexturedRect(
			x + 8 + ( ( column - 1 ) * columnWidth ),
			y + 11 + ( ( row - 1 ) * 18 ),
			8,
			8
		)

		draw.DrawText( 
			functions[i][1], 
			"Photon2.UI:Small",
			x + 20 + ( ( column - 1 ) * columnWidth ),
			y + 9 + ( ( row - 1 ) * 18 ),
			textColor
		)

		column = column + 1
		if ( column > columns ) then
			row = row + 1
			column = 1
		end

	end

end

---@param x integer
---@param y integer
---@param icon IMaterial
---@param frontOn boolean
---@param floodOn boolean
---@param rightOn boolean
---@param backOn boolean
---@param leftOn boolean
function HUD.SceneLightingIndicator( x, y, icon, frontOn, floodOn, rightOn, backOn, leftOn )
	draw.RoundedBox( cornerRadius, x, y, 52, 48, Color( 64, 64, 64, 200 ) )
	
	local drawAsActive = false
	
	if ( frontOn or floodOn ) then
		drawAsActive = true
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( illumFrontOn )
	else
		surface.SetDrawColor( 0, 0, 0, 128 )
		surface.SetMaterial( illumFrontOff )
	end
	surface.DrawTexturedRect( x - 4, y - 4, 56, 30 )

	if ( floodOn ) then
		drawAsActive = true
		surface.SetDrawColor( 255, 255, 255, 255 )
	else
		surface.SetDrawColor( 0, 0, 0, 128 )
	end
	surface.SetMaterial( illumFlood )
	surface.DrawTexturedRect( x - 4, y - 4, 56, 30 )

	if ( rightOn ) then
		drawAsActive = true
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( illumRightOn )
	else
		surface.SetDrawColor( 0, 0, 0, 128 )
		surface.SetMaterial( illumRightOff )
	end
	surface.DrawTexturedRect( x + 27, y - 3, 25, 52 )

	if ( backOn ) then
		drawAsActive = true
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( illumRearOn )
	else
		surface.SetDrawColor( 0, 0, 0, 128 )
		surface.SetMaterial( illumRearOff )
	end
	surface.DrawTexturedRect( x - 4, y + 28, 56, 21 )

	if ( leftOn ) then
		drawAsActive = true
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( illumLeftOn )
	else
		surface.SetDrawColor( 0, 0, 0, 128 )
		surface.SetMaterial( illumLeftOff )
	end
	surface.DrawTexturedRect( x-5, y - 3, 30, 52 )

	surface.SetMaterial( icon )
	if ( drawAsActive ) then
		surface.SetDrawColor( 255, 255, 255, 255 )
	else
		surface.SetDrawColor( 255, 255, 255, 64 )
	end
	surface.DrawTexturedRect( x + 20, y + 21, 12, 12 )
end

---@param x integer
---@param y integer
---@param width integer
---@param icon IMaterial
---@param label string
---@param count integer
---@param selected integer
function HUD.DiscreteIndicator( x, y, width, icon, label, count, selected )
	draw.RoundedBox( cornerRadius, x, y, width, 32, Color( 16, 16, 16, 200 ) )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( icon )
	surface.DrawTexturedRect( x + 9, y + 4, 24, 24 )

	draw.DrawText( label, "Photon2.UI:Medium", x + 40, y + 9, white )

	surface.SetMaterial( ellipseInactive )

	selected = ( count + 1 ) - selected

	surface.SetDrawColor( dimColor )

	for i=1, count do
		if ( i == selected ) then
			surface.SetMaterial( ellipseActive )
			surface.SetDrawColor( white )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( i - 1 ) * 12 ), y + 12, 8, 8 )

		if ( i == selected ) then
			surface.SetMaterial( ellipseInactive)
			surface.SetDrawColor( dimColor )
		end
	end

end



local drawIcon = icons["siren"]

hook.Add( "HUDPaint", "Photon2:RenderHudRT", function()
	-- if true then return end
	local target = Photon2.ClientInput.TargetController

	if ( not target ) then return end

	hudMaterial:SetTexture( "$basetexture", hudRT )
	if ( CurTime() >= (lastUpdate + 0.1) ) then
		render.PushRenderTarget( hudRT )
		-- needs to be scaled down by 16px for some unknown reason
		render.SetViewPort( 8, 8, 512 - 16, 512 - 16 )
		cam.Start2D()
			render.OverrideAlphaWriteEnable( true, true)
			render.Clear( 0, 0, 0, 0, false, false )

			HUD.LightStageIndicator( ScrW() - 150 - 4, 256, 150, "MODE 1", 3, 1, "LEFT", 3, 1 )


			-- Siren 1 Indicator
			local sirenDisplay, sirenSelection
			if ( target.CurrentModes["Emergency.SirenOverride"] ~= "OFF" ) then
				sirenDisplay = smartSirenIndicator.Map[target.CurrentModes["Emergency.SirenOverride"]]
				sirenSelection = -1
			else
				sirenDisplay = smartSirenIndicator.Map[target.CurrentModes["Emergency.Siren"]]
				sirenSelection = smartSirenIndicator.MarkerMap[target.CurrentModes["Emergency.Siren"]] or -1
			end
			HUD.DiscreteIndicator( ScrW() - 150 - 4, 322, 150, icons[sirenDisplay.Icon], sirenDisplay.Label, #smartSirenIndicator.Markers, sirenSelection )


			HUD.FunctionsIndicator( ScrW() - 150 - 4, 356, 96, 48, 2, 44, {
				{ "AUX", false },
				{ "CUT", false },
				{ "MRK", true },
				{ "BLK", false }
			} )

			HUD.SceneLightingIndicator( ScrW() - 150 - 4 + 98, 356, vehicleIcon, 
			false, false, false, false, false )

			draw.DrawText( "v2.0.0 (PREVIEW)", "Photon2.UI:ExtraSmall", ScrW() - 4, 406, white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "DO NOT REDISTRIBUTE", "Photon2.UI:ExtraSmall", ScrW() - 4, 418, white, TEXT_ALIGN_RIGHT )

		cam.End2D()
		render.PopRenderTarget()
		lastUpdate = CurTime()
	end
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(hudMaterial)
	surface.DrawTexturedRect(ScrW() - 528, ScrH() - 516, 496, 496)
end)