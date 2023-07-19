PHOTON2_UNSET = "<UNSET>"

include("sh_util.lua")
include("sh_functions.lua")
include("sh_component_builder.lua")
include("sh_sequence_builder.lua")
include("sh_schema.lua")


function PhotonColor( r, g, b, a )
	return _PhotonColor.New( r, g, b, a )
end


function LoadPhoton2MetaFiles()
	exmeta.LoadFile("photon-v2/meta/dynamic_material.lua")
	exmeta.LoadFile("photon-v2/meta/color.lua")

	exmeta.LoadFile("photon-v2/meta/light_color.lua")
	exmeta.LoadFile("photon-v2/meta/light_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_2d_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_sound_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_sub_state.lua")
	exmeta.LoadFile("photon-v2/meta/light_projected_state.lua")
	
	exmeta.LoadFile("photon-v2/meta/light.lua")
	exmeta.LoadFile("photon-v2/meta/light_2d.lua")
	exmeta.LoadFile("photon-v2/meta/light_sound.lua")
	exmeta.LoadFile("photon-v2/meta/light_projected.lua")

	exmeta.LoadFile("photon-v2/meta/light_sub.lua")

	exmeta.LoadFile("photon-v2/meta/light_mesh.lua")
	exmeta.LoadFile("photon-v2/meta/light_mesh_state.lua")

	exmeta.LoadFile("photon-v2/meta/base_entity.lua")

	exmeta.LoadFile("photon-v2/meta/component.lua")
	exmeta.LoadFile("photon-v2/meta/aural_component.lua")
	exmeta.LoadFile("photon-v2/meta/lighting_component.lua")
	exmeta.LoadFile("photon-v2/meta/lighting_segment.lua")
	exmeta.LoadFile("photon-v2/meta/sequence.lua")
	exmeta.LoadFile("photon-v2/meta/sequence_collection.lua")

	exmeta.LoadFile("photon-v2/meta/vehicle_equipment.lua")
	exmeta.LoadFile("photon-v2/meta/vehicle.lua")
end

LoadPhoton2MetaFiles()

if CLIENT then
	hook.Add("Initialize", "Photon2:Initialize", LoadPhoton2MetaFiles)
end
