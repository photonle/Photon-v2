local class = "Photon2BasicInputConfig"
local base = "Photon2UIWindow"
---@class Photon2UIBasicInputConfig : Photon2UIWindow
---@field EditPanel Panel
---@field CommandList EXDListView
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.ModifierKeys = {
	KEY_RSHIFT,
	KEY_RCONTROL,
	KEY_RALT
}

PANEL.TitleSuffix = " - Input Configuration"
PANEL.TitleMain = "Photon 2"

-- Saves the current WorkingCopy table as an entry
function PANEL:DoSave( postSaveFunc )
	local this = self
	if ( this.WorkingCopy and this.WorkingCopy.Name == nil ) then
		return this:DoSaveAs( postSaveFunc )
	end
	Photon2.Library.InputConfigurations:SaveToDataAndRegister( this.WorkingCopy )
	self:LoadInputConfiguration( this.WorkingCopy.Name )
	if ( isfunction( postSaveFunc ) ) then postSaveFunc() end
end

function PANEL:DoSaveAs( postSaveAsFunc )
	self:ShowSaveBrowser( postSaveAsFunc )
end

-- Prompts user to save unsaved file and will call continueFunc when handled.
---@param onContinue function
function PANEL:RunSaveCheck( onContinue )
	local this = self
	if ( self.WorkingCopy and self.WorkingCopy.Unsaved ) then
		Photon2.UI.DialogBox.ConfirmSave( 
			self.WorkingCopy.Name,
			-- On Save
			function() this:DoSave( onContinue ) end,
			-- On Don't Save
			onContinue,
			-- On Cancel
			nil
		)
	else
		onContinue()
	end
end

function PANEL:Init()
	self.BaseClass.Init( self )

	local this = self

	self:SetTitle("Input Configuration - Photon 2")
	self:SetMinWidth( 352 )
	self:SetMinHeight( 340 )
	
	self:Setup()
	
	self:MakePopup()
	self:SetKeyBoardInputEnabled( false )
end

function PANEL:LoadInputConfiguration( inputConfig, asNew )

	if ( isstring( inputConfig ) ) then inputConfig = Photon2.Library.InputConfigurations:GetCopy( inputConfig ) end

	self.WorkingCopy = inputConfig

	if ( asNew ) then
		local isNew = (inputConfig.Name == nil)
		inputConfig.Name = nil
		self:MarkUnsaved()
		if ( not isNew ) then
			inputConfig.Title = tostring( inputConfig.Title or "" ) .. " (Copy)"
		end
	else
		self:MarkSaved()
	end

	self:SetTitleMain( inputConfig.Name or "untitled" )

	print("Loading input configuration: " .. tostring( inputConfig ) )

	local listView = self.CommandList
	listView:Clear()

	local byCommand = {}

	self:SetMetaPanel( inputConfig )
	self:SetEditPanel( nil )
	self:SetButtonsPanel( inputConfig )

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

	Photon2.Library.Commands:CompileAll()

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
end

---@param data PhotonInputConfiguration
function PANEL:SetMetaPanel( data )
	local this = self
	if ( IsValid( self.MetaPanel ) ) then self.MetaPanel:Remove() end

	---@type Photon2UIFormPanel
	local metaPanel = vgui.Create( "Photon2UIFormPanel", self )
	metaPanel.LabelWidth = 50
	metaPanel:Dock( TOP )
	metaPanel:SetHeight( 128 ) 
	metaPanel:DockMargin( 4, 4, 4, 0 )
	metaPanel:DockPadding( 8, 4, 4, 4 )
	metaPanel:SetPaintBackground( false )
	
	function metaPanel:OnPropertyChanged( name, value )
		this:SetProperty( name, value )
	end

	self.MetaPanel = metaPanel

	if ( not data ) then 
		self.MetaPanel:SetHeight( 0 )
		self.MetaPanelData = nil
		return 
	end

	self.MetaPanelData = data

	
	
	local panel = self.MetaPanel

	panel:CreateTextEntryProperty( "Title", "Title", data.Title )
	panel:CreateTextEntryProperty( "Author", "Author", data.Author )
	panel:CreateLibraryEntryProperty( "Inherit", "Inherit", data.Inherit )

	self.MetaPanel:SetHeight( 106 )

	self:InvalidateLayout( false )
end

function PANEL:ShowBrowser()
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "InputConfigurations", "OPEN" )

	function window:OnFileConfirmed( entryName )
		window:Close()
	end
end

