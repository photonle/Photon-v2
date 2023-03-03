if (exmeta.ReloadFile("photon_v2/meta/sh_base_vehicle.lua")) then return end

NAME = "photon_base_vehicle"

local Vehicle = META

-- Specifies the actual controller entity class to create when the vehicle is created.
-- Override if using your own modified controller entity.
Vehicle.ControllerType = "photon_controller"
