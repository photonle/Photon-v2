if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Colorado State Patrol - Dodge Durango (2021)"
VEHICLE.Vehicle		= "21durango_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}

local livery = PhotonDynamicMaterial.Generate("schmal_sgm_durang21_csp", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sgm_durang21/co_csp.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.020, 0.020, 0.023),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

VEHICLE.SubMaterials = {
	[17] = "photon/common/blank",
	-- [17] = livery.Name,
}

VEHICLE.Selections = {
	{
		Category = "Body",
		Options = {
			{
				Option = "Black Trim",
				Props = {
					{
						Model = "models/schmal/dodur21_hull.mdl",
						Position = Vector( 0, 0, 0 ),
						Angles = Angle( 0, 0, 0 ),
						SubMaterials = {
							[0] = livery.Name,
						}
					}
				}
			}
		}
	}
}