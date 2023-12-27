exui = exui or {}

local draw = draw
local surface = surface

local folder = "photon-v2/exlib/ui/"


for _, File in pairs(file.Find(folder .. "vgui/*.lua", "LUA")) do
	AddCSLuaFile(folder .. "vgui/" .. File)
	include(folder .. "vgui/" .. File)
end

surface.CreateFont("EXUI.PropertyLabel", {
	font = "Tahoma",
	size = 13,
	weight = 500
})

-- surface.CreateFont("EXUI.PropertyHeader", {
-- 	font = "Helvetica World",
-- 	size = 20,
-- 	weight = 700
-- })

function exui.CreateShadowFont(name, data, textAdditive, shadowAdditive, shadowBAdditive, edgeBlur, outerBlur)
	data.additive = textAdditive
	surface.CreateFont(name, data)
	data.blursize = edgeBlur or 1
	data.additive = shadowAdditive
	surface.CreateFont(name .. ".Shadow", data)
	if (outerBlur) then
		data.blursize = outerBlur
	else
		if (data.size < 16) then
			data.blursize = 3
		else
			data.blursize = 6
		end
	end
	data.additive = shadowAdditive
	surface.CreateFont(name .. ".ShadowB", data)
end

function exui.DrawShadowText(text, font, x, y, color, shadow, align, densityEdge, densitySpread)
	for i=1, densitySpread or 1 do
		draw.DrawText(text, font .. ".ShadowB", x, y, shadow, align)
	end
	for i=1, densityEdge or 1 do
		draw.DrawText(text, font .. ".Shadow", x, y, shadow, align)
	end
	draw.DrawText(text, font, x, y, color, align)
end

function exui.GenerateFormJSONSchema(schema)
	local result = {}
	for k, data in pairs(schema) do
		result[k] = {
			Label = data.title or k,
			Type = data.gmType or data.type,
			Tooltip = data.description,
			Category = data.category
		}
	end
	return result
end

local function utfChar(code)
	return utf8.char(tonumber(code, 16))
end

exui.IconSizes = { 16, 24, 32, 48, 56, 60, 64, 96 }

-- Extended icons/reference: https://cdn.materialdesignicons.com/4.7.95/

---------------------------
-- Icon Update Procedure --
---------------------------
-- 		1. Download SVG icons (https://github.com/Templarian/MaterialDesign-SVG)
-- 		2. Import all SVG files to the IcoMoon app (https://icomoon.io/app/)
--		3. Change font name to EXUI MDI (may be changed to "EXUI-MDI", so rename the font string below)
--		4. Download, copy TTF to resource/fonts/
--			- [Flare] GarrysModDS/garrysmod/addons/ex/resource/fonts
--		5. Save selection.json from the IcoMoon folder as lua/exlib/ui/mdi-selection.json
--		6. Run exui.ParseMaterialIconsCodeFileIM() (builds the index/map)
--		7. Paste clipboard text into mdi-index.json
--		8. Delete mdi-selection.json (as it serves no other purpose)
--		9. Finished
---------------------------
--		IMPORTANT		 --
---------------------------
-- 		UTF code points cannot be greater than 65535 (game limitation).
--
--		A custom-made TTF using the MDI SVGs is probably necessary
--		to use all available icons. As of Dec 2019, IcoMoon can do this.
--
--		As of Aug 2020, this should not be a problem as long as the font
--		is extended...?
--
----------------------------

exui.materialIconSizes = exui.materialIconSizes or {}

function exui.LoadMaterialIconsIndex()
	exui.MaterialIconsIndex = util.JSONToTable(file.Read("lua/photon-v2/exlib/ui/mdi-index.json", "GAME"))
end

function exui.GetMDIFont( size )
	if not exui.materialIconSizes[size] then
		surface.CreateFont("MaterialIcons" .. size, {
			font = "EXUI-MDI",
			extended = true,
			size = size
		})
		exui.materialIconSizes[size] = true
	end
	return "MaterialIcons" .. tostring(size)
end

-- function exui.CreateMDIFonts()
-- 	if true then return end
-- 	for _,size in pairs(exui.IconSizes) do
-- 		surface.CreateFont("MaterialIcons" .. size, {
-- 			font = "EXUI MDI",
-- 			extended = true,
-- 			size = size
-- 		})
-- 	end
-- end

function exui.ParseMaterialIconsCodeFileIM(json)
	if not json then
		file.Read("lua/photon-v2/exlib/ui/mdi-selection.json", "GAME")
	end
	local tbl = util.JSONToTable(json)
	local result = {}
	for k, v in pairs(tbl.icons) do
		result[v.properties.name] = utf8.char(v.properties.code)
		-- print("NAME: " .. v.properties.name, "CODE:", v.properties.code )
	end
	json = util.TableToJSON(result, true)
	SetClipboardText(json)
	return json
end

function exui.ParseMaterialIconsCodeFile(codePoints)
	local icons = {}
	if not (codePoints) then 
		print("The code points string was nil.")
		return false 
	end
	codePoints = string.lower(codePoints)
	-- local tab = "{\n"
	local lines = string.Split(codePoints, "\n")
	local split, name, code, line
	for i=1,#lines do
		line = lines[i]
		split = string.find(line, " ")
		name = string.sub(line, 1, split - 1)
		if (i < #lines) then
			code = string.sub(line, split + 1, -2)
		else
			code = string.sub(line, split + 1, -1)
		end
		local decimal = tonumber("0x" .. tostring(code))
		if (decimal > 65535) then
			print("MDI Icon", name, "exceeds UTF limit (" .. tostring(code) .. " = " .. tostring(decimal) .. ")" )
		end
		-- print("DECIMAL OF FONT:", decimal)
		icons[name] = utfChar(code)
		-- tab = tab .. '["' .. name .. '"] = "' .. iconIndex[name] .. '",\n'
	end
	local result = util.TableToJSON(icons, true)
	SetClipboardText(result)
	return result
end

-- local mdiIndex = exui.ParseMaterialIconsCodeFile(file.Read("lua/exlib/ui/mdi-codes.txt", "GAME"))

function exui.MaterialIconCode(code)
	return utfChar(code)
end

function exui.MaterialIcon(name)
	if not name then return "" end
	if not exui.MaterialIconsIndex then exui.LoadMaterialIconsIndex() end
	return exui.MaterialIconsIndex[name] or "?"
end

function exui.FindIcon( name )
	if not exui.MaterialIconsIndex then exui.LoadMaterialIconsIndex() end
	return exui.MaterialIconsIndex[name]
end

MaterialIcon = exui.MaterialIcon

function EXDermaMenu( parentmenu, parent )

	if ( !parentmenu ) then CloseDermaMenus() end

	local dmenu = vgui.Create( "EXDMenu", parent )

	return dmenu

end

-- exui.CreateMDIFonts()
-- exui.LoadMaterialIconsIndex()



-- local function verifyCodePoints()
-- 	for 
-- end

-- print("NUMBER:", tonumber(0xe900))

-- local mdiSelection = util.JSONToTable(file.Read("lua/exlib/ui/mdi-selection.json", "GAME"))

-- for k, v in pairs(mdiSelection.icons) do
-- 	print("NAME: " .. v.properties.name, "CODE:", v.properties.code )
-- end

-- exui.ParseMaterialIconsCodeFileIM(file.Read("lua/exlib/ui/mdi-selection.json", "GAME"))