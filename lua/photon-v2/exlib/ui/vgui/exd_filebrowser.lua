local class = "EXDFileBrowser"
local base = "DFrame"
local description = "Photon EX Component Browser"
local PANEL = {}

AccessorFunc(PANEL, "m_sFileName", "FileName")

---TODO: filename validation
function PANEL:DoSelect()
	if (not self.m_sFileName) then return end
	self:OnSelect(self.m_sFileName)
	self:Close()
end

--- OVERRIDE
function PANEL:OnSelect(fileName) end

--- OVERRIDE
function PANEL:OnCancel() end

function PANEL:AbsoluteCenter()
	self:SetPos((ScrW()/2) - (self:GetWide()/2), (ScrH()/2) - (self:GetTall()/2))
end

local width = 540
local height = 360
local sidebarWidth = 128
local margin = 8
local btnWidth = 74
local textHeight = 22

PANEL.m_bRelativeFileName = false

function PANEL:SelectFile(fullFileName)
	self.m_sFileName = fullFileName
	local displayPath = fullFileName
	if (self.m_bRelativeFileName) then
		displayPath = string.GetFileFromFilename(displayPath)
	end
	self.m_pFileName:SetText(displayPath)
end

function PANEL:Init()
	local this = self
	self:SetCookieName("EXBrowser")
	self:SetFocusTopLevel(true)
	self:SetTitle("Component Browser")
	self:SetSize(width, height)
	self:AbsoluteCenter()
	self:MakePopup()
	self:SetSizable(true)
	local c = vgui.Create("DPanel", self)
	local pathControls = vgui.Create("DPanel", self)
	pathControls:SetDrawBackground(false)
	local searchControls = vgui.Create("DPanel", self)
	searchControls:SetDrawBackground(false)

	pathControls:DockPadding(margin, margin, 0, margin)
	searchControls:DockPadding(0, margin, margin, margin)

	local topContainer = vgui.Create("EXDHorizontalDivider", c)
	topContainer:SetCookieName("EXBrowser.TopControls")
	topContainer:SetAnchor("R")
	topContainer:Dock(FILL)
	topContainer:SetLeft(pathControls)
	topContainer:SetRight(searchControls)

	local topSearch = vgui.Create("EXDTextEntry", searchControls)

	
	local topPath = vgui.Create("EXDTextEntry", pathControls)
	local btnBack = vgui.Create("EXDButton", pathControls)
	btnBack:SetText("")
	btnBack:SetIcon("arrow-left")
	btnBack:SetWide(24)
	btnBack:Dock(LEFT)
	btnBack:DockMargin(0, 0, 4, 0)

	local btnForward = vgui.Create("EXDButton", pathControls)
	btnForward:SetText("")
	btnForward:SetIcon("arrow-right")
	btnForward:SetWide(24)
	btnForward:Dock(LEFT)
	btnForward:DockMargin(0, 0, 8, 0)

	local btnUp = vgui.Create("EXDButton", pathControls)
	btnUp:SetText("")
	btnUp:SetIcon("arrow-up")
	btnUp:SetWide(24)
	btnUp:Dock(LEFT)
	btnUp:DockMargin(0, 0, 4, 0)

	local btnRefresh = vgui.Create("EXDButton", pathControls)
	btnRefresh:SetText("")
	btnRefresh:SetIcon("refresh")
	btnRefresh:SetWide(24)
	btnRefresh:Dock(RIGHT)
	btnRefresh:DockMargin(4, 0, 0, 0)

	c:SetHeight(textHeight + (margin * 2))
	c:Dock(TOP)
	c:DockMargin(-4, -5, -4, 0)
	c:SetPaintBackground(false)
	-- function c:Paint(w, h)
	-- 	surface.SetDrawColor(0, 0, 0, 60)
	-- 	surface.DrawRect(0, 0, w, h)
	-- end
	-- topSearch:SetWide(160)
	-- topSearch:AlignRight(margin)
	-- topSearch:AlignTop(margin)
	-- topSearch:SetHeight(textHeight)
	topSearch:Dock(FILL)
	topSearch:SetPlaceholderText("Search")

	function c:PerformLayout(w, h)
		-- topSearch:AlignRight(margin)
		-- topPath:SetWide(w - topSearch:GetWide() - (margin * 3))
		-- topPath:MoveLeftOf(topSearch, margin)
	end
	topPath:Dock(FILL)
	self.m_pTopPath = topPath
	-- topPath:AlignTop(margin)
	-- topPath:SetWide(300)
	-- topPath:SetHeight(textHeight)
	-- topPath:AlignLeft(margin)

	local ab = vgui.Create("EXDActionBar", self)
	ab:Dock(TOP)
	ab:DockMargin(-4, 0, -4, 0)
	ab.Placement = "Span"

	ab:AddButton("Rename File", "rename-box", function() 
		print("RENAME")
		this.m_Files:GetSelected()[1].Columns[1]:StartEdit()
	end, "Rename")

	-- local t = vgui.Create("classname", parent=nil, name=nil)
	local b = vgui.Create("DPanel", self)
	b:SetHeight(68)
	b:DockMargin(-4, 0, -4, 0)
	b:SetContentAlignment(3)
	b:Dock(BOTTOM)
	b:InvalidateParent(true)
	b:SetPaintBackground(false)
	-- function b:Paint(w, h)
	-- 	surface.SetDrawColor(0, 0, 0, 60)
	-- 	surface.DrawRect(0, 0, w, h)
	-- end
	local btnCancel = vgui.Create("EXDButton", b)
	btnCancel:SetWide(btnWidth)
	btnCancel:SetText("Cancel")
	btnCancel:AlignBottom(margin - 4)
	btnCancel:AlignRight(margin)
	function btnCancel:DoClick()
		this:Close()
	end
	local btnOkay = vgui.Create("EXDButton", b)
	btnOkay:SetWide(btnWidth)
	btnOkay:SetText("OK")
	btnOkay:AlignBottom(margin - 4)
	btnOkay:MoveLeftOf(btnCancel, margin)

	function btnOkay:DoClick()
		this:DoSelect()
	end

	local fType = vgui.Create("DComboBox", b)
	fType:SetWide((btnWidth * 2) + margin)
	fType:AlignRight(margin)
	fType:AlignTop(margin)

	local fileName = vgui.Create("EXDTextEntry", b)
	fileName:SetWide(230)
	fileName:SetHeight(textHeight)
	fileName:AlignTop(margin)
	fileName:MoveLeftOf(fType, margin)
	fileName:SetDisabled(true)
	this.m_pFileName = fileName

	local valueLabel = vgui.Create("DLabel", b)
	valueLabel:SetContentAlignment(6)
	valueLabel:SetText("Component:")
	valueLabel:SizeToContentsX()
	valueLabel:AlignTop(margin)
	valueLabel:MoveLeftOf(fileName, margin)
	function b:PerformLayout(w, h)
		fileName:MoveLeftOf(fType, margin)
		fileName:SetWide(w - 312)
		valueLabel:MoveLeftOf(fileName, margin)
		btnCancel:AlignRight(margin)
		btnOkay:MoveLeftOf(btnCancel, margin)
		fType:AlignRight(margin)
	end
	
	local sideBar = vgui.Create("DPanel", this)
	local files = vgui.Create("EXDListView", self)
	files.ColumnAlignment = 4
	local main = vgui.Create("DHorizontalDivider", self)
	main:Dock(FILL)
	main:SetLeft(sideBar)
	main:SetRight(files)
	main:SetDividerWidth(margin/2)
	main:DockMargin(margin/2, margin, margin/2, 0)
	main:SetLeftWidth(sidebarWidth)
	self.m_Main = main

	files:SetDataHeight(22)
	files:AddColumn("ID")
	files:AddColumn("Name")
	files:SetMultiSelect(false)

	function files:OnRowSelected(index, row)
		this:SelectFile(row.m_sDisplayPath)
	end

	function files:DoDoubleClick(index, row)
		this:DoSelect()
	end

	self.m_Files = files
	self:PopulateComponents()


	function self:Paint(w, h)
		if ( self.m_bBackgroundBlur ) then
			Derma_DrawBackgroundBlur( self, self.m_fCreateTime )
		end
	
		derma.SkinHook( "Paint", "Frame", self, w, h )
		surface.SetDrawColor(0, 0, 0, 60)
		surface.DrawRect(c:GetBounds())
		-- surface.DrawRect(b:GetBounds())
		return true
	end

