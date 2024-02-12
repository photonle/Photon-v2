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


Photon2.RenderPoseElement = Photon2.RenderPoseElement or {
	Active = {}
}

local poseAlternative = {}
local pose = Photon2.RenderPoseElement

function Photon2.RenderPoseElement.Update()
	local activeElements = pose.Active
	local nextTable = poseAlternative

	for i=1, #activeElements do
		if ( activeElements[i] ) then
			nextTable[#nextTable+1] = activeElements[i]:DoPreRender()
		end
		activeElements[i] = nil
	end

	poseAlternative = activeElements
	pose.Active = nextTable
end
hook.Add( "Think", "Photon2.PoseElement:Update", pose.Update )