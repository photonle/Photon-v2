if (exmeta.ReloadFile()) then return end

NAME = "PhotonLibraryType"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

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
local meta = exmeta.New()

local dataPath = "photon_v2/library/"
local luaPath = "photon-v2/library/"

meta.OnServer = true
meta.OnClient = true
meta.Template = {}

function meta.New( properties )
	local result = setmetatable( properties, { __index = meta } )
	result.Loaded = false
	if ( Photon2.Index and Photon2.Index[result.Name] ) then result.Loaded = true end
	result.IsValidRealm = ( result.OnServer == SERVER ) or ( result.OnClient == CLIENT )
	Photon2["Register" .. result.Singular] = function( entry )
		if ( not result.IsValidRealm ) then return nil end
		return result:Register( entry )
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
	-- print( "PATH: " .. tostring( path ) )
	local files, folders = file.Find( path .. "*.lua", "LUA" )
	-- print( "Result: " .. tostring(#files) .. " files found." )
	for _, fil in pairs( files ) do
		-- print( "Loading file: " .. path .. fil )
		self:LoadLuaFile( path .. fil )
	end
end

function meta:LoadLuaFile( path )
	-- print("\tIncluding Lua file: " .. tostring( path ) )
	self.CurrentLoadSource = "Lua"
	local result = include( path )
	self.CurrentLoadSource = nil
	return result
end

-- Loads library objects that were created using JSON in the `data` folder.
function meta:LoadDataLibary()
	local path = string.format( "%s%s/*.json", dataPath, self.Folder )
	local files, folders = file.Find( path, "DATA" )
	for _, fil in pairs( files ) do
		self:LoadDataJsonFile( fil )
	end
end

function meta:LoadLibrary()
	-- print( "Loading library type [" .. tostring( self.Name ) .. "]...")
	if ( not self.IsValidRealm ) then return end
	self.IsLoading = true
	-- print("\t Loading Lua library...")
	self:LoadLuaLibrary()
	-- print("\t Loading data library...")
	self:LoadDataLibary()
	self.IsLoading = false
	self.Loaded = true
	-- print("\tDone loading. Repository:")
	-- PrintTable( self.Repository )
	-- print( "===========================================================" )
end

function meta:LoadDataJsonFile( fileName )
	local path = string.format( "photon_v2/library/%s/%s", self.Folder, fileName)
	-- print( "Loading JSON file from data [" .. path .. "]" )
	
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
	-- print("\t Registering library entry [" .. tostring( data.Name ) .. "]" )
	self.Repository[data.Name] = data
	if ( not data.SourceType ) then data.SourceType = self.CurrentLoadSource or "Other" end
	if ( data.ReadOnly == nil ) then data.ReadOnly = true end
	if ( self.Loaded ) then
		self:OnReload( data )
	elseif ( self.EagerLoading ) then
		self:Compile( data )
	end
end

-- Called when an entry is reloaded.
function meta:OnReload( data )
	self:Compile( data )
end

-- Compilation wrapper. Actual compilation overrides should be done in `TYPE:DoCompile( data )`
---@param data table | string
function meta:Compile( data )
	if ( isstring( data ) ) then data = self:Get( data ) end
	local result = self:DoCompile( table.Copy( data --[[@as table]]) )
	self.Index[result.Name] = result
	return result
end

function meta:DoCompile( data )
	return data
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