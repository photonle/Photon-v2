include("shared.lua")

---@class cl_PhotonController : PhotonController
ENT = ENT

local print = Photon2.Debug.Print


local function addTestEquipment(self)
	---@type PhotonLightingComponent
	local component = Photon2.Index.Components["photon_fedsig_jetsolaris"]
	
	local ent = component:CreateClientside( self ) --[[@as PhotonLightingComponent]]

	-- local ent = PhotonBaseEntity

	ent:SetParent( self )
	ent:SetPos( self:LocalToWorld(Vector(0,0,100)))
	ent:Activate()
	self:ConnectComponent( ent )
	print("[PHOTON2] Component entity type is: " .. tostring(ent))
end


function ENT:Initialize()
	self:InitializeShared()

	-- addTestEquipment(self)
end


function ENT:ConnectComponent( ent )
	if not ent.IsPhotonEntity then 
		error( "[PHOTON2] Attempt to connect an entity to a Photon Controller that is not a Photon Component.") 
	end
	table.insert( self.Components, ent )
end


function ENT:RemoveAllComponents()
	for id, ent in pairs(self.Components) do
		if (IsValid(ent)) then
			ent:Remove()
		end
		self.Components[id] = nil
	end
end

---@param id string
function ENT:SetupComponent( id )
	local data = self.Equipment[id]
	if (not data) then
		print(string.format("Unable to locate equipment ID [%s]", id))
		return
	end
	print(string.format("Setting up component [%s]", id))
	if (data.Component) then
		---@type PhotonLightingComponent
		local component = Photon2.Index.Components[data.Component]
		local ent = component:CreateClientside( self ) --[[@as PhotonLightingComponent]]
		ent:SetMoveType( MOVETYPE_NONE )
		ent:SetParent( self:GetComponentParent() )
		ent:SetLocalPos( data.Position )
		ent:SetLocalAngles( data.Angles )
		if (IsValid(self.Components[id])) then
			self.Components[id]:Remove()
		end
		self.Components[id] = ent
	end	
end


function ENT:OnChannelStateChanged( channel, newState, oldState )
	oldState = oldState or "OFF"
	print("Controller channel state changed. " .. tostring(self) .. " (" .. channel .. ") '" .. oldState .."' => '" .. newState .. "'")

	for id, component in pairs(self.Components) do
		component:SetChannelState( channel, state )
	end
end


function ENT:SetupProfile( name )
	local profile = Photon2.Index.Vehicles[name]
	self:RemoveAllComponents()
	self.CurrentProfile = profile
	if not (profile) then
		print("Unable to locate vehicle profile [" .. tostring(name) .."].")
		return
	end
	print( string.format( "Setting up %s (%s)...", profile.Title, profile.ID ) )
	self.Equipment = profile.Equipment

	if (not profile.Configuration) then
		for id, equipment in pairs(self.Equipment) do
			self:SetupComponent( id )
		end
	end

end


local function NetworkedVarChanged( ent, name, oldValue, newValue )
	-- Must be delayed by a tick to ensure entity is properly
	-- initialized first. Unpredictable results otherwise.
	timer.Simple(0.01, function()
		if (IsValid(ent) and (ent.IsPhotonController)) then
			if (string.StartsWith(name,"Photon2:CS:")) then
				ent:OnChannelStateChanged( name, newValue, oldValue )
			elseif (name == "Photon2:ProfileName") then
				ent:SetupProfile( newValue )
			end
		end
	end)
	
end
hook.Add("EntityNetworkedVarChanged", "Photon2:PhotonController", NetworkedVarChanged)

function ENT:OnRemove()
	local components = {}
	for k, v in pairs(self.Components) do
		components[#components+1] = v
	end
	timer.Simple(0, function()
		if not IsValid( self ) then
			for i = 1, #components do
				if (IsValid(components[i])) then
					components[i]:Remove()
				end
			end
		else

		end
	end)
end