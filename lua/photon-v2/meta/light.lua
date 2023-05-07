if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight"

local printf = Photon2.Debug.PrintF

---@class PhotonLight
---@field Parent Entity
---@field Class string
---@field Deactivate boolean When true, marks the light to be activated on the next frame.
---@field IsActivated boolean
---@field States table
---@field Id integer
---@field CurrentStateId string
local Light = exmeta.New()

---@param id integer
---@param parent Entity
---@return PhotonLight
function Light:Initialize( id, parent )
	---@type PhotonLight2D
	local light = {
		Id = id,
		Class = self.Class,
		Parent = parent
	}
	return setmetatable( light, { __index = self } )
end


function Light:OnStateChange() end


function Light:SetState( state, intensity )
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

-- Finds and returns the corresponding PhotonLight class
-- or throws a traceable error.
---@param className string
---@return PhotonLight
function Light.FindClass( className )
	local lightClass = _G["PhotonLight" .. tostring( className )]

	if ( not lightClass ) then
		error(string.format( "Light class [%s] could not be found.", className ) )
	end

	return lightClass
end