---@meta

---@class PhotonElementDynamicLightStateProperties : PhotonElementProperties
---@field Color? PhotonColor Color of dynamic light.
---@field Brightness? number Brightness of dynamic light.
---@field Size? number Size (spread) of dynamic light.

---@class PhotonElementDynamicLightProperties : PhotonElementPositionalProperties, PhotonElementDynamicLightStateProperties
---@field InnerAngle? number
---@field OuterAngle? number
---@field MinimumLight? number
---@field World? boolean
---@field Model? boolean
---@field Style? number
---@field Direction? "Up" | "Right" | "Forward"
---@field States? table<string, PhotonElementDynamicLightStateProperties>

---@class PhotonElementDynamicEntry : PhotonElementDynamicLightProperties
---@field [1] string Element template name.

---@class PhotonElementDynamicLight : PhotonElement, PhotonElementDynamicLightProperties
---@field LocalPosition? Vector
---@field LocalAngles? Angle
---@field Decay? number
---@field DieTime? number
---@field Index? number
-- -@field States table<string, PhotonElementDynamicState>