if (exmeta.ReloadFile("photon-v2/meta/sh_light.lua")) then return end

NAME = "PhotonLight"

local printf = Photon2.Debug.PrintF

---@class PhotonLight
---@field Parent Entity
---@field Deactivate boolean When true, marks the light to be activated on the next frame.
---@field IsActivated boolean
---@field States table
local Light = META

---@return PhotonLight
function Light:Initialize( parent )
	---@type PhotonLight2D
	local light = {
		Class = self.Class,
		Parent = parent
	}
	printf("SetState is [%s]", self.SetState)
	return setmetatable( light, { __index = self } )
end


function Light:OnStateChange() end


function Light:SetState( state, priority )
	local x = Color(255, 255, 255)
end


-- Marks the light as "activated" to enable rendering optimizations
-- and add to applicable rendering queues.
function Light:Activate() end


-- Forces light deactivation. Should only be called once
-- it's clear that no other segments are using the light.
function Light:DeactivateNow() end

function Light:PrintTable()
	PrintTable(self)
end