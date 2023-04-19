if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight2D"
BASE = "PhotonLight"

local manager = Photon2.Light2D
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLight2D : PhotonLight
---@field PixVisHandle pixelvis_handle_t
---@field VisibilityRadius number (Default = `1`) The radius number used for the PixelVisible calculation.
---@field UseBasicPlacement boolean (Default = `true`) Signifies that the light placement is static and simply relative to its component.
---@field LocalPosition Vector
---@field LocalAngles Angle
---@field Rotation Angle
---@field QuadRotation Angle
---@field AnimationEnabled boolean
---@field IntensityTransitions boolean
---@field Intensity number Light's current (actual) intensity.
---@field TargetIntensity number Light's target intensity.
---@field Position Vector World position of the light. Set and updated automatically.
---@field Angles Angle World angles of the light. Set and updated automatically.
---@field Texture string The texture to use for the light source.
---@field Width number Width of the light source.
---@field Height number Height of the light source.
---@field Ratio number Horizontal size ratio of glow effect. Numbers > 1 will stretch, numbers < 1 will compact.
---@field Scale number Scale of glow effect and apparent brightness. Does not affect the light source.
---@field TargetSourceFillColor Color
---@field TargetSourceDetailColor Color
---@field SourceFillColor Color
---@field SourceDetailColor Color
---@field GlowColor Color
---@field ShouldDraw boolean
---@field Matrix VMatrix
---@field ViewNormal Vector
local Light = exmeta.New()

Light.Class = "2D"

Light.LocalPosition = Vector(0, 0, 0)
Light.LocalAngles = Angle(0, 0, 0)

Light.Texture = "sprites/emv/circular_src"
Light.Width = 1
Light.Height = 1
Light.Scale = 1
Light.Ratio = 1
Light.UseBasicPlacement = true

Light.VisibilityRadius = 1

Light.DrawSource = true
Light.DrawGlow = true

Light.SourceFillColor = Color( 0, 0, 0 )
Light.SourceDetailColor = Color( 0, 0, 0 )

Light.Rotation = Angle( 0, 90, 0 )
Light.QuadRotation = Angle( 0, 90, 90 )
Light.TranslatedLocalAngles = Angle( 0, 0, 0 )

Light.Intensity = 1
Light.IntensityGainFactor = 20
Light.IntensityLossFactor = 10
Light.TargetIntensity = 1

-- Light.States = {
-- 	["OFF"] = { Primary = Color( 0, 0, 0 ), Overlay = Color( 0, 0, 0 ) },
-- 	["R"] = { Primary = Color( 255, 64, 0 ), Overlay = Color(255, 255, 0) },
-- 	["B"] = { Primary = Color( 0, 96, 255 ), Overlay = Color(0, 255, 255) },
-- 	["W"] = { Primary = Color( 255, 255, 255 ), Overlay = Color(255, 255, 255) },
-- 	["A"] = { Primary = Color( 255, 96, 0 ), Overlay = Color(255, 255, 0) },
-- }

---@type table <string, PhotonLight2DState>
Light.States = {
	["~OFF"] = {
		Intensity 				= 0,
		IntensityTransitions 	= true,
	},
	["OFF"] = {
		SourceDetailColor = Color(0,0,0), SourceFillColor = Color(0,0,0), GlowColor = Color(0, 0, 0)
	},
	["R"] = {
		SourceDetailColor = Color(255,255,0), 
		SourceFillColor = Color(255,0,0),
		GlowColor = Color(255, 0, 0)
	},
	["B"] = {
		SourceDetailColor = Color(0,255,255), 
		SourceFillColor = Color(0,96,255),
		GlowColor = Color(0, 0, 255)
	},
	["A"] = {
		SourceDetailColor = Color(255,255,0), 
		SourceFillColor = Color(200,128,0),
		GlowColor = Color( 255, 128, 0 )
	},
	["W"] = {
		SourceDetailColor = Color(255,255,255), 
		SourceFillColor = Color(128,128,128),
		GlowColor = Color(225, 225, 255)
	},
}

for k, v in pairs( Light.States ) do
	Light.States[k] = PhotonLight2DState.New( k, v )
end

function Light:Render()
end

--[[
		INITIALIZE
--]]

---@param parent Entity
---@return PhotonLight2D
function Light:Initialize( id, parent )
	self = PhotonLight.Initialize( self, id, parent )
	self.Matrix = Matrix()
	self.ViewNormal = Vector()
	return self --[[@as PhotonLight2D]]
end

