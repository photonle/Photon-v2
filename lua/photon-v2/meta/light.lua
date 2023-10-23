if (exmeta.ReloadFile()) then return end

NAME = "PhotonLight"

local printf = Photon2.Debug.PrintF

---@class PhotonLight
---@field Parent Entity
---@field Class string
---@field Disabled boolean
---@field Deactivate boolean When `true`, marks the light to be activated on the next frame.
---@field DeactivationState? string
---@field IsActivated boolean
---@field States table
---@field Id integer
---@field CurrentStateId string
---@field Inputs table
---@field SortedInputs table
---@field BoneParent number|string Model bone to attach the light to (if supported).
---@field RequiredBodyGroups table<number | string, number | table<number>>
---@field private HasBodyGroupRequirements boolean
local Light = exmeta.New()

---@param id integer
---@param parent Entity
---@return PhotonLight
function Light:Initialize( id, parent )
	local light = {
		Id = id,
		Class = self.Class,
		Parent = parent,
		Inputs = {},
		SortedInputs = {}
	}
	if ( isstring( self.BoneParent ) ) then
		
		self.BoneParent = parent:LookUpBoneOrError( self.BoneParent )
	end

	return setmetatable( light, { __index = self } )
end

function Light:CheckBodyGroupRequirements()
	if ( self.HasBodyGroupRequirements == nil ) then
		if ( istable( self.RequiredBodyGroups ) ) then
			self.HasBodyGroupRequirements = true
			local metaTable = getmetatable( self.RequiredBodyGroups ) or {}
			if ( not metaTable.Processed ) then
				for bodyGroupName, selection in pairs( self.RequiredBodyGroups ) do
					
					local index = bodyGroupName

					if ( isstring( bodyGroupName ) ) then
						
						index = self.Parent:FindBodygroupByName( bodyGroupName --[[@as string]] )
						if ( index == -1 ) then
							ErrorNoHaltWithStack( "Body group name [" .. tostring( bodyGroupName ) .. "] not found in model [" .. tostring( self.Parent:GetModel() ) .. "]" ) 
						end
						
						self.RequiredBodyGroups[bodyGroupName] = nil
						
					end

					local newSelectionTable = {}
					
					for i=1, #selection do
						newSelectionTable[selection[i]] = true
					end
					
					self.RequiredBodyGroups[index] = newSelectionTable
				end
				metaTable.Processed = true
				setmetatable( self.RequiredBodyGroups, metaTable )
			end
		else
			self.HasBodyGroupRequirements = false
		end
	end

	if ( not self.HasBodyGroupRequirements ) then return true end
	
	for index, bodyGroups in pairs( self.RequiredBodyGroups ) do
		
		if ( not bodyGroups[self.Parent:GetBodygroup( index )] ) then return false end
	end
	
	return true
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
	-- error("deprecated")
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
		if ( not self.States[state] ) then
			error( "StateProxy [" .. tostring( state ) .."] is not defined on child light [" .. tostring( self.Id ) .. "]. Verify that you have all necessary light states configured (COMPONENT.ElementStates)."  )
		end
		self.StateProxy = self.States[state].Proxy
		self.CurrentStateProxyId = nil
		-- print("Setting light state to: " .. tostring(state))
		self:OnStateChange( self.States[state] )
	end

	-- Set light to auto-deactivate when it has no more inputs
	if (#self.SortedInputs < 1) then
		if ( self.DeactivationState ) then
			self:OnStateChange( self.States[self.DeactivationState] )
		else
			self.Deactivate = true
		end
	else
		self:Activate()
	end
end

function Light:UpdateProxyState()
	if ( not self.StateProxy ) then return false end
	local currentState = self.States[self.CurrentStateId]
	local proxyTarget, proxyState
	
	if ( self.StateProxy.Type == "FROM_LIGHT" ) then
		proxyTarget = self.Parent.Elements
	end
	
	if ( not proxyTarget ) then error( "StateProxy lookup failed. Verify 'Type' is supported and that the 'Target' is valid." ) end
	
	proxyStateId = proxyTarget[self.StateProxy.Key][self.StateProxy.Value]
	-- print("proxyStateId: " .. tostring(proxyStateId))
	if ( self.CurrentStateProxyId == proxyStateId ) then return end
	self.CurrentStateProxyId = proxyStateId
	self:OnStateChange( self.States[proxyStateId] )
end

-- Marks the light as "activated" to enable rendering optimizations
-- and add to applicable rendering queues.
function Light:Activate() 
	if ( self.HasBodyGroupRequirements or ( self.HasBodyGroupRequirements == nil ) ) then
		if ( self:CheckBodyGroupRequirements() ) then
			self.Disabled = false
		else
			self.Disabled = true
			return false
		end
	end
	return true
end


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
	return self.Parent--[[@as PhotonLightingComponent]].Elements[proxy[1]][proxy[2]]
end