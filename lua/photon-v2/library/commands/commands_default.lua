
Photon2.RegisterCommand({
	Name = "toggle_warning_lights",
	Title = "Lights On/Off",
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
	Name = "cycle_warning_lights",
	Title = "Light Mode",
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
		{ Action = "TOGGLE", Channel = "Vehicle.Lights", Value = "HEADLIGHTS" } 
	}
})

Photon2.RegisterCommand({
	Name = "left_signal",
	Title = "Turn Left",
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
	Name = "right_signal",
	Title = "Turn Right",
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
	Name = "hazards",
	Title = "Hazards",
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
	Name = "signal_off",
	Title = "Signal/Hazards Off",
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
	Name = "directional_center_out",
	Title = "Center-Out",
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
	Name = "directional_off",
	Title = "Off",
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
	Name = "scene_forward",
	Title = "Illuminate Front",
	Category = "Scene Lighting",
	Description = "Toggles forward-facing scene lighting.",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.SceneForward", Value = "ON" },
	},
	OnHold = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "SET", Channel = "Emergency.SceneForward", Value = "FLOOD" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Name = "scene_off",
	Title = "Turn Off All",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_1",
	Title = "Tone 1",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_2",
	Title = "Tone 2",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_3",
	Title = "Tone 3",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_4",
	Title = "Tone 4",
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

Photon2.RegisterCommand({
	Name = "toggle_siren2_1",
	Title = "Tone 1",
	Category = "Siren #2",
	Description = "Toggles secondary siren tone #1 (T1).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T1" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Name = "toggle_siren2_2",
	Title = "Tone 2",
	Category = "Siren #2",
	Description = "Toggles siren tone #2 (T2).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T2" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Name = "toggle_siren2_3",
	Title = "Tone 3",
	Category = "Siren #2",
	Description = "Toggles secondary siren tone #3 (T3).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T3" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Name = "toggle_siren2_4",
	Title = "Tone 4",
	Category = "Siren #2",
	Description = "Toggles secondary siren tone #4 (T4).",
	OnPress = {
		{ Action = "SOUND", Sound = "Controller" },
		{ Action = "TOGGLE", Channel = "Emergency.Siren2", Value = "T4" },
	},
	OnRelease = {
		{ Action = "SOUND", Sound = "Controller" },
	}
})

Photon2.RegisterCommand({
	Name = "activate_lights_siren",
	Title = "Siren On/Off",
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
	Name = "toggle_cruise",
	Title = "Cruise On/Off",
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
	Name = "toggle_warning_lights_m3",
	Title = "Lights (MODE3) On/Off", 
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
	Name = "auxiliary_dual_toggle",
	Title = "1-2 Toggle",
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