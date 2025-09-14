Photon2.RenderBloom = Photon2.RenderBloom or {
	RenderTime = 0,
	DrawTime = 0
}

local drawLights = GetConVar("ph2_draw_light2d")

local copyMaterial = Material( "pp/copy" )
local additiveMaterial = Material( "pp/add" )
local subtractiveMaterial = Material( "pp/sub" )

local colorMaterial = Material( "photon/pp/color_inner" )
local colorOuter = Material( "photon/pp/color_outer" )

local textureFlags = 16 + 32768 + 32 + 4 + 8

local pp_colormod = GetConVar( "pp_colormod" )
local pp_colormod_addr = GetConVar( "pp_colormod_addr" )
local pp_colormod_addg = GetConVar( "pp_colormod_addg" )
local pp_colormod_addb = GetConVar( "pp_colormod_addb" )
local pp_colormod_brightness = GetConVar( "pp_colormod_brightness" )
local pp_colormod_contrast = GetConVar( "pp_colormod_contrast" )
local pp_colormod_color = GetConVar( "pp_colormod_color" )
local pp_colormod_mulr = GetConVar( "pp_colormod_mulr" )
local pp_colormod_mulg = GetConVar( "pp_colormod_mulg" )
local pp_colormod_mulb = GetConVar( "pp_colormod_mulb" )
local pp_colormod_inv = GetConVar( "pp_colormod_inv" )

local rtBloomOuter = GetRenderTargetEx( "Photon2_RT1", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, textureFlags, CREATERENDERTARGETFLAGS_HDR, IMAGE_FORMAT_BGRA8888 )
local rtMeshSource = GetRenderTargetEx( "Photon2_RT2", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, textureFlags, CREATERENDERTARGETFLAGS_HDR, IMAGE_FORMAT_BGRA8888 )
local rtBloomInner = GetRenderTargetEx( "Photon2_RT3", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, textureFlags, CREATERENDERTARGETFLAGS_HDR, IMAGE_FORMAT_BGRA8888 )
local storeRenderTarget = GetRenderTargetEx( "Photon2_RT4", ScrW(), ScrH(), RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, textureFlags, CREATERENDERTARGETFLAGS_HDR, IMAGE_FORMAT_BGRA8888 )

colorMaterial:SetTexture( "$fbtexture", rtBloomInner )

local additiveDrawMeshSourcePasses = GetConVar( "ph2_bloom_add_src_passes" )
local additiveDrawBloomOuterPasses = GetConVar( "ph2_bloom_add_outer_passes" )
local additiveDrawBloomInnerPasses = GetConVar( "ph2_bloom_add_inner_passes" )

local bloomOuterBlurPasses 	= GetConVar( "ph2_bloom_outer_blur_passes" )
local bloomOuterBlurX 		= GetConVar( "ph2_bloom_outer_blur_x" )
local bloomOuterBlurY 		= GetConVar( "ph2_bloom_outer_blur_y" )
      
local bloomInnerBlurPasses 	= GetConVar( "ph2_bloom_inner_blur_passes" )
local bloomInnerBlurX		= GetConVar( "ph2_bloom_inner_blur_x" )
local bloomInnerBlurY		= GetConVar( "ph2_bloom_inner_blur_y" )

-- unused
-- local function updateColorMaterialParams()
-- 	colorMaterial:SetFloat( "$pp_colour_addr", pp_colormod_addr:GetFloat() * 0.02 )
-- 	colorMaterial:SetFloat( "$pp_colour_addg", pp_colormod_addg:GetFloat() * 0.02 )
-- 	colorMaterial:SetFloat( "$pp_colour_addb", pp_colormod_addb:GetFloat() * 0.02 )
-- 	colorMaterial:SetFloat( "$pp_colour_brightness", pp_colormod_brightness:GetFloat() )
-- 	colorMaterial:SetFloat( "$pp_colour_contrast", pp_colormod_contrast:GetFloat() )
-- 	colorMaterial:SetFloat( "$pp_colour_colour", pp_colormod_color:GetFloat() )
-- 	colorMaterial:SetFloat( "$pp_colour_mulr", pp_colormod_mulr:GetFloat() * 0.1 )
-- 	colorMaterial:SetFloat( "$pp_colour_mulg", pp_colormod_mulg:GetFloat() * 0.1 )
-- 	colorMaterial:SetFloat( "$pp_colour_mulb", pp_colormod_mulb:GetFloat() * 0.1 )
-- 	colorMaterial:SetFloat( "$pp_colour_inv", pp_colormod_inv:GetFloat() )
-- end

-- Enable/disable experimental color modulation shader.
local drawColorModInner = false
local drawColorModOuter = false

