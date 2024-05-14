local class = "Photon2UIVehicleCreator"
local base = "Photon2UIWindow"

---@class Photon2UIVehicleCreator : Photon2UIWindow
local PANEL = {}
PANEL.AllowAutoRefresh = true

PANEL.TitleMain = "Vehicle Code Creator"
PANEL.TitleSuffix = " - Photon 2"

function PANEL:Init()
	self.BaseClass.Init( self )
	local this = self
	self:SetSize( 340, 560 )
	self:Center()
	self:Setup()
end

local processName = function( name )
	name = string.lower(name)
	name = string.gsub(name, " ", "_")
	name = string.gsub(name, "%W", "")
	return name
end

function PANEL:Setup()
	if ( IsValid( self.Content ) ) then self.Content:Remove() end
	self:SetMinWidth( 280 )
	self:SetMinHeight( 140 )
	self:MakePopup()
	self:SetTitleMain( self.TitleMain )

	local sections = {}

	local function addTextEntry( id, label, placeholder, browse )
		local section = vgui.Create( "DPanel", self.Content )
		section:Dock( TOP )
		section:DockMargin( 8, 6, 8, 0 )
		section:SetTall( 26 )
		section:SetPaintBackground( false )

		local sectionLabel = vgui.Create( "DLabel", section )
		sectionLabel:Dock( LEFT )
		sectionLabel:SetText( label )
		sectionLabel:SetWide( 64 )
		sectionLabel:SetContentAlignment( 4 )

		local textbox = vgui.Create( "DTextEntry", section )
		textbox:Dock( FILL )
		textbox:SetPlaceholderText( placeholder )
		section.Label = sectionLabel
		section.TextBox = textbox
		
		sections[id] = section

		if ( browse ) then
			local browseButton = vgui.Create( "EXDButton", section )
			browseButton:Dock( RIGHT )
			browseButton:SetWide( 96 )
			browseButton:DockMargin( 4, 1, 0, 1 )
			browseButton:SetText( "  Browse..." )
			browseButton:SetIcon( "folder" )
			function browseButton:DoClick()
				local window = vgui.Create( "Photon2UILibraryBrowser" )
				window:Setup( browse, "SELECT" )
				window:Center()
				function window:OnFileConfirmed( entryName )
					textbox:SetText( entryName )
					window:Close()
				end
			end
		end

		return section
	end

	local function addDivider()
		local divider = vgui.Create( "DPanel", self.Content )
		divider:Dock( TOP )
		divider:DockMargin( 8, 12, 8, 4 )
		divider:SetTall( 1 )
		function divider:Paint( w, h )
			surface.SetDrawColor( 0, 0, 0, 128 )
			surface.DrawRect( 0, 0, w, h )
		end
	end

	local content = vgui.Create( "DScrollPanel", self )
	content:Dock( FILL )
	self.Content = content

	local bannerContainer = vgui.Create( "DPanel", self.Content )
	bannerContainer:Dock( TOP )
	bannerContainer:SetHeight( 100 )
	bannerContainer:SetPaintBackground( false )

	local bannerImage = vgui.Create( "DImage", bannerContainer )
	bannerImage:SetContentAlignment( 5 )
	bannerImage:SetSize( 203, 80 )
	bannerImage:SetKeepAspect( true )
	bannerImage:SetImage( "photon/ui/ui_veh_generator.png" )

	function bannerContainer:PerformLayout( w, h )
		bannerImage:SetPos( (w - 203) / 2, (h - 80) / 2 )
	end

	addTextEntry( "Name", "Name:", processName( LocalPlayer():Name() ) .. "_unique_vehicle_name" )
	addTextEntry( "Title", "Title:", "My Photon 2 Vehicle Title" )
	addTextEntry( "Category", "Category:", "Spawn Category" )
	
	local function addComponentSection()
		local componentSection = vgui.Create( "DPanel", self.Content )
		componentSection:Dock( TOP )
		componentSection:SetTall( 96 )
		componentSection:DockMargin( 8, 4, 8, 4 )
		componentSection:SetPaintBackground( false )
		
		local componentSectionLabel = vgui.Create( "DLabel", componentSection )
		componentSectionLabel:Dock( TOP )
		componentSectionLabel:SetText( "Add any initial Components to include:" )
		componentSectionLabel:SetContentAlignment( 7 )
		componentSectionLabel:SetTall( 24 )

		local componentsButtonPanel = vgui.Create( "DPanel", componentSection )
		componentsButtonPanel:Dock( RIGHT )
		componentsButtonPanel:SetWide( 96 )
		componentsButtonPanel:SetPaintBackground( false )
		componentsButtonPanel:DockMargin( 4, 0, 0, 0 )

		local componentSectionList = vgui.Create( "DListView", componentSection )
		componentSectionList:Dock( FILL )
		componentSectionList:AddColumn( "Component Name" )
		componentSectionList:SetMultiSelect( false )

		local addButton = vgui.Create( "EXDButton", componentsButtonPanel )
		addButton:Dock( TOP )
		addButton:SetText( "Add...    " )
		addButton:SetIcon( "plus-box" )
		addButton:SetHeight( 24 )
		
		local removeButton = vgui.Create( "EXDButton", componentsButtonPanel )
		removeButton:Dock( TOP )
		removeButton:DockMargin( 0, 4, 0, 0 )
		removeButton:SetText( "Remove" )
		removeButton:SetIcon( "delete" )
		removeButton:SetHeight( 24 )
		removeButton:SetEnabled( false )
		
		function removeButton:DoClick()
			local selected = componentSectionList:GetSelectedLine()
			if ( selected ) then
				componentSectionList:RemoveLine( selected )
				removeButton:SetEnabled( false )
			end
		end

		function addButton:DoClick()
			local window = vgui.Create( "Photon2UILibraryBrowser" )
			window:Setup( "Components", "SELECT" )
			window:Center()
			function window:OnFileConfirmed( entryName )
				local line = componentSectionList:AddLine( entryName )
				componentSectionList:OnClickLine( line, true )
				window:Close()
			end
		end

		function componentSectionList:OnRowSelected( index, row )
			removeButton:SetEnabled( true )
		end

		sections.Components = componentSectionList
	end

	addTextEntry( "Siren", "Siren:", "siren_name (Optional)", "Sirens" )
	addTextEntry( "Livery", "Livery:", "path/to/material or .png (Optional)" )
	addDivider()
	addComponentSection()
	
	
	addDivider()

	local function setupVehicleConfigSection()
		local topLabel = vgui.Create( "DLabel", self.Content )
		topLabel:DockMargin( 8, 6, 8, 0 )
		topLabel:Dock( TOP )
		topLabel:SetWrap( true )
		topLabel:SetAutoStretchVertical( true )
		topLabel:SetMultiline( true )
		topLabel:SetText( "Spawn a vehicle and configure your desired body groups, sub materials, color and skin.\n\nWhen complete, enter the driver seat and click the button below.\n" )
	end

	setupVehicleConfigSection()

	local function doGenerate()
		local codeWindow = vgui.Create( "Photon2UICode" )
		codeWindow:SetSize( 680, 480 )
		codeWindow:Center()

		local components = {}
		for k, v in pairs( sections.Components:GetLines() ) do
			components[#components+1] = v:GetValue( 1 )
		end

		local code = self:GenerateVehicleCode( 
			sections["Name"].TextBox:GetText(), 
			sections["Title"].TextBox:GetText(), 
			sections["Category"].TextBox:GetText(), 
			components,
			sections["Siren"].TextBox:GetText(), 
			sections["Livery"].TextBox:GetText(),
			LocalPlayer():GetVehicle()
		)

		codeWindow:SetCode( code )
	end

	local generateButton = vgui.Create( "EXDButton", self.Content )
	generateButton:Dock( TOP )
	generateButton:SetText( "Generate Code..." )
	generateButton:DockMargin( 8, 8, 8, 8 )
	generateButton:SetHeight( 32 )
	generateButton:SetIcon( "code-tags" )
	function generateButton:DoClick()
		if ( sections["Title"].TextBox:GetText() == "" ) then
			Photon2.UI.DialogBox.UserError( "You must enter a Title for your vehicle." )
			return
		end
		if ( sections["Category"].TextBox:GetText() == "" ) then
			Photon2.UI.DialogBox.UserError( "You must enter a Category for your vehicle." )
			return
		end
		if ( not IsValid( LocalPlayer():GetVehicle() ) ) then
			Photon2.UI.DialogBox.UserError( "You must be seated in a spawned vehicle." )
			return
		end
		doGenerate()
	end
	
	-- Pre-populate for testing
	-- sections.Name.TextBox:SetText( "generated_vehicle_name" )
	-- sections.Title.TextBox:SetText( "Generated Vehicle Title" )
	-- sections.Category.TextBox:SetText( "Photon 2: Schmal" )
	-- sections.Siren.TextBox:SetText( "whelen_epsilon_alt" )
	-- sections["Livery"].TextBox:SetText( "photon/common/glow" )
	-- sections.Components:AddLine( "photon_whe_ion" )
	-- sections.Components:AddLine( "photon_whe_legacy_48" )

end

function PANEL:PreAutoRefresh()
end

function PANEL:PostAutoRefresh()
	self:Setup()
end

function PANEL:GenerateVehicleCode( name, title, category, components, siren, livery, vehicle )
	local skin = 0
	local color = Color( 255, 255, 255 )
	local vehicleClass = "ERROR"
	local bodyGroups, materials

	local result = ""
	local header = [[
-- Generated by the Photon 2 Vehicle Code Builder
--
-- Next steps:
--
-- 1. Click the "Copy to Clipboard" button and then paste the code into a new text file
-- 2. If you do not have a project folder for your work, create a new folder in garrysmod/addons/ (e.g. garrysmod/addons/%s_photon2_content)
-- 3. Save this file as garrysmod/addons/<your_addon_folder>/lua/photon-v2/library/vehicles/%s.lua
-- 4. Restart Garry's Mod
-- 5. Spawn your vehicle from the %s category on the Vehicles tab
-- 6. Edit this code to adjust your component placement and other settings
--
-- For more information, visit https://photon.lighting/docs
--

if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

-- Readable title of the vehicle
VEHICLE.Title = %q

-- Unique identifier of the BASE vehicle
VEHICLE.Vehicle = %q

-- Spawn category of the vehicle
VEHICLE.Category = %q

-- The author of this vehicle file
VEHICLE.Author = %q

VEHICLE.Properties = {
	Skin = %u,
	Color = Color( %u, %u, %u ),
}
]]

	local componentIndex = 90
	local function formatComponent( component )
		componentIndex = componentIndex + 10
		return string.format( [[
	{
		Component = %q,
		Position = Vector( 0, 0, %u ),
		Angles = Angle( 0, 0, 0 ),
		Scale = 1,
	},
]], tostring( component ), componentIndex )
	end

	if ( IsValid( vehicle ) ) then
		skin = vehicle:GetSkin()
		color = vehicle:GetColor()
		-- PrintTable( vehicle.VehicleTable )
		vehicleClass = vehicle:GetVehicleClass()
		if ( istable( vehicle.VehicleTable ) and (vehicle.VehicleTable.IsPhoton2Generated and vehicle.VehicleTable.Base ) ) then
			vehicleClass = vehicle.VehicleTable.Base
		end
		bodyGroups = vehicle:GetBodyGroups()
		materials = vehicle:GetMaterials()
	end

	result = result .. string.format( header, processName( LocalPlayer():Name() ), name, category, title, vehicleClass, category, LocalPlayer():Name(), skin, color.r, color.g, color.b )

	if ( bodyGroups ) then
		result = result .. [[

-- Body-Group Example:
-- ["groupName"] = 1
VEHICLE.BodyGroups = {]]
		local anyBodyGroups = false
		for _, group in ipairs( bodyGroups ) do
			-- If index [1] is nil then the length is less than 2 and can be ignored
			if ( not group.submodels[1] ) then continue end
			result = result .. string.format( "\n\t[%q] = %u,", group.name, vehicle:GetBodygroup( group.id ) )
			anyBodyGroups = true
		end
		if ( anyBodyGroups ) then result = result .. "\n" end
		result = result .. "}\n"
	end

	if ( materials ) then
		result = result .. [[

-- Sub-Material Example:
-- [1] = "path/to/material"
VEHICLE.SubMaterials = {]]
		local anySubMaterials = false
		for index, defaultMaterial in pairs( materials ) do
			if ( vehicle:GetSubMaterial( index - 1 ) == "" ) then continue end
			result = result .. string.format( "\n\t[%u] = %q,", index - 1, vehicle:GetSubMaterial( index - 1 ) )
			anySubMaterials = true
		end
		if ( anySubMaterials ) then result = result .. "\n" end
		result = result .. "}\n"
	end

	if ( livery and livery ~= "" ) then
		result = result .. string.format( "\nVEHICLE.Livery = %q \n", livery )
	end

	if ( siren and siren ~= "" ) then
		result = result .. string.format( "\nVEHICLE.Siren = %q \n", siren )
	end

	if ( istable( components ) ) then
		result = result .. [[

-- Component Example:
--	{
--		Component = "component_name",
--		Position = Vector( 10, 20, 30 ),
--		Angles = Angle( 0, 45, 90 ),
--		Scale = 0.9,
--		States = { "R", "B" },
--		Phase = 180,
--		Segments = {
--			MyCustomSegment = {
--					Frames = {
--						[1] = "1 3 5",
--						[2] = "2 4 6"
--					},
--					Sequences = {
--						["MY_SEQUENCE"] = { 1, 2 }
--					}
--				}
--		},
--		Inputs = {
--			["Emergency.Warning"] = {
--				["MODE1"] = {
--					MyCustomSegment = "MY_SEQUENCE"
--				}
--			}
--		}
--	}
VEHICLE.Components = {]]
		if ( siren and siren ~= "" ) then
			result = result .. string.format([[

	{
		-- Siren speaker component, which is where the siren originates from
		Component = "siren_prototype",
		Position = Vector( 0, 0, %u ),
		Angles = Angle( 0, 0, 0 ),
		Scale = 1,
		-- This points to the siren name defined above
		Siren = 1
	},
]], componentIndex + 10 )
			componentIndex = componentIndex + 10
		end
		local anyComponents = false
		for _, component in ipairs( components ) do
			result = result .. formatComponent( component )
			anyComponents = true
		end
		result = result .. "}\n"
	end

	result = result .. [[

-- Props Example:
--	{
--		Model = "models/tdmcars/emergency/equipment/setina_bodyguard.mdl",
--		Position = Vector( 0, 100, 20 ),
--		Angles = Angle( 0, 0, 0 ),
--		Scale = 1,
--	}
VEHICLE.Props = {}
]]

	return result
end

derma.DefineControl( class, "Photon 2 vehicle scaffold builder.", PANEL, base )
