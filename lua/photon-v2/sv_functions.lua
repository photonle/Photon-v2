print("sv_functions.lua")

local saveSteeringOnExit = true

-- local ENT = FindMetaTable( "Entity" )

-- if not ENT._oldSetKeyValue then
-- 	ENT._oldSetKeyValue = ENT.SetKeyValue
-- 	ENT.SetKeyValue = function( self, key, value )
-- 		print("SETTING KEY VALUE " .. tostring(key) .. ": " .. tostring(value))
-- 		if (key == "vehiclename") then
-- 			self["@vehiclename"] = value
-- 			return
-- 		end
-- 		self:_oldSetKeyValue( key, value )
-- 	end
-- end

-- Workaround function. Modifies vehicle list KeyValues to store vehicle ID in "puntsound" property.
function Photon2.RunVehicleListModification()
	-- For addons that spawn vehicles without explicitly setting the .VehicleName property,
	-- the vehicle index will be stored as internal value "puntsound" if the spawning code iterates 
	-- over KeyValues to set each of them (which it likely does). Photon 2 will then detect this
	-- automatically and set the .VehicleName on its own, before then resetting the internal value.
	--
	-- The "puntsound" variable is used because it stores as a string and is generally unused.
	--
	local vehicles = list.Get( "Vehicles" ) --[[@as table]]
	for key, vehicle in pairs( vehicles ) do
		list.GetForEdit( "Vehicles" )[key]["KeyValues"]["vehiclename"] = key
	end
end
-- hook.Add( "Initialize", "Photon2:RunVehicleListModification", Photon2.RunVehicleListModification )
-- hook.Add( "InitPostEntity", "Photon2:RunVehicleListModification", Photon2.RunVehicleListModification )

-- Photon2.RunVehicleListModification()

function Photon2.OnPlayerEnteredVehicle( ply, vehicle, role )
	-- local target = vehicle
	-- if ( vehicle:IsPhoton2Seat() )
	if ( IsValid( vehicle:GetPhotonControllerFromAncestor() ) ) then
		vehicle:GetPhotonControllerFromAncestor():PlayerEnteredLinkedVehicle( ply, vehicle, role )
	end
end
hook.Add( "PlayerEnteredVehicle", "Photon2:OnPlayerEnteredVehicle", Photon2.OnPlayerEnteredVehicle )

function Photon2.OnPlayerLeaveVehicle( ply, vehicle )
	if ( IsValid( vehicle:GetPhotonControllerFromAncestor() ) ) then
		vehicle:GetPhotonControllerFromAncestor():PlayerExitedLinkedVehicle( ply, vehicle )
	end
	
	Photon2.sv_Network.NotifyPlayerInputController( ply, nil )

	-- TODO: needs to account for custom vehicle bases
	if ( saveSteeringOnExit ) then
		local steering = vehicle:GetSteeringDegrees() * vehicle:GetSteering()
		local increment = 1
		if ( steering < 0 ) then increment = increment * -1; steering = steering * -1 end
		for i=1,math.Round(steering) do
			vehicle:Fire( "steer", increment )
		end
	end

end
hook.Add( "PlayerLeaveVehicle", "Photon2:OnPlayerLeaveVehicle", Photon2.OnPlayerLeaveVehicle )

function Photon2.OnVehicleMove( ply, vehicle, moveData )
	if ( IsValid( vehicle:GetPhotonController() ) ) then
		vehicle:GetPhotonController():UpdateVehicleParameters( ply, vehicle, moveData )
	end
	-- print(vehicle:GetSteering())
end
hook.Add( "VehicleMove", "Photon2:OnVehicleMove", Photon2.OnVehicleMove )