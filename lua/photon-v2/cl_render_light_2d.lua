Photon2.RenderLight2D = Photon2.RenderLight2D or {
	---@type PhotonLight2D[]
	Active = {},
}

local alternateActive = {}

local this = Photon2.RenderLight2D

local overlayConVar = GetConVar("ph2_debug_light_overlay")
local drawLights = GetConVar("ph2_draw_light2d")


local render = render

---@param color PhotonLightColor
local function invertColor( color )
	return color
	-- return { r = 0, g = 255, b = 512, a = 512 }
	-- return { r = (255 - color.TargetR) * color.Intensity, g = (255 - (color.TargetG * 2)) * color.Intensity, b = (255 - color.TargetB) * color.Intensity, a = 0 }
	-- return { r = 0, g = 0, b = 0, a = 0 }
	-- return { r = 255 - color.r, g = 255 - color.g, b = 255 - color.b, a = 255 }
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



--[[
		RENDER OPTIONS		
--]]
local drawDetail 		= true
local drawShape 		= true
local drawBloom 		= true
local drawSubtractive 	= true
local drawAdditive 		= true

local drawGlow 			= true
local drawQuadSprite 	= true


function Photon2.RenderLight2D.DrawBloom()
	local activeLights = this.Active
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if ( light.Shape and drawShape ) then
			render.SetMaterial( light.Shape )
			-- render.OverrideBlend( true, 1, 1, 2, 0, 0, 0 )
				-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, invertColor( light.SourceFillColor ), light.Angles[3] - 180 )
				-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, Color(255,255,255,0), light.Angles[3] - 180 )
			-- render.OverrideBlend( false )
			render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.ShapeGlowColor, light.Angles[3] - 180 )
		end
	end
end

--[[
		SPRITE SCALE OPTIONS
--]]

local glowSize 	= 8
local subtractiveGlowMid = glowSize * 0.5
local subtractiveGlowOuter = glowSize * 2
local glow1 = subtractiveGlowOuter * 2
local glow2 = glowSize * 3

function Photon2.RenderLight2D.Render()
	-- if true then return end
	-- render.SetGoalToneMappingScale(090)
	-- render.SetAmbientLight(512,0,0)
	-- render.SetColorModulation(255,255,0)
	-- render.OverrideBlendFunc()

	render.OverrideColorWriteEnable( true, true )
	local activeLights = this.Active

	-- benchmark test

	-- local vectors = {}
	-- for i=1, 100 do
	-- 	local x = Vector( 10 + i, 20 + i, 30 + i ) * i
	-- 	vectors[#vectors+1] = x
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
					render.DrawSprite( light.EffectPosition, (subtractiveGlowOuter * light.Scale * light.Intensity) * light.ViewDot, (subtractiveGlowOuter * light.Scale * light.Intensity) * light.ViewDot, invertColor(light.GlowColor) )
					render.DrawSprite( light.EffectPosition, (subtractiveGlowMid * light.Scale * light.Intensity) * light.ViewDot, (subtractiveGlowMid * light.Scale * light.Intensity) * light.ViewDot, invertColor(light.SubtractiveMid) )
					if ( light.LightMatrixEnabled ) then
						for i=1, #light.WorldLightMatrix do
							render.DrawSprite( light.WorldLightMatrix[i], (subtractiveGlowOuter * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity) * light.ViewDot, (subtractiveGlowOuter * light.Scale * light.LightMatrixScaleMultiplier * light.Intensity ) * light.ViewDot, invertColor(light.GlowColor) )
						end
					end
					render.OverrideBlend( false )
				end
				render.SetMaterial( mat1_add )
					render.DrawSprite( light.EffectPosition, (glow1 * light.Scale * light.Intensity) * light.ViewDot, (glow1 * light.Scale * light.Intensity) * light.ViewDot, ColorAlpha(light.InnerGlowColor, 64) )
				render.SetMaterial( mat_add )
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

			if ( light.Detail and drawDetail ) then
				render.SetMaterial( light.Detail )
				-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.SourceDetailColor, light.Angles[3] - 180 )
				
				render.OverrideBlend( true, 1, 1, 2, 0, 0, 0 )
					render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, invertColor( light.SourceFillColor ), light.Angles[3] - 180 )
				render.OverrideBlend( false )
				
				render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.SourceDetailColor, light.Angles[3] - 180 )
			end

			if ( light.Shape and drawDetail ) then
				render.SetMaterial( light.Shape )
				-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.SourceDetailColor, light.Angles[3] - 180 )
				
				-- render.OverrideBlend( true, 1, 1, 2, 0, 0, 0 )
					-- render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, invertColor( light.SourceFillColor ), light.Angles[3] - 180 )
				-- render.OverrideBlend( false )
				
				render.DrawQuadEasy( light.Position, light.Angles:Forward(), light.Width * 1, light.Height * 1, light.ShapeGlowColor, light.Angles[3] - 180 )
			end

		end
			
	end
	-- cam.End3D()
	if (overlayConVar:GetBool()) then
		this.DrawDebug()
	end
	render.OverrideColorWriteEnable( false, false )
	
end


-- hook.Add( "PreDrawEffects", "Photon2.Light2D:Render", this.Render )
-- hook.Remove( "PreDrawEffects", "Photon2.Light2D:Render" )
hook.Add( "PostDrawTranslucentRenderables", "Photon2.Light2D:Render", function( drawingDepth, drawingSkybox, draw3dSkybox)
	if (draw3dSkybox or drawingSkybox or draw3dSkybox) then return end
	this.Render()
end)