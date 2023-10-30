if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementVirtual"
BASE = "PhotonElement"

---@class PhotonElementVirtual : PhotonElement

local Element = exmeta.New()

Element.Class = "Virtual"

Element.States = {
	["OFF"] = {},
	["ON"] = {}
}

function Element:Initialize( id, parent )
	self = PhotonElement.Initialize( self, id, parent ) --[[@as PhotonElementVirtual]]
	return self
end

function Element.New( element, template )
	setmetatable( element, { __index = ( template or PhotonElementVirtual )})
	return element
end

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementVirtual }) 
end

function Element.OnFileLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonElementVirtualState:New( key, value, Element.States )
	end
end

Element.OnFileLoad()