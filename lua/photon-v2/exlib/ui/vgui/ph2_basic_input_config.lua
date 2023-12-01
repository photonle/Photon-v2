local class = "Photon2BasicInputConfig"
local base = "DFrame"
local PANEL = {}

function PANEL:Init()
	local this = self
	self:SetSkin("PhotonStudio")
	self:SetTitle("Input Configuration - Photon 2")
	self:SetIcon("photon/ui/studio_icon_16.png")
	self:SetSize( 400, 600 )
	self:Center()
	self:SetSizable(true)

	local lp, tp, rp, bp = this:GetDockPadding()
	this:DockPadding(1, tp - 5, 1, 1)
	local menubar = vgui.Create( "EXDMenuBar", this )
	menubar:SetSkin(this:GetSkin().ID)
	menubar:Dock(TOP)

---@diagnostic disable-next-line: undefined-field
	local fileMenu = menubar:AddMenu("File")
	fileMenu:AddOption("Close", function()
		this:Remove()
	end)

end

derma.DefineControl( class, "Photon 2 basic input configuration window", PANEL, base )