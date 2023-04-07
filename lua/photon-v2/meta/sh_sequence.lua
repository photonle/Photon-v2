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
local Sequence = META


Sequence.IsRepeating = true
Sequence.RestartFrame = 1

-- Returns initialized Sequence for a spawned component.
---@return PhotonSequence
function Sequence:Initialize( segment )
	---@type PhotonSequence
	local instance = {
		Segment = segment,
		CurrentFrame = 1,
	}
	return setmetatable( instance, { __index = self } )
end


-- Returns new Sequence for compiled component.
---@param name string
---@param frameSequence integer[]
---@return PhotonSequence
function Sequence.New( name, frameSequence )
	---@type PhotonSequence
	local sequence = {
		Name = name,
		FramesByIndex = frameSequence
	}
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
end


--TODO
function Sequence:Activate() 
	print("Activating sequence.")
end


function Sequence:Deactivate() 
	print("Deactviating sequence.")
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