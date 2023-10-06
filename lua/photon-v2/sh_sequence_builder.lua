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

function Photon2.SequenceBuilder:ToClipboard()
	SetClipboardText( self:ToLua() )
	return self
end


function Photon2.SequenceBuilder:Append( sequence )
	self._previous = sequence
	for i=1, #sequence do
		self[#self+1] = sequence[i]
	end
	return self
end

function Photon2.SequenceBuilder:Steady( frame, length )
	return self:Add( frame ):Do( length )
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

-- Flashes frame A then flashes frame B (i.e. `A-0-A-0` then `B-0-B-0`). To flash a one frame on and off, see :Blink(...).
---@param framePhaseA integer Index of first (A) frame to flash.
---@param framePhaseB integer Index of second (B) frame to flash.
---@param flashes? integer (Default = `1`) Number of times to flash each frame.
---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder:Flash( framePhaseA, framePhaseB, flashes )
	local result = {}
	flashes = flashes or 1
	for j=1, flashes do
		result[#result+1] = framePhaseA
		result[#result+1] = 0
	end
	for j=1, flashes do
		result[#result+1] = framePhaseB
		result[#result+1] = 0
	end
	return self:Append( result )
end

---@param frame integer The frame to use.
---@param flashes integer The number of times to blink the frame.
function Photon2.SequenceBuilder:Blink( frame, flashes )
	local result = {}
	flashes = flashes or 1
	for j=1, flashes do
		result[#result+1] = frame
		result[#result+1] = 0
	end
	return self:Append( result )
end

---@param shouldRepeat boolean If the sequence should repeat itself.
function Photon2.SequenceBuilder:SetRepeating( shouldRepeat )
	self.IsRepeating = shouldRepeat
	return self
end

-- Flashes frame A *once*, then frame B once (if set).
---@param frame integer Index of first (A) frame/phase to flash.
---@param alternateFrame? integer Index of second (B) frame/phase to flash. If left `nil`, there will be no phasing.
function Photon2.SequenceBuilder:SingleFlash( frame, alternateFrame )
	if ( alternateFrame ) then
		return self:Flash( frame, alternateFrame, 1 )
	end
	return self:Blink( frame, 1 )
end

-- Flashes first frame *twice*, then alternate frame B twice (if set).
---@param frame integer Index of first frame/phase to flash.
---@param alternateFrame? integer Index of alternate frame/phase to flash.
function Photon2.SequenceBuilder:DoubleFlash( frame, alternateFrame )
	if ( alternateFrame ) then
		return self:Flash( frame, alternateFrame, 2 )
	end
	return self:Blink( frame, 2 )
end

-- Flashes first frame *three* times, then alternate frame B three times (if set).
---@param frame integer Index of first frame/phase to flash.
---@param alternateFrame? integer Index of alternate frame/phase to flash.
function Photon2.SequenceBuilder:TripleFlash( frame, alternateFrame )
	if ( alternateFrame ) then
		return self:Flash( frame, alternateFrame, 3 )
	end
	return self:Blink( frame, 3 )
end

-- Flashes first frame *four* times, then alternate frame B four times (if set).
---@param frame integer Index of first frame/phase to flash.
---@param alternateFrame? integer Index of alternate frame/phase to flash.
function Photon2.SequenceBuilder:QuadFlash( frame, alternateFrame )
	if ( alternateFrame ) then
		return self:Flash( frame, alternateFrame, 4 )
	end
	return self:Blink( frame, 4 )
end

-- Flashes first frame *five* times, then alternate frame B five times (if set).
---@param frame integer Index of first frame/phase to flash.
---@param alternateFrame? integer Index of alternate frame/phase to flash.
function Photon2.SequenceBuilder:QuintFlash( frame, alternateFrame )
	if ( alternateFrame ) then
		return self:Flash( frame, alternateFrame, 5 )
	end
	return self:Blink( frame, 5 )
end

-- Takes the previous *frame* and holds (pauses) it for the length specified.
function Photon2.SequenceBuilder:Hold( length )
	local previous = self[#self]
	for j=1, length do
		self[#self+1] = previous
	end
	return self
end

-- Repeats the previous *section* for number of times specified.
---@param times integer Number of times to repeat the previous section.
function Photon2.SequenceBuilder:Do( times )
	for i=1, times-1 do
		self:Append( self._previous )
	end
	return self
end

setmetatable( Photon2.SequenceBuilder, {
	__call = function()
		return setmetatable( { _previous = {} }, Photon2.SequenceBuilder )
	end
} )

-- local s = Photon2.SequenceBuilder.New()
-- print(s:Alternate(1,2,4):Do(3):Add(0):Flash(1,2,3):Do(3):ToLua())