--[[
		COMPILE
--]]
---@param data table Data input table.
function Light.NewTemplate( data )
	---@type PhotonLight2D
	local light = data

	light.Top 		= Vector(  data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Right 	= Vector( -data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Bottom 	= Vector( -data.Width * 0.5, -data.Height * 0.5, 0 )
	light.Left 		= Vector(  data.Width * 0.5, -data.Height * 0.5, 0 )
	
	light.Material = Material( data.Material )
	light.MaterialOverlay = Material( data.MaterialOverlay )

	setmetatable( light, { __index = (base or PhotonLight2D) } )

	local rotate = light.QuadRotation
	light.Top:Rotate(rotate)
	light.Right:Rotate(rotate)
	light.Bottom:Rotate(rotate)
	light.Left:Rotate(rotate)

	return light
end

---@param data table Data input table.
function Light.New( data, template )
	---@type PhotonLight2D
	local light = data

	setmetatable( light, { __index = ( template or PhotonLight2D ) } )

	light.Matrix = Matrix()
	light.Matrix:SetAngles( light.Rotation )
	light.Matrix:Rotate( light.LocalAngles )
	light.TranslatedLocalAngles = light.Matrix:GetAngles()

	return light
end


function Light:Activate()
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
	self.PixVisHandle = util.GetPixelVisibleHandle()
end

function Light:DeactivateNow()
	self.IsActivated = false
	self.PixVisHandle = nil
	self.Deactivate = false
end

function Light:CalculateVisibility()
	if (not self.IsActivated) then return 0 end
	return util_pixvis( self.Position, self.VisibilityRadius, self.PixVisHandle )
end

local IsValid = IsValid

function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if (not self.IsActivated
) then return nil end
	self.ShouldDraw = true

	self.Position = self.Parent:LocalToWorld( self.LocalPosition )
	self.Angles = self.Parent:LocalToWorldAngles( self.TranslatedLocalAngles )

	self.ViewNormal:Set( self.Position )
	self.ViewNormal:Sub( EyePos() )
	self.ViewNormal:Normalize()

	self.ViewDot = - self.ViewNormal:Dot( self.Angles:Forward() )

	if (self.ViewDot < 0) then self.ViewDot = 0 end

	-- Update visibility calculation
	self.Visibility = util_pixvis( self.Position, self.VisibilityRadius, self.PixVisHandle )
	
	if ( self.Visibility == 0 ) then self.ShouldDraw = false end
	if ( self.ViewDot <= 0 ) then self.ShouldDraw = false end

	if ( self.IntensityTransitions ) then
		local state = self.States[self.CurrentStateId]
		if ( self.Intensity > self.TargetIntensity ) then
			self.Intensity = self.Intensity - (RealFrameTime() * state.IntensityLossFactor)
			if (self.Intensity < self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
			end
		else
			self.Intensity = self.Intensity + (RealFrameTime() * state.IntensityGainFactor)
			if (self.Intensity > self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
			end
		end
	
		local sourceFillColor = self.TargetSourceFillColor
		local sourceDetailColor = self.TargetSourceDetailColor
		local intensity = self.Intensity

		self.SourceFillColor.r = sourceFillColor.r * intensity
		self.SourceFillColor.g = sourceFillColor.g * intensity
		self.SourceFillColor.b = sourceFillColor.b * intensity
		
		self.SourceDetailColor.r = sourceDetailColor.r * intensity
		self.SourceDetailColor.g = sourceDetailColor.g * intensity
		self.SourceDetailColor.b = sourceDetailColor.b * intensity

	end
	

	return self
end

function Light:SetState( stateId )
	if ( stateId == self.CurrentStateId ) then return end

	local state = self.States[ stateId ] --[[@as PhotonLight2DState]]

	if ( not state ) then
		error("Invalid light state [" .. tostring(stateId) .. "]")
	end

	self.CurrentStateId = stateId
	self.TargetSourceFillColor = state.SourceFillColor or self.TargetSourceFillColor
	self.TargetSourceDetailColor = state.SourceDetailColor or self.TargetSourceDetailColor

	self.GlowColor = state.GlowColor or self.GlowColor

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity

	if ( state.IntensityTransitions ) then
		if (state.Intensity > 0) then
			self.SourceFillColor = self.TargetSourceFillColor:ToTable()
			self.SourceDetailColor = self.TargetSourceDetailColor:ToTable()
		end
	else
		self.SourceFillColor = self.TargetSourceFillColor
		self.SourceDetailColor = self.TargetSourceDetailColor
		self.Intensity = self.TargetIntensity
	end
end