---@param additive boolean Additive bloom pass.
function Photon2.RenderBloom.Render( additive )

	-- updateColorMaterialParams()

	local scene = render.GetRenderTarget()
	render.CopyRenderTargetToTexture( storeRenderTarget )

	if ( additive ) then
		render.Clear( 0, 0, 0, 255, false, true )
	else
		render.Clear( 255, 255, 255, 255, false, true )
	end

	cam.Start3D()


		render.SetStencilEnable( true )
		render.SetStencilWriteMask( 1 )
		render.SetStencilTestMask( 1 )
		render.SetStencilReferenceValue( 1 )

		render.SetStencilCompareFunction( STENCIL_ALWAYS )
		render.SetStencilPassOperation( STENCIL_REPLACE )
		render.SetStencilFailOperation( STENCIL_KEEP )
		render.SetStencilZFailOperation( STENCIL_KEEP )

		Photon2.RenderLightMesh.Render()
		render.CopyRenderTargetToTexture( rtMeshSource )

		-- RENDER MESHES
		Photon2.RenderLightMesh.DrawBloom()
		if ( drawLights:GetBool() ) then
			Photon2.RenderLight2D.DrawBloom()
		end
		-- Photon2.RenderLight2D.DrawBloom()

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilPassOperation( STENCIL_KEEP )
		
		render.SetStencilEnable( false )
		-- render.SuppressEngineLighting( false )
	cam.End3D()
		
	-- render.SetRenderTarget( rtBloomOuter )

	-- Copy scene to both bloom render targets
	render.CopyRenderTargetToTexture( rtBloomInner )
	render.CopyRenderTargetToTexture( rtBloomOuter )

	-- blur the inner bloom render target
	render.BlurRenderTarget( rtBloomInner, bloomInnerBlurX:GetFloat(), bloomInnerBlurY:GetFloat(), bloomInnerBlurPasses:GetInt() )
	
	-- perform experimental color shading
	if ( drawColorModInner ) then
		render.SetRenderTarget( rtBloomInner )
		colorMaterial:SetTexture( "$fbtexture", rtBloomInner )
		render.SetMaterial( colorMaterial )
		render.DrawScreenQuad()
	end
	-- render.CopyRenderTargetToTexture( rtBloomInner )
	
	
	-- blur outer bloom render target
	render.BlurRenderTarget( rtBloomOuter, bloomOuterBlurX:GetFloat(), bloomOuterBlurY:GetFloat(), bloomOuterBlurPasses:GetInt() )
	-- perform experimental color shading
	if ( drawColorModOuter ) then
		colorOuter:SetTexture( "$fbtexture", rtBloomInner )
		render.SetMaterial( colorOuter )
		render.DrawScreenQuad()
		render.CopyRenderTargetToTexture( rtBloomOuter )
	end

	render.SetRenderTarget( scene )
	copyMaterial:SetTexture( "$basetexture", storeRenderTarget )
	copyMaterial:SetString( "$color", "1 1 1" )
	-- copyMaterial:SetString( "$alpha", "1" )
	render.SetMaterial( copyMaterial )
	render.DrawScreenQuad()
	-- render.SuppressEngineLighting( false )

	-- this code was used for subtractive rendering
	-- render.SetStencilEnable( true )
	-- render.SetStencilEnable( !additive )
		-- render.SetStencilCompareFunction( STENCIL_NOTEQUAL )

	-- -- 	if ( additive ) then
	-- 		-- additiveMaterial:SetTexture( "$basetexture", storeRT )
	-- 		additiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
	-- 		render.SetMaterial( additiveMaterial )
	-- -- 	else
	-- -- 		subtractiveMaterial:SetTexture( "$basetexture", storeRT )
	-- -- 		-- subtractiveMaterial:SetTexture( "$basetexture", blurRenderTarget )
	-- -- 		render.SetMaterial( subtractiveMaterial )
	-- -- 	end

	-- -- 	-- for i=0, bloomPasses do
	-- -- 	-- 	render.DrawScreenQuad()
	-- -- 	-- end

	-- render.SetStencilEnable( false )

	-- render.SetStencilTestMask( 0 )
	-- render.SetStencilWriteMask( 0 )
	-- render.SetStencilReferenceValue( 0 )

end


local addMat = additiveMaterial

function Photon2.RenderBloom.DrawAdditive()
	-- multiple passes of each texture can increase intensity but it's
	-- also moderately GPU intensive

	addMat:SetTexture( "$basetexture", rtBloomOuter )
	render.SetMaterial( addMat )
	for i=1, additiveDrawBloomOuterPasses:GetInt() do
		render.DrawScreenQuad()
	end
	addMat:SetTexture("$basetexture", rtBloomInner )
	for i=1, additiveDrawBloomInnerPasses:GetInt() do
		render.DrawScreenQuad()
	end

	addMat:SetTexture( "$basetexture", rtMeshSource )
	for i=1, additiveDrawMeshSourcePasses:GetInt() do
		render.DrawScreenQuad()
	end
end

-- hook.Remove( "PreDrawViewModels", "Photon2.RenderBloom:Draw" )
-- hook.Remove( "PostDrawEffects", "Photon2.RenderBloom:Draw" )

hook.Add( "PostDrawEffects", "Photon2.RenderBloom:Draw", function( depth, sky )
	if ( ( #Photon2.RenderLightMesh.Active < 1 ) and ( #Photon2.RenderLight2D.Active < 1 ) ) then return end
	local start = SysTime()
	Photon2.RenderBloom.Render( true )
	Photon2.RenderBloom.DrawAdditive()
	Photon2.RenderBloom.DrawTime = SysTime() - start
end )