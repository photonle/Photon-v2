local class = "EXDPAdd"
local base = "DLabel"

local PANEL = {}

function PANEL:Init()
	local this = self
	self:SetText("")
	self:SetIsToggle(true)
	self:SetZPos(1000)
	self:Dock(TOP)
	self:SetHeight(24)
	self:DockPadding(0, 0, 0, 0)
	self:SetMouseInputEnabled(true)
	self:SetCursor("hand")

	local i = vgui.Create("EXDIcon", self)
	i:SetSize(16, 16)
	i:SetIcon("plus-circle-outline")
	i:Dock(LEFT)
	i:DockMargin(4, 4, 6, 4)
	i:SetMouseInputEnabled(false)
	self.AddIcon = i

	local l = vgui.Create("DLabel", self)
	-- l:SetFont("EXUI.Button")
	l:SetText("Add Property     ")
	l:Dock(FILL)
	l:SetContentAlignment(5)
	self.Label = l

	local t = vgui.Create("EXDTextEntry", self)
	t:Dock(FILL)
	t:SetPopupStayAtBack(true)
	t:Hide()
	t:SetPaintBackground(false)
	t:DockMargin(0, 0, 0, 1)

	function t:OnEnter()
		print("ADDING PROPERTY", t:GetValue())
		if t.menuOpen then
			t.menuOpen = false
			if IsValid(t.Menu) then
				t.Menu:Remove()
				t:KillFocus()
			end
		end
	end

	function t:OnFocusChanged(state)
		if (state) then

		else
			if this:GetToggle() == true then
				if (t.menuOpen) then
					t:RequestFocus()
					t.menuOpen = false
				else
					this:Toggle(false)
				end
			end
		end
	end

	function t:GetAutoComplete(input)
		return this:GetFormParent():GetSchemaProperties(input, this:GetParent().Header:GetValue())
	end

	self.Input = t

end

function PANEL:GetFormParent(depth)
	if not self.formParent then
		depth = depth or 20
		local targ = self:GetParent()
		for i=1, depth do
			if targ.IsEXPForm then
				self.formParent = targ
			else
				print("didn't find: ", targ:GetClassName())
				targ = targ:GetParent()
			end
		end
	end
	if self.formParent then
		return self.formParent
	else
		error("A EX form parent was not found. Search depth: " .. tostring(depth))
	end
end

function PANEL:Paint(w, h)
	if self.Hovered then
		surface.SetDrawColor(205, 205, 205)
		surface.DrawRect(0, 0, w, h)
	elseif self:GetToggle() then
		surface.SetDrawColor(255, 255, 255)
		surface.DrawRect(0, 0, w, h)
	else
		surface.SetDrawColor(0, 0, 0, 30)
		surface.DrawRect(0, 0, w, h)
	end
end

function PANEL:OnToggled(state)
	if (state) then
		self.Label:Hide()
		self.Input:Show()
		self.Input:SetKeyboardInputEnabled(true)
		self.Input:SetMouseInputEnabled(true)
		self.Input:RequestFocus()
	else
		self.Input:Hide()
		self.Label:Show()
	end
end

derma.DefineControl( class, "", PANEL, base )