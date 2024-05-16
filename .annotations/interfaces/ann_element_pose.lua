---@meta

---@class PhotonElementPoseStateProperties : PhotonElementProperties
---@field Target number Pose target value.
---@field GainSpeed number Speed at which the pose value increases.
---@field LossSpeed number Speed at which the pose value decreases.

---@class PhotonElementPoseProperties : PhotonElementPoseStateProperties
---@field Parameter string Pose parameter name.
---@field States table<string, PhotonElementPoseStateProperties> States.

---@class PhotonElementPoseEntry : PhotonElementPoseProperties
---@field [1] string Template name.
---@field [2] string Pose parameter name.

---@class PhotonElementPose : PhotonElement, PhotonElementPoseProperties
---@field Value number Current value of pose parameter.
---@field States table<string, PhotonElementPoseState> States.