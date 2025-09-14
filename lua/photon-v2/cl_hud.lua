
Photon2.HUD = Photon2.HUD or {
	ToneIcons = {
		wail = Material("photon/ui/hud_icon_wail.png"),
		yelp =  Material("photon/ui/hud_icon_yelp.png"),
		hilo =  Material("photon/ui/hud_icon_hilo.png"),
		pcall =  Material("photon/ui/hud_icon_pcall.png"),
		tone =  Material("photon/ui/hud_icon_tone.png"),
		bolt =  Material("photon/ui/hud_icon_bolt.png"),
		speaker =  Material("photon/ui/hud_icon_speaker.png"),
		airhorn =  Material("photon/ui/hud_icon_horn.png"),
		manual =  Material("photon/ui/hud_icon_manual.png"),
		siren =  Material("photon/ui/hud_icon_siren.png"),
	},
	IlluminationIcons = {
		RearOff = Material("photon/ui/hud_icon_illum_rear_off.png"),
		LeftOff = Material("photon/ui/hud_icon_illum_left_off.png"),
		RightOff = Material("photon/ui/hud_icon_illum_right_off.png"),
		FrontOff = Material("photon/ui/hud_icon_illum_front_off.png"),
		RearOn = Material("photon/ui/hud_icon_illum_rear_on.png"),
		LeftOn = Material("photon/ui/hud_icon_illum_left_on.png"),
		RightOn = Material("photon/ui/hud_icon_illum_right_on.png"),
		FrontOn = Material("photon/ui/hud_icon_illum_front_on.png"),
		Flood = Material("photon/ui/hud_icon_illum_flood.png"),
	},
	VehicleIcon = Material("photon/ui/hud_veh_icon.png"),
	SignalIcons = {
		Left = Material("photon/ui/hud_icon_left.png"),
		Right = Material("photon/ui/hud_icon_right.png"),
		Headlights = Material("photon/ui/hud_icon_hlights.png"),
		HeadlightsAuto = Material("photon/ui/hud_icon_alights.png"),
		ParkingLights = Material("photon/ui/hud_icon_plights.png"),
	},
	IndicatorIcons = {
		Active = Material("photon/ui/hud_ellipse_active.png"),
		Inactive = Material("photon/ui/hud_ellipse_inactive.png"),
	},
	StartTime = 0
}

local HUD = Photon2.HUD

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local info, warn, warnOnce = Photon2.Debug.Declare( "HUD" )

--[[
		INITIALIZE HUD RENDER TARGET
--]]

-- Important to note that Photon 2 draws its HUD to a dedicated render target
-- so it's refreshed at a slower rate than the client framerate for better efficiency.
local hudMaterial = Material("photon/ui/hud")

local hudRT = GetRenderTargetEx( "Photon2HUD" .. CurTime(), 512, 512, 
0, MATERIAL_RT_DEPTH_NONE, 32768 + 4 + 8 + 512, 0, IMAGE_FORMAT_RGBA8888 )


--[[
		LOCAL UTILITY FUNCTIONS
--]]

local function stringToColor( str )
	local r, g, b, a = string.match( str, "(%d+),(%d+),(%d+),(%d+)" )
	return Color( 
		tonumber( r ) or 255,
		tonumber( g ) or 255,
		tonumber( b ) or 255,
		tonumber( a ) or 255
	)
end

local function truncateString( str, maxLength )
	if #str > maxLength then
		return string.sub(str, 1, maxLength - 3) .. "..."
	else
		return str
	end
end

--[[
		DEBUG/DEVELOPMENT FUNCTIONS
--]]

-- Utility function that draws a fixed box. I made it so 
-- I could capture screenshots/recordings with the same
-- perspective and dimensions for the Wiki.
function HUD.DrawTargetBox( w, h )
	local centerX = ScrW() / 2
	local centerY = ScrH() / 2

	-- surface.SetDrawColor( 255, 255, 255, 255 )
	draw.RoundedBox( 0, centerX - (w/2), centerY - (h/2), w, 1, Color( 255, 255, 255 ) )
	draw.RoundedBox( 0, centerX - (w/2), centerY - (h/2), 1, h, Color( 255, 255, 255 ) )
	draw.RoundedBox( 0, centerX - (w/2), centerY + (h/2), w, 1, Color( 255, 255, 255 ) )
	draw.RoundedBox( 0, centerX + (w/2), centerY - (h/2), 1, h, Color( 255, 255, 255 ) )
end

-- hook.Add( "PostDrawHUD", "Photon2.TargetBox", function() 
	-- HUD.DrawTargetBox( 400, 128 )
-- end)

--[[
		SETUP USER SETTINGS
--]]
	
local userSettings = {}

