---@meta

---@class PhotonElementSoundStateProperties
---@field File? string Sound file path (.WAV or .MP3).
---@field Volume? number `Default = 1` Volume between `0.0` (silent) and `1.0` (max).
---@field Level? number The distance at which the sound is heard. (Note: this is not the same as `Volume`.)
---@field DSP? number `Default = 118` (118 recommended for sirens, 1 recommended for sound effects.)
---@field Pitch? number `Default = 100` Varies pitch (and tempo). Accepts values between `0` and `255`.
---@field Mute? boolean If state should mute the sound.
---@field Play? boolean If state plays the sound.

---@class PhotonElementSoundProperties : PhotonElementSoundStateProperties
---@field VolumeTransition? number Transition time when changing volume. (Note: this has somewhat erratic behavior in the engine.)
---@field PitchTransition? number Transition time when changing the pitch. (Note: this has somewhat erratic behavior in the engine.)
---@field States? table<string, PhotonElementSoundStateProperties>

---@class PhotonElementSoundEntry : PhotonElementSoundProperties
---@field [1] string Element template name.

---@class PhotonElementSound : PhotonElement, PhotonElementSoundProperties
---@field Sound CSoundPatch
---@field Playing boolean
---@field Muted boolean
---@field Tone? string (Optional) Name of library siren tone.
---@field ToneData? PhotonSirenTone Set automatically.
---@field SoundIdentifier string (Internal)
---@field States? table<string, PhotonElementSoundState>