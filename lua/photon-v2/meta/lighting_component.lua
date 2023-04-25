if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightingComponent"
BASE = "PhotonBaseEntity"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonLightingComponent : PhotonBaseEntity
---@field Name string
---@field Lights table<integer, PhotonLight>
---@field Segments table<string, PhotonLightingSegment>
---@field InputPriorities table<string, integer>
---@field CurrentModes table<string, string>
---@field ActiveSequences table<PhotonSequence, boolean>
---@field UseControllerTiming boolean (Default = `true`) When true, flash/sequence timing is managed by the Controller. Set to `false` if unsynchronized flashing is desired.
---@field ColorMap table<integer, string[]>
local Component = exmeta.New()

local Builder = Photon2.ComponentBuilder

Component.IsPhotonLightingComponent = true

--[[
		COMPILATION
--]]

-- [Internal] Compile a Library Component to store in the Index.
---@param name string
---@param data PhotonLibraryComponent
---@return PhotonLightingComponent
function Component.New( name, data )

	---@type PhotonLightingComponent
	local component = {
		Name = name,
		Model = data.Model,
		Lights = {},
		Segments = {},
		Patterns = {},
		LightGroups = data.LightGroups
	}


	--[[
			Compile Light States
	--]]

	local lightStates = {}
	for lightClassName, states in pairs( data.LightStates or {} ) do
		local lightClass = PhotonLight.FindClass( lightClassName )
		local lightStateClass = PhotonLightState.FindClass( lightClassName )
		-- Use actual COMPONENT.LightStates table to get around load/dependency order issues.
		-- Set __index to the base class's Light.States table.
		lightStates[lightClassName] = setmetatable( states, { __index = lightClass.States })
		for stateId, state in pairs( states ) do
			states[stateId] = lightStateClass:New( stateId, state, states )
		end
	end


	--[[
			Compile Color Map
	--]]

	if ( isstring( data.ColorMap ) ) then
		-- component.ColorMap = Builder.ColorMap( data.ColorMap --[[@as string]], data.LightGroups )
		component.ColorMap = Photon2.ComponentBuilder.ColorMap( data.ColorMap --[[@as string]], data.LightGroups )
	elseif ( istable( data.ColorMap ) ) then
		component.ColorMap = data.ColorMap --[[@as table<integer, string[]>]]
	end

	
	--[[
			Compile Light Templates
	--]]

	local lightTemplates = {}
	for lightClassName, templates in pairs( data.Lighting ) do
		
		local lightClass = _G["PhotonLight" .. lightClassName]
		
		-- Verify light class exists/is supported
		if ( not lightClass ) then
			error(string.format("Unrecognized light class [%s]. Global table [PhotonLight%s] is nil.", lightClassName, lightClassName))
		end
		
		-- Iterate through each template in the light class
		for lightName, lightData in pairs( templates ) do
			-- Throw error on duplicate light template name
			if ( lightTemplates[lightName] ) then
				error( string.format( "Light template name [%s] is declared more than once. Each template name must be unique, regardless of its class.", lightName ) )
			end
			lightTemplates[lightName] = lightClass.NewTemplate( lightData )
		end

	end
	

	--[[
			Compile Lights
	--]]

	for id, light in pairs( data.Lights ) do

		-- TODO: Process { Set = "x" } scripting

		local inverse = false

		if ( string.StartsWith(light[1], "-") ) then 
			inverse = true
			light[1] = string.sub( light[1], 2 )
		end

		-- Verify template
		local template = lightTemplates[light[1]]
		if ( not template ) then 
			error( string.format( "Light template [%s] is not defined.", light[1] ) )
		end

		local lightClass = PhotonLight.FindClass( template.Class )

		component.Lights[id] = lightClass.New( {
			LocalPosition = light[2],
			LocalAngles = light[3],
			States = lightStates[template.Class],
			Inverse = inverse
		}, template ) --[[@as PhotonLight]]
	end


	--[[

			Compile Segments
	--]]

	for segmentName, segmentData in pairs( data.Segments ) do
		component.Segments[segmentName] = PhotonLightingSegment.New( segmentData, data.LightGroups )
	end


	--[[
			Compile Patterns
	--]]

	for channelName, channel in pairs( data.Patterns ) do
		for modeName, mode in pairs( channel ) do
			local patternName = channelName .. ":" .. modeName
			for segmentName, sequence in pairs ( mode ) do
				local segment = component.Segments[segmentName]
				if (not segment) then
					error( string.format("Invalid segment: '%s'", segmentName) )
				end
				if (isstring(sequence)) then
					segment:AddPattern( patternName, sequence )
				else
					-- TODO: advanced pattern assignment
					error( "Invalid pattern assignment." )
				end
			end
		end
	end

	setmetatable( component, { __index = PhotonLightingComponent } )

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

	-- Set CurrentState to directly reference controller's table
	component.CurrentModes = controller.CurrentModes

	component.Lights = {}
	component.Segments = {}
	component.ActiveSequences = {}

	-- Process light table
	for key, light in pairs(self.Lights) do
		component.Lights[key] = light:Initialize( key, component.Entity )
	end

	-- Process segments
	for name, segment in pairs(self.Segments) do
		component.Segments[name] = segment:Initialize( component )
	end

	return component
end


function Component:ApplyModeUpdate()
	for name, segment in pairs( self.Segments ) do
		segment:ApplyModeUpdate()
	end
end


function Component:SetChannelMode( channel, new, old )
	printf( "Component received mode change notification for [%s] => %s", channel, new )
	-- Notify segments
	for name, segment in pairs( self.Segments ) do
		segment:OnModeChange( channel, new )
	end
end



---@param segmentName string
---@param sequence PhotonSequence
function Component:RegisterActiveSequence( segmentName, sequence )
	-- local sequence = self.Segments[segmentName].Sequences[sequence]
	printf("Adding sequence [%s]", sequence)
	self.ActiveSequences[sequence] = true
end


---@param segmentName string
---@param sequence PhotonSequence
function Component:RemoveActiveSequence( segmentName, sequence)
	printf("Removing sequence [%s]", sequence)
	self.ActiveSequences[sequence] = nil
end

function Component:FrameTick()
	-- per-sequence concept
	-- for sequence, v in pairs( self.ActiveSequences ) do
	-- 	sequence:IncrementFrame()
	-- end
	for segmentName, segment in pairs( self.Segments ) do 
		segment:IncrementFrame( self.PhotonController.Frame )
	end

end

function Component:RemoveVirtual()
	if ( not self.IsVirtual ) then
		error("Cannot call Component:VirtualRemove() on non-virtual components.")
	end
	for i=1, #self.Lights do
		self.Lights[i]:DeactivateNow()
	end
end