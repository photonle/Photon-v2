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
		-- if ( not this.WorkingCopy ) then return end
		-- if ( this.WorkingCopy and not this.WorkingCopy.Name ) then 
		-- 	this:ShowSaveBrowser()
		-- end
	end)
	
	fileMenu:AddOption("Save As...", function()
		this:DoSaveAs()
	end)
	
	fileMenu:AddSpacer()
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
	listView:SetDataHeight( 20 )

	function listView:OnRowSelected( lineId, line )
		this:SetEditPanel( line.CommandData )
	end

	this.CommandList = listView



	self:SetMetaPanel(nil)

	local editPanel = vgui.Create( "DPanel", self )
	editPanel:DockMargin( 4, 0, 4, 4 )
	-- why 8???
	editPanel:DockPadding( 8, 4, 4, 4 )
	editPanel:SetHeight( 128 )
	editPanel:Dock( BOTTOM )
	self.EditPanel = editPanel

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
	if ( IsValid( self.MetaPanel ) ) then self.MetaPanel:Remove() end

	---@type Photon2UIFormPanel
	local metaPanel = vgui.Create( "Photon2UIFormPanel", self )
	metaPanel.LabelWidth = 50
	metaPanel:Dock( TOP )
	metaPanel:SetHeight( 128 ) 
	metaPanel:DockMargin( 4, 4, 4, 0 )
	metaPanel:DockPadding( 8, 4, 4, 4 )
	metaPanel:SetPaintBackground( false )
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

	print("PANEL SHOULD BE VISIBLE")
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

function PANEL:PreAutoRefresh()
end

function PANEL:PostAutoRefresh()
	self.WorkingCopy = self.WorkingCopy or "default"
	self:LoadInputConfiguration( self.WorkingCopy )
end 

function PANEL:MarkUnsaved()
	self:SetTitlePrefix( "*" )
	self.WorkingCopy.Unsaved = true
end

function PANEL:MarkSaved()
	self:SetTitlePrefix("")
	self.WorkingCopy.Saved = true
end


function PANEL:SetEditPanel( data )
	self.EditPanel:Clear()
	if ( not data ) then return end
	local this = self
	local editPanel = self.EditPanel

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