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

local light
function Photon2.RenderLightMesh.Render()
	local activeLights = this.Active
	cam.Start3D()
		for i=1, #activeLights do
			light = activeLights[i]
			if ( not light or ( light.CurrentStateId == "OFF" ) ) then continue end
			cam.PushModelMatrix( light.Matrix )
			render.SetMaterial( light.DrawMaterial --[[@as IMaterial]] )
			-- light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", Vector( 0, 0, 1 ) )
			light.DrawMaterial--[[@as IMaterial]]:SetVector( "$color", light.DrawColor:GetVector() )
				light.Mesh:Draw()
			cam.PopModelMatrix()
		end
	cam.End3D()
end
hook.Add( "PreDrawHalos", "Photon2.RenderLightMesh", Photon2.RenderLightMesh.Render )