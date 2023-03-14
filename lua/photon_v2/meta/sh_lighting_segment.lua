if (exmeta.ReloadFile("photon_v2/meta/sh_lighting_segment.lua")) then return end

NAME = "PhotonLightingSegment"

---@class PhotonLightingSegment
---@field ActivePattern string Name of the current active pattern.
---@field IsActive boolean Whether the segment is active.
---@field CurrentPriorityScore integer
---@field LastFrameTime integer
---@field InputPriorities table<string, integer>
---@field Sequences table<string, PhotonSequence>
-- [string] = Pattern Name
---@field Patterns table<string, PhotonSequenceCollection> Key = Input Channel-Mode, Value = Associated sequence
---@field Frames table<integer, table> 
-- Lights table is currently just a pointer to Component.Lights.
-- This was done in S because the segment is unaware of its parent component,
-- which I believe was just an arbitrary design choice
---@field Lights table Mirrors Component.Lights (?)
local Segment = META

Segment.Patterns = {}
Segment.InputPriorities = {}
Segment.Count = 0
Segment.FrameDuration = 0.64
Segment.LastFrameTime = 0


---@return PhotonLightingSegment
function Segment.New()
	---@type PhotonLightingSegment
	local segment = {
		Lights = {},
		Sequences = {},
		Frames = {},
	}
	debug.setmetatable(segment, { __index = PhotonLightingSegment })
	return segment
end


function Segment:Initialize()
	---@type PhotonLightingSegment
	local segment = {
		LastFrameTime = 0,
		IsActive = false,
		CurrentPriorityScore = 0,
		InputPriorities = {},
		Patterns = {},
	}
	return setmetatable( segment, { __index = self } )
end

---@param name string Unique sequence name.
---@param sequence table<integer> Frame sequence.
function Segment:AddSequence( name, sequence )
	self.Sequences[name] = sequence
end


---@param index number Frame index
---@param lightStates table Table of light states (e.g. { { 1, "RED" }, { 2, "BLUE" } })
function Segment:AddFrame( index, lightStates )
	local result = {}
	local lightId, stateId
	for i=1, #lightStates do
		lightId = lightStates[i][1]
		stateId = lightStates[i][2]
		if string.StartsWith( lightId, "@" ) then

		else
			result[lightId] = stateId
		end
	end
	self.Frames[index] = result
	return result
end


---@param count number
function Segment:IncrementFrame( count )
	if not (self.IsActive) then return end
	if not (self.ActivePattern) then return end

	local sequences = self.Patterns[self.ActivePattern]
	local sequence

	for i = 1, #sequences do
		---@type PhotonSequence
		sequence = sequences[i]
		if (sequence.IsRepeating) then
			-- Ensures all sequences remain synchronized.
			sequence.CurrentFrame = ( count % #sequence )
		else
			sequence:IncrementFrame()
		end
		
	end
end


--- Updates all lights to match the current sequence frame.
function Segment:Render()
	if (not self.IsActive) then return end

	local map = self.Patterns
	local sequence

	for i = 1, #map[self.ActivePattern] do
		---@type PhotonSequence
		sequence = map[i]
		local lights = self.Lights
		-- map[i] is a PhotonSequence class
		for lightId, state in pairs( sequence[sequence.CurrentFrame] ) do
			lights[lightId]:SetState( state, self.CurrentPriorityScore )
		end
	end
end


function Segment:AcceptsPatternMode( inputTrigger )
	return not ( self.Patterns[inputTrigger] )
end


function Segment:CalculatePriorityInput( inputState )
	local topScore = -1000
	local result
	for channel, state in pairs( inputState ) do
		if ( self.InputPriorities[channel] ) then
			-- TODO: find alternative to string concatination
			if ( ( self.InputPriorities[channel] > topScore ) and self:AcceptsPatternMode( channel .. "." .. inputState[channel] ) ) then
				topScore = self.InputPriorities[channel]
				result = channel
			end
		end
	end
	return result
end


function Segment:ApplyInputUpdate( inputState )
	local newChannel = self:CalculatePriorityInput( inputState )
	local newMode = newChannel .. "." .. inputState[newChannel]
	self.CurrentPriorityScore = self.InputPriorities[newChannel]
	-- Do nothing if priority state hasn't changed
	if (self.ActivePattern == ( newMode )) then
		return
	end
	self:DeactivateSequences()
	-- Turn off all segment lights when the active pattern changes.
	self:ResetSegment()
	self.ActivePattern = newMode
	self.IsActive = true
	-- Turn lights back on
	self:ActivateSequences()
end


function Segment:ResetSegment()
	for i = 0, #self.Frames[0] do
		self.Frames[i][1]:SetState( self.Frames[i][2] )
	end
end


function Segment:ActivateSequences()
	---@type PhotonSequence[]
	local sequences = self.Patterns[self.ActivePattern]
	for i = 1, #sequences do
		sequences[i]:Activate()
	end
end


function Segment:DeactivateSequences()
	---@type PhotonSequence[]
	local sequences = self.Patterns[self.ActivePattern]
	for i = 1, #sequences do
		sequences[i]:Deactivate()
	end
end


---@param sequenceName string Unique name of sequence.
---@return PhotonSequence
function Segment:CreateSequence( sequenceName )
	self.Sequences[sequenceName] = PhotonSequence.New( self )

	return self.Sequences[sequenceName]
end


---@param channel string Channel Name
---@param ... string Channel Modes
---@return PhotonLightingSegment
function Segment:OnInput( channel, ... )
	local modes = table.pack(...)
	local pattern = PhotonSequenceCollection.New( self )

	if self.InputPriorities[channel] then
		pattern.Priority = self.InputPriorities[channel]
	else
		pattern.Priority = -1
		Photon2.Debug.Print("No channel input priority defined for '" .. tostring(channel) .. "'")
	end

	for i = 1, #modes do
		self.Patterns[channel .. "." .. mode] = pattern
	end

	return self
end
