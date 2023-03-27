if (exmeta.ReloadFile("photon-v2/meta/sh_light.lua")) then return end

NAME = "PhotonLight"

---@class PhotonLight
---@field IsActivated boolean
---@field States table
local Light = META

---@return PhotonLight
function Light:Initialize( component, id )
	local light = {}
	return setmetatable( light, { __index = self } )
end


function Light:OnStateChange() end


function Light:SetState( state, priority )
	local x = Color(255, 255, 255)

end


-- Marks the light as "activated" to enable rendering optimizations. 
-- Triggered whenever there is a sequence that utilizes this light.
function Light:Activate() end


-- Marks the light as "deactivated" to remove it from optimization tables
-- and rendering queues. Triggered when it's determined the light won't be used
-- by any active sequences.
function Light:Deactivate() end


function Light:PrintTable()
	PrintTable(self)
end