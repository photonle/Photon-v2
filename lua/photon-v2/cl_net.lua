Photon2.cl_Network = Photon2.cl_Network or {
	ControllerQueue = {}
}

local info, warn = Photon2.Debug.Declare( "NET" )

local print = info
local printf = info

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
	Photon2.ClientInput.SetTargetController( net.ReadEntity() --[[@as PhotonController]] )
end
net.Receive( "Photon2:SetPlayerInputControllerTarget", Photon2.cl_Network.OnSetInputController )

function Photon2.cl_Network.OnNetworkVarChanged( ent, name, oldValue, newValue )
	-- printf("Network change for [%s]. Name: [%s]  Old: [%s]  New: [%s]", ent, name, oldValue, newValue )
	if ( not IsValid( ent ) ) then return end
	
	local isController = false
	local controller = ent

	if( IsValid( ent:GetPhotonController() ) ) then
		controller = ent:GetPhotonController()
		isController = true
	elseif ( ent:GetClass() == "photon_controller" ) then
		isController = true
	end

	if ( isController ) then
		
		if ( ( not IsValid( controller:GetParent() ) ) or ( not controller.IsPhotonController ) ) then
			-- This is to briefly keep change-notifications in a queue because 
			-- the values sometimes change before the controller is fully
			-- initialized on the client (no idea why).
			local queue = Photon2.cl_Network.ControllerQueue
			queue[controller] = queue[controller] or {
				Time = CurTime(),
				Channels = {},
			}
			-- printf("Queueing change for controller [%s]. Name: [%s]  Old: [%s]  New: [%s]", controller, name, oldValue, newValue )
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				queue[controller].Channels[name] = newValue
			elseif (name == "Photon2:ProfileName") then
				queue[controller].Profile = newValue
			elseif (name == "Photon2:Selections") then
				queue[controller].SelectionsString = newValue
			end
		else
			-- printf("NOT queing change for controller [%s]. Name: [%s]  Old: [%s]  New: [%s]", controller, name, oldValue, newValue )
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				controller:OnChannelModeChanged( name, newValue, oldValue )
			elseif (name == "Photon2:ProfileName") then
				controller:SetupProfile( newValue )
			elseif (name == "Photon2:Selections") then
				controller:ProcessSelectionsString( newValue )
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
	if ( IsValid( ent ) and ent:GetClass() == "photon_controller" ) then
		if ( not ent.IsPhotonController ) then return end
		if ( shouldTransmit ) then
			if ( ent.IsSuspended ) then
				if ( IsValid( ent:GetComponentParent() ) ) then 
					ent:OnResumed()
				end
			end
		else
			if ( not ent.IsSuspended ) then
				ent:OnSuspended()
			end
		end
	else
		local controller = ent:GetPhotonControllerFromAncestor()
		if ( IsValid( controller ) ) then
			if ( shouldTransmit ) then
				if ( controller.IsSuspended ) then
					if ( IsValid( ent ) and IsValid( controller:GetComponentParent() ) ) then
						controller:OnResumed()
					end
				end
			else
				if ( not controller.IsSuspended ) then
					controller:OnSuspended()
				end
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
