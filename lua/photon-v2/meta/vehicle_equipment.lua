if (exmeta.ReloadFile()) then return end

NAME = "PhotonVehicleEquipmentManager"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonVehicleEquipmentManager
---@field Components table
---@field Props table
---@field BodyGroups table
---@field SubMaterials table
---@field Hud
local Equipment = exmeta.New()

function Equipment.New( name, option )
	local newOption = {}

end

function Equipment.GetTemplate()
	return {
		Components = {},
		Props = {},
		BodyGroups = {},
		SubMaterials = {},
		VirtualComponents = {},
		UIComponents = {},
		InteractionSounds = {}
	}
end

-- Factory that returns a new Template object with empty tables for each supported equipment type.
function Equipment.ApplyTemplate( tbl )
	for k, v in pairs( Equipment.GetTemplate() ) do
		tbl[k] = rawget( tbl, k ) or v
	end
end

---@param entry table
---@param master table
---@param nameTable table
function Equipment.AddEntry( entry, master, nameTable )
	local index = #master + 1
	local new = table.Copy( entry )
	new.Index = index
	master[index] = new
	if ( entry.Name ) then
		if (nameTable[entry.Name]) then
			error(string.format("Equipment Name '%s' is already defined. Name must be unique."))
		end
		nameTable[entry.Name] = index
	end
	return index
end

function Equipment.ProcessTable( source, destination, master, nameTable, pendingNamesTable )
	for key, entry in pairs( source ) do
		if ( istable( entry ) ) then
			destination[#destination+1] = Equipment.AddEntry( entry, master, nameTable )
		elseif ( isstring( entry ) ) then
			-- Treat entry as pointing to an alias
			-- to be resolved later.
			destination[#destination+1] = entry
			-- Add destination table to queue of unresolved aliases
			pendingNamesTable[destination] = true
		end
	end
end



---@param pendingNamesTable table
---@param nameTable table
function Equipment.ResolveNamesFromQueue( pendingNamesTable, nameTable )
	for equipmentTable, _ in pairs( pendingNamesTable ) do
		for i, equipmentIndex in pairs( equipmentTable ) do
			if ( isstring(equipmentIndex) ) then
				-- Check if name is valid
				if ( not nameTable[equipmentIndex] ) then
					error(string.format("Equipment name '%s' is not defined.", nameTable[equipmentIndex]))
				end
				equipmentTable[i] = nameTable[equipmentIndex]
			end
		end
	end
end


function Equipment.InheritEntry( entry, parentName, equipmentTable, nameTable, loadedParents )
	printf( "Inheriting equipment from parent '%s'", parentName )
	local parent = equipmentTable[nameTable[parentName]]
	if (parent == entry) then
		error(string.format("Equipment entry attempted to inherit itself.", parentName))
	end
	if (not parent) then
		error(string.format("Invalid equipment parent '%s'", parentName))
	end
	if (( parent.Inherit ) and ( not loadedParents[parent.Inherit] ) ) then
		Equipment.InheritEntry( parent, parent.Inherit, equipmentTable, nameTable, loadedParents )
		loadedParents[parentName] = true
	end

	local isAnonymous = not entry.Name
	table.Inherit( entry, parent )

	-- This is to prevent the parent name from applying
	if (isAnonymous) then
		entry.Name = ""
	end

end


function Equipment.ProcessInheritance( equipmentTable, nameTable, loadedParents )
	for index, entry in pairs( equipmentTable ) do
		if (( entry.Inherit ) and ( not entry.BaseClass )) then
			Equipment.InheritEntry( entry, entry.Inherit, equipmentTable, nameTable, loadedParents )
		end
	end
end


-- TODO: WORK IN PROGRESS
local overrideableProperties = { "StateMap", "Phase", "Segments", "Inputs", "ElementGroups", "ElementStates" }

-- Builds components as new inherited variants for each equipment entry
function Equipment.BuildComponents( equipmentTable, key, vehicleId )
	print("Building Components [" .. key .. "]")
	for key, entry in pairs( equipmentTable[key] ) do
		local componentId = entry.Component .. "<" .. vehicleId .. ":" .. entry.Index .. ">"
		---@type PhotonLibraryComponent

		local component = {
			Base = entry.Component,
			StateMap = entry.StateMap,
			Phase = entry.Phase,
			Generated = true,
			Segments = entry.Segments,
			Inputs = entry.InputActions or entry.Inputs,
			ElementGroups = entry.ElementGroups,
			ElementStates = entry.ElementStates,
			Siren = entry.Siren
		}

		-- for 

		-- Distinguish Component/Entity properties from equipment-only metadata (necessary?)

		-- for key, value in pairs( entry ) do
		-- 	if ( not  )
		-- end
		Photon2.Library.Components[componentId] = component
		Photon2.CompileComponent( componentId, component )
		entry.Component = componentId
		print("NEW Component ID: [" .. componentId .. "]" )
		print("Equipment key: " .. tostring(key) )
		PrintTable( entry )
	end
end

-- function Equipment.BuildMapSignature()