function PANEL:ShowOpenBrowser()
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "InputConfigurations", "OPEN" )
	function window:OnFileConfirmed( entryName, asCopy )
		window:Close()
		this:LoadInputConfiguration( entryName, asCopy )
	end
end

function PANEL:ShowSaveBrowser( postSaveFunc )
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "InputConfigurations", "SAVE" )
	function window:OnFileConfirmed( entryName )
		if ( not this.WorkingCopy ) then
			ErrorNoHalt( "Attempted to save [" .. tostring(entryName) .. "] but no valid entry (WorkingCopy) appeared to be loaded." )
			return
		end
		-- SAVE ENTRY
		this.WorkingCopy.Name = entryName
		this:DoSave( postSaveFunc )
		window:Close()
		if ( isfunction( postSaveFunc ) ) then postSaveFunc() end
	end
	if ( self.WorkingCopy and self.WorkingCopy.Name ) then
		window:PreFillSelection( self.WorkingCopy.Name )
	end
end

function PANEL:SetProperty( key, value )
	if ( not self.WorkingCopy ) then return end
	if ( self.WorkingCopy[key] == value ) then return end
	self.WorkingCopy[key] = value
	self:MarkUnsaved()
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
	dialog:DoModal()
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

function PANEL:Setup()
	self:SetupMenuBar()
	self:SetMetaPanel(nil)
	self:SetupCommandsPanel()
	self:SetupButtonsPanel()

	if ( IsValid( self.PropertySheet ) ) then self.PropertySheet:Remove() end

	local propertySheet  = vgui.Create( "DPropertySheet", self )
	propertySheet:Dock( FILL )
	propertySheet:DockMargin( 4, 0, 4, 4 )
	propertySheet:SetPadding( 1 )
	propertySheet:AddSheet( "Buttons", self.ButtonsPanel )
	propertySheet:AddSheet( "Commands", self.CommandPanel )
	self.PropertySheet = propertySheet
	-- function propertySheet:OnActiveTabChanged
end

function PANEL:PreAutoRefresh()
end

function PANEL:PostAutoRefresh()
	self:Setup()

	self.WorkingCopy = self.WorkingCopy or "default"
	self:LoadInputConfiguration( self.WorkingCopy )
end 

function PANEL:MarkUnsaved()
	self:SetTitlePrefix( "*" )
	self.WorkingCopy.Unsaved = true
end

function PANEL:MarkSaved()
	self:SetTitlePrefix("")
	self.WorkingCopy.Unsaved = nil
end

function PANEL:SetupCommandsPanel()
	local this = self
	if ( IsValid( self.CommandPanel ) ) then self.CommandPanel:Remove() end

	local panel = vgui.Create( "DPanel", self )
	self.CommandPanel = panel

	panel:SetPaintBackground( false )
	---@type EXDListView
	local listView = vgui.Create( "EXDListView", panel )
	local catColumn = listView:AddColumn( "Category" )
	catColumn:SetMaxWidth(96)
	catColumn:SetMinWidth(96)
	local cmdColumn = listView:AddColumn( "Command" )
	cmdColumn:SetMaxWidth(160)
	cmdColumn:SetMinWidth(128)
	local keyColumn = listView:AddColumn( "Button(s)" )
	keyColumn:SetMinWidth(128)

	listView:DockMargin( 4, 4, 4, 4 )
	listView:Dock( FILL )
	listView:SetMultiSelect( false )
	listView:SetDataHeight( 20 )

	function listView:OnRowSelected( lineId, line )
		this:SetEditPanel( line.CommandData )
	end

	this.CommandList = listView

	local editPanel = vgui.Create( "DPanel", panel )
	-- why 8???
	editPanel:DockPadding( 8, 4, 4, 4 )
	editPanel:SetHeight( 0 )
	editPanel:Dock( BOTTOM )

	self.EditPanel = editPanel

end

