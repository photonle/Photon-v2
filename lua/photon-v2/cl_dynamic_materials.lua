Photon2.DynamicMaterials = Photon2.DynamicMaterials or {
	Index = {},
	Queue = {},
	Ready = false
}

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local Materials = Photon2.DynamicMaterials

function Materials.ProcessQueue()
	hook.Remove( "HUDPaint", "Photon2:MaterialsInit" )
	for id, material in pairs( Materials.Queue ) do
		printf( "Processing material [%s] from queue.", id )
		Materials.Index[id] = PhotonDynamicMaterial.CreateNow( id, material )
		Materials.Queue[id] = nil
	end
	Photon2.DynamicMaterials.Ready = true
end

hook.Add( "HUDPaint", "Photon2:DynamnicMaterialsInit", Photon2.DynamicMaterials.ProcessQueue )
hook.Run( "Photon2:ClientMaterialsLoaded" )