exmeta = exmeta or {}

---Identical to exmeta.SetMetaTable but accepts a string for the base table's name.
---@param tbl any
---@param base string|table
function exmeta.Inherit(tbl, base)
	if isstring(base) then base = exmeta.FindMetaTable(base) end
	local r = exmeta.SetMetaTable(tbl, base)
	return r
end

local print = Photon2.Debug.Print

---@param obj table
---@param key string
---@param prototype table|string
---@param ref any
---(ref is the object that 'self' should point to)
function  exmeta.SetSubTable(obj, key, prototype, ref)
	ref = ref or obj
	prototype = prototype or obj[key]
	if (isstring(prototype)) then
		prototype = exmeta.FindMetaTable(prototype)
	end
	obj[key] = setmetatable({
		__self = ref,
		__prototype = prototype
		-- __prototype = setmetatable({}, {__index = prototype})
	}, {__index = function(t, k)
		if isfunction(t.__prototype[k]) then
			return function(self, ...)
				return t.__prototype[k](t.__self, unpack({...}))
			end
		end
		return t.__prototype[k]
	end})
	if istable(prototype.__subtables) then
		for k, t in pairs(prototype.__subtables) do
			exmeta.SetSubTable(obj[key], k, t, ref)
		end
	end
	if isfunction(prototype.__init) then
		prototype.__init(ref, key)
	end
end

---@param name string MetaTable Name
---@param tbl table Table
---@param base? string|table Base Class
---@param global? boolean Whether to expose as a global variable.
function exmeta.RegisterMetaTable(name, tbl, base, global)
	if (global == nil) then global = true end
	if isstring(base) then base = exmeta.FindMetaTable(base) end
	if base then
		tbl.Base = base
		debug.getregistry()[name] = exmeta.SetMetaTable(tbl, base)
	else
		debug.getregistry()[name] = tbl
	end
	if (global) then
		_G[name] = debug.getregistry()[name]
	end
	-- debug.getregistry()[name] = setmetatable(tbl, {__index = base})
	return FindMetaTable(name)
end

function exmeta.FindMetaTable(name)
	if debug.getregistry()[name] == nil then debug.getregistry()[name] = {} end
	return FindMetaTable(name)
end

function exmeta.LoadFile(filename, tableName, erase)
	tableName = tableName or "META"
	-- print("[EXMeta] Loading file: " .. tostring(filename))
	_NAME, _BASE, _META = NAME, BASE, _G[tableName]
	NAME, BASE = nil, nil
	_G[tableName] = {}
	exmeta._shouldReload = false
	include(filename)
	exmeta._shouldReload = true
	if NAME == nil then error("[EXMeta] Global NAME must be defined. If it is, verify that the filepath is correct.") end
	exmeta.LoadTable(NAME, BASE, _G[tableName], erase)
	NAME, BASE, _G[tableName] = _NAME, _BASE, _META
end

---@param name string
---@param base? string | table
---@param tbl table
---@param erase boolean
function exmeta.LoadTable(name, base, tbl, erase)
	-- local copy = table.Copy(tbl)
	local copy = tbl
	local meta = FindMetaTable(name)
	-- print("Name:", name)
	-- print("Base:", base)
	if (meta == nil) or (erase) then
		meta = exmeta.RegisterMetaTable(name, {}, base)
	end
	table.Merge(debug.getregistry()[name], copy)
	if isstring(base) or istable(base) then
		-- print("INHERITING FROM: '" .. tostring(base) .. "'")
		meta = exmeta.Inherit(meta, base --[[@as string | table]])
	else
		local metaTable = getmetatable( tbl )
		if metaTable then 
			setmetatable( debug.getregistry()[name], metaTable )
		end
	end
	-- if ( rawget( meta, "__call" ) ) then
	-- 	getmetatable( meta ).__call = meta.__call
	-- end
	meta.ClassName = name
	hook.Run("EXMeta.TableLoaded", name, meta, base)
end

function exmeta.ReloadFile(tableName, erase)
	local filename
	local source = debug.getinfo(2, "S").source
	if source:sub(1, 1) == "@" then
		source = source:sub(2)
		if ( string.StartWith(source, "lua/") ) then
			filename = source:sub(5)
		else
			local _, splitPos = string.find(source, "/lua/", 1, true)
			filename = source:sub(splitPos+1)
		end
	else
		return false
	end
	if exmeta._shouldReload then
		exmeta.LoadFile(filename, tableName, erase)
		return true
	end
	return false
end

function exmeta.LoadFolder(path, fol, tableName)
	fol = isstring(fol) and fol .. "/" or "exmeta/"
	fol = path .. fol
	-- print("[EXMeta] Loading folder '" .. tostring(fol) .. "'")
	local files = file.Find(fol .. "sh_*.lua", "LUA")
	for _, f in pairs(files) do
		AddCSLuaFile(fol .. f)
		exmeta.LoadFile(fol .. f, tableName)
	end
	files = file.Find(fol .. "sv_*.lua", "LUA")
	if SERVER then	
		for _, f in pairs(files) do
			exmeta.LoadFile(fol .. f, tableName)
		end
	end
	files = file.Find(fol .. "cl_*.lua", "LUA")
	for _, f in pairs(files) do
		AddCSLuaFile(fol .. f)
		if CLIENT then exmeta.LoadFile(fol .. f, tableName) end
	end
end

function exmeta.LoadCSFolder(path, fol, tableName)
	fol = isstring(fol) and fol .. "/" or "exmeta/"
	fol = path .. fol
	local files = file.Find(fol .. "*.lua", "LUA")
	PrintTable(files)
	for _, f in pairs(files) do
		AddCSLuaFile(fol .. f)
		if CLIENT then exmeta.LoadFile(fol .. f, tableName) end
	end
end

---Applies default/fallback values to a table.
---@param obj any
---@param metaTable? table|string
---@return table
function exmeta.SetMetaTable(obj, metaTable)
	if isstring( metaTable ) then metaTable = exmeta.FindMetaTable(metaTable) end
	if ( metaTable == nil ) then metaTable = obj; obj = {} end
	if not debug.setmetatable( obj, { __index = metaTable } ) then
		error("[EXMeta] Failed to set metatable of object [" .. tostring(obj) .. "]")
	end
	return obj
end

function exmeta.CopyTable(t, lookup_table)
	if ( t == nil ) then return nil end

	local copy = {}
	setmetatable( copy, debug.getmetatable( t ) )
	for i, v in pairs( t ) do
		if ( !istable( v ) ) then
			if (isvector(v)) then
				copy[ i ] = Vector(v)
			elseif (isangle(v)) then
				copy[ i ] = Angle(v)
			else
				copy[ i ] = v
			end
		else
			lookup_table = lookup_table or {}
			lookup_table[ t ] = copy
			if ( lookup_table[ v ] ) then
				copy[ i ] = lookup_table[ v ] -- we already copied this table. reuse the copy.
			else
				copy[ i ] = exmeta.CopyTable( v, lookup_table ) -- not yet copied. copy it.
			end
		end
	end
	return copy
end

---@return table
function exmeta.New()
	return _G["META"]
end

-- PrintTable(FindMetaTable("EXCar"))
-- PrintTable(FindMetaTable("EXCarTest"))