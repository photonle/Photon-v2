if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightBone"
BASE = "PhotonLight"

local manager = Photon2.RenderLightBone
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightBone : PhotonLight
---@field Value number
---@field BoneId number
---@field Activity PhotonBoneLightActivity
---@field Axis number | string
---@field Smooth number Smoothing factor when reaching target value (only applies to sweep and static)
---@field Direction number -1 or +1
---@field Speed number Controls how fast rotation is.
---@field Target number Required for static and sweep modes.
---@field SweepTo number Required for sweep functionality.
---@field SweepPause number
local Element = exmeta.New()

-- Rotation behaviors...
-- 1. Continuous (speed, direction)
-- 2. Sweep (speed, targetA, targetB, direction)
-- 3. Static (speed, direction, angle)
-- 4. User-defined (networked, angle) (spotlight)
--
-- wind up/down behavior
-- rotation 

Element.Class = "Bone"

Element.Activity 		= "Fixed"
Element.Smooth 			= -1
Element.Direction 		= 1
Element.Speed 			= 100
Element.Target 			= 0
Element.Value 			= 0
Element.Axis 			= "y"

Element.SweepFrom 		= -1
Element.SweepTo 		= 1
Element.SweepPause 		= 0

--Element.ActivityParameters?

Element.States = {
	["OFF"] = { Activity = "Off" },
	["ROT"] = { Activity = "Rotate" }
}

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonLightBone } )
end

function Element.New( element, template )
	setmetatable( element, { __index = ( template or PhotonLightBone ) } )

	return element
end

function Element:Initialize( id, parentEntity )
	self = PhotonLight.Initialize( self, id, parentEntity ) --[[@as PhotonLightBone]]
	return self
end

---@param state PhotonLightBoneState
function Element:OnStateChange( state )
	if ( state.Name ~= "OFF" ) and ( not self.IsActivated ) then
		self:Activate()
	end
	self.Activity = state.Activity
	self.Smooth = state.Smooth
	self.Direction = state.Direction
	self.Speed = state.Speed
	self.Target = state.Target
	self.UpdateCurrentActivity = self["UpdateActivity" .. self.Activity]
end

function Element:Activate()
	PhotonLight.Activate( self )
	self.Deactivate = false
	if ( self.IsActivated ) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
end

function Element:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
end

function Element:SetValue( angle )
	local value = angle % 360
	if ( value < 0 ) then value = 360 + value end
	self.Value = value
	return value
end

function Element:UpdateActivityOff()
	self:SetValue( self.Value )
end

function Element:UpdateActivityRotate()
	return self:SetValue( self.Value + ( ( self.Speed * FrameTime() ) * self.Direction ) )
end

function Element:UpdateActivitySweep()

end

function Element:UpdateActivityFixed()

end

function Element:UpdateActivityManual()

end

-- Abstract function only.
function Element:UpdateCurrentActivity() 
	print("Updating abstract activity function.")
end

function Element:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end

	-- Execute current activity function
	self:UpdateCurrentActivity()

	-- Apply value to the target bone
	print( "original bone angle: " .. tostring( self.Parent:GetManipulateBoneAngles( self.BoneId ) ) )
	local angle = self.Parent:GetManipulateBoneAngles( self.BoneId )
	angle[self.Axis] = self.Value
	self.Parent:ManipulateBoneAngles( self.BoneId, angle)
	-- self.Parent:GetManipulateBoneAngles( self.BoneId )[self.Axis] = self.Value
	print( "manipulated bone angle: " .. tostring( self.Parent:GetManipulateBoneAngles( self.BoneId ) ) )

	return self
end

function Element.OnLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonLightBoneState:New( key, value, Element.States )
	end
end

Element.OnLoad()