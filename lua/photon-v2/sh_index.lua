Photon2.Index = Photon2.Index or {
	---@type PhotonLightingComponent[]
	Components = {},
	Vehicles = {}
}
local index = Photon2.Index

local Library = Photon2.Library
local Debug = Photon2.Debug

function Photon2.Index.ProcessComponentLibrary()	
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

	for i = 1, #loadOrder do
		local name = loadOrder[i]
		local component = Library.Components[name]
		if (not component.Base) then
			debug.setmetatable( component, { __index = PhotonLightingComponent } )
			index.Components[name] = Photon2.CompileComponent( component )

			-- exmeta.SetMetaTable(component, PhotonLightingComponent)
		else
			--setMetaTable(component, index.Components[component.Base])
			-- exmeta.SetMetaTable(component, Index.Components[component.Base])
		end

	end

	
end

---@param inputComponent PhotonLibraryComponent
---@return PhotonLightingComponent
function Photon2.CompileComponent( inputComponent )
	return PhotonLightingComponent.New( inputComponent )
end

Photon2.LoadComponentLibrary()
index.ProcessComponentLibrary()

-- Debug.Print("jetsolaris_2 ===============")
-- PrintTable(Index.Components["photon_fedsig_jetsolaris_2"])
-- Debug.Print(Index.Components["photon_fedsig_jetsolaris_2"].Patterns["Emergency.Warning"]["Mode1"]["Edge"]["Sequence"])