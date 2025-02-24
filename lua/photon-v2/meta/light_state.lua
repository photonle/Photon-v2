if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementState"

---@class PhotonElementState
---@field Name? string Unique name of the element state.
---@field Intensity? number (Default = `1`) Target intensity of the light state.
---@field IntensityTransitions? boolean (Default = `false`) Whether intensity transitions (animation) should be used or not.
---@field IntensityGainFactor? number (Default = `20`)
---@field IntensityLossFactor? number (Default = `10`)
---@field Inherit? string | PhotonElementState
---@field Proxy? table (Special) Allows the rendered state to be based on an external variable look-up rathern than being directly determined by the frame. Made for the Vision SLR.
---@field DeactivationState? string
---@field SuppressInheritanceFailure? boolean (Internal) Silently fails if the inherited state isn't found. Used when states are automatically generated.
---@field Undefined? boolean
local State = exmeta.New()

State.Intensity = 1
State.IntensityTransitions = false
-- State.IntensityGainFactor = 10
-- State.IntensityLossFactor = 10

-- Attempts to look up and return an element's state metatable based on the class name.
---@param lightClassName string Name of the element class.
---@return PhotonElementState
function State.FindClass( lightClassName )
	local lightStateClass = _G["PhotonElement" .. tostring( lightClassName ) .. "State"]
	
	if ( not lightStateClass ) then
		error(string.format("No light state class could be found for light class [%s]. That means global value PhotonElement%sState is not set.", lightClassName, lightClassName))
	end

	return lightStateClass
end

---@param name string Name of the light state.
---@param data PhotonElementState Input data table of the light state.
---@param collection? table<string, PhotonElementState> Light state table to use for inheritance (typically Component.ElementStates).
function State.New( self, name, data, collection )
	local state = data
	state.Name = name
	state.Undefined = nil

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
			if ( isstring( state.Inherit ) or isnumber( state.Inherit ) ) then
				local parent = collection[state.Inherit]
				if ( not parent ) then
					if ( data.SuppressInheritanceFailure ) then
						-- TODO: Entirely returning nil may be better?
						parent = {}
					else
						error(string.format("Light state [%s] failed to inherit from [%s] because it is not defined in the supplied 'collections' table (received [%s]).", name, state.Inherit, tostring(collections)))
					end
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