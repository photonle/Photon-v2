if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightSub"
BASE = "PhotonLight"

---@class PhotonLightSub : PhotonLight
---@field Indexes integer[]
---@field States table<string, PhotonLightSubState>
local Light = exmeta.New()

Light.Class="Sub"

---@param data table
---@param template? PhotonLightSub
---@return PhotonLightSub
function Light.New( data, template )
	local light = data
	setmetatable( light, { __index = ( template or PhotonLightSub ) } )
	return light
end


function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonLightSub })
end


function Light:Initialize( id, parentEntity )
	---@type PhotonLightSub
	self = PhotonLight.Initialize( self, id, parentEntity ) --[[@as PhotonLightSub]]
	return self
end


function Light:SetState( stateId )
	if ( stateId == self.CurrentStateId ) then return end
	
	local state = self.States[ stateId ]
	
	if ( not state ) then
		error("Invalid light state [" .. tostring(stateId) .. "]")
	end
	
	self.CurrentStateId = stateId
	
	for _, light in pairs( self.Indexes ) do
		self.Parent:SetSubMaterial( light, state.Material )
	end

end


function Light:Activate()
	self.Deactivate = false
	if (self.IsActivated) then return end
	self.IsActivated = true
end


function Light:DeactivateNow()
	self.IsAcivated = false
	self.Deactivate = false
end


function Light.OnLoad()

end

Light.OnLoad()