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
	local menu = Photon2.UI.MenuBar
	menu:AddOption( "Refresh Menu", function()
		Photon2.UI.ReloadMenubar()
	end)
	local debugOption = menu:AddOption( "Debug" )
	local debugMenu = debugOption:AddSubMenu()
	debugMenu:SetDeleteSelf( false )
	debugMenu:AddOption( "Reload Library", function()
		Photon2.LoadComponentLibrary()
	end)
	debugMenu:AddOption( "Reload Index", function()
		Photon2.Index.ProcessComponentLibrary()
	end)
	local printOption = debugMenu:AddOption( "Print to Console" )
	local printMenu = printOption:AddSubMenu()
	printMenu:SetDeleteSelf( false )
	for id, entry in pairs( Photon2.Index.Components ) do
		printMenu:AddOption( id, function()
			PrintTable( entry )
		end)
	end


	
	Photon2.Debug.Print("MenuBar populated.")
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