include("shared.lua")

local function addTestEquipment(self)
	local ent = ents.CreateClientside("photon_component")
	ent:Activate()
	ent:SetParent( self )
	ent:SetModel("models/schmal/fedsig_valor/valor_lightbar.mdl")
	ent:SetPos( self:LocalToWorld(Vector(0,0,100)))
	self:ConnectComponent( ent )
	print("[PHOTON2] Component entity type is: " .. tostring(ent))
end

function ENT:Initialize()
	self.cl_Components = {}
	addTestEquipment(self)
end

function ENT:ConnectComponent( ent )
	if not ent.IsPhotonComponent then 
		error( "[PHOTON2] Attempt to connect an entity to a Photon Controller that is not a Photon Component.") 
	end
	table.insert( self.cl_Components, ent )
end

function ENT:OnChannelStateChanged( channel, newState, oldState )
	oldState = oldState or "OFF"
	Photon2.Debug.Print("Controller channel state changed. " .. tostring(self) .. " (" .. channel .. ") '" .. oldState .."' => '" .. newState .. "'")

	for id, component in pairs(self.cl_Components) do
		component:SetChannelState( channel, state )
	end
end

function ENT.ChannelStateChanged( ent, name, oldValue, newValue )
	if (ent.IsPhotonController and string.StartsWith(name,"Photon2:CS:")) then
		ent:OnChannelStateChanged( name, newValue, oldValue )
	end
end
hook.Add("EntityNetworkedVarChanged", "Photon2:PhotonController", ENT.ChannelStateChanged)