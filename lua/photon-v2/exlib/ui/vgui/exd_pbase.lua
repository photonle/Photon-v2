print("[EX VGUI] exd_pcombobox.lua")

local class = "EXDPBase"
local base = "DLabel"
local PANEL = {}

surface.CreateFont("EXD.Label", {
	font = "Consolas",
	weight = 100,
	size = 12
})

PANEL.PropertyIcon = false

function PANEL:OnSelected() end

function PANEL:OnDeselected() end

function PANEL:DoSelect()
	self:SetLabelColor(Color(0, 0, 0, 245))
	-- self:SetLabelColor(self:GetSkin().Colours.Label.Highlight)
	self:OnSelected()
end

function PANEL:DoDeselect()
	self:SetLabelColor(self:GetSkin().Colours.Label.Default)
	self:OnDeselected()
end

function PANEL:SetSelected(selected)
	self.Selected = selected
	if (selected) then
		self:DoSelect()
		print(self:GetLabel(), "SELECTED")
	else
		self:DoDeselect()
	end
end

function PANEL:GetSelected()
	return self.Selected
end

function PANEL:SetLabelColor(color)
	self.m_LabelColor = color
	self.Label:SetTextColor(color)
	self.actionMenuButton:SetTextColor(color)
	self.m_PropertyIcon:SetTextColor(color)
end

function PANEL:GetLabelColor()
	return self.m_LabelColor
end

function PANEL:SetFormParent(parent)
	self.m_FormParent = parent
end

function PANEL:GetFormParent()
	return self.m_FormParent
end

function PANEL:OnChange(property, value) 
	print("[PROPERTY CHANGE]", property, value)
end

function PANEL:SetLabel(text)
	-- text = string.upper(text)
	self.Label:SetText(text)
end

function PANEL:GetLabel()
	return self.Label:GetText()
end

function PANEL:SetPropertyID(properties)
	if (istable(properties)) then
		self.propertyIds = table.Merge(self.propertyIds, properties)
	else
		self.propertyIds = { properties }
	end
end

function PANEL:DoSetProperty(property, value)
	-- print("[DO SET PROPERTY]", property, value)
	if (self.propertyStates[property] == tostring(value)) then
		-- print(" 	=> NO CHANGE DETECTED", "OLD:", self.propertyStates[property])
		return
	end
	self.propertyStates[property] = tostring(value)
	self:OnChange(property, value)
end

function PANEL:Paint(w, h)
	if self.Selected then
		surface.SetDrawColor(0, 0, 0, 66)
		surface.DrawRect(0, 0, w, h)
	elseif self.Hovered then
		surface.SetDrawColor(255, 255, 255, 225)
		surface.DrawRect(0, 0, w, h)
	end
end

function PANEL:PaintOver(w, h)
	if self.Selected then
		DisableClipping(true)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, h - 1, w, 1)
		surface.DrawRect(0, -1, w, 1)
		DisableClipping(false)
		surface.SetDrawColor(0, 0, 255)
		surface.DrawRect(0, 0, 3, h - 1)
	else
		surface.SetDrawColor(200, 200, 200)
		surface.DrawRect(0, h - 1, w, 1)
	end
	
end

function PANEL:SetSourceIcon(name)
	self.sourceIcon = name
	self.actionMenuButton:SetIcon(name)
end

function PANEL:GetSourceIcon()
	return self.sourceIcon
end

function PANEL:SetPropertyIcon(icon, toolTip)
	self.m_PropertyIcon:SetIcon(icon)
	self.m_PropertyIcon:SetToolTip(toolTip)
end

function PANEL:DoSetValueDisabled() end

function PANEL:SetValueDisabled(val)
	self.isDisabled = val
	self:DoSetValueDisabled(val)
end

function PANEL:GetValueDisabled()
	return self.isDisabled
end

-- function PANEL:SetPropertyID(prop)

function PANEL:OnSetupActionMenu() end

function PANEL:ShowActionMenu()
	local m = DermaMenu(self)
	m:SetSkin("PhotonStudio")
	m:AddOption("Action Option", function()
		print("Action Option Clicked")
	end)
	self.actionMenu = m
	self:OnSetupActionMenu(m)
	m:Open()
end

function PANEL:BasePostInit()
	self.m_PropertyIcon:SetIcon(self.PropertyIcon)
	self:SetMouseInputEnabled(true)
end

function PANEL:Select()
	print("ATTEMPTING SELECTION")
	self:GetFormParent():SetSelected(self.propertyIds)
end

function PANEL:OnDepressed()
	self:Select()
end

function PANEL:Init()
	local this = self
	self:SetMouseInputEnabled(true)
	self:SetText("")
	self.propertyIds = { 1, 2, 3, 4 }
	self.propertyStates = {}
	self:DockPadding(0, 2, 8, 3)
	self:SetPaintBackground(false)
	self:SetHeight(36)
	local indicatorParent = vgui.Create("Panel", self)
	indicatorParent:Dock(LEFT)
	indicatorParent:SetWidth(24)
	indicatorParent:DockPadding(0, 4, 0, 0)
	indicatorParent:SetMouseInputEnabled(false)
	-- indicatorParent:SetSize(32, 1)
	local propertyIcon = vgui.Create("EXDIcon", indicatorParent)
	propertyIcon:SetSize(16, 16)
	propertyIcon:SetIcon(self.PropertyIcon)
	-- propertyIcon:SetMouseInputEnabled(fals)
	-- indicator:SetImage("icon16/table_link.png")
	self.m_PropertyIcon = propertyIcon


	local lbl_Label = vgui.Create("DLabel", self)
	lbl_Label:SetSize(84, 1)
	lbl_Label:Dock(LEFT)
	lbl_Label:DockMargin(2, 0, 2, 0)
	lbl_Label:SetFont("EXUI.PropertyLabel")

	-- lbl_Label:SetFontInternal("Default")
	self.Label = lbl_Label

	local quickActions = vgui.Create("DPanel", self)
	quickActions:SetDrawBackground(false)
	quickActions:SetWidth(24)
	quickActions:Dock(RIGHT)
	quickActions:DockMargin(4, 4, 0, 4)
	-- quickActions:SetMouseInputEnabled(false)

	-- local configButton = vgui.Create("DButton", quickActions)
	-- configButton:SetWide(24)
	-- configButton:DockPadding(4, 4, 4, 4)
	-- configButton:SetText("")
	-- configButton:Dock(RIGHT)

	local actionMenuButton = vgui.Create("EXDIcon", quickActions)
	actionMenuButton:SetIconSize(16)
	actionMenuButton:SetIcon("dots-horizontal")
	actionMenuButton:SetPressedIcon("dots-horizontal-circle")
	actionMenuButton:SetWide(24)
	actionMenuButton:DockPadding(4, 4, 4, 4)
	actionMenuButton:Dock(RIGHT)
	function actionMenuButton:DoClick()
		this:ShowActionMenu()
	end
	self.actionMenuButton = actionMenuButton
	-- actionMenuButton:SetSize(16, 16)
	-- actionMenuButton:Dock(FILL)
	-- actionMenuButton:SetMouseInputEnabled(true)

	propertyIcon:Center()
	propertyIcon:AlignTop(7)

	self:SetCursor("hand")

end

derma.DefineControl( class, "", PANEL, base )
