include("shared.lua")

---@class photon_entity
local ENT = ENT

function ENT:Initialize()
	-- self:Photon_OverrideMetaTable()
	self.InputPriorities = {}
	for channel, priority in pairs( self.DefaultInputPriorities ) do
		-- self.InputPriorities
	end

end
