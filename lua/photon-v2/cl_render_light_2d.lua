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

local mat1 = Material("sprites/emv/flare_secondary")


local sosSubTest = Material("photon/lights/sos_nforce_main_bloom_transparent.png", "nocull ignorez vertexalpha vertexcolor")
sosSubTest:SetInt("$translucent", 1 )
sosSubTest:Recompute()

local matIntensitySquare = PhotonDynamicMaterial.Create( "ph2/mat_intensity_square9", {
	"VertexLitGeneric",
		["$basetexture"] = sosSubTest:GetTexture("$basetexture"),
		-- ["$basetexture"] = "photon/sprites/glow_intense_sq_512.png",
		["$nocull"] = 1,
		["$additive"] = 1,
		["$vertexalpha"] = 1,
		["$vertexcolor"] = 1,
		["$ignorez"] = 1
} )

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
		debugoverlay.Text(position, light.Id .. "(" .. tostring(  math.Round(light.ViewDot * 100) ) .. ") VIS: " .. tostring(math.Round(light.Visibility * 100)) .. "%", 0, false)
		end
	end
end

local spread = 2

function Photon2.RenderLight2D.Render()
	local activeLights = this.Active

	if ( drawLights:GetBool() ) then
	-- Draw glow effect sprites
	

	-- cam.Start3D( EyePos(), EyeAngles() )
	-- Draw light sources
	if (drawGlow) then
		for i=1, #activeLights do
			light = activeLights[i] --[[@as PhotonLight2D]]
			if ( not light or not light.ShouldDraw ) then continue end
			render.SetMaterial( mat1 )

			render.DrawSprite( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), (24 * light.Scale) * light.ViewDot, (24 * light.Scale) * light.ViewDot, light.GlowColor)
			render.DrawSprite( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), (16 * light.Scale) * light.ViewDot, (16 * light.Scale) * light.ViewDot, light.InnerGlowColor)

			render.DrawSprite( light.Position + (light.RightNormal * spread) + (light.Angles:Forward() * light.ForwardBloomOffset), (24 * light.Scale) * light.ViewDot, (24 * light.Scale) * light.ViewDot, light.GlowColor)
			render.DrawSprite( light.Position + (light.RightNormal * spread) + (light.Angles:Forward() * light.ForwardBloomOffset), (16 * light.Scale) * light.ViewDot, (16 * light.Scale) * light.ViewDot, light.InnerGlowColor)
			render.DrawSprite( light.Position + (light.RightNormal * -spread) + (light.Angles:Forward() * light.ForwardBloomOffset), (24 * light.Scale) * light.ViewDot, (24 * light.Scale) * light.ViewDot, light.GlowColor)
			render.DrawSprite( light.Position + (light.RightNormal * -spread) + (light.Angles:Forward() * light.ForwardBloomOffset), (16 * light.Scale) * light.ViewDot, (16 * light.Scale) * light.ViewDot, light.InnerGlowColor)
		end
	end
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if ( not light or not light.ShouldDraw ) then continue end
		local angles = light.Angles
		local position = light.Position

		-- cam.Start3D2D( light.Position, light.Angles, 1 )
		-- light.Matrix
		-- render.OverrideBlend( true, BLEND_SRC_COLOR, BLEND_DST_COLOR, BLENDFUNC_MAX )
		if (drawQuadSprite) then
			-- render.SetMaterial( sosSubTest )
			-- render.OverrideAlphaWriteEnable( true, true )
			render.SetMaterial( light.MaterialBloom )
			-- render.SetLightingMode(0)
			-- render.SetMaterial( spriteHint )
			-- render.OverrideBlend( true, BLEND_SRC_COLOR, BLEND_DST_COLOR, BLENDFUNC_MIN )
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * 0.1), light.Angles:Forward(), light.Width * 1.25, light.Height * 0.4, Color(255,255,255,0), 180)
			render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), light.Width * 1, light.Height * 1, ColorAlpha(light.GlowColor, ((255 * ((light.ViewDot * 10) + 0.9)) *  light.Visibility)), light.Angles[3] - 180)
			-- render.OverrideAlphaWriteEnable( false, false )
			-- render.SetLightingMode(0)
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), light.Width * 1.2, light.Height * 1.2, ColorAlpha(light.GlowColor, ((255 * ((light.ViewDot * 10) + 0.3)) *  light.Visibility)), 180)
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), light.Width * 0.8, light.Height * 1.5, ColorAlpha(light.GlowColor, ((255 * ((light.ViewDot * 10) + 0.3)) *  light.Visibility)), 180)
			-- render.DrawQuadEasy( light.Position + (light.Angles:Forward() * light.ForwardBloomOffset), light.Angles:Forward(), light.Width * 0.4, light.Height * 1.5, ColorAlpha(light.GlowColor, ((255 * ((light.ViewDot * 10) + 0.3)) *  light.Visibility)), 180)
		end
		-- render.OverrideBlend( false, 0, 0, 0 )
		cam.Start3D2D( position, angles, 1 )

			-- render.SetLightingMode( 1 )
			render.SetMaterial( light.Material )
			render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, light.SourceFillColor )
			
			render.SetMaterial( light.MaterialOverlay )
			render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, light.SourceDetailColor )
			-- render.SetLightingMode( 0 )

		cam.End3D2D()


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