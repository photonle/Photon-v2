---@class PhotonSequenceBuilder
Photon2.SequenceBuilder = {}

Photon2.SequenceBuilder.__index = Photon2.SequenceBuilder


---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder.__call()
	return setmetatable( { _previous = {} }, Photon2.SequenceBuilder )
end


---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder.New()
	return Photon2.SequenceBuilder() --[[@as PhotonSequenceBuilder]]
end


--Adds frames to the sequence.
---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder:Add( ... )
	return self:Append( { ... } )
end


function Photon2.SequenceBuilder:ToLua()
	local result = "{ "
	for i=1, #self do
		result = result .. tostring( self[i] )
		if (i < #self) then
			result = result .. ","
		end
	end
	result = result .. " }"
	return result
end


function Photon2.SequenceBuilder:Append( sequence )
	self._previous = sequence
	for i=1, #sequence do
		self[#self+1] = sequence[i]
	end
	return self
end


---@param frameA integer First frame index.
---@param frameB integer Second frame index.
---@param length? integer (Default = `1`) Length (in frames) of each frame.
---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder:Alternate( frameA, frameB, length )
	local result = {}

	length = length or 1
	for i=1, length do
		result[#result+1] = frameA
	end
	for i=1, length do
		result[#result+1] = frameB
	end

	return self:Append( result )
end


---@param frameA integer Index of first (A) frame to use.
---@param frameB integer Index of second (B) frame to use.
---@param flashes? integer (Default = `1`) Number of times to flash each frame.
---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder:Flash( frameA, frameB, flashes )
	local result = {}
	flashes = flashes or 1
	for j=1, flashes do
		result[#result+1] = frameA
		result[#result+1] = 0
	end
	for j=1, flashes do
		result[#result+1] = frameB
		result[#result+1] = 0
	end
	return self:Append( result )
end


-- Repeats the *previous* section for number of times specified.
---@param times integer Number of times to repeat the previous section.
function Photon2.SequenceBuilder:Do( times )
	for i=1, times-1 do
		self:Append( self._previous )
	end
	return self
end

setmetatable( Photon2.SequenceBuilder, Photon2.SequenceBuilder )

local s = Photon2.SequenceBuilder.New()

print(s:Alternate(1,2,4):Do(3):Add(0):Flash(1,2,3):Do(3):ToLua())