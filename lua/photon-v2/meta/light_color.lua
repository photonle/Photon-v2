if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightColor"

---@class PhotonLightColor
---@field r number
---@field g number
---@field b number
---@field TargetR number
---@field TargetG number
---@field TargetB number
---@field Intensity number
---@field AddIntensity number
local LightColor = exmeta.New()

function LightColor:SetIntensity( intensity )
	intensity = intensity + ( self.AddIntensity * intensity )

	if ( intensity > 1 ) then intensity = 1 end

	self.r = self.TargetR * intensity
	self.g = self.TargetG * intensity
	self.b = self.TargetB * intensity

	self.Intensity = intensity
end

---@param color Color
function LightColor:SetTarget( color )
	-- Assume color isn't defined on state
	if not color then return end
	self.TargetR = color.r
	self.TargetG = color.g
	self.TargetB = color.b
end

---@param color Color
---@param intensity? number
function LightColor:Set( color, intensity )
	if not color then return end

	self.TargetR = color.r
	self.TargetG = color.g
	self.TargetB = color.b

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
		TargetR = 0,
		TargetG = 0,
		TargetB = 0,
		Intensity = 1,
		AddIntensity = data.AddIntensity or 0
	}, { __index = LightColor } )
end

setmetatable( LightColor, LightColor )