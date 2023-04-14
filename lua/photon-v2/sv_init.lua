include("sh_init.lua")
include("sv_net.lua")

include("sh_component_builder.lua")
include("sh_library.lua")
include("sh_index.lua")

include("sh_ent_meta.lua")
include("sv_functions.lua")


print("sv_init.lua")

local profiles = Photon2.Index.Profiles
local print = Photon2.Debug.Print

---@param ent Entity
Photon2.OnEntityCreated = function( ent )
	-- ent:SetKeyValue("damagefilter", "vehicle-name")
	--local targ = ent:GetInternalVariable("LightingOriginHack") or "<error>"
	--Photon2.Debug.Print("KEY VALUE: " .. tostring(targ))
	--ent.SetKeyValue = ent._oldSetKeyValue
	timer.Simple(0.01, function()
		if not IsValid( ent ) then return end
		if (ent:IsVehicle()) then
			-- Photon2.Debug.Print("@vehiclename: " .. tostring(ent["@vehiclename"]))
			-- ent:SetKeyValue( "target", "custom vehicle name" )
			
			--PrintTable( ent:GetSaveTable(true) )
			
			Photon2.OnPostVehicleCreated ( ent )
		end
	end)
end
hook.Add("OnEntityCreated", "Photon2:OnEntityCreated", Photon2.OnEntityCreated)

-- Runs one tick after a vehicle is first spawned.
---@param ent Entity
Photon2.OnPostVehicleCreated = function ( ent )
	if (not IsValid( ent )) then return end
	if (not ent.VehicleName) then
		Photon2.Debug.Print( "A vehicle was just spawned (" .. tostring( ent ) .. ") but no .VehicleName was set." )
		return
	end
	local profile = profiles.Vehicles[ent.VehicleName]
	if (profiles.Vehicles[ent.VehicleName]) then
		Photon2.Debug.PrintF( "Matching vehicle profile found. [%s] = %s", ent.VehicleName, profile ) 
		Photon2.AddControllerToVehicle( ent, profile )
	end
end


---@param vehicle Entity
---@param profile string
---@return sv_PhotonController
function Photon2.AddControllerToVehicle( vehicle, profile )
	local controller = Photon2.CreateController( params )
	
	controller:SetParent( vehicle )
	controller:Initialize()
	controller:SetLocalPos((Vector(0, 0, 50)))
	controller:SetLocalAngles(Angle(0, -90, 0))

	controller:SetProfileName( profile )

	vehicle:SetNW2Entity( "Photon2:Controller", controller )

	return controller
end

---@param profile string
---@return sv_PhotonController
function Photon2.CreateController( profile )
	local ent = ents.Create("photon_controller")

	return ent --[[@as sv_PhotonController]]
end