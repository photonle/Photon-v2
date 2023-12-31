Photon2.HUD = Photon2.HUD or {

}

local hudMaterial = Material("photon/ui/hud")

local hudRT = GetRenderTargetEx( "Photon2HUD" .. CurTime(), 512, 512, 
0, MATERIAL_RT_DEPTH_NONE, 32768 + 2048 + 4 + 8 + 1, 0, IMAGE_FORMAT_RGBA8888 )

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

local lastUpdate = 0

local cornerRadius = 4

local icons = {
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
}

local ellipseActive = Material("photon/ui/hud_ellipse_active.png")
local ellipseInactive = Material("photon/ui/hud_ellipse_inactive.png")

local white = Color( 255, 255, 255 )

local dimColor = Color( 255, 255, 255, 96 )
local inactiveColor = Color( 0, 0, 0, 128 )

local HUD = Photon2.HUD

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

local stateColors = {
	["OFF"] = inactiveColor,
	["ON"] = white
}

function HUD.LightsIndicator( x, y, width, height, gap, elements )
	for i, element in pairs( elements ) do
		draw.RoundedBox( 0, x + ( ( i - 1 ) * ( width + gap ) ), y, width, height, stateColors[element.CurrentStateId] )
	end
end

function HUD.LightStageIndicator( x, y, width, priLabel, priCount, priSelected, priStyle, secLabel, secCount, secSelected, secStyle, indicatorComponent )
	local priLabelColor = white
	local secLabelColor = white
	local secIndicatorColor = dimColor
	local bgColor = Color( 64, 64, 64, 200 )

	if ( ( priStyle + secStyle ) < 1 ) then
		bgColor = Color( 64, 64, 64, 100 )
	end

	if ( priStyle == 0 ) then
		priLabelColor = dimColor
	end

	if ( secStyle == 0 ) then
		secLabelColor = dimColor
		secIndicatorColor = Color( 0, 0, 0, 128 )
	end

	draw.RoundedBox( cornerRadius, x, y, width, 64, bgColor )
	draw.DrawText( priLabel, "Photon2.UI:Medium", x + 40, y + 8, priLabelColor )
	draw.DrawText( secLabel, "Photon2.UI:Small", x + 40, y + 44, secLabelColor )

	

	local stageDimensions = stageIndicators[priCount]
	local drawColor = white
	for i=1, priCount do
		if ( i <= priSelected ) then
			drawColor = white
		else
			drawColor = inactiveColor
		end
		draw.RoundedBox( 2, x + 8, y + ( 8 ) + ( ( i - 1 ) * ( stageDimensions[1] + stageDimensions[2] ) ), 26, stageDimensions[1], drawColor )
	end

	if ( indicatorComponent ) then
		HUD.LightsIndicator( x + 40, y + 31, 11, 3, 2, indicatorComponent.Elements )
	end

	surface.SetMaterial( ellipseInactive )
	surface.SetDrawColor( secIndicatorColor )

	secSelected = ( secCount + 1 ) - secSelected

	for i=1, secCount do
		if ( i == secSelected ) then
			surface.SetMaterial( ellipseActive )
			surface.SetDrawColor( white )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( i - 1 ) * 12 ), y + 46, 8, 8 )

		if ( i == secSelected ) then
			surface.SetMaterial( ellipseInactive)
			surface.SetDrawColor( secIndicatorColor )
		end
	end
end

function HUD.LightStageIndicatorSingle( x, y, width, label, count, selected, style )
	local labelColor = white
	local bgColor = Color( 64, 64, 64, 200 )

	if ( style < 1 ) then
		bgColor = Color( 64, 64, 64, 100 )
		labelColor = dimColor
	end

	draw.RoundedBox( cornerRadius, x, y, width, 40, bgColor )
	draw.DrawText( label, "Photon2.UI:Medium", x + 40, y + 13, labelColor )

	local stageDimensions = stageIndicatorsSmall[count]

	local drawColor = white

	for i=1, count do
		if ( i <= selected ) then
			drawColor = white
		else
			drawColor = inactiveColor
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
function HUD.FunctionsIndicator( x, y, width, height, columns, columnWidth, functions )
	
	local isActive = false

	for i=1, #functions do
		if ( functions[i][2] > 0 ) then 
			isActive = true
			break
		end
	end

	if ( isActive ) then
		draw.RoundedBox( cornerRadius, x, y, width, height, Color( 64, 64, 64, 200 ) )
	else

		draw.RoundedBox( cornerRadius, x, y, width, height, Color( 64, 64, 64, 100 ) )
	end
	
	local row = 1
	local column = 1

	surface.SetDrawColor( 255, 255, 255, 255 )
	local textColor = white	
	for i=1, #functions do
		
		if ( functions[i][2] == 1 ) then
			surface.SetMaterial( ellipseActive )
			surface.SetDrawColor( white )
			textColor = white
		else
			surface.SetMaterial( ellipseInactive )
			surface.SetDrawColor( inactiveColor )
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

