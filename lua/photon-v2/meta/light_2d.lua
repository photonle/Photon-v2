if (exmeta.ReloadFile()) then return end

NAME = "PhotonElement2D"
BASE = "PhotonElement"

local manager = Photon2.RenderLight2D
local util_pixvis = util.PixelVisible
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@type PhotonElement2D
local Light = exmeta.New()

Light.Class = "2D"

Light.LocalPosition = Vector(0, 0, 0)
Light.LocalAngles = Angle(0, 0, 0)

Light.Shape = "photon/common/blank"
Light.Detail = "photon/common/blank"
Light.Width = 1
Light.Height = 1
Light.Scale = 1
Light.Ratio = 1
Light.UseBasicPlacement = true
Light.InnerSpread = 1

-- Light.ComponentScale = 1

Light.ForwardVisibilityOffset = 0
Light.ForwardBloomOffset = 0

Light.VisibilityRadius = 1

Light.DrawSource = true
Light.DrawGlow = true

Light.Rotation = Angle( 0, 90, 0 )
Light.QuadRotation = Angle( 0, 90, 90 )
Light.TranslatedLocalAngles = Angle( 0, 0, 0 )

Light.Intensity = 0
Light.IntensityGainFactor = 1
Light.IntensityLossFactor = 10
Light.TargetIntensity = 1
Light.IntensityTransitions = false

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

local wScale = 0.9
local swScale = 1.0
local bScale = 0.66
local rScale = 0.66
local function reverseColor( color )
	color.r = 255 - color.r
	color.g = 255 - color.g
	color.b = 255 - color.b
	return color
end

local black = Color( 0, 0, 0 )
-- local white = Color( 255, 255, 255 )

--[[
	Adding additional state colors:
	1. Add to annotations
	2. 
--]] 

local white = { r = 255, g = 255, b = 255 }
local softWhite = { r = 255, g = 225, b = 225 }
local red = { r = 255, g = 0, b = 0 }
local redHalogen = { r = 255, g = 50, b = 70 }
local blue = { r = 0, g = 0, b = 255 }
local green = { r = 0, g = 255, b = 0 }
local amber = { r = 255, g = 0, b = 0 }

