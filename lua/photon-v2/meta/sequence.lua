if (exmeta.ReloadFile()) then return end

NAME = "PhotonSequence"
--- Frames are stored in the numerical indexes of the table.
---@class PhotonSequence
---@field Name string
---@field Segment PhotonLightingSegment
---@field CurrentFrame integer Currently active frame of the sequence.
---@field IsRepeating boolean
---@field RestartFrame integer
---@field FramesByIndex integer[]
---@field UsedLightsByIndex table<integer, boolean>
---@field UsedLights PhotonLight[]
---@field Rank number Sequence's rank in an input pattern.
---@field PriorityScore number
local Sequence = exmeta.New()

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

Sequence.IsRepeating = true
Sequence.RestartFrame = 1

--[[ *************************************************

	New sequence object needs to be created for each 
	reference in COMPONENT.Patterns and assigned 
	a unique sequence identifier.

	Required to:
	1) Enable intra-pattern ranking
	2) Allow off-state overriding

	Unresolved problems:
	1) How should off-state overriding be configured?
	   Per sequence? Per segment?

	 *************************************************
--]]




-- Returns initialized Sequence for a spawned component.
---@param segment PhotonLightingSegment
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

	local lights = segment.Lights

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
---@param frameSequence integer[]
---@param segment PhotonLightingSegment
---@param data? table
---@return PhotonSequence
function Sequence.New( name, frameSequence, segment, data )
	---@type PhotonSequence

	-- unclear why this is needed
	frameSequence._previous = nil

	local sequence = {
		Name = name,
		FramesByIndex = frameSequence
	}
	
	local usedLightsByKey = {}
	local checkedFrames = {}

	for key, frame in pairs( frameSequence ) do
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

	return setmetatable( sequence, { __index = PhotonSequence } )
end

function Sequence:SetFrame( frame )
	self.CurrentFrame = frame
	if (self.CurrentFrame > #self) then
		if (self.IsRepeating) then
			self.CurrentFrame = self.RestartFrame
		else
			self.CurrentFrame = #self
		end
	end
	self.ActiveFrame = self[self.CurrentFrame]
	-- if not (self.PreviousFrame == self.ActiveFrame) then
		-- print( "current frame: " .. tostring(self.CurrentFrame) )
		if ( not self.ActiveFrame ) then
			error( "Invalid frame [" .. tostring( self.CurrentFrame ) .. "]" )
		end
		for light, stateId in pairs( self.ActiveFrame ) do
			light:SetInput( self.Name, stateId )
			-- light:SetState( stateId, self.Segment.Name, self.PriorityScore, self.Rank )
		end
	-- end
	self.PreviousFrame = self.ActiveFrame
end

function Sequence:Activate()
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