Photon2.ClientInput = Photon2.ClientInput or {
	Configurations = {}
}


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
			Allows for 
--]]

PHOTON2_ACT_TOGGLE_OFF 	= 1
PHOTON2_ACT_TOGGLE 		= 2
PHOTON2_ACT_SET 		= 3
PHOTON2_ACT_CYCLE		= 4

local holdThreshold = 1

local prototypeInput = {
	[KEY_F] = {
		OnRelease = {
			{ Action = PHOTON2_ACT_TOGGLE_OFF, Channel = "Emergency.Warning", Value = "MODE3" }
		}
	},
	[KEY_LALT] = {
		Name = "Warning Light Stage",
		OnRelease = {
			{ Action = PHOTON2_ACT_CYCLE, Channel = "Emergency.Warning", Value = { "OFF", "MODE1", "MODE2", "MODE3" } }
		},
		OnHold = {
			{ Action = PHOTON2_ACT_CYCLE, Channel = "Emergency.Warning", Value = { "OFF", "MODE1", "MODE2", "MODE3" } }
		}
	},
	[KEY_R] = {
		Name = "Lights & Sirens",
		Toggle = true,
		OnRelease = {
			{ Channel = "Emergency.Siren1", Toggle = "OFF" }, -- undefined Set should revert to saved value or 1,
			{ Channel = "Emergency.Warning", Set = "MODE3", Toggle = "OFF" }
		}
	},
	[KEY_1] = {
		Modifiers ={
			[KEY_RCONTROL] = {
				OnRelease = { Action = "TOGGLE", Channel = "Emergency.Siren2", Set = "2", Toggle = true }
			}
		},
		OnPress = {
			{ Action = "TOGGLE", Channel = "Emergency.Siren1", Set = "1", Toggle = true }
		}
	},
	[KEY_2] = {
		OnPress = {
			{ Channel = "Emergency.Siren1", Set = "2", Toggle = true }
		}
	}
}

PHOTON2_INPUT_STATE = PHOTON2_INPUT_STATE or {
	Watched = {},
	Pressed = {},
	Held = {}
}

local function inputScan( configuration )
	local result = {
		-- Held = {},
		-- Pressed = {},
		-- Released = {}
	}

	for key, _ in pairs(PHOTON2_INPUT_STATE.Pressed) do
		if ( not input.IsKeyDown( key ) ) then
			print("Bound key " .. tostring( input.GetKeyName(key) ) .. " was RELEASED. Held for " .. ( RealTime() - PHOTON2_INPUT_STATE.Pressed[key] ) .. " seconds.")
			result.Released = configuration.OnRelease
			PHOTON2_INPUT_STATE.Pressed[key] = nil
			PHOTON2_INPUT_STATE.Held[key] = nil
		end
	end
	
	for key, config in pairs( configuration ) do
		
		if ( input.IsKeyDown(key) ) then
			
			local result

			if ( config.Modifiers ) then
				result = inputScan( config.Modifiers )
			end
			
			if ( not PHOTON2_INPUT_STATE.Pressed[key] ) then
				print("Bound key " .. tostring( input.GetKeyName(key) ) .. " was PRESSED.")
				PHOTON2_INPUT_STATE.Pressed[key] = RealTime()
			end
		
			if ( not PHOTON2_INPUT_STATE.Held[key] ) then
	
				-- if ( config.OnHold and ( not PHOTON2_INPUT_STATE.Held[key] ) ) then
				if ( RealTime() >= ( PHOTON2_INPUT_STATE.Pressed[key] + holdThreshold ) ) then
					print("Bound key " .. tostring( input.GetKeyName(key) ) .. " was HELD.")
					PHOTON2_INPUT_STATE.Held[key] = RealTime()
				end
	
			end
	
		end
	
	end


	return result
end
hook.Add( "Think", "Photon2.Input:SCAN", function()
	inputScan( prototypeInput )
end)