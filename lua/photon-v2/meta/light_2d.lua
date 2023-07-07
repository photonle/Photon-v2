if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight2D"
BASE = "PhotonLight"

local manager = Photon2.RenderLight2D
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLight2D : PhotonLight
---@field PixVisHandle pixelvis_handle_t Internal property.
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
---@field EffectPosition Vector World position to render the light effects at. Except in special cirumstances, this is equal to Light.Position.
---@field Angles Angle World angles of the light. Set and updated automatically.
---@field Texture string The texture to use for the light source.
---@field Width number Width of the light source.
---@field Height number Height of the light source.
---@field Ratio number Horizontal size ratio of glow effect. Numbers > 1 will stretch, numbers < 1 will compact.
---@field Scale number Scale of glow effect and apparent brightness. Does not affect the light source.
---@field SourceFillColor PhotonLightColor
---@field SourceDetailColor PhotonLightColor
---@field GlowColor PhotonLightColor
---@field ShapeGlowColor PhotonLightColor
---@field SubtractiveMid PhotonLightColor
---@field SourceIntensity PhotonLightColor
---@field ShouldDraw boolean
---@field Matrix VMatrix
---@field ViewNormal Vector
---@field ViewDotRight number
---@field ViewDotUp number
---@field LightMatrixEnabled boolean Internal property. Will set to true if a LightMatrix is defined.
---@field LightMatrix Vector[] Relative position vectors where additional effect sprites for this light should be drawn. Consider using just a BloomMaterial texture before setting up a LightMatrix, as the BloomMaterial can provide similar results with less performance overhead. Do note, however, that a LightMatrix generally still has better performance than using another dedicated Light.
---@field LightMatrixScaleMultiplier number Sets the light scale (perceived brightness) for all the LightMatrix sprites.
---@field WorldLightMatrix Vector[] Internal property. Stores the matrix points' world positions.
---@field MaterialsLoaded boolean If true, material string names should be materials.
---@field BoneParent integer If set, parents the light to the specified bone on the parent entity.
---@field FlipHorizontal boolean When true, texture quads will flip and mirror along the horizontal axis.
---@field FlipVertical boolean When true, texture quads will flip and mirror along the vertical axis.
---@field Persist boolean Forces the light to render when its visibility is zero. Can be used if glow effects cause undesirable bleeding.
---@field InnerSpread number Scale of inner glow effects.
--@field ComponentScale boolean
local Light = exmeta.New()

Light.Class = "2D"

Light.LocalPosition = Vector(0, 0, 0)
Light.LocalAngles = Angle(0, 0, 0)

Light.Material = "photon/common/blank"
Light.MaterialOverlay = "photon/common/blank"
Light.Width = 1
Light.Height = 1
Light.Scale = 1
Light.Ratio = 1
Light.UseBasicPlacement = true
Light.InnerSpread = 1

-- Light.ComponentScale = 1

Light.SpreadWidth = 1
Light.SpreadHeight = 1

Light.ForwardVisibilityOffset = 0
Light.ForwardBloomOffset = 0

Light.VisibilityRadius = 1

Light.DrawSource = true
Light.DrawGlow = true

Light.Rotation = Angle( 0, 90, 0 )
Light.QuadRotation = Angle( 0, 90, 90 )
Light.TranslatedLocalAngles = Angle( 0, 0, 0 )

Light.Intensity = 1
Light.IntensityGainFactor = 20
Light.IntensityLossFactor = 10
Light.TargetIntensity = 1

Light.LightMatrixEnabled = false
Light.LightMatrixScaleMultiplier = 1

Light.DrawLightPoints = true

Light.BoneParent = -1
-- Light.States = {
-- 	["OFF"] = { Primary = Color( 0, 0, 0 ), Overlay = Color( 0, 0, 0 ) },
-- 	["R"] = { Primary = Color( 255, 64, 0 ), Overlay = Color(255, 255, 0) },
-- 	["B"] = { Primary = Color( 0, 96, 255 ), Overlay = Color(0, 255, 255) },
-- 	["W"] = { Primary = Color( 255, 255, 255 ), Overlay = Color(255, 255, 255) },
-- 	["A"] = { Primary = Color( 255, 96, 0 ), Overlay = Color(255, 255, 0) },
-- }

local wScale = 0.8
local bScale = 0.66
local rScale = 0.66
local function reverseColor( color )
	color.r = 255 - color.r
	color.g = 255 - color.g
	color.b = 255 - color.b
	return color
end

local black = Color( 0, 0, 0 )

--[[
	Adding additional state colors:
	1. Add to annotations
	2. 
--]] 


