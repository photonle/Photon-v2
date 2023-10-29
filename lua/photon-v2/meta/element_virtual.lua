if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementVirtual"
BASE = "PhotonElement"

---@class PhotonElementVirtual : PhotonElement

local Element = exmeta.New()

Element.Class = "Virtual"

Element.States = {

}

function Element:Initialize( id, parent )
	self = PhotonElement.Initialize( self, id, parent ) --[[@as PhotonElementVirtual]]
	return self
end

