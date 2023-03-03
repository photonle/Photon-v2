if (exmeta.ReloadFile("photon_v2/meta/sh_base_light.lua")) then return end

NAME = "photon_base_light"

local Light = META


function Light:Initialize( component, id )

end


function Light:OnStateChange() end


function Light:SetState( state, priority )

end


function Light:PrintTable()
	PrintTable(self)
end