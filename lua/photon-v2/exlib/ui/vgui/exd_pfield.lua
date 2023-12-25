local class = "EXDPField"
local base = "EXDPBase"

local PANEL = {}

PANEL.PropertyIcon = "textbox"

function PANEL:SetValue(text)
	text = text or "" -- to prevent literally "nil" 
	self.Value:SetValue(tostring(text))
end

function PANEL:DoSetValueDisabled(val)
	self.Value:SetDisabled(val)
end

function PANEL:OnSelected()
	self.Value:SetMouseInputEnabled(true)
	self.Value:SetPaintBackground(true)
end

function PANEL:OnDeselected()
	self.Value:SetMouseInputEnabled(false)
	self.Value:SetPaintBackground(false)
end

function PANEL:Init()
	local this = self
	local txt_Value = vgui.Create("DTextEntry", self)
	local defaultColor = Color(0, 0, 0)
	local changedColor = Color(0, 0, 255)
	txt_Value:SetTextColor(defaultColor)
	txt_Value:Dock(FILL)
	txt_Value:DockMargin(0, 4, 0, 4)
	-- txt_Value:SetPaintBackground(false)
	function txt_Value:OnChange()
		self:SetTextColor(changedColor)
	end
	function txt_Value:OnEnter()
		this:DoSetProperty(this.propertyIds[1], self:GetValue())
		self:SetTextColor(defaultColor)
	end
	txt_Value:SetPaintBackground(false)
	self.Value = txt_Value
	self:BasePostInit()
end

derma.DefineControl( class, "", PANEL, base )