if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementDynamicLight"
BASE = "PhotonElement"

---@class PhotonElementDynamicLight : PhotonElement

local Element = exmeta.New()

Element.Class = "Dynamic"

Element.States = {
	["OFF"] = {},
	["ON"] = {}
}

function Element:Initialize( id, parent )
	self = PhotonElement.Initialize( self, id, parent ) --[[@as PhotonElementDynamicLight]]
	return self
end

function Element.New( element, template )
	setmetatable( element, { __index = ( template or PhotonElementDynamicLight )})
	return element
end

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementDynamicLight }) 
end

function Element.OnFileLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonElementDynamicLightState:New( key, value, Element.States )
	end
end

Element.OnFileLoad()