if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightingComponent"
BASE = "PhotonBaseEntity"

local printonly = print

local printf, warn = Photon2.Debug.Declare( "Component" )
local print = Photon2.Debug.Print

local RealTime = RealTime

---@class PhotonLightingComponent : PhotonBaseEntity
---@field Name string
---@field Ancestors table<string, boolean>
---@field Descendants table<string, boolean>
---@field Children table<string, boolean>
---@field Lights table<integer, PhotonElement>
---@field Segments table<string, PhotonElementingSegment>
---@field InputPriorities table<string, integer>
---@field CurrentModes table<string, string>
---@field ActiveSequences table<PhotonSequence, boolean>
---@field ActiveIndependentSequences table<PhotonSequence, boolean>
---@field ActiveDependentSequences table<PhotonSequence, boolean>
---@field StateMap table<integer, string[]>
---@field InputActions table<string, string[]>
---@field ElementGroups table<string, integer[]>
---@field UseControllerModes boolean If true, the component will use its controller's CurrentModes table. If false, it will manage its own (required for Virtual InputActions).
---@field Phase string
---@field FrameDuration number
---@field AcceptControllerPulse boolean (Internal)
---@field AcceptControllerTiming boolean (Internal)
---@field Synchronized boolean If true, the component will synchronize with the controller's frame schedule (can be overridden by segments or sequences).
---@field VirtualOutputs table
---@field Title string
---@field IsPaused boolean If component timing is paused.
---@field UseStrictFrameTiming boolean (Default = `true`) If false, frame timing will be never be faster than the client's current FPS. 
---@field ManualFrameDuration number Frame duration used in debugging.
local Component = exmeta.New()

local Builder = Photon2.ComponentBuilder
local Util = Photon2.Util

Component.UseControllerModes = true
Component.IsPhotonLightingComponent = true
Component.InputPriorities = PhotonBaseEntity.DefaultInputPriorities
Component.StrictFrameTiming = true
Component.ManualFrameDuration = 1/24

Component.ClassMap = {
	Default = "PhotonLightingComponent",
	Siren = "PhotonSirenComponent"
}

--[[
		COMPILATION
--]]

local dumpLibraryData = false

