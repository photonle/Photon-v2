if (Photon2.ReloadVehicle("photon_sgm_fpiu20")) then return end

VEHICLE.Model = "models/sentry/20fpiu_new.mdl"

VEHICLE.Entity = "prop_vehicle_jeep"
VEHICLE.Target = "20fpiu_new_sgm"

-- Slot-based concept
-- VEHICLE.Equipment = {
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

-- Static-based concept with decreased verbosity
VEHICLE.Equipment = {
	["fedsig_solaris"] = {
		Component = "photon_fedsig_jetsolaris",
		Position = Vector(0, 0, 100),
		Angles = Angle(0, 0, 0)
	}
}
-- assess possibility of combining static equipment
-- with slotted options (?)
