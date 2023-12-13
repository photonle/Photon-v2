local class = "Photon2BasicInputConfig"
local base = "Photon2UIWindow"
---@class Photon2UIBasicInputConfig : Photon2UIWindow
---@field EditPanel Panel
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.ModifierKeys = {
	KEY_RSHIFT,
	KEY_RCONTROL,
	KEY_RALT
}

function PANEL:Init()
	self.BaseClass.Init( self )

	local this = self

	self:SetTitle("Input Configuration - Photon 2")
	self:SetMinWidth( 352 )
	self:SetMinHeight( 340 )
	local menubar = self:GetOrBuildMenuBar()
	
	local fileMenu = menubar:AddMenu("File")
	fileMenu:AddOption("New Profile...", function()
	
	end)
	fileMenu:AddOption("Open Profile...", function()
		self:ShowBrowser()
	end)
	fileMenu:AddOption("Save", function()
	
	end)
	fileMenu:AddOption("Save As...", function()
	
	end)
	fileMenu:AddOption("Close", function()
		this:Remove()
	end)

	local viewMenu = menubar:AddMenu("View")
	viewMenu:AddOption("Commands", function()
	
	end)
	viewMenu:AddOption("Keys and Buttons", function()
	
	end)

	local helpMenu = menubar:AddMenu("Help")
	helpMenu:AddOption("Open Documentation", function()
	
	end)


	---@type EXDListView
	local listView = vgui.Create( "EXDListView", self )
	local catColumn = listView:AddColumn( "Category" )
	catColumn:SetMaxWidth(96)
	catColumn:SetMinWidth(96)
	local cmdColumn = listView:AddColumn( "Command" )
	cmdColumn:SetMaxWidth(160)
	cmdColumn:SetMinWidth(128)
	local keyColumn = listView:AddColumn( "Key(s)" )
	keyColumn:SetMinWidth(128)

	listView:DockMargin( 4, 4, 4, 4 )
	listView:Dock( FILL )
	listView:SetMultiSelect( false )

	function listView:OnRowSelected( lineId, line )
		this:SetEditPanel( line.CommandData )
	end

	local byCommand = {}
	local inputConfig = Photon2.Library.InputConfigurations:Get("default")


	for key, commands in pairs( inputConfig.Binds ) do
		for i, data in ipairs( commands ) do
			local command = data.Command
			local keyString = ""
			byCommand[command] = byCommand[command] or {}
			if ( data.Modifiers ) then
				for _, keyCode in pairs( data.Modifiers ) do
					keyString = keyString .. input.GetKeyName( keyCode ) .. " + "
				end
			end
			keyString = keyString .. input.GetKeyName( key )
			byCommand[command][#byCommand[command]+1] = {
				String = keyString,
				Primary = key,
				Modifiers = data.Modifiers
			}
		end
	end

	for key, command in SortedPairsByMemberValue( Photon2.Index.Commands, "ExtendedTitle" ) do
		local keys = ""
		if ( byCommand[command.Name] ) then
			for i, entry in ipairs( byCommand[command.Name] ) do
				keys = keys .. entry.String
				if ( i < #byCommand[command.Name] ) then
					keys = keys .. ", "
				end
			end
			-- keys = table.concat( byCommand[command.Name].String, ", " )
		end
		local line = listView:AddLine( command.Category, command.Title, keys )
		line.CommandData = {
			Command = command,
			Keys = byCommand[command.Name]
		}
	end

	local metaPanel = vgui.Create( "DPanel", self )
	metaPanel:Dock( TOP )
	metaPanel:SetHeight( 128 ) 
	metaPanel:DockMargin( 4, 4, 4, 0 )
	metaPanel:DockPadding( 8, 4, 4, 4 )
	metaPanel:SetPaintBackground( false )
	self.MetaPanel = metaPanel


	self:SetMetaPanel(nil)

	local editPanel = vgui.Create( "DPanel", self )
	editPanel:DockMargin( 4, 0, 4, 4 )
	editPanel:DockPadding( 8, 4, 4, 4 )
	editPanel:Dock( BOTTOM )
	editPanel:SetHeight( 128 )
	self.EditPanel = editPanel

	
end

function PANEL:SetMetaPanel( data )
	self.MetaPanel:Clear()
	local this = self
	local panel = self.MetaPanel
	local height = 28

	local keyPanel = vgui.Create( "DPanel", panel )
	keyPanel:SetPaintBackground( false )
	keyPanel:Dock( LEFT )
	keyPanel:SetWidth( 96 )
	
	local valuePanel = vgui.Create( "DPanel", panel )
	valuePanel:SetPaintBackground( false )
	valuePanel:Dock( RIGHT )
	
	local titleLabel = vgui.Create( "DLabel", keyPanel )
	titleLabel:SetHeight( height )
	titleLabel:Dock( TOP )
	titleLabel:SetText( "Title:" )
	
	local nameLabel = vgui.Create( "DLabel", keyPanel )
	nameLabel:SetHeight( height )
	nameLabel:Dock( TOP )
	nameLabel:SetText( "Name:" )
	
	local authorLabel = vgui.Create( "DLabel", keyPanel )
	authorLabel:SetHeight( height )
	authorLabel:Dock( TOP )
	authorLabel:SetText( "Author:" )
	
	local inheritLabel = vgui.Create( "DLabel", keyPanel )
	inheritLabel:SetHeight( height )
	inheritLabel:Dock( TOP )
	inheritLabel:SetText( "Inherits:" )
end

function PANEL:ShowBrowser()
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "InputConfigurations", "OPEN" )

	function window:OnFileConfirmed( entryName )
		window:Close()
	end
