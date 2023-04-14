Photon2.Light2D = Photon2.Light2D or {
	---@type PhotonLight2D[]
	Active = {},
}

local alternateActive = {}

local this = Photon2.Light2D

function Photon2.Light2D.OnPreRender()
	local activeLights = this.Active
	local nextTable = alternateActive

	for i=1, #activeLights do
		nextTable[#nextTable+1] = activeLights[i]:DoPreRender()
		activeLights[i] = nil
	end

	alternateActive = activeLights
	this.Active = nextTable
end
hook.Add( "PreRender", "Photon2.Light2D:OnPreRender", this.OnPreRender )

-- local mats = {}
local light
function Photon2.Light2D.Render()
	local activeLights = this.Active
	cam.Start3D( EyePos(), EyeAngles() )
		for i=1, #activeLights do
			light = activeLights[i] --[[@as PhotonLight2D]]
			cam.Start3D2D( light.Position, light.Angles, 1 )
				-- render.SetLightingMode( 1 ) ??? 
				render.SetMaterial( light.Material )
				render.DrawQuad( light.Top, light.Right, light.Bottom, light.Left, light.PrimaryColor )
				-- render.SetLightingMode( 0 ) ???
			cam.End3D2D()
		end
	cam.End3D()
end
hook.Add( "PreDrawEffects", "Photon2.Light2D:Render", this.Render )