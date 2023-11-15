Photon2.Render = Photon2.Render or {}

local Render = Photon2.Render

local surface = surface
local render = render
local cam = cam
local hook = hook
local ScrH = ScrH
local ScrW = ScrW

local mat_Copy		= Material("pp/copy")
local mat_BlurX		= Material("pp/blurx")
local mat_BlurY		= Material("pp/blury")
local mat_Bloom 	= Material("pp/bloom")
local mat_Blank 	= Material("photon/common/blank")

local rt_Store		= GetRenderTarget( "photon2/rt/store/" .. math.Round( CurTime() ), ScrW(), ScrH() )
local rt_Scene		= nil

-- function Photon2.Render.RunQueue( domain, alternateTable )
-- 	local activeLights = domain.Active
-- 	local nextTable = alternateTable

-- 	for i=1, #activeLights do 
-- 		if ( activeLights[i] ) then
-- 			nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
-- 		end
-- 		activeLights[i] = nil
-- 	end

-- 	alternateTable = activeLights
-- 	domain.Active = nextTable
-- end

function Photon2.Render.Paint2D( id, func, callback)
	local hookId = "Photon2:Paint2D/" .. tostring(id)
	hook.Add( "HUDPaint", hookId, function()
		hook.Remove( "HUDPaint", hookId )
		local success, err = pcall( func )
		if ( not success ) then
			ErrorNoHaltWithStack( err )
		end
		if ( isfunction ( callback ) ) then callback( id ) end
	end)
end


function Photon2.Render.RenderToMaterial( id, material, textureType, renderTarget, renderFunc, renderFuncParams, callback )
	Render.Paint2D( "RenderToMaterial/" .. tostring(id), function()
		surface.DisableClipping( true )
		render.PushRenderTarget( renderTarget )
		cam.Start2D()
			render.Clear( 0, 0, 0, 0, true, true )
			render.OverrideAlphaWriteEnable( true, true )
			renderFunc( renderFuncParams )
		cam.End2D()
		material:SetTexture( textureType, renderTarget )
		render.PopRenderTarget()
		surface.DisableClipping( false )
	end, callback )
end


-- Blurs render target without down sampling (for higher fidelity).
function Photon2.Render.BlurRenderTargetFullRes( rt, sizeX, sizeY, passes )
	mat_BlurX:SetTexture( "$basetexture", rt )
	mat_BlurY:SetTexture( "$basetexture", rt )
	mat_BlurX:SetFloat( "$size", sizeX )
	mat_BlurY:SetFloat( "$size", sizeY )

	render.SetColorModulation( 1, 1, 1 )
	for i=0, passes do
		render.SetMaterial( mat_BlurY )
		render.DrawScreenQuad()
		render.SetMaterial( mat_BlurX )
		render.DrawScreenQuad()
	end

end


function Photon2.Render.DrawScreenMaterial( material )
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( material )
	surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
end

---@param texture ITexture
---@param blurSize number
---@param passes integer
function Photon2.Render.GenerateBlurredTexture( texture, blurSize, passes )
	local id = string.format("%s(blur:%s,%s)", texture:GetName(), blurSize, passes )
	local blurredTexture = GetRenderTarget( id, texture:Width(), texture:Height())
	Render.Paint2D("BlurTexture" .. tostring(id), function()
		render.CopyTexture( texture, blurredTexture )
		DisableClipping( true )
		render.PushRenderTarget( blurredTexture )
		cam.Start2D()
			-- render.Clear( 0, 0, 0, 255, true, true )
			render.OverrideAlphaWriteEnable( true, true )
			Render.BlurRenderTargetFullRes( blurredTexture, blurSize, blurSize, passes )
		cam.End2D()
		render.PopRenderTarget()
		DisableClipping( false )
	end)
	return blurredTexture
end

--[[
		Dynamic Light Manager
--]]

Photon2.Render.DynamicLighting = Photon2.Render.DynamicLighting or {
	Active = {},
	Index = 800000
}

local DynamicLighting = Photon2.Render.DynamicLighting

local dynamicLightAlternatveActive = {}

function DynamicLighting.GetNextIndex()
	DynamicLighting.Index = DynamicLighting.Index + 1
	return DynamicLighting.Index
end

function DynamicLighting.Update()
	local activeLights = DynamicLighting.Active
	local nextTable = dynamicLightAlternatveActive

	for i=1, #activeLights do 
		if ( activeLights[i] ) then
			nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
		end
		activeLights[i] = nil
	end

	dynamicLightAlternatveActive = activeLights
	DynamicLighting.Active = nextTable
end
hook.Add( "PreRender", "Photon2.ElementDynamicLight:Update", DynamicLighting.Update )

function DynamicLighting.DrawDebug()
	if ( not overlayConVar:GetBool() ) then return end

	local activeLights = DynamicLighting.Active
	
	local light
	cam.Start3D()
		for i=1, #activeLights do 
			light = activeLights[i]
			local angles = light.Angles
			local position = light.Position
			render.DrawLine(position, position + angles:Up() * 3, Color(0,0,255))
			render.DrawLine(position, position + angles:Right() * 3, Color(255,0,0))
			render.DrawLine(position, position + angles:Forward() * 3, Color(0,255,0))
			debugoverlay.Text( position, light.Id, 0, false )
		end
	cam.End3D()
end