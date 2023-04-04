Photon2.cl_Network = {}
Photon2.Debug.Print("cl_net.lua")

function Photon2.cl_Network.SetControllerChannelState(controller, channel, state)
    net.Start("Photon2:SetControllerChannelState")
        net.WriteEntity( controller )
        net.WriteString( channel )
        net.WriteString( state )
    net.SendToServer()
end

function Photon2.cl_Network.SetControllerSelection( controller, table )
	net.Start("Photon2:SetControllerSelection")
		net.WriteEntity( controller )
		net.WriteTable( table )
	net.SendToServer()
end