if (exmeta.ReloadFile("photon-v2/meta/sh_sequence.lua")) then return end

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
local Sequence = META


Sequence.IsRepeating = true
Sequence.RestartFrame = 1

-- Returns initialized Sequence for a spawned component.
---@param segment PhotonLightingSegment
---@return PhotonSequence
function Sequence:Initialize( segment )
	---@type PhotonSequence
	local instance = {
		Segment = segment,
		CurrentFrame = 1,
		UsedLights = {}
	}

	local lights = segment.Lights

	for i=1, #self.UsedLightsByIndex do
		instance.UsedLights[#instance.UsedLights+1] = lights[self.UsedLightsByIndex[i]]
	end


	-- Setup instance frame mapping.
	-- Uses Sequence object to act as array of direct frame references 
	-- instead of repated table look-ups.
	for i=1, #self.FramesByIndex do
		instance[i] = segment.Frames[self.FramesByIndex[i]]
	end

	return setmetatable( instance, { __index = self } )
end


-- Returns new Sequence for compiled component.
---@param name string
---@param frameSequence integer[]
---@param segment PhotonLightingSegment
---@return PhotonSequence
function Sequence.New( name, frameSequence, segment )
	---@type PhotonSequence
	local sequence = {
		Name = name,
		FramesByIndex = frameSequence
	}
	
	local usedLightsByKey = {}
	local checkedFrames = {}

	for key, frame in pairs( frameSequence ) do
		if (checkedFrames[frame]) then continue end
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


function Sequence:IncrementFrame()
	self.CurrentFrame = self.CurrentFrame + 1
	if (self.CurrentFrame > #self) then
		if (self.IsRepeating) then
			self.CurrentFrame = self.RestartFrame
		else
			self.CurrentFrame = #self
		end
	end
	print( "current frame: " .. tostring(self.CurrentFrame) )
end


function Sequence:Activate() 
	print("Activating sequence.")
	local usedLights = self.UsedLights
	for i=1, #usedLights do
		usedLights[i]:Activate()
	end
end


function Sequence:Deactivate() 
	print("Deactviating sequence.")
	local usedLights = self.UsedLights
	for i=1, #usedLights do
		usedLights[i].Deactivate = true
	end
end


function Sequence:Clear()
	for i = 1, #self do
		self[i] = nil
	end
end


function Sequence:AddFrames( frames )

end


-- PATTERN BUILDING FUNCTIONS --
function Sequence:Slow( multiplier )
	return self
end


function Sequence:Flash( frameA, frameB, flash, repeatFor )
	flash = flash or 2
	repeatFor = repeatFor or 1
end