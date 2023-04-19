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

local Builder = Photon2.ComponentBuilder
local Component = exmeta.New()

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

	if ( isstring( data.ColorMap ) ) then
		-- component.ColorMap = Builder.ColorMap( data.ColorMap --[[@as string]], data.LightGroups )
		component.ColorMap = Photon2.ComponentBuilder.ColorMap( data.ColorMap --[[@as string]], data.LightGroups )
	elseif ( istable( data.ColorMap ) ) then
		component.ColorMap = data.ColorMap --[[@as table<integer, string[]>]]
	end

	-- Setup light templates
	local lightTemplates = {}
	--TODO: lighting providers system
	for lightName, lightData in pairs( data.Lighting["2D"] ) do
		lightTemplates[lightName] = PhotonLight2D.NewTemplate( lightData )
	end

	-- Initialize individual lights
	for id, light in pairs( data.Lights ) do
		component.Lights[id] = PhotonLight2D.New( {
			
			LocalPosition = light[2],
			LocalAngles = light[3]

		}, lightTemplates[light[1]] )
	end

	-- Process segments
	for segmentName, segmentData in pairs( data.Segments ) do
		component.Segments[segmentName] = PhotonLightingSegment.New( segmentData, data.LightGroups )
	end

	-- Process patterns
	print("Processing patterns...")
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
	local component = PhotonBaseEntity.Initialize( self, ent, controller ) --[[@as PhotonLightingComponent]]

	-- Set CurrentState to directly reference controller's table
	component.CurrentModes = controller.CurrentModes

	component.Lights = {}
	component.Segments = {}
	component.ActiveSequences = {}

	-- Process light table
	for key, light in pairs(self.Lights) do
		component.Lights[key] = light:Initialize( key, component )
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