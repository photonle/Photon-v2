if (exmeta.ReloadFile()) then return end

NAME = "PhotonSequenceCollection"
---@class PhotonSequenceCollection Stores numerical array of sequence string names.
---@field parentSequence PhotonSequenceCollection 
---@field Segment PhotonLightingSegment
---@field Priority integer Current priority score.
local SequenceCollection = exmeta.New()


---@param parentSegment PhotonLightingSegment
---@return PhotonSequenceCollection
function SequenceCollection.New( parentSegment )
	---@type PhotonSequenceCollection
	local sequenceCollection = {
		Segment = parentSegment,
		Priority = 0
	}
	debug.setmetatable( sequenceCollection,  { __index = PhotonSequenceCollection } )
	return sequenceCollection
end

---@param ... string
function SequenceCollection:AddSequences( ... )
	local sequences = table.pack( ... )
	for k, name in pairs( sequences ) do
		if (self.Segment.Sequences[name]) then
			self[#self + 1] = name
		else
			ErrorNoHalt("[Photon2] Sequence name '" .. tostring(name) .. "' does not exist.")
		end
	end
	return self
end


function SequenceCollection:Clear()
	for i = 1, #self do
		self[i] = nil
	end
	return self
end