if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementMesh"
BASE = "PhotonElement"

local manager = Photon2.RenderLightMesh
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@type PhotonElementMesh
local Light = exmeta.New()

Light.Class = "Mesh"
Light.MeshSubIndex = 1
Light.LocalPosition = Vector()
Light.LocalAngles = Angle()

Light.ManipulateAlpha = true
Light.DrawMaterial = "photon/common/glow"
Light.BloomMaterial = "photon/common/glow"

Light.EnableDraw = true
Light.EnableBloom = true

Light.Intensity = 0
Light.IntensityGainFactor = 2
Light.IntensityLossFactor = 2
Light.TargetIntensity = 1
Light.IntensityTransitions = false

Light.Scale = Vector( 1, 1, 1 )
Light.BoneParent = -1

local white = { r = 235, g = 235, b = 255 }
local softWhite = { r = 255, g = 235, b = 205 }
local red = { r = 255, g = 0, b = 0 }
local blue = { r = 0, g = 0, b = 255 }
local green = { r = 0, g = 255, b = 0 }
local amber = { r = 255, g = 128, b = 0 }
local black = { r = 0, g = 0, b = 0 }

Light.States = {
	["~OFF"] = {
		Intensity = 0,
		IntensityTransitions = true
	},
	["OFF"] = {
		Intensity = 0,
		BloomColor = PhotonColor( 0, 0, 0 ) --[[@as PhotonBlendColor]],
		DrawColor = PhotonColor( 0, 0, 0 ) --[[@as PhotonBlendColor]],
	},
	["R"] = {
		BloomColor = PhotonColor( 255, 0, 0 ):Blend( red ):GetBlendColor(),
		DrawColor = PhotonColor( 255, 128, 0 ):Blend( red ):GetBlendColor(),
	},
	["G"] = {
		BloomColor = PhotonColor( 0, 255, 0 ):Blend( green ):GetBlendColor(),
		DrawColor = PhotonColor( 128, 255, 128 ):Blend( green ):GetBlendColor(),
	},
	["B"] = {
		BloomColor = PhotonColor( 0, 0, 255 ):Blend( blue ):GetBlendColor(),
		DrawColor = PhotonColor( 0, 150, 255 ):Blend( blue ):GetBlendColor(),
	},
	["A"] = {
		BloomColor = PhotonColor( 255, 100, 0 ):Blend( amber ):GetBlendColor(),
		DrawColor = PhotonColor( 255, 180, 0 ):Blend( amber ):GetBlendColor(),
	},
	["W"] = {
		BloomColor = PhotonColor( 128, 128, 255 ):Blend( white ):GetBlendColor(),
		DrawColor = PhotonColor( 255, 255, 255 ):Blend( white ):GetBlendColor(),
	},
	["SW"] = {
		BloomColor = PhotonColor( 255, 195, 175 ):Blend( softWhite ):GetBlendColor(),
		DrawColor = PhotonColor( 255, 245, 205 ):Blend( softWhite ):GetBlendColor(),
	},
}

function Light.New( light, template )

	-- Map shorthand parameters

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

	if ( not light.MeshName ) then
		if ( isstring( light[4] ) ) then
			light.MeshName = light[4]
		elseif ( istable( light[4] ) ) then
			light.MeshName = light[4][1]
			light.MeshSubIndex = light[4][2]
		end
	end
	
	setmetatable( light, { __index = (template or PhotonElementMesh ) } )

	-- error("new light?")
	-- Convert material names into IMaterial objects

	if ( isstring( light.DrawMaterial ) ) then
		light.DrawMaterial = Material( light.DrawMaterial --[[@as string]] )
	end

	if ( isstring( light.BloomMaterial ) ) then
		light.BloomMaterial = Material( light.BloomMaterial --[[@as string]] )
	end


	return light
end

function Light.OnFileLoad()
	-- Setup light states...
	for key, value in pairs( Light.States ) do
		Light.States[key] = PhotonElementMeshState:New( key, value, Light.States )
	end
end

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementMesh })
end

function Light:Initialize( id, component )
	self = PhotonElement.Initialize( self, id, component ) --[[@as PhotonElementMesh]]
	local parentEntity = component.Entity
	self.Matrix = Matrix()
	self.DrawColor = PhotonElementColor()
	self.BloomColor = PhotonElementColor()
	if ( isnumber( self.Scale ) ) then self.Scale = Vector( self.Scale --[[@as number]], self.Scale--[[@as number]], self.Scale--[[@as number]] ) end
	
	-- Fix for bizarre scaling bug in 64-bit game
	self.Scale = self.Scale + Vector( 0.0000000001, 0.0000000001, 0.0000000001 )
	self.FinalScale = self.Scale
	
	self.Matrix:SetScale( self.FinalScale )

	local scale = parentEntity:GetModelScale()
	if ( scale ~= 1 ) then
		self:SetLightScale( scale )
	end

	if ( isstring( self.BoneParent ) ) then
		self.BoneParent = parentEntity:LookupBone( self.BoneParent --[[@as string]] )
	end

	if ( not self.Mesh and CLIENT ) then
		self.Mesh = Photon2.MeshCache.GetMesh( self.Model, self.MeshName, self.MeshSubIndex )
	end

	return self
