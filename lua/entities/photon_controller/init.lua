---@diagnostic disable: duplicate-set-field
include("shared.lua" )
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

---@class sv_PhotonController : PhotonController
ENT = ENT

function ENT:SetChannelMode( channel, state )
	self:SetNW2String( "Photon2:CS:" .. channel, string.upper(state) )
end

function ENT:Initialize()
	self:InitializeShared()
	self:DrawShadow( false )
	self:SetModel( "models/photon_ex/controllers/fedsig_scsb.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_NONE )
	self:SetModelScale( 1 )
	self:Activate()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end

	timer.Simple(1, function()
		-- self:SetChannelMode( "Emergency.Warning", "STAGE_1" )
		-- self:SetChannelMode( "Vehicle.Lights", "HEADLIGHTS" )
		-- self:SetChannelMode( "Emergency.Warning", "STAGE_1")
		-- self:SetChannelMode( "Emergency.Auxiliary", "LEFT")
	end)
end

function ENT:SetProfileName( name )
	Photon2.Debug.Print( "Setting controller profile name to " .. name )
	self:SetNW2String( "Photon2:ProfileName", name )
	self:SetupProfile( name )
end


function ENT:SetSelectionOption( categoryIndex, optionIndex )
	self.CurrentSelections[categoryIndex] = optionIndex
	self:SyncSelections()
	self:OnSelectionChanged( categoryIndex, optionIndex )
end


-- 
function ENT:SyncSelections()
	self:SetNW2String( "Photon2:Selections", table.concat(self.CurrentSelections," "))
end