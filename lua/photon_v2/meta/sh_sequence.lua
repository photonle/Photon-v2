if (exmeta.ReloadFile("photon_v2/meta/sh_sequence.lua")) then return end

NAME = "PhotonSequence"

local Sequence = META


Sequence.IsRepeating = true
Sequence.RestartFrame = 1


function Sequence.New()
	local sequence = {}
	debug.setmetatable( sequence, PhotonSequence )
	return sequence
end


function Seqeuence:SetSegment( segment )
	self.Segment = segment
end


function Sequence:Clear()

end


function Sequence:GetCurrentIndex()

end


function Sequence:GetCurrentFrame()

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