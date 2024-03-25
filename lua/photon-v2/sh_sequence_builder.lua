---@class PhotonSequenceBuilder : integer[]
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

-- Adds frame zero for one frame or the for the length specified. 
---@param count? number (Default = `1`) Gap length.
function Photon2.SequenceBuilder:Gap( count )
	return self:Add( 0 ):Hold( ( count or 1 ) - 1 )
end

-- (Internal) You should use :ToClipboard() instead of calling this function directly.
function Photon2.SequenceBuilder:ToLua()
	local result = "{ "
	for i=1, #self do
		result = result .. tostring( self[i] )
		if (i < #self) then
			result = result .. ", "
		end
	end
	result = result .. " }"
	return result
end

-- Copies the entire sequence in Lua syntax form to your clipboard. You can paste the result
-- to help with complex synchronization.
function Photon2.SequenceBuilder:ToClipboard()
	if ( CLIENT ) then SetClipboardText( self:ToLua() ) end
	return self
end

-- Places the provided frames at the end of this sequence.
---@param sequence integer[]
function Photon2.SequenceBuilder:Append( sequence )
	self._previous = sequence
	for i=1, #sequence do
		self[#self+1] = sequence[i]
	end
	return self
end

-- Places the provided frames at the start of the entire sequence.
---@param sequence integer[]
function Photon2.SequenceBuilder:Prepend( sequence )
	local temp = {}
	for i=1, #sequence do
		temp[#temp+1] = sequence[i]
	end
	for i=1, #self do
		temp[#temp+1] = self[i]
	end
	for i=1, #temp do
		self[i] = temp[i]
	end
	-- This will be unintuitive no matter what
	self._previous = sequence
	return self
end

-- Places the provided frames before the previously appended frames.
function Photon2.SequenceBuilder:PrependPrevious( sequence )
	local result = {}
	for i=1, #sequence do
		result[#result+1] = sequence[i]
	end
	for i=1, #self._previous do
		result[#result+1] = self._previous[i]
	end
	return self:OverwriteLast( result )
end

-- Replaces the previous block with the given sequence.
function Photon2.SequenceBuilder:OverwriteLast( sequence )
	local startIndex = #self - #self._previous
	for i=1, #sequence do
		self[startIndex + i] = sequence[i]
	end
	self._previous = sequence
	return self
end

function Photon2.SequenceBuilder:Steady( frame, length )
	return self:Add( frame ):Do( length )
end

---@param frameA integer First frame index.
---@param frameB integer Second frame index.
---@param length? integer (Default = `1`) Length (in frames) of each frame.
---@param gap? integer (Default = `0`) Off period between each flash.
---@return PhotonSequenceBuilder
function Photon2.SequenceBuilder:Alternate( frameA, frameB, length, gap )
	local result = {}

	gap = gap or 0
	length = length or 1
	for i=1, length do
		result[#result+1] = frameA
	end
	for i=1, gap do
		result[#result+1] = 0
	end
	for i=1, length do
		result[#result+1] = frameB
	end
	for i=1, gap do
		result[#result+1] = 0
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
	for j=1, length-1 do
		self[#self+1] = previous
	end
	return self
end

-- Blinks a frame X times, then ends by holding for Y frames. When multiple frames
-- are passed in a table to the frames parameter, these actions are chained.
function Photon2.SequenceBuilder:FlashHold( frames, flashes, hold )
	local result = {}
	if ( not istable( frames ) ) then frames = { frames } end
	for _, frame in pairs( frames ) do
		for i=0, flashes-1 do
			result[#result+1] = frame
			result[#result+1] = 0
		end
		for i=1, hold do
			result[#result+1] = frame
		end
		result[#result+1] = 0
	end
	return self:Append( result )
end

-- Repeats the previous *section* for number of times specified.
---@param times integer Number of times to repeat the previous section.
function Photon2.SequenceBuilder:Do( times )
	for i=1, times-1 do
		self:Append( self._previous )
	end
	return self
end

-- Extends each frame from the previous _block_ by the amount specified. Value of `1` or less has no effect. 
-- Example: `{ 1, 2, 3 }:Stretch( 2 )` becomes `{ 1, 1, 2, 2, 3, 3 }`
function Photon2.SequenceBuilder:Stretch( amount )
	local result = {}
	for i=1, #self._previous do
		for j=1, amount do
			result[#result+1] = self._previous[i]
		end
	end
	return self:OverwriteLast( result )
end

function Photon2.SequenceBuilder:OverwriteAll( sequence )
	if ( #sequence > #self ) then
		for i=1, #sequence do
			self[i] = sequence[i]
		end
	else
		for i=1, #self do
			self[i] = sequence[i]
		end
	end
	self._previous = sequence
	return self
end

-- Extends each frame from in the _entire sequence_ by the amount specified. Value of `1` or less has no effect. 
function Photon2.SequenceBuilder:StretchAll( amount )
	local result = {}
	for i=1, #self do
		for j=1, amount do
			result[#result+1] = self[i]
		end
	end
	return self:OverwriteAll( result )
end

-- Replaces frame values in the sequence using a map table { [OLD] = NEW }.
-- Example: `Map({ [1] = 8, [2] = 9 })` will change `{ 1, 1, 2, 2 }` to `{ 8, 8, 9, 9 }`
function Photon2.SequenceBuilder:Map( map )
	for i=1, #self do
		if ( map[self[i]] ) then self[i] = map[self[i]] end
	end
end

-- Adds all consecutive frame numbers between `startFrame` and `endFrame`. (Example: `:Sequential( 1, 5 )` becomes `{ 1, 2, 3, 4, 5 }`). Frame sequence will be done in reverse if `endFrame` is lower than `startFrame`.
function Photon2.SequenceBuilder:Sequential( startFrame, endFrame )
	local result = {}
	if ( startFrame < endFrame ) then
		for i=startFrame, endFrame do
			result[#result+1] = i
		end
	else
		for i=startFrame, endFrame, -1 do
			result[#result+1] = i
		end
	end
	return self:Append( result )
end

-- Simulates the Whelen Steady Flash pattern.
function Photon2.SequenceBuilder:SteadyFlash( frame )
	return self:Steady( frame, 64 ):TripleFlash( frame )
end

-- Adds frame [0] for the specified duration
function Photon2.SequenceBuilder:Off( duration )
	local result = {}
	for i=1, duration do
		result[#result+1] = 0
	end
	return self:Append( result )
end


function Photon2.SequenceBuilder:AppendPhaseGap()
	local count = 0
	if ( self._previous ) then count = #self._previous end
	local result = {}
	for i=1, count do
		result[#result+1] = 0
	end
	return self:Append( result )
end

-- Inserts 
function Photon2.SequenceBuilder:PrependPhaseGap()
	local count = 0
	if ( self._previous ) then count = #self._previous end
	local result = {}
	for i=1, count do
		result[#result+1] = 0
	end
	return self:Prepend( result )
end

-- Configures the sequence to use variable frame timing between a "fast" and "slow" speed that changes at the specified rate.
function Photon2.SequenceBuilder:SetVariableTiming( slow, fast, rate )
	self.VariableFrameDuration = {
		Slow = slow,
		Fast = fast,
		Rate = rate or ( 1/3 )
	}
	return self
end

function Photon2.SequenceBuilder:SetTiming( frameDuration )
	self.FrameDuration = frameDuration
	return self
end

setmetatable( Photon2.SequenceBuilder, {
	__call = function()
		return setmetatable( { _previous = {} }, Photon2.SequenceBuilder )
	end
} )

-- local s = Photon2.SequenceBuilder.New()
-- print(s:Alternate(1,2,4):Do(3):Add(0):Flash(1,2,3):Do(3):ToLua())