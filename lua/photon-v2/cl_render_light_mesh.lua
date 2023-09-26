Photon2.RenderLightMesh = Photon2.RenderLightMesh or {
	---@type PhotonLightMesh[]
	Active = {},
}

local alternateActive = {}

local this = Photon2.RenderLightMesh

function Photon2.RenderLightMesh.OnPreRender()
	local activeLights = this.Active
	local nextTable = alternateActive

	for i=1, #activeLights do
		if ( activeLights[i] ) then
			nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
		end
		activeLights[i] = nil
	end

	alternateActive = activeLights
	this.Active = nextTable
end
hook.Add( "PreRender", "Photon2.LightMesh:OnPreRender", this.OnPreRender )

function Photon2.RenderLightMesh.DrawBloom()
	local activeLights = this.Active
	for i=1, #activeLights do
		light = activeLights[i]
		if ( not light or ( light.CurrentStateId == "OFF" ) ) then continue end
		cam.PushModelMatrix( light.Matrix, true )
		render.SetMaterial( light.BloomMaterial --[[@as IMaterial]] )
		-- light.BloomMaterial--[[@as IMaterial]]:SetVector( "$color", Vector(1, 0, 0) )
		light.BloomMaterial--[[@as IMaterial]]:SetVector( "$color", light.BloomColor:GetVector() )
		light.Mesh:Draw()
		cam.PopModelMatrix()
	end
end

local glowTest = Material("photon/common/glow_test")

local light
function Photon2.RenderLightMesh.Render( depth, sky )
	if ( depth or sky ) then return end
	local activeLights = this.Active
		for i=1, #activeLights do
			light = activeLights[i]
			if ( not light or ( light.CurrentStateId == "OFF" ) or ( not light.EnableDraw ) ) then continue end
			-- light.Matrix:Scale(Vector(1.5,1.5,1.5))
			
			cam.PushModelMatrix( light.Matrix, true )
			
			-- render.SetMaterial( glowTest --[[@as IMaterial]] )
			render.SetMaterial( light.DrawMaterial --[[@as IMaterial]] )
			-- light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", Vector( 0, 0, 1 ) )
			light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", light.DrawColor:GetVector() )
			
			-- light.DrawMaterial--[[@as IMaterial]]:SetFloat( "$alpha", 0 )
			if ( light.ManipulateAlpha ) then
				light.DrawMaterial--[[@as IMaterial]]:SetFloat( "$alpha", light.Intensity )
			else
				light.DrawMaterial--[[@as IMaterial]]:SetFloat( "$alpha", 1 )
			end
			-- light.DrawMaterial--[[@as IMaterial]]:SetInt( "$alpha", light.Intensity )
			-- local cMatrix = Matrix({{512, 512, 512, 512}, {512, 512, 512, 512}, {512,512,512,512}, {512,512,512,512}})
			-- cMatrix:Translate(Vector(1024, 1024, 0))
			-- l
			-- glowTest:SetVector( "$color", Vector(1, 1, 1))
			-- glowTest:SetString( "$color2", "{255 512 512}")
			-- light.DrawMaterial:SetVector( "$color2", Vector(1, 5, 1))
			-- light.DrawMaterial:SetMatrix( "$color2", cMatrix )
				light.Mesh:Draw()
			cam.PopModelMatrix()
		end
end
hook.Add( "PreDrawTranslucentRenderables", "Photon2.RenderLightMesh", Photon2.RenderLightMesh.Render )