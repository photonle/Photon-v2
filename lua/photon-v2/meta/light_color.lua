if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightColor"

---@class PhotonLightColor
---@field r number
---@field g number
---@field b number
---@field TargetR number
---@field TargetG number
---@field TargetB number
---@field BlendR number
---@field BlendG number
---@field BlendB number
---@field Inverted boolean
---@field Intensity number
---@field AddIntensity number
local LightColor = exmeta.New()

local blendIntensity = true

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
end

---@param data PhotonLightColor
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
		AddIntensity = data.AddIntensity or 0
	}, { __index = LightColor } )
end

setmetatable( LightColor, LightColor )