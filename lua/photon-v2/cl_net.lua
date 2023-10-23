Photon2.cl_Network = {}
Photon2.Debug.Print("cl_net.lua")

local print = Photon2.Debug.PrintF
local printf = Photon2.Debug.PrintF

---@param controller PhotonController
---@param channel string
---@param state string
function Photon2.cl_Network.SetControllerChannelState( controller, channel, state )
    if ( not state ) then return end
	printf("Requesting a mode change [%s]. Channel: [%s]  Mode: [%s]", controller, channel, state )
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

function Photon2.cl_Network.OnSetInputController( len )
	Photon2.ClientInput.SetTargetController( net.ReadEntity() )
end
net.Receive( "Photon2:SetPlayerInputControllerTarget", Photon2.cl_Network.OnSetInputController )