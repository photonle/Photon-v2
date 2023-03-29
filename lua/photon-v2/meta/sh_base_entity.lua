if (exmeta.ReloadFile("photon-v2/meta/sh_base_entity.lua")) then return end

NAME = "PhotonBaseEntity"
---@class PhotonBaseEntity : photon_entity
---@field Entity photon_entity
---@field Model string
---@field PhotonController PhotonController
local ENT = META

local print = Photon2.Debug.PrintF

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

	self.CurrentModes = controller.CurrentModes

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

function ENT:SetScale( scale )
	if ( isnumber( scale ) ) then
		self:SetModelScale( scale, 0 )
		self:DisableMatrix( "RenderMultiply" )
	elseif ( isvector( scale ) ) then
		self:SetModelScale( 1 )
		local matrix = Matrix()
		matrix:Scale( scale )
		ent:EnableMatrix( "RenderMultiply", matrix )
	end
end

ENT.PropertyFunctionMap = {
	["Position"] = "SetLocalPos",
	["Angles"] = "SetLocalAngles",
	["Scale"] = "SetScale",
	["MoveType"] = "SetMoveType"
}

ENT.PropertiesUpdatedOnSoftUpdate = {
	["Position"] = true,
	["Angles"] = true,
	["Scale"] = true,
}


---@param property string
---@param value any
function ENT:SetProperty( property, value )
	if ( not self.PropertyFunctionMap[property] ) then
		error("Property [%s] cannot be set using PhotonEntity:SetProperty() and will need to manually be set instead.")
	end
	self[self.PropertyFunctionMap[property]]( self, value )
end


---@param equipment PhotonVehicleEquipment
---@param isSoftUpdate? boolean (Default = `false`)
function ENT:SetPropertiesFromEquipment( equipment, isSoftUpdate )
	local map = self.PropertyFunctionMap
	-- Auto-apply supported properties
	for property, value in pairs( equipment ) do
		if ((map[property] ~= nil) and ((not isSoftUpdate) or (self.PropertiesUpdatedOnSoftUpdate[property]))) then
			self:SetProperty( property, value )
		end
	end
end

function ENT:SetChannelMode( channel, new, old )
	print("Component received mode change notification for [%s]. ", channel)
	PrintTable( self.CurrentModes )
end