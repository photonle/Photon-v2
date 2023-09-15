include("sh_init.lua")
include("cl_mesh_cache.lua")
include("cl_convars.lua")
include("cl_net.lua")
include("cl_render.lua")
include("cl_dynamic_materials.lua")
include("cl_material.lua")

LoadPhoton2MetaFiles()

include("cl_ui.lua")
include("cl_ui_skin.lua")
include("sh_component_builder.lua")
include("cl_render_light_projected.lua")
include("cl_render_light_2d.lua")
include("cl_render_light_mesh.lua")
include("cl_render_light_bone.lua")
include("cl_render_bloom.lua")
include("sh_input.lua")
include("cl_input.lua")

include("sh_ent_meta.lua")
include("sh_library.lua")
include("sh_index.lua")

if CLIENT then
	hook.Add("Initialize", "Photon2:Initialize", LoadPhoton2MetaFiles)
end
