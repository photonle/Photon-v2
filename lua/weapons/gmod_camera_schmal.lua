
AddCSLuaFile()

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"
SWEP.DrawCrosshair			= true


SWEP.PrintName	= "Camera (Photon)"

SWEP.Slot		= 1
SWEP.SlotPos	= 0

SWEP.DrawAmmo		= false
SWEP.Spawnable		= true

SWEP.ShootSound = Sound( "NPC_CScanner.TakePhoto" )

if ( SERVER ) then

	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false

	--
	-- A concommand to quickly switch to the camera
	--
	concommand.Add( "schmal_camera", function( player, command, arguments )
		-- player:GiveWeap
		player:SelectWeapon( "schmal_camera" )

	end )

end

--
-- Network/Data Tables
--
function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "Zoom" )
	self:NetworkVar( "Float", 1, "Roll" )

	if ( SERVER ) then
		self:SetZoom( 70 )
		self:SetRoll( 0 )
	end

end

--
-- Initialize Stuff
--
function SWEP:Initialize()

	self:SetHoldType( "camera" )

end

--
-- Reload resets the FOV and Roll
--
function SWEP:Reload()

	local owner = self:GetOwner()

	if ( !owner:KeyDown( IN_ATTACK2 ) ) then self:SetZoom( owner:IsBot() && 75 || owner:GetInfoNum( "fov_desired", 75 ) ) end
	self:SetRoll( 0 )

end

--
-- PrimaryAttack - make a screenshot
--
function SWEP:PrimaryAttack()

	-- self:DoShootEffect()

	-- -- If we're multiplayer this can be done totally clientside
	-- if ( !game.SinglePlayer() && SERVER ) then return end
	-- if ( CLIENT && !IsFirstTimePredicted() ) then return end

	-- self:GetOwner():ConCommand( "jpeg" )

end

--
-- SecondaryAttack - Nothing. See Tick for zooming.
--
function SWEP:SecondaryAttack()
end

--
-- Mouse 2 action
--
function SWEP:Tick()
	local owner = self:GetOwner()

	if ( CLIENT && owner != LocalPlayer() ) then return end -- If someone is spectating a player holding this weapon, bail

	if ( owner:InVehicle() ) then return end

	local cmd = owner:GetCurrentCommand()

	if ( !cmd:KeyDown( IN_ATTACK2 ) ) then return end -- Not holding Mouse 2, bail

	self:SetZoom( math.Clamp( self:GetZoom() + cmd:GetMouseY() * FrameTime() * 6.6, 0.1, 175 ) ) -- Handles zooming
	-- self:SetRoll( self:GetRoll() + cmd:GetMouseX() * FrameTime() * 1.65 ) -- Handles rotation

end

--
-- Override players Field Of View
--
function SWEP:TranslateFOV( current_fov )

	return self:GetZoom()

end

--
-- Deploy - Allow lastinv
--
function SWEP:Deploy()

	return true

end

--
-- Set FOV to players desired FOV
--
function SWEP:Equip()

	local owner = self:GetOwner()

	if ( self:GetZoom() == 70 && owner:IsPlayer() && !owner:IsBot() ) then
		self:SetZoom( owner:GetInfoNum( "fov_desired", 75 ) )
	end

end

function SWEP:ShouldDropOnDie() return false end

--
-- The effect when a weapon is fired successfully
--
function SWEP:DoShootEffect()

	local owner = self:GetOwner()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = owner:GetShootPos()
		local vForward = owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

if ( SERVER ) then return end -- Only clientside lua after this line

SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gmod_camera" )

-- Don't draw the weapon info on the weapon selection thing
function SWEP:DrawHUD() end

function SWEP:PrintWeaponInfo( x, y, alpha ) end

function SWEP:DoDrawCrosshair( x, y )
	if ( not self:FreezeMovement() ) then return true end
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( ( ScrW() / 3 ) - 1, 0, 3, ScrH() )
	surface.DrawRect( ( ( ScrW() / 3 ) * 2 ) - 1, 0, 3, ScrH() )
	surface.DrawRect( 0, ( ScrH() / 3 ) - 1, ScrW(), 3 )
	surface.DrawRect( 0, ( ( ScrH() / 3 ) * 2 ) - 1, ScrW(), 3 )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawLine( ScrW() / 3, 0, ScrW() / 3, ScrH() )
	surface.DrawLine( ( ScrW() / 3 ) * 2, 0, ( ScrW() / 3 ) * 2, ScrH() )
	surface.DrawLine( 0, ScrH() / 3, ScrW(), ScrH() / 3 )
	surface.DrawLine( 0, ( ScrH() / 3 ) * 2, ScrW(), ( ScrH() / 3 ) * 2 )
	draw.DrawText( "FOV: " .. math.Round( self:GetZoom(), 2 ) .. "°", "DebugOverlay", ScrW() - 16, 16, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT )
	-- return true
end

function SWEP:HUDShouldDraw( name )
	-- if true then return true end
	-- So we can change weapons
	if ( name == "CHudWeapon" ) then return true end
	if ( name == "CHudWeaponSelection" ) then return true end
	if ( name == "CHudCrosshair" ) then return true end
	return false

end

function SWEP:FreezeMovement()

	local owner = self:GetOwner()

	if ( owner:InVehicle() ) then return false end

	-- Don't aim if we're holding the right mouse button
	if ( owner:KeyDown( IN_ATTACK2 ) || owner:KeyReleased( IN_ATTACK2 ) ) then
		return true
	end

	return false

end

function SWEP:CalcView( ply, origin, angles, fov )

	if ( self:GetRoll() != 0 ) then
		angles.Roll = self:GetRoll()
	end

	return origin, angles, fov

end

function SWEP:AdjustMouseSensitivity()

	if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) then return 1 end

	return self:GetZoom() / 80

end