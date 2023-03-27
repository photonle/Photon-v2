-- if SERVER then return end
if not exmeta then return end

function GetCurrentLuaFile()
    local source = debug.getinfo(2, "S").source
    if source:sub(1,1) == "@" then
        return source:sub(2)
    else
        error("Caller was not defined in a file", 2)
    end
end

print("misc_testing.lua")
local function metaTableTests()
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
		Vector3 = Vector(3, 3, 3),
		GetVector1 = function(self)
			return Vector(99, 99, 99)
		end
	}, true)

	local tableA = exmeta.SetMetaTable({}, "TableA")
	local tableC = exmeta.SetMetaTable({}, "TableC")

	tableC.Vector1 = Vector(1, 0, 0)

	-- print(tableC:GetVector1())
	-- print(tableC.Vector3)
	-- tableC.Vector1 = nil
	-- print(tableC.Vector1)


	print("TABLE C ======================================")
	-- print(debug.getmetatable(tableC).__index)
	print(tableC:GetVector1())
	-- example of calling a base class function via the end-object
	-- self.Base.functionName(self)
	print(tableC.Base.GetVector1(tableC))
	-- print(debug.getmetatable(tableC).__index:GetVector1())
	print("\nTABLE A ======================================")
	-- print(tableA:GetVector1())
	-- example of calling a base class function via the base class itself
	print(TableA.GetVector1(tableC))
end

local function componentTestA()
	-- PrintTable(Photon2.Index["photon_fedsig_jetsolaris"])
	-- 03-13 passes
	PrintTable(Photon2.Index.Components)
	Photon2.Debug.Print( "Creating instance...")
	local component = Photon2.Index.Components["photon_fedsig_jetsolaris"]
	Photon2.Debug.Print( "\tLoading component...")
	
	-- local instance = Photon2.Index.Components["photon_fedsig_jetsolaris"]:Initialize()
end

-- componentTestA()

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

-- local dependencyTest = {
-- 	{ "level_1", false },
-- 	{ "level_2", false },
-- 	{ "level_3", false },
-- 	{ "level_1a", "level_1" },
-- 	{ "level_1aa", "level_1a"},
-- 	{ "level_1aaa", "level_1aa"},
-- 	{ "level_1aaaa", "level_1aaa"},
-- 	{ "level_3a", "level_3"},
-- }

-- local function buildDependencies( tbl )
-- 	local inpt = table.Copy( tbl )
-- 	table.Shuffle(inpt)
-- 	local result = {}

-- 	local count = 1

-- 	while (not table.IsEmpty(inpt)) do
-- 		for i, meta in pairs( inpt ) do
-- 			if ((meta[2] == false) or (table.HasValue(result, meta[2]))) then
-- 				table.insert( result, meta[1] )
-- 				inpt[i] = nil
-- 			end
-- 		end
-- 	end
-- 	return result
-- end

-- PrintTable(buildDependencies(dependencyTest))

-- local x = { 1, 2, 3, 4, 5,
-- 	["5xxx"] = 4
-- }

-- for i = 1, #x do
-- 	print(tostring(i) .. ": " .. tostring(x[i]))
-- end