local default = {
	Name = "default",
	Title = "Default",
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
			{ Command = "vehicle_lights" },
			{ Command = "vehicle_lights_auto", Modifiers = { KEY_RALT } }
		},
		[KEY_N] = {
			{ Command = "auxiliary_dual_toggle" }
		},
		[KEY_M] = {
			{ Command = "toggle_cruise" }
		},
		[KEY_DELETE] = {
			{ Command = "cut_cycle" }
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
}

Photon2.RegisterInputConfiguration( default )

Photon2.RegisterInputConfiguration({
	Name = "m3_override",
	Inherit = "default",
	Title = "Always Use MODE3",
	Author = "Photon",
	Binds = {
		[KEY_F] = {
			{ Command = "toggle_warning_lights_m3" }
		},
	}
})

Photon2.RegisterInputConfiguration({
	Name = "default_alt",
	Title = "Default (Alternate)",
	Author = "Photon",
	Binds = {
		-- A blank table entry prevents the key from being inherited
		-- [KEY_F] = {},
		-- [KEY_H] = {},
		-- [KEY_R] = {},
		-- [MOUSE_LEFT] = {},
		-- [MOUSE_RIGHT] = {},
		-- [KEY_LALT] = {},
		-- These are commented out because this entry doesn't inherit.
		[KEY_G] = {
			{ Command = "activate_lights_siren" }
		},
		[KEY_J] = {
			{ Command = "toggle_warning_lights" }
		},
		[KEY_K] = {
			{ Command = "cycle_warning_lights" }
		},
		[KEY_T] = {
			{ Command = "manual_siren" }
		},
		[KEY_Y] = {
			{ Command = "airhorn" }
		},
		[KEY_L] = {
			{ Command = "vehicle_lights" } 
		},
		[KEY_N] = {
			{ Command = "auxiliary_dual_toggle" }
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
	Name = "photon_classic",
	Inherit = "default",
	Title = "Classic (Photon LE)",
	Author = "Photon",
	Binds = {
		[KEY_T] = {
			{ Command = "manual_siren" }
		},
		[MOUSE_RIGHT] = {
			{ Command = "cycle_siren" }
		},
	}
})

-- if SERVER then return end
-- SetClipboardText( Photon2.ClientInput.ExportProfileToJson("default") )

-- Photon2.RegisterInputConfiguration({
-- 	Name = "default_override",
-- 	Inherit = "default",
-- 	Title = "Override Test B",
-- 	Author = "Photon",
-- 	Binds = {
-- 		[KEY_M] = {
-- 			{ Command = "manual_siren" }
-- 		}
-- 	}
-- })

-- Photon2.RegisterInputConfiguration({
-- 	Name = "default_c",
-- 	Inherit = "default_override",
-- 	Title = "Override Test C",
-- 	Author = "Photon",
-- 	Binds = {
-- 		[KEY_5] = {
-- 			{ Command = "toggle_siren_1" }
-- 		}
-- 	}
-- })
