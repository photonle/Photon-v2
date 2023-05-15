
--[[------------------------------
	Vehicle file for Photon 2
--------------------------------]]



if (Photon2.ReloadVehicleFile()) then return end
local VEHICLE = Photon2.LibraryVehicle()

VEHICLE.Title 		= "Ford Police Interceptor (2020) Demonstrator"
VEHICLE.Vehicle		= "20fpiu_new_sgm"
VEHICLE.Category 	= "Photon 2"
VEHICLE.Author		= "Schmal"

VEHICLE.Equipment = {}


local mpdcSkin = PhotonDynamicMaterial.Generate("schmal_fpiu20_mpdc", { "VertexLitGeneric",
	["$basetexture"] = Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "VertexLitGeneric smooth" ):GetTexture( "$basetexture" ):GetName(),
	["$bumpmap"] = "photon/common/flat",
	["$phong"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector(0.1, 0.1, 0.1),
	["$phongboost"] = 1.25,
	["$phongexponent"] = 23,
	["$nodecal"] = 1
})

if CLIENT then
	-- mpdcSkin.Material:SetTexture("$basetexture", Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "VertexLitGeneric noclamp smooth" ):GetTexture( "$basetexture" ))
end

VEHICLE.DefaultSubMaterials = {
	[20] = mpdcSkin.Name,
	-- [20] = Material( "schmal/liveries/sgm_fpiu20/mpdc.png", "vertexlitgeneric"):GetName(),
}

-- Category -> Option (-> Variant)
VEHICLE.Selections = {
	{
		Category = "License Plate",
		Options = {
			{
				Option = "Rear",
				Props = {
					{
						Model = "models/license/na_license_plate.mdl",
						Position = Vector( 0, -126.7, 49 ),
						Angles = Angle( 0, 0, 80 ),
						Scale = 1.2,
						DefaultSubMaterials = {
							[1] = "photon/common/matte_dark"
						}
					}
				}
			}
		}
	},
	{
		Category = "Standard",
		Options = {
			{
				Option = "Standard Lighting",
				VirtualComponents = {
					{
						Component = "photon_standard_sgmfpiu20"
					}
				}
			}
		}
	},
	{
		Category = "Forward Lightbar",
		Options = {
			{ Option = "SoundOff Signal nForce",
				Components = {
					{
						Name = "@nforce54",
						Component = "photon_sos_nforce_54",
						Position = Vector( 0, -15, 87.55 ),
						Angles = Angle( 0, 0, -1 ),
						Scale = 1.029
					}
				}

			},
			{ Option = "JetSolaris", Variants = {
					{ Variant = "Front",
						Components = {
							{
								Name 		= "@jetsolaris_front",
								Component	= "photon_fedsig_jetsolaris",
								Position	= Vector(0, -15, 91),
								Angles		= Angle(0, 0, 0),
								Scale		= 1
							},
						}
						
					},
					{ Variant = "Alternate",
						Components = {
							{
								Inherit 	= "@jetsolaris_front",
								Scale		= 0.5,
								Position	= Vector(0, -15, 100 )
							}
						}
					},
				}
			}
		},
	}
	-- },
	-- {
	-- 	Category = "Rear Lightbar",
	-- 	Options = {
	-- 		{
	-- 			Option = "None",
	-- 			Components = {}
	-- 		},
	-- 		{
	-- 			Option = "JetSolaris",
	-- 			Components = {
	-- 				{
	-- 					Inherit 	= "@jetsolaris_front",
	-- 					Position	= Vector(0, -65, 91),
	-- 				}
	-- 			}
	-- 		},
			
			
			
	-- 	}
	-- },
}

-- PHOTON2_DEBUG_VEHICLE_HARDRELOAD = false