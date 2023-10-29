if (exmeta.ReloadFile()) then return end

-- IComponent

NAME = "PhotonAuralComponent"
BASE = "PhotonComponent"

local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF

---@class PhotonAuralComponent : PhotonComponent
local Speaker = exmeta.New()

function Speaker.New( name, data, base )
	data = PhotonComponent.New( name, data, base )

	local component = {
		Name = name,
		Ancestors = ancestors,
		Descendants = {},
		Children = {},
		Model = data.Model,
		Sounds = data.Sounds,
		InputActions = {},
	}

	setmetatable( component, { __index = PhotonAuralComponent } )

	return component
end

function Speaker:Initialize( ent, controller )
	local component = PhotonBaseEntity.Initialize( self, ent, controller ) --[[@as PhotonElementingComponent]]
	component.CurrentModes = controller.CurrentModes -- TODO: set this in PhotonBaseEntity?
	return component
end

function Speaker:SetChannelMode( channel, new, old )
	printf( "Speaker component received mode change notification for [%s] => ", channel, new )
end