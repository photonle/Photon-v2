Photon2.Materials = Photon2.Materials or {
	---@type table<string, PhotonMaterial>
	Queue = {},
	---@type table<string, PhotonMaterial>
	Index = {},
	Ready = false
}

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

function Photon2.Materials.ProcessQueue()
	hook.Remove( "HUDPaint", "Photon2:MaterialsInit" )
	Photon2.Materials.Ready = true
	for name, material in pairs( Photon2.Materials.Queue ) do
		material:Generate()
	end
end

hook.Add( "HUDPaint", "Photon2:MaterialsInit", Photon2.Materials.ProcessQueue )
