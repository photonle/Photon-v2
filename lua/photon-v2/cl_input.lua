Photon2.ClientInput = Photon2.ClientInput or {
	Configurations = {},
	Active = { Binds = {} },
	KeysPressed = {},
	KeysHeld = {},
	Commands = {},
	Listening = false,
	---@type PhotonController | boolean
	TargetController = false,
	KeyActivities = { "OnPress", "OnHold", "OnRelease" }
}

local mouseKeys = { 
	[MOUSE_LEFT] = true, 
	[MOUSE_RIGHT] = true
}

local print = Photon2.Debug.PrintF
local printf = Photon2.Debug.PrintF

local holdThreshold = 1

function Photon2.ClientInput.SetTargetController( controller )
	print( "Setting input controller: (" .. tostring( controller ) .. ")" )
	if IsValid( controller ) then
		Photon2.ClientInput.TargetController = controller
		Photon2.ClientInput.StartListening()
	else
		Photon2.ClientInput.TargetController = false
		Photon2.ClientInput.StopListening()
	end
end

function Photon2.ClientInput.StartListening()
	-- if ( not IsValid( controller ) ) then 
	-- 	ErrorNoHaltWithStack( "ClientInput instructed to start listening with an invalid controller entity.")
	-- end
	Photon2.ClientInput.Listening = true
end

function Photon2.ClientInput.StopListening()
	Photon2.ClientInput.Listening = false
end

function Photon2.ClientInput.SetActiveConfiguration( name )
	local config = Photon2.GetInputConfiguration( name )
	if ( not config ) then
		ErrorNoHalt("Client Input Configuration [" .. tostring(name) .. "] could not be found.")
		config = Photon2.GetInputConfiguration( "default" )
	end
	Photon2.ClientInput.Active = config
end


