include("sh_init.lua")
include("sv_net.lua")

include("sh_library.lua")
include("sh_index.lua")

print("sv_init.lua")

Photon2.OnVehicleCreated = function( ent )
	if not IsValid( ent ) then return end
	if not ent:IsVehicle() then return end
	-- CONCEPT CODE
		-- for id, veh in pairs(Photon2.Library.Vehicles) do

		-- end
	-- 
	timer.Simple(.01, function()
		Photon2.Debug.Print("Detected a spawned vehicle: " .. tostring(ent))	
		Photon2.AddControllerToVehicle( ent, {} )
	end)
	//if not (ent:IsValidVehicle()) then return end
end
hook.Add("OnEntityCreated", "Photon2:OnVehicleCreated", Photon2.OnVehicleCreated)

function Photon2.AddControllerToVehicle( vehicle, params )
	local controller = Photon2.CreateController(params)
	
	controller:SetParent( vehicle )
	controller:Initialize()
	controller:SetLocalPos((Vector(0, 0, 50)))
	controller:SetLocalAngles(Angle(0, -90, 0))
end

function Photon2.CreateController( params )
	local ent = ents.Create("photon_controller")

	return ent
end