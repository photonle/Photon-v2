if (exmeta.ReloadFile()) then return end

NAME = "PhotonBaseEntity"
---@class PhotonBaseEntity : photon_entity
---@field Entity Entity
---@field IsVirtual? boolean
---@field UIMode? boolean
---@field Model? string
---@field PhotonController PhotonController
---@field BodyGroups? table
---@field SubMaterials? table
---@field RenderGroup? RENDERGROUP
---@field EquipmentData? table Data from this entity's coresponding equipment entry.
---@field IsParentPending? boolean If this entity is to be parented to another but hasn't been setup yet.
---@field UniqueId? number (Internal) Running index of created Photon entities.
local ENT = exmeta.New()

local print = Photon2.Debug.PrintF

ENT.DefaultInputPriorities = {
	["#DEBUG"]						= 9999,
	["Emergency.Cut"] 				= 170,
	["Emergency.Illuminate"]		= 160,
	["Emergency.SceneForward"] 		= 150,
	["Emergency.SceneLeft"] 		= 140,
	["Emergency.SceneRight"] 		= 130,
	["Vehicle.Signal"] 				= 120,
	["Vehicle.Brake"] 				= 110,
	["Vehicle.Engine"]				= 100,
	["Vehicle.Transmission"] 		= 90,
	["Emergency.Directional"] 		= 80,
	["Emergency.Auxiliary"] 		= 70,
	["Emergency.Siren2Override"] 	= 61,
	["Emergency.SirenOverride"]		= 60,
	["Emergency.Siren2"] 			= 51,
	["Emergency.Siren"] 			= 50,
	["Emergency.Warning"] 			= 40,
	["Emergency.Marker"] 			= 30,
	["Vehicle.HighBeam"]			= 20,
	["Vehicle.Lights"]	 			= 10,
	["Vehicle.Ambient"]				= 0,
}

ENT.SubMaterials = {}
ENT.BodyGroups = {}
ENT.PoseParameters = {}
ENT.Bones = {}

-- Parameters used when showing the entity
-- in a UI preview window.
ENT.Preview = {
	Position = Vector(),
	Angles = Angle( 0.00001, 0.00001, 0.00001 ),
	Zoom = 1
}

local photonUniqueEntId = 0

