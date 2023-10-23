Photon2.UI = Photon2.UI or {
	CursorReleased = false
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

local hudRT = GetRenderTargetEx( "Photon2:HUD" .. CurTime(), 512, 512, 
RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, 32768 + 2048 + 1, 4, IMAGE_FORMAT_RGBA8888 )

local hudMaterial2 = Material("photon/ui/hud.png")
-- local hudRTId = 
local lastUpdate = 0

local function drawPhoton2Hud()

end

hook.Add( "HUDPaint", "Photon2:RenderHudRT", function()
	if true then return end
	hudMaterial:SetTexture( "$basetexture", hudRT )
	if ( CurTime() >= (lastUpdate + 1) ) then
		-- render.PushRenderTarget( hudMaterial2:GetTexture("$basetexture") )
		render.PushRenderTarget( hudRT )
			render.OverrideAlphaWriteEnable( true, true)
			render.Clear( 0, 255, 0, 128, false, false )
			surface.SetDrawColor( 0, 255, 0, 255 )
			surface.DrawRect( 64, 64, 512, 512 )
		render.PopRenderTarget()
		lastUpdate = CurTime()
	end
	-- local texId = surface.GetTextureID(hudRT:GetName())
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(hudMaterial)
	-- surface.SetTexture()
	surface.DrawTexturedRect(0,  0, 512, 512)
end)