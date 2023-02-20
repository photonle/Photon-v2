-- if SERVER then return end
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

local files, folders = file.Find("photon_v2/library/components/*.lua", "LUA")
PrintTable(files)