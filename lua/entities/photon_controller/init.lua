AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua" )

function ENT:SetChannelState( channel, state )
	self:SetNW2String( "Photon2:CS:" .. channel, string.upper(state) )
end

function ENT:Initialize()
	self:DrawShadow( false )
	self:SetModel( "models/photon_ex/controllers/fedsig_scsb.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetModelScale( 2 )
	self:Activate()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

function ENT:SetVehicleName( name )
	self:SetNW2String( "Photon2:VehicleName", name )
end