-- Connect component to corresponding entity and its controller.
---@param ent Entity
---@param controller PhotonController
---@param uiMode? boolean If the entity is intended to be rendered in a UI element.
---@return PhotonBaseEntity
function ENT:Initialize( ent, controller, uiMode )
	photonUniqueEntId = photonUniqueEntId + 1

	---@type PhotonBaseEntity
	local photonEnt = {
		Entity = ent,
		PhotonController = controller,
		UIMode = uiMode,
		UniqueId = photonUniqueEntId,
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
	
	if ( IsValid( controller ) ) then
		photonEnt.CurrentModes = controller.CurrentModes
	else
		photonEnt.CurrentModes = {}
	end

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

function ENT:FindSubMaterialByName( materialName )
	if ( not self._subMaterialMap ) then
		self._subMaterialMap = {}
		local materials = self:GetMaterials()
		-- PrintTable( materials )
		for i=1, #materials do
			self._subMaterialMap[materials[i]] = i - 1
		end
	end
	local result = self._subMaterialMap[ materialName ]
	if ( not result ) then
		ErrorNoHaltWithStack( "Sub-material [" .. tostring( materialName ) .. "] not found in model [" .. tostring( self:GetModel() ) .. "]")
	end
	return result
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
		if ( isstring( index ) ) then
			index = self:FindSubMaterialByName( index )
		end
		self.Entity:SetSubMaterial( index, subMaterial )
	end
end

function ENT:FindBodyGroupOptionByName( bodyGroup, name )
	if ( string.len(name) > 0 ) then name = name .. ".smd" end
	for index, subModel in pairs( self:GetBodyGroups()[bodyGroup+1].submodels ) do
		-- print("COMPARING [" .. tostring(name) .. "] to [" .. tostring(subModel) .. "]" )
		if ( name == subModel ) then return index end
	end
	ErrorNoHaltWithStack(string.format("Could not find body group option [%s] in body group index [%s] in model [%s]", name, bodyGroup, self:GetModel() ))
	-- PrintTable( self:GetBodyGroups() )
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
	
	-- TODO: better approach instead of polling
	if ( ( not IsValid( self:GetParent() ) ) and ( not self.IsVirtual ) ) or ( self.IsParentPending ) then
		local this = self
		timer.Simple( 0.001, function()
			if ( not IsValid( this ) ) then return end
			this:SetupStaticBones()
		end)
		return
	end

	local follow

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
		
		data.Position = data.Position or data[1] or Vector()
		data.Angles = data.Angles or data[2] or Angle()
		data.Scale = data.Scale or data[3] or Vector( 1, 1, 1 )
		if ( isnumber(data.Scale) ) then data.Scale = Vector( data.Scale --[[@as number]], data.Scale --[[@as number]], data.Scale --[[@as number]] ) end
		data.Follow = data.Follow or data[4] or false

		if ( not data.Follow ) then
			self:ManipulateBonePosition( boneId, data.Position )
			self:ManipulateBoneAngles( boneId, data.Angles )
			self:ManipulateBoneScale( boneId, data.Scale )
		end

		if ( data.Follow ) then
			follow = follow or {
				Parent = self:GetParent() or self
			}
			
			local parent = follow.Parent
			local type = false
			local target
			
			if ( data.Follow.Attachment ) then
				target = data.Follow.Attachment
				type = "Attachments"

				if ( not isnumber(target) ) then
					target = parent:LookupAttachment( target )
				end

				if ( target == 0 ) then
					ErrorNoHaltWithStack( "Attachment name '" .. data.Follow.Attachment .. "' could not be found (0) on parent model: " .. parent:GetModel() )
					type = false
				elseif ( target == -1 ) then
					ErrorNoHaltWithStack( "Attachment lookup resulted in an invalid model error (-1) on parent model: " .. parent:GetModel() )
					type = false
				end

			elseif ( data.Follow.Bone ) then
				target = data.Follow.Bone
				type = "Bones"

				if ( not isnumber(target) ) then
					target = parent:LookupBone( target )
				end

				if ( not target ) then
					ErrorNoHaltWithStack( "Bone name '" .. tostring(data.Follow.Bone) .. "' could not be found on parent model: " .. parent:GetModel() )
					type = false
				end
			end
			
			if ( type ) then
				follow[type] = follow[type] or {}
				follow[type][boneId] = {
					Target = tonumber( target ),
					Data = data
				}
			end
		end

		-- for i=1, #data do
		-- 	local var = data[i]
		-- 	if ( isvector( var ) ) then
		-- 		self:ManipulateBonePosition( boneId, var )
		-- 	elseif ( isangle( var ) ) then
		-- 		self:ManipulateBoneAngles( boneId, var )
		-- 	elseif ( isnumber( var ) ) then
		-- 		self:ManipulateBoneScale( boneId, Vector(var, var, var) )
		-- 	else
		-- 		error("Unable to manipulate bone [" .. boneName .. "] with parameter type [" .. type( var ) .. "] (" .. tostring( var ) .. "). Must be a Vector (position), Angle (angles), or number (scale)." )
		-- 	end
		-- end
	end

	self.MergedBones = follow

	if ( self.MergedBones ) then
		hook.Add( "Think", self, function()
			self:UpdateMergedBones()
		end)
	else
		hook.Remove( "Think", self )
	end
end

local vectorZero = Vector()
local angleZero	 = Angle()

-- TODO: current implementation assumes bone the position and angle are zero...
-- whether setting this via SetBonePosition works is untested
function ENT:UpdateMergedBones()
	if ( not self.MergedBones ) then return false end
	-- print("updating merged bones")
	local parent = self.MergedBones.Parent
	if ( not IsValid( parent ) ) then return false end
	if ( self.MergedBones.Bones ) then
		for boneId, data in pairs ( self.MergedBones.Bones ) do
			local boneMatrix = parent:GetBoneMatrix( boneId )
			local pos, ang = LocalToWorld( Vector( data.Data.Position ) * parent:GetModelScale(), data.Data.Angles, WorldToLocal( boneMatrix:GetTranslation(), boneMatrix:GetAngles(), self:GetPos(), self:GetAngles() ) )
			print("updating merged bones-bones")
			print(tostring(pos))
			print(tostring(ang))
			-- if ( boneId > 0 ) then
				self:SetBonePosition( boneId, vectorZero, angleZero )
				self:ManipulateBonePosition( boneId, pos )
				self:ManipulateBoneAngles( boneId, ang )
			-- else
			-- 	self:SetLocalPos( pos )
			-- 	self:SetLocalAngles( ang )
			-- end
		end
	end

	if ( self.MergedBones.Attachments ) then
		for boneId, data in pairs ( self.MergedBones.Attachments ) do
			local attachmentData = self.MergedBones.Parent:GetAttachment( data.Target )
			-- TODO: possible scaling problems
			local pos, ang = LocalToWorld( Vector(data.Data.Position) * parent:GetModelScale(), data.Data.Angles, WorldToLocal( attachmentData.Pos, attachmentData.Ang, self:GetPos(), self:GetAngles() ) )
			self:SetBonePosition( boneId, vectorZero, angleZero )
			-- self:SetupBones()
			self:ManipulateBonePosition( boneId, pos  )
			self:ManipulateBoneAngles( boneId, ang )
		end
	end
end

---@param controller PhotonController
---@return PhotonBaseEntity
function ENT:CreateClientside( controller )
	-- RenderGroup requires a hacky implementation because it can't be
	-- set after the entity is created.
	PHOTON2_ENTITY.RenderGroup = self.RenderGroup or nil
	local ent = self:Initialize( ents.CreateClientside( "photon_entity" ) --[[@as photon_entity]], controller )
	PHOTON2_ENTITY.RenderGroup = nil
	ent:Setup()
	hook.Run( "Photon2:EntityCreated", ent, controller )
	return ent
end

function ENT:CreateForUI()
	PHOTON2_ENTITY.RenderGroup = RENDERGROUP_OTHER
	local ent = self:Initialize( ents.CreateClientside( "photon_entity" ), nil, true )
	PHOTON2_ENTITY.RenderGroup = nil
	ent:SetNoDraw( true )
	ent:SetIK( false )
	ent:Setup()
	return ent
end

-- Creates a component on an existing entity (clientside).
---@param ent Entity
---@param controller PhotonController
function ENT:CreateOn( ent, controller )
	local ent = self:Initialize( ent, controller )
	hook.Run( "Photon2:VirtualEntityCreated", ent, controller )
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
	["Bones"] = "UpdateAndApplyStaticBoneData",
	["RenderMode"] = "SetRenderMode",
	["Color"] = "SetColor"
}

