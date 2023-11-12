Photon2.RegisterCommand({
	Name = "controller_button_momentary",
	Title = "Momentary Controller Button",
	Description = "Plays controller button sounds as momentary press. Certain controllers will beep when a momentary button is released.",
	OnPress = {
		{ Action = "SOUND", Value = "Controller" } 
	},
	OnRelease = {
		{ Action = "SOUND", Value = "Controller", Press = "Momentary" } 
	},
})

Photon2.RegisterCommand({
	Name = "controller_button",
	Title = "Normal Controller Button",
	Description = "Plays normal controller button sound.",
	OnPress = {
		{ Action = "SOUND", Value = "Controller" } 
	},
	OnRelease = {
		{ Action = "SOUND", Value = "Controller" } 
	},
})

Photon2.RegisterCommand({
	Name = "toggle_warning_lights",
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

Photon2.RegisterCommand({
	Name = "cycle_warning_lights",
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

Photon2.RegisterCommand({
	Name = "manual_siren",
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

Photon2.RegisterCommand({
	Name = "airhorn",
	Title = "Activate Airhorn",
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
	Title = "Vehicle Headlights/Parking Lights",
	Category = "Basic Vehicle Lighting",
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

Photon2.RegisterCommand({
	Name = "right_signal",
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

Photon2.RegisterCommand({
	Name = "hazards",
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

Photon2.RegisterCommand({
	Name = "signal_off",
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

Photon2.RegisterCommand({
	Name = "directional_left",
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

Photon2.RegisterCommand({
	Name = "directional_right",
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

Photon2.RegisterCommand({
	Name = "directional_center_out",
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

Photon2.RegisterCommand({
	Name = "directional_off",
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

Photon2.RegisterCommand({
	Name = "scene_left",
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

Photon2.RegisterCommand({
	Name = "scene_right",
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

Photon2.RegisterCommand({
	Name = "scene_forward",
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

Photon2.RegisterCommand({
	Name = "scene_off",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_1",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_2",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_3",
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

Photon2.RegisterCommand({
	Name = "toggle_siren_4",
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

Photon2.RegisterCommand({
	Name = "toggle_siren2_1",
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

Photon2.RegisterCommand({
	Name = "toggle_siren2_2",
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

Photon2.RegisterCommand({
	Name = "toggle_siren2_3",
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

Photon2.RegisterCommand({
	Name = "toggle_siren2_4",
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

Photon2.RegisterCommand({
	Name = "activate_lights_siren",
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

Photon2.RegisterCommand({
	Name = "toggle_cruise",
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
