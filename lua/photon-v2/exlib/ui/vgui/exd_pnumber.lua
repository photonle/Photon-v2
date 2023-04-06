print("[EX VGUI] exd_pnumber.lua")

local class = "EXDPNumber"
local base = "EXDPBase"

local PANEL = {}

PANEL.PropertyIcon = "numeric"

function PANEL:OnSelected()
	self.Value:SetPaintBackground(true)
	self.Value:SetMouseInputEnabled(true)
end

function PANEL:OnDeselected()
	self.Value:SetPaintBackground(false)
	self.Value:SetMouseInputEnabled(false)
end

function PANEL:SetValue(text)
	text = text or "" -- to prevent literally "nil" 
	self.Value:SetValue(tostring(text))
end

function PANEL:DoSetValueDisabled(val)
	self.Value:SetDisabled(val)
end

function PANEL:Init()
	local this = self
	local value = vgui.Create("EXDNumberWang", self)
	value:Dock(FILL)
	value:DockMargin(0, 4, 0, 4)
	function value:OnValueChanged(val)
		this:DoSetProperty(this.propertyIds[1], val)
	end
	self.Value = value
	self:BasePostInit()
	self:OnDeselected()
end

derma.DefineControl( class, "", PANEL, base )