local optionConVars = {
	Enabled = { "ph2_hud_enabled", "Bool" },
	Anchor = { "ph2_hud_anchor", "String" },
	OffsetX = { "ph2_hud_offset_x", "Int" },
	OffsetY = { "ph2_hud_offset_y", "Int" },
	PanelActiveColor = { "ph2_hud_color_panel_active", "String", stringToColor },
	BackgroundColor = { "ph2_hud_color_panel_inactive", "String", stringToColor },
	PanelAltActiveColor = { "ph2_hud_color_panel_alt_active", "String", stringToColor },
	PanelAltInactiveColor = { "ph2_hud_color_panel_alt_inactive", "String", stringToColor },
	HighlightColor = { "ph2_hud_color_accent", "String", stringToColor },
	AccentInactiveColor = { "ph2_hud_color_accent_inactive", "String", stringToColor },
	AccentAltColor = { "ph2_hud_color_accent_alt", "String", stringToColor },
}

for key, data in pairs( optionConVars ) do
	local cvar = GetConVar( data[1] )
	if ( not cvar ) then
		error( "Failed to find convar " .. data[1] )
		continue
	end
	local value = cvar["Get" .. data[2]]( cvar )
	if ( isfunction( data[3] ) ) then
		value = data[3]( value )
	end
	userSettings[key] = value

	cvars.RemoveChangeCallback( data[1], "Photon2.HUD" )
	cvars.AddChangeCallback( data[1], function( convar, oldValue, newValue )
		if ( isfunction( data[3] ) ) then
			newValue = data[3]( newValue )
			userSettings[key] = newValue
		else
			userSettings[key] = cvar["Get" .. data[2]]( cvar )
		end
		printf( "HUD setting changed: %s %s %s", convar, oldValue, newValue )
		-- userSettings[key] = cvar["Get" .. data[2]]( cvar )
	end, "Photon2.HUD")
end

local stateColors = {
	["OFF"] = function() return userSettings.AccentInactiveColor end,
	["ON"] = function() return userSettings.HighlightColor end
}

--[[
		SETUP LOCAL VARIABLES THAT REFERENCE HUD ICONS (for performance) ???
--]]

local iconIllumRearOff = HUD.IlluminationIcons.RearOff
local iconIllumLeftOff = HUD.IlluminationIcons.LeftOff
local iconIllumRightOff = HUD.IlluminationIcons.RightOff
local iconIllumFrontOff = HUD.IlluminationIcons.FrontOff
local iconIllumRearOn = HUD.IlluminationIcons.RearOn
local iconIllumLeftOn = HUD.IlluminationIcons.LeftOn
local iconIllumRightOn = HUD.IlluminationIcons.RightOn
local iconIllumFrontOn = HUD.IlluminationIcons.FrontOn
local iconIllumFlood = HUD.IlluminationIcons.Flood

local iconVehicle = HUD.VehicleIcon

local iconSignalLeft = HUD.SignalIcons.Left
local iconSignalRight = HUD.SignalIcons.Right
local iconHeadlights = HUD.SignalIcons.Headlights
local iconHeadlightsAuto = HUD.SignalIcons.HeadlightsAuto
local iconParkingLights = HUD.SignalIcons.ParkingLights

local toneIcons = HUD.ToneIcons
local iconIndicatorActive = HUD.IndicatorIcons.Active
local iconIndicatorInactive = HUD.IndicatorIcons.Inactive

local lastUpdate = 0

local cornerRadius = 4




local stageIndicators = {
	[1] = { 48, 0 },
	[2] = { 21, 6 },
	[3] = { 12, 6 },
	[4] = { 8, 5 },
	[5] = { 7, 3 },
}

local stageIndicatorsSmall = {
	[1] = { 24, 0, 0 },
	[2] = { 11, 2, 0 },
	[3] = { 7, 2, 0 },
	[4] = { 5, 2, -1 },
	[5] = { 4, 1, 0 },
}

function HUD.Activate()
	if ( IsValid( HUD.Panel ) ) then
		HUD.Panel:Remove()
	end
	local photon2Hud = vgui.Create( "Photon2HUD" ) --[[@as Photon2HUD]]
	photon2Hud:RestorePosition()
	HUD.Panel = photon2Hud
	hook.Run( "Photon2.HUD:Active" )
end

function HUD.Deactivate()
	if ( IsValid( HUD.Panel ) ) then
		HUD.Panel:Remove()
	end
	hook.Run( "Photon2.HUD:Inactive" )
end

function HUD.LightsIndicator( x, y, width, height, gap, elements )
	for i, element in pairs( elements ) do
		draw.RoundedBox( 0, x + ( ( i - 1 ) * ( width + gap ) ), y, width, height, stateColors[element.CurrentStateId]() )
	end
end

