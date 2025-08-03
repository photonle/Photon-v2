
Photon2.RegisterCommand({
	Author = "Photon",
	Name = "toggle_warning_lights",
	Title = "Warning Lights",
	Alt = "Emergency Lights",
	Category = "Emergency",
	Description = "When warning lights are off, turns them on to MODE2. When warning lights are on (any mode), turns them off.",
	OnPress = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" },
		-- If Emergency.Warning is OFF, it sets it to the second-to-last mode. 
		-- If Emergency.Warning is anything besides OFF (MODE1, MODE2, MODE3, etc.), it sets it to OFF.
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Warning", Value = 1, Query = "LAST_MINUS" },
		-- Sets Emergency.Siren to "OFF" if Emergency.Warning is also "OFF"
		{ Action = "OFF_WITH", Channel = "Emergency.Siren", Value = "Emergency.Warning" }
	},
	OnRelease = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "cycle_warning_lights",
	Title = "Warning Mode (Cycle)",
	Category = "Emergency",
	Description = "Turns on warning lights if off and cycles through MODE1, MODE2, and MODE3.",
	OnPress = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnRelease = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "CYCLE", Channel = "Emergency.Warning", Query = "NEXT" }
		-- { Action = "CYCLE", Channel = "Emergency.Warning", Value = { "MODE1", "MODE2", "MODE3" } }
	},
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "cycle_siren",
	Title = "Siren Tone",
	Category = "Siren",
	Description = "",
	OnPress = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnRelease = {
		-- Plays controller sound.
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "CYCLE", Channel = "Emergency.Siren", Query = "NEXT" }
	},
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "manual_siren",
	Title = "Manual Press",
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

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "airhorn",
	Title = "Airhorn Press",
	Category = "Siren",
	Description = "Plays airhorn as long as key is pressed.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" }, 
		{ Action = "SET", Channel = "Emergency.SirenOverride", Value = "AIR" } 
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller", Press = "Momentary" }, 
		{ Action = "SET", Channel = "Emergency.SirenOverride", Value = "OFF" } 
	},
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "vehicle_lights",
	Title = "Headlights/Parking",
	Category = "Basic",
	Description = "Quick press toggles headlights. Press and hold to toggle parking lights.",
	OnPress = { 
		{ Action = "SOUND", Sound = "Click" } 
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Lights", Value = "PARKING" }
	},
	OnRelease = { 
		{ Action = "TOGGLE", Channel = "Vehicle.Lights", Value = { "OFF", "HEADLIGHTS" } }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "vehicle_lights_cycle",
	Title = "Headlights/Parking (Cycle)",
	Category = "Basic",
	Description = "Cycles through parking lights, headlights, and then off.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "CYCLE", Channel = "Vehicle.Lights", Value = { "PARKING", "HEADLIGHTS", "OFF" } }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "vehicle_lights_auto",
	Category = "Basic",
	Title = "Headlights/Automatic",
	Description = "Sets automatic lighting. Enables daytime running lights and automatic headlights.",
	OnPress = { 
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "SET", Channel = "Vehicle.Lights", Value = "AUTO" },
	},
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "left_signal",
	Title = "Signal Left",
	Category = "Basic",
	Description = "Toggles left vehicle signal.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "LEFT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "right_signal",
	Title = "Signal Right",
	Category = "Basic",
	Description = "Toggles right vehicle signal.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "RIGHT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "hazards",
	Title = "Signal Hazards",
	Category = "Basic",
	Description = "Toggles hazard lights.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "HAZARD" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "signal_off",
	Title = "Signal Off",
	Category = "Basic",
	Description = "Turns off hazard and turn signal lights.",
	OnPress = {
		{ Action = "SOUND", Sound = "Click" },
		{ Action = "TOGGLE", Channel = "Vehicle.Signal", Value = "OFF" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Click" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "directional_left",
	Title = "Arrow Left",
	Category = "Directional",
	Description = "Toggles left emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "LEFT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "directional_right",
	Title = "Arrow Right",
	Category = "Directional",
	Description = "Toggles right emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "RIGHT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "directional_center_out",
	Title = "Arrow Center-Out",
	Category = "Directional",
	Description = "Toggles center-out emergency directional.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "CENOUT" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "directional_off",
	Title = "Arrow Off",
	Category = "Directional",
	Description = "Turns off directional arrow.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Directional", Value = "OFF" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "scene_left",
	Title = "Illuminate Left",
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

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "scene_right",
	Title = "Illuminate Right",
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

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "scene_forward",
	Title = "Illuminate Front",
	Category = "Scene Lighting",
	Description = "Toggles forward-facing scene lighting.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneForward", Value = "FLOOD" },
	},
	OnRelease = {
		{ Action = "TOGGLE", Channel = "Emergency.SceneForward", Value = "ON" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "scene_off",
	Title = "Illuminate Off",
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

local function generateSirenToggle( tone, siren, sirenLabel )
	local category = "Siren"
	local description = "Toggles siren tone #" .. tostring( tone ) .. "."
	if ( siren ) then
		category = category .. " #" .. tostring( siren )
	end
	if ( sirenLabel ) then
		description = "Toggles " .. sirenLabel .. " siren tone #" .. tostring( tone ) .. "."
	end
	siren = siren or ""
	sirenLabel = sirenLabel or ""
	tone = tostring( tone )
	return Photon2.RegisterCommand({
		Author = "Photon",
		Name = "toggle_siren" .. siren .. "_" .. tone,
		Title = "Tone " .. tone,
		Category = category,
		Description = description,
		OnPress = {
			{ Action = "SOUND", Sound = "Controller" },
			{ Action = "TOGGLE", Channel = "Emergency.Siren" .. siren, Value = "T" .. tone },
		},
		OnRelease = {
			{ Action = "SOUND", Sound = "Controller" },
		}
	})
end

-- Generates commands for siren tones 1-8
for i=1, 8 do 
	generateSirenToggle( i, nil, "main" )
	generateSirenToggle( i, "2", "secondary" )
end

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "activate_lights_siren",
	Title = "Siren",
	Alt = "Siren",
	Category = "Emergency",
	Description = "Activates warning lights (MODE3) and toggles the siren (T1).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "SET", Channel = "Emergency.Warning", Query = "LAST" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Siren", Value = "T1" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "toggle_cruise",
	Title = "Cruise Lights",
	Category = "Emergency",
	Description = "Toggles cruise/marker lights ON or OFF.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Marker", Value = "ON" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "toggle_warning_lights_m3",
	Title = "Warning Lights (MODE3)", 
	Category = "Emergency",
	Description = "When warning lights are off, turns them on to MODE3. When warning lights are on (any mode), turns them off.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Warning", Value = "MODE3" },
		{ Action = "OFF_WITH", Channel = "Emergency.Siren", Value = "Emergency.Warning" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "auxiliary_dual_toggle",
	Title = "Short/Long Press",
	Category = "Auxiliary",
	Description = "Quick press toggles MODE1, long press toggles MODE2.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Auxiliary", Value = "MODE2" }
	},
	OnRelease = {
		{ Action = "TOGGLE", Channel = "Emergency.Auxiliary", Value = "MODE1" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "cut_cycle",
	Title = "Cut Lighting (Cycle)",
	Category = "Emergency",
	Description = "Cycles through front/rear cut modes (disables lights that face each direction).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "CYCLE", Channel = "Emergency.Cut", Value = { "FRONT", "REAR", "OFF" } }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "cycle_hold_directional",
	Title = "Arrow (Cycle/Hold)",
	Category = "Directional",
	Description = "Press toggles lights on/off. Hold cycles through modes. Mimics Photon LE's behavior.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "CYCLE", Channel = "Emergency.Directional", Query = "NEXT" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Directional", Query = "FIRST" }
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "hold_warning_cycle_modes",
	Title = "Warning Lights (Hold/Cycle Modes)",
	Category = "Emergency",
	Description = "Long hold toggles lights on/off. If activated, quick press cycles through modes.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller", IfNot = { ["Emergency.Warning"] = "OFF" } },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Warning", Query = "FIRST" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller", IfNot = { ["Emergency.Warning"] = "OFF" } },
		{ Action = "ON_CYCLE", Channel = "Emergency.Warning", Query = "NEXT" },
	}
})

Photon2.RegisterCommand({
	Author = "Photon",
	Name = "hold_siren_cycle_tones",
	Title = "Siren (Hold/Cycle Tones)",
	Category = "Siren",
	Description = "Long hold toggles siren on/off. When activated, quick press cycles through tones.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller", IfNot = { ["Emergency.Siren"] = "OFF" } },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "OFF_TOGGLE", Channel = "Emergency.Siren", Query = "FIRST" }
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller", IfNot = { ["Emergency.Siren"] = "OFF" } },
		{ Action = "ON_CYCLE", Channel = "Emergency.Siren", Query = "NEXT" },
	}
})