if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementProjected"
BASE = "PhotonElement"

local manager = Photon2.RenderLightProjected
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

local mpEnabledConVar = GetConVar( "ph2_enable_projectedtextures_mp" )
local game = game

local function renderEnabled()
	return game.SinglePlayer() or mpEnabledConVar:GetBool()
end

---@type PhotonElementProjected 
local Light = exmeta.New()

Light.Class = "Projected"

local white = { r = 255, g = 255, b = 255 }
local softWhite = { r = 255, g = 235, b = 205 }
local red = { r = 255, g = 0, b = 0 }
local blue = { r = 0, g = 0, b = 255 }
local green = { r = 0, g = 255, b = 0 }
local amber = { r = 255, g = 210, b = 0 }

Light.States = {
	["~OFF"] = {
		Intensity = 0,
		IntensityTransitions = true,
	},
	["OFF"] = {
		Color = PhotonColor( 0, 0, 0 ),
	},
	["W"] = {
		Color = PhotonColor( 235, 235, 255 ):Blend( white ):GetBlendColor()
	},
	["SW"] = {
		Color = PhotonColor( 255, 225, 200):Blend( softWhite ):GetBlendColor()
	},
	["R"] = {
		Color = PhotonColor( 255, 0, 0 ):Blend( red ):GetBlendColor()
	},
	["B"] = {
		Color = PhotonColor( 0, 0, 255 ):Blend( blue ):GetBlendColor()
	},
	["A"] = {
		Color = PhotonColor( 255, 180, 0 ):Blend( amber ):GetBlendColor()
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

Light.Intensity = 0
Light.IntensityGainFactor = 2
Light.IntensityLossFactor = 2
Light.TargetIntensity = 1
Light.IntensityTransitions = false
Light.IntensityFOVFloor = 0.66
Light.IntensityDistanceFactor = 1.5

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementProjected } )
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

	setmetatable( light, { __index = ( template or PhotonElementProjected )})
	
	light.Matrix = Matrix()
	light.Matrix:SetAngles( light.Rotation )
	light.Matrix:Rotate( light.LocalAngles )
	light.TranslatedLocalAngles = light.Matrix:GetAngles()

	return light
end

function Light:Initialize( id, component )
	---@type PhotonElementProjected
	self = PhotonElement.Initialize( self, id, component ) --[[@as PhotonElementProjected]]
	self.Matrix = Matrix()
	self.HorizontalFOV = self.HorizontalFOV or self.FOV
	self.VerticalFOV = self.VerticalFOV or self.FOV
	self.Color = PhotonElementColor()
	if ( self.Material ) then
		self.Texture = Material( self.Material ):GetTexture( "$basetexture" )
	end
	return self
end

---@param state PhotonElementProjectedState
function Light:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	
	self.Color:SetTarget( state.Color )

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity
	self.IntensityGainFactor = state.IntensityGainFactor
	self.IntensityLossFactor = state.IntensityLossFactor

	if ( state.IntensityTransitions ) then

	elseif ( self.TargetIntensity ~= 1 or (self.TargetIntensity ~= self.Intensity) ) then
		self.Intensity = self.TargetIntensity
		self.Color:SetIntensity( self.Intensity)
	else
		self.Intensity = self.TargetIntensity
		self.Color:SetIntensity( self.Intensity)
	end
end

function Light:Activate()
	if ( self.UIMode ) then return end
	if not PhotonElement.Activate( self ) then return end
	self.Deactivate = false
	if ( self.IsActivated ) then return end
	self.IsActivated = true
	if ( SERVER ) then return end
	manager.Active[#manager.Active+1] = self
	if ( not renderEnabled() ) then return end
	local projectedTexture = ProjectedTexture()
	projectedTexture:SetTexture( self.Texture )
	projectedTexture:SetFarZ( self.FarZ )
	projectedTexture:SetNearZ( self.NearZ )
	projectedTexture:SetHorizontalFOV( self.HorizontalFOV )
	projectedTexture:SetVerticalFOV( self.VerticalFOV )
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
	if ( #self.SortedInputActions < 1 ) and ( self.CurrentStateId == "OFF" ) then self.Deactivate = true end
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end
	if ( not renderEnabled() ) then return end

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
		
	self.ProjectedTexture:SetColor( self.Color:GetColor() )
	
	if ( self.IntensityTransitions ) then
		if ( self.Intensity > self.TargetIntensity ) then
			self.Intensity = self.Intensity - (RealFrameTime() * self.IntensityLossFactor)
			if (self.Intensity < self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
				-- Fade out support
				if ( self.CurrentStateId == self.DeactivationState ) then
					self.Deactivate = true
				end
			end
		else
			self.Intensity = self.Intensity + (RealFrameTime() * self.IntensityGainFactor)
			if (self.Intensity > self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
				if ( self.CurrentStateId == self.DeactivationState ) then
					self.Deactivate = true
				end
			end
		end
		
	end

	self.Color:SetIntensity( self.Intensity )

	local fovIntensity = ( ( self.Intensity * ( 1 - self.IntensityFOVFloor ) ) + self.IntensityFOVFloor )
	local disanceIntensity = ( math.Clamp( self.Intensity * self.IntensityDistanceFactor, 0, 1 ) )

	self.ProjectedTexture:SetHorizontalFOV( self.HorizontalFOV * fovIntensity )
	self.ProjectedTexture:SetVerticalFOV( self.VerticalFOV * fovIntensity )
	self.ProjectedTexture:SetFarZ( self.FarZ * disanceIntensity )
	self.ProjectedTexture:SetBrightness( self.Brightness * self.Intensity )
	
	self.ProjectedTexture:SetPos( self.Position )
	self.ProjectedTexture:SetAngles( self.Angles )
	self.ProjectedTexture:Update()
	return self
end

function Light.OnLoad()
	for key, value in pairs( Light.States ) do
		Light.States[key] = PhotonElementProjectedState:New( key, value, Light.States )
	end
end

Light.OnLoad()