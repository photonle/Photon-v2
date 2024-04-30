if (exmeta.ReloadFile()) then return end

NAME = "PhotonElement"

local printf = Photon2.Debug.PrintF

---@class PhotonElement : PhotonElementProperties
---@field [1]? string Template
---@field Parent? Entity
---@field Component? PhotonLightingComponent
---@field Class? string Type of element (2D, Mesh, etc.)
---@field Disabled? boolean
---@field Deactivate? boolean When `true`, marks the light to be activated on the next frame.
---@field IsActivated? boolean
---@field States? table<string, PhotonElementState> Table of available states.
---@field Id? integer Element's unique identifier (per-component).
---@field CurrentStateId? string
---@field InputActions? table
---@field SortedInputActions? table
---@field BoneParent? number|string Model bone to attach the light to (if supported).
---@field RequiredBodyGroups? table<number | string, number | table<number>>
---@field HasBodyGroupRequirements boolean
---@field UIMode? boolean
--@field Initialize fun(self: PhotonElement, id: number, component: PhotonLightingComponent): PhotonElement
--@field CheckBodyGroupRequirements fun(self: PhotonElement): boolean
--@field OnStateChange fun(self: PhotonElement)
--@field SetInput fun(self: PhotonElement, sequenceId: string, stateId: string)
local Light = exmeta.New()

-- -@type PhotonElement

Light.DeactivationState = "OFF"

---@param id string
---@param component PhotonLightingComponent
---@return PhotonElement
function Light:Initialize( id, component )
	local light = {
		Id = id,
		Class = self.Class,
		Component = component,
		Parent = component.Entity,
		InputActions = {},
		SortedInputActions = {},
		UIMode = component.UIMode
	}

	if CLIENT then
		if ( isstring( self.BoneParent ) ) then
			local boneName = self.BoneParent
			self.BoneParent = 0
			-- has to be delayed because the entity may not be valid 
			-- in the same tick
			timer.Simple( 0.01, function() 
				if ( not IsValid( light.Parent ) ) then return end
				self.BoneParent = light.Parent:LookUpBoneOrError( boneName )
			end)
		end
	end

	return setmetatable( light, { __index = self } )
end

function Light:CheckBodyGroupRequirements()
	if ( self.HasBodyGroupRequirements == nil ) then
		if ( istable( self.RequiredBodyGroups ) ) then
			self.HasBodyGroupRequirements = true
			local metaTable = getmetatable( self.RequiredBodyGroups ) or {}
			if ( not metaTable.Processed ) then
				
				local result = {}

				for bodyGroupName, selection in pairs( self.RequiredBodyGroups ) do
					
					if ( not istable( selection ) ) then selection = { selection } end

					local index = bodyGroupName

					if ( isstring( bodyGroupName ) ) then
						
						index = self.Parent:FindBodygroupByName( bodyGroupName --[[@as string]] )
						if ( index == -1 ) then
							ErrorNoHaltWithStack( "Body group name [" .. tostring( bodyGroupName ) .. "] not found in model [" .. tostring( self.Parent:GetModel() ) .. "]" ) 
						end
					
					end

					local newSelectionTable = {}
					
					for i=1, #selection do
						newSelectionTable[selection[i]] = true
					end

					result[index] = newSelectionTable
				end

				self.RequiredBodyGroups = result

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

---@param state PhotonElementState
function Light:OnStateChange( state ) end

local debugPrint = false

-- Orders each input state by its priority.
function Light:SortInputActions()
	table.SortByMember( self.SortedInputActions, "Priority", false )
	for k, v in ipairs(self.SortedInputActions) do
		v.Order = k
	end
end

