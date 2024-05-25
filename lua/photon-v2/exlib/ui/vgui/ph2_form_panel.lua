local class = "Photon2UIFormPanel"
local base = "DScrollPanel"
local description = "Generic form because DForm is an unmaintained shit show."

local callbackIndex = 1

---@class Photon2UIFormPanel : Panel
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.LabelWidth = 80
PANEL.Padding = 4
PANEL.ItemHeight = 32

function PANEL:Init()
	self.Items = {}
	self.Properties = {}
	self:SetPaintBackground( false )
end

function PANEL:AddDivider()
	local panel = vgui.Create( "DPanel", self )
	panel:Dock( TOP )
	panel:SetHeight( 1 )
	panel:SetPaintBackground( false )
	panel:DockMargin( 0, 4, 0, 4 )
	function panel:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 128 )
		surface.DrawRect( 0, 0, w, h )
	end
	return panel
end

-- Internal function called by each new form property added.
function PANEL:CreateBaseProperty( property, labelText )

	if ( istable( property ) ) then
		self:RegisterCVarProperty( property[1], property[2] )
		property = property[1]
	end

	if ( IsValid( self.Items[property] ) ) then
		self.Items[property]:Remove()
	end

	local panel = vgui.Create( "DPanel", self )
	panel:SetHeight( self.ItemHeight )
	panel:Dock( TOP )
	panel:SetPaintBackground( false )
	panel:DockPadding( 4, 4, 4, 4 )
	self.Items[property] = panel

	local label = vgui.Create( "DLabel", panel )
	label:SetWidth( self.LabelWidth )
	label:SetContentAlignment( 4 )
	label:SetText( labelText )
	label:Dock( LEFT )
	label:SetTextInset( 4, 0 )

	panel.Label = label

	local content = vgui.Create( "DPanel", panel )
	content:Dock( FILL )
	content:SetPaintBackground( false )
	content:DockMargin( 0, 0, 4, 0 )
	panel.Content = content

	return panel, property
end

-- Simple text-box property.
function PANEL:CreateTextEntryProperty( property, labelText, currentValue, params )
	local this = self
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
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
		this:InternalOnPropertyChanged( propertyName, value )
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

function PANEL:CreateLibraryEntryProperty( property, labelText, currentValue, params )
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
	local this = self
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
		this:InternalOnPropertyChanged( propertyName, value )
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


---@param propertyName string
---@param labelText string
---@param currentValue boolean
---@param params? { Descriptor?: string }
function PANEL:CreateCheckBoxProperty( property, labelText, currentValue, params )
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
	local descriptor = ""
	if ( params ) then
		if ( params.Descriptor ) then
			descriptor = params.Descriptor
		end
	end
	local this = self
	
	local checkbox = vgui.Create( "DCheckBoxLabel", panel.Content )
	checkbox:Dock( FILL )
	checkbox:SetText( tostring( descriptor ) )
	checkbox:SetChecked( currentValue or false )

	function panel:SetValue( value )
		if ( isstring( value ) ) then value = ( value == "1" ) end
		if ( value == self:GetValue() ) then return end
		checkbox:SetChecked( value )
	end

	function panel:GetValue()
		return checkbox:GetChecked()
	end

	function checkbox:OnChange( value )
		this:InternalOnPropertyChanged( propertyName, value )
	end
end

