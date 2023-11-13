if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementingSegment"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonElementingSegment
---@field Name string
---@field ActivePattern string Name of the current active pattern.
---@field IsActive boolean Whether the segment is active.
---@field CurrentPriorityScore integer
---@field LastFrameTime integer
---@field CurrentModes table<string, string> Key = Channel, Value = mode
---@field InputPriorities table<string, integer>
---@field Sequences table<string, PhotonSequence>
---@field Component PhotonLightingComponent
-- [string] = Pattern Name
---@field Inputs table<string, string> Key = Input Channel, Value = Associated sequence
---@field InputActions table<string, { Sequence: string, Priority: number, Rank: number }>
---@field Frames table<integer, table> 
---@field InitializedFrames table<integer, table<PhotonElement, string>>
---@field Lights table Points to Component.Elements
local Segment = exmeta.New()

Segment.Inputs = {}
Segment.InputPriorities = {}
Segment.Count = 0
Segment.FrameDuration = 0.64
Segment.LastFrameTime = 0
-- Segment.InputPriorities = PhotonBaseEntity.DefaultInputPriorities

-- On compile
---@param segmentData any
---@param lightGroups table<string, integer[]>
---@return PhotonElementingSegment
function Segment.New( name, segmentData, lightGroups, componentInputPriorities )

	---@type PhotonElementingSegment
	local segment = {
		Name = name,
		Elements = {},
		Sequences = {},
		Frames = {},
		Inputs = {},
		InputActions = {},
		InputPriorities = setmetatable( segmentData.InputPriorities or {}, { __index = componentInputPriorities } )
	}

	setmetatable( segment, { __index = PhotonElementingSegment } )

	local function flattenFrame( frame )
		local result = {}
		for i=1, #frame do
			local key = frame[i][1]
			local value = frame[i][2]
			if isstring(key) then
				local group = lightGroups[key]
				if ( not group ) then
					error( string.format( "Undefined LightGroup [%s] in segment.", key ) )
				end
				for _i=1, #group do
					result[group[_i]] = value
				end
			else
				result[key] = value
			end
		end
		return result
	end

	local function rebuildFrame (flatFrame )
		local result = {}
		for k, v in pairs(flatFrame) do
			result[#result+1] = { k, v }
		end
		return result
	end

	local function processFrameString( frame )

		frame = string.Replace( frame, "\n", " " )
		frame = string.Replace( frame, "\t", " " )
		frame = string.Trim( frame )
		while string.find( frame, "  " ) do
			frame = string.Replace( frame, "  ", " " )
		end

		
		local result = {}
		
		if ( frame == "" or frame == " " ) then return result end
		
		local contextState, block
		local blocks = string.Split( frame, " " )
		for i=1, #blocks do

			block = blocks[i]
			if ( string.StartWith( blocks[i], "[") ) then
				block = string.sub( block, 2, string.len( block ) - 1 )
				block = string.Replace( block, " ", "" )
				contextState = block
				continue
			end
			
			if ( contextState == "" ) then contextState = nil end

			local lightData = string.Split(blocks[i], ":")
			
			local insert
			
			if (#lightData == 1) then
				insert = (tonumber(lightData[1]) or lightData[1])
				if ( ( insert) and contextState ~= nil ) then
					insert = { insert, contextState }
				end
			else
				insert = { (tonumber(lightData[1]) or lightData[1]), (tonumber(lightData[2]) or lightData[2]) }
			end

			if ( insert ) then
				result[#result+1] = insert
			else
				error("Frame string [" .. tostring(frame) .."] could not be parsed.")
			end
		end
		return result
	end

	local function buildZeroFrame( frames )
		local usedLights = {}
		local returnFrame = {}
		-- Get all used lights
		for frameIndex = 1, #frames do
			local frame = frames[frameIndex]
			for stateIndex = 1, #frame do
				if ( isstring(frame[stateIndex][1]) ) then
					if ( not lightGroups ) then
						error("Component failed to compile when attempting to build the zero frame. This may indicate an uncaught error in the segment's frame syntax.")
					end
					local group = lightGroups[frame[stateIndex][1]]
					if ( not group ) then 
						error( string.format( "Light group name is not valid %s", frame[stateIndex][1] ) )
					end
					for i=1, #group do
						usedLights[group[i]] = true
					end
				else
					usedLights[frame[stateIndex][1]] = true
				end
			end
		end
		-- Build 0 frame
		for light, _ in pairs( usedLights ) do
			returnFrame[#returnFrame+1] = { light, "OFF" }
		end
		return returnFrame
	end

	local processedFrames = {}

	for i=0, #segmentData.Frames do
		-- process 0 frame if it's been manually defined, otherwise ignore it
		if ( i == 0) and ( not segmentData.Frames[0] ) then 
			-- error("no segmentData.Frames[0]")
			continue 
		end
		
		local inputFrame = segmentData.Frames[i]
		
		if ( not inputFrame ) then
			error( "Expected to find frame index " .. tostring(i) .. ", but did not. Verify the numbering in the Frames table." )
		end

		if (isstring(inputFrame)) then
			inputFrame = processFrameString( inputFrame )
		end
		
		local resultFrame = {}
		
		-- Iterate over each light-state in frame
		for k, v in pairs( inputFrame ) do
			if ( isnumber(v) ) then
				resultFrame[#resultFrame+1] = { v, 1 }
			elseif ( istable(v) ) then
				resultFrame[#resultFrame+1] = v
			elseif ( isstring(v) ) then
				resultFrame[#resultFrame+1] = { v, 1 }
			else
				error("Invalid light-state in frame #" .. tostring(i))
			end
		end
		
		processedFrames[i] = resultFrame

		
	end

	-- Add zero frame (i.e. segment default state)
	if ( not processedFrames[0] ) then
		-- error("no zero frame")
	-- if ( not segmentData.Frames[0] ) then
		processedFrames[0] = buildZeroFrame( processedFrames )
	-- elseif ( isstring(segmentData.Frames[0] ) ) then
	-- 	processedFrames[0] = processFrameString( segmentData.Frames[0] )
	-- else
		-- processedFrames[0] = segmentData.Frames[0]
	else
		-- print("ZERO FRAME: ********************************************************")
		-- PrintTable(processedFrames[0])
	end

	-- SAVE THIS LINE
	-- segment:AddFrame( 0, processedFrames[0] )

	-- local zeroFrame = flattenFrame( processedFrames[0] )
	local zeroFrame = flattenFrame(processedFrames[0])
	segment:AddFrame( 0, rebuildFrame(zeroFrame) )
	-- local zeroFrame = segment:AddFrame( 0, ) 
	
	-- Merges the OFF/default frame to ensure lights reset in the segment
	for i=1, #processedFrames do
		local copyTo = table.Copy( zeroFrame )
		local flatFrame = flattenFrame( processedFrames[i] )
		table.Merge( copyTo, flatFrame )
		segment:AddFrame( i, rebuildFrame( copyTo ) )
	end
	
	if ( not segmentData.Sequences ) then
		ErrorNoHaltWithStack( "Segment is missing .Sequences = {}")
	end

	-- Add sequences
	for sequenceName, frameSequence in pairs( segmentData.Sequences or {} ) do
		
		-- debugging
		-- local frameSequenceMetatable = getmetatable( frameSequence )
		-- if ( istable(frameSequenceMetatable) ) then
		-- 	print(" ^^^^^^ FRAME SEQUENCE HAS METATABLE ^^^^^^")
		-- 	PrintTable( frameSequenceMetatable )
		-- else
		-- 	print("FRAME SEQUENCE HAS NO METATABLE")
		-- end
		
		
		segment:AddNewSequence( sequenceName, frameSequence )
	end

	-- Add inputs (new sequence implementation)
	-- for channelMode, sequenceData in pairs( segmentData.)

	return segment
end

-- On instance creation
---@param componentInstance PhotonLightingComponent
---@return PhotonElementingSegment
function Segment:Initialize( componentInstance )
	---@type PhotonElementingSegment
	local segment = {
		LastFrameTime = 0,
		IsActive = false,
		CurrentPriorityScore = 0,
		Component = componentInstance,
		CurrentModes = componentInstance.CurrentModes,
		Elements = componentInstance.Elements,
		StateMap = componentInstance.StateMap,
		Sequences = {},
		InitializedFrames = {},
		InputActions = {}
	}
	
	setmetatable( segment, { __index = self } )

	-- Setup frames
	for i=0, #self.Frames do
		segment.InitializedFrames[i] = {}
		local frame = segment.InitializedFrames[i]
		for lightId, stateId in pairs(self.Frames[i]) do
			if ( isnumber( stateId ) ) then
				if ( not segment.StateMap[lightId] ) then
					error( "Light ID [" .. tostring( lightId ) .. "] could not be found in the StateMap.")
				end
				stateId = segment.StateMap[lightId][stateId]
				if ( not stateId ) then
					error(string.format("StateMap on Component[%s] Light[%s] does not have Color #%s defined.", componentInstance.Name, lightId, self.Frames[i][lightId]))
				end
			end
			if (not segment.Component.Elements[lightId]) then
				error("Light ID [" .. tostring(lightId) .. "] could not be found.")
			end
			-- TODO: error handling -- this breaks if the frame 
			-- references a non-existent light
			frame[segment.Component.Elements[lightId]] = stateId
		end
	end

	-- -- Setup sequences
	-- for sequenceName, sequence in pairs( self.Sequences ) do
	-- 	error("Deprecated...")
	-- 	-- printf( "Initializing sequence [%s]", sequenceName )
	-- 	-- segment.Sequences[sequenceName] = sequence:Initialize( segment )
	-- end

	-- Setup inputs (new/revised sequences)
	for channelMode, sequenceData in pairs( self.InputActions ) do
		-- printf( "Initializing input sequence from channel mode [%s]", channelMode )
		if ( not self.Sequences[sequenceData.Sequence] ) then
			error( "Sequence [" .. tostring( sequenceData.Sequence ) .."] does not exist." )
		end
		segment.Sequences[sequenceData.Sequence] = self.Sequences[sequenceData.Sequence]:Initialize( sequenceData.Sequence, segment, sequenceData.Priority, sequenceData.Rank )
	end

	segment:ApplyModeUpdate()

	return segment
end


---@param name string Unique sequence name.
---@param frameSequence integer[]
function Segment:AddNewSequence( name, frameSequence )
	self.Sequences[name] = PhotonSequence.New( name, frameSequence, self )
end

function Segment:AddInput()

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
			--????
		else
			result[lightId] = stateId
		end
	end
	self.Frames[index] = result
	return result
end


---@param count number
function Segment:IncrementFrame( count )
	-- print("Incrementing frame... (" .. tostring(count) .. ")")
	if not (self.IsActive) then return end
	if not (self.ActivePattern) then return end

	local sequence = self:GetCurrentSequence()
	if ( not sequence ) then return end
	sequence:IncrementFrame( count )
	-- sequence:SetFrame( (count % #sequence) + 1 )
end


-- -- Updates all lights to match the current sequence frame.
-- function Segment:Render()
-- 	if true then return end
-- 	if (not self.IsActive) then return end

-- 	local map = self.Inputs
-- 	local sequence

-- 	for i = 1, #map[self.ActivePattern] do
-- 		---@type PhotonSequence
-- 		sequence = map[i]
-- 		local lights = self.Elements
-- 		-- map[i] is a PhotonSequence class
-- 		for lightId, state in pairs( sequence[sequence.CurrentFrame] ) do
-- 			lights[lightId]:SetState( state, self.CurrentPriorityScore )
-- 		end
-- 	end
-- end


---@param channelMode string 
---@param sequence string
---@param conditions? table
function Segment:AddPattern( channelMode, sequence, priorityScore, rank )
	-- printf("Adding pattern. Mode: %s. Sequence: %s. Priority: %s. Rank: %s.", channelMode, sequence, priorityScore, rank)
	if (istable(conditions)) then
		-- TODO: conditional
	end
	
	-- Create sequence variant with rank and score information
	local sequenceName = channelMode .. "/" .. self.Name .. "/" .. sequence
	self.Sequences[sequenceName] = self.Sequences[sequence]
	-- if (isstring(sequence)) then
	-- 	sequence = self.Sequences[sequence]
	-- end
	self.InputActions[channelMode] = { Sequence = sequenceName, Rank = rank, Priority = priorityScore }
	self.Inputs[channelMode] = sequenceName --[[@as string]]
end

function Segment:AcceptsChannelMode( channelMode )
	local exists = self.Inputs[channelMode] ~= nil
	-- print("Checking if segment[" .. self.Name .. "] accepts channel mode [" .. channelMode .. "]. Result: [" .. tostring( exists ) .."]" )
	-- PrintTable( self.Inputs )
	-- return true
	return exists
end


function Segment:CalculatePriorityChannel( inputState )
	-- print("Calculating priority input...")
	
	-- PrintTable( inputState )
	local topScore = -1000
	local result
	-- print("============== SEGMENT INPUT STATE ================")
	-- PrintTable( inputState )

	for channel, mode in pairs( inputState ) do
		-- printf( "\tChecking channel [%s]", channel )
		if (mode == "OFF") then continue end
		if ( self.InputPriorities[channel] ) then
			
			-- TODO: find alternative to string concatination
			if ( ( self.InputPriorities[channel] > topScore ) and self:AcceptsChannelMode( channel .. ":" .. inputState[channel] ) ) then
				topScore = self.InputPriorities[channel]
				result = channel
			end
		elseif ( self:AcceptsChannelMode( channel .. ":" .. inputState[channel] ) ) then
			error( "Segment is configured to accept channel input [" .. tostring(channel) .. "] but the channel does not an Input Priority score defined." )
		-- else
			-- error("Input priority score not found for " .. tostring(channel))
		end
	end
	return result
end


function Segment:OnModeChange( channel, mode )
	printf("Segment received a mode update [%s] => %s", channel, mode)
	self:ApplyModeUpdate()
end

function Segment:ApplyModeUpdate()
	local inputState = self.CurrentModes
	local newChannel = self:CalculatePriorityChannel( inputState )

	if (not newChannel) then 
		-- print("Segment:ApplyModeUpdate() -> newChannel is nil and the update is terminating.")
		self:DectivateCurrentSequence()
		-- self:ResetSegment()
		self.ActivePattern = nil
		self.IsActive = false
		return 
	end
	
	-- printf( "New channel calculated to be: %s", newChannel )
	local newMode = newChannel .. ":" .. inputState[newChannel]
	-- printf( "New mode calculated to be: %s", newMode )
	self.CurrentPriorityScore = self.InputPriorities[newChannel]
	-- printf( "CurrentPriorityScore: %s", self.CurrentPriorityScore )
	
	-- Do nothing if active mode hasn't changed
	if ( newMode == self.ActivePattern ) then return end
	
	-- self:DeactivateSequences()
	self:DectivateCurrentSequence()
	-- Turn off all segment lights when the active pattern changes.
	-- self:ResetSegment()
	self.ActivePattern = newMode
	self.IsActive = true
	self:ActivateCurrentSequence()
	-- Turn lights back on
	-- self:ActivateSequences()
end


function Segment:ResetSegment()
	-- print("Resetting segment...")
	local lights = self.Elements
	for lightId, state in pairs(self.Frames[0]) do
		lights[lightId]:SetState( state )
	end
end

function Segment:ActivateCurrentSequence()
	local sequence = self:GetCurrentSequence()
	if (sequence) then
		sequence:Activate()
		self.Component:RegisterActiveSequence( "x", sequence )
	end
end

function Segment:DectivateCurrentSequence()
	local sequence = self:GetCurrentSequence()
	if (sequence) then
		sequence:Deactivate()
		self.Component:RemoveActiveSequence( "x", sequence )
	end
end

function Segment:GetCurrentSequence()
	-- printf("Attemping to get current sequence. The .ActivePattern is [%s]", self.ActivePattern)
	-- printf("self.Inputs[self.ActivePattern] = [%s]", self.Inputs[self.ActivePattern])
	-- PrintTable(self.Sequences)
	-- print("Sequence exists: " .. tostring(not (self.Sequences[self.Inputs[self.ActivePattern]] == nil)))
	return self.Sequences[self.Inputs[self.ActivePattern]]
end


-- function Segment:ActivateSequences()
-- 	---@type PhotonSequence[]
-- 	local sequences = self.Inputs[self.ActivePattern]
-- 	for i = 1, #sequences do
-- 		sequences[i]:Activate()
-- 	end
-- end


-- function Segment:DeactivateSequences()
-- 	---@type PhotonSequence[]
-- 	local sequences = self.Inputs[self.ActivePattern]
-- 	for i = 1, #sequences do
-- 		sequences[i]:Deactivate()
-- 	end
-- end

-- ---@param channel string Channel Name
-- ---@param ... string Channel Modes
-- ---@return PhotonElementingSegment
-- function Segment:OnInput( channel, ... )
-- 	local modes = table.pack(...)
-- 	local pattern = PhotonSequenceCollection.New( self )

-- 	if self.InputPriorities[channel] then
-- 		pattern.Priority = self.InputPriorities[channel]
-- 	else
-- 		pattern.Priority = -1
-- 		Photon2.Debug.Print("No channel input priority defined for '" .. tostring(channel) .. "'")
-- 	end

-- 	for i = 1, #modes do
-- 		self.Inputs[channel .. "." .. mode] = pattern
-- 	end

-- 	return self
-- end
