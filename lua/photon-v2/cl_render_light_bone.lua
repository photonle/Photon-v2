Photon2.RenderLightBone = Photon2.RenderLightBone or {
	Active = {}
}

local alternateActive = {}
local this = Photon2.RenderLightBone

function Photon2.RenderLightBone.Update()

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
hook.Add( "Think", "Photon2.LightBone:Update", this.Update )
