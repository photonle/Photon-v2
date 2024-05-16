---@meta

---@class PhotonElementProjectedStateProperties : PhotonElementProperties, PhotonElementPropertiesIntensityTransitions
---@field Color? PhotonElementColor
---@field Brightness? number

---@class PhotonElementProjectedProperties : PhotonElementPositionalProperties, PhotonElementProjectedStateProperties
---@field Rotation? Angle
---@field NearZ? number
---@field FarZ? number
---@field FOV? number
---@field HorizontalFOV? number
---@field VerticalFOV? number
---@field Intensity? number
---@field EnableShadows? boolean Enable or disable shadows cast from the projected texture.
---@field IntensityFOVFloor? number The minimum FOV multiplier to use when the light intensity is zero.
---@field IntensityDistanceFactor? number Multiplied by light's intensity to modify its distance. Used to smooth intensity transition effects.
---@field Texture? string
---@field States? table<string, PhotonElementProjectedStateProperties>

---@class PhotonElementProjectedEntry : PhotonElementProjectedProperties
---@field [1] string Element template name.
---@field [2] Vector Local position.
---@field [3] Angle Local angles.

---@class PhotonElementProjected : PhotonElement, PhotonElementProjectedProperties
---@field ProjectedTexture? ProjectedTexture
---@field LocalPosition? Vector
---@field LocalAngles? Angle
---@field TranslatedLocalAngles Angle
---@field Matrix? VMatrix
---@field TargetIntensity number
---@field Material? string (Optional) Material that texture will be used from.
