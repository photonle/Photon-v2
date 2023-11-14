Photon2.ComponentBuilder = {}

local string = string

---@param colorMap string
---@param lightGroups table<string, integer[]>
function Photon2.ComponentBuilder.StateMap( colorMap, lightGroups, stateSlots )
	colorMap = string.Replace( colorMap, "\n", " " )
	colorMap = string.Replace( colorMap, "\t", " " )
	colorMap = string.Trim( colorMap )
	while string.find( colorMap, "  " ) do
		colorMap = string.Replace( colorMap, "  ", " " )
	end

	local blocks = string.Split( colorMap, " " )
	
	-- micro optimization
	local validatedStateSlot = false

	local result = {}

	local current
	for i=1, #blocks do
		local block = blocks[i]
		if ( block == "" ) then continue end
		if ( string.StartsWith( block, "[" ) ) then
			block = string.sub( block, 2, string.len(block) - 1 )
			block = string.Replace( block, " ", "" )
			current = string.Split( block, "/" )
			
			for i=1, #current do
				-- If the provided state is a number, it is assumed that it's a slot.
				-- (numeric state names aren't supported)
				local asNumber = tonumber( current[i] )
				if ( asNumber ) then
					if ( not validatedStateSlot ) then
						if ( not istable( stateSlots ) ) then
							error( "Failed to setup StateMap because StateSlots is invalid. Ensure you have COMPONENT.States = {} configured.")
						end
						if ( not stateSlots[asNumber] ) then
							error( "Failed to setup StateMap because slot [" .. tostring(current[i]) .. "] is not defined in COMPONENT.States.")
						end
						validatedStateSlot = true
					end
					current[i] = stateSlots[asNumber]
				end
			end
		else
			local asNumber = tonumber( block )
			if ( not isnumber( asNumber ) ) then
				local group = lightGroups[block]
				if ( not group ) then
					error( string.format( "Invalid light group [%s]", block ) )
				end
				for _i=1, #group do
					result[group[_i]] = current
				end
			elseif ( asNumber ) then
				result[asNumber] = current
			else
				error( "StateMap parsing failed. Received: [" .. tostring(colorMap) .. "]" )
			end
		end
	end

	return result
end