ENT.PropertiesUpdatedOnSoftUpdate = {
	["Position"] = true,
	["Angles"] = true,
	["Scale"] = true,
	["SubMaterials"] = true,
	["BodyGroups"] = true,
	["PoseParameters"] = true,
	["FollowBone"] = true,
	["Bones"] = true,
	["RenderMode"] = true,
	["Color"] = true
}

function ENT:FollowParentBone( bone )
	local boneId
	local parent = self:GetParent()
	if ( isstring( bone ) ) then 
		boneId = parent:LookupBone( bone )
	elseif ( isnumber( bone ) ) then
		boneId = bone
	end
	if ( not boneId ) then
		ErrorNoHaltWithStack( "Unable to find bone [" .. tostring( bone ) .. "] in " .. tostring( parent:GetModel() ) )
		return
	end
	
	self:SetParent( nil )
	self:FollowBone( parent, boneId )
	-- Ths is needed otherwise it stops following if one parent is frozen
	self:AddEffects( EF_PARENT_ANIMATES )
	self.FollowingBone = boneId
	-- self:SetPredictable( true )
	-- hook.Add( "Think", self, function()
	-- 	-- parent:SetupBones()
	-- 	-- self:SetupBones()
	-- 	-- local pos, ang = 
	-- 	-- self:ManipulateBonePosition( 0, parent:GetManipulateBonePosition(boneId) )
	-- 	-- self:ManipulateBoneAngles( 0, parent:GetManipulateBoneAngles(boneId) )
	-- 	-- print( "Manipulate: " .. tostring( parent:GetManipulateBoneAngles(boneId)))
	-- 	-- print( "Matrix: " .. tostring( parent:GetBoneMatrix(boneId):GetAngles()))

	-- end)
