if (exmeta.ReloadFile()) then return end

NAME = "_PhotonColor"
-- BASE = "Color"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

-- An advanced Color class
---@class PhotonColor : Color
---@field r number
---@field g number
---@field b number
---@field a number
---@field Color Color
---@field Alpha boolean
---@field IsPhotonColor boolean
local meta = exmeta.New()

meta.Color = Color( 255, 255, 255 )
meta.Alpha = false
meta.IsPhotonColor = true

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
	if ( isnumber( multiplier ) ) then
		self.r = self.r * multiplier
		self.g = self.g * multiplier
		self.b = self.b * multiplier
		if ( self.Alpha ) then self.a = self.a * multiplier end
	elseif ( istable(  multiplier ) ) then
		self.r = self.r * multiplier[1]
		self.g = self.g * multiplier[2]
		self.b = self.b * multiplier[3]
		if ( self.Alpha ) then self.a = self.a * multiplier[4] end
	end
	return self
end

function meta:GetScaled( multiplier )
	return meta.New( self ):Scale( scale )
end

function meta:Negative()
	self.r = 255 - self.r
	self.g = 255 - self.g
	self.b = 255 - self.b
	if ( self.Alpha ) then self.a = 255 - self.a end
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

-- meta.__call = meta.New
-- meta.__index = meta