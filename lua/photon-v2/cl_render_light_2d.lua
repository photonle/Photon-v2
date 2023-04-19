Photon2.Light2D = Photon2.Light2D or {
	---@type PhotonLight2D[]
	Active = {},
}

local alternateActive = {}

local this = Photon2.Light2D

local overlayConVar = GetConVar("ph2_debug_light_overlay")
local drawLights = GetConVar("ph2_draw_light2d")

function Photon2.Light2D.OnPreRender()
	local activeLights = this.Active
	local nextTable = alternateActive

	for i=1, #activeLights do
		nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
		activeLights[i] = nil
	end

	alternateActive = activeLights
	this.Active = nextTable
end
hook.Add( "PreRender", "Photon2.Light2D:OnPreRender", this.OnPreRender )
-- hook.Remove( "PreRender", "Photon2.Light2D:OnPreRender")
 
local mat1 = Material("sprites/emv/flare_secondary")
local spriteHint = Material("photon/debug/sprite_hint")

local light

function Photon2.Light2D.DrawDebug()
	local activeLights = this.Active
	-- line/dev testing
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if (light.ShouldDraw) then
		-- local angles = light.Matrix:GetAngles()
		-- local position = light.Matrix:GetTranslation()

		local angles = light.Angles
		local position = light.Position

		cam.Start3D2D( position, angles, 1 )
			render.SetMaterial(spriteHint)
			render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, Color(0, 255, 0) )
		cam.End3D2D()

		render.DrawLine(position, position + angles:Up() * 3, Color(0,0,255))
		render.DrawLine(position, position + angles:Right() * 3, Color(255,0,0))
		render.DrawLine(position, position + angles:Forward() * 3, Color(0,255,0))
		debugoverlay.Text(position, light.Id .. " (\n" .. tostring(  math.Round(light.ViewDot * 100) ) .. "%)\nVIS: " .. tostring(light.Visibility * 100) .. "%", 0, false)
		end
	end
end

function Photon2.Light2D.Render()
	local activeLights = this.Active

	if ( drawLights:GetBool() ) then
	-- Draw glow effect sprites
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if (not light.ShouldDraw) then continue end
		render.SetMaterial( mat1 )
		render.DrawSprite( light.Position, 24 * light.ViewDot, 24 * light.ViewDot, light.GlowColor)
	end

	-- cam.Start3D( EyePos(), EyeAngles() )
	-- Draw light sources
	
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		local angles = light.Angles
		local position = light.Position
		if (not light.ShouldDraw) then continue end
		-- cam.Start3D2D( light.Position, light.Angles, 1 )
		-- light.Matrix
		cam.Start3D2D( position, angles, 1 )

			-- -- render.SetLightingMode( 1 ) ??? 
			render.SetMaterial( light.Material )
			render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, light.SourceFillColor )
			render.SetMaterial( light.MaterialOverlay )
			render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, light.SourceDetailColor )
			-- -- render.SetLightingMode( 0 ) ???

		cam.End3D2D()
	end
	end
	-- cam.End3D()
	if (overlayConVar:GetBool()) then
		this.DrawDebug()
	end
	
end
hook.Add( "PreDrawEffects", "Photon2.Light2D:Render", this.Render )