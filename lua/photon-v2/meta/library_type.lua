if (exmeta.ReloadFile()) then return end

NAME = "PhotonLibraryType"

local info, warn, warnonce = Photon2.Debug.Declare( "Library" )

local print = info
local printf = info


---@class PhotonLibraryType
---@field Name string Primary type name. Example: `InputConfigurations`
---@field Folder string Folder/alternate type name. Example: `input_configuration`
---@field Singular string Singular name of library type.
---@field IsLoading? boolean When true, library entries are still being loaded. This is to hint that's unsafe to attempt object inheritance.
---@field Loaded? boolean Indicates
---@field Repository? table<string, table> Raw entries.
---@field Index? table<string, table> Compiled entries.
---@field OnServer? boolean If this library type should be loaded server-side.
---@field OnClient? boolean If this library type should be loaded client-side.
---@field IsValidRealm? boolean If this instance is on a proper realm.
---@field EagerLoading? boolean
---@field CurrentLoadSource? string (Internal) Establishes where ensuing library entries are (presumably) for any bulk operations.
---@field Template? table
---@field Unsaved? boolean
---@field ReadOnly? boolean
---@field LuaPath? string (Internal) Full Lua path to file library.
---@field GlobalName? string (Internal) Global variable name used for dedicated files.
---@field IncludingDedicatedFile? boolean (Internal) If a newly loaded file is actually a dedicated file.
---@field LoadingDedicatedFile? boolean (Internal)
---@field HardReloadThreshold? number (Internal) Time between reloads that should trigger a hard reload.
---@field Signatures? string[] Table keys used as signatures for change detection.
---@field UI? table User interface parameters.
---@field RefreshQueue? table<string, boolean> Stores a list of recently registered entries. (For hooks that need to know when ANY generic updates occur.)
local meta = exmeta.New()

local dataPath = "photon_v2/library/"
local luaPath = "photon-v2/library/"

meta.OnServer = true
meta.OnClient = true
meta.Template = {}
meta.HardReloadThreshold = 1
function meta.New( properties )
	local result = setmetatable( properties, { __index = meta } )
	
	result.Loaded = false
	result.LuaPath = luaPath .. result.Folder .. "/"
	-- ??????
	result.GlobalName = "PHOTON_LIBRARY_" .. string.upper( result.Singular )
	result.RefreshQueue = {}

	if ( Photon2.Index and Photon2.Index[result.Name] ) then result.Loaded = true end
	result.IsValidRealm = ( result.OnServer == SERVER ) or ( result.OnClient == CLIENT )
	
	Photon2["Register" .. result.Singular] = function( entry )
		if ( not result.IsValidRealm ) then return nil end
		return result:Register( entry )
	end

	-- what the fuck is this?
	Photon2["Library" .. result.Singular] = function()
		_G[result.GlobalName] = {
			SourceType = "Lua"
		}
		return _G[result.GlobalName]
	end
	
	Photon2["Reload" .. result.Singular .. "File"] = function()
		result.IncludingDedicatedFile = true
		return result:ReloadDedicatedLuaFile()
	end

	if ( not result.IsValidRealm ) then return end

	file.CreateDir( "photon_v2/library/" .. result.Folder )

	Photon2.Library.Repository[result.Name] = Photon2.Library.Repository[result.Name] or {}
	Photon2.Library.Types = result
	Photon2.Library[result.Name] = result
	result.Repository = Photon2.Library.Repository[result.Name]

	Photon2.Index = Photon2.Index or {}
	Photon2.Index[result.Name] = Photon2.Index[result.Name] or {}
	result.Index = Photon2.Index[result.Name]

	

	Photon2["Get" .. tostring( result.Singular ) ] = function( name )
		return result:GetFromIndex( name )
	end
	
	return result
end

function meta:GetUsedSourceTypes()
	local result = {
		Data = true,
		Lua = true,
		Other = true
	}

	for name, entry in pairs( self.Repository ) do
		if ( entry.SourceType ) then
			result[entry.SourceType] = true
		end
	end

	return result
end

function meta:CompileAll()
	for name, entry in pairs( self.Repository ) do
		self:GetFromIndex( name )
	end
end

function meta:ToJson( data )
	return util.TableToJSON( data, true )
end

function meta:FromJson( json )
	return util.JSONToTable( json )
end

-- Saves library entry as a json file in the corresponding folder.
function meta:SaveToData( data )
	data.Unsaved = nil
	data.ReadOnly = nil
	local json = self:ToJson( data )
	local path = string.format( "%s%s/%s.json", dataPath, self.Folder, data.Name )
	info( "Saving %s library entry to data: %s", self.Name, data.Name )
	file.Write( path, json )
end

