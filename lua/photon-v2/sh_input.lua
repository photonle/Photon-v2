if SERVER then util.AddNetworkString("Photon2:PlayerKeyEvent") end

Photon2.PressedKeys = {}

local bitSize = 16

if CLIENT then
	net.Receive( "Photon2:PlayerKeyEvent", function()
		if ( net.ReadBit() == 1 ) then
			local key = net.ReadInt( bitSize )
			Photon2.PressedKeys[key] = true
			hook.Run( "Photon2:KeyPressed", key )
		else
			local key = net.ReadInt( bitSize )
			Photon2.PressedKeys[key] = nil
			hook.Run( "Photon2:KeyReleased", key )
		end
	end)
end

function Photon2.IsKeyDown( key )
	return ( Photon2.PressedKeys[key] == true )
end

hook.Add("PlayerButtonDown", "Photon2.Input:PlayerButtonDown", function( ply, button ) 
	if ( SERVER ) then
		if ( game.SinglePlayer() ) then
			net.Start("Photon2:PlayerKeyEvent")
				net.WriteBit( true )
				net.WriteInt( button, bitSize )
			net.Send( ply )
		end
	else
		Photon2.PressedKeys[button] = true
		hook.Run( "Photon2:KeyPressed", button )
	end
end)

hook.Add("PlayerButtonUp", "Photon2.Input:PlayerButtonUp", function( ply, button ) 
	if ( SERVER ) then
		if ( game.SinglePlayer() ) then
			net.Start("Photon2:PlayerKeyEvent")
			net.WriteBit( false )
			net.WriteInt( button, bitSize )
			net.Send( ply )
		end
	else
		Photon2.PressedKeys[button] = false
		hook.Run( "Photon2:KeyReleased", button )
	end
end)