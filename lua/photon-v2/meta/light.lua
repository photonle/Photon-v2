if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight"

local printf = Photon2.Debug.PrintF

---@class PhotonLight
---@field Parent Entity
---@field Class string
---@field Deactivate boolean When `true`, marks the light to be activated on the next frame.
---@field IsActivated boolean
---@field States table
---@field Id integer
---@field CurrentStateId string
---@field ControllingSegment string
---@field CurrentPriorityScore number
---@field AdditiveOverrideEnabled boolean When `true`, the light state can be overridden by other segments when otherwise set to OFF by its primary controlling segment.
---@field Inputs table
local Light = exmeta.New()

---@param id integer
---@param parent Entity
---@return PhotonLight
function Light:Initialize( id, parent )
	---@type PhotonLight2D
	local light = {
		Id = id,
		Class = self.Class,
		Parent = parent,
		Inputs = {}
	}
	return setmetatable( light, { __index = self } )
end


---@param state PhotonLightState
function Light:OnStateChange( state ) end

---@return boolean stateChangeAccepted
function Light:SetState( stateId, segmentName, priorityScore )
	if ( stateId == self.CurrentStateId ) then return false end
	if ( not self.States[stateId] ) then
		error("Invalid light state [" .. tostring(stateId) .. "]")
	end
	-- if ( self.ControllingSegment ) then
	-- 	if ( segmentName == self.ControllingSegment ) then 
	-- 		self.CurrentPriorityScore = priorityScore
	-- 	else
	-- 		if ( (stateId ~= "OFF") and (self.AdditiveOverrideEnabled) and ( priorityScore > self.CurrentPriorityScore ) ) then
	-- 			self.CurrentPriorityScore = priorityScore
	-- 		else
	-- 			return false
	-- 		end
	-- 	end
	-- end
	self.CurrentStateId = stateId
	self:OnStateChange( self.States[stateId] )
	return true
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