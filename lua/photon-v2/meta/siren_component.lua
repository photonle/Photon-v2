if (exmeta.ReloadFile()) then return end

NAME = "PhotonSirenComponent"
BASE = "PhotonLightingComponent"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonSirenComponent : PhotonLightingComponent

local Component = exmeta.New()

---@param ent photon_entity
---@param controller PhotonController
---@return PhotonLightingComponent
function Component:Initialize( ent, controller )
	-- Calls the base constructor but passes LightingComponent as "self"
	-- so LightingComponent is what's actually used for the metatable,
	-- not PhotonBaseEntity.
	local component = PhotonBaseEntity.Initialize( self, ent, controller ) --[[@as PhotonLightingComponent]]

	if ( self.UseControllerModes ) then
		component.CurrentModes = controller.CurrentModes
	else
		component.CurrentModes = table.Copy( controller.CurrentModes )
	end

	component.Elements = {}
	component.Segments = {}
	component.ActiveSequences = {}

	-- Process light table
	for key, light in pairs(self.Elements) do
		component.Elements[key] = light:Initialize( key, component )
	end

	-- Process segments
	for name, segment in pairs(self.Segments) do
		component.Segments[name] = segment:Initialize( component )
	end

	return component
end