Photon2.sv_Network = {}

util.AddNetworkString( "Photon2:SetControllerChannelState" )

function Photon2.sv_Network.OnSetControllerChannelState(len, ply)
    local controller = net.ReadEntity()
    local channel = net.ReadString()
    local state = net.ReadString()
end

net.Receive( "Photon2:SetControllerChannelState", Photon2.sv_Network.OnSetControllerChannelState)
