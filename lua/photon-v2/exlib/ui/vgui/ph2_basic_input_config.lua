local class = "Photon2BasicInputConfig"
local base = "Photon2UIWindow"
---@class Photon2UIBasicInputConfig : Photon2UIWindow
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

end

derma.DefineControl( class, "Photon 2 basic input configuration window", PANEL, base )