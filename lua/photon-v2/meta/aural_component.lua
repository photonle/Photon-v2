if (exmeta.ReloadFile()) then return end

-- IComponent

NAME = "PhotonAuralComponent"
BASE = "PhotonComponent"

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
		Inputs = {},
	}

	setmetatable( component, { __index = PhotonAuralComponent } )

	return component
end