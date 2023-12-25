local class = "EXDPAngle"
local base = "EXDPVector"

local PANEL = {}

PANEL.PropertyIcon = "axis-z-rotate-counterclockwise"

PANEL.Label1 = "P"
PANEL.Label2 = "Y"
PANEL.Label3 = "R"


function PANEL:SetValue(ang)
	print("Setting value", ang)
	self.Value = Angle(ang)
	self.XValue:SetValue(ang.p)
	self.YValue:SetValue(ang.y)
	self.ZValue:SetValue(ang.r)
	-- self.Value:SetValue(text)
end

function PANEL:OnChanged() 
	self:DoSetProperty(self.propertyIds[1], Angle(self.Value))
end

function PANEL:_valueChanged()
	self:OnChanged()
end

function PANEL:GetValue()
	-- return Vector()
end

function PANEL:Init()
	print("PROPERTY ICON VALUE IS", self.PropertyIcon)
	self.XLabel:SetIcon("alpha-p")
	self.YLabel:SetIcon("alpha-y")
	self.ZLabel:SetIcon("alpha-r")
	self:BasePostInit()
end

derma.DefineControl( class, "", PANEL, base )