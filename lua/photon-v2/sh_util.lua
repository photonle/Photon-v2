Photon2.Util = {
	ModelMeshes = {},
	ModelMeshMap = {}
}

local Util = Photon2.Util

---@param target table
---@param meta table
function Photon2.Util.ReferentialCopy( target, meta )
	for k, v in pairs(meta) do
		if istable(v) then
			if (rawget( target, k ) == nil) then
				target[k] = meta[k]
			else
				Util.ReferentialCopy(target[k], meta[k])
			end
		end
	end
	setmetatable( target, { __index = meta } )
end

-- A more expensive version of table.Copy that doesn't reuse 
-- metatables, which can cause issues with Photon's inheritance.
function Photon2.Util.UniqueCopy( tbl )
	local copy = {}
	for k, v in pairs( tbl ) do
		if ( istable( v ) ) then
			copy[k] = Photon2.Util.UniqueCopy( v )
		else
			copy[k] = v
		end
	end
	return copy
end

function Photon2.Util.SimpleInherit( target, base )
	base = table.Copy( base )
	for key, value in pairs( base ) do
		if ( target[key] == nil ) then
			target[key] = value
		elseif ( istable( value ) and istable( target[key] ) ) then
			target[key] = Photon2.Util.SimpleInherit( target[key], value )
		end
	end
	return setmetatable(target, { Inherited = true } )
end

---@param target table
---@param base table
-- -@param override
function Photon2.Util.Inherit( target, base )
	local metaTable = getmetatable( target )
	if ( not metaTable ) then
		setmetatable( target, {} )
		metaTable = getmetatable( target )
	end

	if ( metaTable.__inherits ) then
		if ( metaTable.__inherits == base ) then
			return
		end
		error( "Target table has already inherited from a different base table. Ensure instances are being copied and consider using Photon2.Util.UniqueCopy if problems persist." )
	end

	for key, value in pairs( base ) do
		local raw = rawget( target, key )
		
		if ( raw == nil ) then
			target[key] = value
		elseif ( raw == PHOTON2_UNSET ) then
			target[key] = nil
		elseif ( istable( raw ) and istable( value ) ) then
			if ( not raw["__no_inherit"] ) then
				target[key] = Photon2.Util.Inherit( raw, value )
			else
				raw["__no_inherit"] = nil
			end
		end
	end

	metaTable.__inherits = base
	metaTable.__inheritedAt = CurTime()
	return target
end

function Photon2.Util.FindBodyGroupOptionByName( ent, bodyGroupIndex, name )
	if ( string.len(name) > 0 ) then name = name .. ".smd" end
	for index, subModel in pairs( ent:GetBodyGroups()[bodyGroupIndex+1].submodels ) do
		if ( name == subModel ) then return index end
	end
	ErrorNoHaltWithStack(string.format("Could not find body group option [%s] in body group index [%s] in model [%s]", name, bodyGroup, self:GetModel() ))
	return 0
end

function Photon2.Util.PrintTableProperties( tbl )
	print("\nSTART >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n")
	local searching = true
	local currentTable = tbl
	while ( searching ) do
		if istable( currentTable ) then
			PrintTable( currentTable )
		else

		end
		local metaTable = debug.getmetatable( currentTable )
		if ( istable( metaTable ) and istable( metaTable.__index ) ) then
			currentTable = metaTable.__index
			print("\n HAS META TABLE: ==========\n")
		else
			searching = false
		end
	end
	print("\nEND   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n")
end

-- Returns an input key name or `"(INVALID)"` instead of nil
-- so you don't have to use fucking `tostring(result)` every time.
function Photon2.Util.GetKeyName( key )
	local result = input.GetKeyName( key )
	result = result or "(INVALID)"
	return result
end

-- Finds sub-materials on an entity that match those of its parent
-- and generates a map of their indexes lik `{ [ParentIndex] = ChildIndex }`.
---@param ent Entity
function Photon2.Util.BuildParentSubMaterialMap( ent )
	return Photon2.Util.BuildSubMaterialMap( ent:GetParent(), ent )
end

-- Finds sub-materials on `toEnt` that match those of `fromEnt`
-- and generates a map of their indexes lik `{ [fromIndex] = toIndex }`.
---@param fromEnt Entity (Usually the parent entity)
---@param toEnt Entity (Usually the child entity)
function Photon2.Util.BuildSubMaterialMap( fromEnt, toEnt )
	local toMaterials = toEnt:GetMaterials()
	local map = {}
	for key, name in pairs( toMaterials ) do
		toMaterials[name] = key
	end
	for key, name in pairs( fromEnt:GetMaterials() ) do
		if ( toMaterials[name] ) then 
			map[key-1] = toMaterials[name]-1
		end
	end
	return map
end

-- (Internal) Triggered when meta (or other internal) files are saved
-- so changes can be observed immediately on spawned vehicles.
function Photon2.Util.ReloadAllControllers()
	for k, ent in pairs ( ents.FindByClass( "photon_controller" ) ) do
		Photon2.Library.Vehicles:Compile( ent:GetProfileName() )
		ent:HardReload()
	end
end

-- PrintTable(Util.ModelMeshes)