end

function PANEL:ShowKeyEditor()
	local this = self
	local dialog = vgui.Create( "Photon2UIWindow", self )
	-- dialog:SetSkin("PhotonStudio")
	dialog:SetTitle("Edit Key")
	dialog:SetIcon("photon/ui/photon_2_icon_16.png")
	dialog:SetSize( 300, 200 )
	dialog:SetScreenLock( true )
	local parentX, parentY = this:GetPos()
	dialog:Center()
	local dialogX, dialogY = dialog:GetPos()
	-- dialog:SetX( dialog:GetX() )
	dialog:MakePopup()

	-- print( "local", tostring(dialog:GetX() ) )
	-- print( "parent", tostring(this:GetX() ) )
	dialog:SetX( parentX + dialogX )
	dialog:SetY( parentY + dialogY )
	self:SetMouseInputEnabled( false )

	function dialog:OnFocusChanged( gained )
		if ( not gained ) then
			dialog:Remove()
		end
	end

	function dialog:OnRemove()
		this:SetMouseInputEnabled( true )
	end

	local priLabel = vgui.Create( "DLabel", dialog )
	priLabel:SetText( "Primary:" )
	priLabel:SetPos( 8, 32 )
end

function PANEL:PreAutoRefresh()
end

function PANEL:SetEditPanel( data )
	self.EditPanel:Clear()
	if ( not data ) then return end
	local this = self
	local editPanel = self.EditPanel

	local buttonsPanel = vgui.Create( "DPanel", editPanel )
	buttonsPanel:DockPadding( 4, 4, 4, 4 )
	buttonsPanel:SetPaintBackground( false )
	buttonsPanel:Dock( RIGHT )
	buttonsPanel:SetWidth( 128 )

	local previewButton = vgui.Create( "DButton", buttonsPanel )
	previewButton:DockMargin( 0, 0, 0, 8 )
	previewButton:Dock( TOP )
	previewButton:SetText( "Preview" )
	
	

	local clearButton = vgui.Create( "DButton", buttonsPanel )
	clearButton:DockMargin( 0, 0, 0, 8 )
	clearButton:Dock( TOP )
	clearButton:SetText( "Clear" )
	
	local resetButton = vgui.Create( "DButton", buttonsPanel )
	resetButton:DockMargin( 0, 0, 0, 8 )
	resetButton:Dock( TOP )
	resetButton:SetText( "Reset to Default" )
	
	local editButton = vgui.Create( "DButton", buttonsPanel )
	editButton:DockMargin( 0, 0, 0, 8 )
	editButton:Dock( TOP )
	editButton:SetText( "Advanced..." )
	function editButton:DoClick()
		this:ShowKeyEditor()
	end

	local cmdTitleLabel = vgui.Create( "DLabel", editPanel )
	cmdTitleLabel:Dock( TOP )
	cmdTitleLabel:SetText( data.Command.Category .. " | " .. data.Command.Title )

	local cmdDescriptionLabel = vgui.Create( "DLabel", editPanel )
	cmdDescriptionLabel:SetAutoStretchVertical( true )
	cmdDescriptionLabel:SetWrap( true )
	cmdDescriptionLabel:Dock( TOP )
	cmdDescriptionLabel:SetText( data.Command.Description )

	local selectionPanel = vgui.Create( "DPanel", self.EditPanel )
	selectionPanel:SetPaintBackground( false )
	selectionPanel:Dock( BOTTOM )
	selectionPanel:SetHeight( 54 )

	-- TODO: Note that multiple key commands and multiple modifiers
	-- are not supported in basic editing mode, even though this is
	-- supported.

	local currentKeys, currentPrimary, currentModifier
	
	if ( data.Keys ) then
		currentKeys = data.Keys[1]
	end
	
	if ( currentKeys ) then
		currentPrimary = currentKeys.Primary
		if ( currentKeys.Modifiers ) then
			currentModifier = currentKeys.Modifiers[1]
		end
	end

	local primaryBindLabel = vgui.Create( "DLabel", selectionPanel )
	primaryBindLabel:SetText( "Key/Button:" )

	local primaryBindButton = vgui.Create ( "DBinder", selectionPanel )
	primaryBindButton:SetY( 20 )
	primaryBindButton:SetWidth( 96 )
	if ( currentPrimary ) then primaryBindButton:SetValue( currentPrimary ) end

	function primaryBindButton:OnChange( num )
		print( "Primary bind changed to: " .. tostring( input.GetKeyName( num ) or nil ) )
	end

	local modifierBindLabel = vgui.Create( "DLabel", selectionPanel )
	modifierBindLabel:SetText( "Modifier (Optional):" )
	modifierBindLabel:SetX( 104 )
	modifierBindLabel:SetWide( 100 )
	
	local modifierBindButton = vgui.Create ( "DBinder", selectionPanel )
	modifierBindButton:SetY( 20 )
	modifierBindButton:SetWidth( 96 )
	modifierBindButton:SetX( 104 )
	if ( currentModifier ) then modifierBindButton:SetValue( currentModifier ) end

	function modifierBindButton:OnChange( num )
		print( "Primary bind changed to: " .. tostring( ( input.GetKeyName( num ) or nil ) ) )
	end
end

derma.DefineControl( class, "Photon 2 basic input configuration window", PANEL, base )