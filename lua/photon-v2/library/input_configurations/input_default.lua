Photon2.RegisterInputConfiguration({
	Name = "default",
	Title = "Default Input Profile",
	Author = "Photon",
	Binds = {
		[KEY_F] = { 
			{ Command = "toggle_warning_lights" } 
		},
		[KEY_LALT] = { 
			{ Command = "cycle_warning_lights" } 
		},
		[KEY_R] = {
			{ Command = "activate_lights_siren"}
		},
		[MOUSE_LEFT] = { 
			{ Command = "airhorn" } 
		},
		[MOUSE_RIGHT] = { 
			{ Command = "manual_siren" } 
		},
		[KEY_H] = { 
			{ Command = "vehicle_lights" } 
		},
		[KEY_M] = {
			{ Command = "toggle_cruise" }
		},
		[KEY_LEFT] = {
			{ Command = "left_signal" },
			{ Command = "scene_left", Modifiers = { KEY_RSHIFT } },
			{ Command = "directional_left", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_RIGHT] = {
			{ Command = "right_signal" },
			{ Command = "scene_right", Modifiers = { KEY_RSHIFT } },
			{ Command = "directional_right", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_UP] = {
			{ Command = "hazards" },
			{ Command = "scene_forward", Modifiers = { KEY_RSHIFT } },
			{ Command = "directional_center_out", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_DOWN] = {
			{ Command = "signal_off" },
			{ Command = "scene_off", Modifiers = { KEY_RSHIFT } },
			{ Command = "directional_off", Modifiers = { KEY_RCONTROL } },
		},
		[KEY_1] = {
			{ Command = "toggle_siren_1" },
			{ Command = "toggle_siren2_1", Modifiers = { KEY_RALT } },
		},
		[KEY_2] = {
			{ Command = "toggle_siren_2" },
			{ Command = "toggle_siren2_2", Modifiers = { KEY_RALT } },
		},
		[KEY_3] = {
			{ Command = "toggle_siren_3" },
			{ Command = "toggle_siren2_3", Modifiers = { KEY_RALT } },
		},
		[KEY_4] = {
			{ Command = "toggle_siren_4" },
			{ Command = "toggle_siren2_4", Modifiers = { KEY_RALT } },
		}
	}
})

Photon2.RegisterInputConfiguration({
	Name = "default_override",
	Inherit = "default",
	Title = "Override Test",
	Author = "Photon",
	Binds = {
		[KEY_M] = {
			{ Command = "manual_siren" }
		}
	}
})

Photon2.RegisterInputConfiguration({
	Name = "default_c",
	Inherit = "default_override",
	Title = "Override Test",
	Author = "Photon",
	Binds = {
		[KEY_5] = {
			{ Command = "toggle_siren_1" }
		}
	}
})

-- Photon2.Index.CompileInputConfigurationFromLibrary( "default_c" )