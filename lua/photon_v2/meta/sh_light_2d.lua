if (exmeta.ReloadFile("photon_v2/meta/sh_light_2d.lua")) then return end

NAME = "photon_light_2d"
BASE = "photon_light_base"

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