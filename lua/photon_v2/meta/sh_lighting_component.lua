if (exmeta.ReloadFile("photon_v2/meta/sh_lighting_component.lua")) then return end

NAME = "photon_lighting_component"
BASE = "photon_base_component"

local Component = META

Component.IsPhotonLightingComponent = true

-- Component.

function Component:Compile()
	--?
end
