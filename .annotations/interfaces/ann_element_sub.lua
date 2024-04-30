---@meta

---@class PhotonElementSubStateProperties : PhotonElementProperties
---@field Material? string Material to apply to sub-material indexes.

---@class PhotonElementSubProperties : PhotonElementSubStateProperties
---@field Indexes? integer[] Sub-material indexes affected by this element (1-32).
---@field States? table<string, PhotonElementSubStateProperties> States available to this element or elements that use this template.

---@class PhotonElementSubEntry : PhotonElementSubProperties
---@field [1] string Template name.

---@class PhotonElementSub : PhotonElement, PhotonElementSubProperties
---@field States? table<string, PhotonElementSubState>
