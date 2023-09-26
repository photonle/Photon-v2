Photon2.DynamicMaterials = Photon2.DynamicMaterials or {
	Index = {},
	Queue = {},
	Ready = false
}

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local Materials = Photon2.DynamicMaterials

function Materials.ProcessQueue()
	hook.Remove( "HUDPaint", "Photon2:DynamnicMaterialsInit" )
	-- Game seems to crash upon starting a new session (retry)
	-- and the dumbass delay seems to resolve it
	for id, material in pairs( Materials.Queue ) do
		-- printf( "Processing material [%s] from queue.", id )
		Materials.Index[id] = PhotonDynamicMaterial.CreateNow( id, material )
		Materials.Queue[id] = nil
	end
	Photon2.DynamicMaterials.Ready = true
end

function Materials.LoadNextInQueue()
	hook.Remove( "HUDPaint", "Photon2:DynamnicMaterialsInit" )
	local mat = Materials.Queue[#Materials.Queue]
	local count = 0
	for id, material in pairs( Materials.Queue ) do
		-- printf( "Processing material [%s] from queue.", id )
		Materials.Index[id] = PhotonDynamicMaterial.CreateNow( id, material )
		Materials.Queue[id] = nil
		count = count + 1
		break
	end
	if (count > 0) then 
		timer.Simple( 0.1, Materials.LoadNextInQueue)
	else
		Photon2.DynamicMaterials.Ready = true
	end
end

hook.Add( "HUDPaint", "Photon2:DynamnicMaterialsInit", Photon2.DynamicMaterials.ProcessQueue )
hook.Run( "Photon2:ClientMaterialsLoaded" )