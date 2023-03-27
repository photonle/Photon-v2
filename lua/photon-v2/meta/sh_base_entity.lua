if (exmeta.ReloadFile("photon-v2/meta/sh_base_entity.lua")) then return end

NAME = "PhotonBaseEntity"
---@class PhotonBaseEntity : photon_entity
---@field Entity photon_entity
---@field Model string
---@field PhotonController PhotonController
local ENT = META


-- Connect component to corresponding entity and its controller.
---@param ent photon_entity
---@param controller PhotonController
---@return PhotonBaseEntity
function ENT:Initialize( ent, controller )
	---@type PhotonBaseEntity
	local photonEnt = {
		Entity = ent,
		PhotonController = controller
	}
	setmetatable( photonEnt, { __index = self } )
	debug.setmetatable( ent:GetTable(), { __index = photonEnt } )
	return ent --[[@as PhotonBaseEntity]]
end

function ENT:Setup()
	self:SetModel( self.Model )
	return self
end


---@param controller PhotonController
---@return PhotonBaseEntity
function ENT:CreateClientside( controller )
	local ent = self:Initialize( ents.CreateClientside( "photon_entity" ) --[[@as photon_entity]], controller )
	ent:Setup()
	return ent
end