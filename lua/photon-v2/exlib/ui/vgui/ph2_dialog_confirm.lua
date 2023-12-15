local class = "Photon2UIDialogConfirm"
local base = "Photon2UIDialogWindow"
---@class Photon2UIDialogConfirm: Photon2UIDialog
local PANEL = {}

PANEL.AllowAutoRefresh = true

PANEL.ButtonWidth = 80

function PANEL:Init()
	self:SetTitle("Confirm")
	self:MakePopup()
end

function PANEL:Setup( text, funcYes, funcNo )
	local this = self

	self.Text = text
	self:SetWidth( 280 )
	self:SetHeight( 120 )
	self:Center()
	self:SetupDialog()
	self:SetTitle("Confirm")

	self:SetMainText( text )

	local noButton = self:AddButton( "No", function() 
		print("No pressed.")
	end)

	local yesButton = self:AddButton( "Yes", function() 
		print("Yes pressed.")
	end)

end

function PANEL:PostAutoRefresh()
	self:Setup( self.Text )
end

derma.DefineControl( class, description, PANEL, base )
