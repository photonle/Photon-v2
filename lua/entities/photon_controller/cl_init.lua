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


function ENT:Initialize()
	self.Frame = 1
	self.NextFrameTime = RealTime() + self.FrameDuration
	self:InitializeShared()

	-- addTestEquipment(self)
end


-- Called when player is believed to have left the vehicle's PVS.
function ENT:OnSuspended()
	self.IsSuspended = true
	self:RemoveAllComponents()
end


-- Called when player is believed to have re-entered vehicle's PVS.
function ENT:OnResumed()
	self.IsSuspended = false
	self.Frame = 1
	self:SetupProfile(self:GetProfileName())
end


-- function ENT:SetupComponent( id )
-- 	local data = self.Equipment[id]
-- 	if (not data) then
-- 		print(string.format("Unable to locate equipment ID [%s]", id))
-- 		return
-- 	end
-- 	print(string.format("Setting up component [%s]", id))
-- 	if (data.Component) then
-- 		---@type PhotonLightingComponent
-- 		local component = Photon2.Index.Components[data.Component]
-- 		local ent = component:CreateClientside( self ) --[[@as PhotonLightingComponent]]
-- 		ent:SetMoveType( MOVETYPE_NONE )
-- 		ent:SetParent( self:GetComponentParent() )
-- 		component:SetPropertiesFromEquipment( data )
-- 		if (IsValid(self.Components[id])) then
-- 			self.Components[id]:Remove()
-- 		end
-- 		self.Components[id] = ent
-- 	end	
-- end

local RealTime = RealTime
local IsValid = IsValid

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
		if (self.FrameCountEnabled and (self.NextFrameTime) <= RealTime()) then
			self.Frame = self.Frame + 1
			self.NextFrameTime = RealTime() + self.FrameDuration
			local componentArray = self.ComponentArray
			for i=1,#componentArray do
				if ( componentArray[i].FrameTick) then componentArray[i]:FrameTick() end -- ***rebuild component array on equipment change *** 
			end
			for i=1, #self.VirtualComponentArray do
				self.VirtualComponentArray[i]:FrameTick()
			end
		end
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

local function NetworkedVarChanged( ent, name, oldValue, newValue )
	-- Must be delayed by a tick to ensure entity is properly
	-- initialized first. Unpredictable results otherwise.
	local duration = 0.001
	if ( CurTime() > 10000 ) then duration = 0.01 end
	if ( CurTime() > 100000 ) then duration = 0.1 end
	timer.Simple(duration, function()
		if (IsValid(ent) and (ent.IsPhotonController)) then
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				ent:OnChannelModeChanged( name, newValue, oldValue )
			elseif (name == "Photon2:ProfileName") then
				ent:SetupProfile( newValue )
			elseif (name == "Photon2:Selections") then
				ent:ProcessSelectionsString( newValue )
			end
		end
	end)
	
end
hook.Add("EntityNetworkedVarChanged", "Photon2:PhotonController", NetworkedVarChanged)