function HUD.LightStageIndicator( x, y, width, priLabel, priCount, priSelected, priStyle, secLabel, secCount, secSelected, secStyle, indicatorComponent )
	local priLabelColor = userSettings.HighlightColor
	local secLabelColor = userSettings.HighlightColor
	local secIndicatorColor = userSettings.AccentAltColor
	local bgColor = userSettings.PanelActiveColor

	if ( ( priStyle + secStyle ) < 1 ) then
		bgColor = userSettings.BackgroundColor
	end

	if ( priStyle == 0 ) then
		priLabelColor = userSettings.AccentAltColor
	end

	if ( secStyle == 0 ) then
		secLabelColor = userSettings.AccentAltColor
		secIndicatorColor = Color( 0, 0, 0, 128 )
	end

	draw.RoundedBox( cornerRadius, x, y, width, 64, bgColor )
	draw.DrawText( priLabel, "Photon2.UI:Medium", x + 40, y + 8, priLabelColor )
	draw.DrawText( secLabel, "Photon2.UI:Small", x + 40, y + 44, secLabelColor )

	

	local stageDimensions = stageIndicators[priCount]
	local drawColor = userSettings.HighlightColor
	for i=1, priCount do
		if ( i <= priSelected ) then
			drawColor = userSettings.HighlightColor
		else
			drawColor = userSettings.AccentInactiveColor
		end
		draw.RoundedBox( 2, x + 8, y + ( 8 ) + ( ( i - 1 ) * ( stageDimensions[1] + stageDimensions[2] ) ), 26, stageDimensions[1], drawColor )
	end

	if ( indicatorComponent ) then
		HUD.LightsIndicator( x + 40, y + 31, 11, 3, 2, indicatorComponent.Elements )
	end

	surface.SetMaterial( iconIndicatorInactive )
	surface.SetDrawColor( secIndicatorColor )

	secSelected = ( secCount + 1 ) - secSelected

	for i=1, secCount do
		if ( i == secSelected ) then
			surface.SetMaterial( iconIndicatorActive )
			surface.SetDrawColor( userSettings.HighlightColor )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( i - 1 ) * 12 ), y + 46, 8, 8 )

		if ( i == secSelected ) then
			surface.SetMaterial( iconIndicatorInactive)
			surface.SetDrawColor( secIndicatorColor )
		end
	end
end

function HUD.LightStageIndicatorSingle( x, y, width, label, count, selected, style )
	local labelColor = userSettings.HighlightColor
	local bgColor = userSettings.PanelActiveColor

	if ( style < 1 ) then
		bgColor = userSettings.BackgroundColor
		labelColor = userSettings.AccentAltColor
	end

	draw.RoundedBox( cornerRadius, x, y, width, 40, bgColor )
	draw.DrawText( label, "Photon2.UI:Medium", x + 40, y + 13, labelColor )

	local stageDimensions = stageIndicatorsSmall[count]

	local drawColor = userSettings.HighlightColor

	for i=1, count do
		if ( i <= selected ) then
			drawColor = userSettings.HighlightColor
		else
			drawColor = userSettings.AccentInactiveColor
		end
		draw.RoundedBox( 2, x + 8, y + ( 8  + stageDimensions[3] ) + ( ( i - 1 ) * ( stageDimensions[1] + stageDimensions[2] ) ), 26, stageDimensions[1], drawColor )
	end

end


---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param columns integer
---@param columnWidth integer
---@param functions table<table<string, boolean>>
function HUD.FunctionsIndicator( x, y, width, height, columns, functions )
	
	local columnWidth = ( width / columns ) - 4
	local isActive = false

	for i=1, #functions do
		if ( functions[i][2] > 0 ) then 
			isActive = true
			break
		end
	end

	if ( isActive ) then
		draw.RoundedBox( cornerRadius, x, y, width, height, userSettings.PanelActiveColor )
	else

		draw.RoundedBox( cornerRadius, x, y, width, height, userSettings.BackgroundColor )
	end
	
	local row = 1
	local column = 1

	surface.SetDrawColor( userSettings.HighlightColor )
	local textColor = userSettings.HighlightColor	
	for i=1, #functions do
		
		if ( functions[i][2] == 1 ) then
			surface.SetMaterial( iconIndicatorActive )
			surface.SetDrawColor( userSettings.HighlightColor )
			textColor = userSettings.HighlightColor
		else
			surface.SetMaterial( iconIndicatorInactive )
			surface.SetDrawColor( userSettings.AccentInactiveColor )
			textColor = userSettings.AccentAltColor
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

