Photon2.ClientInput = Photon2.ClientInput or {
	Configurations = {},
	Active = { Binds = {} },
	KeysPressed = {},
	KeysHeld = {},
	Commands = {},
	Listening = false,
	---@type PhotonController | boolean
	TargetController = false
}

local mouseKeys = { 
	[MOUSE_LEFT] = true, 
	[MOUSE_RIGHT] = true
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
	Photon2.ClientInput.Listening = true
end

function Photon2.ClientInput.StopListening()
	Photon2.ClientInput.Listening = false
end

local pressActions = { "OnPress", "OnRelease", "OnHold" }

function Photon2.ClientInput.SetActiveConfiguration( id )
	local config = Photon2.ClientInput.Configurations[id]
	if ( not config ) then
		error("Client Input Configuration [" .. tostring(id) .. "] could not be found.")
	end
	Photon2.ClientInput.Active = config
end

---@param id string Unique configuration name/identifier.
---@param config table Bind configuration table.
function Photon2.ClientInput.RegisterConfiguration( id, config )

	-- for key, commands in pairs( config.Binds ) do
	-- 	local usedModifiers = {}
	-- 	-- First pass to find all used modifier keys
	-- 	for i, command in pairs( commands ) do
	-- 		command.ModifierConfig = {}
	-- 		if ( istable( command.Modifiers ) ) then
	-- 			for _, modifierKey in pairs( command.Modifiers ) do
	-- 				usedModifiers[modifierKey] = true
	-- 				command.ModifierConfig[modifierKey] = true
	-- 			end
	-- 		end
	-- 	end
	-- 	-- Second pass to optimize modifier key lookups
	-- 	for i, command in pairs( commands ) do
	-- 		for modifierKey, _ in pairs( usedModifiers ) do
	-- 			if ( command.ModifierConfig[modifierKey] == nil ) then
	-- 				command.ModifierConfig[modifierKey] = false
	-- 			end
	-- 		end
	-- 	end
	-- end

	local keys = config.Binds
	local binds = {}

	-- Loads commands into the configuration
	for key, commands in pairs( keys ) do
		binds[key] = {}
		for _, commandEntry in pairs ( commands ) do
			local command = Photon2.ClientInput.Commands[commandEntry.Command]
			if ( not command ) then
				error( "Client input command [" .. tostring( commandEntry.Command ) .. "] not found." )
			end
			for _, event in pairs( pressActions ) do
				if ( command[event] ) then
					binds[key][event] = binds[key][event] or {}

					binds[key][event][#binds[key][event]+1] = {
						Action = "META",
						Value = command.Name
					}

					for _, action in pairs( command[event] ) do
						binds[key][event][#binds[key][event]+1] = table.Copy( action )
						binds[key][event][#binds[key][event]].Modifiers = commandEntry.Modifiers
					end
				end
			end
		end
	end

	-- Processes actual command actions and optimize
	for key, keyConfig in pairs( binds ) do
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
			-- Process modifier keys
			for modifierKey, _ in pairs( modifiers ) do
				if ( action.ModifierConfig[modifierKey] == nil ) then
					action.ModifierConfig[modifierKey] = false
				end
			end
			-- Process value mapping
			if ( istable( action.Value ) ) then
				action.ValueMap = {}
				for j, value in pairs( action.Value ) do
					action.ValueMap[value] = j
				end
			end
		end
	end
	
	Photon2.ClientInput.Configurations[id] = {
		Name = config.Name,
		Author = config.Author,
		Binds = binds
	}
end


---@param command PhotonClientInputCommand
function Photon2.ClientInput.RegisterCommand( command )
	-- Command pre-processing...
	for _, activity in pairs( keyActivities ) do
		if ( command[activity] ) then
			for i, action in pairs( command[activity] ) do
				if ( istable( action.Value ) ) then
					action.ValueMap = {}
					for j, value in pairs( action.Value ) do
						action.ValueMap[value] = j
					end
				end
			end
		end
	end
	Photon2.ClientInput.Commands[command.Name] = command
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


local prototypeInput = {
	Name = "Default Input Profile",
	Author = "Photon",
	Binds = {
		[KEY_F] = { 
			{ Command = "default.toggle_warning_lights" } 
		},
		[KEY_LALT] = { 
			{ Command = "default.cycle_warning_lights" } 
		},
		[KEY_R] = {
			{ Command = "default.activate_lights_siren"}
		},
		[MOUSE_LEFT] = { 
			{ Command = "default.airhorn" } 
		},
		[MOUSE_RIGHT] = { 
			{ Command = "default.manual_siren" } 
		},
		[KEY_H] = { 
			{ Command = "default.vehicle_lights" } 
		},
		[KEY_M] = {
			{ Command = "default.toggle_cruise" }
		},
		[KEY_LEFT] = {
			{ Command = "default.left_signal" },
			{ Command = "default.scene_left", Modifiers = { KEY_RSHIFT } },
			{ Command = "default.directional_left", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_RIGHT] = {
			{ Command = "default.right_signal" },
			{ Command = "default.scene_right", Modifiers = { KEY_RSHIFT } },
			{ Command = "default.directional_right", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_UP] = {
			{ Command = "default.hazards" },
			{ Command = "default.scene_forward", Modifiers = { KEY_RSHIFT } },
			{ Command = "default.directional_center_out", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_DOWN] = {
			{ Command = "default.signal_off" },
			{ Command = "default.scene_off", Modifiers = { KEY_RSHIFT } },
			{ Command = "default.directional_off", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_1] = {
			{ Command = "default.toggle_siren_1" },
			{ Command = "default.toggle_siren2_1", Modifiers = { KEY_RALT } },
		},
		[KEY_2] = {
			{ Command = "default.toggle_siren_2" },
			{ Command = "default.toggle_siren2_2", Modifiers = { KEY_RALT } },
		},
		[KEY_3] = {
			{ Command = "default.toggle_siren_3" },
			{ Command = "default.toggle_siren2_3", Modifiers = { KEY_RALT } },
		},
		[KEY_4] = {
			{ Command = "default.toggle_siren_4" },
			{ Command = "default.toggle_siren2_4", Modifiers = { KEY_RALT } },
		}
	}
}


Photon2.ClientInput.RegisterCommand({
	Name = "controller_button_momentary",
	Title = "Momentary Controller Button",
	Description = "Plays controller button sounds as momentary press. Certain controllers will beep when a momentary button is released.",
	OnPress = { { Action = "SOUND", Value = "Controller" } },
	OnRelease = { { Action = "SOUND", Value = "Controller", Press = "Momentary" } },
})

Photon2.ClientInput.RegisterCommand({
	Name = "controller_button",
	Title = "Normal Controller Button",
	Description = "Plays normal controller button sound.",
	OnPress = { { Action = "SOUND", Value = "Controller" } },
	OnRelease = { { Action = "SOUND", Value = "Controller" } },
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_warning_lights",
	Title = "Toggle Warning Lights", 
	Category = "Emergency Lighting",
	Description = "When warning lights are off, turns them on to MODE2. When warning lights are on (any mode), turns them off.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Warning", Value = "MODE2" },
		{ Action = "OFF_WITH", Channel = "Emergency.Siren", Value = "Emergency.Warning" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.cycle_warning_lights",
	Title = "Cycle Warning Light Stage",
	Category = "Emergency Lighting",
	Description = "Turns on warning lights if off and cycles through MODE1, MODE2, and MODE3.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "CYCLE", Channel = "Emergency.Warning", Value = { "MODE1", "MODE2", "MODE3" } }
	},
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.manual_siren",
	Title = "Activate Manual Siren",
	Category = "Siren",
	Description = "Plays manual siren as long as key is pressed.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "SET", Channel = "Emergency.SirenOverride", Value = "MAN" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller", Press = "Momentary" },
		{ Action = "SET", Channel = "Emergency.SirenOverride", Value = "OFF" }
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.airhorn",
	Title = "Activate Airhorn",
	Category = "Siren",
	Description = "Plays airhorn as long as key is pressed.",
	OnPress = { { Action = "SOUND", Sound = "Controller" }, { Action = "SET", Channel = "Emergency.SirenOverride", Value = "AIR" } },
	OnRelease = { { Action = "SOUND", Sound = "Controller", Press = "Momentary" }, { Action = "SET", Channel = "Emergency.SirenOverride", Value = "OFF" } },
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.vehicle_lights",
	Title = "Vehicle Headlights/Parking Lights",
	Category = "Basic Vehicle Lighting",

	Description = "Quick press toggles headlights. Press and hold to toggle parking lights.",
	OnPress = { { Action = "SOUND", Sound = "Click" } },
	OnRelease = { { Action = "TOGGLE", Channel = "Vehicle.Lights", Value = "HEADLIGHTS" } },
	OnHold = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Lights", Value = "PARKING" }
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.left_signal",
	Title = "Left Signal",
	Category = "Basic Vehicle Lighting",
	Description = "Toggles left vehicle signal.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "LEFT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.right_signal",
	Title = "Right Signal",
	Category = "Basic Vehicle Lighting",
	Description = "Toggles right vehicle signal.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "RIGHT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.hazards",
	Title = "Hazard Lights",
	Category = "Basic Vehicle Lighting",
	Description = "Toggles hazard lights.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "HAZARD" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.signal_off",
	Title = "Turn Signal/Hazard Lights Off",
	Category = "Basic Vehicle Lighting",
	Description = "Turns off hazard and turn signal lights.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "OFF" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.directional_left",
	Title = "Left Directional",
	Category = "Traffic Advisor",
	Description = "Toggles left emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "LEFT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.directional_right",
	Title = "Right Directional",
	Category = "Traffic Advisor",
	Description = "Toggles right emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "RIGHT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.directional_center_out",
	Title = "Center-Out Directional",
	Category = "Traffic Advisor",
	Description = "Toggles center-out emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "CENOUT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.directional_off",
	Title = "Directional Off",
	Category = "Traffic Advisor",
	Description = "Turns off directional arrow.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "OFF" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.scene_left",
	Title = "Toggle Left Scene Lighting",
	Category = "Scene Lighting",
	Description = "Toggles scene lighting on the left side.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneLeft", Value = "ON" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.scene_right",
	Title = "Toggle Right Scene Lighting",
	Category = "Scene Lighting",
	Description = "Toggles scene lighting on the right side.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneRight", Value = "ON" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.scene_forward",
	Title = "Toggle Forward Scene Lighting",
	Category = "Scene Lighting",
	Description = "Toggles forward-facing scene lighting.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneForward", Value = "ON" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.scene_off",
	Title = "All Scene Lighting Off",
	Category = "Scene Lighting",
	Description = "Turns off all scene lighting.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneForward", Value = "OFF" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneLeft", Value = "OFF" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneRight", Value = "OFF" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren_1",
	Title = "Toggle Siren #1",
	Category = "Siren",
	Description = "Toggles siren #1 (T1).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren", Value = "T1" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren_2",
	Title = "Toggle Siren #2",
	Category = "Siren",
	Description = "Toggles siren tone #2 (T2).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren", Value = "T2" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren_3",
	Title = "Toggle Siren #3",
	Category = "Siren",
	Description = "Toggles siren tone #3 (T3).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren", Value = "T3" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren_4",
	Title = "Toggle Siren #4",
	Category = "Siren",
	Description = "Toggles siren tone #4 (T4).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren", Value = "T4" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren2_1",
	Title = "Toggle Secondary Siren #1",
	Category = "Siren",
	Description = "Toggles secondary siren tone #1 (T1).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T1" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren2_2",
	Title = "Toggle Secondary Siren #2",
	Category = "Siren",
	Description = "Toggles siren tone #2 (T2).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T2" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren2_3",
	Title = "Toggle Secondary Siren #3",
	Category = "Siren",
	Description = "Toggles secondary siren tone #3 (T3).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T3" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_siren2_4",
	Title = "Toggle Secondary Siren #4",
	Category = "Siren",
	Description = "Toggles secondary siren tone #4 (T4).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T4" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.activate_lights_siren",
	Title = "Activate Emergency Lights and Siren",
	Category = "Siren",
	Description = "Activates warning lights (MODE3) and toggles the siren (T1).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "SET", Channel = "Emergency.Warning", Value = "MODE3" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Siren", Value = "T1" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.ClientInput.RegisterCommand({
	Name = "default.toggle_cruise",
	Title = "Toggle Cruise Lights",
	Category = "Lights",
	Description = "Toggles cruise/marker lights ON or OFF.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Marker", Value = "ON" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.ClientInput.RegisterConfiguration( "prototype", prototypeInput )
Photon2.ClientInput.SetActiveConfiguration( "prototype" )

PrintTable( Photon2.ClientInput.Active )

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