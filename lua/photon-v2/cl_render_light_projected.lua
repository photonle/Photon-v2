Photon2.RenderLightProjected = Photon2.RenderLightProjected or {
	---@type PhotonLightProjected
	Active = {}
}

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