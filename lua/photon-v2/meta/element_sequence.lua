if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementSequence"
BASE = "PhotonElement"

---@class PhotonElementSequence : PhotonElement

local Element = exmeta.New()

Element.Class = "Sequence"

Element.States = {
	["OFF"] = { Sequence = "idle" },
}

function Element:Initialize( id, parent )
	self = PhotonElement.Initialize( self, id, parent ) --[[@as PhotonElementSequence]]
	return self
end

---@param state PhotonElementSequenceState
function Element:OnStateChange( state )
	self.Parent:SetSequence( state.Sequence )
end

function Element.New( element, template )
	setmetatable( element, { __index = ( template or PhotonElementSequence )})
	return element
end

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementSequence }) 
end

function Element.OnFileLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonElementSequenceState:New( key, value, Element.States )
	end
end

Element.OnFileLoad()