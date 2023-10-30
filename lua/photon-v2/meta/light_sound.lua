if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSound"
BASE = "PhotonElement"

---@class PhotonElementSound : PhotonElement
---@field Sound CSoundPatch
---@field Volume number Volume of the sound.
---@field Level number The distance the sound is heard.
---@field DSP number
---@field File string
---@field Playing boolean
---@field Muted boolean
---@field Pitch number
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
function Sound.New( sound, template )
	if ( isstring( sound[2] ) ) then
		sound.File = sound[2]
	end
	setmetatable( sound, { __index = ( template or PhotonElementSound ) } )
	return sound
end

Sound.States = {
	["OFF"] = {
		Mute = true,
		Play = false,
		-- Volume = 0,
		DSP = 1
	},
	["ON"] = {
		Mute = false,
		Play = true	
	},
	["HORN"] = {
		Mute = false,
		Play = true,
		DSP = 1
	},
	["MUTE"] = {
		Mute = true,
		Play = true
	}
}

function Sound.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementSound })
end

function Sound:Initialize( id, parentEntity )
	---@type PhotonElementSound
	self = PhotonElement.Initialize( self, id, parentEntity )
	return self
end

---@param state PhotonElementSoundState
function Sound:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	self.Volume = state.Volume
	self.Pitch = state.Pitch
	self.DSP = state.DSP
	self.Playing = state.Play
	-- self.Muted = state.Mute
	-- if ( state.Volume ~= nil ) then self:SetVolume( state.Volume ) end
	-- if ( state.Pitch ~= nil ) then self:SetPitch( state.Pitch ) end
	-- if ( state.DSP ~= nil ) then self:SetDSP( state.DSP ) else self:SetDSP( self.DSP ) end
	-- if ( state.Play ~= nil ) then self:SetPlay( state.Play ) end
	-- if ( state.Mute ~= nil ) then self:SetMute( state.Mute ) end
	self:Sync()
end

function Sound:Sync()
	self:SetPlay( self.Playing )
	self:SetVolume( self.Volume, self.VolumeTransition )
	self:SetLevel( self.Level )
	self:SetPitch( self.Pitch, self.PitchTransition )
	-- self:SetMute( self.Muted )
	self:SetDSP( self.DSP )
end

function Sound:Activate()
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
	if ( not self.Sound ) then
		self.Sound = CreateSound( self.Parent, self.File )
		self:Sync()
	end
end

function Sound:DeactivateNow()
	self.IsAcivated = false
	self.Deactivate = false
	if ( self.Sound ) then self.Sound:Stop() end
	self.Sound = nil
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
	if ( self.Sound ) then self.Sound:ChangePitch( pitch, transition ) end
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
		if ( self.Sound ) then self.Sound:ChangeVolume( 0, 0 ) end
		return
	end
	-- self.Muted = false
	if ( self.Sound ) then self.Sound:ChangeVolume( self.Volume, 0 ) end
end

function Sound:SetPlay( play )
	if ( play ) then
		self.Playing = true
		if ( self.Sound and self.Sound:IsPlaying() ) then return end
		self.Sound:PlayEx( self.Volume, self.Pitch )
		return
	else
		self.Playing = false
		if ( self.Sound ) then 
			self.Sound:FadeOut( 0 )
			self.Sound:Stop() 
		end
	end
	
end

function Sound.OnLoad()
	for key, value in pairs( Sound.States ) do
		Sound.States[key] = PhotonElementSoundState:New( key, value, Sound.States )
	end
end

Sound.OnLoad()