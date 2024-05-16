---@diagnostic disable: duplicate-set-field
include("shared.lua" )
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

---@class sv_PhotonController : PhotonController
---@field IsLinkedToStandardVehicle boolean
ENT = ENT

local globalEngineIdleEnabled = GetConVar( "ph2_engine_idle_enabled" )

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

-- function ENT:SetProfileName( name )
-- 	-- Photon2.Debug.Print( "Setting controller profile name to " .. name )
-- 	-- self:SetNW2String( "Photon2:ProfileName", name )
-- 	self:SetDTString( 0, name )
-- 	self:SetupProfile( name )
-- end


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
	self:GetParent():SetNW2String( "Photon2:Selections", table.concat(self.CurrentSelections," "))
end

function ENT:PlayerEnteredLinkedVehicle( ply, vehicle, role )
	if ( self.EngineIdleEnabled ) then
		if ( self.EngineIdleData and self.EngineIdleData.ActiveIdleSound and self.EngineIdleData.ActiveIdleSound:IsPlaying() ) then
			self:DeactivateEngineIdle()
		end
	end
	Photon2.sv_Network.NotifyPlayerInputController( ply, self )
	self:SetChannelMode( "Vehicle.Transmission", "DRIVE" )
	self:SetEngineRunning( true )
	if ( self:GetChannelMode( "Vehicle.Lights" ) == "OFF" ) then
		self:SetChannelMode( "Vehicle.Lights", "AUTO" )
	end
end

function ENT:ActivateEngineIdle()
	if ( globalEngineIdleEnabled:GetBool() == false ) then 
		self:SetEngineRunning( false )
		return 
	end
	local vehicle = self:GetParent() --[[@as Vehicle]]
	if ( not self.EngineIdleData ) then return end
	self.EngineIdleActive = true
	self:SetEngineRunning( true )
	vehicle:StartEngine( true )
	-- Suppress engine start sound caused by function above
	vehicle:StopSound( self.EngineIdleData.StartSound )
	timer.Destroy( self.EngineIdleData.StopIdleTimer )
	if ( not self.EngineIdleData.ActiveIdleSound ) then
		self.EngineIdleData.ActiveIdleSound = CreateSound( vehicle, self.EngineIdleData.IdleSound )
		self:CallOnRemove( "Photon2.EngineIdleSound", function()
			if ( self.EngineIdleData.ActiveIdleSound ) then
				self.EngineIdleData.ActiveIdleSound:Stop()
			end
		end)
	end
	self.EngineIdleData.ActiveIdleSound = 
		self.EngineIdleData.ActiveIdleSound or
		CreateSound( vehicle, self.EngineIdleData.IdleSound )
	self.EngineIdleData.ActiveIdleSound:PlayEx( 0, 100 )
	self.EngineIdleData.ActiveIdleSound:ChangeVolume( 1, self.EngineIdleData.StartDuration )
	timer.Simple( 2, function() 
		if ( not IsValid( self ) ) then return end
		self:UpdateEngineIdle() 
	end )
end

function ENT:UpdateEngineIdle()
	if ( not IsValid( self ) ) then return end
	if ( not self.EngineIdleActive or not self:GetEngineRunning() ) then return end
	if ( not self.EngineIdleData.ActiveIdleSound ) then return end
	self.EngineIdleData.ActiveIdleSound:Play()
	timer.Simple( 2, function() 
		if ( not IsValid( self ) ) then return end
		self:UpdateEngineIdle() 
	end )
end

function ENT:DeactivateEngineIdle()
	if ( not self.EngineIdleData ) then return end
	self.EngineIdleActive = false
	self:SetEngineRunning( false )
	if ( self.EngineIdleData.ActiveIdleSound ) then
		timer.Create( self.EngineIdleData.StopIdleTimer, self.EngineIdleData.StartDuration, 1, function()
			if ( IsValid( self ) ) then
				if ( self.EngineIdleData.ActiveIdleSound ) then
					self.EngineIdleData.ActiveIdleSound:ChangeVolume( 0, 0 )
					self.EngineIdleData.ActiveIdleSound:Stop()
				end
			end
		end)
		timer.Create( self.EngineIdleData.StopStartTimer, 0.01, 200, function() 
			if ( IsValid( self ) ) then
				local vehicle = self:GetParent() --[[@as Vehicle]]
				vehicle:StopSound( self.EngineIdleData.StartSound )
			end
		end )
	end
end

function ENT:PlayerExitedLinkedVehicle( ply, vehicle )
	if ( ply.PhotonEngineIdleExit ) then
		local duration = CurTime() - ply.PhotonEngineIdleExit
	end

	if ( self.EngineIdleEnabled ) then
		if ( not vehicle.PhotonEngineIdleOff ) then
			self:ActivateEngineIdle()
		else
			vehicle.PhotonEngineIdleOff = nil
			self:SetEngineRunning( false )
		end
	else
		self:SetEngineRunning( false )
	end
	

	self:UpdateVehicleBraking( false )
	self:UpdateVehicleReversing( false )
	self:SetChannelMode( "Vehicle.Transmission", "PARK" )
	if ( not self:GetEngineRunning() ) then
		if ( self:GetChannelMode( "Vehicle.Lights" ) == "AUTO" ) then
			self:SetChannelMode( "Vehicle.Lights", "OFF" )
		end
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