end

function Light:SetLightScale( scale )
	-- TODO
	self.FinalScale = self.Scale * scale
	self.Matrix:SetScale( self.FinalScale )
end

-- Internal
function Light:Activate()
	if not PhotonElement.Activate( self ) then return end
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
end

-- Intenal
function Light:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
end

local function interpolateY(ang, min, max)

	if ( min > max ) then
		if ( ang < max ) then
			ang = ang + 360
		end
		max = max + 360
	elseif min < 0 then
		min = min - min
		max = max - min
		ang = ang - min
	end

	-- Ensure X is within the valid range
	if ang < min then
		ang = min
	elseif ang > max then
		ang = max
	end

	-- Calculate Y using a sine wave with adjustable frequency
	local t = (ang - min) / (max - min)
	local Y = math.sin(math.pi * t)

	return math.Round(Y, 3)
end

-- Internal
function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return nil end

	self:UpdateProxyState()

	self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.LocalAngles, self.Parent:GetPos(), self.Parent:GetAngles() )

	if ( self.BoneParent < 0 ) then
		
	else
		self.Parent:SetupBones()
		local matrix = self.Parent:GetBoneMatrix( self.BoneParent --[[@as number]] )
		self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.LocalAngles, matrix:GetTranslation(), matrix:GetAngles() )
	end

	self.Matrix:SetTranslation( self.Position )
	self.Matrix:SetAngles( self.Angles )
	self.Matrix:SetScale( self.FinalScale )

	
	if ( self.IntensityTransitions ) then
		local state = self.States[self.CurrentStateId]
		if ( self.Intensity > self.TargetIntensity ) then
			self.Intensity = self.Intensity - (RealFrameTime() * self.IntensityLossFactor)
			if ( (self.Intensity < self.TargetIntensity) or (self.Intensity == self.TargetIntensity) ) then
				self.Intensity = self.TargetIntensity
				
				-- Fade out support
				if ( self.CurrentStateId == self.DeactivationState ) then
					self.Deactivate = true
				end
			else
				-- print( "self.Intensity = " .. tostring( self.Intensity ) .. " / self.TargetIntensity = " .. tostring( self.TargetIntensity ) )
			end
		else
			self.Intensity = self.Intensity + (RealFrameTime() * self.IntensityGainFactor)
			-- print("Gain: " .. self.IntensityGainFactor)
			-- self.Intensity = self.Intensity + (RealFrameTime() * 20)
			if (self.Intensity > self.TargetIntensity) then
				self.Intensity = self.TargetIntensity
			end
		end
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	end

	if ( self.Proxies ) then
		if (self.Mirror2) then

			local peak = self.Mirror2[1]
			local fov = self.Mirror2[2]
			
			local min = ( peak - ( fov / 2 ) ) % 360
			local max = ( peak + ( fov / 2 ) ) % 360

			if ( ( max % 360 ) < 180 ) then

			elseif ( ( max % 360 ) > 180 ) then

			end

			local ang = (self:GetProxy("R")) % 360
			-- local shift = 

			-- print("Ang: " .. math.Round(ang) .. " Min: " .. tostring( min ) .. " Max: " .. tostring( max ) )

			-- print("Progress:" .. calculateProgress( peak, fov, ang ) )
			
			-- TODO: Proxy checking is causing meshes to stay in the render queue when they should be off.
			-- (low priority because actual impact seems negligible)
			self.Intensity = interpolateY( ang, min, max )
			-- print("proxy is overriding intensity: " .. tostring( self.Intensity ))
			-- self.Intensity = calculateProgress( peak, fov, ang )
		
		elseif ( self.Mirror ) then
			local proxAng = (self:GetProxy("R") + self.Mirror[3]) % 360
			self.Intensity = interpolateY( proxAng, self.Mirror[1], self.Mirror[2])
			
		end
		
		-- print( "PROXY!   ...   " .. tostring(self:GetProxy("R")))
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	end

	return self
end

-- Internal
function Light:OnStateChange( state )
	self.DrawColor:SetTarget( state.DrawColor )
	self.BloomColor:SetTarget( state.BloomColor )

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity
	self.IntensityGainFactor = state.IntensityGainFactor
	self.IntensityLossFactor = state.IntensityLossFactor

	self.DrawMaterial = state.DrawMaterial
	self.BloomMaterial = state.BloomMaterial

	if ( state.IntensityTransitions ) then

	elseif ( self.TargetIntensity ~= 1 or (self.TargetIntensity ~= self.Intensity) ) then
		self.Intensity = self.TargetIntensity
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	else
		self.Intensity = self.TargetIntensity
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	end

end

Light.OnFileLoad()