include("shared.lua")

---@class cl_PhotonController : PhotonController
---@field IsSuspended boolean
---@field FrameDuration number 0.0334
---@field Frame integer
---@field FrameCountEnabled boolean
---@field LastFrameTime number
ENT = ENT

local print = Photon2.Debug.Print

ENT.FrameDuration = 1/24
ENT.FrameCountEnabled = true
ENT.NextFrameTime = 0

PHOTON2_FREEZE = false

---@diagnostic disable-next-line: duplicate-set-field
function ENT:Initialize()
	self.Frame = 1
	self.NextFrameTime = RealTime() + self.FrameDuration
	self:InitializeShared()
	self:DoInitializationStandby()
	-- addTestEquipment(self)
end

-- Further delays executing initialization code until it's believed
-- other Photon functions are ready. This is primarily a concern
-- when loading in next to an already active Photon vehicle, especially 
-- if the vehicle relies on Photon's dynamic materials.
function ENT:DoInitializationStandby()
	if ( not Photon2.Materials.Ready ) then
		timer.Simple( 1, function() 
			if ( not IsValid( self ) ) then return end
			pcall( self.DoInitializationStandby, self )
		end)
		return
	end

	local queue = Photon2.cl_Network.ControllerQueue[self]
	if ( queue ) then
		
		if ( queue.Profile ) then
			self:SetupProfile( self:GetProfileName() )
		end

		if ( queue.SelectionString ) then
			self:ProcessSelectionsString( self:GetSelectionsString() )
		end

		for channel, mode in pairs( queue.Channels ) do
			self:OnChannelModeChanged( channel, self:GetChannelMode( channel ), "" )
		end

		Photon2.cl_Network.ControllerQueue[self] = nil
	end

	self:RefreshParentSubMaterials()

	timer.Simple( 2, function()
		Photon2.cl_Network.ControllerQueue[self] = nil
	end)
end

-- Called when player is believed to have left the vehicle's PVS.
function ENT:OnSuspended()
	self.IsSuspended = true
	self:RemoveAllComponents()
	self:RemoveAllProps()
end


-- Called when player is believed to have re-entered vehicle's PVS.
function ENT:OnResumed()
	self.IsSuspended = false
	self.Frame = 1
	self:SetupProfile(self:GetProfileName())
end

local RealTime = RealTime
local IsValid = IsValid

function ENT:DoNextFrame()
	self.Frame = self.Frame + 1
	self.NextFrameTime = RealTime() + self.FrameDuration
	local componentArray = self.ComponentArray
	for i=1,#componentArray do
		if ( componentArray[i].FrameTick) then componentArray[i]:FrameTick() end -- ***rebuild component array on equipment change *** 
	end
	for i=1, #self.VirtualComponentArray do
		self.VirtualComponentArray[i]:FrameTick()
	end
	for i=1, #self.UIComponentArray do
		self.UIComponentArray[i]:FrameTick()
	end
end

---@diagnostic disable-next-line: duplicate-set-field
function ENT:Think()
	if (not self.IsSuspended) then
		if (not IsValid(self:GetParent())) then
			self:OnSuspended()
		end
	else
		if (IsValid(self:GetParent())) then
			self:OnResumed()
		end
	end

	if (not self.IsSuspended) then
		-- print("invalidating bone cache")
		-- self:GetParent():InvalidateBoneCache()
		if (self.FrameCountEnabled and (self.NextFrameTime) <= RealTime() and ( not PHOTON2_FREEZE )) then
			self:DoNextFrame()
		end
	end

	if ( self.DoHardReload ) then
		self:HardReload()
	end

	-- for id, component in pairs(self.Components) do
	-- 	if (not IsValid(component:GetParent())) then
	-- 		self:RemoveAllComponents()
	-- 		break
	-- 	end
	-- end
	-- if (not IsValid(self:GetParent())) then
	-- 	print("parent NOT valid")
	-- end
	-- print("controller thinking")
end

function ENT:RenderOverride()
	if ( not self.DrawController ) then return end
	self:DrawModel()
end