-- This file is only used for Lua annotation support.
---@meta

if (true) then return end

---@type PhotonLight
PhotonLight = PhotonLight

---@type PhotonSequence
PhotonSequence = PhotonSequence

---@type PhotonSequenceCollection
PhotonSequenceCollection = PhotonSequenceCollection

---@type PhotonLightingSegment
PhotonLightingSegment = PhotonLightingSegment

---@type PhotonSequenceFrame
PhotonSequenceFrame = PhotonSequenceFrame

---@type PhotonLightingComponent
PhotonLightingComponent = PhotonLightingComponent

---@type PhotonBaseEntity
PhotonBaseEntity = PhotonBaseEntity

---@type PhotonVehicle
PhotonVehicle = PhotonVehicle

---@type PhotonVehicleEquipmentManager
PhotonVehicleEquipmentManager = PhotonVehicleEquipmentManager

---@type PhotonLight2D
PhotonLight2D = PhotonLight2D

---@class Photon2.Index
---@field Components PhotonLightingComponent[] Components index.
---@field Vehicles PhotonVehicle[] Vehicles index.
---@field Profiles Photon2.Index.Profiles

---@class Photon2.Index.Profiles
---@field Map {}
---@field Vehicles table<string, string>

---@class PhotonLibraryComponent
---@field Author string Author's name.
---@field PrintName string
---@field Model string
---@field Lighting table
---@field Lights table
---@field LightGroups table
---@field Segments table
---@field Patterns table

---@class PhotonLibraryVehicle
---@field ID string (Internal) Overwritten by the filename. Cannot be set by user.
---@field Vehicle string The original vehicle name this is based on (e.g. "20fpiu_new_sgm").
---@field Title string The printed name of the vehicle.
---@field Category string The default spawn category of the vehicle.
---@field Author string The author of this _Photon_ vehicle profile.
---@field IsEquipmentConfigurable boolean (Internal) Whether the equipment is user-configurable or static. This is determined automatically by the `.Equipment {}` table structure.
---@field Equipment PhotonVehicleEquipment[]
---@field Selections PhotonVehicleSelectionCategory[]

---@class PhotonEquipmentTable
---@field Components table
---@field Props table
---@field BodyGroups table
---@field SubMaterials table

---@class PhotonVehicleSelectionCategory
---@field Category string Category name.
---@field Options PhotonVehicleSelectionOption[]

---@class PhotonVehicleSelectionOption
---@field Option string Selection name.
---@field Variants PhotonVehicleSelectionVariant[]


---@class PhotonVehicleSelectionVariant
---@field Variant string
---@field Variants PhotonVehicleEquipment[]

---@class PhotonVehicleEquipment
---@field ID string (Internal) Unique per-vehicle identifier.
---@field Component string Component identifier. Cannot be used with `Prop` defined.
---@field Prop string Model path. If set, the model is treated as a static prop. Cannot be used if `Component` is also defined.
---@field BodyGroups table
---@field Position Vector
---@field Angles Angle
---@field Scale number
---@field MoveType MOVETYPE
---@field OnServer boolean -- (Default = `false`) If true, the component will be spawned on the server instead of just clientside. Do not enable unless you know what you're doing.


---@class PixVisHandle


---@param filename string
function include(filename) end

---@param object any
---@return boolean
function istable( object ) end