Light.States = {
	["~OFF"] = {
		Intensity 				= 0,
		IntensityTransitions 	= true,
	},
	["OFF"] = {
		SourceDetailColor = black, 
		SourceFillColor = black, 
		GlowColor = black,
		SubtractiveMid = black,
		ShapeGlowColor = black, 
		InnerGlowColor = black,
		BloomColor = black,
		SourceIntensity = black,
	},
	-- EXPERIMENTAL VIOLET-SHIFTED COLORS
	["R"] = {
		SourceFillColor = PhotonColor(255,32,0),
		GlowColor = PhotonColor(255, 0, 96):Negative():Scale(0.33),
		SubtractiveMid = PhotonColor( 255, 0, 0 ):Negative():Scale(0.22),
		-- GlowColor = Color(255, 0, 48),
		SourceDetailColor = PhotonColor(255,255,0), 
		-- SourceDetailColor = Color(255,255,0), 
		InnerGlowColor = PhotonColor(255, 0, 0):Scale( rScale ),
		ShapeGlowColor = PhotonColor(255, 255, 0),
		SourceIntensity = PhotonColor( 255, 255, 0 )
	},
	["B"] = {
		SourceFillColor = PhotonColor(0,32,255),
		GlowColor = PhotonColor(64+64, 0, 255):Negative():Scale(0.33),
		SubtractiveMid = PhotonColor( 0, 0, 255 ):Negative():Scale(0.22),
		InnerGlowColor = PhotonColor(0, 0, 255):Scale( bScale ),
		SourceDetailColor = PhotonColor(0,255,255), 
		ShapeGlowColor = PhotonColor(0, 255, 255),
		SourceIntensity = PhotonColor( 128, 255, 255 )
	},
	["G"] = {
		SourceFillColor = PhotonColor(0,255,0),
		GlowColor = PhotonColor(0, 255, 0):Negative(),
		InnerGlowColor = PhotonColor(0, 512, 64),
		SourceDetailColor = PhotonColor(0,255,0), 
		ShapeGlowColor = PhotonColor(0, 255, 0),
		SourceIntensity = PhotonColor( 200, 255, 200 )
	},
	-- ORIGINAL GREEN-SHIFTED COLORS
	-- ["R"] = {
	-- 	SourceDetailColor = Color(255,255,0), 
	-- 	SourceFillColor = Color(255,0,0),
	-- 	GlowColor = Color(255, 0, 24),
	-- 	InnerGlowColor = Color(255, 32, 0),
	-- 	ShapeGlowColor = Color(255, 0, 0)
	-- },
	-- ["B"] = {
	-- 	SourceDetailColor = Color(0,255,255), 
	-- 	SourceFillColor = Color(0,0,255),
	-- 	-- SourceFillColor = Color(0,0,255),
	-- 	GlowColor = Color(40, 0, 255),
	-- 	InnerGlowColor = Color(0, 32, 512),
	-- 	ShapeGlowColor = Color(0, 0, 255),
	-- },

	["A"] = {
		SourceDetailColor = PhotonColor(255,255,0), 
		SourceFillColor = PhotonColor(200,64,0),
		GlowColor = PhotonColor( 255, 185, 0 ):Negative(),
		InnerGlowColor = PhotonColor( 255, 138, 0 ),
		ShapeGlowColor = PhotonColor( 255, 205, 0 ),
		SourceIntensity = PhotonColor( 200, 255, 200 ),
	},
	["W"] = {
		SourceDetailColor = PhotonColor(205,205,255), 
		SourceFillColor = PhotonColor( 0, 0, 0 ),
		GlowColor = PhotonColor(200*wScale, 200*wScale, 255*wScale),
		InnerGlowColor = PhotonColor(200*wScale, 200*wScale, 255*wScale),
		ShapeGlowColor = PhotonColor(100*wScale, 100*wScale, 255*wScale),
		SourceIntensity = PhotonColor( 255, 255, 255 )
	},
	["#DEBUG"] = {
		SourceDetailColor = Color( 255, 255, 255 ),
		SourceFillColor = Color( 255, 255, 0 ),
		GlowColor = Color( 255, 0, 255 ),
		InnerGlowColor = Color( 0, 255, 0 ),
		ShapeGlowColor = Color( 255, 0, 0 )
	}
}

function Light.OnLoad()
	for k, v in pairs( Light.States ) do
		Light.States[k] = PhotonLight2DState:New( k, v, Light.States )
	end
end

function Light:Render()
end


-- List of properties that need to be scaled to the parent entity scale
Light.ScalableProperties = {
	"LocalPosition", 
	"Top", 
	"Right", 
	"Bottom", 
	"Left", 
	"Width", 
	"Height", 
	"Scale",
	"ForwardVisibilityOffset",
	"ForwardBloomOffset",
	"LightMatrixScaleMultiplier",
	"SpreadWidth",
	"SpreadHeight"
}

--[[
		INITIALIZE
--]]

