if (exmeta.ReloadFile()) then return end

NAME = "PhotonVehicleEquipmentManager"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonVehicleEquipmentManager
---@field Components table
---@field Props table
---@field BodyGroups table
---@field SubMaterials table
---@field Bones table
---@field Properties table
local Equipment = exmeta.New()

function Equipment.New( name, option )
	local newOption = {}

end

-- For Equipment types where multiple sibling entries are unnecessary.
-- 
local singleEquipmentTypes = {
	Properties = true
}

function Equipment.GetTemplate()
	return {
		Components = {},
		Props = {},
		BodyGroups = {},
		SubMaterials = {},
		InteractionSounds = {},
		Bones = {},
		Properties = {}
	}
end

-- Factory that returns a new Template object with empty tables for each supported equipment type.
function Equipment.ApplyTemplate( tbl )
	for k, v in pairs( Equipment.GetTemplate() ) do
		tbl[k] = rawget( tbl, k ) or v
	end
end

function Equipment.PreMergeEquipment( selection, mergeMap )
	for mergeFrom, mergeTo in pairs( mergeMap ) do
		if ( istable( selection[mergeFrom] ) ) then
			selection[mergeTo] = selection[mergeTo] or {}
			for i=1, #selection[mergeFrom] do
				selection[mergeTo][#selection[mergeTo]+1] = selection[mergeFrom][i]
			end
		end
		selection[mergeFrom] = {}
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
		-- master[index].EquipmentName = entry.Name
	end
	return index
end

function Equipment.ProcessTable( name, source, destination, master, nameTable, pendingNamesTable )
	if ( singleEquipmentTypes[name] ) then source = { source } end
	for key, entry in pairs( source ) do
		if ( istable( entry ) ) then
			destination[#destination+1] = Equipment.AddEntry( entry, master, nameTable )
		elseif ( isstring( entry ) ) then
			-- Allow sub-materials to be setup like [1] = "material"
			if ( name == "SubMaterials" ) then
				entry = { Id = name, Material = entry }
				destination[#destination+1] = Equipment.AddEntry( entry, master, nameTable )
			else
				-- Otherwise treat entry as pointing to an alias
				-- to be resolved later.
				destination[#destination+1] = entry
				-- Add destination table to queue of unresolved aliases
				pendingNamesTable[destination] = true
			end
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
	-- printf( "Inheriting equipment from parent '%s'", parentName )
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
	-- table.Inherit( entry, parent )
	-- Photon2.Util.Inherit( entry, parent )
	-- if ( entry.Inputs and parent.Inputs ) then
	-- 	table.Inherit( entry.Inputs, parent.Inputs )
	-- end
	-- table.Inherit( entry, parent )

	local entryInputs
	if ( istable( entry.Inputs ) ) then entryInputs = table.Copy( entry.Inputs ) end
	Photon2.Util.SimpleInherit( entry, parent )
	Photon2.ComponentBuilder.InheritInputs( entryInputs, entry.Inputs )
	-- This is to prevent the parent name from applying
	if (isAnonymous) then
		entry.Name = nil
	end

end


function Equipment.ProcessInheritance( equipmentTable, nameTable, loadedParents )
	for index, entry in pairs( equipmentTable ) do
		if (( entry.Inherit ) and ( not getmetatable( entry ) )) then
			Equipment.InheritEntry( entry, entry.Inherit, equipmentTable, nameTable, loadedParents )
		end
	end
end


-- TODO: WORK IN PROGRESS
local overrideableProperties = { "StateMap", "Phase", "Segments", "Inputs", "ElementGroups", "ElementStates", "States" }

-- Builds components as new inherited variants for each equipment entry
function Equipment.BuildComponents( equipmentTable, key, vehicleId )
	-- print("Building Components [" .. key .. "]")
	for key, entry in pairs( equipmentTable[key] ) do
		local componentId = entry.Component .. "<" .. vehicleId .. ":" .. entry.Index .. ">"
		
		---@type PhotonLibraryComponent
		
		local component = {
			Base = entry.Component,
			Model = entry.Model,
			StateMap = entry.StateMap,
			Phase = entry.Phase,
			Generated = true,
			Flags = entry.Flags,
			Segments = entry.Segments,
			Inputs = entry.InputActions or entry.Inputs,
			InputPriorities = entry.InputPriorities,
			Elements = entry.Elements,
			ElementGroups = entry.ElementGroups,
			ElementStates = entry.ElementStates,
			Siren = entry.Siren,
			States = entry.States,
			Templates = entry.Templates,
			RenderGroup = entry.RenderGroup,
			VirtualOutputs = entry.VirtualOutputs
		}

		component.Name = componentId
		Photon2.RegisterComponent( Photon2.Util.UniqueCopy(component) )
		
		entry.Component = componentId
		
		-- print("NEW Component ID: [" .. componentId .. "]" )
		-- print("Equipment key: " .. tostring(key) )
		-- PrintTable( entry )
	end
end

-- function Equipment.BuildMapSignature()