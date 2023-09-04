Photon2.ClientInput = Photon2.ClientInput or {
	Configurations = {},
	Active = {},
	KeysPressed = {},
	KeysHeld = {},
	Listening = false,
	---@type PhotonController | boolean
	TargetController = false
}

local print = Photon2.Debug.PrintF
local printf = Photon2.Debug.PrintF

local holdThreshold = 1

local keyActivities = { "OnPress", "OnHold", "OnRelease" }

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
	print("ClientInput: LISTENING")
	Photon2.ClientInput.Listening = true
end

function Photon2.ClientInput.StopListening()
	print("ClientInput: NOT LISTENING")
	Photon2.ClientInput.Listening = false
end

function Photon2.ClientInput.SetActiveConfiguration( id )
	local config = Photon2.ClientInput.Configurations[id]
	if ( not id ) then
		error("Client Input Configuration [" .. tostring(id) .. "] could not be found.")
	end
	Photon2.ClientInput.Active = config
end

function Photon2.ClientInput.RegisterConfiguration( id, config )
	for key, keyConfig in pairs( config ) do
		local modifiers = {}
		local actions = {}
		for _, activity in pairs( keyActivities ) do
			if ( istable( keyConfig[activity] ) ) then
				for _, action in pairs( keyConfig[activity] ) do
					action.ModifierConfig = {}
					if ( istable( action.Modifiers ) ) then
						for _, modifierKey in pairs( action.Modifiers ) do
							modifiers[modifierKey] = true
							action.ModifierConfig[modifierKey] = true
						end
					end
					actions[#actions+1] = action
				end
			end
		end
		for i, action in pairs( actions ) do
			for modifierKey, _ in pairs( modifiers ) do
				if ( action.ModifierConfig[modifierKey] == nil ) then
					action.ModifierConfig[modifierKey] = false
				end
			end
		end
	end
	PrintTable( config )
end

function Photon2.ClientInput.ExecuteActions( actions )
	if ( not actions ) then return end
	if ( not IsValid( Photon2.ClientInput.TargetController ) ) then return end
	
	local controller = Photon2.ClientInput.TargetController ---@as PhotonController
	
	local action
	for i=1, #actions do
		action = actions[i].Action
		print("[" .. tostring( action.Action ) .. "] " .. tostring( action.Channel ) .. "::" .. tostring( action.Value ))

		if ( action.Action == "TOGGLE_OFF" ) then
			local currentValue = controller.CurrentModes[action.Channel]
			if ( currentValue == action.Value ) then
				controller:SetChannelMode( action.Channel, "OFF" )
			else
				controller:SetChannelMode( action.Channel, action.Value )
			end
		elseif ( action.Action == "SET" ) then
			controller:SetChannelMode( action.Channel, action.Value )
		end

	end
	-- print("Executing " .. tostring(#actions) .. " actions...")
end

function Photon2.ClientInput.ValidateActions( actions, key, trigger )
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

	if ( #result > 0 ) then Photon2.ClientInput.ExecuteActions( result ) end

end

function Photon2.ClientInput.OnPress( key )
	if ( not Photon2.ClientInput.Listening ) then return end
	-- print("OnPress:" .. tostring( input.GetKeyName(key) ) )
	if ( Photon2.ClientInput.Active[key] ) then
		Photon2.ClientInput.KeysPressed[key] = RealTime()
		Photon2.ClientInput.ValidateActions(  Photon2.ClientInput.Active[key].OnPress, key, "PRESS" )
	end
end
hook.Add( "Photon2:KeyPressed", "Photon2.ClientInput:OnPress", Photon2.ClientInput.OnPress )

function Photon2.ClientInput.OnRelease( key )
	if ( not Photon2.ClientInput.Listening ) then return end
	-- print("OnRelease:" .. tostring( input.GetKeyName(key) ) )
	if ( Photon2.ClientInput.KeysPressed[key] or Photon2.ClientInput.KeysHeld[key] ) then
		Photon2.ClientInput.KeysPressed[key] = nil
		Photon2.ClientInput.KeysHeld[key] = nil
		Photon2.ClientInput.ValidateActions(  Photon2.ClientInput.Active[key].OnRelease, key, "RELEASE" )
	end
end
hook.Add( "Photon2:KeyReleased", "Photon2.ClientInput:OnRelease", Photon2.ClientInput.OnRelease )

-- Scans keys registered as "pressed" to check when they reach the "held" threshold.
function Photon2.ClientInput.ScanPressed()
	if ( not Photon2.ClientInput.Listening ) then return end

	for key, time in pairs( Photon2.ClientInput.KeysPressed ) do
		if ( RealTime() >= ( time + holdThreshold ) ) then
			Photon2.ClientInput.KeysPressed[key] = nil
			Photon2.ClientInput.KeysHeld[key] = RealTime()
			Photon2.ClientInput.ValidateActions(  Photon2.ClientInput.Active[key].OnHold, key, "HOLD" )
		end
	end
end
hook.Add( "Think", "Photon2.ClientInput:Scan", Photon2.ClientInput.ScanPressed )

local prototypeInput = {
	[KEY_F] = {
		OnRelease = {
			{ Action = "TOGGLE_OFF", Channel = "Emergency.Warning", Value = "MODE3" }
		}
	},
	[KEY_SPACE] = {
		OnPress = {
			{ Action = "SET", Channel = "Vehicle.Brake", Value = "BRAKE" }
		},
		OnRelease = {
			{ Action = "SET", Channel = "Vehicle.Brake", Value = "OFF" }
		}
	},
	[KEY_LALT] = {
		Name = "Warning Light Stage",
		OnRelease = {
			{ Action = "CYCLE", Channel = "Emergency.Warning", Value = { "OFF", "MODE1", "MODE2", "MODE3" } }
		},
		OnHold = {
			{ Action = "CYCLE", Channel = "Emergency.Warning", Value = { "OFF", "MODE1", "MODE2", "MODE3" } }
		}
	},
	[KEY_R] = {
		Name = "Lights & Sirens",
		Toggle = true,
		OnRelease = {
			{ Action = "TOGGLE_OFF", Channel = "Emergency.Siren1", Value = "T1" },
			{ Action = "TOGGLE_OFF", Channel = "Emergency.Warning", Value = "MODE3" }
		}
	},
	[KEY_1] = {
		OnPress = {
			{ Action = "TOGGLE", Channel = "Emergency.Siren1", Value = "1" },
			{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "1", Modifiers = { KEY_RALT } }
		}
	},
	[KEY_2] = {
		OnPress = {
			{ Action = "TOGGLE", Channel = "Emergency.Siren1", Value = "2" },
			{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "2", Modifiers = { KEY_RALT } },
		}
	}
}

Photon2.ClientInput.RegisterConfiguration( "prototype", prototypeInput )

Photon2.ClientInput.Active = prototypeInput

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
