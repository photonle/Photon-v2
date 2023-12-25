local class = "EXDPBool"
local base = "EXDPBase"

local PANEL = {}

PANEL.PropertyIcon = "format-list-checks"

function PANEL:SetValue(val)
	val = val or false
	self.Value:SetValue(val)
end

function PANEL:Init()
	local this = self
	local cbox = vgui.Create("DCheckBox", self)
	cbox:Dock(LEFT)
	cbox:DockMargin(0, 8, 0, 8)
	-- cbox:SetText("")
	self.Value = cbox
	function cbox:OnChange(val)
		this:DoSetProperty(this.propertyIds[1], val)
	end
	self:BasePostInit()
end

derma.DefineControl( class, "", PANEL, base )