function Photon2.ClientInput.ExecuteActions( actions, key, press )
	if ( not actions ) then return end
	if ( not IsValid( Photon2.ClientInput.TargetController ) ) then return end
	-- print("Executing " .. tostring(#actions) .. " actions...")
	local controller = Photon2.ClientInput.TargetController ---@as PhotonController
	controller:InputUserCommand( actions, key, press, "NAME NOT IMPLEMENTED" )
end

function Photon2.ClientInput.ValidateActions( actions, key, press )
	-- print("Validating " .. tostring(input.GetKeyName(key) .. " " .. tostring(trigger)))
	if ( not actions ) then return end

	local result = {}

	for i, action in pairs( actions ) do
		local pass = true
		if ( action.ModifierConfig ) then
			for modifier, pressed in pairs( action.ModifierConfig ) do
				if ( Photon2.IsKeyDown( modifier ) ~= pressed ) then
					pass = false
					break
				end
			end
		end
		if ( pass ) then
			result[#result+1] =
			{
				Key = input.GetKeyName( key ),
				Press = press,
				Action = action
			}
		end
	end

	if ( #result > 0 ) then Photon2.ClientInput.ExecuteActions( result, key, press ) end

end

local pressedKeys = {}

function Photon2.ClientInput.OnPress( key )
	-- OCTOBER INPUT DEMO 
		pressedKeys[#pressedKeys+1] = key
	--
	if ( not Photon2.ClientInput.Listening ) then return end
	if ( mouseKeys[key] and vgui.CursorVisible() ) then return end
	if ( not Photon2.ClientInput.Active.Binds[key] ) then return end

	local binds = Photon2.ClientInput.Active.Binds[key]
	-- print("OnPress:" .. tostring( input.GetKeyName(key) ) )
	if ( binds ) then
		Photon2.ClientInput.KeysPressed[key] = RealTime()
		Photon2.ClientInput.ValidateActions(  binds.OnPress, key, "Press" )
	end
end
hook.Add( "Photon2:KeyPressed", "Photon2.ClientInput:OnPress", Photon2.ClientInput.OnPress )

function Photon2.ClientInput.OnRelease( key )
	-- OCTOBER INPUT DEMO 
		table.RemoveByValue( pressedKeys, key )
	--
	if ( not Photon2.ClientInput.Listening ) then return end
	if ( mouseKeys[key] and vgui.CursorVisible() ) then return end
	-- print("OnRelease:" .. tostring( input.GetKeyName(key) ) )
	if ( Photon2.ClientInput.KeysPressed[key] ) then
		Photon2.ClientInput.KeysPressed[key] = nil

		local binds = Photon2.ClientInput.Active.Binds[key]

		Photon2.ClientInput.ValidateActions(  binds.OnRelease, key, "Release" )
	elseif ( Photon2.ClientInput.KeysHeld[key] ) then
		-- Release will not run if key is configured for hold
		Photon2.ClientInput.KeysHeld[key] = nil
	end
end
hook.Add( "Photon2:KeyReleased", "Photon2.ClientInput:OnRelease", Photon2.ClientInput.OnRelease )

-- Scans keys registered as "pressed" to check when they reach the "held" threshold.
function Photon2.ClientInput.ScanPressed()
	if ( not Photon2.ClientInput.Listening ) then return end
	for key, time in pairs( Photon2.ClientInput.KeysPressed ) do

		if ( not Photon2.ClientInput.Active.Binds[key] ) then return end

		local binds = Photon2.ClientInput.Active.Binds[key]

		if ( RealTime() >= ( time + holdThreshold ) and ( binds.OnHold ) ) then
			Photon2.ClientInput.KeysPressed[key] = nil
			Photon2.ClientInput.KeysHeld[key] = RealTime()
			Photon2.ClientInput.ValidateActions(  binds.OnHold, key, "Hold" )
		end
	end
end
hook.Add( "Think", "Photon2.ClientInput:Scan", Photon2.ClientInput.ScanPressed )

--[[
		==== ILLUM ====
		misc: hold for flood, release for takedown?
--]]


-- PrintTable( Photon2.ClientInput.Active )

-- Photon2.ClientInput.StartListening()

--[[
		Actions:
			1. SET: Channel's mode is set to the specified value.
			
			2. TOGGLE: Toggles between the specified value and OFF. 
			   If the value is set to something other than the target value, the channel will
			   first change to the target value, then OFF.
			
			3. TOGGLE_OFF: Toggles between a non-OFF value and OFF. This differs
			   from TOGGLE as the channel will turn off whenever it isn't already
			   OFF. Otherwise the channel is set to the default target value.

			4. CYCLE: Moves sequentially through a collection of values upon each
			   activation, one at a time. If a collection of values isn't specified,
			   all available modes are utilized as found in the vehicle file or
			   all its components.

		Key behaviors:
			1. OnPress: When the key is pressed down.
			2. OnRelease: When the key is released.
			3. OnHold: When the key is pressed and held for a certain duration (1 second).

		Modifiers:
			Allows for modifier keys (Shift, Alt, Control) to be used for multi-key binds.
			Actions that use modifier keys will only fire those actions so long as the modifer
			keys are held during during the event (press, release, or hold). If Ctrl+1 is pressed, 
			the main key is [1] and the modifier would be Ctrl, and the OnPress event would be 
			executed. If both keys were held, the OnHold event would be executed. If Ctrl was 
			then released before [1] was released, the related OnRelease event would NOT execute.

			Multiple modifier keys can be required as well, and similarly, corresponding actions
			will only execute as long as EVERY modifier key is being held during each event.

		----- 
		UNDECIDED ON IMPLEMENTATION...

		Active Input State:
			Primarily tracks the current index of cycle actions. Each action entry is assigned
			a sequential and unique index and its value is tracked. An internal table 
			maintains a direct map to these actions that is treated independently of the key
			hierarchy. This is processed and managed automatically without surfacing
			to the user.

		-----
--]]

-- surface.CreateFont( "PH2Demo", {
-- 	font = "Roboto Light",
-- 	size = 96,
-- 	weight = 100
-- } )

-- hook.Add( "HUDPaint", "Photon2:KeyDemo", function()
-- 	local pressedKeysString = ""
-- 	for i=1, #pressedKeys do
-- 		pressedKeysString = pressedKeysString .. input.GetKeyName(pressedKeys[i])
-- 		if ( i < #pressedKeys ) then
-- 			pressedKeysString = pressedKeysString .. " + "
-- 		end

-- 	end
-- 	for k, v in ipairs( pressedKeys ) do

-- 	end
-- 	draw.DrawText( pressedKeysString, "PH2Demo", ScrW() * 0.5, ScrH() * 0.75, color_white, TEXT_ALIGN_CENTER )
-- end)