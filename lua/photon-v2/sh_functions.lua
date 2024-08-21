local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

function Photon2.CreateConVar( name, default, flags, help )
	if ( SERVER ) then
		return Photon2.CreateServerConVar( name, default, flags, help )
	end
	return CreateConVar( name, default, flags, help )
end

Photon2.CreateConVar( "ph2_engine_idle_enabled", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables or disables Photon 2's engine idling functionality.", 0, 1 )
Photon2.CreateConVar( "ph2_camera_swep_enabled", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables or disables Photon 2's special camera SWEP.", 0, 1 )
