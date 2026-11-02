if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSound"
BASE = "PhotonElement"

local info, warn, warn_once = Photon2.Debug.Declare( "SoundElement")

---@type PhotonElementSound
local Sound = exmeta.New()

Sound.Class = "Sound"

Sound.Volume = 1
Sound.VolumeTransition = 0.1
Sound.Pitch = 100
Sound.PitchTransition = 0.01
Sound.Level = 85
Sound.DSP = 118
-- Sound.DSP = 1
Sound.Muted = false

-- Doppler settings (Source engine velocity is measured in units/second).
-- 13503 units/s is approximately the speed of sound at 343 m/s.
Sound.DopplerEnabled = true
Sound.DopplerSpeedOfSound = 13503
Sound.DopplerStrength = 1
Sound.DopplerMinMultiplier = 0.75
Sound.DopplerMaxMultiplier = 1.35
Sound.DopplerPitchTransition = 0.05

-- Only playing sounds are updated. One shared hook handles every sound element.
local activeSounds = setmetatable( {}, { __mode = "k" } )

-- Estimate radial velocity from the change in distance between EyePos() and
-- the source entity. This intentionally does not use GetVelocity(): it also
-- works with detached camera entities because it measures what the listener
-- actually sees from frame to frame.
local function DopplerMultiplier( element, listenerPos, now )
    local source = element.Parent
    if ( not IsValid( source ) ) then return 1 end

    local offset = listenerPos - source:GetPos()
    local distance = offset:Length()
    local previousDistance = element.DopplerPreviousDistance
    local previousTime = element.DopplerPreviousTime

    element.DopplerPreviousDistance = distance
    element.DopplerPreviousTime = now

    -- The first sample only establishes a baseline.
    if ( previousDistance == nil or previousTime == nil ) then return 1 end

    local dt = now - previousTime
    if ( dt <= 0.0001 ) then return 1 end

    local distanceDelta = previousDistance - distance

    -- Ignore discontinuities such as teleporting the camera or changing views.
    -- Normal vehicle movement is far below this threshold.
    if ( math.abs( distanceDelta ) > ( 3000 * dt + 128 ) ) then return 1 end

    -- Positive means distance is decreasing (approaching); negative means
    -- distance is increasing (receding). This is relative radial speed, in
    -- Source units per second, measured from the actual EyePos/source positions.
    local radialSpeed = distanceDelta / dt
    local c = element.DopplerSpeedOfSound or Sound.DopplerSpeedOfSound
    local strength = element.DopplerStrength or Sound.DopplerStrength
    if ( c <= 0 ) then return 1 end

    -- For an approaching source, c - radialSpeed gets smaller and pitch rises.
    local denominator = math.max( c - radialSpeed * strength, c * 0.1 )
    local multiplier = c / denominator

    return math.Clamp( multiplier,
        element.DopplerMinMultiplier or Sound.DopplerMinMultiplier,
        element.DopplerMaxMultiplier or Sound.DopplerMaxMultiplier )
end

if ( CLIENT ) then
    hook.Add( "Think", "Photon2:SoundElementDoppler", function()
        local player = LocalPlayer()
        if ( not IsValid( player ) ) then return end

        -- Use the actual current view origin, including camera-entity views.
        local listenerPos = EyePos()
        local now = RealTime()

        for element in pairs( activeSounds ) do
            local patch = element.Sound
            if ( not patch or not IsValid( element.Parent ) or not patch:IsPlaying() ) then
                activeSounds[element] = nil
                element.DopplerPreviousDistance = nil
                element.DopplerPreviousTime = nil
                element.LastDopplerPitch = nil
            else
                local multiplier = 1
                if ( element.DopplerEnabled ~= false ) then
                    multiplier = DopplerMultiplier( element, listenerPos, now )
                end

                local pitch = math.Clamp( ( element.Pitch or 100 ) * multiplier, 0, 255 )
                if ( not element.LastDopplerPitch or math.abs( pitch - element.LastDopplerPitch ) >= 0.1 ) then
                    patch:ChangePitch( pitch, element.DopplerPitchTransition or Sound.DopplerPitchTransition )
                    element.LastDopplerPitch = pitch
                end
            end
        end
    end )
end

---@param element PhotonElementSound
---@param template any
function Sound.New( element, template )
	if ( isstring( element[2] ) ) then
		element.File = element[2]
	end
	setmetatable( element, { __index = ( template or PhotonElementSound ) } )
	return element
end

