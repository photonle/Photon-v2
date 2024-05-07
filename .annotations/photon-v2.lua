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

---@type PhotonElementPose
PhotonElementPose = PhotonElementPose

---@type PhotonElementPoseState
PhotonElementPoseState = PhotonElementPoseState

---@type PhotonBlendColor
PhotonBlendColor = PhotonBlendColor

---@type PhotonLibraryType
PhotonLibraryType = PhotonLibraryType

---@type PhotonMaterial
PhotonMaterial = PhotonMaterial

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

---@class PhotonEquipmentLibraryComponentProperties
---@field StateMap table<integer, string[]> | string
---@field Phase string|number Pattern variant identifier.
---@field Segments table<string, PhotonLibraryComponentSegment>
---@field ElementGroups table<string, table<number>>
---@field ElementStates { SubMat: table, Mesh: table } Light states.
---@field States table<integer, string> Pre-defined state slots.
---@field RenderGroup RENDERGROUP
---@field BodyGroups table
---@field Inputs table
---@field Color Color Component's model color override.
---@field Flags PhotonLibraryComponentFlags

---@class PhotonLibraryComponent : PhotonEquipmentLibraryComponentProperties
---@field Name? string Component name (may be overwritten by filename).
---@field Author string Component author's name.
---@field Base string Base component ID if inheriting from an existing component.
---@field Credits table<string, string>
---@field Class string
---@field Category string
---@field Title string
---@field Model string
---@field Templates PhotonLibraryComponentTemplates
---@field Elements table<number, PhotonElement2DEntry | PhotonElementBoneEntry | PhotonElementMeshEntry | PhotonElementProjectedEntry | PhotonElementSoundEntry | PhotonElementDynamicEntry | PhotonElementSubEntry | PhotonElementSequenceEntry | PhotonElementPoseEntry | PhotonElementVirtualEntry >
---@field InputPriorities table<string, number>
---@field VirtualOutputs table
---@field SubMaterials table<integer, string>
---@field Patterns table<string, table[]> Collections of segments and sequences that can be referenced in COMPONENT.Inputs. (See: https://github.com/photonle/Photon-v2/wiki/Components#patterns) 

---@class PhotonLibraryComponentFlags
---@field AutomaticHeadlights? boolean Injects component code to setup automatic headlight on/off behavior.

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
---@field Off? string Off state that should be used for elements in this segment. (Note: this has no effect when frame [0] is manually defined.)
---@field FrameDuration? number Overrides the default duration of each frame. (In seconds.)
---@field Frames table<number, string | table> Individual frames that can be used in sequences.
---@field Sequences table<string, table<integer, integer>> One or more frames that, together, make up a sequence.

---@class PhotonLibraryVehicle
---@field Name string (Internal) Overwritten by the filename. Cannot be set by user.
---@field Vehicle string The original vehicle name this is based on (e.g. "20fpiu_new_sgm").
---@field Title string The printed name of the vehicle.
---@field Category string The default spawn category of the vehicle.
---@field Author string The author of this _Photon_ vehicle profile.
---@field IsEquipmentConfigurable boolean (Internal) Whether the equipment is user-configurable or static. This is determined automatically by the `.Equipment {}` table structure.
---@field EquipmentSelections PhotonVehicleSelectionCategory[] Mirror of .Equipment 
---@field Equipment PhotonVehicleSelectionCategory[]
---@field Siren table<number, table<string, string> | string> Defines the siren(s) the vehicle should use by default. You may use a complete siren-set or select tones individually from other existing sets and re-map them. If you need more customization, you should create a new siren with `Photon2.RegisterSiren(...)` and use the name of it instead.
---@field Schema table<string, table<table>>
---@field Default? boolean If true, the profile will be used by default on the base vehicle and any other non-Photon 2 vehicles of the same class and model.
---@field Livery? string Static material to apply as the vehicle's livery.
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
-- Photon Components.
---@field Components? PhotonEquipmentComponentEntry[]
-- Decorative props.
---@field Props? PhotonEquipmentPropEntry[]
-- Body groups.
---@field BodyGroups? PhotonEquipmentBodyGroupEntry[]
-- Sub materials.
---@field SubMaterials? PhotonEquipmentSubMaterialEntry[]
-- User HUD sounds (i.e. beeps and clicks).
---@field InteractionSounds? PhotonEquipmentInteractionSoundEntry[]
---@field Properties? table
---@field Bones? table<string, table>



---@class PhotonVehicleSelectionCategory
---@field Category string Category name.
---@field Visible? boolean If category should be visible in menu.
---@field Options PhotonVehicleSelectionOption[]

---@class PhotonVehicleSelectionOption : PhotonEquipmentTable
---@field Option string Selection name.
---@field Variants? PhotonVehicleSelectionVariant[]

---@class PhotonVehicleSelectionVariant
---@field Variant string
---@field Variants? PhotonEquipmentTable[]

---@class PhotonEquipmentPositional

---@class PhotonEquipmentEntityProperties : PhotonEquipmentEntryProperties
---@field Position Vector Local position.
---@field Angles Angle Local angles.
---@field Scale? number Entity scale.
---@field SubMaterials? table<integer | string, string>
---@field BodyGroups? table<string, integer | string>
---@field PoseParameters? table<string, number>
---@field Parent? string 
---@field Color? Color Entity model's color override.

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

---@class PhotonEquipmentEntryProperties
---@field Name? string Unique equipment entry name. Only required if you want other entries to inherit from it.
---@field Inherit? string Name of an equipment entry to inherit from.

---@class PhotonEquipmentComponentEntry : PhotonEquipmentEntityProperties, PhotonEquipmentLibraryComponentProperties

---@class PhotonEquipmentPropEntry : PhotonEquipmentEntityProperties
---@field Model? string Model path. (e.g. `models/my/props/model.mdl`)

---@class PhotonEquipmentBodyGroupEntry : PhotonEquipmentEntryProperties
---@field BodyGroup string | integer Body group name or index.
---@field Value string | integer Body group option name or index.

---@class PhotonEquipmentSubMaterialEntry : PhotonEquipmentEntityProperties
---@field Id string | integer Sub-material name or index to override.
---@field Material string Material to apply.

---@class PhotonEquipmentInteractionSoundEntry : PhotonEquipmentEntryProperties
---@field Class "Controller" | "Click" | string Sound type.
---@field Profile "whelen_cencom" | "code3_z3s" | "fedsig" | "sos_nergy" | string Sound profile name.

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


---@class PhotonElementProperties
---@field DeactivationState? string Deactivation state. This state is applied when the light has no more inputs. NOTE: If another state from a different input is set, the light will NOT deactivate.

---@class PhotonElementPropertiesIntensityTransitions
---@field IntensityTransitions? boolean If intensity transtions should be enabled.
---@field IntensityGainFactor? number How quickly intensity increases.
---@field IntensityLossFactor? number How quickly intensity decreases.
---@field Intensity? number State intensity.

-- Creates a new Photon 2 component table.
---@return PhotonLibraryComponent
function Photon2.LibraryComponent() end

-- Registers a table as a new Photon 2 component.
---@param component PhotonLibraryComponent
function Photon2.RegisterComponent( component ) end

---@return PhotonLibraryVehicle
function Photon2.LibraryVehicle() end

function isfunction( func )
	if ( func ~= nil ) then return true end
	return false
end