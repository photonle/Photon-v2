if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightProjected"
BASE = "PhotonLight"

local manager = Photon2.RenderLightProjected
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightProjected: PhotonLight
---@field ProjectedTexture? ProjectedTexture
---@field LocalPosition? Vector
---@field LocalAngles? Angle
---@field Position? Vector World position of the light. Set and updated automatically.
---@field Angles? Angle World angles of the light. Set and updated automatically.
---@field BoneParent? integer If set, parents the light to the specified bone on the parent entity.
---@field Rotation? Angle
---@field protected TranslatedLocalAngles? Angle
---@field protected Matrix? VMatrix
---@field Color? PhotonColor
---@field Brightness? number
---@field NearZ? number
---@field FarZ? number
---@field FOV? number
---@field HorizontalFOV? number
---@field VerticalFOV? number
---@field Intensity? number
---@field IntensityGainFactor? number
---@field IntensityLossFactor? number
---@field protected TargetIntensity? number
---@field IntensityTransitions? boolean
---@field IntensityFOVFloor? number The minimum FOV multiplier to use when the light intensity is zero.
---@field IntensityDistanceFactor? number Multiplied by light's intensity to modify its distance. Used to smooth intensity transition effects.
---@field EnableShadows? boolean Enable or disable shadows cast from the projected texture.
local Light = exmeta.New()

Light.Class = "Projected"

Light.States = {
	["~OFF"] = {
		Intensity = 0,
		IntensityTransitions = 1
	},
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
	},
	["A"] = {
		Color = PhotonColor( 255, 220, 0 )
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

Light.Intensity = 1
Light.IntensityGainFactor = 2
Light.IntensityLossFactor = 2
Light.TargetIntensity = 1
Light.IntensityTransitions = false
Light.IntensityFOVFloor = 0.66
Light.IntensityDistanceFactor = 1.5

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
	self.HorizontalFOV = self.HorizontalFOV or self.FOV
	self.VerticalFOV = self.VerticalFOV or self.FOV
	return self
end

---@param state PhotonLightProjectedState
function Light:OnStateChange( state )

	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	
	self.Color = state.Color

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity
	self.IntensityGainFactor = state.IntensityGainFactor
	self.IntensityLossFactor = state.IntensityLossFactor

	if ( state.IntensityTransitions ) then

	elseif ( self.TargetIntensity ~= 1 or (self.TargetIntensity ~= self.Intensity) ) then
		self.Intensity = self.TargetIntensity
	else
		self.Intensity = self.TargetIntensity
	end
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
	projectedTexture:SetHorizontalFOV( self.HorizontalFOV or self.FOV)
	projectedTexture:SetVerticalFOV( self.VerticalFOV or self.FOV)
	projectedTexture:SetBrightness( self.Brightness * self.Intensity )
	projectedTexture:SetEnableShadows( self.EnableShadows )
	self.ProjectedTexture = projectedTexture
end

function Light:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
	if ( IsValid( self.ProjectedTexture ) ) then
		self.ProjectedTexture:Remove()
		self.ProjectedTexture = nil
	end
end

function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end

	self:UpdateProxyState()

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

	if ( self.IntensityTransitions ) then
		if ( self.Intensity > self.TargetIntensity ) then
			self.Intensity = self.Intensity - (RealFrameTime() * self.IntensityLossFactor)
			if (self.Intensity < self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
			end
		else
			self.Intensity = self.Intensity + (RealFrameTime() * self.IntensityGainFactor)
			if (self.Intensity > self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
			end
		end
		
	end

	local fovIntensity = ( ( self.Intensity * ( 1 - self.IntensityFOVFloor ) ) + self.IntensityFOVFloor )
	local disanceIntensity = ( math.Clamp( self.Intensity * self.IntensityDistanceFactor, 0, 1 ) )

	self.ProjectedTexture:SetHorizontalFOV( self.HorizontalFOV * fovIntensity )
	self.ProjectedTexture:SetVerticalFOV( self.HorizontalFOV * fovIntensity )
	self.ProjectedTexture:SetFarZ( self.FarZ * disanceIntensity )
	self.ProjectedTexture:SetBrightness( self.Brightness * self.Intensity )
	
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