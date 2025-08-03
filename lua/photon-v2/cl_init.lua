include("sh_init.lua")
include("cl_mesh_cache.lua")
include("cl_convars.lua")
include("cl_net.lua")
include("cl_render.lua")
include("cl_dynamic_materials.lua")

LoadPhoton2MetaFiles()

include("cl_ui.lua")
include("cl_ui_skin.lua")
include("cl_hud.lua")
include("sh_component_builder.lua")
include("cl_render_light_projected.lua")
include("cl_render_light_2d.lua")
include("cl_render_light_mesh.lua")
include("cl_render_light_bone.lua")
include("cl_render_bloom.lua")
include("sh_input.lua")
include("cl_input.lua")

include("sh_ent_meta.lua")
include("sh_library.lua")
include("sh_index.lua")

if CLIENT then
	hook.Add("Initialize", "Photon2:Initialize", LoadPhoton2MetaFiles)
end

function Photon2.FreezeFrame()
	PHOTON2_FREEZE = true
end

function Photon2.ResumeFrame()
	PHOTON2_FREEZE = false
end

function Photon2.NextFrame()
	for _, ent in pairs(ents.FindByClass("photon_controller")) do
		ent:DoNextFrame()
		ent:DoPulse()
	end
end

concommand.Add( "ph2_toggle_freeze", function()
	if ( PHOTON2_FREEZE ) then
		Photon2.ResumeFrame()
		return
	end
	Photon2.FreezeFrame()
end)

concommand.Add( "ph2_next_frame", function()
	Photon2.NextFrame()
end)

PhotonMaterial.New({
	Name = "flashlight/wide",
	Shader = "UnlitGeneric",
	Parameters = {
		["$basetexture"] = "photon/flashlight/wide.png"
	}
})

local propList = {
	["Antennas"] = {
		"models/schmal/antenna_absc.mdl",
		"models/schmal/antenna_lojack.mdl",
		"models/schmal/antenna_motorola.mdl",
		"models/schmal/antenna_vhf_1.mdl",
		"models/schmal/antenna_vhf_2.mdl",
	},
	["Antenna Pods"] = {
		"models/schmal/antenna_pod_data.mdl",
		"models/schmal/antenna_pod_navigator.mdl",
		"models/schmal/antenna_pod_quadmode.mdl",
		"models/schmal/antenna_pod_trimode.mdl"
	},
	["License Plate"] = {
		"models/license/na_license_plate.mdl"
	}
}

hook.Add( "PopulateMenuBar", "Photon2:AddPropCategory", function()
	local contents = {}

	for category, models in pairs( propList ) do
		table.insert( contents, {
			type = "header",
			text = category
		})
		for i=1, #models do
			table.insert( contents, {
				type = "model",
				model = models[i]
			})
		end
	end
	spawnmenu.AddPropCategory( "Photon2.Props", "Photon 2", contents, "photon/ui/photon_2_icon_16_centered.png" )
end)

-- TODO: integrate/automate with sound elements
local dspChannels = { 118 }
local dspSounds = {}

function Photon2.MaintainDSPChannels()
	for i=1, #dspChannels do
		local channel = dspChannels[i]
		if ( not dspSounds[channel] ) then
			dspSounds[channel] = CreateSound( LocalPlayer(), "photon/silent_" .. tostring( dspChannels[i] ) .. ".wav" )
			dspSounds[channel]:SetDSP( channel )
		end
		dspSounds[channel]:Play()
	end
end

hook.Add( "InitPostEntity", "Photon2:SirenDSPChannel", function()
	timer.Create( "Photon2:MaintainDSP", 5, 0, Photon2.MaintainDSPChannels )
	Photon2.MaintainDSPChannels()
end)

local lastObserverUpdate = 0
local lastObserverPosition = Vector()
local lastObserverMovement = Vector()

function Photon2.GetObserverMovement()
	if ( lastObserverUpdate == RealTime() ) then return lastObserverMovement end
	lastObserverUpdate = RealTime()
	lastObserverPosition = EyePos()
	lastObserverMovement = lastObserverPosition - lastObserverMovement
	return lastObserverMovement
end