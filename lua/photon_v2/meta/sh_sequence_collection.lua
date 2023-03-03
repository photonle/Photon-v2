if (exmeta.ReloadFile("photon_v2/meta/sh_sequence_collection.lua")) then return end

NAME = "PhotonSequenceCollection"
---@class PhotonSequenceCollection
local SequenceCollection = META


function SequenceCollection.New()
	local sequenceCollection = {}
	debug.setmetatable( sequenceCollection, PhotonSequenceCollection)
	return sequenceCollection
end


function SequenceCollection:GetParent()
	if (self.parentSequence == nil) then return self end
	return self.parentSequence
end


function SequenceCollection:SetParent( parent )
	self.parentSequence = parent
end


function SequenceCollection:SetSegment( segment )
	self.Segment = segment
end


function SequenceCollection:AddSequences( sequences )
	for k, name in pairs( sequences ) do
		if (self.Segment.Sequences[name]) then
			self.Sequences[#self.Sequences + 1] = name
		else
			ErrorNoHalt("[Photon2] Sequence name '" .. tostring(name) .. "' does not exist.")
		end
	end
	return self
end


function SequenceCollection:Clear()
	self.Sequences = {}
	return self
end