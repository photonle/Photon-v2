---@meta

-- Properties that are settable by element states.
---@class PhotonElementBoneStateProperties : PhotonElementProperties
---@field Activity? PhotonBoneLightActivity
---@field Speed? number Controls how fast rotation is.
---@field Target? number Required for static and sweep modes.
---@field SweepStart? number Angle the sweep should start at.
---@field SweepEnd? number Angle the sweep should end at.
---@field PauseTime? number Pause duration while sweeping.
---@field Direction number Direction of movement.
---@field Smooth? number (NOT IMPLEMENTED) Smoothing factor when reaching target value (only applies to sweep and static)

-- Adjustable element properties.
---@class PhotonElementBoneProperties : PhotonElementBoneStateProperties
---@field Axis? number | string
---@field DeactivateOnTarget? boolean If the light should deactivate upon reaching its target.
---@field AngleOutputMap? table<integer, table<number, any>>
---@field AddSpeed? number Constant number to add speed by. Can be used to intentionally "drift" lights that are otherwise set to the same speed. 

---@class PhotonElementBoneEntry : PhotonElementBoneProperties
---@field [1] string Element template name.

---@class PhotonElementBone : PhotonElement, PhotonElementBoneProperties
---@field BoneId? number
---@field Bone? string
---@field Direction? number -1 or +1
---@field Value number Current angle of rotation.
---@field InTransit? boolean If the element is actively rotating to a target value.
---@field Momentum? number (NOT IMPLEMENTED)
---@field AngleOutputCeil number
---@field AngleOutputFloor number
---@field AngleOutput string