---@param parentEntity Entity
---@return PhotonLight2D
function Light:Initialize( id, parentEntity )
	self = PhotonLight.Initialize( self, id, parentEntity ) --[[@as PhotonLight2D]]
	self.Matrix = Matrix()
	self.ViewNormal = Vector()
	self.EffectPosition = Vector()
	self.SourceDetailColor = PhotonLightColor( { AddIntensity = 0.5 } )
	self.SourceFillColor = PhotonLightColor()
	self.GlowColor = PhotonLightColor()
	self.InnerGlowColor = PhotonLightColor()
	self.ShapeGlowColor = PhotonLightColor()
	self.SubtractiveMid = PhotonLightColor()
	self.SourceIntensity = PhotonLightColor()

	-- Adjust to component's scale
	local scale = parentEntity:GetModelScale()
	if (scale ~= 1) then
		self:SetLightScale( scale )
	end

	if ( self.LightMatrix ) then
		self.LightMatrixEnabled = true
		self.WorldLightMatrix = {}
		for i=1, #self.LightMatrix do
			self.WorldLightMatrix[i] = Vector()
		end
	end

	-- Lazy loading of materials.

	local baseClass = getmetatable( self ).__index

	if ( isstring( baseClass.Material ) ) then
		baseClass.Material = Material( baseClass.Material )
	end

	if ( isstring(baseClass.MaterialOverlay) ) then
		baseClass.MaterialOverlay = Material( baseClass.MaterialOverlay )
	end

	if ( isstring( baseClass.MaterialBloom ) ) then
		baseClass.MaterialBloom = Material( baseClass.MaterialBloom )
	end

	return self
end

function Light:SetLightScale( scale )
	local properties = self.ScalableProperties
	for i=1, #self.ScalableProperties do
		-- remove current values to so the metatable values are restored
		self[properties[i]] = nil
		-- scale is set using metatable values
		self[properties[i]] = self[properties[i]] * scale
	end
	if (self.LightMatrixEnabled) then
		local lightMatrix = self.LightMatrix
		self.LightMatrix = {}
		for i=1, #lightMatrix do
			self.LightMatrix[i] = lightMatrix[i] * scale
		end
	end
end

-- Internal function. Converts string material names to Material objects.
function Light:LoadMaterials()


	self.MaterialsLoaded = true
end

