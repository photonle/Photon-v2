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
function PANEL:CreateBaseProperty( propertyName, labelText )

	if ( IsValid( self.Items[propertyName] ) ) then
		self.Items[propertyName]:Remove()
	end

	local panel = vgui.Create( "DPanel", self )
	panel:SetHeight( self.ItemHeight )
	panel:Dock( TOP )
	panel:SetPaintBackground( false )
	panel:DockPadding( 4, 4, 4, 4 )
	self.Items[propertyName] = panel

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

	panel.Content = content

	return panel
end

-- Simple text-box property.
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

function PANEL:CreateLibraryEntryProperty( propertyName, labelText, currentValue, params )
	local panel = self:CreateBaseProperty( propertyName, labelText )
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
function PANEL:CreateCheckBoxProperty( propertyName, labelText, currentValue, params )
	local panel = self:CreateBaseProperty( propertyName, labelText )
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
		print( "Setting value to " .. tostring( value ) )
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

function PANEL:CreateComboBoxProperty( propertyName, labelText, currentValue, options )
	local panel = self:CreateBaseProperty( propertyName, labelText )
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

function PANEL:CreateNumberSliderProperty( propertyName, labelText, currentValue, min, max, decimals )
	local panel = self:CreateBaseProperty( propertyName, labelText )
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

---comment
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


---comment
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
		print( "CVar changed: " .. tostring( convar ) .. " " .. tostring( oldValue ) .. " " .. tostring( newValue ) )
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

--- For overriding
function PANEL:OnPropertyChanged( name, value )
	print( string.format( "Property [%s] changed to [%s]", name, value ) )
end

derma.DefineControl( class, description, PANEL, base )