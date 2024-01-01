Photon2.RegisterSiren(
	{
		Name = "fedsig_touchmaster_delta",
		Make = "Federal Signal",
		Model = "Touchmaster Delta",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/fedsig_td/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_td/yelp.wav", 	Default = "T2" },
			["SCAN"] = { Sound = "photon/sirens/fedsig_td/scan.wav", Icon = "hilo",	Default = "T3" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_td/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_td/manual.wav", 	Default = "MAN", Label = "MAN" },
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
			["PRIORITY"] = { Sound = "photon/sirens/fedsig_ss/priority.wav", Icon = "bolt",	Default = "T3", Label = "PRTY" },
			["HILO"] = { Sound = "photon/sirens/fedsig_ss/hilo.wav", 	Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_ss/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_ss/manual.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "fedsig_omega90",
		Make = "Federal Signal",
		Model = "Omega 90",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/fedsig_omega90/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_omega90/yelp.wav", 	Default = "T2" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_omega90/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_omega90/manual.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

-- SMART SIREN TONES USED TO FILL IN BECAUSE I AM OUT OF TIME

Photon2.RegisterSiren(
	{
		Name = "sos_nergy400",
		Make = "SoundOff Signal",
		Model = "nErgy 400",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/sos_nergy400/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_ss/yelp.wav", 	Default = "T2" },
			["PRIORITY"] = { Sound = "photon/sirens/fedsig_ss/priority.wav", Icon = "bolt",	Default = "T3", Label = "PRTY" },
			["HILO"] = { Sound = "photon/sirens/fedsig_ss/hilo.wav", 	Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_ss/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_ss/manual.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "whelen_gamma",
		Make = "Whelen",
		Model = "Gamma",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/whelen_gamma/wail_alt.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/whelen_gamma/yelp.wav", 	Default = "T2" },
			["PIERCER"] = { Sound = "photon/sirens/whelen_gamma/piercer.wav", Icon = "bolt",	Default = "T3", Label = "PIER" },
			-- ["HILO"] = { Sound = "photon/sirens/fedsig_ss/hilo.wav", 	Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_ss/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/whelen_gamma/wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)