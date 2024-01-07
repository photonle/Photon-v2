if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementColor"


---@class PhotonElementColor
---@field r number Current value of red channel.
---@field g number Current value of green channel.
---@field b number Current value of blue channel.
---@field a number Current value of alpha channel.
---@field TargetR number Red channel target value.
---@field TargetG number Green channel target value.
---@field TargetB number Blue channel target value.
---@field TargetA number Alpha channel target value.
---@field BlendR number Blend color red channel.
---@field BlendG number Blend color green channel.
---@field BlendB number Blend color blue channel.
---@field BlendA number Blend color alpha channel.
---@field Inverted boolean If color should be inverted.
---@field Intensity number Current intensity of the color.
---@field AddIntensity number Static value to always add to the intensity.
---@field Vector Vector The current color as a normalized vector.
local LightColor = exmeta.New()

local blendIntensity = true

-- NOTE: Color is only actually updated when the intensity is set.
function LightColor:SetIntensity( intensity )
	intensity = intensity + ( self.AddIntensity * intensity )

	if ( intensity > 1 ) then intensity = 1 end

	if ( blendIntensity ) then
		self.r, self.g, self.b = 
			PhotonBlendColor.ComputeIntensityExClamped( 
				self.BlendR,
				self.BlendG,
				self.BlendB,
				self.TargetR,
				self.TargetG,
				self.TargetB,
				intensity
			)
	else
		self.r = self.TargetR * intensity
		self.g = self.TargetG * intensity
		self.b = self.TargetB * intensity
	end

	if ( self.Inverted ) then
		self.r = 255 - self.r
		self.g = 255 - self.g
		self.b = 255 - self.b
	end

	self.Intensity = intensity

	self.Vector[1] = self.r / 255
	self.Vector[2] = self.g / 255
	self.Vector[3] = self.b / 255
end

---@param color PhotonBlendColor | RGB
function LightColor:SetTarget( color )
	-- Assume color isn't defined on state
	if not color then return end

	if ( color.IsPhotonBlendColor ) then
		self.TargetR = color.To.r
		self.TargetG = color.To.g
		self.TargetB = color.To.b
		self.BlendR = color.From.r
		self.BlendG = color.From.g
		self.BlendB = color.From.b
	else
		self.TargetR = color.r
		self.TargetG = color.g
		self.TargetB = color.b
		self.BlendR = color.r
		self.BlendG = color.g
		self.BlendB = color.b
	end
	
	
end

---@param color Color
---@param intensity? number
function LightColor:Set( color, intensity )
	if not color then return end
	self:SetTarget( color )
	self:SetIntensity( intensity or 1 )
end

-- Sets current color value to the target color.
function LightColor:Reset()
	self.r = self.TargetR
	self.g = self.TargetG
	self.b = self.TargetB

	self.Vector[1] = self.r / 255
	self.Vector[2] = self.g / 255
	self.Vector[3] = self.b / 255
end

function LightColor:GetVector()
	local result = Vector(
		self.r / 255,
		self.g / 255,
		self.b / 255
	)
	return result
end

function LightColor:GetColor()
	return Color( self.r, self.g, self.b )
end

---@param data PhotonElementColor
function LightColor:__call( data )
	data = data or {}
	return setmetatable( {
		r = data.r or 0,
		g = data.g or 0,
		b = data.b or 0,
		Inverted = data.Inverted or false,
		TargetR = 0,
		TargetG = 0,
		TargetB = 0,
		BlendR = 0,
		BlendG = 0,
		BlendB = 0,
		Intensity = 1,
		AddIntensity = data.AddIntensity or 0,
		Vector = Vector(),
	}, { __index = LightColor } )
end

setmetatable( LightColor, LightColor )