function PANEL:SetupButtonsPanel()
	if ( IsValid( self.ButtonsPanel ) ) then self.ButtonsPanel:Remove() end

	local panel = vgui.Create( "DPanel", self )
	panel:SetPaintBackground( false )
	self.ButtonsPanel = panel

	local divider = vgui.Create( "EXDHorizontalDivider", panel )
	divider:Dock( FILL )
	divider:SetDividerWidth( 4 )
	divider:SetLeftMin( 140 )

	local left = vgui.Create( "DPanel", panel )
	left :SetPaintBackground( false )
	divider:SetLeft( left )

	local right = vgui.Create( "DScrollPanel", panel )
	right:SetPaintBackground( false )
	divider:SetRight( right )

	local buttonPanel = vgui.Create( "DPanel", right )
	buttonPanel:Dock( TOP )
	buttonPanel:SetHeight( 90 )
	buttonPanel:DockMargin( 0, 36, 4, 4 )
	self.SelectedButtonPanel = buttonPanel

	local commandPanel = vgui.Create( "DPanel", right )
	commandPanel:Dock( TOP )
	commandPanel:SetHeight( 128 )
	commandPanel:DockMargin( 0, 4, 4, 4 )
	self.SelectedCommandPanel = commandPanel
	
	local modifierPanel = vgui.Create( "DPanel", right )
	modifierPanel:Dock( TOP )
	modifierPanel:SetHeight( 0 )
	modifierPanel:DockMargin( 0, 4, 4, 4 )
	self.SelectedModifierPanel = modifierPanel

	local tree = vgui.Create( "EXDTree", left )
	tree:SetLineHeight( 22 )
	tree:Dock( FILL )
	tree:DockMargin( 4, 4, 4, 4 )
	self.ButtonsTree = tree

	local newCommandButton = vgui.Create( "EXDButton", left )
	newCommandButton:Dock( TOP )
	newCommandButton:SetHeight( 24 )
	newCommandButton:SetText( "    Add Key/Button..." )
	newCommandButton:SetIcon( "plus-box" )
	newCommandButton:DockMargin( 4, 8, 4, 0 )
	newCommandButton:SetTextInset( -60, 0 )
	function newCommandButton:DoClick()
		Photon2.UI.DialogBox.ButtonInput( "Bind...", 
		function()

		end)
	end
end

