local class = "EXDLabelEditable"
local base = "DLabel"
local description = "Editable label (EX)."
local PANEL = {}

function PANEL:Init()
end

function PANEL:SizeToContents()

	local w, h = self:GetContentSize()
	self:SetSize( w + 16, h ) -- Add a bit more room so it looks nice as a textbox :)

end

function PANEL:StartEdit()

	local TextEdit = vgui.Create( "DTextEntry", self )
	TextEdit:Dock( FILL )
	TextEdit:SetText( self:GetText() )
	TextEdit:SetFont( self:GetFont() )

	TextEdit.OnEnter = function()
		local text = self:OnLabelTextChanged( TextEdit:GetText() ) or TextEdit:GetText()
		if ( text:byte() == 35 ) then text = "#" .. text end -- Hack!
		self:SetText( text )
		self:StopEdit()
	end

	TextEdit.OnLoseFocus = function()
		self:StopEdit()
	end

	self.m_bOldMouseInput = self:IsMouseInputEnabled()
	self.m_bOldKeyboardInput = self:IsKeyboardInputEnabled()

	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)
	TextEdit:RequestFocus()
	TextEdit:OnGetFocus() -- Because the keyboard input might not be enabled yet! (spawnmenu)
	TextEdit:SelectAllText( true )
	
	self.m_pTextEdit = TextEdit

end

function PANEL:StopEdit()
	self:SetMouseInputEnabled(self.m_bOldMouseInput)
	self:SetKeyboardInputEnabled(self.m_bOldKeyboardInput)
	if IsValid(self.m_pTextEdit) then
		hook.Run( "OnTextEntryLoseFocus", self.m_pTextEdit )
		self.m_pTextEdit:Remove()
	end
end

function PANEL:OnLabelTextChanged( text )
	return text
end

derma.DefineControl( class, description, PANEL, base )