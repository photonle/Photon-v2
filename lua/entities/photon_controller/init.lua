---@diagnostic disable: duplicate-set-field
include("shared.lua" )
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

---@class sv_PhotonController : PhotonController
---@field IsLinkedToStandardVehicle boolean
ENT = ENT

function ENT:Initialize()
	self:InitializeShared()
	self:DrawShadow( false )
	self:SetModel( "models/schmal/photon_controller.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_NONE )
	self:SetModelScale( 1 )
	self:Activate()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
	
	-- Absurdly stupid but is necessary.
	hook.Add( "Think", self, function()
		self:Think()
	end)
end

function ENT:SetProfileName( name )
	-- Photon2.Debug.Print( "Setting controller profile name to " .. name )
	self:SetNW2String( "Photon2:ProfileName", name )
	self:SetupProfile( name )
end


function ENT:SetSelectionOption( categoryIndex, optionIndex )
	self.CurrentSelections[categoryIndex] = optionIndex
	self:SyncSelections()
	self:OnSelectionChanged( categoryIndex, optionIndex )
end

function ENT:SetOperator( ply )
	self:SetNW2Entity( "Photon2:Operator", ply )
end

-- 
function ENT:SyncSelections()
	self:SetNW2String( "Photon2:Selections", table.concat(self.CurrentSelections," "))
end

function ENT:PlayerEnteredLinkedVehicle( ply, vehicle, role )
	Photon2.sv_Network.NotifyPlayerInputController( ply, self )
	self:SetChannelMode( "Vehicle.Transmission", "DRIVE" )
	if ( self:GetChannelMode( "Vehicle.Lights" ) == "OFF" ) then
		self:SetChannelMode( "Vehicle.Lights", "DRL" )
	end
end

function ENT:PlayerExitedLinkedVehicle( ply, vehicle )
	self:UpdateVehicleBraking( false )
	self:UpdateVehicleReversing( false )
	self:SetChannelMode( "Vehicle.Transmission", "PARK" )
	if ( self:GetChannelMode( "Vehicle.Lights" ) == "DRL" ) then
		self:SetChannelMode( "Vehicle.Lights", "OFF" )
	end
end

function ENT:ParentSubMaterialChanged()
	if ( self.LastSubMaterialUpdate and self.LastSubMaterialUpdate >= CurTime() ) then return end
	Photon2.sv_Network.NotifySubMaterialChange( self )
	self.LastSubMaterialUpdate = CurTime()
end

function ENT:Think()
	if ( self.DoHardReload ) then
		self:HardReload()
	end
end