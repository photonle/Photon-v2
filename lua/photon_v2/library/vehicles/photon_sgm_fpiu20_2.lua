if (Photon2.ReloadVehicle("photon_sgm_fpiu20_2")) then return end

VEHICLE.Base = "photon_sgm_fpiu20"

VEHICLE.Equipment = {
	["fedsig_solaris"] = {
		Position = Vector(0, -50, 100)
	}
}