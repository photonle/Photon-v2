Photon2.RegisterInteractionSound({
	Class = "Click",
	Name = "default",
	Title = "Default",
	Default = {
		Sound = "photon/generic/click1.wav",
		Duration = 0.025,
		Volume = 50
	},
	Press = true,
	Release = true,
	Momentary = true
})

Photon2.RegisterInteractionSound({
	Class = "Controller",
	Name = "fedsig",
	Title = "Federal Signal",
	Default = { 
		Sound = "photon/controllers/fedsig_ssp_chirp.wav",
		Volume = 50,
	},
	Release = false,
	Momentary = true
})

Photon2.RegisterInteractionSound({
	Class = "Controller",
	Name = "code3_z3s",
	Default = { 
		Sound = "photon/controllers/code3_z3s_chirp.wav", 
		Volume = 50, -- default: 100
		Duration = 0.1, -- default: 0.1 -- specified to prevent undesired sound overlapping
		Pitch = 100 -- default: 100
	},
	Press = true,
	Release = false,
	Momentary = false,
	Hold = true
})

Photon2.RegisterInteractionSound({
	Class = "Controller",
	Name = "whelen_cencom",
	Title = "Whelen CenCom",
	Default = { 
		Sound = "photon/controllers/whelen_cencom_click.wav",
		Duration = 0.02
	},
	Release = true,
	Momentary = true
})

Photon2.RegisterInteractionSound({
	Class = "Controller",
	Name = "sos_nergy",
	Default = { 
		Sound = "photon/controllers/sos_nergy_chirp.wav", 
		Volume = 50, -- default: 100
		Duration = 0.1, -- default: 0.1 -- specified to prevent undesired sound overlapping
		Pitch = 100 -- default: 100
	},
	Press = true,
	Release = false,
	Momentary = false,
	Hold = true
})