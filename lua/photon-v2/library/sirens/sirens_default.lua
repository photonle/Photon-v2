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

Photon2.RegisterSiren(
	{
		Name = "code3_z3",
		Make = "Code 3",
		Model = "Z3",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/code3_z3/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/code3_z3/yelp.wav", 	Default = "T2" },
			["HYPER"] = { Sound = "photon/sirens/code3_z3/hyper_yelp_5.wav", 	Default = "T3" },
			["HILO"]  = { Sound = "photon/sirens/code3_z3/hilo.wav", Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/code3_z3/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/code3_z3/wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

-- ***************************
-- NOTE: DUAL TONE CONFIGURATION IS EXPERIMENTAL
-- 
-- THIS IMPLEMENTATION MAY CHANGE AT ANY TIME
--
-- USE EXTREME CAUTION IF PUBLISHING OTHER SIRENS THAT USE THIS,
-- AS THEY ARE LIKELY TO BREAK IN A FUTURE UPDATE
-- 
-- ***************************

Photon2.RegisterSiren(
	{
		Name = "sos_nergy400",
		Make = "SoundOff Signal",
		Model = "nErgy 400",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/sos_nergy400/wail.wav", 	Default = "T1" },
			["WAIL2"] = { Sound = "photon/sirens/sos_nergy400/wail_short.wav", 	Default = "TS1" },
			["YELP"] = { Sound = "photon/sirens/sos_nergy400/yelp.wav", 	Default = "T2" },
			-- Annoying clicking sound emerged when stretching the yelp, but luckily you can't tell
			-- when both yelps are playing
			["YELP2"] = { Sound = "photon/sirens/sos_nergy400/yelp_long.wav", 	Default = "TS2" },
			["PIERCER"] = { Sound = "photon/sirens/sos_nergy400/phaser.wav", Icon = "bolt",	Default = "T3", Label = "PRTY" },
			["SUPER_HILO"] = { Sound = "photon/sirens/sos_nergy400/super_hilo.wav", Default = "TS3", Label = "S-HILO", Icon = "hilo" },
			["HILO"] = { Sound = "photon/sirens/sos_nergy400/hilo.wav", 	Default = "T4" },
			["ALERT"] = { Sound = "photon/sirens/sos_nergy400/alert.wav", Default = "TS4", Label = "ALRT", Icon = "bolt" },
			
			["AIRHORN"]  = { Sound = "photon/sirens/sos_nergy400/airhorn.wav", Default = "AIR", Label = "AIR" },
			["AIRHORN2"]  = { Sound = "photon/sirens/sos_nergy400/phaser.wav", Default = "SAIR" },
			["MANUAL"]  = { Sound = "photon/sirens/sos_nergy400/wail.wav", 	Default = "MAN", Label = "MAN" },
			["PCALL"] = { Sound = "photon/sirens/sos_nergy400/pcall.wav", 	icon = "pcall" },
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
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_ss/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/whelen_gamma/wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "whelen_epsilon",
		Make = "Whelen",
		Model = "Epsilon",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/whelen_epsilon/wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/whelen_epsilon/yelp.wav", 	Default = "T2" },
			["PIERCER"] = { Sound = "photon/sirens/whelen_epsilon/piercer.wav", Icon = "bolt",	Default = "T3", Label = "PIER" },
			["HILO"] = { Sound = "photon/sirens/whelen_epsilon/hilo.wav", 	Default = "T4" },
			["WARB"] = { Sound = "photon/sirens/whelen_epsilon/warble.wav", 	Default = "T5" },
			["WOOP"] = { Sound = "photon/sirens/whelen_epsilon/woop.wav", 	Default = "T6" },
			["WAIL_ALT"] = { Sound = "photon/sirens/whelen_epsilon/wail_alt.wav", Label = "ALT W",	Default = "T7" },
			["YELP_ALT"] = { Sound = "photon/sirens/whelen_epsilon/yelp_alt.wav", Label = "ALT Y",	Default = "T8" },
			["AIRHORN"]  = { Sound = "photon/sirens/whelen_epsilon/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/whelen_epsilon/wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "whelen_epsilon_alt",
		Make = "Whelen",
		Model = "Epsilon (Alternate)",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/whelen_epsilon/wail_alt.wav", Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/whelen_epsilon/yelp_alt.wav", Default = "T2" },
			["PIERCER"] = { Sound = "photon/sirens/whelen_epsilon/piercer.wav", Icon = "bolt",	Default = "T3", Label = "PIER" },
			["HILO"] = { Sound = "photon/sirens/whelen_epsilon/hilo.wav", 	Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/whelen_epsilon/airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/whelen_epsilon/wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)

Photon2.RegisterSiren(
	{
		Name = "fedsig_pathfinder_ssp",
		Make = "Federal Signal",
		Model = "PathFinder SSP",
		Author = "Schmal",
		Sounds = {
			["WAIL"] = { Sound = "photon/sirens/fedsig_pathfinder/ssp_wail.wav", 	Default = "T1" },
			["YELP"] = { Sound = "photon/sirens/fedsig_pathfinder/ssp_yelp.wav", 	Default = "T2" },
			["PRIORITY"] = { Sound = "photon/sirens/fedsig_pathfinder/ssp_priority.wav", Icon = "bolt",	Default = "T3", Label = "PRTY" },
			["HILO"] = { Sound = "photon/sirens/fedsig_pathfinder/ssp_hilo.wav", 	Default = "T4" },
			["AIRHORN"]  = { Sound = "photon/sirens/fedsig_pathfinder/ssp_airhorn.wav", Default = "AIR", Label = "AIR" },
			["MANUAL"]  = { Sound = "photon/sirens/fedsig_pathfinder/ssp_wail.wav", 	Default = "MAN", Label = "MAN" },
		}
	}
)