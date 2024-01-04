if (exmeta.ReloadFile()) then return end

-- UNUSED FILE
-- IComponent

NAME = "PhotonComponent"
BASE = "PhotonBaseEntity"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF


---@class PhotonComponent : PhotonBaseEntity
---@field Name string
---@field InputPriorities table<string, integer>
---@field CurrentModes table<string, string>
-- TODO: rename .InputActions to .InputActions?
---@field InputActions table<string, string[]>
local Component = exmeta.New()

function Component.New( name, data, base )
	data = table.Copy( data )

	local ancestors = { [name] = true }

	if ( data.Base ) then
		Util.Inherit( data, table.Copy(Photon2.BuildParentLibraryComponent( name, data.Base ) ))
		Photon2.Library.ComponentsGraph[data.Base] = Photon2.Library.ComponentsGraph[data.Base] or {}
		Photon2.Library.ComponentsGraph[data.Base][name] = true
	end

	return data
end

function Component:Initialize( ent, controller )

end

function Component:ApplyModeUpdate()

end

function Component:SetChannelMode( channel, new, old )

end

function Component:RemoveVirtual()

end

function Component:FrameTick()

end
