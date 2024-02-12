---@meta

---@class PhotonElementPoseStateProperties
---@field Target number Pose target value.
---@field GainSpeed number Speed at which the pose value increases.
---@field LossSpeed number Speed at which the pose value decreases.

---@class PhotonElementPoseProperties : PhotonElementPoseStateProperties
---@field Parameter string Pose parameter name.
---@field States table<string, PhotonElementPoseStateProperties> States.

---@class PhotonElementPoseEntry : PhotonElementPoseProperties

---@class PhotonElementPose : PhotonElement, PhotonElementPoseProperties
---@field Value number Current value of pose parameter.
---@field States table<string, PhotonElementPoseState> States.