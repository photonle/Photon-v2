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

---@type PhotonLibraryType
PhotonLibraryType = PhotonLibraryType

---@alias PhotonBoneLightActivity
---| '"Rotate"' # Continuously rotates in one direction.
---| '"Sweep"' # Rotates back and forth between the `Target` angle and `SweepTo` angle.
---| '"Fixed"' # Rotates to a specified `Target` angle and then freezes.
---| '"Spot"' # (TODO) Manually positioned by the player. Networked.
---| '"Off"' # Stops all motion and holds position.

-- -@class Photon2.Index
-- -@field Components PhotonLightingComponent[] Components index.
-- -@field Vehicles PhotonVehicle[] Vehicles index.
-- -@field Profiles Photon2.Index.Profiles 
-- -@field Sirens table<string, PhotonSiren>
-- -@field Tones table<string, table>

---@class PhotonProfileSchema: table<string, table>

---@alias PhotonLibrarySource
---| '"Lua"' Object generated from Lua file.
---| '"Static"' Object generated from data_static folder.
---| '"Data"' Object generated from data folder. Editable in game.

---@class Photon2.Index.Profiles
---@field Map {}
---@field Vehicles table<string, string>
---@field Sirens table<string, PhotonSiren>

---@class PhotonLibraryObject
---@field LibrarySource PhotonLibrarySource (Internal) `nil` should be assumed as "Lua"

---@class PhotonLibraryComponent
---@field Author string Component author's name.
---@field Base string Base component ID if inheriting from an existing component.
---@field Credits table<string, string>
---@field Class string
---@field Category string
---@field PrintName string
---@field Model string
---@field Templates PhotonLibraryComponentTemplates
---@field Elements table<number, PhotonElement2DEntry | PhotonElementBoneEntry | PhotonElementMeshEntry | PhotonElementProjectedEntry | PhotonElementSoundEntry | PhotonElementDynamicEntry | PhotonElementSubEntry | PhotonElementSequenceEntry | PhotonElementVirtualEntry >
---@field ElementGroups table<string, table<number>>
---@field Segments table<string, PhotonLibraryComponentSegment>
---@field Inputs table
---@field InputPriorities table<string, number>
---@field VirtualOutputs table
---@field StateMap table<integer, string[]> | string
---@field SubMaterials table<integer, string>
---@field ElementStates { SubMat: table, Mesh: table } Light states.
---@field Phase string Pattern variant identifier.
---@field States table<integer, string> Pre-defined state slots.

---@class PhotonLibraryComponentTemplates
---@field ["2D"]? table<string, PhotonElement2DProperties> 2D sprite-based light.
---@field Bone? table<string, PhotonElementBoneProperties> Bone manipulation.
---@field Mesh? table<string, PhotonElementMeshProperties> 3D mesh-based light.
---@field Projected? table<string, PhotonElementProjectedProperties> Projected texture lighting.
---@field Sound? table<string, PhotonElementSoundProperties> Sound.
---@field DynamicLight? table<string, PhotonElementDynamicLightProperties> Dynamic lighting.
---@field Sub? table<string, PhotonElementSubProperties> Sub-material.
---@field Sequence? table<string, PhotonElementSequenceProperties> Model sequence.
---@field Virtual? table<string, PhotonElementVirtualProperties> Virtual element (for UI components).

---@class PhotonLibrarySirenComponent : PhotonLibraryComponent
---@field Siren string Default siren name.

---@class PhotonLibraryComponentSegment
---@field Frames table<number, string | table>
---@field Sequences table<string, table<integer, integer>>

---@class PhotonLibraryVehicle
---@field ID string (Internal) Overwritten by the filename. Cannot be set by user.
---@field Vehicle string The original vehicle name this is based on (e.g. "20fpiu_new_sgm").
---@field Title string The printed name of the vehicle.
---@field Category string The default spawn category of the vehicle.
---@field Author string The author of this _Photon_ vehicle profile.
---@field IsEquipmentConfigurable boolean (Internal) Whether the equipment is user-configurable or static. This is determined automatically by the `.Equipment {}` table structure.
---@field EquipmentSelections PhotonVehicleSelectionCategory[] Mirror of .Equipment 
---@field Equipment PhotonVehicleSelectionCategory[]
---@field Siren table<number, table<string, string> | string> Defines the siren(s) the vehicle should use by default. You may use a complete siren-set or select tones individually from other existing sets and re-map them. If you need more customization, you should create a new siren with `Photon2.RegisterSiren(...)` and use the name of it instead.
---@field Schema table<string, table<table>>
-- ---@field Equipment PhotonVehicleEquipment[]

---@class PhotonLibrarySiren
---@field Name string Unique name of siren set entry.
---@field Make string Siren manufacturer.
---@field Model string Siren model.
---@field Variant? string Optional variant descriptor.
---@field Author string Creator of the siren entry.
---@field Tones table<string, PhotonSirenTone>

---@class PhotonSirenTone
---@field Label string Display name of the tone.
---@field Sound string Sound file of the tone.
---@field Icon string Optional tone icon name, if applicable.

---@class PhotonSiren : PhotonLibrarySiren

---@class PhotonEquipmentTable
---@field Components table<integer, PhotonEquipmentComponentEntry>
---@field Props table
---@field BodyGroups table
---@field SubMaterials table
---@field VirtualComponents table
---@field UIComponents table
---@field InteractionSounds table

---@class PhotonVehicleSelectionCategory
---@field Category string Category name.
---@field Options PhotonVehicleSelectionOption[]

---@class PhotonVehicleSelectionOption : PhotonEquipmentTable
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
---@field OnServer boolean -- NOT IMPLEMENTED! (Default = `false`) If true, the component will be spawned on the server instead of just clientside. Do not enable unless you know what you're doing.
---@field FollowBone string|integer Attaches to the specified parent bone and sets the positioning relative to the bone.

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

---@class PhotonEquipmentEntry
---@field Name string
---@field Inherit string

---@class PhotonEquipmentComponentEntry : PhotonEquipmentEntry, PhotonLibraryComponent



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

---@class PhotonElementPositionalProperties
---@field Position? Vector Local position of element (relative to parent entity or bone).
---@field Angles? Angle Local angles of element (relative to parent entity or bone).
---@field BoneParent? string|integer Parents light to bone.

---@class PhotonCommandAction
---@field Action string
---@field Channel? string Applicable channel.
---@field Value? string Value parameter.
---@field Sound? string Sound class (for use with "SOUND" action only).

---@class PhotonCommand
---@field Name string Unique command name. Example: `my_photon_command`
---@field Title string Readable title of command. Example: _"My Photon Command"_
---@field Category string Category of command.
---@field Description string Description of command.
---@field OnPress? PhotonCommandAction[] Actions executed when key is pressed.
---@field OnHold? PhotonCommandAction[] Actions executed after key is pressed and held.
---@field OnRelease? PhotonCommandAction[] Actions executed when key is released.
---@field ExtendedTitle? string (Internal) Set automatically.

---@class PhotonElementPropertiesIntensityTransitions
---@field IntensityTransitions? boolean If intensity transtions should be enabled.
---@field IntensityGainFactor? number How quickly intensity increases.
---@field IntensityLossFactor? number How quickly intensity decreases.
---@field Intensity? number State intensity.