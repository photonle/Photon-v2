---@meta

---@class PhotonElementVirtualStateProperties : PhotonElementProperties

---@class PhotonElementVirtualProperties : PhotonElementVirtualStateProperties
---@field States table<string, PhotonElementVirtualProperties> Element states.

---@class PhotonElementVirtualEntry : PhotonElementVirtualProperties

---@class PhotonElementVirtual : PhotonElement, PhotonElementVirtualProperties