--[[
		COMPILE
--]]
---@param data table Data input table.
---@return PhotonLight2D
function Light.NewTemplate( data )
	---@type PhotonLight2D
	local light = setmetatable( data, { __index = PhotonLight2D } )

	light.Top 		= Vector(  data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Right 	= Vector( -data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Bottom 	= Vector( -data.Width * 0.5, -data.Height * 0.5, 0 )
	light.Left 		= Vector(  data.Width * 0.5, -data.Height * 0.5, 0 )
	
	local rotate = light.QuadRotation
	light.Top:Rotate(rotate)
	light.Right:Rotate(rotate)
	light.Bottom:Rotate(rotate)
	light.Left:Rotate(rotate)

	return light
end

---@param light PhotonLight2D Data input table.
---@param template? PhotonLight2D Light template.
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

	-- print("==== light =====")
	-- PrintTable(light)

	setmetatable( light, { __index = ( template or PhotonLight2D ) } )

	light.Matrix = Matrix()
	light.Matrix:SetAngles( light.Rotation )
	light.Matrix:Rotate( light.LocalAngles )
	light.TranslatedLocalAngles = light.Matrix:GetAngles()

	if ( light.FlipHorizontal ) then light.Width = light.Width * -1 end
	if ( light.FlipVertical ) then light.Height = light.Height * -1 end

	return light
end


function Light:Activate()
	PhotonLight.Activate( self )
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
	self.PixVisHandle = self.PixVisHandle or util.GetPixelVisibleHandle()
end

function Light:DeactivateNow()
	self.IsActivated = false
	-- self.PixVisHandle = nil
	self.Deactivate = false
end

local IsValid = IsValid
local LocalTowWorld = LocalToWorld

-- Micro-optimization to reuse Vector
local normalRef = Vector()

function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return nil end
	
	self.ShouldDraw = true

	
	if ( self.BoneParent < 0 ) then
		self.Position = self.Parent:LocalToWorld( self.LocalPosition )
		self.Angles = self.Parent:LocalToWorldAngles( self.TranslatedLocalAngles )
	else
		-- print("BONE PARENT: " .. tostring(self.BoneParent))
		-- -- TODO: optimization
		self.Parent:SetupBones()
		local matrix = self.Parent:GetBoneMatrix( self.BoneParent )
		-- local bonePosition = matrix:GetTranslation()
		-- local boneAngles = matrix:GetAngles()

		-- self.NextPositio

		-- if ( self.Parent:GetPos() == self.Parent:GetBonePosition( self.BoneParent ) ) then
		-- 	print("BONE AND ENTITY POSITIONS ARE THE SAME")
		-- end

		self.Position, self.Angles = LocalTowWorld( self.LocalPosition, self.TranslatedLocalAngles, matrix:GetTranslation(), matrix:GetAngles() )
	end


	

	-- self.NormUp = self.Angles:Up()
	-- self.NormForward = self.Angles:Forward()
	self.RightNormal = self.Angles:Right()
	self.UpNormal = self.Angles:Up()
	self.ForwardNormal = self.Angles:Forward()

	-- Update visibility calculation
	self.Visibility = util_pixvis( self.Position + (self.Angles:Forward() * self.ForwardVisibilityOffset), self.VisibilityRadius, self.PixVisHandle )
	-- self.Visibility = 1
	if ( self.Visibility == 0 and (not self.Persist) ) then self.ShouldDraw = false end
	
	if ( self.ShouldDraw ) then

		-- Setup effect positioning
		normalRef:Set( self.Angles:Forward() )
		normalRef:Mul( self.ForwardBloomOffset )
		self.EffectPosition:Set( self.Position )
		self.EffectPosition:Add( normalRef )

		-- Setup light matrix
		if ( self.LightMatrixEnabled ) then
			local localPoint, worldPoint
			for i = 1, #self.LightMatrix do

				localPoint = self.LightMatrix[i]

				worldPoint = self.WorldLightMatrix[i]
				worldPoint:Set( self.EffectPosition )

				normalRef:Set( self.RightNormal )
				normalRef:Mul( localPoint.x )
				worldPoint:Add( normalRef )

				normalRef:Set( self.ForwardNormal )
				normalRef:Mul( localPoint.y )
				worldPoint:Add( normalRef )

				normalRef:Set( self.UpNormal )
				normalRef:Mul( localPoint.z )
				worldPoint:Add( normalRef )

				-- self.WorldLightMatrix[i] = worldPoint

			end
		end


		self.ViewNormal:Set( self.Position )
		self.ViewNormal:Sub( EyePos() )
		self.ViewNormal:Normalize()
		self.ViewDot = (- self.ViewNormal:Dot( self.Angles:Forward() )) * self.Visibility
		
		-- local viewNorm = EyeAngles():Forward()
		
		-- self.ViewDotRight = - self.ViewNormal:Dot( self.Angles:Right() )
		-- self.ViewDotUp = - self.ViewNormal:Dot( self.Angles:Up() )
		-- self.ViewAngleDot = - LocalPlayer():GetAimVector():Dot( self.Angles:Forward() )
		
		if (self.ViewDot < 0) then self.ViewDot = 0 end
		if (( self.ViewDot <= 0 ) and (not self.Persist)) then self.ShouldDraw = false end

	end
		

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

		self.SourceFillColor:SetIntensity( self.Intensity )
		self.SourceDetailColor:SetIntensity( self.Intensity )
		self.GlowColor:SetIntensity( self.Intensity )
		self.ShapeGlowColor:SetIntensity( self.Intensity )
		self.InnerGlowColor:SetIntensity( self.Intensity )

	end

	return self
end

function Light:OnStateChange( state )

	self.SourceFillColor:SetTarget( state.SourceFillColor )
	self.SourceDetailColor:SetTarget( state.SourceDetailColor )
	self.GlowColor:SetTarget( state.GlowColor )
	self.InnerGlowColor:SetTarget( state.InnerGlowColor )
	self.ShapeGlowColor:SetTarget( state.ShapeGlowColor )
	self.SubtractiveMid:SetTarget( state.SubtractiveMid )
	self.SourceIntensity:SetTarget( state.SourceIntensity )

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity

	if ( state.IntensityTransitions ) then

	elseif ( self.TargetIntensity ~= 1 or (self.TargetIntensity ~= self.Intensity) ) then		

		self.Intensity = self.TargetIntensity

		self.SourceFillColor:SetIntensity( self.Intensity )
		self.SourceDetailColor:SetIntensity( self.Intensity )
		self.GlowColor:SetIntensity( self.Intensity )
		self.InnerGlowColor:SetIntensity( self.Intensity )
		self.ShapeGlowColor:SetIntensity( self.Intensity )
		self.SubtractiveMid:SetIntensity( self.Intensity )

	else
		self.Intensity = self.TargetIntensity

		self.SourceFillColor:SetIntensity( self.Intensity )
		self.SourceDetailColor:SetIntensity( self.Intensity )
		self.GlowColor:SetIntensity( self.Intensity )
		self.InnerGlowColor:SetIntensity( self.Intensity )
		self.ShapeGlowColor:SetIntensity( self.Intensity )
		self.SubtractiveMid:SetIntensity( self.Intensity )
		self.SourceIntensity:SetIntensity( self.Intensity )
	end
end

Light.OnLoad()