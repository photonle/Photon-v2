if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementPose"
BASE = "PhotonElement"

local manager = Photon2.RenderPoseElement
local printF = Photon2.Debug.Print

---@type PhotonElementPose
local Element = exmeta.New()

Element.Class = "Pose"

Element.Target = 0
Element.GainSpeed = 1
Element.LossSpeed = 1

Element.States = {
	["OFF"] = { Target = 0 },
	["ON"] = { Target = 1 },
}

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementPose } )
end

function Element.New( element, template )
	setmetatable( element, { __index = ( template or PhotonElementPose ) } )

	if ( not element.Parameter and element[2] ) then
		element.Parameter = element[2]
	end

	return element
end

function Element:Initialize( id, component )
	self = PhotonElement.Initialize( self, id, component ) --[[@as PhotonElementPose]]
	self.Value = self.Parent:GetPoseParameter( self.Parameter )
	-- local parentEntity = component.Entity

	return self
end

---@param state PhotonElementPoseStateProperties
function Element:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	self.Target = state.Target
	self.GainSpeed = state.GainSpeed
	self.LossSpeed = state.LossSpeed
end

function Element:Activate()
	if not PhotonElement.Activate( self ) then return end
	self.Deactivate = false
	if ( self.IsActivated ) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
end

function Element:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
end

function Element:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end

	if ( self.Value == self.Target ) then 
		if ( self.CurrentStateId ==  self.DeactivationState ) then
			self.Deactivate = true
		end
		return self
	end

	if ( self.Value > self.Target ) then
		self.Value = self.Value - ( self.LossSpeed * RealFrameTime() )
		if ( self.Value < self.Target ) then self.Value = self.Target end
	elseif ( self.Value < self.Target ) then
		self.Value = self.Value + ( self.GainSpeed * RealFrameTime() )
		if ( self.Value > self.Target ) then self.Value = self.Target end
	end
	
	self.Parent:SetPoseParameter( self.Parameter, self.Value )

	return self
end

function Element.OnLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonElementPoseState:New( key, value, Element.States )
	end
end

Element.OnLoad()