-- Draws vehicle name with current input profile below it.
function HUD.VehicleInfo( x, y, w, h, vehicleName, inputConfigName )
	local backgroundColor = userSettings.PanelActiveColor
	draw.RoundedBox( cornerRadius, x, y, w, h, backgroundColor )

	draw.DrawText( vehicleName, "Photon2.UI:Small", x + 8, y + 7, userSettings.HighlightColor )
	draw.DrawText( inputConfigName, "Photon2.UI:Small", x + 8, y + 20, userSettings.AccentAltColor )
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
	local isInactive = (not frontOn) and (not floodOn) and (not rightOn) and (not backOn) and (not leftOn)
	local backgroundColor = userSettings.PanelActiveColor
	
	if ( isInactive ) then
		backgroundColor = userSettings.BackgroundColor
	end

	draw.RoundedBox( cornerRadius, x, y, 52, 48, backgroundColor )
	
	local drawAsActive = false
	
	if ( frontOn or floodOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconIllumFrontOn )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconIllumFrontOff )
	end
	surface.DrawTexturedRect( x - 4, y - 4, 56, 30 )

	if ( floodOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
	end
	surface.SetMaterial( iconIllumFlood )
	surface.DrawTexturedRect( x - 4, y - 4, 56, 30 )

	if ( rightOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconIllumRightOn )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconIllumRightOff )
	end
	surface.DrawTexturedRect( x + 27, y - 3, 25, 52 )

	if ( backOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconIllumRearOn )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconIllumRearOff )
	end
	surface.DrawTexturedRect( x - 4, y + 28, 56, 21 )

	if ( leftOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconIllumLeftOn )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconIllumLeftOff )
	end
	surface.DrawTexturedRect( x-5, y - 3, 30, 52 )

	surface.SetMaterial( icon )
	if ( drawAsActive ) then
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentAltColor )
	end
	surface.DrawTexturedRect( x + 20, y + 21, 12, 12 )
end

---@param x integer
---@param y integer
---@param icon IMaterial
---@param lsignalOn boolean
---@param rsignalOn boolean
---@param hsignalOn boolean
---@param hlightsOn boolean
---@param alightsOn boolean
---@param plightsOn boolean
function HUD.StandardLightingIndicator( x, y, width, icon, sigSelected, sigStyle, signalComponent, lsignalOn, rsignalOn, hsignalOn, hlightsOn, alightsOn, plightsOn )
	local isInactive = (not lsignalOn) and (not rsignalOn) and (not hsignalOn) and (not hlightsOn) and (not alightsOn) and (not plightsOn)
	local backgroundColor = userSettings.PanelActiveColor
	--local backgroundColor = userSettings.BackgroundColor
	
	if ( isInactive ) then
		backgroundColor = userSettings.BackgroundColor
	end

	draw.RoundedBox( cornerRadius, x, y, width, 32, backgroundColor )
	
	local drawAsActive = false

	if ( lsignalOn && (sigSelected == 2) ) then
		drawAsActive = true
		
		--Photon2.Util.PrintTableProperties(signalComponent.Elements)
		--if ( (sigSelected == 2) && (sigStyle == 1) ) then
			--surface.SetDrawColor( userSettings.HighlightColor )
		--	surface.SetDrawColor( userSettings.HighlightColor )
			--stateColors[element.CurrentStateId]()
		--end
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
	end
	surface.SetMaterial( iconSignalLeft )
	surface.DrawTexturedRect( x + 4, y + 4, 24, 24 )

	if ( rsignalOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
	end
	surface.SetMaterial( iconSignalRight )
	surface.DrawTexturedRect( x + 122, y + 4, 24, 24 )

	if ( alightsOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconHeadlightsAuto )
	elseif ( hlightsOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconHeadlights )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconHeadlights )
	end
	surface.DrawTexturedRect( x + 43, y + 4, 24, 24 )
	
	-- For now I've displayed running lights separately as
	-- opposed to replacing the headlight and auto headlight icons.
	-- If more room is needed in the future this could free up a spot.
	if ( plightsOn or alightsOn or hlightsOn ) then
		drawAsActive = true
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
	end
	surface.SetMaterial( iconParkingLights )
	surface.DrawTexturedRect( x + 82, y + 4, 24, 24 )
	
end

function HUD.StandardLights( x, y, width, headlightsAuto, headlightsOn, parkingOn )
	local backgroundColor = userSettings.PanelActiveColor
	
	-- if ( isInactive ) then
	-- 	backgroundColor = userSettings.BackgroundColor
	-- end

	draw.RoundedBox( cornerRadius, x, y, width, 32, backgroundColor )
	
	
	surface.SetDrawColor( userSettings.HighlightColor )
	surface.SetMaterial( iconSignalLeft )
	surface.DrawTexturedRect( x + 4, y + 4, 24, 24 )

	surface.SetDrawColor( userSettings.HighlightColor )
	surface.SetMaterial( iconSignalRight )
	surface.DrawTexturedRect( x + 122, y + 4, 24, 24 )


	if ( headlightsAuto ) then
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconHeadlightsAuto )
	elseif ( headlightsOn ) then
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetMaterial( iconHeadlights )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
		surface.SetMaterial( iconHeadlights )
	end
	surface.DrawTexturedRect( x + 43, y + 4, 24, 24 )
	
	-- For now I've displayed running lights separately as
	-- opposed to replacing the headlight and auto headlight icons.
	-- If more room is needed in the future this could free up a spot.
	if ( parkingOn ) then
		surface.SetDrawColor( userSettings.HighlightColor )
	else
		surface.SetDrawColor( userSettings.AccentInactiveColor )
	end
	surface.SetMaterial( iconParkingLights )
	surface.DrawTexturedRect( x + 82, y + 4, 24, 24 )
