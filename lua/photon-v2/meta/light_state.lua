if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightState"

---@class PhotonLightState
---@field Name string
---@field Intensity number (Default = `1`) Target intensity of the light state.
---@field IntensityTransitions boolean (Default = `false`) Whether intensity transitions (animation) should be used or not.
---@field IntensityGainFactor number (Default = `20`)
---@field IntensityLossFactor number (Default = `10`)
---@field Inherit string | PhotonLightState
local State = exmeta.New()

State.Intensity = 1
State.IntensityTransitions = false
-- State.IntensityGainFactor = 10
-- State.IntensityLossFactor = 10

function State.FindClass( lightClassName )
	local lightStateClass = _G["PhotonLight" .. tostring( lightClassName ) .. "State"]
	
	if ( not lightStateClass ) then
		error(string.format("No light state class could be found for light class [%s]. That means global value PhotonLight%sState is not set.", lightClassName, lightClassName))
	end

	return lightStateClass
end

---@param name string Name of the light state.
---@param data PhotonLightState Input data table of the light state.
---@param collection? table<string, PhotonLightState> Light state table to use for inheritance (typically Component.LightStates).
function State.New( self, name, data, collection )
	local state = data
	state.Name = name

	local restoreValue = false

	-- Enables states to override and inherit existing states
	-- without literally inheriting itself.
	collection = collection or {}
	if ( collection[name] == data ) then
		collection[name] = nil
		restoreValue = true
	end

	if ( state.Inherit ) then
		local inherit
		if ( collection and istable(collection) )then
			if ( isstring( state.Inherit ) ) then
				local parent = collection[state.Inherit]
				if ( not parent ) then
					error(string.format("Light state [%s] failed to inherit from [%s] because it is not defined in the supplied 'collections' table (received [%s]).", name, state.Inherit, tostring(collections)))
				end
				inherit = parent
			end
			setmetatable( state, { __index = inherit } )
		else
			error(string.format("Light state [%s] failed to inherit from [%s] because the 'collection' parameter was not a table (received [%s]).", name, state.Inherit, tostring(collections)))
		end
	else
		setmetatable( state, { __index = self })
	end

	if (restoreValue) then
		collection[name] = state
	end

	return state
end