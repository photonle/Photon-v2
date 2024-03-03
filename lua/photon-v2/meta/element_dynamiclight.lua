if (exmeta.ReloadFile()) then return end

NAME = "PhotonElementDynamicLight"
BASE = "PhotonElement"

local manager
if ( CLIENT ) then manager = Photon2.Render.DynamicLighting end
local print = Photon2.Debug.Print
local printf = Photon2.Debug.PrintF
local DynamicLight = DynamicLight

---@type PhotonElementDynamicLight
local Element = exmeta.New()

Element.Class = "DynamicLight"

Element.BoneParent = -1
Element.Model = true
Element.World = false
Element.Decay = 1000000
Element.DieTime = 0.001
Element.Brightness = 0
Element.Size = 100
Element.Direction = "Up"

Element.States = {
	["OFF"] = { 
		Color = PhotonColor( 0, 0, 0 ) 
	},
	["R"] = { 
		Color = PhotonColor( 255, 0, 0 ),
	},
	["B"] = { 
		Color = PhotonColor( 0, 0, 255 ),
	},
	["W"] = { 
		Color = PhotonColor( 255, 255, 255 ),
	},
	["SW"] = { 
		Color = PhotonColor( 255, 215, 185 ),
	}
}

function Element.New( element, template )

	if ( not element.LocalPosition and isvector( element[2] ) ) then
		element.LocalPosition = element[2]
	else
		element.LocalPosition = Vector()
	end

	if ( not element.LocalAngles and isangle( element[3] ) ) then
		element.LocalAngles = element[3]
	end

	setmetatable( element, { __index = ( template or PhotonElementDynamicLight )})
	return element
end

function Element:Initialize( id, parent )
	self = PhotonElement.Initialize( self, id, parent ) --[[@as PhotonElementDynamicLight]]
	if CLIENT then self.Index = manager.GetNextIndex() end
	return self
end

function Element.NewTemplate( data )
	return setmetatable( data, { __index = PhotonElementDynamicLight }) 
end

function Element.OnFileLoad()
	for key, value in pairs( Element.States ) do
		Element.States[key] = PhotonElementDynamicLightState:New( key, value, Element.States )
	end
end

Element.OnFileLoad()

---@param state PhotonElementDynamicLight\State
function Element:OnStateChange( state )
	self.Color = state.Color
	self.Brightness = state.Brightness
	self.Size = state.Size
end

function Element:Activate()
	if ( self.UIMode ) then return end
	if not PhotonElement.Activate( self ) then return end
	-- ErrorNoHalt("dlight activate")
	self.Deactivate = false
	if ( self.IsActivated ) then return end
	self.IsActivated = true
	manager.Active[#manager.Active+1] = self
end

function Element:DeactivateNow()
	self.IsActivated = false
	self.Deactivate = false
end

local angleZero = Angle( 0, 0, 0 )

function Element:DoPreRender()
	if ( self.Deactivate or ( not IsValid( self.Parent ) ) ) then self:DeactivateNow() end
	if ( not self.IsActivated ) then return end

	self:UpdateProxyState()
	
	
	if ( self.BoneParent < 0 ) then
		self.Position = self.Parent:LocalToWorld( self.LocalPosition )
		if ( self.LocalAngles ) then
			self.Angles = self.Parent:LocalToWorldAngles( self.LocalAngles )
		end
	else
		-- TODO: optimization
		self.Parent:SetupBones()
		local matrix = self.Parent:GetBoneMatrix( self.BoneParent )
		self.Position, self.Angles = LocalToWorld( self.LocalPosition, self.LocalAngles or angleZero, matrix:GetTranslation(), matrix:GetAngles() )
	end
	
	local dynamicLight = DynamicLight( self.Index, ( self.World == false ) )
	
	if ( dynamicLight ) then
		dynamicLight.pos = self.Position
		-- if ( self.CurrentStateId == "OFF" ) then return self end
		dynamicLight.brightness = self.Brightness
		dynamicLight.decay = self.Decay
		dynamicLight.minlight = self.MinimumLight
		dynamicLight.noworld = ( not self.World )
		dynamicLight.nomodel = ( not self.Model )
		dynamicLight.size = self.Size
		dynamicLight.r = self.Color.r
		dynamicLight.g = self.Color.g
		dynamicLight.b = self.Color.b
		dynamicLight.dietime = CurTime() + self.DieTime
		dynamicLight.style = self.Style
		if ( isangle(self.Angles) ) then
			-- TODO: unclear if there's any reason to manually override this
			dynamicLight.dir = Angle()[self.Direction]( self.Angles )
			dynamicLight.innerangle = self.InnerAngle
			dynamicLight.outerangle = self.OuterAngle
		end
	end

	return self
end