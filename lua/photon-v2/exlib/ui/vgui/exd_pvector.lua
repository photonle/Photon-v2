local class = "EXDPVector"
local base = "EXDPBase"

local PANEL = {}

PANEL.PropertyIcon = "axis-arrow"

PANEL.Label1 = "X"
PANEL.Label2 = "Y"
PANEL.Label3 = "Z"

function PANEL:SetLabel(text)
	self.Label:SetText(text)
end

function PANEL:SetValue(vec)
	print("Setting value", vec)
	self.Value = Vector(vec)
	self.XValue:SetValue(vec.x)
	self.YValue:SetValue(vec.y)
	self.ZValue:SetValue(vec.z)
	-- self.Value:SetValue(text)
end

function PANEL:OnChanged() 
	-- print("NEW VALUE", self.Value)
	self:DoSetProperty(self.propertyIds[1], Vector(self.Value))
end

function PANEL:_valueChanged()
	self:OnChanged()
end

function PANEL:GetValue()
	-- return Vector()
end

function PANEL:DoSetValueDisabled(val)
	self.XValue:SetDisabled(val)
	self.YValue:SetDisabled(val)
	self.ZValue:SetDisabled(val)
end

function PANEL:OnSelected()
	self.ValuePanel:SetMouseInputEnabled(true)
	self.ValuePanel:SetKeyBoardInputEnabled(true)
	self.XValue:SetPaintBackground(true)
	self.XValue:SetMouseInputEnabled(true)
	self.YValue:SetPaintBackground(true)
	self.YValue:SetMouseInputEnabled(true)
	self.ZValue:SetPaintBackground(true)
	self.ZValue:SetMouseInputEnabled(true)
end

function PANEL:OnDeselected()
	self.ValuePanel:SetMouseInputEnabled(false)
	self.XValue:SetPaintBackground(false)
	self.YValue:SetPaintBackground(false)
	self.ZValue:SetPaintBackground(false)
end

function PANEL:Init()
	local p = self
	self.Value = Vector()
	self.ValuePanel = vgui.Create("DPanel", self)
	self.ValuePanel:SetDrawBackground(false)
	self.ValuePanel:Dock(FILL)
	self.ValuePanel:SetMouseInputEnabled(false)
	local xl = vgui.Create("EXDIcon", self.ValuePanel)
	-- xl:Dock(LEFT)
	xl:AlignLeft(-9)
	-- xl:AlignTop(4)
	xl:SetIcon("alpha-x", 24)
	-- xl:SetWidth(20)
	-- xl:SetText(self.Label1)
	-- xl:SetSize(14, 1)
	xl:SetWidth(16)
	xl:AlignTop(-3)
	xl:SetContentAlignment(4)
	-- xl:SetColor(Color(180, 0, 0))
	xl:CopyHeight(self)
	-- xl:InvalidateLayout(false)
	self.XLabel = xl
	local x = vgui.Create("EXDNumberWang", self.ValuePanel)
	x:SetPos(0, 0)
	x:SetSize(52, 1)
	x:Dock(LEFT)
	x:DockMargin(14, 4, 0, 4)
	x:SetInterval(0.01)
	x:SetMin(-9999)
	function x:OnValueChanged()
		-- local v = Vector(p.Value)
		p.Value[1] = x:GetValue()
		p:_valueChanged()
	end
	self.XValue = x
	local yl = vgui.Create("EXDIcon", self.ValuePanel)
	yl:Dock(LEFT)
	yl:SetWidth(20)
	yl:SetIcon("alpha-y", 24)
	yl:AlignTop(-3)
	yl:DockMargin(-3, 0, 0, 0)
	yl:SetContentAlignment(5)
	-- yl:SetColor(Color(0, 140, 0))
	yl:CopyHeight(self)
	self.YLabel = yl
	local y = vgui.Create("EXDNumberWang", self.ValuePanel)
	y:SetPos(0, 0)
	y:SetSize(52, 1)
	y:Dock(LEFT)
	y:DockMargin(2, 4, 0, 4)
	y:SetMin(-9999)
	function y:OnValueChanged()
		p.Value[2] = y:GetValue()
		p:_valueChanged()
	end
	self.YValue = y
	local zl = vgui.Create("EXDIcon", self.ValuePanel)
	zl:Dock(LEFT)
	zl:SetWidth(20)
	zl:SetIcon("alpha-z", 24)
	zl:AlignTop(-3)
	zl:DockMargin(-3, 0, 0, 0)
	zl:SetContentAlignment(5)
	zl:CopyHeight(self)
	-- zl:SetColor(Color(0, 0, 180))
	self.ZLabel = zl
	local z = vgui.Create("EXDNumberWang", self.ValuePanel)
	z:SetPos(0, 0)
	z:SetSize(52, 1)
	z:Dock(LEFT)
	z:DockMargin(2, 4, 0, 4)
	z:SetMin(-9999)
	self.ZValue = z
	function z:OnValueChanged()
		p.Value[3] = z:GetValue()
		p:_valueChanged()
	end
	self:BasePostInit()
	self:OnDeselected()
end

derma.DefineControl( class, "", PANEL, base )