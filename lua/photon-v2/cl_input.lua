Photon2.ClientInput = Photon2.ClientInput or {
	Configurations = {}
}

local prototypeInput = {
	["F"] = {
		OnPress = {
			{ Channel = "Emergency.Warning", Toggle = true }
		}
	},
	["R"] = {
		Name = "Lights & Sirens",
		Toggle = true,
		OnRelease = {
			{ Channel = "Emergency.Siren1", Toggle = "OFF" }, -- undefined Set should rever to saved value or 1,
			{ Channel = "Emergency.Warning", Set = "MODE3", Toggle = "OFF" }
		}
	},
	["1"] = {
		OnPress = {
			{ Channel = "Emergency.Siren1", Set = "1", Toggle = true }
		}
	},
	["2"] = {
		OnPress = {
			{ Channel = "Emergency.Siren1", Set = "2", Toggle = true }
		}
	}
	
}