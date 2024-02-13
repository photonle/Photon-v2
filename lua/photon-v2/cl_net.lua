Photon2.cl_Network = Photon2.cl_Network or {
	ControllerQueue = {}
}

local print = Photon2.Debug.PrintF
local printf = Photon2.Debug.PrintF

---@param controller PhotonController
---@param channel string
---@param state string
function Photon2.cl_Network.SetControllerChannelState( controller, channel, state )
    if ( not state ) then return end
	-- printf("Requesting a mode change [%s]. Channel: [%s]  Mode: [%s]", controller, channel, state )
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

function Photon2.cl_Network.OnNetworkVarChanged( ent, name, oldValue, newValue )
	if ( not IsValid( ent ) ) then return end
	if ( ent:GetClass() == "photon_controller" ) then
		
		if ( not ent.IsPhotonController ) then
			-- This is to briefly keep change-notifications in a queue because 
			-- the values sometimes change before the controller is fully
			-- initialized on the client (no idea why).
			local queue = Photon2.cl_Network.ControllerQueue
			queue[ent] = queue[ent] or {
				Time = CurTime(),
				Channels = {},
			}
			
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				queue[ent].Channels[name] = newValue
			elseif (name == "Photon2:ProfileName") then
				queue[ent].Profile = newValue
			elseif (name == "Photon2:Selections") then
				queue[ent].SelectionsString = newValue
			end
		else
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				ent:OnChannelModeChanged( name, newValue, oldValue )
			elseif (name == "Photon2:ProfileName") then
				ent:SetupProfile( newValue )
			elseif (name == "Photon2:Selections") then
				ent:ProcessSelectionsString( newValue )
			end
		end
	elseif ( ent:GetClass() == "prop_physics" ) then
		if ( name == "Photon2.SyncSubMaterials" ) then
			local controller = ent:GetPhotonControllerFromAncestor()
			if ( IsValid( controller ) ) then
				timer.Create("Photon2.RefreshSubMaterials:" .. tostring( ent:GetParent() ), 0.1, 1, function()
					if ( IsValid( ent ) and IsValid( controller ) ) then
						controller.SyncAttachedParentSubMaterials = true
						controller:RefreshParentSubMaterials()
					end
				end)
			end
		end
	end
end
hook.Add("EntityNetworkedVarChanged", "Photon2:OnNetworkVarChanged", Photon2.cl_Network.OnNetworkVarChanged)

function Photon2.cl_Network.OnUpdateTransmitState( ent, shouldTransmit )
	if ( ent:GetClass() == "photon_controller" ) then
		if ( not ent.IsPhotonController ) then return end
		if ( shouldTransmit ) then
			if ( ent.IsSuspended ) then
				ent:OnResumed()
			end
		else
			if ( not ent.IsSuspended ) then
				ent:OnSuspended()
			end
		end
	end

end
hook.Add( "NotifyShouldTransmit", "Photon2:NotifyShouldTransmit", Photon2.cl_Network.OnUpdateTransmitState )

function Photon2.cl_Network.OnSubMaterialChange( len )
	local ent = net.ReadEntity() --[[@as PhotonController]]
	if ( IsValid( ent ) and ( ent.IsPhotonController ) ) then
		ent:RefreshParentMaterialsOnNextFrame()
	end
end
net.Receive( "Photon2:OnSubMaterialChange", Photon2.cl_Network.OnSubMaterialChange )
