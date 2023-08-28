if (exmeta.ReloadFile()) then return end

NAME = "_PhotonColor"
-- BASE = "Color"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

-- An advanced Color class
---@class PhotonColor : Color, RGB
---@field r number
---@field g number
---@field b number
---@field a number
---@field BlendColor RGB
---@field Color Color
---@field Alpha boolean
---@field Inverted boolean If color should be inverted.
---@field Multiplier number  Scale factor of the color.
---@field IsPhotonColor boolean
local meta = exmeta.New()

meta.Color = Color( 255, 255, 255 )
meta.Alpha = false
meta.IsPhotonColor = true
meta.Inverted = false
meta.Multiplier = 1

local metaTable = { __index = meta, __call = meta.New }

function meta.New( r, g, b, a )
	local result = {}
	if ( isnumber( a ) ) then result.Alpha = true end
	if ( isnumber( r ) or ( r == nil ) ) then
		result.r = r or 255
		result.g = g or 255
		result.b = b or 255
		result.a = a or 255
	elseif ( istable(r) and r.IsPhotonColor ) then
		result.r = r.r or 255
		result.g = r.g or 255
		result.b = r.b or 255
		result.a = r.a or 255
		result.Alpha = r.Alpha
	end

	return setmetatable( result, { __index = meta } )
end

function meta:Scale( multiplier )
	self.Multiplier = multiplier

	-- if ( isnumber( multiplier ) ) then
	-- 	self.r = self.r * multiplier
	-- 	self.g = self.g * multiplier
	-- 	self.b = self.b * multiplier
	-- 	if ( self.Alpha ) then self.a = self.a * multiplier end
	-- elseif ( istable(  multiplier ) ) then
	-- 	self.r = self.r * multiplier[1]
	-- 	self.g = self.g * multiplier[2]
	-- 	self.b = self.b * multiplier[3]
	-- 	if ( self.Alpha ) then self.a = self.a * multiplier[4] end
	-- end
	return self
end

function meta:GetScaled( multiplier )
	return meta.New( self ):Scale( scale )
end

function meta:Negative( isNegative )
	self.Inverted = isNegative
	-- self.r = 255 - self.r
	-- self.g = 255 - self.g
	-- self.b = 255 - self.b
	-- if ( self.Alpha ) then self.a = 255 - self.a end

	return self
end

function meta:GetNegative()
	return meta.New( self ):Negative()
end

function meta:GreenShiftBlue( value )
	self.r = self.r - value
	self.g = self.g + value
	return self
end

function meta:GreenShiftRed( value )
	self.b = self.b - value
	self.g = self.g + value
	return self
end

function meta:Blend( blendColor )
	self.BlendColor = blendColor
	return self
end

function meta:GetBlendColor()
	local blendColor = self.BlendColor

	if ( not blendColor ) then
		blendColor = {
			r = self.r,
			g = self.g,
			b = self.b
		}
	end

	local from = { r = blendColor.r, g = blendColor.g, b = blendColor.b }
	local to = { r = self.r, g = self.g, b = self.b }

	if ( self.Inverted ) then
		from.r = 255 - from.r
		from.g = 255 - from.g
		from.b = 255 - from.b

		to.r = 255 - to.r
		to.g = 255 - to.g
		to.b = 255 - to.b
	end

	from.r = from.r * self.Multiplier
	from.g = from.g * self.Multiplier
	from.b = from.b * self.Multiplier

	to.r = to.r * self.Multiplier
	to.g = to.g * self.Multiplier
	to.b = to.b * self.Multiplier

	return PhotonBlendColor.New( from, to, 1, self.Inverted )
end

-- meta.__call = meta.New
-- meta.__index = meta