local class = "EXDIcon"
local base = "DLabel"

local PANEL = {}

function PANEL:Init()
	self:SetText("")
	self:SetIconSize(16)
	self:SetMouseInputEnabled(true)
	self:SetContentAlignment(5)
end

function PANEL:SetIconSize(size)
	self.iconSize = size
	self:SetFont(exui.GetMDIFont(size))
end

function PANEL:GetIconSize()
	return self.iconSize
end

function PANEL:SetIcon(name, size)
	self.icon = name
	if isnumber(size) then
		self:SetIconSize(size)
	end
	self:SetText(exui.MaterialIcon(name))
end

function PANEL:GetIcon()
	return self.icon
end

function PANEL:OnDepressed()
	if self.pressedIcon then
		self:SetText(exui.MaterialIcon(self.pressedIcon))
	end
end

function PANEL:OnReleased()
	if self.pressedIcon then
		self:SetText(exui.MaterialIcon(self.icon))
	end
end

function PANEL:OnCursorEntered()
	self:InvalidateLayout(true)
	if self.hoverIcon then
		self:SetText(exui.MaterialIcon(self.hoverIcon))
	end
end

function PANEL:OnCursorExited()
	self:InvalidateLayout(true)
	if self.hoverIcon then
		self:SetText(exui.MaterialIcon(self.icon))
	end
end

function PANEL:SetPressedIcon(name)
	self.pressedIcon = name
end

function PANEL:GetPressedIcon()
	return self.pressedIcon
end

function PANEL:SetHoverIcon(name)
	self.hoverIcon = name
end

function PANEL:GetHoverIcon()
	return self.hoverIcon
end

function PANEL:SetImage() end
function PANEL:GetImage() return "" end

derma.DefineControl( class, "", PANEL, base )
