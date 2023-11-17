if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightingComponent"
BASE = "PhotonBaseEntity"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

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
---@field UseControllerTiming boolean (Default = `true`) When true, flash/sequence timing is managed by the Controller. Set to `false` if unsynchronized flashing is desired.
---@field StateMap table<integer, string[]>
---@field InputActions table<string, string[]>
---@field ElementGroups table<string, integer[]>
---@field UseControllerModes boolean If true, the component will use its controller's CurrentModes table. If false, it will manage its own (required for Virtual InputActions).
---@field Phase string
local Component = exmeta.New()

local Builder = Photon2.ComponentBuilder
local Util = Photon2.Util

Component.UseControllerModes = true
Component.IsPhotonLightingComponent = true
Component.InputPriorities = PhotonBaseEntity.DefaultInputPriorities

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

	if ( data.Base ) then
		Util.Inherit( data, table.Copy( Photon2.BuildParentLibraryComponent( name, data.Base ) ))
		Photon2.Library.ComponentsGraph[data.Base] = Photon2.Library.ComponentsGraph[data.Base] or {}
		Photon2.Library.ComponentsGraph[data.Base][name] = true

		-- if ( Photon2.Library.Components[data.Base] ) then
		-- 	Photon2.Library.Components[data.Base].Children[name] = true
		-- end
	end

	if ( dumpLibraryData ) then
		print("_______________________________________")
		PrintTable(data)
		print("_______________________________________")
	end

	---@type PhotonLightingComponent
	local component = {
		Name = name,
		PrintName = data.PrintName or name,
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
	}

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
			printf("\t\t\tTemplate name: %s", templateName)
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

	for segmentName, segmentData in pairs( data.Segments or {} ) do
		component.Segments[segmentName] = PhotonElementingSegment.New( segmentName, segmentData, data.ElementGroups, component.InputPriorities )
	end

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
			
			if ( not isstring( modeName ) ) then continue end

			-- Build input interface modes
			if ( istable( sequences ) and ( next(sequences) ~= nil) ) then
				component.InputActions[channelName][#component.InputActions[channelName] + 1] = modeName
			end
			-- print("----------------------------")
			-- PrintTable( channel )
			-- print("----------------------------")
			local patternName = channelName .. ":" .. modeName

			-- sequence ranking...
			--[[
				for i=1, #sequences do
					{ Tail, "RIGHT" }
				end
			]]--\
			local rankOrder = 0
			for segmentName, sequence in pairs ( sequences ) do
				-- if sequence == "<UNSET>" then continue end

				local sequenceName
				rankOrder = rankOrder + 1

				local rank = rankOrder

				if ( isstring( sequence ) ) then
					sequenceName = sequence
					rank = rankOrder
				elseif ( istable( sequence ) ) then
					sequenceName = sequence[1] or sequence.Name
					rank = sequence[2] or sequence.Rank or rankOrder
				end


				-- sequenceName = patternName .. "/" .. sequenceName
				-- print("Sequence name: " .. sequenceName)
				local segment = component.Segments[segmentName]

				if (not segment) then
					error( string.format("Invalid segment: '%s'", segmentName) )
				end

				-- PHASING
				local phase = component.Phase

				if ( phase ) then
					local newSequenceName = sequenceName .. ":" .. phase
					-- print( "*********** COMPONENT HAS PHASING ***********" )
					-- print( "Phase: " .. tostring( phase ) )
					-- print( "New sequence name: " .. tostring( newSequenceName ) )
					if ( component.Segments[segmentName].Sequences[newSequenceName] ) then
						-- print( "Phased sequence LOCATED.")
						sequenceName = newSequenceName
					else
						-- print( "Phase NOT found." )
					end
				end

				segment:AddPattern( patternName, sequenceName, priorityScore, rank )

				
				-- print("Segment InputActions =======================")
				-- PrintTable( segment.InputActions )
				-- print("========================================")
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
---@return PhotonLightingComponent
function Component:Initialize( ent, controller )
	-- Calls the base constructor but passes LightingComponent as "self"
	-- so LightingComponent is what's actually used for the metatable,
	-- not PhotonBaseEntity.
	local component = PhotonBaseEntity.Initialize( self, ent, controller ) --[[@as PhotonLightingComponent]]

	if ( self.UseControllerModes ) then
		component.CurrentModes = controller.CurrentModes
	else
		component.CurrentModes = table.Copy( controller.CurrentModes )
	end

	component.Elements = {}
	component.Segments = {}
	component.ActiveSequences = {}

	-- Process light table
	for key, light in pairs(self.Elements) do
		component.Elements[key] = light:Initialize( key, component )
	end

	-- Process segments
	for name, segment in pairs(self.Segments) do
		component.Segments[name] = segment:Initialize( component )
	end

	return component
end


function Component:OnScaleChange( newScale, oldScale )
	for key, light in pairs(self.Elements) do
		if (light.SetLightScale) then
			light:SetLightScale( newScale )
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

	for name, segment in pairs( self.Segments ) do
		segment:ApplyModeUpdate()
	end
	-- self:UpdateSegmentLightControl()
	self:FrameTick()
	-- print("\t\tVirtual Outputs table:")
	-- PrintTable( virtualOutputs )
	-- print("\t\tInput table:")
	-- PrintTable( self.CurrentModes )
	-- print("=======================================================")
end

function Component:SetChannelMode( channel, new, old )
	
	-- printf( "Component received mode change notification for [%s] => %s", channel, new )
	
	if ( not self.UseControllerModes ) then
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
function Component:RegisterActiveSequence( segmentName, sequence )
	-- local sequence = self.Segments[segmentName].Sequences[sequence]
	-- printf("Adding sequence [%s]", sequence)
	self.ActiveSequences[sequence] = true
end


---@param segmentName string
---@param sequence PhotonSequence
function Component:RemoveActiveSequence( segmentName, sequence)
	self.ActiveSequences[sequence] = nil
end

function Component:FrameTick()
	-- Relays notification to each segment
	-- TODO: consider sequence-based updates to reduce overhead
	for segmentName, segment in pairs( self.Segments ) do 
		segment:IncrementFrame( self.PhotonController.Frame )
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