end

---@param property string
---@param value any
function ENT:SetProperty( property, value )
	if ( not self.PropertyFunctionMap[property] ) then
		error("Property [%s] cannot be set using PhotonEntity:SetProperty() and will need to manually be set instead.")
	end
	self[self.PropertyFunctionMap[property]]( self, value )
end


---@param equipment table?
---@param isSoftUpdate? boolean (Default = `false`)
function ENT:SetPropertiesFromEquipment( equipment, isSoftUpdate )
	-- These values manipulate entity properties and must not be called
	-- if Photon is not controlling the actual component entity.
	if ( self.IsVirtual ) then return end
	
	-- if ( self.IsParentPending ) then 
	-- 	ErrorNoHaltWithStack( "Equipment properties being setup while IsParentPending = true." )
	-- 	return
	-- end

	equipment = equipment or self.EquipmentData --[[@as table]]
	-- Bone following needs to occur before positioning
	-- to work correctly.
	if ( equipment.FollowBone ) then
		if ((not isSoftUpdate) or (self.PropertiesUpdatedOnSoftUpdate["FollowBone"])) then
			self:FollowParentBone( equipment.FollowBone )
		end
	elseif ( self.FollowingBone ) then 
		-- Clears the bone following if it was previously set (for responsive saving).
		local parent = self:GetParent()
		self:FollowBone( nil, self.FollowingBone )
		self:SetParent( parent )
		self:SetPredictable( false )
		hook.Remove("Think", self)
	end
	
	local map = self.PropertyFunctionMap
	-- Auto-apply supported properties
	for property, value in pairs( equipment ) do
		-- if ( ( map[property] == nil ) ) then
		-- 	error("Unsupported equipment property [" .. tostring( property) .. "].")
		-- end\

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

function ENT:ResetSubMaterials()
	for i=0, 31 do
		if ( i ~= index ) then
			self:SetSubMaterial( i, nil )
		end
	end
end

function ENT:SoftHighlightSubMaterial( index )
	local timerId = "Photon2.SubMaterialHighlight[" .. tostring( self.UniqueId ) .."]"
	local alt = true
	for i=0, 31 do
		if ( i ~= index ) then
			self:SetSubMaterial( i, nil )
		end
	end
	self:SetSubMaterial( index, "photon/common/debug_highlight" )
	timer.Create( timerId, 0.5, 0, function()
		if ( not IsValid( self ) ) then
			timer.Destroy( timerId)
			return
		end
		if ( alt ) then
			alt = false
			self:SetSubMaterial( index, nil )
		else
			alt = true
			self:SetSubMaterial( index, "photon/common/debug_highlight" )
		end
	end)
end

function ENT:ClearMaterialHighlight()
	local timerId = "Photon2.SubMaterialHighlight[" .. tostring( self.UniqueId ) .."]"
	timer.Destroy( timerId )
	self:ResetSubMaterials()
end

function ENT:IsolateSubMaterial( index )
	local timerId = "Photon2.SubMaterialHighlight[" .. tostring( self.UniqueId ) .."]"
	timer.Destroy( timerId )
	for i=0, 31 do
		if ( i ~= index ) then
			self:SetSubMaterial( i, "photon/common/blank" )
		else
			self:SetSubMaterial( i, nil )
		end
	end
end