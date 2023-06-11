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
---@field SortedInputs table
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
		Inputs = {},
		SortedInputs = {}
	}
	return setmetatable( light, { __index = self } )
end


---@param state PhotonLightState
function Light:OnStateChange( state ) end

local debugPrint = false

function Light:SortInputs()
	-- print("Sorting inputs. Current inputs: " .. tostring(#self.SortedInputs))

	table.SortByMember( self.SortedInputs, "Priority", false )
	-- print("====== self.SortedInputs ======")
	-- PrintTable( self.SortedInputs )

	-- local newSortedInputs = {}
	-- for k, v in ipairs(self.SortedInputs) do
	for k, v in ipairs(self.SortedInputs) do
		v.Order = k
		-- print("IPAIRS ITERATING: " .. tostring(k))
		-- newSortedInputs[#newSortedInputs+1] = v
		-- v.Order = #newSortedInputs
	end
	-- print("====== self.SortedInputs RESULT ======")
	-- PrintTable( self.SortedInputs )
	-- self.SortedInputs = newSortedInputs
	-- print("====== SORTED INPUTS AFTER IPAIRS ======")
	-- PrintTable( self.SortedInputs )
	-- print("\tNew inputs: " .. tostring(#self.SortedInputs))
	-- for i=1, #self.SortedInputs do
	-- 	if ( not self.SortedInputs[i] ) then
	-- 		print("====== SortedInput index NOT found ======")
	-- 		print("#self.SortedInputs == " .. #self.SortedInputs)
	-- 		print("i == " .. tostring(i))
	-- 		PrintTable(self.SortedInputs)
	-- 	end
	-- 	self.SortedInputs[i].Order = i
	-- end
end

function Light:AddInput( sequenceId, priority )
	local isNew = true

	if ( self.Inputs[sequenceId] ) then isNew = false end

	self.Inputs[sequenceId] = self.Inputs[sequenceId] or {}

	self.Inputs[sequenceId].Sequence = sequenceId
	self.Inputs[sequenceId].Priority = priority
	self.Inputs[sequenceId].State = "PASS"

	if ( isNew ) then
		self.SortedInputs[#self.SortedInputs+1] = self.Inputs[sequenceId]
	end

	self:SortInputs()
end

function Light:SetInput( sequenceId, stateId )
	self.Inputs[sequenceId].State = stateId
end

function Light:RemoveInput( sequenceId )
	-- print("Removing sequence: " .. tostring(sequenceId))
	table.remove( self.SortedInputs, self.Inputs[sequenceId].Order )
	-- self.SortedInputs[self.Inputs[sequenceId].Order] = nil
	self.Inputs[sequenceId] = nil
	self:SortInputs()
end

function Light:UpdateState()
	local state = "PASS"
	-- print("Current inputs: " .. tostring(#self.SortedInputs))
	for i=1, #self.SortedInputs do
		if (self.SortedInputs[i].State ~= "PASS") then
			state = self.SortedInputs[i].State
			break
		end
	end
	if state == "PASS" then state = "OFF" end
	if (state ~= self.CurrentStateId) then
		self.CurrentStateId = state
		self:OnStateChange( self.States[state] )
	end

	-- Set light to auto-deactivate when it has no more inputs
	if (#self.SortedInputs < 1) then
		self.Deactivate = true
	else
		self:Activate()
	end
end

---@return boolean stateChangeAccepted
function Light:SetState( stateId, segmentName, priorityScore, rank )
	error()
	if true then return end
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