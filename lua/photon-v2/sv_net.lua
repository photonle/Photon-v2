Photon2.sv_Network = {}

local printf = Photon2.Debug.PrintF

util.AddNetworkString( "Photon2:SetControllerChannelState" )
util.AddNetworkString( "Photon2:SetControllerSelection" )

function Photon2.sv_Network.OnSetControllerChannelState(len, ply)
    local controller = net.ReadEntity()
    local channel = net.ReadString()
    local state = net.ReadString()
end
net.Receive( "Photon2:SetControllerChannelState", Photon2.sv_Network.OnSetControllerChannelState )

function Photon2.sv_Network.OnControllerSelectionChange( len, ply )
    local controller = net.ReadEntity() --[[@as sv_PhotonController]]
	local selections = net.ReadTable()
	
	printf("Receiving a selection change request for Controller (%s)", controller)

	if (not IsValid(controller)) then 
		return
	end

	PrintTable( selections )

	for i, selection in ipairs( selections ) do
		controller:SetSelectionOption( selection[1], selection[2] )
	end

end
net.Receive( "Photon2:SetControllerSelection", Photon2.sv_Network.OnControllerSelectionChange )