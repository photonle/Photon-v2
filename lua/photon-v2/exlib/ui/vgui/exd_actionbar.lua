print("[EX VGUI] exd_actionbar.lua")

local class = "EXDActionBar"
local base = "DPanel"
local description = "EX UI Actionbar"
local PANEL = {}

PANEL.Placement = "Float"

PANEL.Align = LEFT

function PANEL:Init()
	self:SetHeight(28)
	self:DockPadding(1, 1, 1, 1)
	-- self:SetDrawBackground(false)
end

function PANEL:Paint(w, h)
	derma.SkinHook( "Paint", "ActionBar", self, w, h )

end

function PANEL:AddButton(name, icon, action, label)
	local b = vgui.Create("EXDActionBarButton", self)
	b:Dock(self.Align)
	b:SetLabel(label)
	b:SetIcon(icon)
	print("TOOL TIP/NAME", name)
	if istable(name) then
		error("TOOL TIP BEING SET TO SOMETHING DUMB")
	end
	b:SetToolTip(name)
	if isfunction(action) then
		b.DoClick = action
	end
end

derma.DefineControl( class, description, PANEL, base )