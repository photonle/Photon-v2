if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementVirtual"
BASE = "PhotonLight"

---@class PhotonElementVirtual : PhotonLight

local Element = exmeta.New()

Element.Class = "Virtual"

Element.States = {

}

function Element:Initialize( id, parent )
	self = PhotonLight.Initialize( self, id, parent ) --[[@as PhotonElementVirtual]]
	return self
end

