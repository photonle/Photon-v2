---@meta

---@class PhotonElementSequenceStateProperties : PhotonElementProperties
---@field Sequence string Sequence name.

---@class PhotonElementSequenceProperties : PhotonElementSequenceStateProperties
---@field States table<string, PhotonElementSequenceStateProperties> States.

---@class PhotonElementSequenceEntry : PhotonElementSequenceProperties
---@field [1] string Template name.

---@class PhotonElementSequence : PhotonElement, PhotonElementSequenceProperties
---@field States table<string, PhotonElementSequenceState> States.
