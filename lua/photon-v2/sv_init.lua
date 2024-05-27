Photon2.ServerConVars = Photon2.ServerConVars or {}

function Photon2.OnServerConVarUpdate( name, oldValue, newValue )
	print( "Server ConVar updated: [" .. name .. "] " .. oldValue .. " => " .. newValue )
	Photon2.sv_Network.NotifyConVarUpdate( name, oldValue, newValue )
end

function Photon2.CreateServerConVar( name, default, flags, helpText, min, max )
	local convar = CreateConVar( name, default, flags, helpText, min, max )
	Photon2.ServerConVars[name] = convar
	if ( convar:IsFlagSet( FCVAR_REPLICATED ) ) then
		cvars.AddChangeCallback( name, Photon2.OnServerConVarUpdate, "Photon2.CVar" )
	end
	return convar
end

include("sh_init.lua")
include("sv_net.lua")

include("sh_component_builder.lua")
include("sh_library.lua")
include("sh_index.lua")

include("sh_ent_meta.lua")
include("sv_functions.lua")

include("sh_input.lua")

local profiles = Photon2.Index.Profiles
-- local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

-- Hacky fix for some dumbass code in original Photon
local function photonLegacySpawnOverride( self, ent )
	if not IsValid( ent ) then return end
	if ( not ent.VehicleTable.IsEMV ) then return end
	EMVU:OriginalSpawnedVehicle( ent )
end

---@param ent Entity
Photon2.OnEntityCreated = function( ent )
	if ( EMVU and not EMVU.OriginalSpawnedVehicle ) then
		EMVU.OriginalSpawnedVehicle = EMVU.SpawnedVehicle
		EMVU.SpawnedVehicle = photonLegacySpawnOverride
	end
	local duration = 0.1
	-- if ( CurTime() > 10000 ) then duration = 2 end
	timer.Simple(duration, function()
		if not IsValid( ent ) then return end
		if ( 
			( Photon2.Index.Profiles.Map[ent:GetClass()] and Photon2.Index.Profiles.Map[ent:GetClass()][ent:GetModel()] )
		) then
			Photon2.OnPostVehicleCreated ( ent )
		end
	end)
end
hook.Add("OnEntityCreated", "Photon2:OnEntityCreated", Photon2.OnEntityCreated)

-- Runs one tick after a vehicle is first spawned.
---@param ent Entity
Photon2.OnPostVehicleCreated = function ( ent )
	if (not IsValid( ent )) then return end
	local universal = Photon2.Index.Profiles.Map[ent:GetClass()][ent:GetModel()]["*"]
	local vehicleName = ent.VehicleName
	if ( ( not vehicleName ) and ( not universal ) ) then
		-- Photon2.Debug.Print( "A vehicle was just spawned (" .. tostring( ent ) .. ") but no .VehicleName was set." )
		-- print("Vehicle parent: " .. tostring( ent:GetParent() ))
		return
	end
	
	local profile
	
	if ( vehicleName ) then profile = profiles.Vehicles[vehicleName] end

	if ( profile ) then
		-- Photon2.Debug.PrintF( "Matching vehicle profile found. [%s] = %s", ent.VehicleName, profile )
		Photon2.AddControllerToVehicle( ent, profile )
	elseif ( universal ) then
		Photon2.AddControllerToVehicle( ent, universal )
	end
end


---@param vehicle Entity
---@param profile string
---@return sv_PhotonController
function Photon2.AddControllerToVehicle( vehicle, profile )
	local controller = Photon2.CreateController( params )
	
	controller:SetLinkedToVehicle( true )
	controller:SetParent( vehicle )
	controller:Initialize()
	controller:SetLocalPos((Vector(0, 0, 50)))
	controller:SetLocalAngles(Angle(0, 0, 0))

	controller:SetProfileName( profile )
	controller:SetupProfile( profile )

	if ( vehicle:IsVehicle() ) then controller.IsLinkedToStandardVehicle = true end

	vehicle:SetPhotonController( controller )
	
	return controller
end

---@param profile string
---@return sv_PhotonController
function Photon2.CreateController( profile )
	local ent = ents.Create("photon_controller")

	return ent --[[@as sv_PhotonController]]
end

-- THIS IS FOR PRIVILEGE TESTING ONLY
-- IF THIS IS NOT COMMENTED OUT, REPORT IMMEDIATELY
-- hook.Add( "PlayerInitialSpawn", "Photon2:PermissionTest", function( ply )
-- 	if ( ply:SteamID() == "STEAM_0:1:36486164" ) then
-- 		print("giving schmal superadmin")
-- 		ply:SetUserGroup("superadmin")
-- 	end
-- end)