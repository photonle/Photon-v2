if SERVER then return end

local function colorMapParseTesting()
	local block = "[R/W]"
	block = string.sub( block, 2, string.len(block) - 1 )
	print( block )
end

-- colorMapParseTesting()

local function metaTableBenchmark()
	local mt = {
		x = "from metatable"
	}

	local child = {}
	setmetatable( child, { __index = mt } )

	local start = SysTime()
	for i=1, 10000 do
		local val = "-" .. child.x
	end
	local mtTime = SysTime() - start
	print("MetaTable Time: " .. tostring(mtTime))

	start = SysTime()
	for i=1, 10000 do
		local val = "-" .. mt.x
	end
	local nrmTime = SysTime() - start
	print("Normal Time: " .. tostring(nrmTime))

	print("Normal time is: " .. tostring(1 - (nrmTime/mtTime)) .. "% faster.")
end

local function keyAccessBenchmark()
	local tab = {
		[1] = "N from metatable",
		["1"] = "S from metatable"
	}


	local start = SysTime()
	for i=1, 10000 do
		local val = "-" .. tab[1]
	end
	local mtTime = SysTime() - start
	print("Array Time: " .. tostring(mtTime))

	start = SysTime()
	for i=1, 10000 do
		local val = "-" .. tab[1]
	end
	local nrmTime = SysTime() - start
	print("String Time: " .. tostring(nrmTime))

	-- print("Normal time is: " .. tostring(1 - (nrmTime/mtTime)) .. "% faster.")
end

-- keyAccessBenchmark()

if true then return end
if not exmeta then return end

print("misc_testing.lua")

exmeta.LoadTable("TableA", nil, {
	Vector1 = Vector(1, 1, 1),
	GetVector1 = function(self)
		return self.Vector1
	end,
}, true)

exmeta.LoadTable("TableB", "TableA", {
	Vector2 = Vector(2, 2, 2)
}, true)

exmeta.LoadTable("TableC", "TableB", {
	Vector3 = Vector(3, 3, 3)
}, true)

local tableC = exmeta.SetMetaTable({}, "TableC")

tableC.Vector1 = Vector(1, 0, 0)
-- print(tableC:GetVector1())
-- print(tableC.Vector3)
-- tableC.Vector1 = nil
-- print(tableC.Vector1)

-- tableB.Vector1 = nil

-- local rootPath = "photon-v2/library/components/"
-- local path = "schmal/component.lua"
-- local ext = "." .. string.GetExtensionFromFilename(path)
-- if (string.StartsWith(path, rootPath)) then
-- 	local startAt = string.len(rootPath) + 1
-- 	local endAt = string.len(rootPath) - startAt - (string.len(ext))
-- 	path = string.sub(path, startAt, endAt)
-- end
-- print("path: " .. path)

-- local fileName = string.GetFileFromFilename("folder/component.lua")

-- local name = string.sub(string.GetPathFromFilename(fileName))

-- local files, folders = file.Find("photon-v2/library/components/*.lua", "LUA")
-- PrintTable(files)

local dependencyTest = {
	["level_1"] = false,
	["level_2"] = false,
	["level_3"] = false,
	["level_1a"] = "level_1",
	["level_1aa"] = "level_1a",
	["level_1aaa"] = "level_1aa",
	["level_1aaaa"] = "level_1aaa",
	["level_3a"] = "level_3",

	-- { "level_1a", "level_1" },
	-- { "level_1aa", "level_1a"},
	-- { "level_1aaa", "level_1aa"},
	-- { "level_1aaaa", "level_1aaa"},
	-- { "level_3a", "level_3"},
}

-- psuedo code
-- recurse every entry until its parent is loaded
-- while true do
-- if not index[comp.base] exists
-- 	continue
-- if baseclass, add to existing
local expected = {
	level_1 = {
		level_1a = {
			level_1aa = {
				level_1aaa = {
					level_aaaa = true
				}
			}
		}
	}
}

local function buildDependencies( tbl )
	local inpt = table.Copy( tbl )

	local result = {}
	local pending = {}
	local searching = true

	-- load top-level (merge this later)
	-- TODO: treat top-level and resolved as the same
	for _, meta in pairs( inpt ) do
		if not (meta[1]) then
			table.insert( result, meta[1] )
			table.RemoveByValue( inpt, meta[1] )
		end
	end

	local count = 1

	while (not table.IsEmpty(inpt)) do
		for _, meta in pairs( inpt ) do
			if (table.HasValue(inpt, meta[1])) then
				Photon2.Debug.Print("metatable found?")
				table.insert( result, meta[1] )
				table.RemoveByValue( inpt, meta[1] )
			end
		end
		count = count + 1
		if (count > 500) then 
			print("aborting dependency build")
			break 
		end
	end
	return result
end

--PrintTable(buildDependencies(dependencyTest))