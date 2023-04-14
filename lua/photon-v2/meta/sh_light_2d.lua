if (exmeta.ReloadFile("photon-v2/meta/sh_light_2d.lua")) then return end

NAME = "PhotonLight2D"
BASE = "PhotonLight"

local manager = Photon2.Light2D
local util_pixvis = util.PixelVisible

---@class PhotonLight2D : PhotonLight
---@field PixVisHandle pixelvis_handle_t
---@field VisibilityRadius number (Default = `1`) The radius number used for the PixelVisible calculation.
---@field UseBasicPlacement boolean (Default = `true`) Signifies that the light placement is static and simply relative to its component.
---@field LocalPosition Vector
---@field LocalAngles Angle
---@field Position Vector World position of the light. Set and updated automatically.
---@field Angles Angle World angles of the light. Set and updated automatically.
---@field Texture string The texture to use for the light source.
---@field Width number Width of the light source.
---@field Height number Height of the light source.
---@field Ratio number Horizontal size ratio of glow effect. Numbers > 1 will stretch, numbers < 1 will compact.
---@field Scale number Scale of glow effect and apparent brightness. Does not affect the light source.
---@field PrimaryColor Color
local Light = META

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

Light.PrimaryColor = Color( 0, 0, 0 )

Light.States = {
	["OFF"] = { Primary = Color( 0, 0, 0 ) },
	["R"] = { Primary = Color( 255, 96, 0 ) },
	["B"] = { Primary = Color( 0, 164, 255 ) },
	["W"] = { Primary = Color( 255, 255, 255 ) },
	["A"] = { Primary = Color( 255, 200, 0 ) },
}

function Light:Render()
end

--[[
		INITIALIZE
--]]

---@param parent Entity
---@return PhotonLight2D
function Light:Initialize( parent )
	self = PhotonLight.Initialize( self, parent )
	return self --[[@as PhotonLight2D]]
end

--[[
		COMPILE
--]]
---@param data table Data input table.
function Light.NewTemplate( data )
	local light = {}

	light.Top = Vector(  data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Right 	= Vector( -data.Width * 0.5,  data.Height * 0.5, 0 )
	light.Bottom = Vector( -data.Width * 0.5, -data.Height * 0.5, 0 )
	light.Left 	= Vector(  data.Width * 0.5, -data.Height * 0.5, 0 )
	light.Material = Material( data.Material )

	setmetatable( light, { __index = (base or PhotonLight2D) } )

	return light
end

---@param data table Data input table.
function Light.New( data, template )
	local light = data

	setmetatable( light, { __index = ( template or PhotonLight2D ) } )

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
	if (not self.IsActivated) then return nil end
	-- Update position and angles
	self.Position = self.Parent:LocalToWorld( self.LocalPosition )
	self.Angles = self.Parent:LocalToWorldAngles( self.LocalAngles )
	-- Update visibility calculation
	self.Visibility = util_pixvis( self.Position, self.VisibilityRadius, self.PixVisHandle )
	return self
end

function Light:SetState( stateId )
	if ( stateId == self.CurrentStateId ) then return end
	local state = self.States[ stateId ]
	if ( not state ) then
		error("Invalid light state [" .. tostring(stateId) .. "]")
	end
	self.CurrentStateId = stateId
	self.PrimaryColor = state.Primary
end