Light.States = {
	["~OFF"] = {
		Intensity 				= 0,
		IntensityTransitions 	= true,
	},
	["OFF"] = {
		Blend = PhotonColor( 0, 0, 0 ),
		SourceDetailColor = black, 
		SourceFillColor = black, 
		GlowColor = black,
		SubtractiveMid = black,
		ShapeGlowColor = black, 
		InnerGlowColor = black,
		BloomColor = black,
		SourceIntensity = black,
		PeakColor = black,
		Intensity = 0
	},
	-- EXPERIMENTAL VIOLET-SHIFTED COLORS
	["R"] = {
		Blend = PhotonColor( 255, 0, 0 ),
		SourceFillColor = PhotonColor( 255, 0, 0 ):Negative(true):Blend( red ):GetBlendColor(),
		GlowColor = PhotonColor( 255, 0, 0 ):Negative(true):Blend(red):Scale(0.6):GetBlendColor(),
		SubtractiveMid = PhotonColor( 255, 0, 0 ):Negative(true):Blend(red):Scale(0.6):GetBlendColor(),
		SourceDetailColor = PhotonColor( 255,255,0 ):Blend(red):GetBlendColor(), 
		InnerGlowColor = PhotonColor(255, 0, 0):Blend(red):Scale( rScale ):GetBlendColor(),
		ShapeGlowColor = PhotonColor(255, 0, 0):Blend(red):GetBlendColor()
	},
	["B"] = {
		Blend = PhotonColor( 0, 0, 255 ),
		-- inverted
		SourceFillColor = PhotonColor(0,0,255):Negative(true):Blend( blue ):GetBlendColor(),
		-- inverted
		GlowColor = PhotonColor(48, 0, 255):Negative(true):Blend(blue):Scale(0.6):GetBlendColor(), --*
		-- inverted
		SubtractiveMid = PhotonColor( 0, 0, 255 ):Negative(true):Blend(blue):Scale(0.6):GetBlendColor(), --*
		InnerGlowColor = PhotonColor(0, 64, 255):Blend(blue):Scale( bScale ):GetBlendColor(),--*
		SourceDetailColor = PhotonColor(0,255,255):Blend(blue):GetBlendColor(), --*
		ShapeGlowColor = PhotonColor(0, 0, 255):Blend(blue):GetBlendColor(), --*
	},
	["G"] = {
		SourceDetailColor = PhotonColor(255,255,0):Blend(green):GetBlendColor(), 
		SourceFillColor = PhotonColor(64,200,0):Blend(green):GetBlendColor(),
		GlowColor = PhotonColor( 100, 255, 0 ):Blend(green):GetBlendColor(), --*
		InnerGlowColor = PhotonColor( 128, 255, 0 ):Blend(green):GetBlendColor(),
		ShapeGlowColor = PhotonColor( 0, 128, 0 ):Blend(green):GetBlendColor(),
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
		SourceDetailColor = PhotonColor(255,255,0):Blend(amber):GetBlendColor(), 
		SourceFillColor = PhotonColor(200,64,0):Blend(amber):GetBlendColor(),
		GlowColor = PhotonColor( 255, 100, 0 ):Blend(amber):GetBlendColor(), --*
		InnerGlowColor = PhotonColor( 255, 128, 0 ):Blend(amber):GetBlendColor(),
		ShapeGlowColor = PhotonColor( 255, 128, 0 ):Blend(amber):GetBlendColor(),
	},
	["W"] = {
		Blend = Color( 200, 200, 255 ),
		SourceDetailColor = PhotonColor(255,255,255):Blend(white):GetBlendColor(), 
		SourceFillColor = PhotonColor( 255, 255, 255 ):Blend(white):GetBlendColor(),
		GlowColor = PhotonColor(200*wScale, 200*wScale, 255*wScale):Negative(true):Blend(white):GetBlendColor(),
		InnerGlowColor = PhotonColor(150*wScale, 150*wScale, 255*wScale):Blend(white):GetBlendColor(),
		ShapeGlowColor = PhotonColor(255, 255, 255):Blend(white):GetBlendColor(),
	},
	["SW"] = {
		Blend = Color( 255, 200, 200 ),
		SourceDetailColor = PhotonColor(255,255,255):Blend(softWhite):GetBlendColor(), 
		SubtractiveMid = PhotonColor( 0, 0, 255 ):Negative(true):Blend(softWhite):GetBlendColor(),
		SourceFillColor = PhotonColor( 255, 255, 255 ):Negative(false):Blend(softWhite):GetBlendColor(),
		GlowColor = PhotonColor(255*swScale, 255*swScale, 200*swScale):Negative(true):Blend(softWhite):GetBlendColor(),
		InnerGlowColor = PhotonColor(255*swScale, 175*swScale, 150*swScale):Blend(softWhite):GetBlendColor(),
		ShapeGlowColor = PhotonColor(255, 255, 255):Blend(softWhite):GetBlendColor(),
	},
	["HR"] = {
		Title = "Halogen Red",
		Blend = PhotonColor( 255, 50, 50 ),
		SourceFillColor = PhotonColor( 255, 0, 0 ):Negative(true):Blend( redHalogen ):GetBlendColor(),
		GlowColor = PhotonColor( 255, 0, 0 ):Negative(true):Blend(redHalogen):Scale(0.6):GetBlendColor(),
		SubtractiveMid = PhotonColor( 255, 0, 0 ):Negative(true):Blend(redHalogen):Scale(0.6):GetBlendColor(),
		SourceDetailColor = PhotonColor( 255,225,0 ):Blend(redHalogen):GetBlendColor(), 
		InnerGlowColor = PhotonColor(255, 50, 50):Blend(redHalogen):Scale( rScale ):GetBlendColor(),
		ShapeGlowColor = PhotonColor(255, 48, 48):Blend(redHalogen):GetBlendColor()
	},
	["#DEBUG"] = {
		SourceDetailColor = Color( 0, 255, 0 ),
		SourceFillColor = PhotonColor( 0, 255, 0 ):Negative( true ):GetBlendColor(),
		GlowColor = Color( 0, 0, 0 ),
		InnerGlowColor = Color( 0, 0, 0 ),
		ShapeGlowColor = Color( 0, 0, 0 ),
		Intensity = 0.5
	}
}
function Light.OnLoad()
	for k, v in pairs( Light.States ) do
		Light.States[k] = PhotonElement2DState:New( k, v, Light.States )
	end
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
	"LightMatrixScaleMultiplier"
}