Sound.States = {
	["OFF"] = {
		Mute = true,
		Play = false,
	},
	["ON"] = {
		Mute = false,
		Play = true	
	},
	["HORN"] = {
		Mute = false,
		Play = true,
	},
	["MUTE"] = {
		Mute = true,
		Play = true
	}
}

function Sound.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementSound })
end

function Sound:Initialize( id, component )
	---@type PhotonElementSound
	self = PhotonElement.Initialize( self, id, component )
	self.SoundIdentifier = "SoundElement[" .. id .. "]"
	if ( self.Tone ) then self:SetTone( self.Tone ) end
	return self
end

function Sound:SetTone( tone )
	if ( self.Component.Siren ) then
		local siren = Photon2.GetSiren(self.Component.Siren)
		if ( not siren ) then warn_once( "Unable to locate siren [%s]", self.Component.Siren ) return end
		local data = siren.Tones[tone]
		if ( data ) then
			self.File = data.Sound
			self.ToneData = data
		end
	else
		ErrorNoHalt("Component does not have .Siren defined.")
	end
	-- local data = Photon2.GetSirenTone( tone )

	-- self.File = data.Sound
end

---@param state PhotonElementSoundState
function Sound:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	self.Volume = state.Volume
	self.Pitch = state.Pitch
	self.DSP = state.DSP
	self.Level = state.Level
	self.Playing = state.Play
	self.PitchTransition = state.PitchTransition
	self.VolumeTransition = state.VolumeTransition
	self:Sync()
end

function Sound:Sync()
	self:SetPlay( self.Playing )
	self:SetVolume( self.Volume, self.VolumeTransition )
	self:SetLevel( self.Level )
	self:SetPitch( self.Pitch, self.PitchTransition )
	self:SetMute( self.Muted )
	self:SetDSP( self.DSP )
end

function Sound:Activate()
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
	if ( self.File ) then
		if ( not self.Sound ) then
			self.Sound = CreateSound( self.Parent, self.File )
			self:Sync()
		end
	end
end

function Sound:DeactivateNow()
	self.IsAcivated = false
	self.Deactivate = false
	if ( self.Sound ) then self.Sound:Stop() end
	self.Sound = nil
	activeSounds[self] = nil
	self.LastDopplerPitch = nil
end

function Sound:SetVolume( volume, transition )
	transition = transition or 0
	-- self.Volume = volume
	if ( self.Muted ) then volume = 0; transition = 0; end
	if ( self.Sound ) then self.Sound:ChangeVolume( volume, transition ) end
end

function Sound:SetPitch( pitch, transition )
	transition = transition or 0
	-- self.Pitch = pitch
	if ( self.Sound ) then
        self.LastDopplerPitch = nil
        self.Sound:ChangePitch( pitch, transition )
    end
end

function Sound:SetDSP( dsp )
	-- self.DSP = dsp
	if ( self.Sound ) then self.Sound:SetDSP( dsp ) end
end

function Sound:SetLevel( level )
	-- self.Level = level
	if ( self.Sound ) then self.Sound:SetSoundLevel( level ) end
end

function Sound:SetMute( mute )
	if ( mute ) then
		-- self.Muted = true
		-- if ( self.Sound ) then self.Sound:ChangeVolume( 0, 0 ) end
			self:SetLevel( 0.0001 )
		return
	end
	self:SetLevel( self.Level )
	-- self.Muted = false
	-- if ( self.Sound ) then self.Sound:ChangeVolume( self.Volume, 0 ) end
end

function Sound:SetPlay( play )
	if ( play ) then
		self.Playing = true
		if ( self.Sound and self.Sound:IsPlaying() ) then return end
		if ( not self.File ) then return end
		self.Sound:PlayEx( self.Volume, self.Pitch )
        activeSounds[self] = true
        self.LastDopplerPitch = nil
		self.Parent:CallOnRemove( self.SoundIdentifier, function()
			self:DeactivateNow()
		end)
		return
	else
		self.Playing = false
		if ( self.Sound ) then 
			self.Sound:FadeOut( 0 )
			self.Sound:Stop()
			self.Parent:RemoveCallOnRemove( self.SoundIdentifier )
            activeSounds[self] = nil
            self.LastDopplerPitch = nil
		end
	end
	
end

function Sound.OnLoad()
	for key, value in pairs( Sound.States ) do
		Sound.States[key] = PhotonElementSoundState:New( key, value, Sound.States )
	end
end

Sound.OnLoad()