end

function HUD.KeyBindHint( x, y, keys )
	local key
	local keyPadding = 7
	for i=1, #keys do
		key = keys[i]
		surface.SetFont( "Photon2.UI:MediumSmall" )
		local w = surface.GetTextSize( key[1] )
		draw.RoundedBox( 4, x + 14 - w - keyPadding, y, w + (keyPadding * 2), 20, userSettings.PanelActiveColor )
		surface.SetDrawColor( userSettings.HighlightColor )
		surface.SetTextPos( x + 14 - w, y + 4)
		surface.DrawText( key[1] )
		surface.SetTextPos( x + 28, y + 4 )
		surface.DrawText( key[2] )
		y = y + 22
	end
	
end

---@param x integer
---@param y integer
---@param width integer
---@param icon IMaterial
---@param label string
---@param count integer
---@param selected integer
---@param mode integer 0=Off, 1=On, 2=Override
function HUD.DiscreteIndicator( x, y, width, icon, label, count, selected, mode )
	local activeIcon = iconIndicatorActive
	local inactiveIcon = iconIndicatorInactive
	local labelColor = userSettings.HighlightColor
	local iconColor = userSettings.HighlightColor
	local indicatorColor = userSettings.AccentAltColor
	local backgroundColor =  userSettings.PanelAltActiveColor
	local rowMax = 5
	local rows = math.ceil( count / rowMax )
	local selectedIndicator = ( count + 1 ) - selected

	if ( mode == 2 ) then
		activeIcon = iconIndicatorInactive
		inactiveIcon = iconIndicatorActive
		indicatorColor = userSettings.HighlightColor
	elseif ( mode == 0 ) then
		labelColor = userSettings.AccentAltColor
		iconColor = userSettings.AccentInactiveColor
		indicatorColor = userSettings.AccentInactiveColor
		backgroundColor =  userSettings.PanelAltInactiveColor
	end

	draw.RoundedBox( cornerRadius, x, y, width, 32, backgroundColor )
	
	surface.SetDrawColor( iconColor )
	surface.SetMaterial( icon )
	surface.DrawTexturedRect( x + 9, y + 4, 24, 24 )

	draw.DrawText( label, "Photon2.UI:Medium", x + 40, y + 9, labelColor )

	surface.SetMaterial( inactiveIcon )

	-- The "selected" indicator calculation needs
	-- special handling when there's more than one row.
	if ( selected > 0 and rows > 1 ) then
		local selectedRow = math.ceil( selected / rowMax )

		-- the highest value up to the end of the selected row
		local maxToRow
		if ( selectedRow == rows ) then
			maxToRow = count
		else
			maxToRow = selectedRow * rowMax
		end
		
		-- the intra-row index of the selected value (always between 1 and rowMax)
		local rowSelected = selected - ( ( selectedRow - 1 ) * rowMax )
		
		selectedIndicator = maxToRow - rowSelected + 1

		-- local lastRow = rowMax - ( ( rowMax * rows ) - count )

		-- print( "last row: " .. tostring( lastRow ) )
		-- print( selectedRow )
		-- selectedIndicator = selected + rowMax
	end

	surface.SetDrawColor( indicatorColor )

	-- for =1, rows do

	-- end

	local yOffset
	
	for i=1, count do
		local row = math.ceil( i/rowMax )

		if ( rows == 1 ) then 
			yOffset = 12
		elseif ( rows == 2 ) then
			yOffset = 6 + ( ( row - 1 ) * 12 )
		end

		if ( i == selectedIndicator ) then
			surface.SetMaterial( activeIcon )
			surface.SetDrawColor( userSettings.HighlightColor )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( ( ( i - 1 ) % rowMax ) ) * 12 ), y + yOffset, 8, 8 )

		if ( i == selectedIndicator ) then
			surface.SetMaterial( inactiveIcon )
			surface.SetDrawColor( indicatorColor )
		end
	end

end



