---@meta

---@class PhotonInputConfigurationBind
---@field Command string Command name. Example: `toggle_warning_lights`
---@field Modifiers? KEY Modifier keys.

---@class PhotonInputConfigurationProperties
---@field Name string Unique configuration name. Example: `my_input_config`
---@field Title string Readable display name. Example: `My Input Configuration`
---@field Author string Author of the input configuration. Example: `Schmal`
---@field Inherit? string Name of a configuration to inherit from. Example: `default`
---@field Binds table<KEY, PhotonInputConfigurationBind[]>

---@class PhotonInputConfiguration : PhotonInputConfigurationProperties, PhotonLibraryObject