function Light:AddInput( sequenceId, priority )

	local isNew = true

	if ( self.InputActions[sequenceId] ) then isNew = false end

	self.InputActions[sequenceId] = self.InputActions[sequenceId] or {}

	self.InputActions[sequenceId].Sequence = sequenceId
	self.InputActions[sequenceId].Priority = priority
	self.InputActions[sequenceId].State = "PASS"

	if ( isNew ) then
		self.SortedInputActions[#self.SortedInputActions+1] = self.InputActions[sequenceId]
	end

	self:SortInputActions()
end

function Light:ReapplyState()
	if ( self.StateProxy ) then 
		self:UpdateProxyState()
		return
	end
	self:OnStateChange( self.States[self.CurrentStateId] )
end

-- Registers what state the element should have in a sequence.
-- When multiple sequences are trying to set its state,
-- the state to actually apply is determined by the sequence priority.
---@param sequenceId string Sequence identifier.
---@param stateId string Element's state in the sequence.
function Light:SetInput( sequenceId, stateId )
	-- error("deprecated")
	self.InputActions[sequenceId].State = stateId
end

function Light:RemoveInput( sequenceId )
	table.remove( self.SortedInputActions, self.InputActions[sequenceId].Order )
	self.InputActions[sequenceId] = nil
	self:SortInputActions()
	-- if ( #self.SortedInputActions < 1 ) then self.Deactivate = true end
end

-- Returns if the state exists, and if the state is defined DIRECTLY on the element.
---@return boolean?, table?
function Light:VerifyStateForGeneration( stateId )
	if ( not self.States[stateId] ) then return false end

	local fromTemplate = getmetatable( self.States ).__index[stateid]
	local fromSelf = rawget( self.States, stateId )

	-- The extra if check is to rule out a misleading micro-optimization
	if ( fromSelf and not ( fromTemplate == fromSelf ) ) then
		return true, self.States
	end

	return true, getmetatable( self.States ).__index
end

function Light:FindOrAttemptTransitioningState( stateId )
	local valid, target = self:VerifyStateForGeneration( stateId )
	if ( not valid ) then return false end
	local newId = "~" .. stateId
	---@diagnostic disable-next-line: need-check-nil
	if ( target[newId] ) then return target end
	local stateClass = PhotonElementState.FindClass( self.Class )
	target[newId] = stateClass:New( newId, {
		Inherit = stateId,
		IntensityTransitions = true
	}, target )
	return target
end

function Light:FlagInvalidState( stateId )
	ErrorNoHalt( "Flagging invalid state: " .. tostring( stateId ) )
	getmetatable( self.States ).__index[stateId] = {
		Undefined = true
	}
	return false
end

local function parseStateString( input )
	local useTransitions = string.sub( input, 1, 1 ) == "~"
	local gainLoss = string.match( input, "%(([%d.,]+)%)")
	local gain, loss = nil, nil
	if gainLoss then
		gain, loss = string.match( gainLoss, "([^,]+),?([^,]*)")
		gain = tonumber( gain )
		loss = tonumber( loss ) or gain
	end
	local baseState = string.match( input, "^~?%([^)]*%)([%w.-]*)%*?[0-9.]*$") or string.match( input, "^~?([%w.-]*)%*?[0-9.]*$")
	local intensity = tonumber( string.match( input, "%*([0-9.]+)$")) or nil

	return useTransitions, baseState, intensity, gain, loss
end

-- Takes the state identifer of a non-existing state and determines if it can be constructed automatically. 
-- (~ prefix triggers intensity transitions, *0.X suffix triggers variable intensity)
function Light:AttemptStateGeneration( stateId )
	local transition, baseState, intensity, gain, loss = parseStateString( stateId )
	-- print("Analyzing state for generation: " .. tostring(stateId) .. " | Transition: " .. tostring(transition) .. " | Base: " .. tostring(baseState) .. " | Intensity: " .. tostring(intensity) .. " | Gain: " .. tostring(gain) .. " | Loss: " .. tostring(loss))
	if ( ( not transition ) and ( not intensity ) ) then
		return self:FlagInvalidState( stateId )
	end

	if ( transition ) then
		local targetTable = self:FindOrAttemptTransitioningState( baseState )
		if ( not targetTable ) then return self:FlagInvalidState( stateId ) end
		if ( intensity ) then
			local stateClass = PhotonElementState.FindClass( self.Class )
			local parentName = "~" .. baseState
			targetTable[stateId] = stateClass:New( stateId, {
				Inherit = parentName,
				IntensityTransitions = true,
				Intensity = intensity,
				IntensityGainFactor = gain,
				IntensityLossFactor = loss
			}, targetTable )
		end
	else
		local valid, targetTable = self:VerifyStateForGeneration( baseState )
		if ( not valid ) then return self:FlagInvalidState( stateId ) end
		local stateClass = PhotonElementState.FindClass( self.Class )
		targetTable[stateId] = stateClass:New( stateId, {
			Inherit = baseState,
			Intensity = intensity
		}, targetTable )
	end

	if ( not self.States[stateId] ) then
		ErrorNoHalt( "State [" .. tostring( stateId ) .. "] was not generated successfully." )
		return self:FlagInvalidState( stateId )
	end

	return self.States[stateId]
end

---@param force boolean If true, forces lights to update their state, even if unchanged (necessary in case of exeternal mutations).
function Light:UpdateState( force )
	-- If a light state is not being updated, verify that component supports
	-- the input channel.

	local state = "PASS"
	-- print("Current inputs: " .. tostring(#self.SortedInputActions))
	for i=1, #self.SortedInputActions do
		if (self.SortedInputActions[i].State ~= "PASS") then
			state = self.SortedInputActions[i].State
			break
		end
	end
	if state == "PASS" then state = self.DeactivationState end
	
	if ( ( state ~= self.CurrentStateId ) or ( force ) ) then
		self.CurrentStateId = state
		-- .Undefined signifies an attempt was already made to generate the state, but it failed.
		if ( not self.States[state] ) then self:AttemptStateGeneration( state ) end
		
		if ( self.States[state].Undefined ) then
			ErrorNoHalt( "State [" .. tostring( state ) .."] is not defined on light [" .. tostring( self.Id ) .. "]. Verify that you have all necessary light states configured (COMPONENT.ElementStates)."  )
			state = "OFF"
		end
		
		self.StateProxy = self.States[state].Proxy
		self.CurrentStateProxyId = nil
		-- print("Setting light state to: " .. tostring(state))
		self:OnStateChange( self.States[state] )
	end

	-- Set light to auto-deactivate when it has no more inputs
	if (#self.SortedInputActions < 1) then
		if ( self.DeactivationState  
			and ( self.IsActivated ) ) 
			-- and ( state ~= self.CurrentStateId )
		then
			-- ErrorNoHalt("deactivation state:" .. tostring( self.DeactivationState ))
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

-- Finds and returns the corresponding PhotonElement class
-- or throws a traceable error.
---@param className string
---@return PhotonElement
function Light.FindClass( className )
	local lightClass = _G["PhotonElement" .. tostring( className )]

	if ( not lightClass ) then
		error(string.format( "Light class [%s] could not be found.", className ) )
	end

	return lightClass
end

function Light:GetProxy( id )
	local proxy = self.Proxies[id]
	return self.Parent--[[@as PhotonLightingComponent]].Elements[proxy[1]][proxy[2]]
end

function Light:DrawDebug()

end