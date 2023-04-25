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

local spriteParams = {
	["$nocull"] = 1,
	["$additive"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1
}

local mat1 = Material("sprites/emv/flare_secondary")
local matIntensitySquare512Png = Material("photon/sprites/glow_intense_sq_512.png")
local matIntensitySquare512 = matIntensitySquare512
if (not matIntensitySquare512) then
	timer.Simple(10, function()
		matIntensitySquare512 = CreateMaterial("photon2/sprite/glow_intense_sq_512", "UnLitGeneric", {
			["$basetexture"] = matIntensitySquare512Png:GetTexture("$basetexture"):GetName(),
			["$nocull"] = 1,
			["$additive"] = 1,
			["$vertexalpha"] = 1,
			["$vertexcolor"] = 1,
			["$ignorez"] = 1
		})
	end)
end

local spriteHint = Material("photon/debug/sprite_hint")

-- matIntensitySquare512:Recompute()



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
		debugoverlay.Text(position, light.Id .. "(" .. tostring(  math.Round(light.ViewDot * 100) )  .. "/" .. math.Round(light.ViewAngleDot * 100) .. ") VIS: " .. tostring(math.Round(light.Visibility * 100)) .. "%", 0, false)
		end
	end
end

function Photon2.Light2D.Render()
	local activeLights = this.Active

	if ( drawLights:GetBool() ) then
	-- Draw glow effect sprites
	

	-- cam.Start3D( EyePos(), EyeAngles() )
	-- Draw light sources
	for i=1, #activeLights do
		light = activeLights[i] --[[@as PhotonLight2D]]
		if ( not light or not light.ShouldDraw ) then continue end
		render.SetMaterial( mat1 )
		render.DrawSprite( light.Position, (32 * light.Scale) * light.ViewDot, (32 * light.Scale) * light.ViewDot, light.GlowColor)
		render.DrawSprite( light.Position, (16 * light.Scale) * light.ViewDot, (16 * light.Scale) * light.ViewDot, light.GlowColor)
		-- render.SetMaterial( matIntensitySquare512 )
		-- render.DrawSprite( light.Position, (6 * light.Ratio) * light.ViewDot, 6 * light.ViewDot, light.GlowColor)
	end
		for i=1, #activeLights do
			light = activeLights[i] --[[@as PhotonLight2D]]
			if ( not light or not light.ShouldDraw ) then continue end
			local angles = light.Angles
			local position = light.Position

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
			render.SetMaterial( matIntensitySquare512 )
			render.DrawQuadEasy( light.Position, light.Angles:Forward(), (6 * light.Ratio), 6, ColorAlpha(light.GlowColor, ((255 * ((light.ViewDot * 10) + 0.3)) *  light.Visibility)))

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