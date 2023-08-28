if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightProjected"
BASE = "PhotonLight"

local manager = Photon2.RenderLightProjected
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightProjected: PhotonLight
---@field ProjectedTexture ProjectedTexture
---@field LocalPosition Vector
---@field LocalAngles Angle
---@field Position Vector World position of the light. Set and updated automatically.
---@field Angles Angle World angles of the light. Set and updated automatically.
---@field BoneParent integer If set, parents the light to the specified bone on the parent entity.
---@field Rotation Angle
---@field TranslatedLocalAngles Angle
---@field Matrix VMatrix
---@field Color PhotonColor
---@field Brightness number
---@field NearZ number
---@field FarZ number
---@field FOV number
local Light = exmeta.New()

Light.Class = "Projected"

Light.States = {
	["OFF"] = {
		Color = PhotonColor( 0, 0, 0 ),
		-- Brightness = 0
	},
	["W"] = {
		Color = PhotonColor( 235, 235, 255 )
	},
	["R"] = {
		Color = PhotonColor( 255, 0, 0 )
	},
	["B"] = {
		Color = PhotonColor( 0, 0, 255 )
	}
}

Light.BoneParent = -1
Light.LocalPosition = Vector()
Light.LocalAngles = Angle()
Light.Rotation = Angle( 0, 90, 0 ) -- 0 90 0?
Light.TranslatedLocalAngles = Angle()
Light.NearZ = 4
Light.FarZ = 1020
Light.FOV = 90
Light.Brightness = 4
Light.Texture = "effects/flashlight001"
Light.EnableShadows = false

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonLightProjected } )
end

function Light.New( light, template )
	
	if ( not light.LocalPosition and isvector( light[2] ) ) then
		light.LocalPosition = light[2]
	else
		light.LocalPosition = Vector()
	end

	if ( not light.LocalAngles and isangle( light[3] ) ) then
		light.LocalAngles = light[3]
	else
		light.LocalAngles = Angle()
	end

	setmetatable( light, { __index = ( template or PhotonLightProjected )})
	
	light.Matrix = Matrix()
	light.Matrix:SetAngles( light.Rotation )
	light.Matrix:Rotate( light.LocalAngles )
	light.TranslatedLocalAngles = light.Matrix:GetAngles()

	return light
end

function Light:Initialize( id, parentEntity )
	---@type PhotonLightProjected
	self = PhotonLight.Initialize( self, id, parentEntity ) --[[@as PhotonLightProjected]]
	self.Matrix = Matrix()
	return self
end

---@param state PhotonLightProjectedState
function Light:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	self.Color = state.Color
end

function Light:Activate()
	PhotonLight.Activate( self )
	self.Deactivate = false
	if ( self.IsActivated ) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
	local projectedTexture = ProjectedTexture()
	projectedTexture:SetTexture( self.Texture )
	projectedTexture:SetFarZ( self.FarZ )
	projectedTexture:SetNearZ( self.NearZ )
	projectedTexture:SetFOV( self.FOV )
	projectedTexture:SetBrightness( self.Brightness )
	projectedTexture:SetEnableShadows( self.EnableShadows )
	self.ProjectedTexture = projectedTexture
end

function Light:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
	self.ProjectedTexture:Remove()
	self.ProjectedTexture = nil
end

function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end

	if ( self.BoneParent < 0 ) then
		self.Position = self.Parent:LocalToWorld( self.LocalPosition )
		self.Angles = self.Parent:LocalToWorldAngles( self.TranslatedLocalAngles )
	else
		-- TODO: optimization
		self.Parent:SetupBones()
		local matrix = self.Parent:GetBoneMatrix( self.BoneParent )
		self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.TranslatedLocalAngles, matrix:GetTranslation(), matrix:GetAngles() )
	end

	self.ProjectedTexture:SetColor( self.Color )

	self.ProjectedTexture:SetPos( self.Position )
	self.ProjectedTexture:SetAngles( self.Angles )
	self.ProjectedTexture:Update()
	return self
end

function Light.OnLoad()
	for key, value in pairs( Light.States ) do
		Light.States[key] = PhotonLightProjectedState:New( key, value, Light.States )
	end
end

Light.OnLoad()