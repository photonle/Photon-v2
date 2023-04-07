Photon2.UI = Photon2.UI or {}

function Photon2.UI.ReloadMenubar()
	Photon2.Debug.Print("Reloading MenuBar...")
	-- Photon2.Debug.Print("\t" .. tostring(Photon2.UI.MenuBar))
	if (IsValid(Photon2.UI.MenuBar)) then
		-- Photon2.Debug.Print("\tMenuBar is valid..")
		Photon2.UI.MenuBar:Clear()
		timer.Simple(0.5, function()
			-- Photon2.UI.Menubar:Remove()
			-- Photon2.Debug.Print("\tRe-populating MenuBar...")
			Photon2.UI.PopulateMenuBar()
		end)
	end
end

function Photon2.UI.PopulateMenuBar()
	-- Necesssary due to debugMenu:SetDeleteSelf( false )
	-- TODO: populate on each open to resolve
	timer.Simple(0.01, function ()
		local menu = Photon2.UI.MenuBar
		menu:AddOption( "Refresh Menu", function()
			Photon2.UI.ReloadMenubar()
		end)
		local debugOption = menu:AddOption( "Debug" )
		local debugMenu = debugOption:AddSubMenu()
		debugMenu:SetDeleteSelf( false )
		debugMenu:AddOption( "Print Profiles to Console", function()
			PrintTable( Photon2.Index.Profiles )
		end)
		debugMenu:AddOption( "Print Vehicle Index to Console", function()
			PrintTable( Photon2.Index.Vehicles )
		end)
		debugMenu:AddOption( "Reload Components", function()
			Photon2.LoadComponentLibrary()
		end)
		debugMenu:AddOption( "Reload Vehicles", function()
			Photon2.LoadVehicleLibrary()
		end)
		local printOption = debugMenu:AddOption( "Print to Console" )
		local printMenu = printOption:AddSubMenu()
		printMenu:SetDeleteSelf( false )
		for id, entry in pairs( Photon2.Index.Components ) do
			printMenu:AddOption( id, function()
				PrintTable( Photon2.Index.Components[id] )
			end)
		end

		Photon2.Debug.Print("MenuBar populated.")
	end)
	
end

function Photon2.UI.OnPopulateMenuBar( menubar )
	Photon2.UI.MenuBar = menubar:AddOrGetMenu( "Photon 2" )
	Photon2.UI.PopulateMenuBar()
	-- Photon2.Debug.Print("PopulateMenuBar called.")
end

concommand.Add("ph2_debug_reloadmenubar", function()
	Photon2.UI.ReloadMenubar()
end)

hook.Add( "PopulateMenuBar", "Photon2:PopulateMenuBar", Photon2.UI.OnPopulateMenuBar )



--[[
	Sandbox Properties Context Menu 
--]]

properties.Add("photon2_equipment", {
	MenuLabel = "Equipment",
	Order = 60,
	Filter = function(self, ent, ply)
		if (not IsValid( ent:GetPhotonController() )) then
			return false
		end
		return true
	end,
	---@param ent PhotonController
	MenuOpen = function(self, option, ent)
		local controller = ent:GetPhotonController()
		local currentSelections = controller.CurrentSelections
		local selections = controller:GetProfile().Selections
		-- Required so child elements can be applied
		local subMenu = option:AddSubMenu()
		for i, category in ipairs( selections ) do
			-- Create category's sub-menu
			local categoryMenu = subMenu:AddSubMenu( category.Category )
			-- Process each option
			for _i, opt in ipairs( category.Options ) do
				-- Process variants if applicable
				if (opt.Variants) then
					local optMenu = categoryMenu:AddSubMenu( opt.Option )
					for __i, variant in ipairs(opt.Variants) do
						local this = optMenu:AddOption( variant.Variant, function()
							Photon2.cl_Network.SetControllerSelection( controller, { { i, variant.Selection } } )
						end)
						if (currentSelections[i] == variant.Selection ) then
							this:SetChecked( true )
						end
					end
				else
					-- Process option if applicable
					local this = categoryMenu:AddOption( opt.Option, function() 
						Photon2.cl_Network.SetControllerSelection( controller,  { { i, opt.Selection } }  )
					end)

					if (currentSelections[i] == opt.Selection) then
						this:SetChecked( true )
					end

				end
			end
		end
	end
})