--[[
		INITIALIZE
--]]

function Light:Initialize( id, component )
	self = PhotonElement.Initialize( self, id, component ) --[[@as PhotonElement2D]]
	local parentEntity = component.Entity
	self.Matrix = Matrix()
	self.ViewNormal = Vector()
	self.EffectPosition = Vector()
	self.SourceDetailColor = PhotonElementColor( { AddIntensity = 0.5 } )
	self.SourceFillColor = PhotonElementColor()
	self.GlowColor = PhotonElementColor( { Inverted = false } )
	self.InnerGlowColor = PhotonElementColor()
	self.ShapeGlowColor = PhotonElementColor()
	self.SubtractiveMid = PhotonElementColor( { Inverted = false } )
	self.SourceIntensity = PhotonElementColor()

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

	---@type PhotonElement2D
	local baseClass = getmetatable( self ).__index

	if ( isstring( baseClass.Shape ) ) then
		baseClass.Shape = Material( baseClass.Shape --[[@as string]] )
	end

	if ( isstring(baseClass.Detail) ) then
		baseClass.Detail = Material( baseClass.Detail --[[@as string]]  )
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
		local lightMatrix = self.LightMatrix or {}
		self.LightMatrix = {}
		for i=1, #lightMatrix do
			self.LightMatrix[i] = lightMatrix[i] * scale
		end
	end
end

--[[
		COMPILE
--]]
---@param data table Data input table.
---@return PhotonElement2D
function Light.NewTemplate( data )
	---@type PhotonElement2D
	local light = setmetatable( data, { __index = PhotonElement2D } )

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

	setmetatable( light, { __index = ( template or PhotonElement2D ) } )

	light.Matrix = Matrix()
	light.Matrix:SetAngles( light.Rotation )
	light.Matrix:Rotate( light.LocalAngles )
	light.TranslatedLocalAngles = light.Matrix:GetAngles()

	if ( light.FlipHorizontal ) then light.Width = light.Width * -1 end
	if ( light.FlipVertical ) then light.Height = light.Height * -1 end

	return light
end

function Light:Activate()
	if not PhotonElement.Activate( self ) then return end
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
local LocalToWorld = LocalToWorld

-- Micro-optimization to reuse Vector
local normalRef = Vector()

