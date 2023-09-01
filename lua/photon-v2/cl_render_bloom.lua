Photon2.RenderBloom = Photon2.RenderBloom or {}

local copyMaterial = Material( "pp/copy" )
local additiveMaterial = Material( "pp/add" )
local subtractiveMaterial = Material( "pp/sub" )

local storeRenderTarget = render.GetScreenEffectTexture( 0 )
local blurRenderTarget = render.GetScreenEffectTexture( 1 )

local bloomEnabled = true

local bloomBlurX = 1
local bloomBlurY = 1
local bloomPasses = 4

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

		-- RENDER MESHES
		Photon2.RenderLightMesh.DrawBloom()
		Photon2.RenderLight2D.DrawBloom()

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilPassOperation( STENCIL_KEEP )

		-- cam.Start2D()
			-- surface.SetDrawColor( 0, 0, 255, 255 )
			-- surface.DrawRect( 0, 0, ScrW(), ScrH() )
		-- cam.End2D()
		
		render.SuppressEngineLighting( false )
		render.SetStencilEnable( false)
	cam.End3D()

	render.CopyRenderTargetToTexture( blurRenderTarget )
	render.BlurRenderTarget( blurRenderTarget, blurX, blurY, passes )

	render.SetRenderTarget( scene )
	copyMaterial:SetTexture( "$basetexture", storeRenderTarget )
	copyMaterial:SetVector( "$color", Vector(1,1,1) )
	render.SetMaterial( copyMaterial )
	render.DrawScreenQuad()

	render.SetStencilEnable( !additive )
		render.SetStencilCompareFunction( STENCIL_NOTEQUAL )

		if ( additive ) then
			additiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
			render.SetMaterial( additiveMaterial )
		else
			subtractiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
			render.SetMaterial( subtractiveMaterial )
		end

		for i=0, bloomPasses do
			render.DrawScreenQuad()
		end

	render.SetStencilEnable( false )

	render.SetStencilTestMask( 0 )
	render.SetStencilWriteMask( 0 )
	render.SetStencilReferenceValue( 0 )

end

hook.Add( "PostDrawEffects", "Photon2.RenderBloom:Render", function ()
	if (bloomEnabled) then
		-- Photon2.RenderBloom.Render( false, 4, 4, 1 )
		Photon2.RenderBloom.Render( true, bloomBlurX, bloomBlurY, bloomPasses )
	end
end)