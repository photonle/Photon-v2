include("sh_schema.lua")
Photon2.Debug.Print("-----------------------")
Photon2.Debug.Print("-----------------------")
Photon2.Debug.Print("-----------------------")
Photon2.Debug.Print("sh_init.lua")
Photon2.Debug.Print("-----------------------")
Photon2.Debug.Print("-----------------------")
Photon2.Debug.Print("-----------------------")

function LoadPhoton2MetaFiles()
	exmeta.LoadFile("photon_v2/meta/sh_light.lua")
	exmeta.LoadFile("photon_v2/meta/sh_light_2d.lua")

	exmeta.LoadFile("photon_v2/meta/sh_base_component.lua")

	exmeta.LoadFile("photon_v2/meta/sh_lighting_component.lua")
	exmeta.LoadFile("photon_v2/meta/sh_lighting_segment.lua")
	exmeta.LoadFile("photon_v2/meta/sh_sequence.lua")
	exmeta.LoadFile("photon_v2/meta/sh_sequence_collection.lua")

	exmeta.LoadFile("photon_v2/meta/sh_base_vehicle.lua")
end

LoadPhoton2MetaFiles()

if CLIENT then
	hook.Add("Initialize", "Photon2:Initialize", LoadPhoton2MetaFiles)
end
