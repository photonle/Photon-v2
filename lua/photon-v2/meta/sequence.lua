if (exmeta.ReloadFile()) then return end

NAME = "PhotonSequence"
--- Frames are stored in the numerical indexes of the table.
---@class PhotonSequence
---@field Name string
---@field Segment PhotonElementingSegment
---@field CurrentFrame integer Currently active frame of the sequence.
---@field IsRepeating boolean
---@field RestartFrame integer
---@field FramesByIndex integer[]
---@field UsedLightsByIndex table<integer, boolean>
---@field UsedLights PhotonElement[]
---@field Rank number Sequence's rank in an input pattern.
---@field PriorityScore number
---@field AcceptControllerPulse boolean (Internal) If the sequence is configured to utilize pulses (used for variable frame timing).
---@field FrameDuration number
---@field Synchronize boolean If the sequence should always synchronize to its controller's rolling frame index.
local Sequence = exmeta.New()

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local RealTime = RealTime

Sequence.IsRepeating = true
Sequence.RestartFrame = 1
Sequence.FrameDuration = nil

-- Returns initialized Sequence for a spawned component.
---@param segment PhotonElementingSegment
---@return PhotonSequence
function Sequence:Initialize( name, segment, priorityScore, rank )
	---@type PhotonSequence
	local instance = {
		Name = name,
		Segment = segment,
		CurrentFrame = 1,
		UsedLights = {},
		PriorityScore = priorityScore or 0,
		Rank = rank or 0
	}

	local lights = segment.Elements

	for i=1, #self.UsedLightsByIndex do
		instance.UsedLights[#instance.UsedLights+1] = lights[self.UsedLightsByIndex[i]]
	end

	-- Setup instance frame mapping.
	-- Uses Sequence object to act as array of direct frame references instead of repeated table look-ups.
	for i=1, #self.FramesByIndex do
		instance[i] = segment.InitializedFrames[self.FramesByIndex[i]]
	end

	return setmetatable( instance, { __index = self } )
end


-- Returns new Sequence for compiled component.
---@param name string
---@param frameSequence table
---@param segment PhotonElementingSegment
---@param data? table What the fuck is this for?
---@return PhotonSequence
function Sequence.New( name, frameSequence, segment, data )
	---@type PhotonSequence

	-- unclear why this is needed
	frameSequence._previous = nil

	local shouldRepeat = true

	if ( frameSequence.IsRepeating ~= nil ) then
		shouldRepeat = frameSequence.IsRepeating
	end

	local sequence = {
		Name = name,
		IsRepeating = shouldRepeat,
		Synchronize = frameSequence.Synchronize
	}

	-- If not set, sequence will use the Segment's setting
	if ( sequence.Synchronize == nil ) then 
		sequence.Synchronize = segment.Synchronize
	end

	if ( frameSequence.FrameDuration == nil ) then
		sequence.FrameDuration = segment.FrameDuration
		if ( sequence.FrameDuration ) then
			sequence.AcceptControllerPulse = true
		end
	end
	

	local usedLightsByKey = {}
	local checkedFrames = {}
	local rebuiltFrameSequence = {}

	for key, frame in ipairs( frameSequence ) do
		rebuiltFrameSequence[key] = frame
		if (checkedFrames[frame]) then continue end
		if ( not segment.Frames[frame] ) then
			error("Frame #" .. tostring(frame) .. " does not exist.")
		end
		for lightIndex, state in pairs( segment.Frames[frame] ) do
			usedLightsByKey[lightIndex] = true
		end
		checkedFrames[frame] = true
	end

	local usedLights = {}
	for lightIndex, _ in pairs( usedLightsByKey ) do
		usedLights[#usedLights+1] = lightIndex
	end

	sequence.UsedLightsByIndex = usedLights
	sequence.FramesByIndex = rebuiltFrameSequence

	return setmetatable( sequence, { __index = PhotonSequence } )
end

function Sequence:OnPulse()
	if ( ( self.NextFrame <= RealTime() ) ) then
		self:IncrementFrame()
		return true
	end
	return false
end

---comment
---@param frame number Parent frame count. Will be ignored if sequence isn't synchronized.
---@param force? boolean If true, forces squence to use frame parameter and not discard it. (Used for previewing.)
function Sequence:IncrementFrame( frame, force )
	-- print("Frame parameter: " .. tostring( frame ))
	if ( self.FrameDuration ) then
		local nextFrame = self.NextFrame + self.FrameDuration
		-- Resets frame timing in case things get fucked
		if ( nextFrame < RealTime() ) then
			nextFrame = RealTime() + self.FrameDuration
		elseif ( self.NextFrame + .01 > ( RealTime() + self.FrameDuration ) ) then
			nextFrame = self.NextFrame
		end
		self.NextFrame = nextFrame
	end

	-- allow empty sequences to silently fail
	if ( #self < 1 ) then return end

	if ( not self.Synchronize and ( not force ) ) then
		frame = self.CurrentFrame
	end

	if ( self.IsRepeating and self.RestartFrame == 1 ) then
		self.CurrentFrame = (frame % #self) + 1
		-- print("Normal current frame: " .. tostring( self.CurrentFrame ) .. " Frame: " .. tostring( frame ) )
	elseif ( not self.IsRepeating ) then

		if ( not self.PreviousFrame ) then self.CurrentFrame = 0 end
		
		if ( self.CurrentFrame >= #self ) then
			self.CurrentFrame = #self
		else
			self.CurrentFrame = self.CurrentFrame + 1
		end

	else
		self.CurrentFrame = (frame % #self) + 1
	end

	-- self.CurrentFrame = frame
	-- if (self.CurrentFrame > #self) then
	-- 	if (self.IsRepeating) then
	-- 		print("sequence should repeat")
	-- 		self.CurrentFrame = self.RestartFrame
	-- 	else
	-- 		print("sequence should not repeat")
	-- 		self.CurrentFrame = #self
	-- 	end
	-- end
	self.ActiveFrame = self[self.CurrentFrame]
	if not (self.PreviousFrame == self.ActiveFrame) then
		-- print( "current frame: " .. tostring(self.CurrentFrame) )
		if ( not self.ActiveFrame ) then
			error( "Invalid frame [" .. tostring( self.CurrentFrame ) .. "]" )
		end
		for light, stateId in pairs( self.ActiveFrame ) do
			light:SetInput( self.Name, stateId )
			-- light:SetState( stateId, self.Segment.Name, self.PriorityScore, self.Rank )
		end
	end
	self.PreviousFrame = self.ActiveFrame
end

function Sequence:Activate()
	if ( not self.Synchronize ) then
		self.CurrentFrame = 0
		if ( self.FrameDuration ) then
			-- self.NextFrame = RealTime()
			self.NextFrame = RealTime() + self.FrameDuration
		end
	end
	local usedLights = self.UsedLights
	for i=1, #usedLights do
		-- usedLights[i]:Activate()
		usedLights[i]:AddInput( self.Name, (self.PriorityScore * 100 + self.Rank )  )
	end
end


function Sequence:Deactivate() 
	local usedLights = self.UsedLights
	for i=1, #usedLights do
		-- usedLights[i].Deactivate = true
		usedLights[i]:RemoveInput( self.Name )
	end
	self.PreviousFrame = nil
end


function Sequence:Clear()
	for i = 1, #self do
		self[i] = nil
	end
end