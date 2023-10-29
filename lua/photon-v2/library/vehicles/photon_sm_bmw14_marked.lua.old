
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "British - BMW 5 Series Touring"
VEHICLE.Vehicle		= "sm13bmwf11"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "SuperMighty"

VEHICLE.Equipment = {}

if CLIENT then
	-- mpdcSkin.Material:SetTexture("$basetexture", Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "VertexLitGeneric noclamp smooth" ):GetTexture( "$basetexture" ))
end

VEHICLE.SubMaterials = {
	-- [20] = mpdcSkin.Name,
	-- [3] = "photon/common/blank"
	-- [20] = Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "vertexlitgeneric"):GetName(),
}

-- Category -> Option (-> Variant)
VEHICLE.Selections = {
	{
		Category = "Lightbar",
		Options ={
			{
				Option = "Traffic Commander",
				Components = {
					{
						Component = "photon_rsg_traffic_commander",
						Position = Vector( 0, -70, 56 ),
						Angles = Angle( 0, 90, 0 ),
						Scale = 1.1
					}
				}
			}
		}
	},
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false