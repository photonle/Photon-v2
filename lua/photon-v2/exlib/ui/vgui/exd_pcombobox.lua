local class = "EXDPComboBox"
local base = "EXDPBase"
local PANEL = {}

function PANEL:AddChoice(txt, data, sel)
	self.Value:AddChoice(txt, data, sel)
end

function PANEL:SetValue(text)
	self.Value:SetValue(text)
end

function PANEL:DoSetValueDisabled(val)
	self.Value:SetDisabled(val)
end

function PANEL:Init()
	local val = vgui.Create("DComboBox", self)
	val:Dock(FILL)
	val:DockMargin(0, 4, 0, 4)
	self.Value = val
	self:BasePostInit()
end

derma.DefineControl( class, "", PANEL, base )