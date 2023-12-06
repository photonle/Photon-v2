if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSound"
BASE = "PhotonElement"

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

function Sound:Initialize( id, component )
	---@type PhotonElementSound
	self = PhotonElement.Initialize( self, id, component )
	self.SoundIdentifier = "SoundElement[" .. id .. "]"
	if ( self.Tone ) then self:SetTone( self.Tone ) end
	return self
end

function Sound:SetTone( tone )
	if ( self.Component.Siren ) then
		local siren = Photon2.Index.Sirens[self.Component.Siren]
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
		if ( not self.File ) then return end
		self.Sound:PlayEx( self.Volume, self.Pitch )
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
		end
	end
	
end

function Sound.OnLoad()
	for key, value in pairs( Sound.States ) do
		Sound.States[key] = PhotonElementSoundState:New( key, value, Sound.States )
	end
end

Sound.OnLoad()