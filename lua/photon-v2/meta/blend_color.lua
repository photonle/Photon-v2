if (exmeta.ReloadFile()) then return end

NAME = "PhotonBlendColor"

local print = Photon2.Debug.Pring
local printf = Photon2.Debug.PrintF

--TODO: verify functionality with inverted colors

-- Color derived from the blending of two colors (from => to).
---@class PhotonBlendColor
---@field From RGB
---@field To RGB
---@field Blend number
---@field Inverted boolean
local meta = exmeta.New()

meta.IsPhotonBlendColor = true
meta.From = { r = 0, g = 0, b = 0 }
meta.To = { r = 255, g = 255, b = 255 }
meta.Blend = 1

---@param from RGB Color to blend from.
---@param to RGB Color to blend to.
---@param blend? number Static blend multiplier.
function meta.New( from, to, blend, inverted )
	return setmetatable({
		From = { r = from.r, g = from.g, b = from.b },
		To = { r = to.r, g = to.g, b = to.b },
		Blend = blend or 1,
		Inverted = inverted or false
	}, { __index = meta } )
end

---@param blendAmount number
---@return RGB
function meta:Compute( blendAmount )
	blendAmount = (blendAmount or 1) * self.Blend
	return {
		r = self.From.r + (( self.To.r - self.From.r ) * blendAmount ),
		g = self.From.g + (( self.To.g - self.From.g ) * blendAmount ),
		b = self.From.b + (( self.To.b - self.From.b ) * blendAmount )
	}
end

function meta:ComputeClamped( blendAmount )
	local result = self:Compute( blendAmount )
	result.r = math.Clamp( result.r, 0, 255 )
	result.g = math.Clamp( result.g, 0, 255 )
	result.b = math.Clamp( result.b, 0, 255 )
	return result
end

-- Returns a new PhotonBlendColor derived from an existing one, modifying only the value of `.Blend`.
function meta:Derive( blendAmount )
	return meta.New( self.From, self.To, self.Blend * blendAmount )
end

function meta.ComputeEx( fromR, fromG, fromB, toR, toG, toB, amount )
	return
		( fromR + ( toR - fromR ) * amount ),
		( fromG + ( toG - fromG ) * amount ),
		( fromB + ( toB - fromB ) * amount )
end

function meta.ComputeIntensityEx( fromR, fromG, fromB, toR, toG, toB, amount )
	return
		( fromR + ( toR - fromR ) * amount ) * amount,
		( fromG + ( toG - fromG ) * amount ) * amount,
		( fromB + ( toB - fromB ) * amount ) * amount
end

function meta.ComputeIntensityExClamped( fromR, fromG, fromB, toR, toG, toB, amount )
	return
		math.Clamp(( fromR + ( toR - fromR ) * amount ) * amount, 0, 255),
		math.Clamp(( fromG + ( toG - fromG ) * amount ) * amount, 0, 255),
		math.Clamp(( fromB + ( toB - fromB ) * amount ) * amount, 0, 255)
end