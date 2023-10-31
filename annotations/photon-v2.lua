-- This file is only used for Lua annotation support.
---@meta

if (true) then return end

---@type PhotonElement
PhotonElement = PhotonElement

---@type PhotonElementState
PhotonElementState = PhotonElementState

---@type PhotonSequence
PhotonSequence = PhotonSequence

---@type PhotonSequenceCollection
PhotonSequenceCollection = PhotonSequenceCollection

---@type PhotonElementingSegment
PhotonElementingSegment = PhotonElementingSegment

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

---@type PhotonElementColor
PhotonElementColor = PhotonElementColor

---@type PhotonElement2D
PhotonElement2D = PhotonElement2D

---@type PhotonElement2DState
PhotonElement2DState = PhotonElement2DState

---@type PhotonElementSub
PhotonElementSub = PhotonElementSub

---@type PhotonElementSubState
PhotonElementSubState = PhotonElementSubState

---@type PhotonElementMesh
PhotonElementMesh = PhotonElementMesh

---@type PhotonElementMeshState
PhotonElementMeshState = PhotonElementMeshState

---@type PhotonDynamicMaterial
PhotonDynamicMaterial = PhotonDynamicMaterial

---@type PhotonComponent
PhotonComponent = PhotonComponent

---@type PhotonAuralComponent
PhotonAuralComponent = PhotonAuralComponent

---@type PhotonElementSound
PhotonElementSound = PhotonElementSound

---@type PhotonElementSoundState
PhotonElementSoundState = PhotonElementSoundState

---@type PhotonElementProjected
PhotonElementProjected = PhotonElementProjected

---@type PhotonElementProjectedState
PhotonElementProjectedState = PhotonElementProjectedState

---@type PhotonElementBone
PhotonElementBone = PhotonElementBone

---@type PhotonElementBoneState
PhotonElementBoneState = PhotonElementBoneState

---@type PhotonBlendColor
PhotonBlendColor = PhotonBlendColor

---@alias PhotonBoneLightActivity
---| '"Rotate"' # Continuously rotates in one direction.
---| '"Sweep"' # Rotates back and forth between the `Target` angle and `SweepTo` angle.
---| '"Fixed"' # Rotates to a specified `Target` angle and then freezes.
---| '"Spot"' # (TODO) Manually positioned by the player. Networked.
---| '"Off"' # Stops all motion and holds position.

---@class Photon2.Index
---@field Components PhotonLightingComponent[] Components index.
---@field Vehicles PhotonVehicle[] Vehicles index.
---@field Profiles Photon2.Index.Profiles

---@class Photon2.Index.Profiles
---@field Map {}
---@field Vehicles table<string, string>

---@class PhotonLibraryComponent
---@field Author string Component author's name.
---@field Base string Base component ID if inheriting from an existing component.
---@field Credits table<string, string>
---@field PrintName string
---@field Model string
---@field Templates { Bone?: table<string, PhotonElementBone>, Mesh?: table<string, PhotonElementMesh>, Sprite?: table<string, PhotonElement2D>, Projected?: table<string, PhotonElementProjected>,  }
---@field Lights table
---@field LightGroups table
---@field Segments table
---@field Inputs table
---@field ColorMap table<integer, string[]> | string
---@field SubMaterials table<integer, string>
---@field ElementStates { SubMat: table, Mesh: table } Light states.
---@field Phase string Pattern variant identifier.

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
---@field VirtualComponents table

---@class PhotonVehicleSelectionCategory
---@field Category string Category name.
---@field Options PhotonVehicleSelectionOption[]

---@class PhotonVehicleSelectionOption
---@field Option string Selection name.
---@field Variants? PhotonVehicleSelectionVariant[]


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

---@class PhotonClientInputEvents
---@field OnPress? table<PhotonClientInputAction>
---@field OnRelease? table<PhotonClientInputAction>
---@field OnHold? table<PhotonClientInputAction>

---@class PhotonClientInputCommand : PhotonClientInputEvents
---@field Name string Unique command name.
---@field Title string Title of the command.
---@field Description string Description of what the command does.

---@class PhotonClientInputAction
---@field Action string
---@field Value? string | table<string>
---@field Channel? string
---@field Modifiers? table<any>



---@class RGB
---@field r number Red
---@field g number Green
---@field b number Blue

---@class PixVisHandle


---@param filename string
function include(filename) end

---@param object any
---@return boolean
function istable( object ) end

---@class PhotonControllerSoundFile
---@field Sound string
---@field Volume? integer
---@field Duration? number
---@field Pitch? integer

---@class PhotonControllerSound
---@field Default PhotonControllerSoundFile
---@field Press? PhotonControllerSoundFile | boolean
---@field Momentary? PhotonControllerSoundFile | boolean
---@field Release? PhotonControllerSoundFile | boolean
---@field Hold? PhotonControllerSoundFile | boolean

---@class FontCreationData
---@field font string
---@field size number
---@field weight? number
---@field extended? boolean
---@field blursize? number
---@field scanlines? boolean
---@field underline? boolean
---@field italic? boolean
---@field strikeout? boolean
---@field rotary? boolean
---@field shadow? boolean
---@field additive? boolean
---@field outline? boolean