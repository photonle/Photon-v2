-- VCMod compatability functions

-- If VCMod appears to be installed
Photon2.IsVCModInstalled = true
-- Photon2.IsVCModInstalled = not ( VC_AU_Ver == nil )

Photon2.VCMod = Photon2.VCMod or {}

function Photon2.VCMod.OnSwitchSeats( player, entFrom, entTo )
	-- Disables seat switching to prevent conflict with siren keys
	if ( entFrom:IsVehicle() and IsValid( entFrom:GetPhotonController() ) ) then
		return false
	end
end
hook.Add( "VC_canSwitchSeat", "VC_canSwitchSeat", Photon2.VCMod.OnSwitchSeats )