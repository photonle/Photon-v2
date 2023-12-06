if (exmeta.ReloadFile()) then return end

NAME = "PhotonLibraryType"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLibraryType
---@field Name string Primary type name. Example: `InputConfigurations`
---@field Folder string Folder/alternate type name. Example: `input_configuration`
---@field IsLoading boolean When true, library entries are still being loaded. This is to hint that's unsafe to attempt object inheritance.
---@field Loaded boolean Indicates
---@field Repository table<string, table>
local meta = exmeta.New()

local dataPath = "photon_v2/library/"
local luaPath = "photon-v2/library/"

function meta.New( properties )
	local result = setmetatable( properties, { __index = meta } )
	Photon2.Library.Repository[result.Name] = Photon2.Library.Repository[result.Name] or {}
	result.Repository = Photon2.Library.Repository[result.Name]
	result.Loaded = false
	return result
end

function meta:ToJson( data )
	return util.TableToJSON( data, true )
end

function meta:FromJson( json )
	return util.JSONToTable( json )
end

-- Loads library objects that were created in Lua
function meta:LoadLuaLibrary()
	local path = luaPath .. self.Folder
	local files, folders = file.Find( path .. "*lua", "LUA" )
	for _, fil in pairs( files ) do
		self:LoadLuaFile( path .. fil )
	end
end

function meta:LoadLuaFile( path )
	return include( path )
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
	self.IsLoading = true
	self:LoadLuaLibrary()
	self:LoadDataLibary()
	self.IsLoading = false
	self.Loaded = true
end

function meta:LoadDataJsonFile( fileName )
	print( "Loading JSON file from data [" .. fileName .. "]" )
	local data = self:FromJson( file.Read(
		string.format( "photon_v2/library/%s/%s.json", self.Folder, fileName)
	) )
	return self:Register( self:FromJson( text ) )
end

function meta:Get( name )
	return self.Repository[name]
end

function meta:Register( data )

end

-- Loads library objects that were created using JSON in the `data_static` folder.
-- This is for Workshop addons so GMAs can use JSON files. Implementation by Facepunch
-- is currently half-assed so this function is not yet available.
function meta:LoadDataStaticLibrary()

end