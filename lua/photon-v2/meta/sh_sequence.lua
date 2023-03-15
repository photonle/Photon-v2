if (exmeta.ReloadFile("photon-v2/meta/sh_sequence.lua")) then return end

NAME = "PhotonSequence"
--- Frames are stored in the numerical indexes of the table.
---@class PhotonSequence
---@field Segment PhotonLightingSegment
---@field CurrentFrame integer Currently active frame of the sequence.
---@field IsRepeating boolean
---@field RestartFrame integer
local Sequence = META


Sequence.IsRepeating = true
Sequence.RestartFrame = 1

---@param segment PhotonLightingSegment
---@return PhotonSequence
function Sequence.New( segment )
	---@type PhotonSequence
	local sequence = {
		Segment = segment
	}
	debug.setmetatable( sequence, PhotonSequence )
	return sequence
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
function Sequence:Activate() end


function Sequence:Deactivate() end


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