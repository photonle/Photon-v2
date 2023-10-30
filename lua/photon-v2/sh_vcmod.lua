Photon2.VCMod = Photon2.VCMod or {}

function Photon2.VCMod.OnSwitchSeats( player, entFrom, entTo )
	if ( entFrom:IsVehicle() and IsValid( entFrom:GetPhotonController() ) ) then
		return false
	end
	-- debug.Trace()
end
hook.Add( "VC_canSwitchSeat", "VC_canSwitchSeat", Photon2.VCMod.OnSwitchSeats )