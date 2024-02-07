Photon2.sv_Network = {}

local printf = Photon2.Debug.PrintF

util.AddNetworkString( "Photon2:SetControllerChannelState" )
util.AddNetworkString( "Photon2:SetControllerSelection" )
util.AddNetworkString( "Photon2:SetPlayerInputControllerTarget")
util.AddNetworkString( "Photon2:OnSubMaterialChange")

function Photon2.sv_Network.OnSetControllerChannelState(len, ply)
	local controller = net.ReadEntity() --[[@as sv_PhotonController]]
    local channel = net.ReadString()
    local mode = net.ReadString()

	-- TODO: implement permissions
	if ( IsValid(ply) ) then
		controller:SetChannelMode( channel, mode )
	end

end
net.Receive( "Photon2:SetControllerChannelState", Photon2.sv_Network.OnSetControllerChannelState )

function Photon2.sv_Network.OnControllerSelectionChange( len, ply )
    local controller = net.ReadEntity() --[[@as sv_PhotonController]]
	local selections = net.ReadTable()
	
	printf("Receiving a selection change request for Controller (%s)", controller)

	if (not IsValid(controller)) then 
		return
	end

	for i, selection in ipairs( selections ) do
		controller:SetSelectionOption( selection[1], selection[2] )
	end

end
net.Receive( "Photon2:SetControllerSelection", Photon2.sv_Network.OnControllerSelectionChange )

function Photon2.sv_Network.NotifyPlayerInputController( ply, controller )
	net.Start( "Photon2:SetPlayerInputControllerTarget" )
		net.WriteEntity( controller )
	net.Send( ply )
end

function Photon2.sv_Network.NotifySubMaterialChange( controller )
	net.Start( "Photon2:OnSubMaterialChange" )
		net.WriteEntity( controller )
	net.SendPVS( controller:GetParent():GetPos() )
end