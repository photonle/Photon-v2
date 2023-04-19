if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightState"

---@class PhotonLightState
---@field Name string
---@field Intensity number (Default = `1`) Target intensity of the light state.
---@field IntensityTransitions boolean (Default = `false`) Whether intensity transitions (animation) should be used or not.
---@field IntensityGainFactor number (Default = `20`)
---@field IntensityLossFactor number (Default = `10`)
local State = exmeta.New()

State.Intensity = 1
State.IntensityTransitions = false
State.IntensityGainFactor = 10
State.IntensityLossFactor = 10