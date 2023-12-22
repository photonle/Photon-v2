local class = "Photon2UIFormPanel"
local base = "DPanel"
local description = "Basic key-value form."

---@class Photon2UIFormPanel : Panel
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.LabelWidth = 80
PANEL.Padding = 4
PANEL.ItemHeight = 32

function PANEL:Init()
	self.Items = {}
end

function PANEL:CreateBaseProperty( propertyName, labelText )

	if ( IsValid( self.Items[propertyName] ) ) then
		self.Items[propertyName]:Remove()
	end

	local panel = vgui.Create( "DPanel", self )
	panel:SetHeight( self.ItemHeight )
	panel:Dock( TOP )
	panel:SetPaintBackground( false )
	panel:DockPadding( 0, 4, 0, 4 )
	self.Items[propertyName] = panel

	local label = vgui.Create( "DLabel", panel )
	label:SetWidth( self.LabelWidth )
	label:SetContentAlignment( 6 )
	label:SetText( labelText )
	label:Dock( LEFT )
	label:SetTextInset( 8, 0 )

	panel.Label = label

	local content = vgui.Create( "DPanel", panel )
	content:Dock( FILL )
	content:SetPaintBackground( false )

	panel.Content = content

	return panel
end

function PANEL:CreateTextEntryProperty( propertyName, labelText, currentValue, params )
	local this = self
	local panel = self:CreateBaseProperty( propertyName, labelText )
	local textEntry = vgui.Create( "DTextEntry", panel.Content )
	textEntry:SetUpdateOnType( true )
	textEntry:Dock( FILL )

	function panel:SetValue( value )
		textEntry:SetText( value or "" )
	end

	function panel:GetValue()
		return textEntry:GetText()
	end

	panel:SetValue( currentValue )

	function textEntry:OnValueChange( value )
		this:OnPropertyChanged( propertyName, value )
	end
end

function PANEL:SetPropertyValue( property, value )
	local target = self.Items[property]
	if ( not IsValid( target ) ) then
		ErrorNoHalt( "Target for " .. tostring( property ) .. " is invalid.")
		return
	end
	self.Items[property]:SetValue( value )
end

function PANEL:CreateLibraryEntryProperty( propertyName, labelText, currentValue, params )
	local panel = self:CreateBaseProperty( propertyName, labelText )
	local textEntry = vgui.Create( "DTextEntry", panel.Content )
	textEntry:Dock( FILL )
	textEntry:SetUpdateOnType( true )
	function panel:SetValue( value )
		textEntry:SetText( value or "" )
	end

	function panel:GetValue()
		return textEntry:GetText()
	end

	panel:SetValue( currentValue )

	function textEntry:OnValueChange( value )
		this:OnPropertyChanged( propertyName, value )
	end

	local browse = vgui.Create( "DButton", panel.Content )
	browse:DockMargin( 8, 0, 0, 0 )
	browse:Dock( RIGHT )
	browse:SetWidth( 96 )
	browse:SetText( "Select..." )

	local this = self
	function browse:DoClick()
		local window = vgui.Create( "Photon2UILibraryBrowser" )
		window:Setup( "InputConfigurations", "SELECT" )
		function window:OnFileConfirmed( name )
			this:SetPropertyValue( propertyName, name )
			window:Close()
		end
	end

end

--- For overriding
function PANEL:OnPropertyChanged( name, value )
	print("On property changed")
end

derma.DefineControl( class, description, PANEL, base )