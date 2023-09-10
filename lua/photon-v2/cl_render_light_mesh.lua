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
		cam.PushModelMatrix( light.Matrix )
		render.SetMaterial( light.BloomMaterial --[[@as IMaterial]] )
		-- light.BloomMaterial--[[@as IMaterial]]:SetVector( "$color", Vector(1, 0, 0) )
		light.BloomMaterial--[[@as IMaterial]]:SetVector( "$color", light.BloomColor:GetVector() )
		light.Mesh:Draw()
		cam.PopModelMatrix()
	end
end

local light
function Photon2.RenderLightMesh.Render( depth, sky )
	if ( depth or sky ) then return end
	local activeLights = this.Active
	cam.Start3D()
		for i=1, #activeLights do
			light = activeLights[i]
			if ( not light or ( light.CurrentStateId == "OFF" ) or ( not light.EnableDraw ) ) then continue end
			cam.PushModelMatrix( light.Matrix )
			render.SetMaterial( light.DrawMaterial --[[@as IMaterial]] )
			-- light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", Vector( 0, 0, 1 ) )
			light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", light.DrawColor:GetVector() )
				light.Mesh:Draw()
			cam.PopModelMatrix()
		end
	cam.End3D()
end
hook.Add( "PreDrawTranslucentRenderables", "Photon2.RenderLightMesh", Photon2.RenderLightMesh.Render )