function PANEL:CreateComboBoxProperty( property, labelText, currentValue, options )
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
	local this = self
	local comboBox = vgui.Create( "DComboBox", panel.Content )
	comboBox:Dock( FILL )
	comboBox:SetValue( currentValue or "" )

	local mapIn, mapOut

	for k, v in pairs( options or {} ) do
		if ( isstring( v ) ) then
			comboBox:AddChoice( v )
		elseif ( istable( v ) ) then
			mapIn = mapIn or {}
			mapOut = mapOut or {}
			mapOut[v[1]] = v[2]
			mapIn[v[2]] = v[1]
			comboBox:AddChoice( v[1], v[2] )
		end
	end

	function panel:SetValue( value )
		if ( mapIn ) then
			value = mapIn[value] or value
		end
		comboBox:SetValue( value )
	end

	function panel:GetValue()
		local result = comboBox:GetValue()
		if ( mapOut ) then
			result = mapOut[result] or result
		end
		return result
	end

	function comboBox:OnSelect( index, value, data )
		if ( mapOut ) then
			value = mapOut[value] or value
		end
		this:InternalOnPropertyChanged( propertyName, value )
	end
end

function PANEL:CreateNumberSliderProperty( property, labelText, currentValue, min, max, decimals )
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
	local this = self
	local slider = vgui.Create( "DNumberWang", panel.Content )
	slider:Dock( FILL )
	slider:SetMinMax( min, max )
	slider:SetDecimals( decimals or 0 )
	slider:SetValue( currentValue or 0 )

	function panel:SetValue( value )
		slider:SetValue( value )
	end

	function panel:GetValue()
		return slider:GetValue()
	end

	function slider:OnValueChanged( value )
		this:InternalOnPropertyChanged( propertyName, value )
	end
end

function PANEL:AddButton( text, callback, icon )
	local panel = vgui.Create( "DPanel", self )
	panel:Dock( TOP )
	panel:SetHeight( self.ItemHeight )
	panel:SetPaintBackground( false )
	panel:DockMargin( 0, 0, 4, 0 )
	panel:DockPadding( 4, 4, 4, 4 )

	local button = vgui.Create( "EXDButton", panel )
	button:Dock( RIGHT )
	button:SetText( text )
	button:SetHeight( self.ItemHeight )
	button.DoClick = callback
	button:SizeToContentsX( 32 )
	if ( icon ) then
		button:SetIcon( icon )
	end

end

--- UNUSED
---@param name string Internal property name.
---@param onChange fun(value: any) Function to call when the property changes.
---@param convertInput? fun(value: any): any Function to convert the external value to the one internally displayed.
---@param convertOutput? fun(value: any): any Function to convert the internally displayed value to the external one.
function PANEL:RegisterProperty( name, onChange, convertInput, convertOutput )
	self.Properties[name] = {
		OnChange = onChange or function() end,
		Input = convertInput or function( val ) return val end,
		Output = convertOutput or function( val ) return val end
	}
end


---@param name any
---@param type? "String" | "Int" | "Float" | "Bool"
---@param onChange? any
---@param convertInput? any
---@param convertOutput? any
function PANEL:RegisterCVarProperty( name, type, onChange, convertInput, convertOutput )
	callbackIndex = callbackIndex + 1
	local thisCallbackIndex = callbackIndex
	self.Properties[name] = {
		IsCVar = thisCallbackIndex,
		CVar = GetConVar( name ),
		Type = type or "String",
		OnChange = onChange or function() end,
		Input = convertInput or function( val ) return val end,
		Output = convertOutput or function( val ) return val end
	}
	self.Properties[name].GetCVar = self.Properties[name].CVar["Get" .. self.Properties[name].Type]
	self.Properties[name].SetCVar = self.Properties[name].CVar["Set" .. self.Properties[name].Type]
	cvars.AddChangeCallback( name, function( convar, oldValue, newValue )
		if ( not IsValid( self ) ) then
			-- this has to be delayed or else it removes the entry from the callback table
			-- while it's still being iterated through (which really fucks things up)
			timer.Simple( 0.1, function() 
				cvars.RemoveChangeCallback( convar, tostring( thisCallbackIndex ) )
			end)
			return
		end
		if ( self.Items[name] ) then
			self.Items[name]:SetValue( self.Properties[name].Input( newValue ) )
		end
	end, tostring( thisCallbackIndex ) )
	timer.Simple( 0, function()
		if ( not IsValid( self ) ) then return end
		if ( self.Items[name] ) then
			self.Items[name]:SetValue( self.Properties[name].Input( 
				self.Properties[name].GetCVar( self.Properties[name].CVar )
			 ) )
		end
	end)
