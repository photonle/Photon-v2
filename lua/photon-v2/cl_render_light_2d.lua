Photon2.RenderLight2D = Photon2.RenderLight2D or {
	---@type PhotonLight2D[]
	Active = {},
}

local alternateActive = {}

local this = Photon2.RenderLight2D

local overlayConVar = GetConVar("ph2_debug_light_overlay")
local drawLights = GetConVar("ph2_draw_light2d")

local drawGlow = true
local drawQuadSprite = true

--[[
		RENDER OPTIONS		
--]]
local drawDetail = true
local drawShape = true
local drawBloom = true
local drawSubtractive = true
local drawAdditive = true

local function invertColor( color )
	-- return { r = 0, g = 255, b = 512, a = 512 }
	return { r = 255 - color.r, g = 255 - color.g * 2, b = 255 - color.b, a = 255 }
end

function Photon2.RenderLight2D.OnPreRender()
	local activeLights = this.Active
	local nextTable = alternateActive

	for i=1, #activeLights do
		if (activeLights[i]) then
			nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
		end
		activeLights[i] = nil
	end

	alternateActive = activeLights
	this.Active = nextTable
end
hook.Add( "PreRender", "Photon2.Light2D:OnPreRender", this.OnPreRender )
-- hook.Remove( "PreRender", "Photon2.Light2D:OnPreRender")

local mat1 = Material("photon/sprites/sprite_generic")
-- local mat1_add = 
local mat_add = Material("sprites/emv/flare_secondary")
-- local mat1_add = Material("sprites/emv/flare_secondary")
local mat1_add = Material("photon/sprites/sprite_generic_add")

local spriteHint = Material("photon/debug/sprite_hint")

local light


local BLENDFUNC_ADD 				= 0
local BLENDFUNC_SUBTRACT 			= 1
local BLENDFUNC_REVERSE_SUBTRACT 	= 2
local BLENDFUNC_MIN 				= 3
local BLENDFUNC_MAX 				= 4

local BLEND_ZERO 					= 0
local BLEND_ONE 					= 1
local BLEND_DST_COLOR				= 2
local BLEND_ONE_MINUS_DST_COLOR		= 3
local BLEND_SRC_ALPHA				= 4
local BLEND_ONE_MINUS_SRC_ALPHA		= 5
local BLEND_DST_ALPHA				= 6
local BLEND_ONE_MINUS_DST_ALPHA		= 7
local BLEND_SRC_ALPHA_SATURATE		= 8
local BLEND_SRC_COLOR				= 9
local BLEND_ONE_MINUS_SRC_COLOR		= 10

local s = 1
local lightMatrix = {
	Vector( 0, s, 0 ),
	Vector( 0, 0, 0 ),
	Vector( 0, -s, 0)
}


function Photon2.RenderLight2D.DrawDebug()
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
		debugoverlay.Text( position, light.Id )
		-- debugoverlay.Text(position, light.Id .. "(" .. tostring(  math.Round(light.ViewDot * 100) ) .. ") VIS: " .. tostring(math.Round(light.Visibility * 100)) .. "%", 0, false)
		end
	end
end


local glowSize = 8
local subtractiveGlowMid = glowSize * 0.5
local subtractiveGlowOuter = glowSize * 2
local glow1 = subtractiveGlowOuter * 2
local glow2 = glowSize * 3