-- Saves a library entry and then registers it so it's immediately loaded.
function meta:SaveToDataAndRegister( data )
	if ( not data.Name ) then 
		ErrorNoHaltWithStack( "Attempted to save a library entry with no .Name defined." )
		return
	end
	data.Unsaved = nil
	self:SaveToData( data )
	self:LoadDataJsonFile( data.Name .. ".json", data )
end

-- Loads library objects that were created in Lua
function meta:LoadLuaLibrary()
	local path = luaPath .. self.Folder .. "/"
	print( "\tPath: " .. tostring( path ) )
	local files, folders = file.Find( path .. "*.lua", "LUA" )
	print( "\tResult: " .. tostring(#files) .. " file(s) found." )
	for _, fil in pairs( files ) do
		self:LoadLuaFile( path .. fil )
	end
end

function meta:LoadLuaFile( path )
	print("\t\tIncluding Lua file: " .. tostring( path ) )
	self.CurrentLoadSource = "Lua"
	self.SupressDedicatedLoad = true
	local result = include( path )
	self.SupressDedicatedLoad = false
	if ( self.IncludingDedicatedFile ) then
		self.IncludingDedicatedFile = false
		self:LoadDedicatedLuaFile( path )
	end
	self.CurrentLoadSource = nil
	return result
end

-- When a dedicated file is reloaded. Requires a special function because
-- the component name needs to be parsed from the file using the debug library.
function meta:ReloadDedicatedLuaFile( )
	-- return true to terminate include
	if ( self.SupressDedicatedLoad ) then return true end
	if ( self.LoadingDedicatedFile ) then return false end

	local source = debug.getinfo(2, "S").source
	if source:sub(1, 1) == "@" then
		source = source:sub(2)
	else
		return false
	end

	local startPos, endPos = source:find( self.LuaPath, 1, true )

	if ( startPos ) then
		local path = source:sub(startPos)
		self:LoadDedicatedLuaFile( path )
	else
		Photon2.Debug.Print("Attempted to reload library entry from an invalid file location [" .. tostring(source) .."]")
		return false
	end
end

function meta:GetNameFromLuaFile( path )
	local nameStart = string.len( self.LuaPath ) + 1
	local nameEnd = string.len( self.LuaPath ) - nameStart -4
	return string.sub( path, nameStart, nameEnd )
end

-- Loads a file dedicated to a single entry. 
function meta:LoadDedicatedLuaFile( path )
	info( "Loading dedicated file [%s]", path )
	local name = self:GetNameFromLuaFile( path )
	info( "Name [%s]", name )

	_UNSET = UNSET
	UNSET = PHOTON2_UNSET
	
	self.LoadingDedicatedFile = true
	include( path )
	self.LoadingDedicatedFile = false
	
	UNSET = _UNSET

	local entry = _G[self.GlobalName]
	
	if ( not entry ) then return end
	
	entry.Name = name
	entry.SourceType = "Lua"
	
	self:Register( table.Copy( entry ) )
	
	entry = {}
end

-- Loads library objects that were created using JSON in the `data` folder.
function meta:LoadDataLibary()
	local path = string.format( "%s%s/*.json", dataPath, self.Folder )
	print( "\tPath: " .. path)
	local files, folders = file.Find( path, "DATA" )
	print( "\tResult: " .. tostring(#files) .. " file(s) found." )
	for _, fil in pairs( files ) do
		self:LoadDataJsonFile( fil )
	end
end

function meta:LoadLibrary()
	print( "Loading [%s] library...", self.Name )
	if ( not self.IsValidRealm ) then return end
	self.IsLoading = true
	print("\tLoading Lua files...")
	self:LoadLuaLibrary()
	print("\tLoading data files...")
	self:LoadDataLibary()
	self.IsLoading = false
	print("\tLibrary loading marked complete.")
	self.Loaded = true
end

function meta:LoadDataJsonFile( fileName )
	local path = string.format( "photon_v2/library/%s/%s", self.Folder, fileName)
	print( "\t\tLoading JSON file [%s]", path  )
	
	local json = file.Read( path, "DATA" )
	
	local data = self:FromJson( json )
	
	if ( istable( data ) ) then
		data.Name = string.sub( fileName, 1, #fileName - 5 )
		data.SourceType = "Data"
		data.ReadOnly = data.ReadOnly or false
		return self:Register( data )
	else
		ErrorNoHalt( "Error occurred when attemping to load library data file: [" .. tostring( fileName ) .. "]")
		return nil
	end
end

-- Retrieves a library entry using its name/unique identifier.
---@return table
function meta:Get( name )
	return self.Repository[name]
end

-- Retrieves a copy of a library entry using its name/unique identifier. Used for non-destructive editing.
function meta:GetCopy( name )
	return table.Copy( self.Repository[name] )
end

-- Generates a new, blank library entry of this type.
function meta:GetNew()
	return table.Copy( self.Template )
end

---@param name string
-- Retrieves a compiled version of the entry from its index using its name/unique identifier.
function meta:GetFromIndex( name )
	-- self.Index = self.Index or Photon2.Index[self.Name]
	if ( not self.Index[name] and self.Repository[name] ) then
		self:Compile( name )
	end
	return self.Index[name]
end

-- Registers an entry to this library.
function meta:Register( data )
	self:PreRegister( data )
	local success, code = pcall( self.DoRegister, self, data )
	if ( not success ) then
		local name = data.Name or "(INVALID NAME)"
		warn( "Failed to register [%s]: %s", name, code )
	end
end

---This should only be used as a last resort to handle breaking API changes!
---Raw data should otherwise NEVER be manipulated.
---@param data any
function meta:PreRegister( data ) end

function meta:DoRegister( data )
	info( "\t\t\tRegistering [%s] library entry [%s]", self.Name, data.Name )
	local initialType = data.SourceType
	self.Repository[data.Name] = data
	if ( not data.SourceType ) then data.SourceType = self.CurrentLoadSource or "Other" end
	if ( data.ReadOnly == nil ) then data.ReadOnly = true end
	if ( self.Loaded ) then
		info("\t\t\t\tReloading...")
		self:OnReload( data )
	elseif ( self.EagerLoading ) then
		self:Compile( data )
	end
	self:PostRegister( data.Name )
	self.RefreshQueue[data.Name] = true
	timer.Create( self.GlobalName .. "_UPDATED", 0.01, 1, function()
		hook.Run( "Photon2:" .. self.Name .. "Changed", self.RefreshQueue )
		self.RefreshQueue = {}
	end)
	-- if ( data.SourceType ~= initialType ) then
	-- 	warn("SourceType changed!")
	-- end
end

function meta:PostRegister( name )

end

-- Called when an entry is reloaded.
function meta:OnReload( data )
	local old = self.Index[data.Name]
	local hardReload = ( ( istable( old ) ) and ( old.CompileTime + self.HardReloadThreshold >= CurTime() ) )
	self:Compile( data, true, hardReload )
	timer.Create( "Photon2.Library:" .. self.Name .. "Reload", 0.05, 1, function()
		if ( self ) then
			self:OnPostReload()
		end
	end)
end

-- Reloads every entry in the index. Useful when external data changes that the library needs to account for.
function meta:ReloadIndex()
	for name, entry in pairs( self.Index ) do
		self:OnReload( self.Repository[name] )
	end
end

-- Called one tick(ish) after any reload occurred. Does not provide what was reloaded
-- because this is only called once AFTER multiple entries were reloaded.
function meta:OnPostReload()
end

-- Compilation wrapper. Actual compilation overrides should be done in `TYPE:DoCompile( data )`
---@param data table | string
---@param hardReload? boolean
function meta:Compile( data, isReload, hardReload )
	if ( isstring( data ) ) then data = self:Get( data ) end
	local result = self:DoCompile( table.Copy( data --[[@as table]]) )
	result.CompileTime = CurTime()
	hardReload = hardReload or ( self:MatchSignatures( self.Index[result.Name], result ) == false )
	self.Index[result.Name] = result
	self:PostCompile( result.Name, isReload, hardReload )
	return result
end

-- Compares signatures
function meta:MatchSignatures( oldEntry, newEntry )
	if not ( self.Signatures ) then return false end
	if not ( oldEntry ) then return true end
	for i, key in ipairs( self.Signatures ) do
		if ( newEntry[key] ~= oldEntry[key] ) then
			print("SIGNATURE DOES NOT MATCH")
			return false
		end
		print("SIGNATURE MATCHES: %s", tostring( newEntry[key]))
	end
	return true
end

function meta:GetInherited( data )
	if ( isstring( data ) ) then data = self:GetCopy( data ) end
	return data
end

function meta:TryGetInherited( data )
	local success, result = pcall( self.GetInherited, self, data )
	if ( not success ) then
		warnonce( "Failed to load: [" .. tostring( data ) .. "]. You are likely missing required content or have a naming error in your code.", result )
		return {}, false
	end
	return result, true
end

function meta:DoCompile( data )
	return data
end

function meta:PostCompile( name, isReload, hardReload )

end

-- Not implemented
function meta:SetupInheritance( data )
	
end

-- Not implemented
function meta:DoParentInheritance()

end

---@param name string Name of entry to export.
---@param newName string Name of the exported entry.
-- Takes an existing library entry and exports (copies) it as a new JSON file entry.
function meta:Export( name, newName )
	local copy = table.Copy( self:Get( name ) )
	copy.Name = newName
	self:SaveToData( copy )
end
-- Loads library objects that were created using JSON in the `data_static` folder.
-- This is for Workshop addons so GMAs can use JSON files. Implementation by Facepunch
-- is currently half-assed so this function is not yet available.
function meta:LoadDataStaticLibrary()

end