end

function PANEL:InternalOnPropertyChanged( name, value )
	local property = self.Properties[name]
	if ( property ) then
		if ( property.Input ) then
			value = property.Input( value )
		end
		property.OnChange( value )
		if ( property.CVar ) then
			property.CVar["Set" .. property.Type]( property.CVar, value )
		end
	end
	self:OnPropertyChanged( name, value )
end

local matGrid = Material( "gui/alpha_grid.png", "nocull" )

function PANEL:CreateColorProperty( property, labelText, currentValue )
	local panel, propertyName = self:CreateBaseProperty( property, labelText )
	local this = self

	local currentValueColor = Color( 255, 255, 255, 255 )
	local currentValueString = "255,255,255,255"

	function panel:GetValue()
		return currentValueString
	end

	local colorButton = vgui.Create( "DColorButton", panel.Content )
	colorButton:Dock( FILL )
	function colorButton:Paint( w, h )
		if ( self:GetColor().a < 255 ) then -- Grid for Alpha

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( matGrid )
	
			local size = math.max( 128, math.max( w, h ) )
			local x, y = w / 2 - size / 2, h / 2 - size / 2
			surface.DrawTexturedRect( x, y , size, size )
	
		end
	
		surface.SetDrawColor( self:GetColor() )
		self:DrawFilledRect()
	
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, w, 1 )
		surface.DrawRect( 0, 0, 1, h )
		surface.DrawRect( 0, h - 1, w, 1 )
		surface.DrawRect( w - 1, 0, 1, h )
	
		return false
	end

	colorButton:DockMargin( 0, 2, 0, 2 )

	local textBox = vgui.Create( "DTextEntry", panel.Content )
	textBox:Dock( RIGHT )
	textBox:DockMargin( 8, 0, 0, 0 )
	textBox:SetWidth( 108 )
	textBox:SetUpdateOnType( true )

	local function onValueChange( color, noUpdateTextBox )
		currentValueColor = color
		currentValueString = string.format( "%s,%s,%s,%s", color.r, color.g, color.b, color.a )
		if ( not noUpdateTextBox ) then
			textBox:SetText( currentValueString )
		end
		colorButton:SetColor( color )
		this:InternalOnPropertyChanged( propertyName, textBox:GetText() )
	end

	local picker
	local function openPicker()
		if ( IsValid( picker ) ) then return end
		picker = Photon2.UI.ColorMixer( currentValueColor )
		function picker:OnSelect( color )
			onValueChange( color )
		end
		function picker:OnPreview( color )
			onValueChange( color )
		end
	end

	function textBox:OnValueChange( value )
		local parsedColor = Photon2.Util.GetValidColorString( value )
		local noUpdate = self:HasHierarchicalFocus()
		if ( parsedColor ) then
			onValueChange( parsedColor, noUpdate )
		end
	end

	function textBox:OnLoseFocus()
		textBox:SetText( currentValueString )
	end

	function panel:SetValue( value )
		if ( isstring( value ) ) then
			local r, g, b, a = string.match( value, "(%d+),(%d+),(%d+),(%d+)" )
			if ( r and g and b and a ) then
				currentValueColor = Color( r, g, b, a )
				currentValueString = value
			end
		end
		colorButton:SetColor( currentValueColor )
		if ( not textBox:HasHierarchicalFocus() ) then
			textBox:SetText( currentValueString )
		end
	end

	function colorButton:DoClick()
		openPicker()
	end
end

--- For overriding
function PANEL:OnPropertyChanged( name, value )
	print( string.format( "Property [%s] changed to [%s]", name, value ) )
end

derma.DefineControl( class, description, PANEL, base )