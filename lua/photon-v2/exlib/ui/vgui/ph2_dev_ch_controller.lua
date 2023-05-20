local class = "Photon2ChannelController"
local base = "DFrame"
local PANEL = {}

local placeholderModes = { "Mode 1", "Mode 2", "Mode 3", "Mode 4" }


function PANEL:AddModeSelection( channel, modes )
	local panel = vgui.Create( "DPanel", self.ScrollPanel )
	panel:DockMargin( 8, 8, 8, 0 )
	panel:Dock( TOP )
	
	local label = vgui.Create( "DLabel", panel )
	label:SetText( channel )
	label:Dock( LEFT )
	label:SetWide( 160 )
	label:DockMargin( 8, 0, 0, 0 )
	local comboBox = vgui.Create( "DComboBox", panel )
	comboBox:Dock( FILL )

	
	for _, value in pairs( modes ) do
		comboBox:AddChoice( value )
	end
end

function PANEL:Init()
	self:SetSkin("PhotonStudio")
	self:SetTitle("Channel Controller - Photon 2")
	self:SetIcon("photon/ui/studio_icon_16.png")
	self:SetSize( 400, 600 )
	self:Center()
	self:SetSizable(true)
	self:MakePopup()

	

	local label = vgui.Create( "DLabel", self )
	label:Dock( TOP )
	label:SetText( "Select Controller Entity:" )

	local controllerSelector = vgui.Create( "DComboBox", self )
	controllerSelector:DockMargin( 0, 8, 0, 0 )

	controllerSelector:SetPos( 8, 8 )
	controllerSelector:Dock( TOP )

	local refreshButton = vgui.Create( "DButton", self )
	refreshButton:SetText( "Refresh" )
	refreshButton:Dock ( TOP )
	refreshButton:DockMargin( 0, 8, 0, 0 )

	local channelListPanel = vgui.Create( "DPanel", self )
	channelListPanel:Dock( FILL )
	channelListPanel:DockPadding( 0, 0, 0, 0 )
	channelListPanel:DockMargin( 0, 8, 0, 0)

	local scrollPanel = vgui.Create( "DScrollPanel", channelListPanel )
	scrollPanel:DockMargin( 0, 0, 0, 0 )
	scrollPanel:Dock( FILL )
	scrollPanel:DockPadding( 0, 0, 0, 0 )
	self.ScrollPanel = scrollPanel

	-- for i=0, 10 do
	-- 	local button = scrollPanel:Add( "DButton" )
	-- 	button:SetText( "Button " .. tostring(i) )
	-- 	button:Dock( TOP )
	-- 	button:DockMargin( 0, 0, 0, 5 )
	-- end
	for category, channels in pairs( Photon2.DefaultChannelTree ) do
		for _, channel in pairs( channels ) do
			self:AddModeSelection( category .. "." .. channel, placeholderModes )
		end
	end

end

derma.DefineControl(class, "", PANEL, base)
