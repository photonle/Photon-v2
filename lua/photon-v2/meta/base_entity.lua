if (exmeta.ReloadFile()) then return end

NAME = "PhotonBaseEntity"
---@class PhotonBaseEntity : photon_entity
---@field Entity Entity
---@field IsVirtual boolean
---@field Model string
---@field PhotonController PhotonController
---@field BodyGroups table
---@field SubMaterials table
local ENT = exmeta.New()

local print = Photon2.Debug.PrintF

-- TODO: input without an input priority score silently fails
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
	["Vehicle.HighBeam"]			= 20,
	["Vehicle.Lights"]	 			= 10
}

ENT.SubMaterials = {}
ENT.BodyGroups = {}
ENT.PoseParameters = {}
ENT.Bones = {}

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
		self:SetupSubMaterials()
		self:SetupBodyGroups()
		self.Entity:SetupBones()
		self:SetupStaticBones()
	end
	return self
end

function ENT:UpdateAndApplySubMaterials( subMaterials )
	self.SubMaterials = subMaterials
	self:SetupSubMaterials()
end

function ENT:UpdateAndApplyBodyGroups( bodyGroups )
	self.BodyGroups = bodyGroups
	self:SetupBodyGroups()
end

function ENT:SetupSubMaterials()
	for index, subMaterial in pairs( self.SubMaterials ) do
		self.Entity:SetSubMaterial( index, subMaterial )
	end
end

function ENT:FindBodyGroupOptionByName( bodyGroup, name )
	if ( string.len(name) > 0 ) then name = name .. ".smd" end
	for index, subModel in pairs( self:GetBodyGroups()[bodyGroup+1].submodels ) do
		print("COMPARING [" .. tostring(name) .. "] to [" .. tostring(subModel) .. "]" )
		if ( name == subModel ) then return index end
	end
	ErrorNoHaltWithStack(string.format("Could not find body group option [%s] in body group index [%s] in model [%s]", name, bodyGroup, self:GetModel() ))
	PrintTable( self:GetBodyGroups() )
	return 0
end

function ENT:SetupBodyGroups()
	for bodyGroup, option in pairs( self.BodyGroups ) do
		if (isstring(bodyGroup)) then bodyGroup = self:FindBodygroupByName( bodyGroup ) end
		if (isstring(option)) then
			option = self:FindBodyGroupOptionByName( bodyGroup, option )
		end
		self:SetBodygroup( bodyGroup, option )
	end
end

function ENT:SetupPoseParameters()
	for param, value in pairs( self.PoseParameters ) do
		self:SetPoseParameter( param, value )
	end
end

function ENT:UpdateAndApplyPoseParameters( poseParameters )
	self.PoseParameters = poseParameters
	self:SetupPoseParameters()
end

function ENT:UpdateAndApplyStaticBoneData( boneData )
	self.Bones = boneData
	self:SetupStaticBones()
end

function ENT:SetupStaticBones()
	for boneName, data in pairs(self.Bones) do
		local boneId = boneName
		if ( isstring( boneId ) ) then
			boneId = self:LookupBone( boneName )
			if ( not boneId ) then
				ErrorNoHaltWithStack("Bone name [" .. tostring(boneName) .. "] does not exist in model [" .. tostring(self:GetModel() .. "]"))
				return
			end
		end
		if ( not istable( data ) ) then
			data = { data }
		end
		for i=1, #data do
			local var = data[i]
			if ( isvector( var ) ) then
				self:ManipulateBonePosition( boneId, var )
			elseif ( isangle( var ) ) then
				self:ManipulateBoneAngles( boneId, var )
			elseif ( isnumber( var ) ) then
				self:ManipulateBoneScale( boneId, Vector(var, var, var) )
			else
				error("Unable to manipulate bone [" .. boneName .. "] with parameter type [" .. type( var ) .. "] (" .. tostring( var ) .. "). Must be a Vector (position), Angle (angles), or number (scale)." )
			end
		end
	end
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
	local oldScale
	if ( isnumber( scale ) ) then
		oldScale = self.Entity:GetModelScale()
		self.Entity:SetModelScale( scale, 0 )
		self.Entity:DisableMatrix( "RenderMultiply" )
	elseif ( isvector( scale ) ) then
		self.Entity:SetModelScale( 1 )
		local matrix = Matrix()
		matrix:Scale( scale )
		self.Entity:EnableMatrix( "RenderMultiply", matrix )
	end
	if ( self.OnScaleChange ) then
		self:OnScaleChange( scale, oldScale )
	end
end

ENT.PropertyFunctionMap = {
	["Position"] = "SetLocalPos",
	["Angles"] = "SetLocalAngles",
	["Scale"] = "SetScale",
	["MoveType"] = "SetMoveType",
	["SubMaterials"] = "UpdateAndApplySubMaterials",
	["BodyGroups"] = "UpdateAndApplyBodyGroups",
	["PoseParameters"] = "UpdateAndApplyPoseParameters",
	["Bones"] = "UpdateAndApplyStaticBoneData"
}

ENT.PropertiesUpdatedOnSoftUpdate = {
	["Position"] = true,
	["Angles"] = true,
	["Scale"] = true,
	["SubMaterials"] = true,
	["BodyGroups"] = true,
	["PoseParameters"] = true,
	["Bones"] = true
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