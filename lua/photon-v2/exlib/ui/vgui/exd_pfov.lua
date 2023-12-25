local class = "EXDPFOV"
local base = "EXDPBase"

local PANEL = {}

function PANEL:SetValue(text)
	text = text or "" -- to prevent literally "nil" 
	self.Value:SetValue(tostring(text))
end

function PANEL:Init()
	local txt_Value = vgui.Create("DTextEntry", self)
	txt_Value:Dock(FILL)
	txt_Value:DockMargin(0, 4, 0, 4)
	self.Value = txt_Value
end

derma.DefineControl( class, "", PANEL, base )