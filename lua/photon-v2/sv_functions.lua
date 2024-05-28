local saveSteeringOnExit = true

local CurTime = CurTime
local info, warn, warn_once = Photon2.Debug.Declare( "SERVER" )

local globalEngineIdleEnabled = GetConVar( "ph2_engine_idle_enabled" )

local holdDuration = 0.2

local vehicleEntryPause = {}
local activeUseHeld = {}

---@param ply Player
---@param ucmd any
function Photon2.OnStartCommand( ply, ucmd )
	-- Handles the quick/long press of E for the enging idle feature
	if ( not globalEngineIdleEnabled:GetBool() ) then return end
	if ( IsValid( ply ) and IsValid( ply:GetVehicle() ) and ( ply:GetVehicle().PhotonEngineIdleEnabled ) ) then
		if ( ucmd:KeyDown( IN_USE ) ) then
			if ( not vehicleEntryPause[ply] ) then
				activeUseHeld[ply] = activeUseHeld[ply] or CurTime()
				if ( activeUseHeld[ply] + holdDuration > CurTime() ) then
					ucmd:RemoveKey( IN_USE )
				else
					ply:GetVehicle().PhotonEngineIdleOff = true
					ply.PhotonEngineIdleExit = activeUseHeld[ply]
					activeUseHeld[ply] = nil
				end
			end
		else
			if ( vehicleEntryPause[ply] ) then
				vehicleEntryPause[ply] = nil
			elseif ( activeUseHeld[ply] ) then
				ucmd:AddKey( IN_USE )
				ply.PhotonEngineIdleExit = activeUseHeld[ply]
				activeUseHeld[ply] = nil
			end
		end
	end
end
hook.Add( "StartCommand", "Photon2:StartCommand", Photon2.OnStartCommand )


---@param ply Entity
---@param vehicle Vehicle
---@param role any
function Photon2.OnPlayerEnteredVehicle( ply, vehicle, role )

	if ( vehicle.PhotonEngineIdleEnabled ) then
		vehicleEntryPause[ply] = true
		vehicle.PhotonEngineIdleOff = nil
	end

	local controller = vehicle:GetPhotonControllerFromAncestor() --[[@as sv_PhotonController]]
	if ( not IsValid( controller ) ) then return end
	
	if ( controller.IsLinkedToStandardVehicle and ( vehicle:GetPhotonController() == controller ) and ( vehicle:GetDriver() == ply ) ) then
		controller:PlayerEnteredLinkedVehicle( ply, vehicle, role )
	elseif ( not controller.IsLinkedToStandardVehicle ) then
		controller:PlayerEnteredLinkedVehicle( ply, vehicle, role )
	end

end
hook.Add( "PlayerEnteredVehicle", "Photon2:OnPlayerEnteredVehicle", Photon2.OnPlayerEnteredVehicle )

function Photon2.OnPlayerLeaveVehicle( ply, vehicle )
	local controller = vehicle:GetPhotonControllerFromAncestor()
	if ( IsValid( controller ) ) then
		if ( controller.IsLinkedToStandardVehicle ) then
			if ( vehicle:GetPhotonController() == controller ) then
				vehicle:GetPhotonControllerFromAncestor():PlayerExitedLinkedVehicle( ply, vehicle )
			end
		else
			vehicle:GetPhotonControllerFromAncestor():PlayerExitedLinkedVehicle( ply, vehicle )
		end
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


local lastModelAttachScanTime = 0
local modelAttachScanRate = 1

-- For compatability with SGM's model attachment framework
function Photon2.ModelAttachBridgeScan()
	if ( not ( SGM and SGM.AttachedModels ) ) then return end
	if ( CurTime() < ( lastModelAttachScanTime + modelAttachScanRate) ) then return end
	for k, ent in pairs( SGM.AttachedModels ) do
		if ( not ( ent.SyncSubMaterials or ent.Sync ) ) then continue end
		if ( ent:GetNW2Bool( "Photon2.SyncSubMaterials" ) ) then continue end
		if not ( IsValid( ent:GetParent() ) and IsValid( ent:GetParent():GetPhotonController() ) ) then return end
		ent:SetNW2Bool( "Photon2.SyncSubMaterials", true )
	end
	lastModelAttachScanTime = CurTime()
end
hook.Add( "Think", "Photon2:ModelAttachBridgeScan", Photon2.ModelAttachBridgeScan )


function Photon2.OnPlayerSetServerConVar( ply, cmd, args )
	-- Internal permission check
	-- print( "Player [" .. ply:Nick() .. "] is attempting to set cvar: [" .. args[1] .. "] to [" .. args[2] .. "]" )
	local result = hook.Run( "Photon2.Permissions:SetServerConVar", ply, args[1] )
	if ( result ~= nil ) and ( not result ) then 
		-- print( "\tBlocked by Photon2.Permissions:SetServerConVar.")
		return
	end

	if ( not CAMI.PlayerHasAccess( ply, "Photon2.ServerSettings" ) ) then 
		-- print( "\tBlocked by CAMI.ServerSettings")
		return
	end
	info( "Player " .. ply:Nick() .. " (" .. ply:SteamID() .. ") set cvar: [" .. args[1] .. "] to [" .. args[2] .. "]" )
	local actualValue = GetConVar( args[1] ):GetString()
	RunConsoleCommand( args[1], args[2] )
end
concommand.Add( "ph2_set_cvar", Photon2.OnPlayerSetServerConVar )