-- [Internal] Compile a Library Component to store in the Index.
---@param name string
---@param data PhotonLibraryComponent
---@return PhotonLightingComponent
function Component.New( name, data )
	
	data = table.Copy( data )

	local ancestors = { [name] = true }

	data = Photon2.Library.Components:GetInherited( data )
	-- if ( data.Base ) then
	-- 	-- More special handling for Input sequence assignments (there must be a better way to do this)
	-- 	local dataInputs
	-- 	if ( istable( data.Inputs ) ) then dataInputs = table.Copy( data.Inputs ) end
	-- 	Util.Inherit( data, table.Copy( Photon2.BuildParentLibraryComponent( name, data.Base ) ))
	-- 	Photon2.Library.ComponentsGraph[data.Base] = Photon2.Library.ComponentsGraph[data.Base] or {}
	-- 	Photon2.Library.ComponentsGraph[data.Base][name] = true

	-- 	Photon2.ComponentBuilder.InheritInputs( dataInputs, data.Inputs )

	-- 	-- if ( Photon2.Library.Components[data.Base] ) then
	-- 	-- 	Photon2.Library.Components[data.Base].Children[name] = true
	-- 	-- end
	-- end

	data.Flags = data.Flags or {}

	if ( dumpLibraryData ) then
		print("_______________________________________")
		PrintTable(data)
		print("_______________________________________")
	end

	-- TODO: there needs to be an actual flag system setup
	if ( data.Flags.AutomaticHeadlights ) then
		Photon2.ComponentBuilder.SetupAutomaticVehicleLighting( data )
	end

	if ( data.Flags.ParkMode ) then
		Photon2.ComponentBuilder.SetupParkMode( data, data.Flags.ParkMode )
	end

	if ( data.Flags.NightParkMode ) then
		Photon2.ComponentBuilder.SetupNightParkMode( data, data.Flags.NightParkMode )
	end

	if ( data.Flags.FrontNoM1 ) then
		Photon2.ComponentBuilder.SetupFrontNoM1( data, data.Flags.FrontNoM1 )
	end

	---@type PhotonLightingComponent
	local component = {
		Name = name,
		Title = data.Title or data.PrintName or name,
		Authors = data.Authors,
		Class = data.Class or "Default",
		Category = data.Category,
		Credits = data.Credits,
		Phase = data.Phase,
		Ancestors = ancestors,
		Descendants = {},
		Children = {},
		Model = data.Model,
		Elements = {},
		Segments = {},
		Inputs = {},
		InputActions = {},
		ElementGroups = data.ElementGroups,
		SubMaterials = data.SubMaterials,
		InputPriorities = setmetatable( data.InputPriorities or {}, { __index = Component.InputPriorities } ),
		States = data.States
	}

	-- Assume components without a model defined are virtual
	if ( data.IsVirtual == nil ) then
		if ( component.Model == nil ) then component.IsVirtual = true end
	end

	for key, value in pairs( data ) do
		if ( component[key] == nil ) then
			component[key] = value
		end
	end


	-- if ( not component.InputPriorities ) then
	-- 	error( "Component.InputPriorities was not set.")
	-- end

	-- --[[
	-- 		Build Ancestors Dictionary
	-- --]]

	-- local lastParent = data.Base

	-- while ( lastParent ) do
	-- 	ancestors[lastParent] = true
	-- 	if ( Photon2.Library.Components[lastParent] ) then
	-- 		Photon2.Library.Components[lastParent].Descendants[name] = true
	-- 		lastParent = Photon2.Library.Components[lastParent].Base
	-- 	end
	-- end


	--[[
			Process element state inheritance from state slots.
	--]]

	if ( istable( data.States ) ) then
		data.ElementStates = data.ElementStates or {}
		for elementType, states in pairs( data.ElementStates ) do
			for slotId, stateId in pairs( data.States ) do
				states[tostring(slotId)] = {
					Inherit = stateId,
					SuppressInheritanceFailure = true
				}
				states[slotId] = states[tostring(slotId)]
			end
		end
	end


	--[[
			Compile COMPONENT-Wide Light States
	--]]

	local lightStates = {}
	for lightClassName, states in pairs( data.ElementStates or {} ) do
		local lightClass = PhotonElement.FindClass( lightClassName )
		local lightStateClass = PhotonElementState.FindClass( lightClassName )
		-- Use actual COMPONENT.ElementStates table to get around load/dependency order issues.

		-- Set __index to the base class's Light.States table.
		lightStates[lightClassName] = setmetatable( states, { __index = lightClass.States })

		-- Initialize each custom state from raw data
		for stateId, state in pairs( states ) do
			states[stateId] = lightStateClass:New( stateId, state, states )
		end
	end


	--[[
			Compile State Map
	--]]

	if ( isstring( data.StateMap ) ) then
		-- component.StateMap = Builder.StateMap( data.StateMap --[[@as string]], data.ElementGroups )
		component.StateMap = Photon2.ComponentBuilder.StateMap( data.StateMap --[[@as string]], data.ElementGroups, data.States )
	elseif ( istable( data.StateMap ) ) then
		component.StateMap = data.StateMap --[[@as table<integer, string[]>]]
	end

	--[[
			Handle State Map Slots
	--]]

	-- Check if component is configured to use state slots
	if ( istable( data.States ) ) then
		-- Iterate through each element (non-processed)
		for id, element in pairs( data.Elements ) do
			-- Use direct reference if the StateMap isn't manually configured
			if ( not component.StateMap[id] ) then
				component.StateMap[id] = data.States
			else
				local slot
				-- Iterate through each state slot
				for slotIndex, stateId in pairs( data.States ) do
					slot = component.StateMap[id][slotIndex]
					-- Fill non-defined slots with slots from the component states
					if ( slot == "" ) or ( slot == nil ) then
						component.StateMap[id][slotIndex] = stateId
					else
						component.StateMap[id][slotIndex] = slot
					end
				end
			end
		end
	end

	--[[
			Compile Light Templates
	--]]

	local lightTemplates = {}
	for lightClassName, templates in pairs( data.Templates or {} ) do
		-- printf( "\t\tLight class %s templates...", lightClassName )

		local lightClass = _G["PhotonElement" .. lightClassName]

		-- Verify light class exists/is supported
		if ( not lightClass ) then
			error(string.format("Unrecognized light class [%s]. Global table [PhotonElement%s] is nil.", lightClassName, lightClassName))
		end

		-- Iterate through each template in the light class
		for templateName, templateData in pairs( templates ) do
			templateData.Class = lightClassName
			-- printf("\t\t\tTemplate name: %s", templateName)
			-- Throw error on duplicate light template name
			if ( lightTemplates[templateName] ) then
				error( string.format( "Light template name [%s] is declared more than once. Each template name must be unique, regardless of its class.", templateName ) )
			end

			-- Set the metatable __index of each template's States to the COMPONENT.ElementStates

			--
			-- Process Template's Light States
			--

			local lightStateClass = PhotonElementState.FindClass( lightClassName )
			
			-- set the "parent" table to either COMPONENT.ElementStates[class] or the default states
			local parentStatesTable = lightStates[lightClassName] or PhotonElement.FindClass( lightClassName ).States
			local templateStates = setmetatable( templateData.States or {}, { __index = parentStatesTable } )
			
			for stateId, state in pairs( templateStates ) do
				templateStates[stateId] = lightStateClass:New( stateId, state, templateStates )
			end

			templateData.States = templateStates

			--
			-- Generate Light Template Object
			--

			lightTemplates[templateName] = lightClass.NewTemplate( templateData )

			if ( not lightTemplates[templateName] ) then
				error( "Light template [" .. tostring(templateName) .. "] was not added. NewTemplate likely returned nil." )
			end
		end

	end
	

	--[[
			Compile Lights
	--]]

	-- print("Compiling lights...")
	for id, light in pairs( data.Elements or {} ) do
		-- printf( "\t\tLight ID: %s", id )
		-- TODO: Process { Set = "x" } scripting

		local inverse = nil

		-- Add light.Inverse value if the template starts with the - sign
		if ( string.StartsWith(light[1], "-") ) then
			inverse = true
			light[1] = string.sub( light[1], 2 )
		end

		-- Verify template
		local template = lightTemplates[light[1]]
		if ( not template ) then 
			error( string.format( "Light template [%s] is not defined.", light[1] ) )
		end

		-- Process light states
		local lightClass = PhotonElement.FindClass( template.Class )
		local lightStateClass = PhotonElementState.FindClass( template.Class )
		if ( istable( light.States ) ) then
			setmetatable( light.States, { __index = template.States } )
			for stateId, state in pairs( light.States ) do
				light.States[stateId] = lightStateClass:New( stateId, state, light.States )
			end
		else
			light.States = template.States
		end
		
		if ( light.Inverse == nil ) then light.Inverse = inverse end

		-- Additional data passed to light constructor for the light
		-- class to process.
		component.Elements[id] = lightClass.New( light, template ) --[[@as PhotonElement]]
	end


	--[[
			Compile Segments
	--]]

	-- for segmentName, segmentData in pairs( data.Segments or {} ) do
	-- 	component.Segments[segmentName] = PhotonElementingSegment.New( segmentName, segmentData, data.ElementGroups, component.InputPriorities )
	-- end



	--[[
			Setup Virtual InputActions
	--]]

	if ( istable( data.VirtualOutputs ) ) then
		component.UseControllerModes = false
		for outputChannel, outputModes in pairs( data.VirtualOutputs ) do
			for modeIndex, modeData in pairs( outputModes ) do
				for inputChannel, inputModes in pairs( modeData.Conditions ) do
					for i=1, #inputModes do
						inputModes[inputModes[i]] = true
					end
				end
			end
		end
		component.VirtualOutputs = data.VirtualOutputs
	end	

	--[[
			Inject Segment Quick Inputs

			(This idea may be abandoned)
	--]]

	-- for segmentName, segment in pairs( component.Segments ) do
	-- 	for channelName, modes in pairs ( segment.QuickInputs ) do
	-- 		data.Inputs[channelName] = data.Input[channelName] or {}
	-- 		for modeName, sequenceName in pairs( modes ) do
	-- 			data.Inputs[channelName][modeName] = data.Inputs[channelName][modeName] or {}
	-- 			data.Inputs[channelName][modeName][segmentName] = segmentName
	-- 		end
	-- 	end
	-- end


	-- local usedSegments = {}

	--[[
			Compile Inputs
	--]]

	for channelName, channel in pairs( data.Inputs or {} ) do
		-- Build input interface channels
		component.InputActions[channelName] = {}
		
		-- local priorityScore = PhotonLightingComponent.DefaultInputPriorities[channelName]
		local priorityScore = component.InputPriorities[channelName]
	
		if ( not priorityScore ) then
			ErrorNoHaltWithStack( "Failed to find input priority score for Input (Pattern) [" .. tostring( channelName ) .. "].")
			priorityScore = 0
		end

		for modeName, sequences in pairs( channel ) do
			
			-- Allows patterns to be assigned like ["MODE1"] = "Pattern" for simplicity
			if ( isstring( sequences ) ) then sequences = { sequences } end

			-- Build input interface modes
			if ( istable( sequences ) and ( next(sequences) ~= nil) ) then
				component.InputActions[channelName][#component.InputActions[channelName] + 1] = modeName
			end

			local patternName = channelName .. ":" .. modeName

			local orderTally = 0

			if ( data.Patterns ) then
				
				local addSequences = {}
				local removeSequences ={}

				for segmentNumber, pattern in ipairs( sequences ) do
					if ( not isnumber( segmentNumber ) ) then continue end
					local autoPatternName
					if ( isstring( pattern ) ) then autoPatternName = pattern end
					autoPatternName = autoPatternName or pattern.Pattern or pattern[1]

					local order = orderTally * 10

					if ( istable( pattern ) and pattern.Order ) then
						order = pattern.Order
					end

					if ( data.Patterns ) then
						local parsedPatternname, phaseDegrees = Photon2.Util.ParseSequenceName( autoPatternName )
						
						if ( data.Patterns[parsedPatternname] ) then
							for index, sequence in pairs( data.Patterns[parsedPatternname] ) do
								
								local sequenceName = sequence[2]
								
								if ( phaseDegrees ) then
									sequenceName = sequenceName .. ":" .. tostring( phaseDegrees )
								end

								addSequences[sequence[1]] = {
									sequenceName,
									Order = sequence.Order or ( order + index )
								}

							end
						else
							warn( "Pattern [%s] does not appear to be defined in COMPONENT.Patterns.", autoPatternName )
						end
					end

					removeSequences[segmentNumber] = true

					orderTally = orderTally + 1
				end

				for segmentName, sequence in pairs( addSequences ) do
					sequences[segmentName] = sequence
				end

				for index, _ in pairs( removeSequences ) do
					sequences[index] = nil
				end

			end

			for segmentName, sequence in pairs ( sequences ) do
				if ( not isstring( segmentName ) ) then continue end
				-- if sequence == "<UNSET>" then continue end

				local sequenceName
				orderTally = orderTally + 1

				local order = orderTally

				if ( isstring( sequence ) ) then
					sequenceName = sequence
					order = orderTally
				elseif ( istable( sequence ) ) then
					sequenceName = sequence[1] or sequence.Name
					order = sequence[2] or sequence.Order or orderTally
				end


				-- sequenceName = patternName .. "/" .. sequenceName
				-- print("Sequence name: " .. sequenceName)
				-- usedSegments[segmentName] = true

				local segment = component.Segments[segmentName]

				-- Segments are setup on-demand so unused ones
				-- won't add overhead to initialized components
				if ( not segment and data.Segments[segmentName] ) then
					component.Segments[segmentName] = PhotonElementingSegment.New( segmentName, data.Segments[segmentName], data.ElementGroups, component.InputPriorities )
					segment = component.Segments[segmentName]
				end

				if (not segment) then
					error( string.format( "Invalid segment: '%s'", segmentName ) )
				end

				-- PHASING
				local phase = component.Phase
				local autoPhase

				if ( phase ) then
					local newSequenceName = sequenceName .. ":" .. phase
					if ( component.Segments[segmentName].Sequences[newSequenceName] or ( isnumber( phase ) ) ) then
						sequenceName = newSequenceName
					else
						if ( string.find( phase, ":" ) ) then
							local phaseName, phaseDegrees = Photon2.Util.ParseSequenceName( phase )
							if ( phaseName and isnumber( phaseDegrees ) and component.Segments[segmentName].Sequences[sequenceName .. ":" .. phaseName]) then
								sequenceName = newSequenceName
							end
						end
						-- print( "Phase NOT found." )
					end
				end

				segment:AddPattern( patternName, sequenceName, priorityScore, order )

			end

		end
	end

	local class = PhotonLightingComponent.ClassMap[component.Class]
	if ( not class ) then error("Unsupported component class [" .. tostring( component.Class ) .. "]") end
	
	if isstring( class ) then class = _G[class] end


	--[[
			Finalize and set meta-table
	--]]
	setmetatable( component, { __index = class } )

	-- print("Component.Inputs ====================================")
	-- 	PrintTable( component.Inputs )
	-- print("=======================================================")

	return component
end


--[[
		INITIALIZATION
--]]

-- Return new INSTANCE of this component that connects
-- to a Photon Controller and component entity.
---@param ent photon_entity
---@param controller PhotonController
---@param uiMode? boolean
---@return PhotonLightingComponent
function Component:Initialize( ent, controller, uiMode )
	-- Calls the base constructor but passes LightingComponent as "self"
	-- so LightingComponent is what's actually used for the metatable,
	-- not PhotonBaseEntity.
	local component = PhotonBaseEntity.Initialize( self, ent, controller, uiMode ) --[[@as PhotonLightingComponent]]

	if ( IsValid( controller ) ) then
		if ( self.UseControllerModes ) then
			component.CurrentModes = controller.CurrentModes
		else
			component.CurrentModes = table.Copy( controller.CurrentModes )
		end
	else
		self.UseControllerModes = false
		component.CurrentModes = {}
	end

	component.Elements = {}
	component.Segments = {}
	component.ActiveSequences = {}
	component.ActiveIndependentSequences = {}
	component.ActiveDependentSequences = {}

	-- Process light table
	for key, light in pairs(self.Elements) do
		component.Elements[key] = light:Initialize( key, component )
	end

	-- Process segments
	for name, segment in pairs(self.Segments) do
		component.Segments[name] = segment:Initialize( component )
	end

	hook.Run( "Photon2:ComponentCreated", component, controller )

	return component
end

function Component:OnScaleChange( newScale, oldScale )
	for key, light in pairs(self.Elements) do
		if (light.SetLightScale) then
			light:SetLightScale( newScale )
		end
	end
end

function Component:Pulse( frameChange )
	-- local frameChange = false
	
	for sequence, _ in pairs( self.ActiveIndependentSequences ) do
		if ( sequence:OnPulse( frameChange ) ) then frameChange = true end
	end

	if ( frameChange ) then
		for i=1, #self.Elements do
			self.Elements[i]:UpdateState()
		end
	end
end

function Component:ApplyModeUpdate()


	-- Virtual outputs
	local virtualOutputs = {}
	for outputChannel, outputModes in pairs( self.VirtualOutputs or {} ) do
		-- print("Virtual Outputs ==========================================")
		-- print("\tChecking output channel [" .. tostring( outputChannel ) .. "]")
		local modeResult = "OFF"
		for i=1, #outputModes do
			-- print("\t\tChecking output mode [" .. tostring( outputModes[i].Mode ) .. "]")
			local conditionsMet = true
			for conditionChannel, conditionModes in pairs( outputModes[i].Conditions ) do
				-- print("\t\t\tChecking condition channel [" .. tostring(conditionChannel .. "]"))
				-- print("\t\t\t\tCurrent mode is [" .. tostring(self.CurrentModes[conditionChannel]) .."]" )
				-- PrintTable( conditionModes )
				if ( not conditionModes[self.CurrentModes[conditionChannel]] ) then
					-- print("\t\t\t\tMode condition NOT met.")
					conditionsMet = false
					break
				end
			end
			if ( conditionsMet ) then
				-- print("\t\t\t\tMode conditions MET.")
				modeResult = outputModes[i].Mode
				break
			end
			-- if ( modeResult ~= "OFF" ) then break end
		end
		virtualOutputs[outputChannel] = modeResult
		self.CurrentModes[outputChannel] = modeResult
		
	end

	local acceptControllerPulse = false
	for name, segment in pairs( self.Segments ) do
		local sequence = segment:ApplyModeUpdate()
		if ( sequence and sequence.AcceptControllerPulse ) then
			acceptControllerPulse = true
			if ( IsValid( self.PhotonController ) ) then
				self.PhotonController.RebuildPulseComponents = true
			end
		end
	end

	self.AcceptControllerPulse = acceptControllerPulse

	-- self:UpdateSegmentLightControl()
	if ( self.PhotonController ) then
		self:FrameTick( true )
	else
		self:IndependentFrameTick( true )
	end
	-- print("\t\tVirtual Outputs table:")
	-- PrintTable( virtualOutputs )
	-- print("\t\tInput table:")
	-- PrintTable( self.CurrentModes )
	-- print("=======================================================")
end

function Component:SetPaused( pause )
	self.IsPaused = pause
end

function Component:ManualThink()
	if ( not self.IsPaused ) then
		self:Pulse()
		self.LastFrameTick = self.LastFrameTick or RealTime()

		if ( RealTime() >= self.LastFrameTick + self.ManualFrameDuration ) then
			self:IndependentFrameTick()
			if ( self.UseStrictFrameTiming ) then
				-- Prevents a frame change "backlog"
				self.LastFrameTick = self.LastFrameTick + self.ManualFrameDuration
				if ( RealTime() >= self.LastFrameTick + 1 ) then
					self.LastFrameTick = RealTime()
				end
			else
				self.LastFrameTick = RealTime()
			end
			
		end
	end
	return self.FrameIndex
end

-- Developer function that turns all active modes to OFF.
function Component:ClearAllModes()
	for thisChannel, thisMode in pairs( self.CurrentModes ) do
		self.CurrentModes[thisChannel] = "OFF"
	end
	self:ApplyModeUpdate()
end

function Component:SuspendAllModes()
	self.SuspendedModes = table.Copy( self.CurrentModes )
	self:ClearAllModes()
end

function Component:ResumeAllModes()
	if ( self.SuspendedModes ) then
		for channel, mode in pairs( self.SuspendedModes ) do
			self.CurrentModes[channel] = mode
		end
		self:ApplyModeUpdate()
	end
end

function Component:SetChannelMode( channel, new, exclusive )
	
	-- printf( "Component received mode change notification for [%s] => %s", channel, new )
	
	if ( not self.UseControllerModes ) then
		if ( exclusive ) then
			for thisChannel, thisMode in pairs( self.CurrentModes ) do
				self.CurrentModes[thisChannel] = "OFF"
			end
		end
		self.CurrentModes[channel] = new
	end

	-- Notify segments
	self:ApplyModeUpdate()
	-- for name, segment in pairs( self.Segments ) do
	-- 	segment:OnModeChange( channel, new )
	-- end
	-- self:FrameTick()
end


---@param segmentName string
---@param sequence PhotonSequence
function Component:RegisterActiveSequence( sequence )
	-- local sequence = self.Segments[segmentName].Sequences[sequence]
	-- printf("Adding sequence [%s]", sequence.Name)
	self.ActiveSequences[sequence] = true

	if ( sequence.AcceptControllerPulse ) then
		self.ActiveIndependentSequences[sequence] = true
	else
		self.ActiveDependentSequences[sequence] = true
	end
end


---@param segmentName string
---@param sequence PhotonSequence
function Component:RemoveActiveSequence( sequence )
	-- printf("Removing sequence [%s]", sequence.Name)
	self.ActiveSequences[sequence] = nil
	self.ActiveIndependentSequences[sequence] = nil
	self.ActiveDependentSequences[sequence] = nil
end

function Component:SetFrameIndex( index )
	self.FrameIndex = index
	for sequence, _ in pairs( self.ActiveSequences ) do
		sequence:IncrementFrame( self.FrameIndex, true )
	end
	for i=1, #self.Elements do
		self.Elements[i]:UpdateState()
	end
end

-- Used for component previewing
function Component:IndependentFrameTick( all, change )
	if ( not self.FrameIndex ) then self.FrameIndex = 0 end
	self.FrameIndex = self.FrameIndex + ( change or 1 )
	-- print( self.FrameIndex )
	if ( all ) then
		for sequence, _ in pairs( self.ActiveSequences ) do
			sequence:IncrementFrame( self.FrameIndex, true )
		end
	else
		for sequence, _ in pairs( self.ActiveDependentSequences ) do
			sequence:IncrementFrame( self.FrameIndex, false )
		end
	end

	for i=1, #self.Elements do
		self.Elements[i]:UpdateState()
	end
end

function Component:FrameTick( all )
	-- for segmentName, segment in pairs( self.Segments ) do 
	-- 	segment:IncrementFrame( self.PhotonController.Frame )
	-- end
	if ( all ) then
		for sequence, _ in pairs( self.ActiveSequences ) do
			sequence:IncrementFrame( self.PhotonController.Frame )
		end
	else
		for sequence, _ in pairs( self.ActiveDependentSequences ) do
			sequence:IncrementFrame( self.PhotonController.Frame )
		end
	end
	

	for i=1, #self.Elements do
		self.Elements[i]:UpdateState()
	end
end

function Component:RemoveVirtual()
	if ( not self.IsVirtual ) then
		error("Cannot call Component:VirtualRemove() on non-virtual components.")
	end
	for i=1, #self.Elements do
		self.Elements[i]:DeactivateNow()
	end
end

function Component:SetStateMap( colorMap )
	if ( isstring( colorMap ) ) then
		-- error("Setting string StateMap: " .. tostring(colorMap))
		colorMap = Photon2.ComponentBuilder.StateMap( colorMap --[[@as string]], self.ElementGroups )
	end
	self.StateMap = colorMap
end

Component.Parameters = {}

Component.PropertyFunctionMap = {
	["StateMap"] = "SetStateMap"
}

Component.PropertiesUpdatedOnSoftUpdate = {
	["StateMap"] = true
}