if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightMesh"
BASE = "PhotonLight"

local manager = Photon2.RenderLightMesh
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightMesh : PhotonLight
---@field Model string Name of model that contains the mesh.
---@field MeshName string Mesh name (model sub-material).
---@field MeshSubIndex number Model's mesh sub-index (default = `1`).
---@field Mesh IMesh
---@field LocalPosition Vector
---@field LocalAngles Angle
---@field Position Vector
---@field Angles Angle
---@field Matrix VMatrix
---@field BloomColor PhotonLightColor
---@field DrawColor PhotonLightColor
---@field Intensity number
---@field IntensityGainFactor number
---@field IntensityLossFactor number
---@field TargetIntensity number
---@field IntensityTransitions boolean
---@field EnableDraw boolean Whether or the mesh should be rendered in the normal pass.
---@field EnableBloom boolean Whether or not the mesh should be drawn during the bloom pass.
---@field DrawMaterial string | IMaterial Material to use when drawing the mesh.
---@field BloomMaterial string | IMaterial Material to use 
---@field States table<string, PhotonLightMeshState>
local Light = exmeta.New()

Light.Class = "Mesh"
Light.MeshSubIndex = 1
Light.LocalPosition = Vector()
Light.LocalAngles = Angle()

Light.DrawMaterial = "photon/common/glow"
Light.BloomMaterial = "photon/common/glow"

Light.EnableDraw = true
Light.EnableBloom = true

Light.Intensity = 1
Light.IntensityGainFactor = 10
Light.IntensityLossFactor = 10
Light.TargetIntensity = 1
Light.IntensityTransitions = false

local white = { r = 255, g = 255, b = 255 }
local red = { r = 255, g = 0, b = 0 }
local blue = { r = 0, g = 0, b = 255 }
local green = { r = 0, g = 255, b = 0 }
local amber = { r = 255, g = 255, b = 0 }

Light.States = {
	["~OFF"] = {
		Intensity = 0,
		IntensityTransitions = true,
	},
	["OFF"] = {
		BloomColor = PhotonColor( 0, 0, 0 ),
		DrawColor = PhotonColor( 0, 0, 0 ),
	},
	["R"] = {
		BloomColor = PhotonColor( 255, 0, 0 ):Blend( red ),
		DrawColor = PhotonColor( 255, 255, 0 ):Blend( red ),
	},
	["G"] = {
		BloomColor = PhotonColor( 0, 255, 0 ):Blend( green ),
		DrawColor = PhotonColor( 128, 255, 128 ):Blend( green ),
	},
	["B"] = {
		BloomColor = PhotonColor( 0, 0, 255 ):Blend( blue ),
		DrawColor = PhotonColor( 0, 255, 255 ):Blend( blue ),
	},
	["A"] = {
		BloomColor = PhotonColor( 255, 200, 0 ):Blend( amber ),
		DrawColor = PhotonColor( 255, 255, 128 ):Blend( amber ),
	},
	["W"] = {
		BloomColor = PhotonColor( 200, 200, 255 ):Blend( white ),
		DrawColor = PhotonColor( 255, 255, 255 ):Blend( white ),
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
	
	setmetatable( light, { __index = (template or PhotonLightMesh ) } )

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
		Light.States[key] = PhotonLightMeshState:New( key, value, Light.States )
	end
end

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonLightMesh })
end

function Light:Initialize( id, parentEntity )
	self = PhotonLight.Initialize( self, id, parentEntity ) --[[@as PhotonLightMesh]]
	self.Matrix = Matrix()
	self.DrawColor = PhotonLightColor()
	self.BloomColor = PhotonLightColor()

	local scale = parentEntity:GetModelScale()
	if ( scale ~= 1 ) then
		self:SetLightScale( scale )
	end

	if ( not self.Mesh and CLIENT ) then
		self.Mesh = Photon2.MeshCache.GetMesh( self.Model, self.MeshName, self.MeshSubIndex )
	end
	return self
end

function Light:SetLightScale( scale )
	-- TODO
end

-- Internal
function Light:Activate()
	PhotonLight.Activate( self )
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

-- Internal
function Light:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return nil end

	self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.LocalAngles, self.Parent:GetPos(), self.Parent:GetAngles() )

	self.Matrix:SetTranslation( self.Position )
	self.Matrix:SetAngles( self.Angles )

	return self
end

-- Internal
function Light:OnStateChange( state )
	
	self.DrawColor:SetTarget( state.DrawColor )
	self.BloomColor:SetTarget( state.BloomColor )

	self.IntensityTransitions = state.IntensityTransitions
	self.TargetIntensity = state.Intensity

	if ( state.IntensityTransitions ) then

	elseif ( self.TargetIntensity ~= 1 or (self.TargetIntensity ~= self.Intensity) ) then
		print("setting intensity?")
		self.Intensity = self.TargetIntensity
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	else
		print("setting intensity?")
		self.Intensity = self.TargetIntensity
		self.DrawColor:SetIntensity( self.Intensity )
		self.BloomColor:SetIntensity( self.Intensity )
	end

end

Light.OnFileLoad()