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