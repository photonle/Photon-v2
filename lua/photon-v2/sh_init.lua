PHOTON2_UNSET = "<UNSET>"
PHOTON2_STUDIO_ENABLED = false

-- CAMI Integration (for Admin Mods) (https://github.com/glua/CAMI)
CAMI.RegisterPrivilege({
	Name = "Photon2.ServerSettings",
	MinAccess = "superadmin"
})

include("sh_util.lua")
include("sh_functions.lua")
include("sh_component_builder.lua")
include("sh_sequence_builder.lua")
include("sh_vcmod.lua")

local info, warn = Photon2.Debug.Declare("Init")

---@return PhotonColor
function PhotonColor( r, g, b, a )
	return _PhotonColor.New( r, g, b, a )
end

if ( game.SinglePlayer() ) then
	PHOTON2_STUDIO_ENABLED = true
end

file.CreateDir("photon_v2")
file.CreateDir("photon_v2/user")
file.CreateDir("photon_v2/library")

-- This is done manually because some files have dependencies on others
function LoadPhoton2MetaFiles()
	exmeta.LoadFile("photon-v2/meta/library_type.lua")

	exmeta.LoadFile("photon-v2/meta/material.lua")
	exmeta.LoadFile("photon-v2/meta/blend_color.lua")
	exmeta.LoadFile("photon-v2/meta/color.lua")

	exmeta.LoadFile("photon-v2/meta/light_color.lua")
	exmeta.LoadFile("photon-v2/meta/light_state.lua")
	exmeta.LoadFile("photon-v2/meta/element_virtual_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_2d_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_sound_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_sub_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_projected_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_bone_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_mesh_state.lua")
	exmeta.LoadFile("photon-v2/meta/element_dynamiclight_state.lua")
	exmeta.LoadFile("photon-v2/meta/element_sequence_state.lua")
	exmeta.LoadFile("photon-v2/meta/element_pose_state.lua")
	
	exmeta.LoadFile("photon-v2/meta/light.lua")
	exmeta.LoadFile("photon-v2/meta/element_virtual.lua")
	exmeta.LoadFile("photon-v2/meta/light_2d.lua")
	exmeta.LoadFile("photon-v2/meta/light_sound.lua")
	exmeta.LoadFile("photon-v2/meta/light_projected.lua")
	exmeta.LoadFile("photon-v2/meta/light_bone.lua")
	exmeta.LoadFile("photon-v2/meta/light_mesh.lua")
	exmeta.LoadFile("photon-v2/meta/element_dynamiclight.lua")
	exmeta.LoadFile("photon-v2/meta/element_sequence.lua")
	exmeta.LoadFile("photon-v2/meta/element_pose.lua")

	exmeta.LoadFile("photon-v2/meta/light_sub.lua")

	exmeta.LoadFile("photon-v2/meta/light_mesh.lua")
	exmeta.LoadFile("photon-v2/meta/light_mesh_state.lua")

	exmeta.LoadFile("photon-v2/meta/base_entity.lua")

	exmeta.LoadFile("photon-v2/meta/lighting_component.lua")
	exmeta.LoadFile("photon-v2/meta/lighting_segment.lua")
	exmeta.LoadFile("photon-v2/meta/sequence.lua")
	exmeta.LoadFile("photon-v2/meta/sequence_collection.lua")
	exmeta.LoadFile("photon-v2/meta/siren_component.lua")

	exmeta.LoadFile("photon-v2/meta/vehicle_equipment.lua")
	exmeta.LoadFile("photon-v2/meta/vehicle.lua")
end

if SERVER then LoadPhoton2MetaFiles() end

if CLIENT then
	hook.Add("Initialize", "Photon2:Initialize", LoadPhoton2MetaFiles)
end

--[[
	Essential Global Functions
--]]

-- Prevents a table from inheriting any of its values
function Photon2.NoInherit( tbl )
	tbl["__no_inherit"] = true
	return tbl
end