function Photon2.RenderLight2D.Render()
	local activeLights = this.Active

	-- benchmark test

	-- for i=1, 10000 do
	-- 	local x = Vector( 10, 20, 30 )
	-- end

	--

	if ( drawLights:GetBool() ) then
	-- Draw glow effect sprites
	if (drawGlow) then
		for i=1, #activeLights do
			light = activeLights[i] --[[@as PhotonLight2D]]
			if ( not light or not light.ShouldDraw or not light.DrawLightPoints ) then continue end
			
			if (drawSubtractive) then
				render.OverrideBlend( true, 1, 1, 2, 0, 0, 0 )
				render.SetMaterial( mat1 )
				render.DrawSprite( light.EffectPosition, (subtractiveGlowOuter * light.Scale * light.Intensity) * light.ViewDot, (subtractiveGlowOuter * light.Scale * light.Intensity) * light.ViewDot, light.GlowColor )
				render.DrawSprite( light.EffectPosition, (subtractiveGlowMid * light.Scale * light.Intensity) * light.ViewDot, (subtractiveGlowMid * light.Scale * light.Intensity) * light.ViewDot, light.SubtractiveMid )
				if ( light.LightMatrixEnabled ) then
					for i=1, #light.WorldLightMatrix do
						render.DrawSprite( light.WorldLightMatrix[i], (subtractiveGlowOuter * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity) * light.ViewDot, (subtractiveGlowOuter * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity ) * light.ViewDot, light.GlowColor )
					end
				end
				render.OverrideBlend( false )
			end
			render.SetMaterial( mat1_add )
			render.DrawSprite( light.EffectPosition, (glow1 * light.Scale * light.Intensity) * light.ViewDot, (glow1 * light.Scale * light.Intensity) * light.ViewDot, ColorAlpha(light.InnerGlowColor, 64) )
			render.SetMaterial( mat_add )
			-- render.DrawSprite( light.EffectPosition, (glow1 * light.Scale * light.Intensity) * light.ViewDot, (glow1 * light.Scale * light.Intensity) * light.ViewDot, ColorAlpha(light.GlowColor, 255) )
			render.DrawSprite( light.EffectPosition, (glow2 * light.Scale * light.Intensity) * light.ViewDot, (glow2 * light.Scale * light.Intensity) * light.ViewDot, ColorAlpha(light.InnerGlowColor, 255) )	
			if ( light.LightMatrixEnabled ) then
				for i=1, #light.WorldLightMatrix do
					render.DrawSprite( light.WorldLightMatrix[i], (glow2 * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity) * light.ViewDot, (glow2 * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity ) * light.ViewDot, light.InnerGlowColor )
				end
			end
		end
	end

	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if ( not light or not light.ShouldDraw or light.CurrentStateId == "OFF" ) then continue end
		local angles = light.Angles
		local position = light.Position
		if ( drawQuadSprite and drawBloom ) then
			if ( light.MaterialBloom ) then
				render.SetMaterial( light.MaterialBloom )		-- ******
				render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), (light.Width * 1)-7, (light.Height * 1)-7, ColorAlpha(light.ShapeGlowColor, ((255 * ((light.ViewDot * 10) + 0.9)) *  light.Visibility)), light.Angles[3] - 180)
			end
		end
		if ( light.Material and drawShape ) then
			render.SetMaterial( light.Material )
			render.OverrideBlend( true, 1, 1, 2 )
			-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, invertColor( light.SourceFillColor ), light.Angles[3] - 180 )
			-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, Color(255,255,255,0), light.Angles[3] - 180 )
			render.OverrideBlend( false )
			render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, ColorAlpha( light.SourceFillColor, 0 ), light.Angles[3] - 180 )
		end

		if ( light.MaterialOverlay and drawDetail ) then
			render.SetMaterial( light.MaterialOverlay )
			render.OverrideBlend( true, 1, 3, 0 )
				-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1.1, light.Height * 1.1, Color(0,0,0), light.Angles[3] - 180 )
			render.OverrideBlend( false )
			-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.SourceDetailColor, light.Angles[3] - 180 )
		end

		if ( light.MaterialBloom ) then
			render.SetMaterial( light.MaterialBloom )		-- ******
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), light.Width * 1, light.Height * 1, ColorAlpha(Color(0,255,0), ((255 * ((light.ViewDot * 10) + 0.9)) *  light.Visibility)), light.Angles[3] - 180)
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), (light.Width * 1)+1, (light.Height * 1)+1, ColorAlpha(light.SourceIntensity, ((255 * ((light.ViewDot * 10) + 0.9)) *  light.Visibility)), light.Angles[3] - 180)
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), (light.Width * 1), (light.Height * 1), ColorAlpha(Color(0,255,0), ((255 * ((light.ViewDot * 10) + 0.9)) *  light.Visibility)), light.Angles[3] - 180)
		end
	end
		
	end
	-- cam.End3D()
	if (overlayConVar:GetBool()) then
		this.DrawDebug()
	end
	
end
-- hook.Add( "PreDrawEffects", "Photon2.Light2D:Render", this.Render )
-- hook.Remove( "PreDrawEffects", "Photon2.Light2D:Render" )
hook.Add( "PostDrawTranslucentRenderables", "Photon2.Light2D:Render", function( drawingDepth, drawingSkybox, draw3dSkybox)
	if (draw3dSkybox or drawingSkybox or draw3dSkybox) then return end
	this.Render()
end)
-- hook.Remove( "PostDrawTranslucentRenderables", "Photon2.Light2D:Render" )