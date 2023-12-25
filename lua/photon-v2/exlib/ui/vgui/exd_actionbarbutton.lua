local class = "EXDActionBarButton"
local base = "DLabel"
local description = "EX Action Bar Button"
local PANEL = {}

function PANEL:Init()
	self:SetText("")
	self:SetMouseInputEnabled(true)
	self:SetCursor("hand")
	self:SetDoubleClickingEnabled(false)
	self:DockPadding(8 + 2, 0, 8 + 2, 0)

end

function PANEL:Paint(w, h)
	if (self.Depressed) then
		surface.SetDrawColor(0, 0, 0, 96)
		surface.DrawRect(0, 0, w, h)
	elseif (self.Hovered) then
		surface.SetDrawColor(255, 255, 255, 75)
		surface.DrawRect(0, 0, w, h)
	end
	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawRect(w - 1, 0, 1, h)
end

function PANEL:SetIcon(name, size)
	if not self.m_Icon then
		if not (name) then return end
		local icon = vgui.Create("EXDIcon", self)
		icon:Dock(LEFT)
		icon:SetIconSize(20)
		icon:SetMouseInputEnabled(false)
		icon:SetWidth(self:GetTall() * 1.25)
		icon:SetIcon(name)
		icon:SetDoubleClickingEnabled(false)
		icon:SetZPos(-1)
		self.m_Icon = icon
	end
	if not (name) then
		self.m_Icon:Remove()
	else
		self.m_Icon:SetIcon(name)
		self.m_Icon:SetIconSize(size or 20)
	end
	if IsValid(self.m_Icon) then
		self:DockPadding(6, 0, 6, 0)
	else
		self:DockPadding(8 + 2, 0, 8 + 2, 0)
	end
end

function PANEL:GetIcon()
	if (self.m_Icon) then
		return self.m_Icon:GetIcon()
	end
end

function PANEL:OnCursorEntered()
	if (self.m_Icon) then
		self.m_Icon:OnCursorEntered()
	end
end

function PANEL:OnCursorExited()
	if (self.m_Icon) then
		self.m_Icon:OnCursorExited()
	end
end

function PANEL:OnDepressed()
	if (self.m_Icon) then	
		self.m_Icon:OnDepressed()
	end
end

function PANEL:OnReleased()
	if (self.m_Icon) then
		self.m_Icon:OnReleased()
	end
end

function PANEL:PerformLayout(w, h)
	if (self.m_Label) then
		self.m_Label:SizeToContentsX(2)
		self.m_Label:DockMargin(4, 0, 16, 0)
	end
	self:SizeToChildren(true, false)
end

function PANEL:SetLabel(text)

	if not (self.m_Label) then
		if (not text) or (text == "") then return end
		self.m_Label = vgui.Create("DLabel", self)
		self.m_Label:SetContentAlignment(4)
		self.m_Label:Dock(LEFT)
		-- self.m_Label:DockPadding(4, 0, 4, 0)
	end
	self.m_Label:SetText(text)
end

derma.DefineControl( class, description, PANEL, base )