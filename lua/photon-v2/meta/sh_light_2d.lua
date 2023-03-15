if (exmeta.ReloadFile("photon-v2/meta/sh_light_2d.lua")) then return end

NAME = "PhotonLight2D"
BASE = "PhotonLight"

---@class PhotonLight2D : PhotonLight
---@field PixVisHandle PixVisHandle
local Light = META

Light.LocalPosition = Vector(0, 0, 0)
Light.LocalAngles = Angle(0, 0, 0)

Light.Texture = "sprites/emv/circular_src"
Light.Width = 1
Light.Height = 1
Light.Scale = 1
Light.Ratio = 1

Light.DrawSource = true
Light.DrawGlow = true

function Light:Render()
end

function Light:Initialize()
	self = PhotonLight.Initialize(self)

	return self
end