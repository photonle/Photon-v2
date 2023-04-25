if (exmeta.ReloadFile()) then return end

NAME = "PhotonBaseEntity"
---@class PhotonBaseEntity : photon_entity
---@field Entity Entity
---@field IsVirtual boolean
---@field Model string
---@field PhotonController PhotonController
local ENT = exmeta.New()

local print = Photon2.Debug.PrintF

ENT.DefaultInputPriorities = {
	["Emergency.Cut"] 				= 140,
	["Emergency.Illuminate"]		= 130,
	["Emergency.SceneForward"] 		= 120,
	["Emergency.SceneLeft"] 		= 120,
	["Emergency.SceneRight"] 		= 120,
	["Vehicle.Signal"] 				= 110,
	["Vehicle.Brake"] 				= 100,
	["Vehicle.Reverse"] 			= 90,
	["Emergency.Directional"] 		= 80,
	["Emergency.Auxiliary"] 		= 70,
	["Emergency.Marker"] 			= 60,
	["Emergency.Siren2Override"] 	= 51,
	["Emergency.SirenOverride"]		= 50,
	["Emergency.Siren2"] 			= 40,
	["Emergency.Warning"] 			= 30,
	["Vehicle.HighBeams"]			= 20,
	["Vehicle.Lights"]	 			= 10
}


-- Connect component to corresponding entity and its controller.
---@param ent Entity
---@param controller PhotonController
---@return PhotonBaseEntity
function ENT:Initialize( ent, controller )
	---@type PhotonBaseEntity
	local photonEnt = {
		Entity = ent,
		PhotonController = controller
	}
	setmetatable( photonEnt, { __index = self } )
	
	if ( ent:GetClass() == "photon_entity" ) then
		debug.setmetatable( ent:GetTable(), { __index = photonEnt } )
	else
		photonEnt.IsVirtual = true
		-- local virtualEnt = setmetatable( {
		-- 	IsVirtual = true
		-- }, {
		-- 	__index = ent:GetTable()
		-- 	-- __index = function( tbl, key )
		-- 	-- 	if (ent[key] ) then return ent[key] end
		-- 	-- 	return photonEnt[key]
		-- 	-- end,
		-- })
		ent = photonEnt
	end
	
	photonEnt.CurrentModes = controller.CurrentModes

	return ent --[[@as PhotonBaseEntity]]
end

function ENT:Setup()
	if ( not self.IsVirtual ) then
		self.Entity:SetModel( self.Model )
	end
	return self
end


---@param controller PhotonController
---@return PhotonBaseEntity
function ENT:CreateClientside( controller )
	local ent = self:Initialize( ents.CreateClientside( "photon_entity" ) --[[@as photon_entity]], controller )
	ent:Setup()
	return ent
end

-- Creates a component on an existing entity (clientside).
---@param ent Entity
---@param controller PhotonController
function ENT:CreateOn( ent, controller )
	local ent = self:Initialize( ent, controller )
	return ent
end

function ENT:SetScale( scale )
	if ( isnumber( scale ) ) then
		self.Entity:SetModelScale( scale, 0 )
		self.Entity:DisableMatrix( "RenderMultiply" )
	elseif ( isvector( scale ) ) then
		self.Entity:SetModelScale( 1 )
		local matrix = Matrix()
		matrix:Scale( scale )
		self.Entity:EnableMatrix( "RenderMultiply", matrix )
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
	if ( self.IsVirtual ) then return end
	local map = self.PropertyFunctionMap
	-- Auto-apply supported properties
	for property, value in pairs( equipment ) do
		if ((map[property] ~= nil) and ((not isSoftUpdate) or (self.PropertiesUpdatedOnSoftUpdate[property]))) then
			self:SetProperty( property, value )
		end
	end
end

function ENT:Remove()
	if ( not self.IsVirtual ) then
		self.Entity:Remove()
	end
end