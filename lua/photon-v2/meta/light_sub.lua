if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSub"
BASE = "PhotonElement"

---@class PhotonElementSub : PhotonElement
---@field Indexes? integer[] Sub-material indexes this element controls.
---@field States? table<string, PhotonElementSubState> Element states.
local Light = exmeta.New()

Light.Class="Sub"

---@param data table
---@param template? PhotonElementSub
---@return PhotonElementSub
function Light.New( data, template )
	local light = data
	setmetatable( light, { __index = ( template or PhotonElementSub ) } )
	return light
end

Light.States = {
	["OFF"] = {
		Material = nil
	}
}

function Light.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementSub })
end


function Light:Initialize( id, component )
	---@type PhotonElementSub
	self = PhotonElement.Initialize( self, id, component ) --[[@as PhotonElementSub]]
	return self
end


function Light:OnStateChange( state )	
	for _, light in pairs( self.Indexes ) do
		self.Parent:SetSubMaterial( light, state.Material )
	end
end


function Light:Activate()
	if not PhotonElement.Activate( self ) then return end
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