include("shared.lua")

---@class cl_PhotonController : PhotonController
ENT = ENT

local print = Photon2.Debug.Print


function ENT:Initialize()
	self:InitializeShared()

	-- addTestEquipment(self)
end


-- function ENT:SetupComponent( id )
-- 	local data = self.Equipment[id]
-- 	if (not data) then
-- 		print(string.format("Unable to locate equipment ID [%s]", id))
-- 		return
-- 	end
-- 	print(string.format("Setting up component [%s]", id))
-- 	if (data.Component) then
-- 		---@type PhotonLightingComponent
-- 		local component = Photon2.Index.Components[data.Component]
-- 		local ent = component:CreateClientside( self ) --[[@as PhotonLightingComponent]]
-- 		ent:SetMoveType( MOVETYPE_NONE )
-- 		ent:SetParent( self:GetComponentParent() )
-- 		component:SetPropertiesFromEquipment( data )
-- 		if (IsValid(self.Components[id])) then
-- 			self.Components[id]:Remove()
-- 		end
-- 		self.Components[id] = ent
-- 	end	
-- end

local function NetworkedVarChanged( ent, name, oldValue, newValue )
	-- Must be delayed by a tick to ensure entity is properly
	-- initialized first. Unpredictable results otherwise.
	timer.Simple(0.01, function()
		if (IsValid(ent) and (ent.IsPhotonController)) then
			if (string.StartsWith(name,"Photon2:CS:")) then
				name = string.sub( name, 12 )
				ent:OnChannelModeChanged( name, newValue, oldValue )
			elseif (name == "Photon2:ProfileName") then
				ent:SetupProfile( newValue )
			end
		end
	end)
	
end
hook.Add("EntityNetworkedVarChanged", "Photon2:PhotonController", NetworkedVarChanged)