-- Draws vehicle name with current input profile below it.
function HUD.VehicleInfo( x, y, w, h, vehicleName, inputConfigName )
	local backgroundColor = Color( 64, 64, 64, 200 )
	draw.RoundedBox( cornerRadius, x, y, w, h, backgroundColor )

	draw.DrawText( vehicleName, "Photon2.UI:Small", x + 8, y + 7, white )
	draw.DrawText( inputConfigName, "Photon2.UI:Small", x + 8, y + 20, Color(255,255,255,100) )
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
	local backgroundColor = Color( 64, 64, 64, 200 )
	
	if ( isInactive ) then
		backgroundColor = Color( 64, 64, 64, 100 )
	end

	draw.RoundedBox( cornerRadius, x, y, 52, 48, backgroundColor )
	
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

function HUD.KeyBindHint( x, y, keys )
	local key
	local keyPadding = 7
	for i=1, #keys do
		key = keys[i]
		surface.SetFont( "Photon2.UI:MediumSmall" )
		local w = surface.GetTextSize( key[1] )
		draw.RoundedBox( 4, x + 14 - w - keyPadding, y, w + (keyPadding * 2), 20, Color( 64, 64, 64, 200 ) )
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetTextPos( x + 14 - w, y + 4)
		surface.DrawText( key[1] )
		surface.SetTextPos( x + 28, y + 4 )
		surface.DrawText( key[2] )
		y = y + 22
	end
	
end


-- Displays basic input 
function HUD.BasicInputHint()
	HUD.KeyBindHint( 190, 220, {
		{ "F", "EMERGENCY LIGHTS" },
		{ "ALT", "LIGHT MODE" },
		{ "R", "SIREN" },
		{ "1-4", "SIREN TONE" },
	})
end

local commands = {
	"toggle_warning_lights",
	"cycle_warning_lights",
	"activate_lights_siren"
}

---@param x integer
---@param y integer
---@param width integer
---@param icon IMaterial
---@param label string
---@param count integer
---@param selected integer
---@param mode integer 0=Off, 1=On, 2=Override
function HUD.DiscreteIndicator( x, y, width, icon, label, count, selected, mode )
	local activeIcon = ellipseActive
	local inactiveIcon = ellipseInactive
	local labelColor = white
	local iconColor = white
	local indicatorColor = dimColor
	local backgroundColor =  Color( 16, 16, 16, 200 )

	if ( mode == 2 ) then
		activeIcon = ellipseInactive
		inactiveIcon = ellipseActive
		indicatorColor = white
	elseif ( mode == 0 ) then
		labelColor = Color( 255, 255, 255, 128 )
		iconColor = Color( 0, 0, 0, 128 )
		indicatorColor = Color( 0, 0, 0, 128 )
		backgroundColor =  Color( 16, 16, 16, 100 )
	end

	draw.RoundedBox( cornerRadius, x, y, width, 32, backgroundColor )
	
	surface.SetDrawColor( iconColor )
	surface.SetMaterial( icon )
	surface.DrawTexturedRect( x + 9, y + 4, 24, 24 )

	draw.DrawText( label, "Photon2.UI:Medium", x + 40, y + 9, labelColor )

	surface.SetMaterial( inactiveIcon )

	selected = ( count + 1 ) - selected

	surface.SetDrawColor( indicatorColor )

	for i=1, count do
		if ( i == selected ) then
			surface.SetMaterial( activeIcon )
			surface.SetDrawColor( white )
		end

		surface.DrawTexturedRect( x + width - 16 - ( ( i - 1 ) * 12 ), y + 12, 8, 8 )

		if ( i == selected ) then
			surface.SetMaterial( inactiveIcon )
			surface.SetDrawColor( indicatorColor )
		end
	end

end

local function truncateString( str, maxLength )
	if #str > maxLength then
		return string.sub(str, 1, maxLength - 3) .. "..."
	else
		return str
	end
end

