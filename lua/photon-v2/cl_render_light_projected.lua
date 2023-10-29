Photon2.RenderLightProjected = Photon2.RenderLightProjected or {
	---@type PhotonElementProjected
	Active = {}
}

local overlayConVar = GetConVar("ph2_debug_light_overlay")

local alternateActive = {}
local this = Photon2.RenderLightProjected

function Photon2.RenderLightProjected.Update()
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
hook.Add( "PreRender", "Photon2.LightProjected:Update", this.Update )

function Photon2.RenderLightProjected.DrawDebug()
	if ( not overlayConVar:GetBool() ) then return end

	local activeLights = this.Active
	
	local light
	cam.Start3D()
		for i=1, #activeLights do 
			light = activeLights[i] --[[@as PhotonElementProjected]]
			local angles = light.Angles
			local position = light.Position
			render.DrawLine(position, position + angles:Up() * 3, Color(0,0,255))
			render.DrawLine(position, position + angles:Right() * 3, Color(255,0,0))
			render.DrawLine(position, position + angles:Forward() * 3, Color(0,255,0))
			debugoverlay.Text( position, light.Id, 0, false )
		end
	cam.End3D()
end
-- hook.Remove( "DrawOverlay", "Photon2.RenderLightProjected:DrawDebug" )
hook.Add( "PostDrawEffects", "Photon2.RenderLightProjected:DrawDebug", Photon2.RenderLightProjected.DrawDebug )