if (exmeta.ReloadFile("photon-v2/meta/sh_lighting_segment.lua")) then return end

NAME = "PhotonLightingSegment"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightingSegment
---@field ActivePattern string Name of the current active pattern.
---@field IsActive boolean Whether the segment is active.
---@field CurrentPriorityScore integer
---@field LastFrameTime integer
---@field CurrentModes table<string, string> Key = Channel, Value = mode
---@field InputPriorities table<string, integer>
---@field Sequences table<string, PhotonSequence>
-- [string] = Pattern Name
---@field Patterns table<string, string> Key = Input Channel, Value = Associated sequence
---@field Frames table<integer, table> 
---@field Lights table Points to Component.Lights
local Segment = META

Segment.Patterns = {}
Segment.InputPriorities = {}
Segment.Count = 0
Segment.FrameDuration = 0.64
Segment.LastFrameTime = 0
Segment.InputPriorities = PhotonBaseEntity.DefaultInputPriorities

-- On compile
---@param segmentData any
---@return PhotonLightingSegment
function Segment.New( segmentData )

	---@type PhotonLightingSegment
	local segment = {
		Lights = {},
		Sequences = {},
		Frames = {},
		Patterns = {}
	}

	setmetatable(segment, { __index = PhotonLightingSegment })

	segment:AddFrame( 0, segmentData.Frames[0] )
	-- Add frames
	for i, frame in ipairs( segmentData.Frames ) do
		segment:AddFrame( i, frame )
	end

	-- Add sequences
	for sequenceName, frameSequence in pairs( segmentData.Sequences ) do
		segment:AddNewSequence( sequenceName, frameSequence )
	end

	return segment
end

-- On instance creation
---@param componentInstance PhotonLightingComponent
function Segment:Initialize( componentInstance )
	---@type PhotonLightingSegment
	local segment = {
		LastFrameTime = 0,
		IsActive = false,
		CurrentPriorityScore = 0,
		CurrentModes = componentInstance.CurrentModes,
		Lights = componentInstance.Lights,
		Patterns = {},
	}
	return setmetatable( segment, { __index = self } )
end


---@param name string Unique sequence name.
---@param frameSequence integer[]
function Segment:AddNewSequence( name, frameSequence )
	self.Sequences[name] = PhotonSequence.New( name, frameSequence )
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


---@param channelMode string 
---@param sequence string
---@param conditions? table
function Segment:AddPattern( channelMode, sequence, conditions )
	printf("Adding pattern. Mode: %s. Sequence: %s.", channelMode, sequence)
	if (istable(conditions)) then
		-- TODO: conditional
	end
	-- if (isstring(sequence)) then
	-- 	sequence = self.Sequences[sequence]
	-- end
	self.Patterns[channelMode] = sequence --[[@as string]]
end

function Segment:AcceptsChannelMode( channelMode )
	-- return true
	return not ( self.Patterns[channelMode] )
end


function Segment:CalculatePriorityInput( inputState )
	print("Calculating priority input...")
	PrintTable( inputState )
	local topScore = -1000
	local result
	for channel, mode in pairs( inputState ) do
		if (mode == "OFF") then continue end
		if ( self.InputPriorities[channel] ) then
			printf( "\tChecking channel [%s]", channel )
			-- TODO: find alternative to string concatination
			if ( ( self.InputPriorities[channel] > topScore ) and self:AcceptsChannelMode( channel .. "." .. inputState[channel] ) ) then
				topScore = self.InputPriorities[channel]
				result = channel
			end
		end
	end
	return result
end


function Segment:ApplyModeUpdate( channel, mode )
	printf("Segment received a mode update [%s] => %s", channel, mode)
	local inputState = self.CurrentModes
	local newChannel = self:CalculatePriorityInput( inputState )
	printf( "New channel calculated to be: %s", newChannel )
	local newMode = newChannel .. "." .. inputState[newChannel]
	printf( "New mode calculated to be: %s", newMode )
	self.CurrentPriorityScore = self.InputPriorities[newChannel]
	printf( "CurrentPriorityScore: %s", self.CurrentPriorityScore )
	-- Do nothing if priority state hasn't changed
	if (self.ActivePattern == ( newMode )) then
		return
	end
	-- self:DeactivateSequences()
	-- Turn off all segment lights when the active pattern changes.
	self:DectivateCurrentSequence()
	self:ResetSegment()
	self.ActivePattern = newMode
	self.IsActive = true
	self:ActivateCurrentSequence()
	-- Turn lights back on
	-- self:ActivateSequences()
end


function Segment:ResetSegment()
	-- print("Resetting segment...")
	local lights = self.Lights
	for lightId, state in pairs(self.Frames[0]) do
		lights[lightId]:SetState( state )
	end
	-- print("Frame[0]")
	-- PrintTable(self.Frames[0])
	-- for i = 1, #default do
	-- 	printf("default[i] = %s", default[i])
	-- 	-- TODO: switch to direct reference instead of long look-up
	-- 	self.Lights[default[i][1]]:SetState( default[i][2] )
	-- end
end

function Segment:ActivateCurrentSequence()
	local sequence = self:GetCurrentSequence()
	if (sequence) then
		sequence:Activate()
	end
end

function Segment:DectivateCurrentSequence()
	local sequence = self:GetCurrentSequence()
	if (sequence) then
		sequence:Deactivate()
	end
end

function Segment:GetCurrentSequence()
	return self.Sequences[self.ActivePattern]
end


-- function Segment:ActivateSequences()
-- 	---@type PhotonSequence[]
-- 	local sequences = self.Patterns[self.ActivePattern]
-- 	for i = 1, #sequences do
-- 		sequences[i]:Activate()
-- 	end
-- end


-- function Segment:DeactivateSequences()
-- 	---@type PhotonSequence[]
-- 	local sequences = self.Patterns[self.ActivePattern]
-- 	for i = 1, #sequences do
-- 		sequences[i]:Deactivate()
-- 	end
-- end

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