local function addHintKey( tbl, cmd )
	local map = Photon2.ClientInput.Active.Map
	if ( not map ) then return end
	if ( map[cmd] and map[cmd][1] ) then
		tbl[#tbl+1] = { string.upper(map[cmd][1].Display), string.upper(Photon2.GetCommand(cmd).Alt or Photon2.GetCommand(cmd).Title)  }
	end
end

local function addHintKeyMultiple( tbl, cmd1, cmd2, label )
	local map = Photon2.ClientInput.Active.Map
	if ( not map ) then return end
	if ( map[cmd1] and map[cmd1][1] and  map[cmd2] and map[cmd2][1] ) then
		tbl[#tbl+1] = { string.upper(map[cmd1][1].Display .. "-" .. string.upper(map[cmd2][1].Display )), string.upper( label )  }
	end
end

HUD.StartTime = 0
local indicatorComponent = nil

local signalComponent = nil

-- How long the key/hint info stays visible
local hintDuration = 7
-- Width of main HUD panels
local mainWidth = 150
-- Distance from edge of canvas
local offset = 4
-- Spacing between the internal panels
local margin = 2
-- Key bind information width
local keyHintWidth = 150
-- Key bind information margin
local keyHintMargin = 32

-- Photon2.HUD.FromRight = false

local hintInfoVisible = false

function HUD.EnableChanged()

end

hook.Add( "HUDPaint", "Photon2:RenderHudRT", function()

	-- if true then return end
	local target = Photon2.ClientInput.TargetController
	
	if ( not target  or not IsValid( target ) or ( not userSettings.Enabled ) ) then 
		
		HUD.StartTime = 0
		indicatorComponent = nil
		signalComponent = nil
		if ( HUD.WasActive ) then
			HUD.WasActive = false
			HUD.Deactivate()
		end
		return
	elseif ( not HUD.WasActive and ( userSettings.Enabled ) ) then
		HUD.WasActive = true
		HUD.Activate()
	end

	-- when does this happen?
	if ( not Photon2.ClientInput.Active ) then warnOnce( "Client input profile is invalid." ) end

	HUD.WasActive = true

	local keyHints = {}

	hudMaterial:SetTexture( "$basetexture", hudRT )

	if ( CurTime() >= (lastUpdate + 0.05) ) then

		if HUD.StartTime == 0 then 
			HUD.StartTime = CurTime()
			hintInfoVisible = true
		end

		if ( not indicatorComponent and ( istable( target.ComponentArray )) ) then
			for k, v in pairs( target.ComponentArray ) do
				if ( v.Title == "Photon 2 HUD" ) then
					indicatorComponent = v
					break
				end
			end
		end

		-- This is a really dirty way of getting this info, but realistically there should only be 1 'Vehicle' category component per profile
		if ( not signalComponent and ( istable( target.ComponentArray )) ) then
			for k, v in pairs( target.ComponentArray ) do
				if ( v.Category == "Vehicle" ) then
					signalComponent = v
					break
				end
			end
		end

		render.PushRenderTarget( hudRT )
		-- needs to be scaled down by 16px for some unknown reason
		render.SetViewPort( 8, 8, 512 - 16, 512 - 16 )
		cam.Start2D()
			render.OverrideAlphaWriteEnable( true, true)
			render.Clear( 0, 0, 0, 0, false, false )

			local mainX = offset
			local nextY = 4
			local nextH = 38

			if ( HUD.FromRight ) then
				mainX = ScrW() - mainWidth - offset
			end

			HUD.VehicleInfo( mainX, nextY, mainWidth, nextH, 
				string.upper(truncateString(Photon2.ClientInput.TargetController:GetProfile().Title, 26 ) or "ERROR"),
				string.upper(Photon2.ClientInput.Active.Title or "ERROR")
			)

			

			--
			-- TESTING STUFF HERE
			--
			local schema = target:GetInputSchema()

			local sigChannel = "Vehicle.Signal"
			local ligChannel = "Vehicle.Lights"
			local sigMode = target.CurrentModes[sigChannel]

			local showStandard = false

			-- Check if turn signals or head/parking lights are present then display HUD component if they are
			showStandard = ( schema[sigChannel] ~= nil or schema[ligChannel] ~= nil )

			if ( showStandard ) then
				local sigStyle = 1
				if ( sigMode == "OFF" ) then sigStyle = 0 end
				sigMode = (schema[sigChannel] or {})[sigMode] or {}

				nextY = ( nextY + nextH + margin )
				nextH = 32


				-- HUD.StandardLightingIndicator( mainX, nextY, mainWidth, iconVehicle, sigMode.Index or 0, sigStyle, signalComponent,
				-- 	target.CurrentModes["Vehicle.Signal"] == "LEFT", 
				-- 	target.CurrentModes["Vehicle.Signal"] == "RIGHT", 
				-- 	target.CurrentModes["Vehicle.Signal"] == "HAZARD",
				-- 	target.CurrentModes["Vehicle.Lights"] == "HEADLIGHTS", 
				-- 	target.CurrentModes["Vehicle.Lights"] == "AUTO",
				-- 	target.CurrentModes["Vehicle.Lights"] == "PARKING"
				-- )

				HUD.StandardLights( mainX, nextY, mainWidth, 
					target.CurrentModes["Vehicle.Lights"] == "AUTO", 
					target.CurrentModes["Vehicle.Lights"] == "HEADLIGHTS", 
					target.CurrentModes["Vehicle.Lights"] == "PARKING"
				)
			end
			--
			--
			--

			

			nextY = ( nextY + nextH + margin )

			local priChannel = "Emergency.Warning"
			local priMode = target.CurrentModes[priChannel]

			if ( schema[priChannel] ) then 
				local priData = schema[priChannel][priMode]

				if ( not priData ) then
					schema[priChannel][priMode] = {
						Label = priMode
					}
				end
				
				local priStyle = 1
				if ( priMode == "OFF" ) then priStyle = 0 end

				if ( hintInfoVisible ) then
					addHintKey( keyHints, "toggle_warning_lights" )
					addHintKey( keyHints, "cycle_warning_lights" )
				end

				local showSecondary = false

				local secChannel = "Emergency.Directional"
				local secMode = target.CurrentModes[secChannel]

				showSecondary = ( schema[secChannel] ~= nil )

				if ( showSecondary ) then
					local secStyle = 1
					if ( secMode == "OFF" ) then secStyle = 0 end
					secMode = (schema[secChannel] or {})[secMode] or {}

					nextH = 64
					HUD.LightStageIndicator( mainX, nextY, mainWidth, 
						schema[priChannel][priMode].Label or priMode, 
						#schema[priChannel], 
						schema[priChannel][priMode].Index or 0,
						priStyle,

						secMode.Label or target.CurrentModes[secChannel], 
						#(schema[secChannel] or {}) or 0, 
						secMode.Index or 0,
						secStyle,
						indicatorComponent
					)

				else
					nextH = 40
					HUD.LightStageIndicatorSingle( mainX, nextY, mainWidth,
						schema[priChannel][priMode].Label, 
						-- 3, 
						#schema[priChannel], 
						schema[priChannel][priMode].Index or 0,
						priStyle
					)

				end

				nextY = ( nextY + nextH + margin )
			end

			local siren1Name = target:GetSirenSelection(1)
			
			if ( siren1Name ) then
				-- local siren1 = Photon2.Index.Sirens[siren1Name]
				local siren1 = Photon2.GetSiren( siren1Name )
				if ( siren1 ) then
					-- local sirenTones1 = siren1
					if ( hintInfoVisible ) then
						addHintKey( keyHints, "activate_lights_siren" )
						addHintKeyMultiple( keyHints, "toggle_siren_1", "toggle_siren_4", "Siren Tone" )
					end
					
					-- Siren 1 Indicator
					local sirenDisplay
					local label = target.CurrentModes["Emergency.Siren"]
					local icon = toneIcons["speaker"]
					local sirenSelection = siren1.OrderedTones[target.CurrentModes["Emergency.Siren"]] or -1
					local indicatorMode = 0

					if ( target.CurrentModes["Emergency.SirenOverride"] ~= "OFF" ) then
						sirenDisplay = siren1.Tones[target.CurrentModes["Emergency.SirenOverride"]]
						indicatorMode = 2
					else
						sirenDisplay = siren1.Tones[target.CurrentModes["Emergency.Siren"]]
						if ( (target.CurrentModes["Emergency.Siren"] ~= "OFF") and (sirenDisplay) ) then
							indicatorMode = 1
						end
					end

					if (sirenDisplay) then
						icon = toneIcons[sirenDisplay.Icon] or toneIcons["siren"]
						label = sirenDisplay.Label
					end

					nextH = 32
					HUD.DiscreteIndicator( mainX, nextY, mainWidth, 
						icon, 
						label, 
						#siren1.OrderedTones, 
						sirenSelection, 
						indicatorMode 
					)
				else
					nextH = 32
					HUD.DiscreteIndicator( mainX, nextY, mainWidth, 
						toneIcons["speaker"], 
						"ERROR", 
						0, 
						0, 
						0 
					)
				end
				-- HUD.DiscreteIndicator( ScrW() - mainWidth - 4, 322, mainWidth, 
				-- 	icons[sirenDisplay.Icon], 
				-- 	sirenDisplay.Label, 
				-- 	#smartSirenIndicator.DisplayArray, 
				-- 	sirenSelection, 
				-- 	indicatorMode 
				-- )
				nextY = ( nextY + nextH + margin )
			end

			nextH = 48

			local template = {
				{ "Emergency.Auxiliary", "AUX" },
				{ "Emergency.Cut", "CUT" },
				{ "Emergency.Marker", "CRZ" },
				{ "Emergency.Spotlight", "SPT" }
			}

			local indicators = {}

			local channel, label, style, mode, modeData

			for i=1, #template do
				channel = template[i][1]
				label = template[i][2]
				if ( schema[channel] ) then
					mode = target.CurrentModes[channel]
					modeData = schema[channel][mode]
					style = 0
					if ( mode and ( mode ~= "OFF" ) ) then
						style = 1
						if ( modeData ) then
							label = modeData.Label
						else
							label = mode
						end
					end
					indicators[i] = { label or mode, style }
				else
					indicators[i] = { label, 0 }
				end
			end

			-- PrintTable(schema[i1])

			-- Draw Bottom Row
			HUD.FunctionsIndicator( mainX, nextY, mainWidth - 52 - margin, 48, 2, indicators )

			-- The scene light indicator is currently fixed at 52x48
			HUD.SceneLightingIndicator( mainX + ( mainWidth - 52 - margin ) + margin, nextY, iconVehicle, 
				target.CurrentModes["Emergency.SceneForward"] ~= "OFF", 
				target.CurrentModes["Emergency.SceneForward"] == "FLOOD", 
				target.CurrentModes["Emergency.SceneRight"] ~= "OFF",
				target.CurrentModes["Emergency.SceneRear"] ~= "OFF", 
				target.CurrentModes["Emergency.SceneLeft"] ~= "OFF" 
			)

			nextY = ( nextY + nextH + margin )

			if ( HUD.StartTime + hintDuration >= CurTime() ) then
				local versionX = offset
				local alignX = TEXT_ALIGN_LEFT
				local bindInfoX = mainWidth + keyHintMargin
				
				if ( HUD.FromRight ) then
					bindInfoX = ScrW() - mainWidth - keyHintWidth
					alignX = TEXT_ALIGN_RIGHT
					versionX = ScrW() - offset
				end

				draw.DrawText( "PHOTON v" .. tostring( Photon2.Version ), "Photon2.UI:Small", versionX, nextY + margin, userSettings.HighlightColor, alignX )

				nextY = ( nextY + 32 + margin )
				
				HUD.KeyBindHint( bindInfoX, 4, keyHints )
			else
				-- prevents HUD from moving
				nextY = ( nextY + 32 + margin )
				hintInfoVisible = false
			end
			-- HUD.BasicInputHint()
			drawHeight = nextY
		cam.End2D()
		render.PopRenderTarget()
		lastUpdate = CurTime()
	end

	-- surface.SetDrawColor( 255, 255, 255, 255 )
	-- surface.SetMaterial( hudMaterial )
	-- surface.DrawTexturedRect( ScrW() - 528 - userSettings.OffsetX, ScrH() - userSettings.OffsetY - 32, 496, 496 )
	-- surface.SetAlphaMultiplier( 1 )
end)

local showPerformanceInfo = GetConVar( "ph2_debug_perf_overlay" )

function Photon2.HUD.DrawPerformanceInfo()
	if ( not showPerformanceInfo:GetBool() ) then return end
	local x = 16
	local y = 240
	local frameTime = FrameTime()
	draw.DrawText( "Photon 2      " .. tostring( math.Round( FrameTime() * 1000 ) ) .."ms", "BudgetLabel", x, y, userSettings.HighlightColor )
	y = y + 22
	draw.DrawText( "Mesh (" .. tostring( #Photon2.RenderLightMesh.Active ) ..")", "BudgetLabel", x, y, userSettings.HighlightColor )
	x = x + 96
	draw.DrawText( "2D (" .. tostring( #Photon2.RenderLight2D.Active ) ..")", "BudgetLabel", x, y, userSettings.HighlightColor )
	x = x + 96
	draw.DrawText( "CUR: " .. tostring( math.Round( CurTime() ) ), "BudgetLabel", x, y - 22, userSettings.HighlightColor )
	draw.DrawText( "PTX (" .. tostring( #Photon2.RenderLightProjected.Active ) .. ")", "BudgetLabel", x, y, userSettings.HighlightColor )
	x = 16
	y = y + 18
	draw.DrawText( "R: " .. tostring( math.Round( ( Photon2.RenderLightMesh.RenderTime / frameTime ) * 100, 2 ) .."%" ), "BudgetLabel", x, y, userSettings.HighlightColor )
	y = y + 12
	draw.DrawText( "D: " .. tostring( math.Round( ( Photon2.RenderBloom.DrawTime / frameTime ) * 100, 2 ) .."%" ), "BudgetLabel", x, y, userSettings.HighlightColor )
	x = 16 + 96
	y = y - 12
	draw.DrawText( "P: " .. tostring( math.Round( ( Photon2.RenderLight2D.PreRenderTime / frameTime ) * 100, 2 ) .."%" ), "BudgetLabel", x, y, userSettings.HighlightColor )
	y = y + 12
	draw.DrawText( "R: " .. tostring( math.Round( ( Photon2.RenderLight2D.RenderTime / frameTime ) * 100, 2 ) .."%" ), "BudgetLabel", x, y, userSettings.HighlightColor )
end

hook.Add( "HUDPaint", "Photon2,HUD:PerformanceInfo", Photon2.HUD.DrawPerformanceInfo )