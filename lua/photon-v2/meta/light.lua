if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight"

local printf = Photon2.Debug.PrintF

---@class PhotonLight
---@field Parent Entity
---@field Class string
---@field Deactivate boolean When `true`, marks the light to be activated on the next frame.
---@field IsActivated boolean
---@field States table
---@field Id integer
---@field CurrentStateId string
---@field Inputs table
---@field SortedInputs table
local Light = exmeta.New()

---@param id integer
---@param parent Entity
---@return PhotonLight
function Light:Initialize( id, parent )
	---@type PhotonLight2D
	local light = {
		Id = id,
		Class = self.Class,
		Parent = parent,
		Inputs = {},
		SortedInputs = {}
	}
	return setmetatable( light, { __index = self } )
end


---@param state PhotonLightState
function Light:OnStateChange( state ) end

local debugPrint = false

function Light:SortInputs()
	table.SortByMember( self.SortedInputs, "Priority", false )
	for k, v in ipairs(self.SortedInputs) do
		v.Order = k
	end
end

function Light:AddInput( sequenceId, priority )
	local isNew = true

	if ( self.Inputs[sequenceId] ) then isNew = false end

	self.Inputs[sequenceId] = self.Inputs[sequenceId] or {}

	self.Inputs[sequenceId].Sequence = sequenceId
	self.Inputs[sequenceId].Priority = priority
	self.Inputs[sequenceId].State = "PASS"

	if ( isNew ) then
		self.SortedInputs[#self.SortedInputs+1] = self.Inputs[sequenceId]
	end

	self:SortInputs()
end

function Light:SetInput( sequenceId, stateId )
	self.Inputs[sequenceId].State = stateId
end

function Light:RemoveInput( sequenceId )
	table.remove( self.SortedInputs, self.Inputs[sequenceId].Order )
	self.Inputs[sequenceId] = nil
	self:SortInputs()
end

function Light:UpdateState()
	-- If a light state is not being updated, verify that component supports
	-- the input channel.
	local state = "PASS"
	-- print("Current inputs: " .. tostring(#self.SortedInputs))
	for i=1, #self.SortedInputs do
		if (self.SortedInputs[i].State ~= "PASS") then
			state = self.SortedInputs[i].State
			break
		end
	end
	if state == "PASS" then state = "OFF" end
	
	if (state ~= self.CurrentStateId) then
		self.CurrentStateId = state
		-- print("Setting light state to: " .. tostring(state))
		self:OnStateChange( self.States[state] )
	end

	-- Set light to auto-deactivate when it has no more inputs
	if (#self.SortedInputs < 1) then
		self.Deactivate = true
	else
		self:Activate()
	end
end

-- Marks the light as "activated" to enable rendering optimizations
-- and add to applicable rendering queues.
function Light:Activate() end


-- Forces light deactivation. Should only be called once
-- it's clear that no other segments are using the light.
function Light:DeactivateNow() end

function Light:PrintTable()
	PrintTable(self)
end

-- Finds and returns the corresponding PhotonLight class
-- or throws a traceable error.
---@param className string
---@return PhotonLight
function Light.FindClass( className )
	local lightClass = _G["PhotonLight" .. tostring( className )]

	if ( not lightClass ) then
		error(string.format( "Light class [%s] could not be found.", className ) )
	end

	return lightClass
end

function Light:GetProxy( id )
	local proxy = self.Proxies[id]
	return self.Parent--[[@as PhotonLightingComponent]].Lights[proxy[1]][proxy[2]]
end