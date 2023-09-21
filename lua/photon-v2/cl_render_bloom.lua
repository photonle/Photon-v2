Photon2.RenderBloom = Photon2.RenderBloom or {}

local copyMaterial = Material( "pp/copy" )
local additiveMaterial = Material( "pp/add" )
local subtractiveMaterial = Material( "pp/sub" )

local storeRenderTarget = render.GetScreenEffectTexture( 0 )
local blurRenderTarget = render.GetScreenEffectTexture( 1 )

-- local storeRenderTarget = render.GetBloomTex0()
-- local blurRenderTarget = render.GetBloomTex1()

local storeRT = GetRenderTargetEx( "Photon2_RT", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, bit.bor(2, 256), 0, IMAGE_FORMAT_BGRA8888 )
local storeRT2 = GetRenderTargetEx( "Photon2_RT3", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, bit.bor(2, 256), 0, IMAGE_FORMAT_BGRA8888 )

local bloomTex2 = GetRenderTargetEx( "Photon2_RT4", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, bit.bor(2, 256), 0, IMAGE_FORMAT_BGRA8888 )

local bloomEnabled = true

local bloomBlur = 4
local bloomPasses = 2
local blurPasses = 1

local bloomBlurX = bloomBlur
local bloomBlurY = bloomBlur

---@param additive boolean Additive bloom pass.
function Photon2.RenderBloom.Render( additive, blurX, blurY, passes )

	local scene = render.GetRenderTarget()
	render.CopyRenderTargetToTexture( storeRenderTarget )

	if ( additive ) then
		render.Clear( 0, 0, 0, 255, false, true )
	else
		render.Clear( 255, 255, 255, 255, false, true )
	end

	cam.Start3D()
		render.SetStencilEnable( true )
		render.SuppressEngineLighting( true )
		render.SetStencilWriteMask( 1 )
		render.SetStencilTestMask( 1 )
		render.SetStencilReferenceValue( 1 )

		render.SetStencilCompareFunction( STENCIL_ALWAYS )
		render.SetStencilPassOperation( STENCIL_REPLACE )
		render.SetStencilFailOperation( STENCIL_KEEP )
		render.SetStencilZFailOperation( STENCIL_KEEP )

		Photon2.RenderLightMesh.Render()
		render.CopyRenderTargetToTexture( storeRT2 )


		-- RENDER MESHES
		Photon2.RenderLightMesh.DrawBloom()
		Photon2.RenderLight2D.DrawBloom()

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilPassOperation( STENCIL_KEEP )
		
		render.SuppressEngineLighting( false )
		render.SetStencilEnable( false)
	cam.End3D()

	
	render.CopyRenderTargetToTexture( blurRenderTarget )
	render.CopyRenderTargetToTexture( bloomTex2 )
	-- render.BlurRenderTarget( blurRenderTarget, 0, 0, 0 )
	render.BlurRenderTarget( blurRenderTarget, blurX, blurY, blurPasses )
	render.CopyRenderTargetToTexture( storeRT )
	
	render.BlurRenderTarget( bloomTex2, 1, 1, 1 )


	render.SetRenderTarget( scene )
	copyMaterial:SetTexture( "$basetexture", storeRenderTarget )
	copyMaterial:SetVector( "$color", Vector(1,1,1) )
	render.SetMaterial( copyMaterial )
	render.DrawScreenQuad()

	-- render.SetStencilEnable( !additive )
	-- 	render.SetStencilCompareFunction( STENCIL_NOTEQUAL )

	-- 	if ( additive ) then
	-- 		-- additiveMaterial:SetTexture( "$basetexture", storeRT )
	-- 		-- additiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
	-- 		-- render.SetMaterial( additiveMaterial )
	-- 	else
	-- 		subtractiveMaterial:SetTexture( "$basetexture", storeRT )
	-- 		-- subtractiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
	-- 		render.SetMaterial( subtractiveMaterial )
	-- 	end

	-- 	-- for i=0, bloomPasses do
	-- 	-- 	render.DrawScreenQuad()
	-- 	-- end

	-- render.SetStencilEnable( false )

	-- render.SetStencilTestMask( 0 )
	-- render.SetStencilWriteMask( 0 )
	-- render.SetStencilReferenceValue( 0 )

end

function Photon2.RenderBloom.DrawAdditive()
	

	additiveMaterial:SetTexture( "$basetexture", storeRT )
	render.SetMaterial( additiveMaterial )
	for i=0, bloomPasses do
		render.DrawScreenQuad()
	end

	additiveMaterial:SetTexture( "$basetexture", bloomTex2 )
	for i=0, bloomPasses*2 do
		render.DrawScreenQuad()
	end

	additiveMaterial:SetTexture( "$basetexture", storeRT2 )
	render.DrawScreenQuad()
end

local inPreDraw = false

hook.Add( "PreDrawTranslucentRenderables", "Photon2.RenderBloom:Render", function (depth, sky, sky3d)
	if (depth or sky or sky3d) then return end
	if (bloomEnabled and inPreDraw) then
		Photon2.RenderBloom.Render( true, bloomBlurX, bloomBlurY, blurPasses )
		-- Photon2.RenderBloom.Render( false, 4, 4, 1 )
	end
end)


hook.Add( "PostDrawTranslucentRenderables", "Photon2.RenderBloom:Draw", function( depth, sky )
	if ( depth or sky ) then return end
	if ( not inPreDraw ) then Photon2.RenderBloom.Render( true, bloomBlurX, bloomBlurY, blurPasses ) end
	Photon2.RenderBloom.DrawAdditive()
end )