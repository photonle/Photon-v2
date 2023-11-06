Photon2.RegisterSiren(
	{
		Name = "fedsig_touchmaster_delta",
		Make = "Federal Signal",
		Model = "Touchmaster Delta",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/fedsig_td/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_td/yelp.wav", 	Default = "T2" },
			["SCAN"] = { Sound = "photon/sirens/fedsig_td/scan.wav", 	Default = "T3" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_td/airhorn.wav", Default = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_td/manual.wav", 	Default = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "fedsig_smartsiren",
		Make = "Federal Signal",
		Model = "SmartSiren",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/fedsig_ss/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_ss/yelp.wav", 	Default = "T2" },
			["PRIORITY"] = { Sound = "photon/sirens/fedsig_ss/priority.wav", 	Default = "T3", Label = "PRTY" },
			["HILO"] = { Sound = "photon/sirens/fedsig_ss/hilo.wav", 	Default = "T4", Label = "PRTY" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_ss/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_ss/manual.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)