end

function PANEL:SetSource(scheme, hierarchyTable)
	self.m_Data = hierarchyTable
	self.m_sScheme = scheme
end

function PANEL:NavigateTo(path)
	self.m_pTopPath:SetValue(self.m_sScheme .. ":" .. path)
end

-- TODO: dev function only
function PANEL:PopulateComponents()
	for id, func in pairs(photon_ex.Components) do
		local l = self.m_Files:AddLine(
			{ photon_ex.GetComponentDisplayID(func().ClassName), "file" }, 
			func().Label)
		l.ComponentID = id
		l.m_sDisplayPath = photon_ex.GetComponentDisplayID(func().ClassName)
		if DEV_MODE then
			if id == "EXCSEnt.excom_whelen_liberty" then
				timer.Simple(0.1, function()
					s:SelectItem(l)
				end)
			end
		end
		l.GetComponent = func
	end
end

function PANEL:OnRemove()
	self:SetCookie("Width", self:GetWide())
	self:SetCookie("Height", self:GetTall())
	self:SetCookie("SidebarWidth", self.m_Main:GetLeftWidth())
end

function PANEL:LoadCookies()
	width = self:GetCookieNumber("Width", width)
	height = self:GetCookieNumber("Height", height)
	sidebarWidth = self:GetCookieNumber("SidebarWidth", sidebarWidth)
end

derma.DefineControl( class, description, PANEL, base )