local function addHintKey( tbl, cmd )
	local map = Photon2.ClientInput.Active.Map
	if ( map[cmd] and map[cmd][1] ) then
		tbl[#tbl+1] = { string.upper(map[cmd][1].Display), string.upper(Photon2.GetCommand(cmd).Alt or Photon2.GetCommand(cmd).Title)  }
	end
end

local function addHintKeyMultiple( tbl, cmd1, cmd2, label )
	local map = Photon2.ClientInput.Active.Map
	if ( map[cmd1] and map[cmd1][1] and  map[cmd2] and map[cmd2][1] ) then
		tbl[#tbl+1] = { string.upper(map[cmd1][1].Display .. "-" .. string.upper(map[cmd2][1].Display )), string.upper( label )  }
	end
end

-- How long the key information stays visible
local hintDuration = 7

local drawHeight = 0
local hudStartTime = 0

local hintInfoVisible = false

hook.Add( "HUDPaint", "Photon2:RenderHudRT", function()
	-- if true then return end
	local target = Photon2.ClientInput.TargetController
	local indicatorComponent

	if ( not target ) then hudStartTime = 0 return end

	local keyHints = {}

	hudMaterial:SetTexture( "$basetexture", hudRT )
	if ( CurTime() >= (lastUpdate + 0.05) ) then

		if hudStartTime == 0 then 
			hudStartTime = CurTime()
			hintInfoVisible = true
		end

		for k, v in pairs( target.UIComponents ) do
			if ( v.PrintName == "Photon 2 HUD" ) then
				indicatorComponent = v
				break
			end
		end

		render.PushRenderTarget( hudRT )
		-- needs to be scaled down by 16px for some unknown reason
		render.SetViewPort( 8, 8, 512 - 16, 512 - 16 )
		cam.Start2D()
			render.OverrideAlphaWriteEnable( true, true)
			render.Clear( 0, 0, 0, 0, false, false )

			local margin = 2
			local nextY = 4
			local nextH = 38

			HUD.VehicleInfo( ScrW() - 150 - 4, nextY, 150, nextH, 
				string.upper(truncateString(Photon2.ClientInput.TargetController:GetProfile().Title, 26 ) or "ERROR"),
				string.upper(Photon2.ClientInput.Active.Title or "ERROR")
			)

			nextY = ( nextY + nextH + margin )

			local priChannel = "Emergency.Warning"
			local priMode = target.CurrentModes[priChannel]

			local schema = target:GetInputSchema()

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
					HUD.LightStageIndicator( ScrW() - 150 - 4, nextY, 150, 
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
					HUD.LightStageIndicatorSingle( ScrW() - 150 - 4, nextY, 150,
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
				local siren1 = Photon2.GetSiren(siren1Name)
				-- local sirenTones1 = siren1
				if ( hintInfoVisible ) then
					addHintKey( keyHints, "activate_lights_siren" )
					addHintKeyMultiple( keyHints, "toggle_siren_1", "toggle_siren_4", "Siren Tone" )
				end
				
				-- Siren 1 Indicator
				local sirenDisplay
				local label = target.CurrentModes["Emergency.Siren"]
				local icon = icons["speaker"]
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
					icon = icons[sirenDisplay.Icon]
					label = sirenDisplay.Label
				end

				nextH = 32
				HUD.DiscreteIndicator( ScrW() - 150 - 4, nextY, 150, 
					icon, 
					label, 
					#siren1.OrderedTones, 
					sirenSelection, 
					indicatorMode 
				)
				-- HUD.DiscreteIndicator( ScrW() - 150 - 4, 322, 150, 
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

			HUD.FunctionsIndicator( ScrW() - 150 - 4, nextY, 96, 48, 2, 44, indicators )


			HUD.SceneLightingIndicator( ScrW() - 150 - 4 + 98, nextY, vehicleIcon, 
				target.CurrentModes["Emergency.SceneForward"] ~= "OFF", 
				target.CurrentModes["Emergency.SceneForward"] ~= "OFF", 
				target.CurrentModes["Emergency.SceneRight"] ~= "OFF",
				target.CurrentModes["Emergency.SceneRear"] ~= "OFF", 
				target.CurrentModes["Emergency.SceneLeft"] ~= "OFF" 
			)

			nextY = ( nextY + nextH + margin )

			if ( hudStartTime + hintDuration >= CurTime() ) then
				draw.DrawText( "PHOTON v" .. tostring( Photon2.Version ), "Photon2.UI:Small", ScrW() - 4, nextY + 2, white, TEXT_ALIGN_RIGHT )

				nextY = ( nextY + 32 + margin )
				
				HUD.KeyBindHint( ScrW() - 300, 4, keyHints )
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
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(hudMaterial)
	surface.DrawTexturedRect(ScrW() - 528, ScrH() - drawHeight - 32, 496, 496)
	surface.SetAlphaMultiplier( 1 )
end)