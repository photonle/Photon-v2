local class = "Photon2ChannelController"
local base = "DFrame"
local PANEL = {}

local placeholderModes = { "Mode 1", "Mode 2", "Mode 3", "Mode 4" }
local printf = Photon2.Debug.PrintF

function PANEL:AddModeSelection( channel, modes, current )
	local this = self
	local panel = vgui.Create( "DPanel", self.ScrollPanel )
	panel:DockMargin( 8, 8, 8, 0 )
	panel:Dock( TOP )
	
	self.Channels[channel] = panel

	local label = vgui.Create( "DLabel", panel )
	label:SetText( channel )
	label:Dock( LEFT )
	label:SetWide( 160 )
	label:DockMargin( 8, 0, 0, 0 )

	local comboBox = vgui.Create( "DComboBox", panel )
	comboBox:Dock( FILL )
	function comboBox:OnSelect( index, value, data )
		-- print("%%%%%%%%%%%%%%%%%%%%%% d")
		-- PrintTable( data )
		-- print("%%%%%%%%%%%%%%%%%%%%%% d")
		if ( not this.SupressOptions ) then
			Photon2.cl_Network.SetControllerChannelState( data[1], data[2], data[3] )
		end
	end
	
	for _, value in pairs( modes ) do
		comboBox:AddChoice( value, { this.CurrentController, channel, value }, ( value == current ))
	end

	if ( #modes < 2) then
		comboBox:SetEnabled( false )
	end

	return panel
end

function PANEL:LoadControllers()
	self.ControllerSelector.Choices = {}
	for k, v in pairs( ents.FindByClass("photon_controller") ) do
		self.ControllerSelector:AddChoice( tostring(v) .. " (" .. v:GetProfileName() .. ")", v )
	end
end

function PANEL:Init()
	local this = self
	self:SetSkin("PhotonStudio")
	self:SetTitle("Channel Controller - Photon 2")
	self:SetIcon("photon/ui/studio_icon_16.png")
	self:SetSize( 400, 600 )
	self:Center()
	self:SetSizable(true)
	
	self.Channels = {}
	-- self:MakePopup()

	

	local label = vgui.Create( "DLabel", self )
	label:Dock( TOP )
	label:SetText( "Select Controller Entity:" )

	local controllerSelector = vgui.Create( "DComboBox", self )
	controllerSelector:DockMargin( 0, 8, 0, 0 )
	controllerSelector:SetPos( 8, 8 )
	controllerSelector:Dock( TOP )
	
	controllerSelector.DoClick = function( self )
		if ( self:IsMenuOpen() ) then
			return self:CloseMenu()
		end
		this:LoadControllers()
		self:OpenMenu()
	end

	self.ControllerSelector = controllerSelector

	function controllerSelector:OnSelect( index, value, data )
		this.ScrollPanel:DeleteChannels()
		local validInputs = data:GetChannelModeTree()
		this.CurrentController = data
		for channel, mode in pairs( data.CurrentModes ) do
			lastMode = this:AddModeSelection( channel, validInputs[channel] or { mode }, mode )
		end
	end

	function controllerSelector.OnMenuOpened( menu )
		self:LoadControllers()
	end

	local channelListPanel = vgui.Create( "DPanel", self )
	channelListPanel:Dock( FILL )
	channelListPanel:DockPadding( 0, 0, 0, 0 )
	channelListPanel:DockMargin( 0, 8, 0, 0)

	local scrollPanel = vgui.Create( "DScrollPanel", channelListPanel )
	scrollPanel:DockMargin( 0, 0, 0, 0 )
	scrollPanel:Dock( FILL )
	scrollPanel:DockPadding( 0, 0, 0, 0 )
	scrollPanel:GetCanvas():DockPadding( 0, 0, 0, 8 )
	function scrollPanel:DeleteChannels()
		for channel, panel in pairs( this.Channels ) do
			panel:Remove()
			this.Channels[channel] = nil
		end

		for k, v in pairs(scrollPanel:GetCanvas():GetChildren()) do
			v:Remove()
		end

	end

	self.ScrollPanel = scrollPanel

	-- for i=0, 10 do
	-- 	local button = scrollPanel:Add( "DButton" )
	-- 	button:SetText( "Button " .. tostring(i) )
	-- 	button:Dock( TOP )
	-- 	button:DockMargin( 0, 0, 0, 5 )
	-- end
	-- for category, channels in pairs( Photon2.DefaultChannelTree ) do
	-- 	for _, channel in pairs( channels ) do
	-- 		self:AddModeSelection( category .. "." .. channel, placeholderModes )
	-- 	end
	-- end

	self:LoadControllers()

	self.SupressOptions = true
	if ( #self.ControllerSelector.Choices > 0 ) then
		self.ControllerSelector:ChooseOption( self.ControllerSelector.Choices[1], 1 )
	end
	self.SupressOptions = false
end

derma.DefineControl(class, "", PANEL, base)
