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
---@field CurrentSequenceRank number
---@field AdditiveOverrideEnabled boolean When `true`, the light state can be overridden by other segments when otherwise set to OFF by its primary controlling segment.
---@field SegmentLocked boolean Internal. When `true`, the light will not accept state changes until reset with the next frame change.
---@field Inputs table
local Light = exmeta.New()
Light.AdditiveOverrideEnabled = true

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

local debugPrint = false

---@return boolean stateChangeAccepted
function Light:SetState( stateId, segmentName, priorityScore, rank )
	-- if ( stateId == self.CurrentStateId ) then return false end
	segmentName = segmentName or self.ControllingSegment
	if ( not self.States[stateId] ) then
		error("Invalid light state [" .. tostring(stateId) .. "]")
	end
	if debugPrint then printf( "Setting light state to [%s]. Segment [%s]. Priority [%s]. Rank [%s]. Controlling segment [%s].", stateId, segmentName, priorityScore, rank, self.ControllingSegment) end
	
	priorityScore = priorityScore or 0
	
	if ( self.ControllingSegment and self.AdditiveOverrideEnabled and ( not self.SegmentLocked )) then
		if ( stateId == "OFF" ) then
			if (( segmentName == self.ControllingSegment )) then
				priorityScore = 0
				if debugPrint then print("Controlling segment setting to OFF, priorityScore=0") end
				if (self.CurrentPriorityScore > priorityScore) then return false end
			else
				if debugPrint then print("Request to turn light OFF rejected.") end
				return false
			end
		else
			if (( segmentName == self.ControllingSegment )) then
				self.CurrentPriorityScore = priorityScore
				self.SegmentLocked = true
				if debugPrint then print("Light state set by controlling segment.") end
			elseif 
			( priorityScore > self.CurrentPriorityScore ) or
			(( priorityScore == self.CurrentPriorityScore ) and ( rank < self.CurrentSequenceRank )) then
				self.CurrentPriorityScore = priorityScore
				self.CurrentSequenceRank = rank
				if debugPrint then print("Light state set by other segment.") end
			else
				if debugPrint then print("Light state change rejected.") end
				return false
			end
		end
	end

	self.CurrentSequenceRank = rank
	self.CurrentPriorityScore = priorityScore
	local previousState = self.CurrentStateId
	self.CurrentStateId = stateId
	if (stateId ~= previousState) then self:OnStateChange( self.States[stateId] ) end
	if debugPrint then print("Light is changing state.") end
	return true
end

-- For later reference
-- function Light:FrameChange()
-- 	self.CurrentPriorityScore = 0
-- end


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