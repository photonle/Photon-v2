--[[
	Performance notes:

	- Using integer keys when declaring a table does NOT make it an array
	- Table integer keys are slower to retrieve than strings
	- Actual array lookups are only as fast as table string lookups

	- Function overhead made test ~25% slower (needs more evaluation)

	- Table key string length has no performance impact
	- Local table look-up is just ~2% slower than a local variable

	- Metatable lookups seem to be ~20-30% slower than direct access
		- Consolidating the metatable properties seems effective
]]


if SERVER then return end

local SysTime = SysTime

local function tableVsLocal()
	local start = SysTime()
	
	local x = {
		["abc"] = "abc"
	}
	local abc = "abc"

	local tblStart = SysTime()
	for i=1, 1000000 do 
		local val = "-" .. x.abc
	end
	local tblTime = SysTime() - tblStart

	local locStart = SysTime()
	for i=1, 1000000 do 
		local val = "-" .. abc
	end
	local locTime = SysTime() - locStart

	print("Table: " .. tostring(tblTime))
	print("Local: " .. tostring(locTime))
	print("Local is: " .. tostring((1 - (locTime/tblTime))*100) .. "% faster.")

end

-- tableVsLocal()

local function colorMapParseTesting()
	local block = "[R/W]"
	block = string.sub( block, 2, string.len(block) - 1 )
	print( block )
end


-- colorMapParseTesting()

local function metaTableBenchmark()
	local start = SysTime()
	local mt = {
		x = "from metatable"
	}

	local child = {}
	setmetatable( child, { __index = mt } )

	local grandchild = {}
	setmetatable( grandchild, { __index = child })
	
	-- grandchild.x = grandchild.x

	print("grandchild.x: " .. tostring(grandchild.x))


	
	
	start = SysTime()
	for i=1, 100000 do
		local val =  "x" .. mt.x
		-- local val = grandchild.x
		-- uselessFunction()
		
	end
	local nmTime = SysTime() - start
	
	start = SysTime()
	for i=1, 100000 do
		-- local val = grandchild.x
		-- local y = val
		-- local z = y
		local val = "x" .. grandchild.x
		-- uselessFunction()
	end
	local mtTime = SysTime() - start

	print("Normal Time: " .. tostring(nmTime))
	print("MetaTable Time: " .. tostring(mtTime))
	print("Normal time is: " .. tostring((1 - (nmTime/mtTime))*100) .. "% faster.")
end
-- metaTableBenchmark()


local function keyAccessBenchmark()
	local arr = {
		true, true
		-- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	}
	arr[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	local tab = {
		[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		["ABCDEFGHIJKLMNOPQRSTUVWXYZ"] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	}

	local function access( key )
		return tab[key]
	end
	

	local start = SysTime()
	for i=1, 10000 do
		local val = "-" .. access( 1 )
		-- local val = "-" .. arr[1]
		-- local val = string.format("-%s", tab[1])

	end
	local arrTime = SysTime() - start
	print("INT Time: " .. tostring(arrTime))

	start = SysTime()
	for i=1, 10000 do
		-- local val = string.format("-%s", tab["1"])
		-- local val = "-" .. tab.ABCDEFGHIJKLMNOPQRSTUVWXYZ
		-- local val = "-" .. tab["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
		local val = "-" .. access("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
	end
	local nrmTime = SysTime() - start
	print("STR Time: " .. tostring(nrmTime))

	-- print("Normal time is: " .. tostring(1 - (nrmTime/mtTime)) .. "% faster.")
end



--[[
	Function overhead:
	INT Time: 0.00027810000028694
	STR Time: 0.00024860000121407
	
	Direct access:
	INT Time: 0.00025180000375258
	STR Time: 0.00020709999807877
]]


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