function PANEL:SetButtonsPanel( config )
	local tree = self.ButtonsTree
	if ( not IsValid( tree ) ) then return end
	tree:Clear()

	local bindTree = {}

	for key, commands in pairs( config.Binds ) do
		local keyName = input.GetKeyName(key)
		local icon = Photon2.UI.FindInputIcon( keyName )
		local keyNode = tree:AddNode( keyName, icon )
		keyNode.InputConfigurationLevel = "BUTTON"
		keyNode.InputConfigurationLevelIndex = key
		bindTree[key] = bindTree[key] or {}
		for i, command in ipairs( commands ) do
			local commandData = Photon2.Library.Commands:Get( command.Command )
			local commandNode = keyNode:AddNode( commandData.Title .. " (" .. commandData.Category .. ")", "console-line" )
			commandNode.InputConfigurationLevel = "COMMAND"
			commandNode.InputConfigurationLevelIndex = i
			if ( command.Modifiers ) then
				for i, modifier in ipairs( command.Modifiers ) do
					local modifierNode = commandNode:AddNode( input.GetKeyName( modifier ), "keyboard" )
					modifierNode.InputConfigurationLevelIndex = i
					modifierNode.InputConfigurationLevel = "MODIFIER"
					print( modifierNode:GetParentNode().CommandIndex )
				end
			end
		end
	end

	function tree:OnNodeSelected( node )
		local levels = { "BUTTON", "COMMAND", "MODIFIER" }
		print( "node type: " .. tostring( node.InputConfigurationLevel ), "id: " .. tostring( node.InputConfigurationLevelIndex ))
		local searching = true
		local resultTree = {}
		local result = {}
		local currentNode = node
		while ( searching ) do
			resultTree[#resultTree+1] = currentNode.InputConfigurationLevelIndex
			if ( currentNode and currentNode.GetParentNoded and currentNode:GetParentNode() ) then
				currentNode = currentNode:GetParentNode()
			else
				searching = false
			end
		end
		resultTree = table.Reverse( resultTree )
		for i=1, 3 do
			result[i] = levels[i]
		end
		PrintTable( result )
	end

	self:SetSelectedButton( )
	self:SetSelectedCommand( )
	self:SetSelectedModifier( )
end

function PANEL:BuildActionsSection( parent, title, height )
	
	parent:Clear()
	parent:SetPaintBackground( false )
	parent:SetHeight( height )
	
	local titleLabel = vgui.Create( "DLabel", parent )
	titleLabel:Dock( TOP )
	titleLabel:SetText( title )
	titleLabel:SetContentAlignment( 7 )
	titleLabel:SetHeight( 20 )

	local container = vgui.Create( "DPanel", parent )
	container:Dock( FILL )

	local left = vgui.Create( "DPanel", container )
	left:Dock( FILL )
	left:SetPaintBackground( false )
	left:DockPadding( 8, 8, 8, 8 )

	local right = vgui.Create( "DPanel", container )
	right:Dock( RIGHT )
	right:SetWidth( 150 )
	right:DockPadding( 8, 8, 8, 8 )
	right:SetPaintBackground( false )

	return {
		Title = titleLabel,
		Container = container,
		Left = left,
		Right = right,
		AddButton = function( btnLabel, btnIcon, onBtnClick )
			local button = vgui.Create( "EXDButton", right )
			button:Dock( TOP )
			button:DockMargin( 0, 0, 0, 4 )
			button:SetText( btnLabel )
			button:SetIcon( btnIcon )
			button.DoClick = onBtnClick
			return button
		end
	}
end

---@param btn number Input button.
function PANEL:SetSelectedButton( btn )
	local panel = self.SelectedButtonPanel
	local section = self:BuildActionsSection( panel, "Key / Button", 110 )
	local addButton = section.AddButton( "Add a Command...", "plus-box-multiple-outline" )
	local clearButton = section.AddButton( "Clear All Commands", "eraser" )
	local deleteButton = section.AddButton( "Delete Key / Button", "delete-outline" )
end

function PANEL:SetSelectedCommand( index )
	local panel = self.SelectedCommandPanel
	if ( not IsValid( panel ) ) then return end
	local section = self:BuildActionsSection( panel, "Command", 136 )
	local swapButton = section.AddButton( "Swap Command...", "swap-horizontal-variant" )
	local addButton = section.AddButton( "Add a Modifier...", "keyboard" )
	local clearButton = section.AddButton( "Clear All Modifiers", "eraser" )
	local deleteButton = section.AddButton( "Remove Command", "close-box-outline" )

	local commandInfo = vgui.Create( "DLabel", section.Left )
	commandInfo:SetText("Toggle Warning | Emergency\ntoggle_warning")
	commandInfo:Dock( TOP )
	commandInfo:SetHeight( 26 )
	commandInfo:SetContentAlignment( 7 )

end

function PANEL:SetSelectedModifier( index )
	local panel = self.SelectedModifierPanel
	if ( not IsValid( panel ) ) then return end

	local section = self:BuildActionsSection( panel, "Modifier Key / Button", 84 )
	section.AddButton( "Swap Modifier...", "swap-horizontal-variant" )
	section.AddButton( "Remove Modifier", "close-box-outline" )


end

function PANEL:SetupMenuBar()
	local this = self
	if ( IsValid( self.MenuBar ) ) then self.MenuBar:Remove() end

	local menubar = self:GetOrBuildMenuBar()
	
	local fileMenu = menubar:AddMenu("File")
	
	fileMenu:AddOption("New Profile", function()
		this:RunSaveCheck( function()
			this:LoadInputConfiguration( Photon2.Library.InputConfigurations:GetNew(), false )
		end)
	end)

	fileMenu:AddSpacer()
	fileMenu:AddOption("Open Profile...", function()
		this:RunSaveCheck( function()
			this:ShowOpenBrowser()
		end)
	end)
	
	fileMenu:AddSpacer()
	fileMenu:AddOption("Save", function()
		this:DoSave()
	end)
	
	fileMenu:AddOption("Save As...", function()
		this:DoSaveAs()
	end)
	
	fileMenu:AddSpacer()
	fileMenu:AddOption("Close", function()
		this:RunSaveCheck( function()
			this:Remove()
		end )
	end)

	local viewMenu = menubar:AddMenu("View")
	viewMenu:AddOption("Commands", function()
	
	end)
	viewMenu:AddOption("Keys and Buttons", function()
	
	end)

	local helpMenu = menubar:AddMenu("Help")
	helpMenu:AddOption("Open Documentation", function()
	
	end)

end

function PANEL:SetEditPanel( data )
	self.EditPanel:Clear()
	if ( not data ) then 
		self.EditPanel:SetHeight( 0 )
		self.EditPanel:DockMargin( 0, 0, 0, 0 )
		return end
	local this = self

	local editPanel = self.EditPanel
	
	editPanel:SetHeight( 128 )
	editPanel:DockMargin( 4, 0, 4, 4 )

	local buttonsPanel = vgui.Create( "DPanel", editPanel )
	buttonsPanel:DockPadding( 4, 4, 4, 4 )
	buttonsPanel:SetPaintBackground( false )
	buttonsPanel:SetWidth( 128 )
	buttonsPanel:Dock( RIGHT )

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