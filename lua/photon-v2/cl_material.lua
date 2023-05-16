
local licensePlateTemplate = {
	"VertexLitGeneric",
	["$basetexture"] = "photon/common/blank",
	["$bumpmap"] = "photon/common/flat",
	["$detail"] = "photon/license/reflective_paint",
	["$detailscale"] = 6,
	["$detailblendmode"] = 1,
	["$envmap"] = "env_cubemap",
	["$envmaptint"] = Vector( 0.02, 0.02, 0.02 ),
	["$halflambert"] = 1,
	["$phong"] = 1,
	["$phongboost"] = 1,
	["$phongfresnelranges"] = Vector( 1, 1, 1 ),
	["$phongexponent"] = 64,
	["$rimlight"] = 1,
	["$rimlightexponent"] = 10,
	["$rimlightboost"] = 0.1,
	["$phongfix"] = Vector( 1, 1, 1 ),
	["$nocull"] = 1
}

-- local mpdcPlate = PhotonDynamicMaterial.Generate( "ph2_mpdc_demo", licensePlateTemplate,
-- {
-- 	["$basetexture"] = "photon/license/plates/dc_gov_photon2"
-- })

--[[
		Photon Commmon Materials		
--]]

Photon2.Material = {
	Blank = Material( "photon/common/blank" )
}
