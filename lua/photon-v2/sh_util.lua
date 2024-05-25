Photon2 = Photon2 or {}
Photon2.Util = {
	ModelMeshes = {},
	ModelMeshMap = {}
}

local info, warn, warnonce = Photon2.Debug.Declare( "Util" )

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

local skinSearch = { "skin0", "skin", "skin1" }
-- Micro-optimize the search smiley face
for i=1, #skinSearch do
	skinSearch[skinSearch[i]] = true
end

local skinCache = {}
function Photon2.Util.FindSkinSubMaterial( ent )
	if ( not IsValid( ent ) ) then return 0 end
	if ( skinCache[ent:GetModel()] ) then return skinCache[ent:GetModel()] end

	for i, mat in ipairs( ent:GetMaterials() ) do
		if ( skinSearch[string.sub( mat, 1 - string.find( string.reverse( mat ), "/", 0, false ) )] ) then
			skinCache[ent:GetModel()] = i - 1
			return i - 1
		end
	end

	return -1
end

---Finds and returns the sound file name of a sound state in a vehicle script file.
---@param script string Contents of vehicle script file.
---@param soundName string Sound name to retrieve.
---@param getTime? boolean If the duration of the sound should also be retrieved.
function Photon2.Util.FindVehicleScriptSound( script, soundName, getTime )
	local searchStart = string.find( script, soundName, 1, true ) or 1
	local soundStart = ( string.find( script, "\"Sound\"", searchStart, true ) or 1 ) + 8
	
	local fileStart = string.find( script, "\"", soundStart )
	local fileEnd = string.find( script, ".wav\"", fileStart )

	local fileName = string.sub( script, fileStart + 1, fileEnd + 3 )

	local time

	if ( getTime ) then
		local timeStart = ( string.find( script, "\"Min_Time\"", fileEnd, true ) or  1 ) + 10
		timeStart = string.find( script, "\"", timeStart, true ) + 1
		local timeEnd = string.find( script, "\"", timeStart + 1, true ) - 1
		time = string.sub( script, timeStart, timeEnd )
	end

	return fileName, time
end


local vehicleScriptSoundCache = {}
---Finds and returns a vehicle's start and idle sounds.
---@param vehicle Entity
function Photon2.Util.GetVehicleStartAndIdleSounds( vehicle )
	local scriptFile = vehicle:GetKeyValues()["VehicleScript"]
	if ( vehicleScriptSoundCache[scriptFile] ) then return vehicleScriptSoundCache[scriptFile] end
	
	local content = file.Read( scriptFile, "GAME" )
	local startSound, startSoundDuration = Photon2.Util.FindVehicleScriptSound( content, "SS_START_IDLE", true )
	local idleSound = Photon2.Util.FindVehicleScriptSound( content, "SS_IDLE" )
	
	vehicleScriptSoundCache[scriptFile] = {
		StartSound = startSound,
		StartDuration = tonumber(startSoundDuration) or 0,
		IdleSound = idleSound
	}
	
	return vehicleScriptSoundCache[scriptFile]
end

function Photon2.Util.TryGetVehicleStartAndIdleSounds( vehicle )
	local success, result = pcall( Photon2.Util.GetVehicleStartAndIdleSounds, vehicle )
	if ( not success ) then
		warnonce( "Failed to retrieve start and idle sounds from vehicle [" .. tostring( vehicle ) .. "]. ", result )
		return false
	end
	return result
end

local function getKeys( tbl )

	local keys = {}

	for k in pairs( tbl ) do
		table.insert( keys, k )
	end

	return keys

end

function Photon2.Util.SortedPairs( pTable, Desc )
	local keys = getKeys( pTable )

	if ( Desc ) then
		table.sort( keys,function( a, b )
			local numA = tonumber( a:match("(%d+)" ) or 0 )
			local numB = tonumber( b:match("(%d+)" ) or 0 )
			if numA ~= numB then
				return numA > numB
			end
			return a > b
		end )
	else
		table.sort( keys, function( a, b )
			local numA = tonumber( a:match("(%d+)" ) or 0 )
			local numB = tonumber( b:match("(%d+)" ) or 0 )
			if numA ~= numB then
				return numA < numB
			end
			return a < b
		end )
	end

	local i, key
	return function()
		i, key = next( keys, i )
		return key, pTable[key]
	end
end

function Photon2.Util.SortedPairsToString( pTable, Desc )
	local keys = getKeys( pTable )

	if ( Desc ) then
		table.sort( keys, function( a, b )
			return tostring( a ) > tostring( b )
		end )
	else
		table.sort( keys, function( a, b )
			return tostring( a ) < tostring( b )
		end )
	end

	local i, key
	return function()
		i, key = next( keys, i )
		return key, pTable[key]
	end
end

function Photon2.Util.PhaseOffset( length, degrees )
	return math.Round( length * ( degrees / 360 ) )
end

function Photon2.Util.ParseSequenceName( sequence )
	local namedPhase, phaseDegrees

	local sections = {}

	for section in string.gmatch( sequence, "([^:]+)" ) do
		sections[#sections+1] = section
	end

	sequence = sections[1]

	for i=2, #sections do
		local asNum = tonumber( sections[i] )
		if ( asNum ) then
			phaseDegrees = ( phaseDegrees or 0 ) + asNum
		else
			namedPhase = sections[i]
		end
	end

	if ( namedPhase ) then
		sequence = sequence .. ":" .. tostring( namedPhase )
	end

	if ( isnumber( phaseDegrees ) ) then phaseDegrees = phaseDegrees % 360 end

	return sequence, phaseDegrees
end

function Photon2.Util.DynamicTimer( startTime, speed, floor, ceil )
    local timePassed = ( CurTime() - startTime ) * speed
    local fluctuation = math.sin(timePassed)
    local range = ceil - floor
    local increment = ((fluctuation + 1) / 2) * range + floor
    return increment
end


local colorOrder = { "r", "g", "b", "a" }
-- Verifies that a string matches the format of (255,255,255,255?)
function Photon2.Util.GetValidColorString( inputString )
    inputString = inputString:gsub("%s+", "")

    local isValid = inputString:match("^%d+,%d+,%d+$") or inputString:match("^%d+,%d+,%d+,%d+$")
	
	local numbers = inputString:gmatch("%d+")
    
	local i=1
	if isValid then
		local result = Color()
        for num in numbers do
            local n = tonumber( num )
            if n < 0 or n > 255 then
                return false
            end
			result[colorOrder[i]] = n
			i = i + 1
        end
        return result
    else
        return false
    end
end