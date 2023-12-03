local class = "Photon2BasicInputConfig"
local base = "Photon2UIWindow"
---@class Photon2UIBasicInputConfig : Photon2UIWindow
---@field EditPanel Panel
local PANEL = {}

function PANEL:Init()
	self.BaseClass.Init( self )

	local this = self

	self:SetTitle("Input Configuration - Photon 2")

	local menubar = self:GetOrBuildMenuBar()
	local fileMenu = menubar:AddMenu("File")
	fileMenu:AddOption("Close", function()
		this:Remove()
	end)

	---@type EXDListView
	local listView = vgui.Create( "EXDListView", self )
	local catColumn = listView:AddColumn( "Category" )
	catColumn:SetMaxWidth(96)
	local cmdColumn = listView:AddColumn( "Command" )
	cmdColumn:SetMaxWidth(128)
	local keyColumn = listView:AddColumn( "Key(s)" )
	keyColumn:SetMinWidth(128)

	listView:DockMargin( 4, 4, 4, 4 )
	listView:Dock( FILL )
	listView:SetMultiSelect( false )

	function listView:OnRowSelected( lineId, line )
		this:SetEditPanel( line.CommandData )
	end

	local byCommand = {}
	local inputConfig = Photon2.Library.InputConfigurations["default"]

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
			byCommand[command][#byCommand[command]+1] = keyString
		end
	end

	for key, command in SortedPairsByMemberValue( Photon2.Index.Commands, "ExtendedTitle" ) do
		local keys = ""
		if ( byCommand[command.Name] ) then
			keys = table.concat( byCommand[command.Name], ", " )
		end
		local line = listView:AddLine( command.Category, command.Title, keys )
		line.CommandData = command
	end

	local editPanel = vgui.Create( "DPanel", self )
	editPanel:DockMargin( 4, 0, 4, 4 )
	editPanel:DockPadding( 8, 4, 4, 4 )
	editPanel:Dock( BOTTOM )
	editPanel:SetHeight( 128 )
	self.EditPanel = editPanel

	
end

function PANEL:SetEditPanel( data )
	self.EditPanel:Clear()
	if ( not data ) then return end
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
	
	local editButton = vgui.Create( "DButton", buttonsPanel )
	editButton:DockMargin( 0, 0, 0, 8 )
	editButton:Dock( TOP )
	editButton:SetText( "Edit Key..." )
	
	local clearButton = vgui.Create( "DButton", buttonsPanel )
	clearButton:DockMargin( 0, 0, 0, 8 )
	clearButton:Dock( TOP )
	clearButton:SetText( "Clear" )

	local resetButton = vgui.Create( "DButton", buttonsPanel )
	resetButton:Dock( TOP )
	resetButton:SetText( "Reset to Default" )

	local cmdTitleLabel = vgui.Create( "DLabel", editPanel )
	cmdTitleLabel:Dock( TOP )
	cmdTitleLabel:SetText( data.Category .. " | " .. data.Title )

	local cmdDescriptionLabel = vgui.Create( "DLabel", editPanel )
	cmdDescriptionLabel:SetAutoStretchVertical( true )
	cmdDescriptionLabel:SetWrap( true )
	cmdDescriptionLabel:Dock( TOP )
	cmdDescriptionLabel:SetText( data.Description )
end

derma.DefineControl( class, "Photon 2 basic input configuration window", PANEL, base )