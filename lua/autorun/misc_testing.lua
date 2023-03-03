-- if SERVER then return end
if not exmeta then return end

print("misc_testing.lua")

-- exmeta.LoadTable("TableA", nil, {
-- 	Vector1 = Vector(1, 1, 1),
-- 	GetVector1 = function(self)
-- 		return self.Vector1
-- 	end,
-- }, true)

-- exmeta.LoadTable("TableB", "TableA", {
-- 	Vector2 = Vector(2, 2, 2)
-- }, true)

-- exmeta.LoadTable("TableC", "TableB", {
-- 	Vector3 = Vector(3, 3, 3)
-- }, true)

-- local tableC = exmeta.SetMetaTable({}, "TableC")

-- tableC.Vector1 = Vector(1, 0, 0)

-- print(tableC:GetVector1())
-- print(tableC.Vector3)
-- tableC.Vector1 = nil
-- print(tableC.Vector1)

-- tableB.Vector1 = nil

-- local rootPath = "photon_v2/library/components/"
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

-- local files, folders = file.Find("photon_v2/library/components/*.lua", "LUA")
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

local x = {
	[0] = 1,
	[2] = 3,

}

PrintTable(x)