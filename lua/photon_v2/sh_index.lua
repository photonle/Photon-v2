Photon2.Index = Photon2.Index or {}
local Index = Photon2.Index

local Library = Photon2.Library
local Debug = Photon2.Debug

Index.Components = {}
Index.Vehicles = {}

function Index.ProcessComponentLibrary()	
	local dependencyList = {}
	-- High-level dependency check
	for name, component in pairs(Library.Components) do
		table.insert(dependencyList, { name, component.Base })
		if (component.Base) and (not Library.Components[component.Base]) then
			Debug.Print("Component [" .. tostring(name) .. "] is based on [" .. tostring(component.Base) .. "], which could not be found. Aborting.")
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

	for i, name in ipairs(loadOrder) do
		local component = Library.Components[name]
		if (not component.Base) then
			exmeta.SetMetaTable(component, "photon_lighting_component")
		else
			setMetaTable(component, Index.Components[component.Base])
			-- exmeta.SetMetaTable(component, Index.Components[component.Base])
		end
		Index.Components[name] = component

		Photon2.CompileComponent( component )
	end

	
end

function Photon2.CompileComponent( inputComponent )
	local component = {}

	-- Handle light objects
	local templateLights = {}
	for name, data in pairs(inputComponent.Lighting["2D"]) do
		templateLights[name] = exmeta.Inherit( data, "photon_light_2d" )
	end

	local lights = {}
	for i, data in pairs( inputComponent.Lights ) do
		
		lights[i] = exmeta.SetMetaTable({
			LocalPosition = data[2],
			LocalAngles = data[3],
		}, templateLights[data[1]])


		-- prints all values including metatables....
		PrintTable(lights[i])
		local s1 = debug.getmetatable(lights[i]).__index
		local s2 = debug.getmetatable(s1).__index
		PrintTable(s1)
		PrintTable(s2)
	end

end

Photon2.LoadComponentLibrary()
Index.ProcessComponentLibrary()

-- Debug.Print("jetsolaris_2 ===============")
-- PrintTable(Index.Components["photon_fedsig_jetsolaris_2"])
-- Debug.Print(Index.Components["photon_fedsig_jetsolaris_2"].Patterns["Emergency.Warning"]["Mode1"]["Edge"]["Sequence"])