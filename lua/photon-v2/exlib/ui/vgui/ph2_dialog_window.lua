local class = "Photon2UIDialogWindow"
local base = "Photon2UIWindow"
---@class Photon2UIDialog: Photon2UIWindow
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.ButtonWidth = 80

function PANEL:Init()
	self:SetTitle("")
	self:MakePopup()

end

function PANEL:SetupDialog()
	local this = self

	if ( IsValid( self.Container ) ) then
		self.Container:Remove()
	end

	local container = vgui.Create( "DPanel", self )
	container:Dock( FILL )
	container:SetPaintBackground( false )

	self.Container = container

	local content = vgui.Create( "DPanel", container )
	content:Dock( FILL )
	content:DockMargin( 4, 4, 4, 4 )
	self.ContentContainer = content

	local bottom = vgui.Create( "DPanel", container )
	bottom:Dock( BOTTOM )
	bottom:SetHeight( 24 )
	bottom:DockMargin( 4, 4, 4, 4 )
	bottom:SetPaintBackground( false )
	self.ButtonContainer = bottom

end

function PANEL:SetMainText( text )
	self.Text = text
	local label = self.MainTextLabel
	if ( not label ) then
		label = vgui.Create( "DLabel", self.ContentContainer )
		label:Dock( FILL )
		label:SetTextInset( 8, 0 )
		self.MainTextLabel = label
	end
	label:SetText( self.Text )
end

---@param label string
---@param onClick function | boolean
function PANEL:AddButton( label, onClick )
	
	---@type Panel
	local button = vgui.Create( "EXDButton", self.ButtonContainer )
	button:Dock( RIGHT )
	button:SetText( label )
	button:DockMargin( 8, 0, 0, 0 )
	button:SetWidth( 80 )

	if ( isfunction( onClick ) ) then
		button.DoClick = onClick
	else
		button:SetEnabled( false )
	end

end


function PANEL:PostAutoRefresh()
	self:SetupDialog()
end

derma.DefineControl( class, description, PANEL, base )
