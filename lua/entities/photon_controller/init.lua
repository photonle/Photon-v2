AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua" )

function ENT:SetChannelState( channel, state )
	self:SetNW2String( "Photon2:CS:" .. channel, string.upper(state) )
end

function ENT:Initialize()
	-- self:SetMoveType( MOVETYPE_NONE )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( false )
	self:SetModel( "models/photon_ex/controllers/fedsig_scsb.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetModelScale( 5 )
	self:Activate()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

function ENT:Use()
	if (self:GetChannelState( "Emergency.Warning" ) == "OFF" ) then
		self:SetChannelState( "Emergency.Warning", "MODE1" )
	else
		self:SetChannelState( "Emergency.Warning", "OFF" )
	end
end