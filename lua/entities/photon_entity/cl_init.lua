include("shared.lua")

---@class photon_entity
local ENT = ENT

function ENT:Initialize()
	-- self:Photon_OverrideMetaTable()
	self.InputPriorities = {}
	for channel, priority in pairs( self.DefaultInputPriorities ) do
		-- self.InputPriorities
	end
	self:SetupChannels()

end

function ENT:SetupChannels( channels )
	self.Channels = {}
	-- channels = channels or Photon2.InputChannelSchema
	-- for category, channel in pairs( channels ) do
	-- 	self.Channels[]
	-- end
end

function ENT:SetChannelState( channel, state )
	self.Channels[channel] = state
end