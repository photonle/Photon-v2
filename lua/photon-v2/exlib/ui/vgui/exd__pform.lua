local class = "EXPForm"
local base = "DPanel"
local PANEL = {}

PANEL.IsEXPForm = true

PANEL.DataTypes = {
	string = "String",
	Vector = "Vector",
	number = "Number",
	Angle = "Angle",
	boolean = "Boolean"
}

PANEL.DataControlTypes = {
	Vector = "EXDPVector",
	String = "EXDPField",
	Number = "EXDPNumber",
	Angle = "EXDPAngle",
	Boolean = "EXDPBool"
}

function PANEL:ClearForm()
	self.m_Form:Clear()
	self.ActionBarBottom:Clear()
	self.ActionBarTop:Clear()
end

function PANEL:Init()
	self:SetSkin("PhotonStudio")
	self.Categories = {}
	self.Properties = {}
	self:DockMargin(0, 0, 0, 0)
	self:Dock(FILL)
	local tab = vgui.Create("EXDActionBar", self)
	tab:Dock(TOP)
	tab:SetZPos(1000)
	tab.Placement = "Top"
	self.ActionBarTop = tab
	local bab = vgui.Create("EXDActionBar", self)
	bab:Dock(BOTTOM)
	bab.Align = RIGHT
	bab:SetZPos(1001)
	self.ActionBarBottom = bab
	bab.Placement = "Bottom"
	local container = vgui.Create("DPanel", self)
	container:DockPadding(1, 1, 2, 1)
	container:Dock(FILL)
	container.Style = "NormalMid"
	local f = vgui.Create("DScrollPanel", container)
	f:Dock(FILL)
	-- timer.Simple(0.1, function()
	-- 	self:InvalidateLayout(true)
	-- end)
	self.m_Form = f
	-- self:DockPadding(0, 0, 4, 0)
	-- self:DockPadding(4, 4, 4, 4)
end

function PANEL:SetSelected(id)
	print("CHANGING SELECTED TO", id)
	-- TODO: multi-property panel IDs ???
	-- if istable(id) then
	-- 	id = id[1]
	-- end
	self.m_SelectedID = id
	for _id, pnl in pairs(self.Properties) do
		if id == pnl.propertyIds then 
			pnl:SetSelected(true)
			self.m_SelectedPanel = pnl
		else
			pnl:SetSelected(false)
		end
	end
	--
	self.ActionBarBottom:Clear()
	self.ActionBarBottom:AddButton(table.concat(id, "/"), "trash-can")
end

function PANEL:GetSelected()
	return self.m_SelectedID, self.m_SelectedPanel
end

surface.CreateFont("EXPDCollapsibleCategory", {
	font = "Roboto",
	size = 17,
	weight = 900
})

function PANEL:AddCategory(category, label)
	if IsValid(self.Categories[category]) then
		self.Categories[category]:Remove()
	end
	local c = vgui.Create("DCollapsibleCategory", self.m_Form)
	c.Header:SetFont("EXUI.PropertyHeader")
	c:DockMargin(0, 0, 0, 0)
	c:SetLabel(string.upper(label or category))
	c:Dock(TOP)
	c.NewPropertyPanel = vgui.Create("EXDPAdd", c)
	self.Categories[category] = c
	return c
end

function PANEL:AddEXPControl(properties, class, label, value, category)
	local parent = self.m_Form
	if (category) then
		if not (self.Categories[category]) then 
			self:AddCategory(category)
		end
		parent = self.Categories[category]
	end
	-- parent = parent or self
	local c = vgui.Create(class, parent)
	c:Dock(TOP)
	-- c:DockMargin(4, 0, 4, 0)
	c:SetLabel(label)
	c:SetPropertyID(properties)
	c:SetFormParent(self)
	if (value) then
		c:SetValue(value)
	end
	
	if istable(properties) then
		for _, property in pairs(properties) do
			self.Properties[property] = c
		end
	else
		self.Properties[properties] = c
	end

	return c
end

function PANEL:AddAutoDataControl(properties, typeName, ...)
	local result = self.DataTypes[typeName]
	result = result or "String"
	return self:AddDataControl(properties, result, unpack({...}))
end

function PANEL:AddDataControl(properties, class, ...)
	if self.DataTypes[class] then 
		class = self.DataTypes[class] 
	end
	if self.DataControlTypes[class] then
		return self:AddEXPControl(properties, self.DataControlTypes[class], unpack({...}))
	else
		error("[EXD Photon Form] Attempt to add unregistered/unknown data type: " .. tostring(class))
	end
end

function PANEL:SetSchemaFile(fileName, path)
	path = path or "GAME"
	return self:SetSchemaJSON(file.Read(fileName, path))
end

function PANEL:SetSchemaJSON(tbl)
	local schema = {}
	for k, data in pairs(tbl) do
		schema[k] = {
			Label = data.title or k,
			Type = data.gmType or data.type,
			Tooltip = data.description,
			Category = data.category or "Other"
		}
	end
end

function PANEL:SetSchema(schema)
	self.schema = schema
end

function PANEL:GetSchema()
	return self.schema or {}
end

function PANEL:GetSchemaProperties(term, category)
	term = string.lower(term)
	local result = {}
	local termMatch, categoryMatch = false, false
	for k, v in pairs(self:GetSchema()) do
		if (term) then
			if (string.StartWith(string.lower(v.Label), term)) then
				-- result[#result+1] = v.Label
				termMatch = true
			end
		else
			termMatch = true
		end
		
		if (category) then
			print("[CATEGORY]", "Search:", string.lower(category), "Schema:", string.lower(v.Category))
			if (string.lower(category) == string.lower(v.Category)) then
				print("CATEGORY IS A MATCH")
				categoryMatch = true
			end
		else
			categoryMatch = true
		end

		if (termMatch and categoryMatch) then
			result[#result+1] = v.Label
		end
		termMatch, categoryMatch = false, false
	end
	return result
end

derma.DefineControl(class, "", PANEL, base)

