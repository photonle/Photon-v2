if (exmeta.ReloadFile("photon-v2/meta/sh_lighting_component.lua")) then return end

NAME = "PhotonLightingComponent"
BASE = "PhotonBaseEntity"

---@class PhotonLightingComponent : PhotonBaseEntity
---@field Lights table<integer, PhotonLight>
---@field Segments table<string, PhotonLightingSegment>
local Component = META

Component.IsPhotonLightingComponent = true

-- [Internal] Compile a Library Component to store in the Index.
---@param data PhotonLibraryComponent
---@return PhotonLightingComponent
function Component.New( data )

	local component = {
		Lights = {},
		Segments = {}
	}

	-- Process lights

	-- Setup light templates
	local lightTemplates = {}
	--TODO: lighting providers system
	for name, data in pairs( data.Lighting["2D"] ) do
		lightTemplates[name] = exmeta.Inherit( data, PhotonLight2D )
	end

	-- Initialize individual lights
	for id, light in pairs( data.Lights ) do
		component.Lights[id] = exmeta.SetMetaTable(
			{
				LocalPosition = light[2],
				LocalAngles = light[3]
			},
			lightTemplates[light[1]]
		)
		-- PrintTable(lights[i])
		-- local s1 = debug.getmetatable(lights[i]).__index
		-- local s2 = debug.getmetatable(s1).__index
		-- PrintTable(s1)
		-- PrintTable(s2)
	end


	-- Process segments
	for segmentName, segmentData in pairs( data.Segments ) do
		-- Declare new segment
		local segment = PhotonLightingSegment.New()

		-- Add frames to segment
		for i, frame in pairs(segmentData.Frames) do
			segment:AddFrame(i, frame)
		end

		-- Add sequences to segment
		for sequenceName, sequence in pairs(segmentData.Sequences) do
			segment:AddSequence(sequenceName, sequence)
		end

		component.Segments[segmentName] = segment
	end

	-- debug.setmetatable( component, { __index = PhotonLightingComponent } )
	
	return component
end

-- Return new INSTANCE of this component that connects
-- to a Photon Controller and component entity.
---@return PhotonLightingComponent
function Component:Initialize()
	local component = {
		Lights = {},
		Segments = {}
	}
	-- Process light table
	for key, light in pairs(self.Lights) do
		component.Lights[key] = light:Initialize()
	end

	-- Process segments
	for name, segment in pairs(self.Segments) do
		component.Segments[name] = segment:Initialize()
	end

	debug.setmetatable( component, { __index = self } )
	return component
end