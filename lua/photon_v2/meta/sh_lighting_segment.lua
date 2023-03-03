if (exmeta.ReloadFile("photon_v2/meta/sh_lighting_segment.lua")) then return end

NAME = "PhotonLightingSegment"

---@class PhotonLightingSegment
local Segment = META

Segment.FrameDuration = 0.64
-- -@field Frames table
Segment.Frames = {}
Segment.Lights = {}
Segment.Sequences = {}
Segment.PatternMap = {}
Segment.InputPriorities = {}
Segment.LastFrameTime = 0
Segment.IsActive = false
Segment.CurrentPriorityScore = 0
Segment.ActivePattern = nil
Segment.Count = 0


function Segment.New()
	local segment = {
		Lights = {},
		Frames = {},
		Sequences = {},
		PatternMap = {},
		InputPriorities = {},
		LastFrameTime = 0,
		IsActive = true,
		CurrentPriorityScore = 0,
	}
	debug.setmetatable(segment, PhotonLightingSegment)
	return segment
end

---@param frame number Frame index
---@param lightStates table Table of light states (e.g. { { 1, "RED" }, { 2, "BLUE" } })
function Segment:AddFrame( frame, lightStates )
	local result = {}
	for light, state in pairs(lightStates) do
		if string.StartsWith(light, "@") then

		else
			result[light] = state
		end
	end
	self.Frames[frame] = result
	self.Count = table.Count(self.Frames)
	return result
end

---@param count number
function Segment:IncrementFrame( count )
	if not (self.IsActive) then return end
	if not (self.ActivePattern) then return end
	for _, sequence in pairs( self.PatternMap[self.ActivePattern] ) do
		sequence:IncrementFrame( count )
		-- if (sequence.IsRepeating) then
		-- 	sequence.CurrentIndex = ( count % sequence.Count )
		-- else
		-- 	sequence.CurrentIndex = sequence.CurrentIndex + count
		-- end
	end
end


function Segment:Render()
	if (not self.IsActive) then return end

	local map = self.PatternMap

	for i = 1, #map[self.ActivePattern] do
		-- map[i] is a PhotonSequence class
		for light, state in pairs( map[i]:GetCurrentFrame() ) do
			light:SetState( state, self.CurrentPriorityScore )
		end
	end
end


function Segment:AcceptsPatternMode( inputTrigger )
	return not ( self.PatternMap[inputTrigger] )
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
	self.CurrentPriorityScore = self.InputPriorities[newChannel]
end

function Segment:ResetSegment()
	for i = 0, #self.Frames[0] do
		self.Frames[i][1]:SetState( self.Frames[i][2] )
	end
end

function Segment:ActivateSequences()

end


function Segment:DeactivateSequences()

end


function Segment:OnInput( inputState, modes )

end


function Segment:CreateSequence( sequenceName )

	-- return PhotonComponentSegmentSequence
end