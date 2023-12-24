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

	self.SelectedButtonNodes = {}
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

function PANEL:ShowCommandSelectionBrowser( onSelected )
	local this = self
	local window = vgui.Create( "Photon2UILibraryBrowser", self:GetParent() )
	window:Setup( "Commands", "SELECT" )
	function window:OnFileConfirmed( entryName )
		if ( isfunction( onSelected ) ) then onSelected( entryName ) end
		window:Close()
	end
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
	local this = self
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

	local right = vgui.Create( "DPanel", panel )
	right:SetPaintBackground( false )
	divider:SetRight( right )

	local rightButtons = vgui.Create( "DPanel", right )
	rightButtons:Dock( BOTTOM )
	rightButtons:SetHeight( 128 )
	rightButtons.ButtonPadding = 6
	rightButtons.ButtonHeight = 24
	rightButtons:DockMargin( 0, 8, 5, 1 )
	rightButtons:SetPaintBackground( false )
	self.SelectedActionButtons = rightButtons

	function rightButtons:ClearButtons()
		self:Clear()
		self.Items = {}
		self:SetHeight( 0 )
	end

	function rightButtons:AddButton( label, icon, onClick )
		local button = vgui.Create( "EXDButton", self )
		button:Dock( TOP )
		button:DockMargin( 0, 0, 0, self.ButtonPadding )
		button:SetText( label )
		button:SetIcon( icon )
		button:SetHeight( self.ButtonHeight )
		self.Items[#self.Items+1] = button
		self:SetHeight( #self.Items * ( self.ButtonPadding + self.ButtonHeight ))
		if ( onClick ) then button.DoClick = onClick end
		return button
	end

	local rightInfo = vgui.Create( "DScrollPanel", right )
	rightInfo:Dock( FILL )

	local buttonPanel = vgui.Create( "DPanel", rightInfo )
	buttonPanel:Dock( TOP )
	buttonPanel:SetHeight( 90 )
	buttonPanel:DockMargin( 0, 36, 4, 4 )
	self.SelectedButtonPanel = buttonPanel

	local commandPanel = vgui.Create( "DPanel", rightInfo )
	commandPanel:Dock( TOP )
	commandPanel:SetHeight( 128 )
	commandPanel:DockMargin( 0, 4, 4, 4 )
	self.SelectedCommandPanel = commandPanel
	
	local modifierPanel = vgui.Create( "DPanel", rightInfo )
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
			function( key )
				Photon2.Library.InputConfigurations.AddButtonToConfig( this.WorkingCopy, key )
				this.WorkingCopy.Binds[key] = this.WorkingCopy.Binds[key] or {}
				this.SelectedButtonNodes = { key }
				this:PushWorkingCopyChange()
			end
		)
	end
end

function PANEL:SetButtonsPanel( config )
	local this = self
	this.SelectedButtonNodes = this.SelectedButtonNodes or {}
	local tree = self.ButtonsTree
	this.SelectedActionButtons:ClearButtons()
	if ( not IsValid( tree ) ) then return end
	tree:Clear()
	tree.KeyNodeMap = {}
	function tree:AddButtonNode( key )
		local keyName = input.GetKeyName(key)
		local icon = Photon2.UI.FindInputIcon( keyName )
		local keyNode = tree:AddNode( keyName, icon )
		keyNode.InputConfigurationLevel = "BUTTON"
		keyNode.InputConfigurationLevelIndex = { key }
		-- TODO
		-- keyNode:SetDraggableName( true )
		tree.KeyNodeMap[key] = keyNode
		return keyNode
	end

	function tree:AddCommandNode( key, commandIndex, command )
		local keyNode = tree.KeyNodeMap[key]
		local commandData = Photon2.Library.Commands:Get( command.Command )
		local commandNode = keyNode:AddNode( commandData.Title .. " (" .. commandData.Category .. ")", "console-line" )
		commandNode.InputConfigurationLevel = "COMMAND"
		commandNode.InputConfigurationLevelIndex = { key, commandIndex }
		-- commandNode:SetDraggableName( false )
		return commandNode
	end

	for key, commands in SortedPairs( config.Binds ) do
		local keyNode = tree:AddButtonNode( key )
		for commandIndex, command in ipairs( commands ) do
			local commandNode = tree:AddCommandNode( key, commandIndex, command )
			if ( command.Modifiers ) then
				for modifierIndex, modifier in ipairs( command.Modifiers ) do
					local modifierNode = commandNode:AddNode( input.GetKeyName( modifier ), "keyboard" )
					modifierNode.InputConfigurationLevelIndex = { key, commandIndex, modifierIndex}
					modifierNode.InputConfigurationLevel = "MODIFIER"
				end
			end
		end
	end

	function tree:OnNodeSelected( node )
		local levels = { "BUTTON", "COMMAND", "MODIFIER" }
		local index = node.InputConfigurationLevelIndex
		-- print( "node type: " .. tostring( node.InputConfigurationLevel ), "id: " .. tostring( node.InputConfigurationLevelIndex ))
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
		this.SelectedButtonNodes = index
		this:SetSelectedButton( index[1] )
		this:SetSelectedCommand( index[1], index[2] )
		this:SetSelectedModifier( index[1], index[2], index[3] )
		-- PrintTable( result )
	end

	local selected = this.SelectedButtonNodes

	if ( selected[1] and tree.KeyNodeMap[selected[1]]) then
		tree:SetSelectedItem( tree.KeyNodeMap[selected[1]] )
		tree.KeyNodeMap[selected[1]]:SetExpanded( true )
	else
		selected = {}
		this.SelectedButtonNodes = {}
	end

	if ( selected[2] and tree.KeyNodeMap[selected[1]]:GetChildNode(selected[2]-1) ) then
		tree:SetSelectedItem( tree.KeyNodeMap[selected[1]]:GetChildNode(selected[2]-1) )
		tree.KeyNodeMap[selected[1]]:GetChildNode(selected[2]-1):SetExpanded( true )
	end

	self:SetSelectedButton( self.SelectedButtonNodes[1] )
	self:SetSelectedCommand( self.SelectedButtonNodes[1], self.SelectedButtonNodes[2] )
	self:SetSelectedModifier( self.SelectedButtonNodes[1], self.SelectedButtonNodes[2], self.SelectedButtonNodes[3] )
end

function PANEL:BuildActionsSection( parent, title, height, scrollable, showButtons )
	local this = self
	
	if ( showButtons ) then
		this.SelectedActionButtons:ClearButtons()
	end

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

	local left
	if ( scrollable ) then
		left = vgui.Create( "DScrollPanel", container )
	else
		left = vgui.Create( "DPanel", container )
	end
	left:Dock( FILL )
	left:SetPaintBackground( false )
	left:DockMargin( 8, 8, 8, 8 )
	-- left:DockPadding( 8, 8, 8, 8 )

	-- local right = vgui.Create( "DPanel", container )
	-- right:Dock( RIGHT )
	-- right:SetWidth( 150 )
	-- right:DockPadding( 8, 8, 8, 8 )
	-- right:SetPaintBackground( false )

	-- if ( hideButtons ) then
	-- 	right:SetWidth( 0 )
	-- end

	return {
		Title = titleLabel,
		Container = container,
		Left = left,
		Right = right,
		AddButton = function( btnLabel, btnIcon, onBtnClick )
			if ( not showButtons ) then return end
			return this.SelectedActionButtons:AddButton( btnLabel, btnIcon, onBtnClick)
			-- local button = vgui.Create( "EXDButton", this.SelectedActionButtons )
			-- button:Dock( TOP )
			-- button:DockMargin( 0, 0, 0, 4 )
			-- button:SetText( btnLabel )
			-- button:SetIcon( btnIcon )
			-- if ( onBtnClick ) then button.DoClick = onBtnClick end
			-- return button
		end
	}
end

function PANEL:BuildActionsSectionButtonDisplay( parent, button )
	local iconPreview = vgui.Create( "EXDIcon", parent )
	iconPreview:Dock( LEFT )
	iconPreview:SetWidth( 32 )
	iconPreview:SetIcon( Photon2.UI.FindInputIcon( input.GetKeyName( button )  ) )
	iconPreview:SetContentAlignment( 4 )
	local valueLabel = vgui.Create( "DLabel", parent ) 
	valueLabel:Dock( FILL )
	valueLabel:SetText( "Name: " .. input.GetKeyName( button ) .. "      Input ID: " .. tostring( button ) )
	
end

---@param index number Input button.
function PANEL:SetSelectedButton( index )
	local this = self
	local panel = self.SelectedButtonPanel
	if ( not index ) then panel:Clear(); panel:SetHeight( 0 ); return end
	local showButtons = ( #this.SelectedButtonNodes == 1 )
	local section = self:BuildActionsSection( panel, "Key / Button", 64, false, ( showButtons ) )
	local addButton = section.AddButton( "Bind a Command...", "plus-box-multiple-outline",
		function()
			this:ShowCommandSelectionBrowser( function( command ) 
				Photon2.Library.InputConfigurations.AddCommandToButton( this.WorkingCopy, index, command )
				this.SelectedButtonNodes = { index, #this.WorkingCopy.Binds[index] }
				this:PushWorkingCopyChange()
			end)
		end
	)
	local clearButton = section.AddButton( "Clear All Command Bindings", "eraser",
		function()
			Photon2.UI.DialogBox.Confirm(
				"Delete all commands?",
				"Are you sure you want to clear ALL commands assigned to this button?",
				function()
					Photon2.Library.InputConfigurations.ClearCommandsFromButton( this.WorkingCopy, index )
					this.SelectedButtonNodes = { index }
					this:PushWorkingCopyChange()
				end,
				nil
			)
		end
	)
	local deleteButton = section.AddButton( "Delete This Key / Button", "delete-outline",
		function()
			Photon2.UI.DialogBox.Confirm(
				"Delete this button?", 
				"Are you sure you want to delete this button and clear all assigned commands?",
				function()
					Photon2.Library.InputConfigurations.DeleteButton( this.WorkingCopy, index )
					this.SelectedButtonNodes = nil
					this:PushWorkingCopyChange()
				end
			)
		end
	)
	self:BuildActionsSectionButtonDisplay( section.Left, index )
end

function PANEL:SetSelectedCommand( buttonIndex, index )
	local this = self
	local panel = self.SelectedCommandPanel
	if ( not IsValid( panel ) ) then return end
	if ( not index ) then panel:Clear(); panel:SetHeight( 0 ); return end
	local commandName = self.WorkingCopy.Binds[buttonIndex][index].Command
	local showButtons = ( #this.SelectedButtonNodes == 2 )
	local section = self:BuildActionsSection( panel, "Command", 136, true, ( showButtons ) )
	local swapButton = section.AddButton( "Change This Command...", "swap-horizontal-variant",
		function()
			this:ShowCommandSelectionBrowser( function( command )
				Photon2.Library.InputConfigurations.SwapButtonCommand( this.WorkingCopy, buttonIndex, index, command )
				this.SelectedButtonNodes = { buttonIndex, index }
				this:PushWorkingCopyChange()
			end)
		end
	)
	local addModifier = section.AddButton( "Add a Modifier Key / Button...", "keyboard", 
		function()
			Photon2.UI.DialogBox.ButtonInput( "Add modifier button...",
				function( key )
					Photon2.Library.InputConfigurations.AddModifierToCommand( this.WorkingCopy, buttonIndex, index, key )
					this.SelectedButtonNodes = { buttonIndex, index }
					this:PushWorkingCopyChange()
				end
			)
		end
	)
	local clearButton = section.AddButton( "Clear All Modifiers", "eraser",
		function()
			Photon2.UI.DialogBox.Confirm(
				"Clear all modifiers?",
				"Are you sure you want to clear ALL modifier buttons assigned to this command?",
				function()
					Photon2.Library.InputConfigurations.ClearAllModifiers( this.WorkingCopy, buttonIndex, index )
					this.SelectedButtonNodes = { buttonIndex, index }
					this:PushWorkingCopyChange()
				end
			)
		end
	)
	local deleteButton = section.AddButton( "Unbind This Command", "close-box-outline", 
		function()
			Photon2.UI.DialogBox.Confirm(
				"Remove this command?",
				"Are you sure you want to remove this command from the button?",
				function()
					Photon2.Library.InputConfigurations.RemoveCommandFromButton( this.WorkingCopy, buttonIndex, index )
					this.SelectedButtonNodes = { buttonIndex }
					this:PushWorkingCopyChange()
				end
			)
		end
	)

	local command = Photon2.Library.Commands:Get( commandName )
	local format = string.format(
[[
	%s | %s
	
	Name: %s
	
	Description: %s
]],
	command.Category, command.Title, command.Name, command.Description)
	local commandInfo = vgui.Create( "DLabel", section.Left )
	commandInfo:SetText( format )
	-- commandInfo:SetText( tostring(commandName) .. " \n\n" .. tostring(command.Title) .. " (" .. command.Category .. ")\n\n" .. command.Description )
	commandInfo:Dock( TOP )
	commandInfo:SetAutoStretchVertical( true )
	-- commandInfo:SetHeight( 26 )
	commandInfo:SetContentAlignment( 7 )
	commandInfo:SetWrap( true )
end

-- Reloads the WorkingCopy object to update the UI and flags the entry as unsaved.
function PANEL:PushWorkingCopyChange()
	if ( not self.WorkingCopy ) then return end
	self:LoadInputConfiguration( self.WorkingCopy )
	self:MarkUnsaved()
end

function PANEL:SetSelectedModifier( buttonIndex, commandIndex, index )
	local this = self
	local panel = self.SelectedModifierPanel
	if ( not IsValid( panel ) ) then return end
	if ( not index ) then panel:Clear(); panel:SetHeight( 0 ); return end
	local buttonCode = self.WorkingCopy.Binds[buttonIndex][commandIndex].Modifiers[index]
	local showButtons = ( #this.SelectedButtonNodes == 3 )
	local section = self:BuildActionsSection( panel, "Modifier Key / Button", 64, false, ( showButtons ) )
	section.AddButton( "Change This Modifier...", "swap-horizontal-variant",
		function()
			Photon2.UI.DialogBox.ButtonInput( "Swap modifier button...",
				function( key )
					Photon2.Library.InputConfigurations.SwapCommandModifier( this.WorkingCopy, buttonIndex, index, key )
					this.SelectedButtonNodes = { buttonIndex, commandIndex }
					this:PushWorkingCopyChange()
				end
			)
		end
	)
	section.AddButton( "Remove This Modifier", "close-box-outline", 
		function ()
			Photon2.UI.DialogBox.Confirm(
				"Remove this button modifier?",
				"Are you sure you want to remove this button modifier from the command?",
				function()
					Photon2.Library.InputConfigurations.RemoveCommandModifier( this.WorkingCopy, buttonIndex, commandIndex, index )
					this.SelectedButtonNodes = { buttonIndex, commandIndex }
					this:PushWorkingCopyChange()
				end
			)
		end
	)
	
	self:BuildActionsSectionButtonDisplay( section.Left, buttonCode )

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
		Photon2.Library.InputConfigurations.AssignCommandToButtonBasic( this.WorkingCopy, num, data.Command.Name )
		this:PushWorkingCopyChange()
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
		Photon2.Library.InputConfigurations.AssignCommandToButtonBasic( this.WorkingCopy, currentPrimary, data.Command.Name, num )
		this:PushWorkingCopyChange()
	end

	if ( not currentPrimary ) then
		modifierBindButton:SetEnabled( false )
	end
end

derma.DefineControl( class, "Photon 2 basic input configuration window", PANEL, base )