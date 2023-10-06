if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightBone"
BASE = "PhotonLight"

local manager = Photon2.RenderLightBone
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightBone : PhotonLight
---@field Value number
---@field BoneId number
---@field Bone string
---@field Activity PhotonBoneLightActivity
---@field Axis number | string
---@field Smooth number Smoothing factor when reaching target value (only applies to sweep and static)
---@field Direction number -1 or +1
---@field Speed number Controls how fast rotation is.
---@field Target number Required for static and sweep modes.
---@field SweepStart number Angle the sweep should start at.
---@field SweepEnd number Angle the sweep should end at.
---@field SweepPause number Pause duration while sweeping.
---@field AngleOutputMap table<integer, table<number, any>>
---@field AddSpeed number Constant number to add speed by. Can be used to intentionally "drift" lights that are otherwise set to the same speed. 
---@field private InTransit boolean
---@field private PauseTime number
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
Element.AddSpeed		= 0
Element.Target 			= 0
Element.Value 			= 0
Element.Axis 			= "y"

Element.PauseTime		= 0
Element.InTransit		= false
Element.Momentum		= 1

Element.SweepEnd		= 1
Element.SweepStart 		= 359
Element.SweepPause 		= 1

Element.AngleOutputCeil	= 0
Element.AngleOutputFloor= 0
Element.AngleOutput = "OFF"
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
	if ( isstring( self.Bone ) ) then self.Bone = parentEntity:LookUpBoneOrError( self.Bone ) end
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
	self.SweepStart = state.SweepStart
	self.SweepEnd = state.SweepEnd
	self.SweepPause = state.SweepPause
	self.AngleOutputMap = state.AngleOutputMap

	self.UpdateCurrentActivity = self["UpdateActivity" .. self.Activity]

	if ( state.Activity == "Fixed" and self.Value ~= state.Target ) then
		self.InTransit = true
	elseif ( state.Activity == "Sweep" ) then
		self.InTransit = true
		self.Direction = self.Direction * -1
	end

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
	self.InTransit = true
	return self:SetValue( self.Value + ( ( ( self.Speed + self.AddSpeed ) * FrameTime() ) * self.Direction ) )
end

function Element:ReachedTargetAngle( newAngle, oldAngle, target, direction )
	local crossedThreshold = ( newAngle < 0 ) or ( newAngle > 360 )
	newAngle = newAngle % 360
	if ( newAngle < 0 ) then newAngle = 360 + newAngle end
	
	if ( direction > 0 ) then
		if 
			( ( crossedThreshold ) and ( oldAngle < target ) and ( newAngle < target ) )
			or ( ( newAngle >= target ) and ( oldAngle < target ) ) 
		then
			newAngle = target
		end
	else
		if
			( ( newAngle <= target ) and ( oldAngle > target ) )
			or ( ( crossedThreshold ) and ( oldAngle > target ) and ( newAngle > target ) )
		then
			newAngle = target
		end
	end
	return newAngle
end

function Element:UpdateActivitySweep()
	if ( not self.InTransit ) then
		if ( ( self.PauseTime + self.SweepPause ) <= RealTime() ) then
			self.InTransit = true
			self.Direction = self.Direction * -1
		else
			return
		end
	end

	local newValue = (self.Value + (( ( self.Speed + self.AddSpeed ) * FrameTime() ) * self.Direction))
	local target = self.SweepEnd

	if ( self.Direction < 0 ) then target = self.SweepStart end

	self:SetValue( self:ReachedTargetAngle( newValue, self.Value, target, self.Direction ) )

	if ( self.Value == target ) then
		self.InTransit = false
		self.PauseTime = RealTime()
	end
end

function Element:UpdateActivityFixed()
	if ( self.InTransit ) then
		local newValue = (self.Value + (( ( self.Speed + self.AddSpeed ) * FrameTime() ) * self.Direction))
		self:SetValue( self:ReachedTargetAngle( newValue, self.Value, self.Target, self.Direction ) )
		if ( self.Value == self.Target ) then self.InTransit = false end
	end
	return self.Value
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
	-- print( "original bone angle: " .. tostring( self.Parent:GetManipulateBoneAngles( self.BoneId ) ) )
	local angle = self.Parent:GetManipulateBoneAngles( self.BoneId )
	angle[self.Axis] = self.Value * -1
	self.Parent:ManipulateBoneAngles( self.BoneId, angle )

	if ( self.InTransit and self.AngleOutputMap ) then
		local result = 1
		local updated = false

		if ( #self.AngleOutputMap > 1 ) then
			if ( self.Value > self.AngleOutputCeil or self.Value < self.AngleOutputFloor ) then
				updated = true
			-- if ( self.Direction > 0 ) then
				for i=1, #self.AngleOutputMap do
					if ( i == #self.AngleOutputMap ) then
						self.AngleOutputFloor = self.AngleOutputMap[i][1]
						self.AngleOutputCeil = 360
						result = i
						break
					elseif ( self.Value > self.AngleOutputMap[i][1] and self.Value <= self.AngleOutputMap[i+1][1] ) then
						self.AngleOutputFloor = self.AngleOutputMap[i][1]
						self.AngleOutputCeil = self.AngleOutputMap[i+1][1]
						result = i
						break
					end
				end
			end
			-- else
			-- 	for i=#self.AngleOutputMap, 2, -1 do

			-- 	end
			-- end
		else

		end

		if ( updated ) then
			self.AngleOutput = self.AngleOutputMap[result][2]
			-- print("Angle output " .. tostring( self.Value) .. ": " .. tostring( self.AngleOutput ) )
		
		end
	end


	-- print("Bone's angle output: " .. tostring( self.AngleOutput ) )

	-- self.Parent:GetManipulateBoneAngles( self.BoneId )[self.Axis] = self.Value
	-- print( "manipulated bone angle: " .. tostring( self.Parent:GetManipulateBoneAngles( self.BoneId ) ) )
	-- print("sin: " .. tostring( math.abs((((( self.Value + 90) % 360 ))/360))) )
	-- local ang = (self.Value + 180) % 360
	-- print( "RES = " .. interpolateY( ang ) )
	-- print( "ANG: " .. tostring((self.Value + 180) % 360))
	-- print(math.sin(0.4))
	return self
end

function Element.OnLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonLightBoneState:New( key, value, Element.States )
	end
end

Element.OnLoad()