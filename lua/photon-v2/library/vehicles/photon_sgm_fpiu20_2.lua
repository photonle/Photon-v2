if (Photon2.ReloadVehicleFile()) then return end;
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Base = "photon_sgm_fpiu20"

VEHICLE.Equipment = {
	["fedsig_solaris"] = {
		Position = Vector(0, -50, 100)
	}
}

-- Slot-based concept
-- VEHICLE.Equipment = {
--	Configurable = true,
-- 	["Lightbar"] = {
-- 		["Federal Signal JetSolaris"] = {
-- 			["fedsig_solaris"] = {
-- 				Type = "Component",
-- 				Component = "photon_fedsig_jetsolaris",
-- 				Position = Vector(0, 0, 100),
-- 				Angles = Angle(0, 0, 0)
-- 			}
-- 		}
-- 	}
-- }