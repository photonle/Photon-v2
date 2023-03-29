---@type Photon2.Index
Photon2.Index = Photon2.Index or {
	Components = {},
	Vehicles = {},
	Profiles = {
		Map = {},
		-- For entities that :IsVehicle() and have .VehicleName defined.
		Vehicles = {}
	}
}

--[[
	Profiles = {
		Map = {
			["prop_vehicle_jeep"] = {
				["models/sentry/20fpiu_new.mdl"] = {
					["~default"] = "photon_sgm_fpiu20",
					["20fpiu_new_sgm"] = "photon_sgm_fpiu20"
				}
			}
		},
		Vehicles = {
			["sgm_fpiu_2020_new"] = "photon_sgm_fpiu20"
		}	
	}
]]

local print = Photon2.Debug.PrintF

local index = Photon2.Index
local library = Photon2.Library
local debug = Photon2.Debug

--[[---------------------
	Component Index
-----------------------]]

function Photon2.Index.ProcessComponentLibrary()	
	local dependencyList = {}
	-- High-level dependency check
	for name, component in pairs(library.Components) do
		table.insert(dependencyList, { name, component.Base })
		if (component.Base) and (not library.Components[component.Base]) then
			debug.Print("Component [" .. tostring(name) .. "] is based on [" .. tostring(component.Base) .. "], which could not be found. Aborting.")
			error()
		end
	end

	local loadOrder = {}
	-- Determines load order by dependencies
	while (not table.IsEmpty(dependencyList)) do
		for i, entry in pairs( dependencyList ) do
			if ((not entry[2]) or table.HasValue(loadOrder, entry[2])) then
				loadOrder[#loadOrder + 1] = entry[1]
				dependencyList[i] = nil
			end
		end
	end

	local function setMetaTable(targ, meta)
		for k, v in pairs(meta) do
			if istable(v) then
				if (targ[k] == nil) then
					targ[k] = meta[k]
				end
				setMetaTable(targ[k], meta[k])
			end
		end
		debug.setmetatable(targ, { __index = meta })
	end

	for i = 1, #loadOrder do
		local name = loadOrder[i]
		local component = library.Components[name]
		if (not component.Base) then
			-- debug.setmetatable( component, { __index = PhotonLightingComponent } )
			Photon2.CompileComponent( name, component )

			-- exmeta.SetMetaTable(component, PhotonLightingComponent)
		else
			-- TODO: Component inheritance
			--setMetaTable(component, index.Components[component.Base])
			-- exmeta.SetMetaTable(component, Index.Components[component.Base])
		end
	end

end


---@param name string
---@param inputComponent PhotonLibraryComponent
---@return PhotonLightingComponent
function Photon2.CompileComponent( name, inputComponent )
	Photon2.Index.Components[name] = PhotonLightingComponent.New( inputComponent )
	return Photon2.Index.Components[name]
end


--[[---------------------
	Vehicle Index
-----------------------]]

function Photon2.Index.ProcessVehicleLibrary()
	debug.Print("processing vehicle library")
	local dependencyList = {}
	for name, vehicle in pairs(library.Vehicles) do
		dependencyList[#dependencyList+1] = { name, vehicle.Base }
		if (vehicle.Base) and (not library.Vehicles[vehicle.Base]) then
			debug.Print("Vehicle [" .. tostring(name) .. "] is based on [" .. tostring(component.Base) .. "], which could not be found. Aborting.")
			error()
		end
	end

	local loadOrder = {}
	while (not table.IsEmpty(dependencyList)) do
		for i, entry in pairs( dependencyList ) do
			if ( ( not entry[2] ) or ( table.HasValue(loadOrder, entry[2]) ) ) then
				loadOrder[#loadOrder+1] = entry[1]
				dependencyList[i] = nil
			end
		end
	end

	for i=1, #loadOrder do
		local name = loadOrder[i]
		local vehicle = library.Vehicles[name]
		if (not vehicle.Base) then
			Photon2.Index.CompileVehicle( name, vehicle )
		else
			-- TODO: Vehicle inheritance
		end
	end

end


---@param name string The name of the vehicle profile.
---@param inputVehicle PhotonLibraryVehicle The library vehicle instance to compile.
---@param isReload? boolean If the component is being reloaded (i.e. the file was just saved).
function Photon2.Index.CompileVehicle( name, inputVehicle, isReload )
	local currentEquipmentCount, newEquipmentCount
	local currentEquipmentSignature, newEquipmentSignature
	local hardSet = true

	if (isReload) then
		-- Build equipment signature of current table to compare new one to
		currentEquipmentSignature = {}
		currentEquipmentCount = #Photon2.Index.Vehicles[name].Equipment
		for key, params in pairs(Photon2.Index.Vehicles[name].Equipment) do
			currentEquipmentSignature[key] = (params.Component or params.Prop)
		end
	end

	Photon2.Index.Vehicles[name] = PhotonVehicle.New( inputVehicle )

	if (isReload) then
		-- Build new equipment signature
		local newEquipment = Photon2.Index.Vehicles[name].Equipment
		newEquipmentCount = #newEquipment
		if (currentEquipmentCount == newEquipmentCount) then
			print("Equipment count unchanged. Checking signatures...")
			for key, params in pairs(newEquipment) do
				print("\tChecking key [%s]", key)
				print("\tKey: ", tostring(currentEquipmentSignature[key]))
				if (
						(currentEquipmentSignature[key]) and 
						((currentEquipmentSignature[key] == params.Prop) or
						(currentEquipmentSignature[key] == params.Component))
				) then
					print("Detected as a soft reload...")
					hardSet = false
				else
					print("Hard reload necessary.")
					break
				end
			end
		else
			print("Equipment was added or removed.")		
		end
	end

	hook.Run("Photon2.VehicleCompiled", name, Photon2.Index.Vehicles[name], hardSet)
	return Photon2.Index.Vehicles[name]
end

hook.Add("Photon2.VehicleCompiled", "Photon2:OnVehicleCompiled", function(name, vehicle)
	print("Vehicle compiled (%s)", name)
end)