function Light:DoPreRender( force )
	if ( not force ) then
		if ( #self.SortedInputActions < 1 ) and ( self.CurrentStateId == "OFF" ) then self.Deactivate = true end
		if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
		if ( not self.IsActivated ) then return nil end
	end

	self:UpdateProxyState()

	self.ShouldDraw = true

	
	if ( self.BoneParent < 0 ) then
		self.Position = self.Parent:LocalToWorld( self.LocalPosition )
		self.Angles = self.Parent:LocalToWorldAngles( self.TranslatedLocalAngles )
		-- print( tostring(self.Parent:GetAngles()) )
	else
		-- print("BONE PARENT: " .. tostring(self.BoneParent))
		-- -- TODO: optimization
		self.Parent:SetupBones()
		local matrix = self.Parent:GetBoneMatrix( self.BoneParent --[[@as number]] )
		-- local bonePosition = matrix:GetTranslation()
		-- local boneAngles = matrix:GetAngles()

		-- self.NextPositio

		-- if ( self.Parent:GetPos() == self.Parent:GetBonePosition( self.BoneParent ) ) then
		-- 	print("BONE AND ENTITY POSITIONS ARE THE SAME")
		-- end

		self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.TranslatedLocalAngles, matrix:GetTranslation(), matrix:GetAngles() )
	end


	

	-- self.NormUp = self.Angles:Up()
	-- self.NormForward = self.Angles:Forward()
	self.RightNormal = self.Angles:Right()
	self.UpNormal = self.Angles:Up()
	self.ForwardNormal = self.Angles:Forward()

	-- Update visibility calculation
	if ( self.UIMode ) then
		self.Visibility = 1
	else
		self.Visibility = util_pixvis( self.Position + (self.Angles:Forward() * self.ForwardVisibilityOffset), self.VisibilityRadius, self.PixVisHandle )
	end
	
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


		if ( not self.UIMode ) then
			self.ViewNormal:Set( self.Position )
			self.ViewNormal:Sub( EyePos() )
			self.ViewNormal:Normalize()
			self.ViewDot = (- self.ViewNormal:Dot( self.Angles:Forward() )) * self.Visibility
		else
			self.ViewDot = 1
		end
		
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
			end
		end

		self.SourceFillColor:SetIntensity( self.Intensity )
		self.SourceDetailColor:SetIntensity( self.Intensity )
		self.GlowColor:SetIntensity( self.Intensity )
		self.ShapeGlowColor:SetIntensity( self.Intensity )
		self.InnerGlowColor:SetIntensity( self.Intensity )
		self.SubtractiveMid:SetIntensity( self.Intensity )

	end

	return self
end

function Light:DrawDebug()
	-- if ( self.Id ~= 1 ) then return end
	-- cam.Start3D2D( self.Position, self.Angles, 1 )
	-- surface.SetFont( "DebugOverlay" )
	-- surface.SetDrawColor( 255, 255, 255 )
	-- self:DoPreRender()
	-- cam.Start3D()
	
	-- cam.Start2D()

	-- local pos = self.Position:ToScreen()
	-- render.DrawSphere( self.Position, 3, 4, 4, Color( 255, 0, 0 ) )
	-- PrintTable( pos )
	-- cam.End3D()
	-- cam.Start3D2D( self.Position, self.Angles, 1 )
	-- 	surface.SetDrawColor( 255, 0, 0, 255 )
	-- 	surface.DrawRect( 0, 0, 8, 8 )
	-- cam.End3D2D()
	-- cam.Start2D()
	if ( self.ScreenPosition ) then
		local color = Color( 255, 255, 255, 255 )
		if ( self.CurrentStateId == "OFF" ) then color = Color( 255, 255, 255, 100 ) end
		draw.DrawText( self.Id, "DebugOverlay", self.ScreenPosition.x, self.ScreenPosition.y - 6, ColorAlpha( color, ( 255 * self.Intensity ) + 100 ) , TEXT_ALIGN_CENTER )
		-- local pos = self.Position:ToScreen()
		-- draw.DrawText( self.Id, "DebugOverlay",pos.x,pos.y, Color( 0, 255, 0 ) )
	end
	-- cam.End2D()
	-- cam.End3D2D()
 
	-- cam.End2D()
	-- surface.SetTextPos( pos.x, pos.y )
	-- surface.DrawText( "HELLO" )
	-- debugoverlay.Text( self.Position, "hi", 0, false)
	-- cam.End3D2D()

end

function Light:OnStateChange( state )

	self.BlendColor = state.Blend

	self.SourceFillColor:SetTarget( state.SourceFillColor )
	self.SourceDetailColor:SetTarget( state.SourceDetailColor )
	self.GlowColor:SetTarget( state.GlowColor )
	self.InnerGlowColor:SetTarget( state.InnerGlowColor )
	self.ShapeGlowColor:SetTarget( state.ShapeGlowColor )
	self.SubtractiveMid:SetTarget( state.SubtractiveMid )

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity
	self.IntensityGainFactor = state.IntensityGainFactor
	self.IntensityLossFactor = state.IntensityLossFactor

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
	end
end

Light.OnLoad()