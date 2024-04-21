include("shared.lua")

---@class cl_PhotonController : PhotonController
---@field IsSuspended boolean
---@field FrameDuration number 0.0334
---@field Frame integer
---@field FrameCountEnabled boolean
---@field LastFrameTime number
---@field NextPulse number
ENT = ENT

local info, warn = Photon2.Debug.Declare( "Library" )


local printOnly = print
local print = info
local RealTime = RealTime

ENT.FrameDuration = 1/24
ENT.FrameCountEnabled = true
ENT.NextFrameTime = 0
ENT.AmbientCheckDuration = 1/2
ENT.PulseDuration = 1/100

PHOTON2_FREEZE = false

---@diagnostic disable-next-line: duplicate-set-field
function ENT:Initialize()
	self.Frame = 1
	self.LastAmbientCheck = 0
	self.NextPulse = 0
	self.NextFrameTime = RealTime() + self.FrameDuration
	self:InitializeShared()
	self:DoInitializationStandby()
	self.CurrentPulseComponents = {}
	-- addTestEquipment(self)
end

-- Further delays executing initialization code until it's believed
-- other Photon functions are ready. This is primarily a concern
-- when loading in next to an already active Photon vehicle, especially 
-- if the vehicle relies on Photon's dynamic materials.
function ENT:DoInitializationStandby()
	if ( not Photon2.Materials.Ready or ( not self:GetProfileName() ) ) then
		timer.Simple( 1, function() 
			if ( not IsValid( self ) ) then return end
			pcall( self.DoInitializationStandby, self )
		end)
		return
	end

	if ( self:GetProfileName() ) then
		self:SetupProfile( self:GetProfileName() )
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
end

function ENT:DoPulse()
	if ( self.RebuildPulseComponents ) then self:UpdatePulseComponentArray() end
	self.NextPulse = RealTime() + self.PulseDuration
	for i=1, #self.CurrentPulseComponents do
		if ( not ( self.CurrentPulseComponents[i].IsVirtual ) and ( not IsValid( self.CurrentPulseComponents[i] ) ) ) then
			self.RebuildPulseComponents = true
			return
		end
		self.CurrentPulseComponents[i]:Pulse()
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
		if ( self.PropPendingParents ) then
			self:UpdatePropPendingParents()
			for ent, parentName in pairs( self.PropPendingParents or {} ) do
				warn( "Failed to parent entity to: " .. tostring( parentName ) )
				ent:Remove()
			end
			self.PropPendingParents = nil
		end

		if ( self.ComponentPendingParents ) then
			self:UpdateComponentPendingParents()
			for ent, parentName in pairs( self.ComponentPendingParents or {} ) do
				warn( "Failed to parent entity to: " .. tostring( parentName ) )
				ent:Remove()
			end
			self.ComponentPendingParents = nil
		end
		-- print("invalidating bone cache")
		-- self:GetParent():InvalidateBoneCache()
		if ( self.LastAmbientCheck + self.AmbientCheckDuration <= RealTime() ) then
			self:RefreshAmbient()
		end
		if ( self.NextPulse <= RealTime() and ( not PHOTON2_FREEZE ) ) then
			self:DoPulse()
		end
		if (self.FrameCountEnabled and (self.NextFrameTime) <= RealTime() and ( not PHOTON2_FREEZE )) then
			self:DoNextFrame()
		end
	end

	if ( self.DoHardReload ) then
		self:HardReload()
	end

	-- local lighting = render.ComputeLighting( self:GetPos(), self:GetUp() )
	-- local ambient = render.GetAmbientLightColor()
	-- ambient = ( ambient.x + ambient.y + ambient.z ) / 3
	-- lighting =  ( lighting.x + lighting.y + lighting.z ) / 3
	-- printOnly( lighting/ambient )
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

local darkMapThreshold = 0.2
local darkMapMultiplier = 4
local normalThreshold = 1.5

function ENT:RefreshAmbient()
	local mapAmbient = render.GetAmbientLightColor()
	mapAmbient = ( mapAmbient.x + mapAmbient.y + mapAmbient.z ) / 3

	local threshold = normalThreshold

	-- if the map itself is dark, boost the threshold
	if ( mapAmbient < darkMapThreshold ) then threshold = threshold * darkMapMultiplier end

	local data = self.AmbientLightingData or {
		CurrentIndex = 1,
	}

	local current = render.ComputeLighting( self:GetPos(), self:GetUp() )
	current = ( current.x + current.y + current.z ) / 3

	-- print( "Current: " .. tostring( current ) )
	if ( current < threshold ) then
		current = 0
	else
		current = 1
	end
	
	data[1] = data[1] or current
	data[2] = data[2] or current
	data[3] = data[3] or current

	data[data.CurrentIndex] = current

	data.Average = ( data[1] + data[2] + data[3] ) / 3

	data.CurrentIndex = data.CurrentIndex + 1
	if ( data.CurrentIndex > 3 ) then data.CurrentIndex = 1 end
	
	-- print( "Map: " .. tostring( mapAmbient ) )

	self.LastAmbientCheck = RealTime()
	self.AmbientLightingData = data

	if ( self:GetChannelMode( "Vehicle.Ambient" ) == "OFF" ) then
		if ( data.Average ) == 0 then
			self:SetChannelMode( "Vehicle.Ambient", "DARK" )
		end
	else
		if ( data.Average ) > 0.99 then
			self:SetChannelMode( "Vehicle.Ambient", "OFF" )
		end
	end
	-- if ( data.Average < 1.5 ) then
	-- 	self:SetChannelMode( "Vehicle.Ambient", "DARK" )
	-- 	print("DARK")
	-- else
	-- 	self:SetChannelMode( "Vehicle.Ambient", "OFF" )
	-- 	print("NORMAL")
	-- end
	-- print("Average: " .. tostring( data.Average ) )
end

function ENT:RenderOverride()
	if ( not self.DrawController ) then return end
	self:DrawModel()
end