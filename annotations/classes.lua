---@class Angle
Angle = Angle

-- Adds the values of the argument angle to the orignal angle.This functions the same as angle1 + angle2 without creating a new angle object, skipping object construction and garbage collection.
---@param angle Angle
function Angle:Add(angle) end

-- Divides all values of the original angle by a scalar. This functions the same as angle1 / num without creating a new angle object, skipping object construction and garbage collection.
---@param scalar number
function Angle:Div(scalar) end

-- Returns a normal vector facing in the direction that the angle points.
function Angle:Forward() end

-- Returns whether the pitch, yaw and roll are 0 or not.
function Angle:IsZero() end

-- Multiplies a scalar to all the values of the orignal angle. This functions the same as num * angle without creating a new angle object, skipping object construction and garbage collection.
---@param scalar number
function Angle:Mul(scalar) end

-- Normalizes the angles by applying a module with 360 to pitch, yaw and roll.
function Angle:Normalize() end

-- Randomizes each element of this Angle object.
---@param min number
---@param max number
function Angle:Random(min,max) end

-- Returns a normal vector facing in the direction that points right relative to the angle's direction.
function Angle:Right() end

-- Rotates the angle around the specified axis by the specified degrees.
---@param axis Vector
---@param rotation number
function Angle:RotateAroundAxis(axis,rotation) end

-- Copies pitch, yaw and roll from the second angle to the first.
---@param originalAngle Angle
function Angle:Set(originalAngle) end

-- Sets the p, y, and r of the angle.
---@param p number
---@param y number
---@param r number
function Angle:SetUnpacked(p,y,r) end

-- Snaps the angle to nearest interval of degrees.This will modify the original angle too!
---@param axis string
---@param target number
function Angle:SnapTo(axis,target) end

-- Subtracts the values of the argument angle to the orignal angle. This functions the same as angle1 - angle2 without creating a new angle object, skipping object construction and garbage collection.
---@param angle Angle
function Angle:Sub(angle) end

-- Returns the angle as a table with three elements.
function Angle:ToTable() end

-- Returns the pitch, yaw, and roll components of the angle.
function Angle:Unpack() end

-- Returns a normal vector facing in the direction that points up relative to the angle's direction.
function Angle:Up() end

-- Sets pitch, yaw and roll to 0.This function is faster than doing it manually.
function Angle:Zero() end



---@class bf_read
bf_read = bf_read

-- Reads an returns an angle object from the bitstream.
function bf_read:ReadAngle() end

-- Reads 1 bit an returns a bool representing the bit.
function bf_read:ReadBool() end

-- Reads a signed char and returns a number from -127 to 127 representing the ascii value of that char.
function bf_read:ReadChar() end

-- Reads a short representing an entity index and returns the matching entity handle.
function bf_read:ReadEntity() end

-- Reads a 4 byte float from the bitstream and returns it.
function bf_read:ReadFloat() end

-- Reads a 4 byte long from the bitstream and returns it.
function bf_read:ReadLong() end

-- Reads a 2 byte short from the bitstream and returns it.
function bf_read:ReadShort() end

-- Reads a null terminated string from the bitstream.
function bf_read:ReadString() end

-- Reads a special encoded vector from the bitstream and returns it, this function is not suitable to send normals.
function bf_read:ReadVector() end

-- Reads a special encoded vector normal from the bitstream and returns it, this function is not suitable to send vectors that represent a position.
function bf_read:ReadVectorNormal() end

-- Rewinds the bitstream so it can be read again.
function bf_read:Reset() end



---@class CEffectData
CEffectData = CEffectData

-- Returns the angles of the effect.
function CEffectData:GetAngles() end

-- Returns the attachment ID for the effect.
function CEffectData:GetAttachment() end

-- Returns byte which represents the color of the effect.
function CEffectData:GetColor() end

-- Returns the damage type of the effect
function CEffectData:GetDamageType() end

-- Returns the entity index of the entity set for the effect.
function CEffectData:GetEntIndex() end

-- Returns the entity assigned to the effect.
function CEffectData:GetEntity() end

-- Returns the flags of the effect.
function CEffectData:GetFlags() end

-- Returns the hit box ID of the effect.
function CEffectData:GetHitBox() end

-- Returns the magnitude of the effect.
function CEffectData:GetMagnitude() end

-- Returns the material ID of the effect.
function CEffectData:GetMaterialIndex() end

-- Returns the normalized direction vector of the effect.
function CEffectData:GetNormal() end

-- Returns the origin position of the effect.
function CEffectData:GetOrigin() end

-- Returns the radius of the effect.
function CEffectData:GetRadius() end

-- Returns the scale of the effect.
function CEffectData:GetScale() end

-- Returns the start position of the effect.
function CEffectData:GetStart() end

-- Returns the surface property index of the effect.
function CEffectData:GetSurfaceProp() end

-- Sets the angles of the effect.
---@param ang Angle
function CEffectData:SetAngles(ang) end

-- Sets the attachment id of the effect to be created with this effect data.This is internally stored as an integer, but only the first 5 bits will be networked, effectively limiting this function to 0-31 range.
---@param attachment number
function CEffectData:SetAttachment(attachment) end

-- Sets the "color" of the effect.All this does is provide an addition 8 bits of data for the effect to use. What this will actually do will vary from effect to effect, depending on how a specific effect uses this given data, if at all.Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to 0-255 range.
---@param color number
function CEffectData:SetColor(color) end

-- Sets the damage type of the effect to be created with this effect data.
---@param damageType number
function CEffectData:SetDamageType(damageType) end

-- Sets the entity of the effect via its index.
---@param entIndex number
function CEffectData:SetEntIndex(entIndex) end

-- Sets the entity of the effect to be created with this effect data.
---@param entity Entity
function CEffectData:SetEntity(entity) end

-- Sets the flags of the effect. Can be used to change the appearance of a MuzzleFlash effect.## Example values for MuzzleFlash effectFlags |  Description |------|--------------|1 | Regular muzzleflash|5 | Combine muzzleflash|7 | Regular muzzle but bigger|Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `0-255` range.
---@param flags number
function CEffectData:SetFlags(flags) end

-- Sets the hit box index of the effect.Internally stored as an integer, but only first 11 bits are networked, effectively limiting this function to 0-2047 range.
---@param hitBoxIndex number
function CEffectData:SetHitBox(hitBoxIndex) end

-- Sets the magnitude of the effect.Internally stored as a float with 12 bit precision for networking purposes, limited to range of 0-1023.
---@param magnitude number
function CEffectData:SetMagnitude(magnitude) end

-- Sets the material index of the effect.Internally stored as an integer, but only first 12 bits are networked, effectively limiting this function to 0-4095 range.
---@param materialIndex number
function CEffectData:SetMaterialIndex(materialIndex) end

-- Sets the normalized (length=1) direction vector of the effect to be created with this effect data. This **must** be a normalized vector for networking purposes.
---@param normal Vector
function CEffectData:SetNormal(normal) end

-- Sets the origin of the effect to be created with this effect data.Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)
---@param origin Vector
function CEffectData:SetOrigin(origin) end

-- Sets the radius of the effect to be created with this effect data.Internally stored as a float, but networked as a 10bit float, and is clamped to 0-1023 range.
---@param radius number
function CEffectData:SetRadius(radius) end

-- Sets the scale of the effect to be created with this effect data.
---@param scale number
function CEffectData:SetScale(scale) end

-- Sets the start of the effect to be created with this effect data.Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)
---@param start Vector
function CEffectData:SetStart(start) end

-- Sets the surface property index of the effect.Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `-1`-`254` range.(yes, that's not a mistake)
---@param surfaceProperties number
function CEffectData:SetSurfaceProp(surfaceProperties) end



---@class CLuaEmitter
CLuaEmitter = CLuaEmitter

-- Creates a new CLuaParticle with the given material and position.
---@param material string
---@param position Vector
function CLuaEmitter:Add(material,position) end

-- Manually renders all particles the emitter has created.
function CLuaEmitter:Draw() end

-- Removes the emitter, making it no longer usable from Lua. If particles remain, the emitter will be removed when all particles die.
function CLuaEmitter:Finish() end

-- Returns the amount of active particles of this emitter.
function CLuaEmitter:GetNumActiveParticles() end

-- Returns the position of this emitter. This is set when creating the emitter with Global.ParticleEmitter.
function CLuaEmitter:GetPos() end

-- Returns whether this emitter is 3D or not. This is set when creating the emitter with Global.ParticleEmitter.
function CLuaEmitter:Is3D() end

-- Returns whether this CLuaEmitter is valid or not.
function CLuaEmitter:IsValid() end

-- Sets the bounding box for this emitter.Usually the bounding box is automatically determined by the particles, but this function overrides it.
---@param mins Vector
---@param maxs Vector
function CLuaEmitter:SetBBox(mins,maxs) end

-- This function sets the the distance between the render camera and the emitter at which the particles should start fading and at which distance fade ends ( alpha becomes 0 ).
---@param distanceMin number
---@param distanceMax number
function CLuaEmitter:SetNearClip(distanceMin,distanceMax) end

-- Prevents all particles of the emitter from automatically drawing.
---@param noDraw boolean
function CLuaEmitter:SetNoDraw(noDraw) end

-- The function name has not much in common with its actual function, it applies a radius to every particles that affects the building of the bounding box, as it, usually is constructed by the particle that has the lowest x, y and z and the highest x, y and z, this function just adds/subtracts the radius and inflates the bounding box.
---@param radius number
function CLuaEmitter:SetParticleCullRadius(radius) end

-- Sets the position of the particle emitter.
---@param position Vector
function CLuaEmitter:SetPos(position) end



---@class CLuaLocomotion
CLuaLocomotion = CLuaLocomotion

-- Sets the location we want to get to.Each call of CLuaLocomotion:Approach moves the NextBot 1 unit towards the specified goal. The size of this unit is determined by CLuaLocomotion:SetDesiredSpeed; the default is `0` (each call of CLuaLocomotion:Approach moves the NextBot 0).To achieve smooth movement with CLuaLocomotion:Approach, it should be called in a hook like ENTITY:Think, as shown in the example.
---@param goal Vector
---@param goalweight number
function CLuaLocomotion:Approach(goal,goalweight) end

-- Removes the stuck status from the bot
function CLuaLocomotion:ClearStuck() end

-- Sets the direction we want to face
---@param goal Vector
function CLuaLocomotion:FaceTowards(goal) end

-- Returns the acceleration speed
function CLuaLocomotion:GetAcceleration() end

-- Returns whether the Nextbot is allowed to avoid obstacles or not.
function CLuaLocomotion:GetAvoidAllowed() end

-- Returns whether the Nextbot is allowed to climb or not.
function CLuaLocomotion:GetClimbAllowed() end

-- Returns the current acceleration as a vector
function CLuaLocomotion:GetCurrentAcceleration() end

-- Gets the height the bot is scared to fall from
function CLuaLocomotion:GetDeathDropHeight() end

-- Gets the deceleration speed
function CLuaLocomotion:GetDeceleration() end

-- Returns the desired movement speed set by CLuaLocomotion:SetDesiredSpeed
function CLuaLocomotion:GetDesiredSpeed() end

-- Returns the locomotion's gravity.
function CLuaLocomotion:GetGravity() end

-- Return unit vector in XY plane describing our direction of motion - even if we are currently not moving
function CLuaLocomotion:GetGroundMotionVector() end

-- Returns the current ground normal.
function CLuaLocomotion:GetGroundNormal() end

-- Returns whether the Nextbot is allowed to jump gaps or not.
function CLuaLocomotion:GetJumpGapsAllowed() end

-- Gets the height of the bot's jump
function CLuaLocomotion:GetJumpHeight() end

-- Returns maximum jump height of this CLuaLocomotion.
function CLuaLocomotion:GetMaxJumpHeight() end

-- Returns the max rate at which the NextBot can visually rotate.
function CLuaLocomotion:GetMaxYawRate() end

-- Returns the NextBot this locomotion is associated with.
function CLuaLocomotion:GetNextBot() end

-- Gets the max height the bot can step up
function CLuaLocomotion:GetStepHeight() end

-- Returns the current movement velocity as a vector
function CLuaLocomotion:GetVelocity() end

-- Returns whether this CLuaLocomotion can reach and/or traverse/move in given CNavArea.
---@param area CNavArea
function CLuaLocomotion:IsAreaTraversable(area) end

-- Returns true if we're trying to move.
function CLuaLocomotion:IsAttemptingToMove() end

-- Returns true of the locomotion engine is jumping or climbing
function CLuaLocomotion:IsClimbingOrJumping() end

-- Returns whether the nextbot this locomotion is attached to is on ground or not.
function CLuaLocomotion:IsOnGround() end

-- Returns true if we're stuck
function CLuaLocomotion:IsStuck() end

-- Returns whether or not the target in question is on a ladder or not.
function CLuaLocomotion:IsUsingLadder() end

-- Makes the bot jump. It must be on ground (Entity:IsOnGround) and its model must have `ACT_JUMP` activity.
function CLuaLocomotion:Jump() end

-- Makes the bot jump across a gap. The bot must be on ground (Entity:IsOnGround) and its model must have `ACT_JUMP` activity.
---@param landingGoal Vector
---@param landingForward Vector
function CLuaLocomotion:JumpAcrossGap(landingGoal,landingForward) end

-- Sets the acceleration speed
---@param speed number
function CLuaLocomotion:SetAcceleration(speed) end

-- Sets whether the Nextbot is allowed try to to avoid obstacles or not. This is used during path generation. Works similarly to `nb_allow_avoiding` convar. By default bots are allowed to try to avoid obstacles.
---@param allowed boolean
function CLuaLocomotion:SetAvoidAllowed(allowed) end

-- Sets whether the Nextbot is allowed to climb or not. This is used during path generation. Works similarly to `nb_allow_climbing` convar. By default bots are allowed to climb.
---@param allowed boolean
function CLuaLocomotion:SetClimbAllowed(allowed) end

-- Sets the height the bot is scared to fall from.
---@param height number
function CLuaLocomotion:SetDeathDropHeight(height) end

-- Sets the deceleration speed.
---@param deceleration number
function CLuaLocomotion:SetDeceleration(deceleration) end

-- Sets movement speed.
---@param speed number
function CLuaLocomotion:SetDesiredSpeed(speed) end

-- Sets the locomotion's gravity.With values 0 or below, or even lower positive values, the nextbot will start to drift sideways, use CLuaLocomotion:SetVelocity to counteract this.
---@param gravity number
function CLuaLocomotion:SetGravity(gravity) end

-- Sets whether the Nextbot is allowed to jump gaps or not. This is used during path generation. Works similarly to `nb_allow_gap_jumping` convar. By default bots are allowed to jump gaps.
---@param allowed boolean
function CLuaLocomotion:SetJumpGapsAllowed(allowed) end

-- Sets the height of the bot's jump
---@param height number
function CLuaLocomotion:SetJumpHeight(height) end

-- Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.
---@param yawRate number
function CLuaLocomotion:SetMaxYawRate(yawRate) end

-- Sets the max height the bot can step up
---@param height number
function CLuaLocomotion:SetStepHeight(height) end

-- Sets the current movement velocity
---@param velocity Vector
function CLuaLocomotion:SetVelocity(velocity) end



---@class CLuaParticle
CLuaParticle = CLuaParticle

-- Returns the air resistance of the particle.
function CLuaParticle:GetAirResistance() end

-- Returns the current orientation of the particle.
function CLuaParticle:GetAngles() end

-- Returns the angular velocity of the particle
function CLuaParticle:GetAngleVelocity() end

-- Returns the 'bounciness' of the particle.
function CLuaParticle:GetBounce() end

-- Returns the color of the particle.
function CLuaParticle:GetColor() end

-- Returns the amount of time in seconds after which the particle will be destroyed.
function CLuaParticle:GetDieTime() end

-- Returns the alpha value that the particle will reach on its death.
function CLuaParticle:GetEndAlpha() end

-- Returns the length that the particle will reach on its death.
function CLuaParticle:GetEndLength() end

-- Returns the size that the particle will reach on its death.
function CLuaParticle:GetEndSize() end

-- Returns the gravity of the particle.
function CLuaParticle:GetGravity() end

-- Returns the 'life time' of the particle, how long the particle existed since its creation.This value will always be between 0 and CLuaParticle:GetDieTime.It changes automatically as time goes.It can be manipulated using CLuaParticle:SetLifeTime.If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
function CLuaParticle:GetLifeTime() end

-- Returns the current material of the particle.
function CLuaParticle:GetMaterial() end

-- Returns the absolute position of the particle.
function CLuaParticle:GetPos() end

-- Returns the current rotation of the particle in radians, this should only be used for 2D particles.
function CLuaParticle:GetRoll() end

-- Returns the current rotation speed of the particle in radians, this should only be used for 2D particles.
function CLuaParticle:GetRollDelta() end

-- Returns the alpha value which the particle has when it's created.
function CLuaParticle:GetStartAlpha() end

-- Returns the length which the particle has when it's created.
function CLuaParticle:GetStartLength() end

-- Returns the size which the particle has when it's created.
function CLuaParticle:GetStartSize() end

-- Returns the current velocity of the particle.
function CLuaParticle:GetVelocity() end

-- Sets the air resistance of the the particle.
---@param airResistance number
function CLuaParticle:SetAirResistance(airResistance) end

-- Sets the angles of the particle.
---@param ang Angle
function CLuaParticle:SetAngles(ang) end

-- Sets the angular velocity of the the particle.
---@param angVel Angle
function CLuaParticle:SetAngleVelocity(angVel) end

-- Sets the 'bounciness' of the the particle.
---@param bounce number
function CLuaParticle:SetBounce(bounce) end

-- Sets the whether the particle should collide with the world or not.
---@param shouldCollide boolean
function CLuaParticle:SetCollide(shouldCollide) end

-- Sets the function that gets called whenever the particle collides with the world.
---@param collideFunc function
function CLuaParticle:SetCollideCallback(collideFunc) end

-- Sets the color of the particle.
---@param r number
---@param g number
---@param b number
function CLuaParticle:SetColor(r,g,b) end

-- Sets the time where the particle will be removed.
---@param dieTime number
function CLuaParticle:SetDieTime(dieTime) end

-- Sets the alpha value of the particle that it will reach when it dies.
---@param endAlpha number
function CLuaParticle:SetEndAlpha(endAlpha) end

-- Sets the length of the particle that it will reach when it dies.
---@param endLength number
function CLuaParticle:SetEndLength(endLength) end

-- Sets the size of the particle that it will reach when it dies.
---@param endSize number
function CLuaParticle:SetEndSize(endSize) end

-- Sets the directional gravity aka. acceleration of the particle.
---@param gravity Vector
function CLuaParticle:SetGravity(gravity) end

-- Sets the 'life time' of the particle, how long the particle existed since its creation.This value should always be between 0 and CLuaParticle:GetDieTime.It changes automatically as time goes.If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
---@param lifeTime number
function CLuaParticle:SetLifeTime(lifeTime) end

-- Sets whether the particle should be affected by lighting.
---@param useLighting boolean
function CLuaParticle:SetLighting(useLighting) end

-- Sets the material of the particle.
---@param mat IMaterial
function CLuaParticle:SetMaterial(mat) end

-- Sets when the particles think function should be called next, this uses the synchronized server time returned by Global.CurTime.
---@param nextThink number
function CLuaParticle:SetNextThink(nextThink) end

-- Sets the absolute position of the particle.
---@param pos Vector
function CLuaParticle:SetPos(pos) end

-- Sets the roll of the particle in radians. This should only be used for 2D particles.
---@param roll number
function CLuaParticle:SetRoll(roll) end

-- Sets the rotation speed of the particle in radians. This should only be used for 2D particles.
---@param rollDelta number
function CLuaParticle:SetRollDelta(rollDelta) end

-- Sets the initial alpha value of the particle.
---@param startAlpha number
function CLuaParticle:SetStartAlpha(startAlpha) end

-- Sets the initial length value of the particle.
---@param startLength number
function CLuaParticle:SetStartLength(startLength) end

-- Sets the initial size value of the particle.
---@param startSize number
function CLuaParticle:SetStartSize(startSize) end

-- Sets the think function of the particle.
---@param thinkFunc function
function CLuaParticle:SetThinkFunction(thinkFunc) end

-- Sets the velocity of the particle.
---@param vel Vector
function CLuaParticle:SetVelocity(vel) end

-- Scales the velocity based on the particle speed.
---@param doScale boolean
function CLuaParticle:SetVelocityScale(doScale) end



---@class CMoveData
CMoveData = CMoveData

-- Adds keys to the move data, as if player pressed them.
---@param keys number
function CMoveData:AddKey(keys) end

-- Gets the aim angle. Seems to be same as CMoveData:GetAngles.
function CMoveData:GetAbsMoveAngles() end

-- Gets the aim angle. On client is the same as Entity:GetAngles.
function CMoveData:GetAngles() end

-- Gets which buttons are down
function CMoveData:GetButtons() end

-- Returns the center of the player movement constraint. See CMoveData:SetConstraintCenter.
function CMoveData:GetConstraintCenter() end

-- Returns the radius that constrains the players movement. See CMoveData:SetConstraintRadius.
function CMoveData:GetConstraintRadius() end

-- Returns the player movement constraint speed scale. See CMoveData:SetConstraintSpeedScale.
function CMoveData:GetConstraintSpeedScale() end

-- Returns the width (distance from the edge of the radius, inward) where the actual movement constraint functions.
function CMoveData:GetConstraintWidth() end

-- Returns an internal player movement variable `m_outWishVel`.
function CMoveData:GetFinalIdealVelocity() end

-- Returns an internal player movement variable `m_outJumpVel`.
function CMoveData:GetFinalJumpVelocity() end

-- Returns an internal player movement variable `m_outStepHeight`.
function CMoveData:GetFinalStepHeight() end

-- Returns the players forward speed.
function CMoveData:GetForwardSpeed() end

-- Gets the number passed to "impulse" console command
function CMoveData:GetImpulseCommand() end

-- Returns the maximum client speed of the player
function CMoveData:GetMaxClientSpeed() end

-- Returns the maximum speed of the player.
function CMoveData:GetMaxSpeed() end

-- Returns the angle the player is moving at. For more info, see CMoveData:SetMoveAngles.
function CMoveData:GetMoveAngles() end

-- Gets the aim angle. Only works clientside, server returns same as CMoveData:GetAngles.
function CMoveData:GetOldAngles() end

-- Get which buttons were down last frame
function CMoveData:GetOldButtons() end

-- Gets the player's position.
function CMoveData:GetOrigin() end

-- Returns the strafe speed of the player.
function CMoveData:GetSideSpeed() end

-- Returns the vertical speed of the player. ( Z axis of CMoveData:GetVelocity )
function CMoveData:GetUpSpeed() end

-- Gets the players velocity.This will return Vector(0,0,0) sometimes when walking on props.
function CMoveData:GetVelocity() end

-- Returns whether the key is down or not
---@param key number
function CMoveData:KeyDown(key) end

-- Returns whether the key was pressed. If you want to check if the key is held down, try CMoveData:KeyDown
---@param key number
function CMoveData:KeyPressed(key) end

-- Returns whether the key was released
---@param key number
function CMoveData:KeyReleased(key) end

-- Returns whether the key was down or not.Unlike CMoveData:KeyDown, it will return false if CMoveData:KeyPressed is true and it will return true if CMoveData:KeyReleased is true.
---@param key number
function CMoveData:KeyWasDown(key) end

-- Sets absolute move angles.( ? ) Doesn't seem to do anything.
---@param ang Angle
function CMoveData:SetAbsMoveAngles(ang) end

-- Sets angles.This function does nothing.
---@param ang Angle
function CMoveData:SetAngles(ang) end

-- Sets the pressed buttons on the move data
---@param buttons number
function CMoveData:SetButtons(buttons) end

-- Sets the center of the player movement constraint. See CMoveData:SetConstraintRadius.
---@param pos Vector
function CMoveData:SetConstraintCenter(pos) end

-- Sets the radius that constrains the players movement.Works with conjunction of:* CMoveData:SetConstraintWidth* CMoveData:SetConstraintSpeedScale* CMoveData:SetConstraintCenter
---@param radius number
function CMoveData:SetConstraintRadius(radius) end

-- Sets the player movement constraint speed scale. This will be applied to the player within the CMoveData:SetConstraintRadius when approaching its edge.
---@param  number
function CMoveData:SetConstraintSpeedScale() end

-- Sets  the width (distance from the edge of the CMoveData:SetConstraintRadius, inward) where the actual movement constraint functions.
---@param  number
function CMoveData:SetConstraintWidth() end

-- Sets an internal player movement variable `m_outWishVel`.
---@param idealVel Vector
function CMoveData:SetFinalIdealVelocity(idealVel) end

-- Sets an internal player movement variable `m_outJumpVel`.
---@param jumpVel Vector
function CMoveData:SetFinalJumpVelocity(jumpVel) end

-- Sets an internal player movement variable `m_outStepHeight`.
---@param stepHeight number
function CMoveData:SetFinalStepHeight(stepHeight) end

-- Sets players forward speed.
---@param speed number
function CMoveData:SetForwardSpeed(speed) end

-- Sets the impulse command. This isn't actually utilised in the engine anywhere.
---@param impulse number
function CMoveData:SetImpulseCommand(impulse) end

-- Sets the maximum player speed. Player won't be able to run or sprint faster then this value.This also automatically sets CMoveData:SetMaxSpeed when used in the GM:SetupMove hook. You must set it manually in the GM:Move hook.This must be called on both client and server to avoid prediction errors.This will **not** reduce speed in air.Setting this to 0 will not make the player stationary. It won't do anything.
---@param maxSpeed number
function CMoveData:SetMaxClientSpeed(maxSpeed) end

-- Sets the maximum speed of the player. This must match with CMoveData:SetMaxClientSpeed both, on server and client.Doesn't seem to be doing anything on it's own, use CMoveData:SetMaxClientSpeed instead.
---@param maxSpeed number
function CMoveData:SetMaxSpeed(maxSpeed) end

-- Sets the serverside move angles, making the movement keys act as if player was facing that direction.This does nothing clientside.
---@param dir Angle
function CMoveData:SetMoveAngles(dir) end

-- Sets old aim angles. ( ? ) Doesn't seem to be doing anything.
---@param aimAng Angle
function CMoveData:SetOldAngles(aimAng) end

-- Sets the 'old' pressed buttons on the move data. These buttons are used to work out which buttons have been released, which have just been pressed and which are being held down.
---@param buttons number
function CMoveData:SetOldButtons(buttons) end

-- Sets the players position.
---@param pos Vector
function CMoveData:SetOrigin(pos) end

-- Sets players strafe speed.
---@param speed number
function CMoveData:SetSideSpeed(speed) end

-- Sets vertical speed of the player. ( Z axis of CMoveData:SetVelocity )
---@param speed number
function CMoveData:SetUpSpeed(speed) end

-- Sets the player's velocity
---@param velocity Vector
function CMoveData:SetVelocity(velocity) end



---@class CNavArea
CNavArea = CNavArea

-- Adds a hiding spot onto this nav area.There's a limit of 255 hiding spots per area.
---@param pos Vector
---@param flags number
function CNavArea:AddHidingSpot(pos,flags) end

-- Adds this CNavArea to the closed list, a list of areas that have been checked by A* pathfinding algorithm.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:AddToClosedList() end

-- Adds this CNavArea to the Open List.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:AddToOpenList() end

-- Clears the open and closed lists for a new search.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:ClearSearchLists() end

-- Returns the height difference between the edges of two connected navareas.
---@param navarea CNavArea
function CNavArea:ComputeAdjacentConnectionHeightChange(navarea) end

-- Returns the Enums/NavDir direction that the given vector faces on this CNavArea.
---@param pos Vector
function CNavArea:ComputeDirection(pos) end

-- Returns the height difference on the Z axis of the two CNavAreas. This is calculated from the center most point on both CNavAreas.
---@param navArea CNavArea
function CNavArea:ComputeGroundHeightChange(navArea) end

-- Connects this CNavArea to another CNavArea or CNavLadder with a one way connection. ( From this area to the target )See CNavLadder:ConnectTo for making the connection from ladder to area.
---@param area CNavArea
function CNavArea:ConnectTo(area) end

-- Returns true if this CNavArea contains the given vector.
---@param pos Vector
function CNavArea:Contains(pos) end

-- Disconnects this nav area from given area or ladder. (Only disconnects one way)
---@param area CNavArea
function CNavArea:Disconnect(area) end

-- Draws this navarea on debug overlay.
function CNavArea:Draw() end

-- Draws the hiding spots on debug overlay. This includes sniper/exposed spots too!
function CNavArea:DrawSpots() end

-- Returns a table of all the CNavAreas that have a  ( one and two way ) connection **from** this CNavArea.If an area has a one-way incoming connection to this CNavArea, then it will **not** be returned from this function, use CNavArea:GetIncomingConnections to get all one-way incoming connections.See CNavArea:GetAdjacentAreasAtSide for a function that only returns areas from one side/direction.
function CNavArea:GetAdjacentAreas() end

-- Returns a table of all the CNavAreas that have a ( one and two way ) connection **from** this CNavArea in given direction.If an area has a one-way incoming connection to this CNavArea, then it will **not** be returned from this function, use CNavArea:GetIncomingConnections to get all incoming connections.See CNavArea:GetAdjacentAreas for a function that returns all areas from all sides/directions.
---@param navDir number
function CNavArea:GetAdjacentAreasAtSide(navDir) end

-- Returns the amount of CNavAreas that have a connection ( one and two way ) **from** this CNavArea.See CNavArea:GetAdjacentCountAtSide for a function that only returns area count from one side/direction.
function CNavArea:GetAdjacentCount() end

-- Returns the amount of CNavAreas that have a connection ( one or two way ) **from** this CNavArea in given direction.See CNavArea:GetAdjacentCount for a function that returns CNavArea count from/in all sides/directions.
---@param navDir number
function CNavArea:GetAdjacentCountAtSide(navDir) end

-- Returns the attribute mask for the given CNavArea.
function CNavArea:GetAttributes() end

-- Returns the center most vector point for the given CNavArea.
function CNavArea:GetCenter() end

-- Returns the closest point of this Nav Area from the given position.
---@param pos Vector
function CNavArea:GetClosestPointOnArea(pos) end

-- Returns the vector position of the corner for the given CNavArea.
---@param cornerid number
function CNavArea:GetCorner(cornerid) end

-- Returns the cost from starting area this area when pathfinding. Set by CNavArea:SetCostSoFar.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:GetCostSoFar() end

-- Returns a table of very bad hiding spots in this area.See also CNavArea:GetHidingSpots.
function CNavArea:GetExposedSpots() end

-- Returns size info about the nav area.
function CNavArea:GetExtentInfo() end

-- Returns a table of good hiding spots in this area.See also CNavArea:GetExposedSpots.
---@param type number
function CNavArea:GetHidingSpots(type) end

-- Returns this CNavAreas unique ID.
function CNavArea:GetID() end

-- Returns a table of all the CNavAreas that have a one-way connection **to** this CNavArea.If a CNavArea has a two-way connection **to or from** this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections.See CNavArea:GetIncomingConnectionsAtSide for a function that returns one-way incoming connections from  only one side/direction.
function CNavArea:GetIncomingConnections() end

-- Returns a table of all the CNavAreas that have a one-way connection **to** this CNavArea from given direction.If a CNavArea has a two-way connection **to or from** this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections.See CNavArea:GetIncomingConnections for a function that returns one-way incoming connections from  all sides/directions.
---@param navDir number
function CNavArea:GetIncomingConnectionsAtSide(navDir) end

-- Returns all CNavLadders that have a ( one or two way ) connection **from** this CNavArea.See CNavArea:GetLaddersAtSide for a function that only returns CNavLadders in given direction.
function CNavArea:GetLadders() end

-- Returns all CNavLadders that have a ( one or two way ) connection **from** ( one and two way ) this CNavArea in given direction.See CNavArea:GetLadders for a function that returns CNavLadder from/in all sides/directions.
---@param navDir number
function CNavArea:GetLaddersAtSide(navDir) end

-- Returns the parent CNavArea
function CNavArea:GetParent() end

-- Returns how this CNavArea is connected to its parent.
function CNavArea:GetParentHow() end

-- Returns the Place of the nav area.
function CNavArea:GetPlace() end

-- Returns a random CNavArea that has an outgoing ( one or two way ) connection **from** this CNavArea in given direction.
---@param navDir number
function CNavArea:GetRandomAdjacentAreaAtSide(navDir) end

-- Returns a random point on the nav area.
function CNavArea:GetRandomPoint() end

-- Returns the width this Nav Area.
function CNavArea:GetSizeX() end

-- Returns the height of this Nav Area.
function CNavArea:GetSizeY() end

-- Returns the total cost when passing from starting area to the goal area through this node. Set by CNavArea:SetTotalCost.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:GetTotalCost() end

-- Returns the elevation of this Nav Area at the given position.
---@param pos Vector
function CNavArea:GetZ(pos) end

-- Returns true if the given CNavArea has this attribute flag set.
---@param attribs number
function CNavArea:HasAttributes(attribs) end

-- Returns whether the nav area is blocked or not, i.e. whether it can be walked through or not.
---@param teamID number
---@param ignoreNavBlockers boolean
function CNavArea:IsBlocked(teamID,ignoreNavBlockers) end

-- Returns whether this node is in the Closed List.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:IsClosed() end

-- Returns whether this CNavArea can completely (i.e. all corners of this area can see all corners of the given area) see the given CNavArea.
---@param area CNavArea
function CNavArea:IsCompletelyVisible(area) end

-- Returns whether this CNavArea has an outgoing ( one or two way ) connection **to** given CNavArea.See CNavArea:IsConnectedAtSide for a function that only checks for outgoing connections in one direction.
---@param navArea CNavArea
function CNavArea:IsConnected(navArea) end

-- Returns whether this CNavArea has an outgoing ( one or two way ) connection **to** given CNavArea in given direction.See CNavArea:IsConnected for a function that checks all sides.
---@param navArea CNavArea
---@param navDirType number
function CNavArea:IsConnectedAtSide(navArea,navDirType) end

-- Returns whether this Nav Area is in the same plane as the given one.
---@param navArea CNavArea
function CNavArea:IsCoplanar(navArea) end

-- Returns whether this Nav Area is flat within the tolerance of the **nav_coplanar_slope_limit_displacement** and **nav_coplanar_slope_limit** convars.
function CNavArea:IsFlat() end

-- Returns whether this area is in the Open List.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:IsOpen() end

-- Returns whether the Open List is empty or not.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:IsOpenListEmpty() end

-- Returns if this position overlaps the Nav Area within the given tolerance.
---@param pos Vector
---@param tolerance number
function CNavArea:IsOverlapping(pos,tolerance) end

-- Returns true if this CNavArea is overlapping the given CNavArea.
---@param navArea CNavArea
function CNavArea:IsOverlappingArea(navArea) end

-- Returns whether this CNavArea can see given position.
---@param pos Vector
---@param ignoreEnt Entity
function CNavArea:IsPartiallyVisible(pos,ignoreEnt) end

-- Returns whether this CNavArea can potentially see the given CNavArea.
---@param area CNavArea
function CNavArea:IsPotentiallyVisible(area) end

-- Returns if we're shaped like a square.
function CNavArea:IsRoughlySquare() end

-- Whether this Nav Area is placed underwater.
function CNavArea:IsUnderwater() end

-- Returns whether this CNavArea is valid or not.
function CNavArea:IsValid() end

-- Returns whether we can be seen from the given position.
---@param pos Vector
function CNavArea:IsVisible(pos) end

-- Drops a corner or all corners of a CNavArea to the ground below it.
---@param corner number
function CNavArea:PlaceOnGround(corner) end

-- Removes a CNavArea from the Open List with the lowest cost to traverse to from the starting node, and returns it.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:PopOpenList() end

-- Removes the given nav area.
function CNavArea:Remove() end

-- Removes this node from the Closed List.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:RemoveFromClosedList() end

-- Sets the attributes for given CNavArea.
---@param attribs number
function CNavArea:SetAttributes(attribs) end

-- Sets the position of a corner of a nav area.
---@param corner number
---@param position Vector
function CNavArea:SetCorner(corner,position) end

-- Sets the cost from starting area this area when pathfinding.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
---@param cost number
function CNavArea:SetCostSoFar(cost) end

-- Sets the new parent of this CNavArea.
---@param parent CNavArea
---@param how number
function CNavArea:SetParent(parent,how) end

-- Sets the Place of the nav area.There is a limit of 256 Places per nav file.
---@param place string
function CNavArea:SetPlace(place) end

-- Sets the total cost when passing from starting area to the goal area through this node.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
---@param cost number
function CNavArea:SetTotalCost(cost) end

-- Moves this open list to appropriate position based on its CNavArea:GetTotalCost compared to the total cost of other areas in the open list.Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).More information can be found on the Simple Pathfinding page.
function CNavArea:UpdateOnOpenList() end



---@class CNavLadder
CNavLadder = CNavLadder

-- Connects this ladder to a CNavArea with a one way connection. ( From this ladder to the target area ).See CNavArea:ConnectTo for making the connection from area to ladder.
---@param area CNavArea
function CNavLadder:ConnectTo(area) end

-- Disconnects this ladder from given area in a single direction.
---@param area CNavArea
function CNavLadder:Disconnect(area) end

-- Returns the bottom most position of the ladder.
function CNavLadder:GetBottom() end

-- Returns the bottom area of the CNavLadder.
function CNavLadder:GetBottomArea() end

-- Returns this CNavLadders unique ID.
function CNavLadder:GetID() end

-- Returns the length of the ladder.
function CNavLadder:GetLength() end

-- Returns the direction of this CNavLadder. ( The direction in which players back will be facing if they are looking directly at the ladder )
function CNavLadder:GetNormal() end

-- Returns the world position based on given height relative to the ladder.
---@param height number
function CNavLadder:GetPosAtHeight(height) end

-- Returns the topmost position of the ladder.
function CNavLadder:GetTop() end

-- Returns the top behind CNavArea of the CNavLadder.
function CNavLadder:GetTopBehindArea() end

-- Returns the top forward CNavArea of the CNavLadder.
function CNavLadder:GetTopForwardArea() end

-- Returns the top left CNavArea of the CNavLadder.
function CNavLadder:GetTopLeftArea() end

-- Returns the top right CNavArea of the CNavLadder.
function CNavLadder:GetTopRightArea() end

-- Returns the width of the ladder in Hammer Units.
function CNavLadder:GetWidth() end

-- Returns whether this CNavLadder has an outgoing ( one or two way ) connection **to** given CNavArea in given direction.
---@param navArea CNavArea
---@param navDirType number
function CNavLadder:IsConnectedAtSide(navArea,navDirType) end

-- Returns whether this CNavLadder is valid or not.
function CNavLadder:IsValid() end

-- Removes the given nav ladder.
function CNavLadder:Remove() end

-- Sets the bottom area of the CNavLadder.
---@param area CNavArea
function CNavLadder:SetBottomArea(area) end

-- Sets the top behind area of the CNavLadder.
---@param area CNavArea
function CNavLadder:SetTopBehindArea(area) end

-- Sets the top forward area of the CNavLadder.
---@param area CNavArea
function CNavLadder:SetTopForwardArea(area) end

-- Sets the top left area of the CNavLadder.
---@param area CNavArea
function CNavLadder:SetTopLeftArea(area) end

-- Sets the top right area of the CNavLadder.
---@param area CNavArea
function CNavLadder:SetTopRightArea(area) end



---@class CNewParticleEffect
CNewParticleEffect = CNewParticleEffect

-- Adds a control point to the particle system.This function will not work if the CNewParticleEffect:GetOwner entity is not valid
---@param cpID number
---@param ent Entity
---@param partAttachment number
---@param entAttachment number
---@param offset Vector
function CNewParticleEffect:AddControlPoint(cpID,ent,partAttachment,entAttachment,offset) end

function CNewParticleEffect:GetAutoUpdateBBox() end

-- Returns the name of the particle effect this system is set to emit.
function CNewParticleEffect:GetEffectName() end

-- Returns the highest control point number for given particle system.
function CNewParticleEffect:GetHighestControlPoint() end

-- Returns the owner of the particle system, the entity the particle system is attached to.
function CNewParticleEffect:GetOwner() end

-- Returns whether the particle system has finished emitting particles or not.
function CNewParticleEffect:IsFinished() end

-- Returns whether the particle system is valid or not.
function CNewParticleEffect:IsValid() end

-- Returns whether the particle system is intended to be used on a view model?
function CNewParticleEffect:IsViewModelEffect() end

-- Forces the particle system to render using current rendering context.Can be used to render the particle system in vgui panels, etc.Used in conjunction with CNewParticleEffect:SetShouldDraw.
function CNewParticleEffect:Render() end

-- Forces the particle system to restart emitting particles.
function CNewParticleEffect:Restart() end

-- Sets a value for given control point.
---@param cpID number
---@param value Vector
function CNewParticleEffect:SetControlPoint(cpID,value) end

-- Essentially makes child control point follow the parent entity.
---@param child number
---@param parent Entity
function CNewParticleEffect:SetControlPointEntity(child,parent) end

-- Sets the forward direction for given control point.
---@param cpID number
---@param forward Vector
function CNewParticleEffect:SetControlPointForwardVector(cpID,forward) end

-- Sets the orientation for given control point.
---@param cpID number
---@param forward Vector
---@param right Vector
---@param up Vector
function CNewParticleEffect:SetControlPointOrientation(cpID,forward,right,up) end

-- Essentially makes child control point follow the parent control point.
---@param child number
---@param parent number
function CNewParticleEffect:SetControlPointParent(child,parent) end

-- Sets the right direction for given control point.
---@param cpID number
---@param right Vector
function CNewParticleEffect:SetControlPointRightVector(cpID,right) end

-- Sets the upward direction for given control point.
---@param cpID number
---@param upward Vector
function CNewParticleEffect:SetControlPointUpVector(cpID,upward) end

---@param isViewModel boolean
function CNewParticleEffect:SetIsViewModelEffect(isViewModel) end

-- Forces the particle system to stop automatically rendering.Used in conjunction with CNewParticleEffect:Render.
---@param should boolean
function CNewParticleEffect:SetShouldDraw(should) end

-- Sets the sort origin for given particle system. This is used as a helper to determine which particles are in front of which.
---@param origin Vector
function CNewParticleEffect:SetSortOrigin(origin) end

-- Starts the particle emission.
---@param infiniteOnly boolean
function CNewParticleEffect:StartEmission(infiniteOnly) end

-- Stops the particle emission.
---@param infiniteOnly boolean
---@param removeAllParticles boolean
---@param wakeOnStop boolean
function CNewParticleEffect:StopEmission(infiniteOnly,removeAllParticles,wakeOnStop) end

-- Stops particle emission and destroys all particles instantly. Also detaches the particle effect from the entity it was attached to.This function will work identically to CNewParticleEffect:StopEmission( false, true ) if  CNewParticleEffect:GetOwner entity is not valid.Consider using CNewParticleEffect:StopEmission( false, true ) instead, which has same effect, but doesn't require owner entity, and does't detach the particle system from its entity.
function CNewParticleEffect:StopEmissionAndDestroyImmediately() end



---@class Color
Color = Color

-- Sets the red, green, blue, and alpha of the color.
---@param r number
---@param g number
---@param b number
---@param a number
function Color:SetUnpacked(r,g,b,a) end

-- Converts a Color into HSL color space. This calls Global.ColorToHSL internally.
function Color:ToHSL() end

-- Converts a Color into HSV color space. This calls Global.ColorToHSV internally.
function Color:ToHSV() end

-- Returns the color as a table with four elements.
function Color:ToTable() end

-- Translates the Color into a Vector, losing the alpha channel.This will also range the values from 0 - 255 to 0 - 1r / 255 -&gt; xg / 255 -&gt; yb / 255 -&gt; zThis is the opposite of Vector:ToColor
function Color:ToVector() end

-- Returns the red, green, blue, and alpha of the color.
function Color:Unpack() end



---@class ConVar
ConVar = ConVar

-- Tries to convert the current string value of a ConVar to a boolean.
function ConVar:GetBool() end

-- Returns the default value of the ConVar
function ConVar:GetDefault() end

-- Returns the Enums/FCVAR flags of the ConVar
function ConVar:GetFlags() end

-- Attempts to convert the ConVar value to a float
function ConVar:GetFloat() end

-- Returns the help text assigned to that convar.
function ConVar:GetHelpText() end

-- Attempts to convert the ConVar value to a integer.
function ConVar:GetInt() end

-- Returns the maximum value of the ConVar
function ConVar:GetMax() end

-- Returns the minimum value of the ConVar
function ConVar:GetMin() end

-- Returns the name of the ConVar.
function ConVar:GetName() end

-- Returns the current ConVar value as a string.
function ConVar:GetString() end

-- Returns whether the specified flag is set on the ConVar
---@param flag number
function ConVar:IsFlagSet(flag) end

-- Reverts ConVar to its default value
function ConVar:Revert() end

-- Sets a ConVar's value to 1 or 0 based on the input boolean. This can only be ran on ConVars created from within Lua.
---@param value boolean
function ConVar:SetBool(value) end

-- Sets a ConVar's value to the input number.This can only be ran on ConVars created from within Lua.
---@param value number
function ConVar:SetFloat(value) end

-- Sets a ConVar's value to the input number after converting it to an integer.This can only be ran on ConVars created from within Lua.
---@param value number
function ConVar:SetInt(value) end

-- Sets a ConVar's value to the input string. This can only be ran on ConVars created from within Lua.
---@param value string
function ConVar:SetString(value) end



---@class CRecipientFilter
CRecipientFilter = CRecipientFilter

-- Adds all players to the recipient filter.
function CRecipientFilter:AddAllPlayers() end

-- Adds all players that are in the same [PAS (Potentially Audible Set)](https://developer.valvesoftware.com/wiki/PAS "PAS - Valve Developer Community") as this position.
---@param pos Vector
function CRecipientFilter:AddPAS(pos) end

-- Adds a player to the recipient filter
---@param Player Player
function CRecipientFilter:AddPlayer(Player) end

-- Adds all players that are in the same [PVS(Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") as this position.
---@param Position Vector
function CRecipientFilter:AddPVS(Position) end

-- Adds all players that are on the given team to the filter.
---@param teamid number
function CRecipientFilter:AddRecipientsByTeam(teamid) end

-- Returns the number of valid players in the recipient filter.
function CRecipientFilter:GetCount() end

-- Returns a table of all valid players currently in the recipient filter.
function CRecipientFilter:GetPlayers() end

-- Removes all players from the recipient filter.
function CRecipientFilter:RemoveAllPlayers() end

-- Removes all players from the filter that are in Potentially Audible Set for given position.
---@param position Vector
function CRecipientFilter:RemovePAS(position) end

-- Removes the player from the recipient filter.
---@param Player Player
function CRecipientFilter:RemovePlayer(Player) end

-- Removes all players that can see this PVS from the recipient filter.
---@param pos Vector
function CRecipientFilter:RemovePVS(pos) end

-- Removes all players that are on the given team from the filter.
---@param teamid number
function CRecipientFilter:RemoveRecipientsByTeam(teamid) end

-- Removes all players that are not on the given team from the filter.
---@param teamid number
function CRecipientFilter:RemoveRecipientsNotOnTeam(teamid) end



---@class CSEnt
CSEnt = CSEnt

-- Removes the clientside entity
function CSEnt:Remove() end



---@class CSoundPatch
CSoundPatch = CSoundPatch

-- Adjust the pitch, alias the speed at which the sound is being played.This invokes the GM:EntityEmitSound.
---@param pitch number
---@param deltaTime number
function CSoundPatch:ChangePitch(pitch,deltaTime) end

-- Adjusts the volume of the sound played.Appears to only work while the sound is being played.
---@param volume number
---@param deltaTime number
function CSoundPatch:ChangeVolume(volume,deltaTime) end

-- Fades out the volume of the sound from the current volume to 0 in the given amount of seconds.
---@param seconds number
function CSoundPatch:FadeOut(seconds) end

-- Returns the DSP ( Digital Signal Processor ) effect for the sound.
function CSoundPatch:GetDSP() end

-- Returns the current pitch.
function CSoundPatch:GetPitch() end

-- Returns the current sound level.
function CSoundPatch:GetSoundLevel() end

-- Returns the current volume.
function CSoundPatch:GetVolume() end

-- Returns whenever the sound is being played.
function CSoundPatch:IsPlaying() end

-- Starts to play the sound. This will reset the sound's volume and pitch to their default values. See CSoundPatch:PlayEx
function CSoundPatch:Play() end

-- Same as CSoundPatch:Play but with 2 extra arguments allowing to set volume and pitch directly.
---@param volume number
---@param pitch number
function CSoundPatch:PlayEx(volume,pitch) end

-- Sets the DSP (Digital Signal Processor) effect for the sound. Similar to Player:SetDSP but for individual sounds.
---@param dsp number
function CSoundPatch:SetDSP(dsp) end

-- Sets the sound level in decibel.
---@param level number
function CSoundPatch:SetSoundLevel(level) end

-- Stops the sound from being played.This will not work if the entity attached to this sound patch (specified by Global.CreateSound) is invalid.
function CSoundPatch:Stop() end



---@class CTakeDamageInfo
CTakeDamageInfo = CTakeDamageInfo

-- Increases the damage by damageIncrease.
---@param damageIncrease number
function CTakeDamageInfo:AddDamage(damageIncrease) end

-- Returns the ammo type used by the weapon that inflicted the damage.
function CTakeDamageInfo:GetAmmoType() end

-- Returns the attacker ( character who originated the attack ), for example a player or an NPC that shot the weapon.
function CTakeDamageInfo:GetAttacker() end

-- Returns the initial unmodified by skill level ( game.GetSkillLevel ) damage.
function CTakeDamageInfo:GetBaseDamage() end

-- Returns the total damage.
function CTakeDamageInfo:GetDamage() end

-- Gets the current bonus damage.
function CTakeDamageInfo:GetDamageBonus() end

-- Gets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
function CTakeDamageInfo:GetDamageCustom() end

-- Returns a vector representing the damage force.Can be set with CTakeDamageInfo:SetDamageForce.
function CTakeDamageInfo:GetDamageForce() end

-- Returns the position where the damage was or is going to be applied to.Can be set using CTakeDamageInfo:SetDamagePosition.
function CTakeDamageInfo:GetDamagePosition() end

-- Returns a bitflag which indicates the damage type(s) of the damage.Consider using CTakeDamageInfo:IsDamageType instead. Value returned by this function can contain multiple damage types.
function CTakeDamageInfo:GetDamageType() end

-- Returns the inflictor of the damage. This is not necessarily a weapon.For hitscan weapons this is the weapon.For projectile weapons this is the projectile.For a more reliable method of getting the weapon that damaged an entity, use CTakeDamageInfo:GetAttacker with Player:GetActiveWeapon.
function CTakeDamageInfo:GetInflictor() end

-- Returns the maximum damage. See CTakeDamageInfo:SetMaxDamage
function CTakeDamageInfo:GetMaxDamage() end

-- Returns the initial, unmodified position where the damage occured.
function CTakeDamageInfo:GetReportedPosition() end

-- Returns true if the damage was caused by a bullet.
function CTakeDamageInfo:IsBulletDamage() end

-- Returns whenever the damageinfo contains the damage type specified.
---@param dmgType number
function CTakeDamageInfo:IsDamageType(dmgType) end

-- Returns whenever the damageinfo contains explosion damage.
function CTakeDamageInfo:IsExplosionDamage() end

-- Returns whenever the damageinfo contains fall damage.
function CTakeDamageInfo:IsFallDamage() end

-- Scales the damage by the given value.
---@param scale number
function CTakeDamageInfo:ScaleDamage(scale) end

-- Changes the ammo type used by the weapon that inflicted the damage.
---@param ammoType number
function CTakeDamageInfo:SetAmmoType(ammoType) end

-- Sets the attacker ( character who originated the attack ) of the damage, for example a player or an NPC.
---@param ent Entity
function CTakeDamageInfo:SetAttacker(ent) end

-- Sets the initial unmodified by skill level ( game.GetSkillLevel ) damage. This function will not update or touch CTakeDamageInfo:GetDamage.
---@param  number
function CTakeDamageInfo:SetBaseDamage() end

-- Sets the amount of damage.
---@param damage number
function CTakeDamageInfo:SetDamage(damage) end

-- Sets the bonus damage. Bonus damage isn't automatically applied, so this will have no outer effect by default.
---@param damage number
function CTakeDamageInfo:SetDamageBonus(damage) end

-- Sets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
---@param DamageType number
function CTakeDamageInfo:SetDamageCustom(DamageType) end

-- Sets the directional force of the damage.This function seems to have no effect on player knockback. To disable knockback entirely, see [EFL_NO_DAMAGE_FORCES](https://wiki.facepunch.com/gmod/Enums/EFL#EFL_NO_DAMAGE_FORCES) or use workaround example below.
---@param force Vector
function CTakeDamageInfo:SetDamageForce(force) end

-- Sets the position of where the damage gets applied to.
---@param pos Vector
function CTakeDamageInfo:SetDamagePosition(pos) end

-- Sets the damage type.
---@param type number
function CTakeDamageInfo:SetDamageType(type) end

-- Sets the inflictor of the damage for example a weapon.For hitscan/bullet weapons this should the weapon.For projectile ( rockets, etc ) weapons this should be the projectile.
---@param inflictor Entity
function CTakeDamageInfo:SetInflictor(inflictor) end

-- Sets the maximum damage this damage event can cause.
---@param maxDamage number
function CTakeDamageInfo:SetMaxDamage(maxDamage) end

-- Sets the origin of the damage.
---@param pos Vector
function CTakeDamageInfo:SetReportedPosition(pos) end

-- Subtracts the specified amount from the damage.
---@param damage number
function CTakeDamageInfo:SubtractDamage(damage) end



---@class CUserCmd
CUserCmd = CUserCmd

-- Adds a single key to the active buttons bitflag. See also CUserCmd:SetButtons.
---@param key number
function CUserCmd:AddKey(key) end

-- Removes all keys from the command.If you are looking to affect player movement, you may need to use CUserCmd:ClearMovement instead of clearing the buttons.
function CUserCmd:ClearButtons() end

-- Clears the movement from the command.See also CUserCmd:SetForwardMove, CUserCmd:SetSideMove and  CUserCmd:SetUpMove.
function CUserCmd:ClearMovement() end

-- Returns an increasing number representing the index of the user cmd.The value returned is occasionally 0 inside GM:CreateMove and GM:StartCommand. It is advised to check for a non-zero value if you wish to get the correct number.
function CUserCmd:CommandNumber() end

-- Returns a bitflag indicating which buttons are pressed.
function CUserCmd:GetButtons() end

-- The speed the client wishes to move forward with, negative if the clients wants to move backwards.
function CUserCmd:GetForwardMove() end

-- Gets the current impulse from the client, usually 0. [See impulses list](https://developer.valvesoftware.com/wiki/Impulse) and some CUserCmd:SetImpulse.
function CUserCmd:GetImpulse() end

-- Returns the scroll delta as whole number.
function CUserCmd:GetMouseWheel() end

-- Returns the delta of the angular horizontal mouse movement of the player.
function CUserCmd:GetMouseX() end

-- Returns the delta of the angular vertical mouse movement of the player.
function CUserCmd:GetMouseY() end

-- The speed the client wishes to move sideways with, positive if it wants to move right, negative if it wants to move left.
function CUserCmd:GetSideMove() end

-- The speed the client wishes to move up with, negative if the clients wants to move down.
function CUserCmd:GetUpMove() end

-- Gets the direction the player is looking in.
function CUserCmd:GetViewAngles() end

-- When players are not sending usercommands to the server (often due to lag), their last usercommand will be executed multiple times as a backup. This function returns true if that is happening.This will never return true clientside.
function CUserCmd:IsForced() end

-- Returns true if the specified button(s) is pressed.
---@param key number
function CUserCmd:KeyDown(key) end

-- Removes a key bit from the current key bitflag.For movement you will want to use CUserCmd:SetForwardMove, CUserCmd:SetUpMove and CUserCmd:SetSideMove.
---@param button number
function CUserCmd:RemoveKey(button) end

-- Forces the associated player to select a weapon. This is used internally in the default HL2 weapon selection HUD.This may not work immediately if the current command is in prediction. Use input.SelectWeapon to switch the weapon from the client when the next available command can do so.This is the ideal function to use to create a custom weapon selection HUD, as it allows prediction to run properly for WEAPON:Deploy and GM:PlayerSwitchWeapon
---@param weapon Weapon
function CUserCmd:SelectWeapon(weapon) end

-- Sets the buttons as a bitflag. See also CUserCmd:GetButtons.If you are looking to affect player movement, you may need to use CUserCmd:SetForwardMove instead of setting the keys.
---@param buttons number
function CUserCmd:SetButtons(buttons) end

-- Sets speed the client wishes to move forward with, negative if the clients wants to move backwards.See also CUserCmd:ClearMovement, CUserCmd:SetSideMove and CUserCmd:SetUpMove.
---@param speed number
function CUserCmd:SetForwardMove(speed) end

-- Sets the impulse command to be sent to the server.Here are a few examples of impulse numbers:- `100` toggles their flashlight- `101` gives the player all Half-Life 2 weapons with `sv_cheats` set to `1`- `200` toggles holstering / restoring the current weaponWhen holstered, the `EF_NODRAW` flag is set on the active weapon.- `154` toggles noclip[See full list](https://developer.valvesoftware.com/wiki/Impulse)
---@param impulse number
function CUserCmd:SetImpulse(impulse) end

-- Sets the scroll delta.
---@param speed number
function CUserCmd:SetMouseWheel(speed) end

-- Sets the delta of the angular horizontal mouse movement of the player.See also CUserCmd:SetMouseY.
---@param speed number
function CUserCmd:SetMouseX(speed) end

-- Sets the delta of the angular vertical mouse movement of the player.See also CUserCmd:SetMouseX.
---@param speed number
function CUserCmd:SetMouseY(speed) end

-- Sets speed the client wishes to move sidewards with, positive to move right, negative to move left.See also CUserCmd:SetForwardMove and  CUserCmd:SetUpMove.
---@param speed number
function CUserCmd:SetSideMove(speed) end

-- Sets speed the client wishes to move upwards with, negative to move down.See also CUserCmd:SetSideMove and  CUserCmd:SetForwardMove.This function does **not** move the client up/down ladders. To force ladder movement, consider CUserCMD:SetButtons and use IN_FORWARD from Enums/IN.
---@param speed number
function CUserCmd:SetUpMove(speed) end

-- Sets the direction the client wants to move in.For human players, the pitch (vertical) angle should be clamped to +/- 89° to prevent the player's view from glitching.For fake clients (those created with player.CreateNextBot), this functionally dictates the 'move angles' of the bot. This typically functions separately from the colloquial view angles. This can be utilized by CUserCmd:SetForwardMove and its related functions.
---@param viewAngle Angle
function CUserCmd:SetViewAngles(viewAngle) end

-- Returns tick count since joining the server.This will always return 0 for bots.Returns 0 clientside during prediction calls. If you are trying to use CUserCmd:Set*() on the client in a movement or command hook, keep doing so till TickCount returns a non-zero number to maintain prediction.
function CUserCmd:TickCount() end



---@class Entity
Entity = Entity

-- Activates the entity. This needs to be used on some entities (like constraints) after being spawned.For some entity types when this function is used after Entity:SetModelScale, the physics object will be recreated with the new scale. [Source-sdk-2013](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/baseanimating.cpp#L321-L327).Calling this method after Entity:SetModelScale will recreate a new scaled `SOLID_VPHYSICS` PhysObj on scripted entities. This can be a problem if you made a properly scaled PhysObj of another kind (using Entity:PhysicsInitSphere for instance) or if you edited the PhysObj's properties. This is especially the behavior of the Sandbox spawn menu.This crashes the game with scaled vehicles.
function Entity:Activate() end

-- Add a callback function to a specific event. This is used instead of hooks to avoid calling empty functions unnecessarily.This also allows you to use certain hooks in engine entities (non-scripted entities).This method does not check if the function has already been added to this object before, so if you add the same callback twice, it will be run twice! Make sure to add your callback only once.
---@param hook string
---@param func function
function Entity:AddCallback(hook,func) end

-- Applies an engine effect to an entity.See also Entity:IsEffectActive and  Entity:RemoveEffects.
---@param effect number
function Entity:AddEffects(effect) end

-- Adds engine flags.
---@param flag number
function Entity:AddEFlags(flag) end

-- Adds flags to the entity.
---@param flag number
function Entity:AddFlags(flag) end

-- Adds a gesture animation to the entity and plays it.See Entity:AddGestureSequence and Entity:AddLayeredSequence for functions that takes sequences instead of Enums/ACT.This function only works on BaseAnimatingOverlay entites!
---@param activity number
---@param autokill boolean
function Entity:AddGesture(activity,autokill) end

-- Adds a gesture animation to the entity and plays it.See Entity:AddGesture for a function that takes Enums/ACT.See also Entity:AddLayeredSequence.This function only works on BaseAnimatingOverlay entites!
---@param sequence number
---@param autokill boolean
function Entity:AddGestureSequence(sequence,autokill) end

-- Adds a gesture animation to the entity and plays it.See Entity:AddGestureSequence for a function that doesn't take priority.See Entity:AddGesture for a function that takes Enums/ACT.This function only works on BaseAnimatingOverlay entites!
---@param sequence number
---@param priority number
function Entity:AddLayeredSequence(sequence,priority) end

-- Adds solid flag(s) to the entity.
---@param flags number
function Entity:AddSolidFlags(flags) end

-- Adds a PhysObject to the entity's motion controller so that ENTITY:PhysicsSimulate will be called for given PhysObject as well.You must first create a motion controller with Entity:StartMotionController.You can remove added PhysObjects by using Entity:RemoveFromMotionController.Only works on a scripted Entity of anim type
---@param physObj PhysObj
function Entity:AddToMotionController(physObj) end

-- Returns an angle based on the ones inputted that you can use to align an object.This function doesn't change the angle of the entity on its own (see example).
---@param from Angle
---@param to Angle
function Entity:AlignAngles(from,to) end

-- Spawns a clientside ragdoll for the entity, positioning it in place of the original entity, and makes the entity invisible. It doesn't preserve flex values (face posing) as CSRagdolls don't support flex.It does not work on players. Use Player:CreateRagdoll instead.The original entity is not removed, and neither are any ragdolls previously generated with this function.To make the entity re-appear, run Entity:SetNoDraw( false )
function Entity:BecomeRagdollOnClient() end

-- Returns true if the entity is being looked at by the local player and is within 256 units of distance.This function is only available in entities that are based off of sandbox's base_gmodentity.
function Entity:BeingLookedAtByLocalPlayer() end

--  Dispatches blocked events to this entity's blocked handler. This function is only useful when interacting with entities like func_movelinear.
---@param entity Entity
function Entity:Blocked(entity) end

-- Returns a centered vector of this entity, NPCs use this internally to aim at their targets.This only works on players and NPCs.
---@param origin Vector
---@param noisy boolean
function Entity:BodyTarget(origin,noisy) end

-- Returns whether the entity's bone has the flag or not.
---@param boneID number
---@param flag number
function Entity:BoneHasFlag(boneID,flag) end

-- Returns the length between given bone's position and the position of given bone's parent.
---@param boneID number
function Entity:BoneLength(boneID) end

-- Returns the distance between the center of the bounding box and the furthest bounding box corner.
function Entity:BoundingRadius() end

-- Calls all NetworkVarNotify functions with the given new value, but doesn't change the real value.
---@param Type string
---@param index number
---@param new value any
function Entity:CallDTVarProxies(Type,index,new value) end

-- Causes a specified function to be run if the entity is removed by any means. This can later be undone by Entity:RemoveCallOnRemove if you need it to not run.This hook is called during clientside full updates. See ENTITY:OnRemove#clientsidebehaviourremarks for more information.Using players with this function will provide a gimped entity to the callback.
---@param identifier string
---@param removeFunc function
---@param argn... vararg
function Entity:CallOnRemove(identifier,removeFunc,argn...) end

-- Clears all registered events for map i/o outputs of the Entity.
function Entity:ClearAllOutputs() end

-- Resets all pose parameters such as aim_yaw, aim_pitch and rotation.
function Entity:ClearPoseParameters() end

-- Declares that the collision rules of the entity have changed, and subsequent calls for GM:ShouldCollide with this entity may return a different value than they did previously.This function must **not** be called inside of GM:ShouldCollide. Instead, it must be called in advance when the condition is known to change.Failure to use this function correctly will result in a crash of the physics engine.
function Entity:CollisionRulesChanged() end

-- Creates bone followers based on the current entity model.Bone followers are physics objects that follow the visual mesh. This is what is used by `prop_dynamic` for things like big combine doors for vehicles with multiple physics objects which follow the visual mesh of the door when it animates.You must call Entity:UpdateBoneFollowers every tick for bone followers to update their positions.This function only works on `anim` type entities.
function Entity:CreateBoneFollowers() end

-- Returns whether the entity was created by map or not.
function Entity:CreatedByMap() end

-- Creates a clientside particle system attached to the entity. See also Global.CreateParticleSystemThe particle effect must be precached with Global.PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
---@param particle string
---@param attachment number
---@param options table
function Entity:CreateParticleEffect(particle,attachment,options) end

-- Draws the shadow of an entity.
function Entity:CreateShadow() end

-- Whenever the entity is removed, entityToRemove will be removed also.
---@param entityToRemove Entity
function Entity:DeleteOnRemove(entityToRemove) end

-- Destroys bone followers created by Entity:CreateBoneFollowers.This function only works on `anim` type entities.
function Entity:DestroyBoneFollowers() end

-- Removes the shadow for the entity.The shadow will be recreated as soon as the entity wakes.Doesn't affect shadows from flashlight/lamps/env_projectedtexture.
function Entity:DestroyShadow() end

-- Disables an active matrix.
---@param matrixType string
function Entity:DisableMatrix(matrixType) end

-- Performs a trace attack towards the entity this function is called on. Visually identical to Entity:TakeDamageInfo.Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
---@param damageInfo CTakeDamageInfo
---@param traceRes table
---@param dir Vector
function Entity:DispatchTraceAttack(damageInfo,traceRes,dir) end

-- This removes the argument entity from an ent's list of entities to 'delete on remove'Also see Entity:DeleteOnRemove
---@param entityToUnremove Entity
function Entity:DontDeleteOnRemove(entityToUnremove) end

-- Draws the entity or model.If called inside ENTITY:Draw or ENTITY:DrawTranslucent, it only draws the entity's model itself.If called outside of those hooks, it will call both of said hooks depending on Entity:GetRenderGroup, drawing the entire entity again.When drawing an entity more than once per frame in different positions, you should call Entity:SetupBones before each draw; Otherwise, the entity will retain its first drawn position.Calling this on entities with Enums/EF and Enums/EF applied causes a crash.Using this with a map model (game.GetWorld():Entity:GetModel()) crashes the game.
---@param flags number
function Entity:DrawModel(flags) end

-- Sets whether an entity's shadow should be drawn.
---@param shouldDraw boolean
function Entity:DrawShadow(shouldDraw) end

-- Move an entity down until it collides with something.The entity needs to already have something below it within 256 units.
function Entity:DropToFloor() end

-- You should use Entity:NetworkVar insteadSets up a self.dt.NAME alias for a Data Table variable.
---@param Type string
---@param ID number
---@param Name string
function Entity:DTVar(Type,ID,Name) end

-- Plays a sound on an entity. If run clientside, the sound will only be heard locally.If used on a player or NPC character with the mouth rigged, the character will "lip-sync". This does not work with all sound files.When using this function with weapons, use the Weapon itself as the entity, not its owner!This does not respond to Global.SuppressHostEvents.
---@param soundName string
---@param soundLevel number
---@param pitchPercent number
---@param volume number
---@param channel number
---@param soundFlags number
---@param dsp number
function Entity:EmitSound(soundName,soundLevel,pitchPercent,volume,channel,soundFlags,dsp) end

-- Toggles the constraints of this ragdoll entity on and off.
---@param toggleConstraints boolean
function Entity:EnableConstraints(toggleConstraints) end

-- Flags an entity as using custom lua defined collisions. Fixes entities having spongy player collisions or not hitting traces, such as after Entity:PhysicsFromMeshInternally identical to `Entity:AddSolidFlags( bit.bor( FSOLID_CUSTOMRAYTEST, FSOLID_CUSTOMBOXTEST ) )`Do not confuse this function with Entity:SetCustomCollisionCheck, they are not the same.
---@param useCustom boolean
function Entity:EnableCustomCollisions(useCustom) end

-- Can be used to apply a custom VMatrix to the entity, mostly used for scaling the model by a Vector.To disable it, use Entity:DisableMatrix.If your old scales are wrong due to a recent update, use Entity:SetLegacyTransform as a quick fix.The matrix can also be modified to apply a custom rotation and offset via the VMatrix:SetAngles and VMatrix:SetTranslation functions.This does not scale procedural bones.This disables inverse kinematics of an entity.
---@param matrixType string
---@param matrix VMatrix
function Entity:EnableMatrix(matrixType,matrix) end

-- Gets the unique entity index of an entity.Entity indices are marked as unused after deletion, and can be reused by newly-created entities
function Entity:EntIndex() end

-- Extinguishes the entity if it is on fire.Has no effect if called inside GM:EntityTakeDamage (and the attacker is the flame that's hurting the entity)See also Entity:Ignite.
function Entity:Extinguish() end

-- Returns the direction a player, npc or ragdoll is looking as a world-oriented angle.This can return an incorrect value in vehicles (like pods, buggy, ...). **This bug has been fixed in the past but was causing many addons being broken, so the fix has been removed but applied to Player:GetAimVector only**.This may return local angles in jeeps when used with Player:EnterVehicle. **A workaround is available in the second example.**
function Entity:EyeAngles() end

-- Returns the position of an Player/NPC's view.
function Entity:EyePos() end

-- Searches for bodygroup with given name.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param name string
function Entity:FindBodygroupByName(name) end

-- Returns a transition from the given start and end sequence.This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures.
---@param currentSequence number
---@param goalSequence number
function Entity:FindTransitionSequence(currentSequence,goalSequence) end

-- Fires an entity's input, conforming to the map IO event queue system. You can find inputs for most entities on the [Valve Developer Wiki](https://developer.valvesoftware.com/wiki/Output)See also Entity:Input for a function that bypasses the event queue and GM:AcceptInput.
---@param input string
---@param param string
---@param delay number
---@param activator Entity
---@param caller Entity
function Entity:Fire(input,param,delay,activator,caller) end

-- Fires a bullet.When used in a  hook such as WEAPON:Think or WEAPON:PrimaryAttack, it will use Player:LagCompensation internally.Lag compensation will not work if this function is called in a timer, regardless if the timer was made in a  hook.Due to how FireBullets is set up internally, bullet tracers will always originate from attachment 1.
---@param bulletInfo table
---@param suppressHostEvents boolean
function Entity:FireBullets(bulletInfo,suppressHostEvents) end

-- Makes an entity follow another entity's bone.Internally this function calls Entity:SetParent( parent, boneid ), Entity:AddEffects( EF_FOLLOWBONE) and sets an internal flag to always rebuild all bones.If the entity vibrates or stops following the parent, you probably need to run Entity:SetPredictable( true ) clientside.This function will not work if the target bone's parent bone is invalid or if the bone is not used by VERTEX LOD0
---@param parent Entity
---@param boneid number
function Entity:FollowBone(parent,boneid) end

-- Forces the Entity to be dropped, when it is being held by a player's gravitygun or physgun.
function Entity:ForcePlayerDrop() end

-- Advances the cycle of an animated entity.Animations that loop will automatically reset the cycle so you don't have to - ones that do not will stop animating once you reach the end of their sequence.Do not call this function multiple times a frame, as it can cause unexpected results, such as animations playing at increased rate, etc.NextBot:BodyMoveXY calls this internally, so do not call this function before or after NextBot:BodyMoveXY.
function Entity:FrameAdvance() end

-- Returns the entity's velocity.Actually binds to CBaseEntity::GetLocalVelocity() which retrieves the velocity of the entity due to its movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision.
function Entity:GetAbsVelocity() end

-- Gets the angles of given entity.This returns incorrect results for the local player clientside.This will return the local player's Global.EyeAngles in Category:3D_Rendering_Hooks.This will return Global.Angle(0,0,0) in Category:3D_Rendering_Hooks while paused in single-player.
function Entity:GetAngles() end

-- Returns the amount of animations (not to be confused with sequences) the entity's model has. A sequence can consist of multiple animations.See also Entity:GetAnimInfo
function Entity:GetAnimCount() end

-- Returns a table containing the number of frames, flags, name, and FPS of an entity's animation ID.Animation ID is not the same as sequence ID. See Entity:GetAnimCount
---@param animIndex number
function Entity:GetAnimInfo(animIndex) end

-- Returns the last time the entity had an animation update. Returns 0 if the entity doesn't animate.
function Entity:GetAnimTime() end

-- Returns the amount of time since last animation.Works only on `CBaseAnimating` entities.
function Entity:GetAnimTimeInterval() end

-- Gets the orientation and position of the attachment by its ID, returns nothing if the attachment does not exist.The update rate of this function is limited by the setting of ENT.AutomaticFrameAdvance for Scripted Entities!This will return improper values for viewmodels if used in GM:CalcView.
---@param attachmentId number
function Entity:GetAttachment(attachmentId) end

-- Returns a table containing all attachments of the given entity's model.Returns an empty table or **nil** in case its model has no attachments.This can have inconsistent results in single-player.
function Entity:GetAttachments() end

-- Returns the entity's base velocity which is their velocity due to forces applied by other entities. This includes entity-on-entity collision or riding a treadmill.
function Entity:GetBaseVelocity() end

-- Returns the blood color of this entity. This can be set with Entity:SetBloodColor.
function Entity:GetBloodColor() end

-- Gets the exact value for specific bodygroup of given entity.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param id number
function Entity:GetBodygroup(id) end

-- Returns the count of possible values for this bodygroup.This is **not** the maximum value, since the bodygroups start with 0, not 1.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param bodygroup number
function Entity:GetBodygroupCount(bodygroup) end

-- Gets the name of specific bodygroup for given entity.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param id number
function Entity:GetBodygroupName(id) end

-- Returns a list of all body groups of the entity.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return body groups form view model.
function Entity:GetBodyGroups() end

-- Returns the contents of the specified bone.
---@param bone number
function Entity:GetBoneContents(bone) end

-- Returns the value of the bone controller with the specified ID.This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
---@param boneID number
function Entity:GetBoneController(boneID) end

-- Returns the amount of bones in the entity.Will return -1 for Global.ClientsideModel or undrawn entities until Entity:SetupBones is called on the entity.
function Entity:GetBoneCount() end

-- Returns the transformation matrix of a given bone on the entity's model. The matrix contains the transformation used to position the bone in the world. It is not relative to the parent bone.This is equivalent to constructing a VMatrix using Entity:GetBonePosition.This can return the server's matrix during server lag.This can return garbage serverside or a 0,0,0 fourth column (represents position) for v49 models.
---@param boneID number
function Entity:GetBoneMatrix(boneID) end

-- Returns name of given bone id.
---@param index number
function Entity:GetBoneName(index) end

-- Returns parent bone of given bone.Will return -1 for Global.ClientsideModel until Entity:SetupBones is called on the entity.
---@param bone number
function Entity:GetBoneParent(bone) end

-- Returns the position and angle of the given attachment, relative to the world.This function can return entity's `GetPos()` instead if the entity doesn't have it's bone cache set up.To ensure the bone position is correct use this:```lualocal pos = ent:GetBonePosition(0)if pos == ent:GetPos() thenpos = ent:GetBoneMatrix(0):GetTranslation()end```This function returns the bone position from the last tick, so if your framerate is higher than the server's tickrate it may appear to lag behind if used on a fast moving entity. You can fix this by using the bone's matrix instead:```lualocal matrix = entity:GetBoneMatrix(0)local pos = matrix:GetTranslation()local ang = matrix:GetAngles()```This can return the server's position during server lag.This can return garbage serverside or Global.Vector(0,0,0) for v49 models.This can return garbage if a trace passed through the target bone during bone matrix access.
---@param boneIndex number
function Entity:GetBonePosition(boneIndex) end

-- Returns the surface property of the specified bone.
---@param bone number
function Entity:GetBoneSurfaceProp(bone) end

-- Returns info about given plane of non-nodraw brush model surfaces of the entity's model. Works on worldspawn as well.This only works on entities with brush models.
---@param id number
function Entity:GetBrushPlane(id) end

-- Returns the amount of planes of non-nodraw brush model surfaces of the entity's model.
function Entity:GetBrushPlaneCount() end

-- Returns a table of brushes surfaces for brush model entities.
function Entity:GetBrushSurfaces() end

-- Returns the specified hook callbacks for this entity added with Entity:AddCallbackThe callbacks can then be removed with Entity:RemoveCallback.
---@param hook string
function Entity:GetCallbacks(hook) end

-- Returns ids of child bones of given bone.
---@param boneid number
function Entity:GetChildBones(boneid) end

-- Gets the children of the entity - that is, every entity whose move parent is this entity.This function returns Entity:SetMoveParent children, **NOT** Entity:SetParent!Entity:SetParent however also calls Entity:SetMoveParent.This means that some entities in the returned list might have a NULL Entity:GetParent.This also means that using this function on players will return their weapons on the client but not the server.
function Entity:GetChildren() end

-- Returns the classname of a entity. This is often the name of the Lua file or folder containing the files for the entity
function Entity:GetClass() end

-- Returns an entity's collision bounding box. In most cases, this will return the same bounding box as Entity:GetModelBounds unless the entity does not have a physics mesh or it has a PhysObj different from the default.This can be out-of-sync between the client and server for weapons.
function Entity:GetCollisionBounds() end

-- Returns the entity's collision group
function Entity:GetCollisionGroup() end

-- Returns the color the entity is set to.The returned color will not have the color metatable.
function Entity:GetColor() end

-- Returns the color the entity is set to.This functions will return Colors set with Entity:GetColor
function Entity:GetColor4Part() end

-- Returns the two entities involved in a constraint ent, or nil if the entity is not a constraint.
function Entity:GetConstrainedEntities() end

-- Returns the two entities physobjects involved in a constraint ent, or no value if the entity is not a constraint.
function Entity:GetConstrainedPhysObjects() end

-- Returns entity's creation ID. Unlike Entity:EntIndex or  Entity:MapCreationID, it will always increase and old values won't be reused.
function Entity:GetCreationID() end

-- Returns the time the entity was created on, relative to Global.CurTime.
function Entity:GetCreationTime() end

-- Gets the creator of the SENT.
function Entity:GetCreator() end

-- Returns whether this entity uses custom collision check set by Entity:SetCustomCollisionCheck.
function Entity:GetCustomCollisionCheck() end

-- Returns the frame of the currently played sequence. This will be a number between 0 and 1 as a representation of sequence progress.
function Entity:GetCycle() end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get an angle stored in the datatable of the entity.
---@param key number
function Entity:GetDTAngle(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get a boolean stored in the datatable of the entity.
---@param key number
function Entity:GetDTBool(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Returns an entity stored in the datatable of the entity.
---@param key number
function Entity:GetDTEntity(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get a float stored in the datatable of the entity.
---@param key number
function Entity:GetDTFloat(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get an integer stored in the datatable of the entity.
---@param key number
function Entity:GetDTInt(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get a string stored in the datatable of the entity.
---@param key number
function Entity:GetDTString(key) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Get a vector stored in the datatable of the entity.
---@param key number
function Entity:GetDTVector(key) end

-- Returns internal data about editable Entity:NetworkVars.This is used internally by DEntityProperties and Editable Entities system.This function will only work on entities which had Entity:InstallDataTable called on them, which is done automatically for players and all Scripted Entities
function Entity:GetEditingData() end

-- Returns a bit flag of all engine effect flags of the entity.
function Entity:GetEffects() end

-- Returns a bit flag of all engine flags of the entity.
function Entity:GetEFlags() end

-- Returns the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
function Entity:GetElasticity() end

-- Returns all flags of given entity.
function Entity:GetFlags() end

-- Returns acceptable value range for the flex.
---@param flex number
function Entity:GetFlexBounds(flex) end

-- Returns the ID of the flex based on given name.This function will search by beginning of a name.
---@param name string
function Entity:GetFlexIDByName(name) end

-- Returns flex name.
---@param id number
function Entity:GetFlexName(id) end

-- Returns the number of flexes this entity has.
function Entity:GetFlexNum() end

-- Returns the flex scale of the entity.
function Entity:GetFlexScale() end

-- Returns current weight ( value ) of the flex.
---@param flex number
function Entity:GetFlexWeight(flex) end

-- Returns the forward vector of the entity, as a normalized direction vector
function Entity:GetForward() end

-- Returns how much friction an entity has. Entities default to 1 (100%) and can be higher or even negative.
function Entity:GetFriction() end

-- Gets the gravity multiplier of the entity.
function Entity:GetGravity() end

-- Returns the object the entity is standing on.
function Entity:GetGroundEntity() end

-- Returns the entity's ground speed velocity, which is based on the entity's walk/run speed and/or the ground speed of their sequence ( Entity:GetSequenceGroundSpeed ). Will return an empty Vector if the entity isn't moving on the ground.
function Entity:GetGroundSpeedVelocity() end

-- Gets the bone the hit box is attached to.
---@param hitbox number
---@param hboxset number
function Entity:GetHitBoxBone(hitbox,hboxset) end

-- Gets the bounds (min and max corners) of a hit box.
---@param hitbox number
---@param set number
function Entity:GetHitBoxBounds(hitbox,set) end

-- Gets how many hit boxes are in a given hit box group.
---@param group number
function Entity:GetHitBoxCount(group) end

-- You should use Entity:GetHitboxSetCount instead.Returns the number of hit box sets that an entity has. Functionally identical to Entity:GetHitboxSetCount
function Entity:GetHitBoxGroupCount() end

-- Gets the hit group of a given hitbox in a given hitbox set.
---@param hitbox number
---@param hitboxset number
function Entity:GetHitBoxHitGroup(hitbox,hitboxset) end

-- Returns entity's current hit box set
function Entity:GetHitboxSet() end

-- Returns the amount of hitbox sets in the entity.
function Entity:GetHitboxSetCount() end

-- An interface for accessing internal key values on entities.See Entity:GetSaveTable for a more detailed explanation. See Entity:SetSaveValue for the opposite of this function.
---@param variableName string
function Entity:GetInternalVariable(variableName) end

-- Returns a table containing all key values the entity has.Single key values can usually be retrieved with Entity:GetInternalVariable.This only includes engine defined key values. For custom key values, use GM:EntityKeyValue or ENTITY:KeyValue to capture and store them.Here's a list of keyvalues that will not appear in this list, as they are not stored/defined as actual keyvalues internally:* rendercolor - Entity:GetColor (Only RGB)* rendercolor32 - Entity:GetColor (RGBA)* renderamt - Entity:GetColor (Alpha)* disableshadows - EF_NOSHADOW* mins - Entity:GetCollisionBounds* maxs - Entity:GetCollisionBounds* disablereceiveshadows - EF_NORECEIVESHADOW* nodamageforces - EFL_NO_DAMAGE_FORCES* angle - Entity:GetAngles* angles - Entity:GetAngles* origin - Entity:GetPos* targetname - Entity:GetName
function Entity:GetKeyValues() end

-- Returns the animation cycle/frame for given layer.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:GetLayerCycle(layerID) end

-- Returns the duration of given layer.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:GetLayerDuration(layerID) end

-- Returns the layer playback rate. See also Entity:GetLayerDuration.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:GetLayerPlaybackRate(layerID) end

-- Returns the sequence id of given layer.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:GetLayerSequence(layerID) end

-- Returns the current weight of the layer. See Entity:SetLayerWeight for more information.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:GetLayerWeight(layerID) end

-- Returns the entity that is being used as the light origin position for this entity.
function Entity:GetLightingOriginEntity() end

-- Returns the rotation of the entity relative to its parent entity.
function Entity:GetLocalAngles() end

-- Returns the non-VPhysics angular velocity of the entity relative to its parent entity.
function Entity:GetLocalAngularVelocity() end

-- Returns entity's position relative to it's parent.
function Entity:GetLocalPos() end

-- Gets the entity's angle manipulation of the given bone. This is relative to the default angle, so the angle is zero when unmodified.
---@param boneID number
function Entity:GetManipulateBoneAngles(boneID) end

-- Returns the jiggle amount of the entity's bone.See Entity:ManipulateBoneJiggle for more info.
---@param boneID number
function Entity:GetManipulateBoneJiggle(boneID) end

-- Gets the entity's position manipulation of the given bone. This is relative to the default position, so it is zero when unmodified.
---@param boneId number
function Entity:GetManipulateBonePosition(boneId) end

-- Gets the entity's scale manipulation of the given bone. Normal scale is Vector( 1, 1, 1 )
---@param boneID number
function Entity:GetManipulateBoneScale(boneID) end

-- Returns the material override for this entity.Returns an empty string if no material override exists. Use Entity:GetMaterials to list it's default materials.The server's value takes priority on the client.
function Entity:GetMaterial() end

-- Returns all materials of the entity's model.This function is unaffected by Entity:SetSubMaterial as it returns the original materials.The table returned by this function will not contain materials if they are missing from the disk/repository. This means that if you are attempting to find the ID of a material to replace with Entity:SetSubMaterial and there are missing materials on the model, all subsequent materials will be offset in the table, meaning that the ID you are trying to get will be incorrect.
function Entity:GetMaterials() end

-- Returns the surface material of this entity.
function Entity:GetMaterialType() end

-- Returns the max health that the entity was given. It can be set via Entity:SetMaxHealth.
function Entity:GetMaxHealth() end

-- Gets the model of given entity.This does not necessarily return the model's path, as is the case for brush and virtual models. This is intentional behaviour, however, there is currently no way to retrieve the actual file path.
function Entity:GetModel() end

-- Returns the entity's model bounds, not scaled by Entity:SetModelScale.These bounds are affected by all the animations the model has at compile time, if they go outside of the models' render bounds at any point.See Entity:GetModelRenderBounds for just the render bounds of the model.This is different than the collision bounds/hull, which are set via Entity:SetCollisionBounds.
function Entity:GetModelBounds() end

-- Returns the contents of the entity's current model.
function Entity:GetModelContents() end

-- Gets the physics bone count of the entity's model. This is only applicable to `anim` type Scripted Entities with ragdoll models.
function Entity:GetModelPhysBoneCount() end

-- Gets the models radius.
function Entity:GetModelRadius() end

-- Returns the entity's model render bounds. Unlike Entity:GetModelBounds, bounds returning by this function will not be affected by animations (at compile time).
function Entity:GetModelRenderBounds() end

-- Gets the selected entity's model scale.
function Entity:GetModelScale() end

-- Returns the amount a momentary_rot_button entity is turned based on the given angle. 0 meaning completely turned closed, 1 meaning completely turned open.This only works on momentary_rot_button entities.
---@param turnAngle Angle
function Entity:GetMomentaryRotButtonPos(turnAngle) end

-- Returns the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
function Entity:GetMoveCollide() end

-- Returns the movement parent of this entity.See Entity:SetMoveParent for more info.
function Entity:GetMoveParent() end

-- Returns the entity's movetype
function Entity:GetMoveType() end

-- Returns the map/hammer targetname of this entity.
function Entity:GetName() end

-- Gets networked angles for entity.
function Entity:GetNetworkAngles() end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNetworked2Angle.You should be using Entity:GetNW2Angle instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Angle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNetworked2Bool.You should be using Entity:GetNW2Bool instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Bool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNetworked2Entity.You should be using Entity:GetNW2Entity instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Entity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworked2Float.You should be using Entity:GetNW2Float instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Float(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNetworked2Int.You should be using Entity:GetNW2Int instead.The integer has a 32 bit limit. Use Entity:SetNWInt and Entity:GetNWInt instead
---@param key string
---@param fallback any
function Entity:GetNetworked2Int(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNetworked2String.You should be using Entity:GetNW2String instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2String(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNetworked2Var.You should be using Entity:GetNW2Var instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Var(key,fallback) end

-- Returns callback function for given NWVar of this entity.
---@param key any
function Entity:GetNetworked2VarProxy(key) end

-- Returns all the networked2 variables in an entity.You should be using Entity:GetNW2VarTable instead.
function Entity:GetNetworked2VarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNetworked2Vector.You should be using Entity:GetNW2Vector instead.
---@param key string
---@param fallback any
function Entity:GetNetworked2Vector(key,fallback) end

-- You should use Entity:GetNWAngle instead.Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNetworkedAngle.
---@param key string
---@param fallback Angle
function Entity:GetNetworkedAngle(key,fallback) end

-- You should use Entity:GetNWBool instead.Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNetworkedBool.
---@param key string
---@param fallback boolean
function Entity:GetNetworkedBool(key,fallback) end

-- You should use Entity:GetNWEntity instead.Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedEntity.
---@param key string
---@param fallback Entity
function Entity:GetNetworkedEntity(key,fallback) end

-- You should use Entity:GetNWFloat instead.Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedFloat.Seems to be the same as Entity:GetNetworkedInt.
---@param key string
---@param fallback number
function Entity:GetNetworkedFloat(key,fallback) end

-- You should use Entity:GetNWInt instead.Retrieves a networked integer value at specified index on the entity that is set by Entity:SetNetworkedInt.
---@param key string
---@param fallback number
function Entity:GetNetworkedInt(key,fallback) end

-- You should use Entity:GetNWString instead.Retrieves a networked string value at specified index on the entity that is set by Entity:SetNetworkedString.
---@param key string
---@param fallback string
function Entity:GetNetworkedString(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNetworkedVar.
---@param key string
---@param fallback any
function Entity:GetNetworkedVar(key,fallback) end

-- This function was superseded by Entity:GetNetworked2VarProxy. This page still exists an archive in case anybody ever stumbles across old code and needs to know what it isReturns callback function for given NWVar of this entity.
---@param name string
function Entity:GetNetworkedVarProxy(name) end

-- You should be using Entity:GetNWVarTable instead.Returns all the networked variables in an entity.
function Entity:GetNetworkedVarTable() end

-- You should use Entity:GetNWVector instead.Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNetworkedVector.
---@param key string
---@param fallback Vector
function Entity:GetNetworkedVector(key,fallback) end

-- Gets networked origin for entity.
function Entity:GetNetworkOrigin() end

-- Returns all network vars created by Entity:NetworkVar and Entity:NetworkVarElement and their current values.This is used internally by the duplicator.For NWVars see Entity:GetNWVarTable.This function will only work on entities which had Entity:InstallDataTable called on them, which is done automatically for players and all Scripted Entities
function Entity:GetNetworkVars() end

-- Returns if the entity's rendering and transmitting has been disabled.This is equivalent to calling Entity:IsEffectActive( EF_NODRAW )
function Entity:GetNoDraw() end

-- Returns the body group count of the entity.If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
function Entity:GetNumBodyGroups() end

-- Returns the number of pose parameters this entity has.
function Entity:GetNumPoseParameters() end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNW2Angle.
---@param key string
---@param fallback any
function Entity:GetNW2Angle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNW2Bool.
---@param key string
---@param fallback any
function Entity:GetNW2Bool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNW2Entity.
---@param key string
---@param fallback any
function Entity:GetNW2Entity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNW2Float.
---@param key string
---@param fallback any
function Entity:GetNW2Float(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNW2Int.The integer has a 32 bit limit. Use Entity:SetNWInt and Entity:GetNWInt instead
---@param key string
---@param fallback any
function Entity:GetNW2Int(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNW2String.
---@param key string
---@param fallback any
function Entity:GetNW2String(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNW2Var.
---@param key string
---@param fallback any
function Entity:GetNW2Var(key,fallback) end

-- Returns callback function for given NWVar of this entity.Alias of Entity:GetNetworked2VarProxy
---@param key any
function Entity:GetNW2VarProxy(key) end

-- Returns all the NW2 variables in an entity.This function will return keys with empty tables if the NW2Var is nil.
function Entity:GetNW2VarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNW2Vector.
---@param key string
---@param fallback any
function Entity:GetNW2Vector(key,fallback) end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNWAngle.
---@param key string
---@param fallback any
function Entity:GetNWAngle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNWBool.
---@param key string
---@param fallback any
function Entity:GetNWBool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNWEntity.
---@param key string
---@param fallback any
function Entity:GetNWEntity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNWFloat.
---@param key string
---@param fallback any
function Entity:GetNWFloat(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNWInt.This function will not round decimal values as it actually networks a float internally.
---@param key string
---@param fallback any
function Entity:GetNWInt(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNWString.
---@param key string
---@param fallback any
function Entity:GetNWString(key,fallback) end

-- Returns callback function for given NWVar of this entity.This function was superseded by Entity:GetNW2VarProxy. This page still exists an archive in case anybody ever stumbles across old code and needs to know what it is
---@param key any
function Entity:GetNWVarProxy(key) end

-- Returns all the networked variables in an entity.
function Entity:GetNWVarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNWVector.
---@param key string
---@param fallback any
function Entity:GetNWVector(key,fallback) end

-- Returns the owner entity of this entity. See Entity:SetOwner for more info.This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.
function Entity:GetOwner() end

-- Returns the parent entity of this entity.
function Entity:GetParent() end

-- Returns the attachment index of the entity's parent. Returns 0 if the entity is not parented to a specific attachment or if it isn't parented at all.This is set by second argument of Entity:SetParent or the **SetParentAttachment** input.
function Entity:GetParentAttachment() end

-- If the entity is parented to an entity that has a model with multiple physics objects (like a ragdoll), this is used to retrieve what physics object number the entity is parented to on it's parent.
function Entity:GetParentPhysNum() end

-- Returns the position and angle of the entity's move parent as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.
function Entity:GetParentWorldTransformMatrix() end

-- Returns whether the entity is persistent or not.See Entity:SetPersistent for more information on persistence.
function Entity:GetPersistent() end

-- Returns player who is claiming kills of physics damage the entity deals.
---@param timeLimit number
function Entity:GetPhysicsAttacker(timeLimit) end

-- Returns the entity's physics object, if the entity has physics.Entities don't have clientside physics objects by default, so this will return `[NULL PHYSOBJ]` on the client in most cases.
function Entity:GetPhysicsObject() end

-- Returns the number of physics objects an entity has (usually 1 for non-ragdolls)
function Entity:GetPhysicsObjectCount() end

-- Returns a specific physics object from an entity with multiple PhysObjects (like ragdolls)See also Entity:TranslateBoneToPhysBone.
---@param physNum number
function Entity:GetPhysicsObjectNum(physNum) end

-- Returns the playback rate of the main sequence on this entity, with 1.0 being the default speed.
function Entity:GetPlaybackRate() end

-- Gets the position of entity in world.
function Entity:GetPos() end

-- Returns the pose parameter value
---@param name string
function Entity:GetPoseParameter(name) end

-- Returns name of given pose parameter
---@param id number
function Entity:GetPoseParameterName(id) end

-- Returns pose parameter range
---@param id number
function Entity:GetPoseParameterRange(id) end

-- Returns whether this entity is predictable or not.See Entity:SetPredictable for more information
function Entity:GetPredictable() end

-- Returns the entity which the ragdoll came from. The opposite of Player:GetRagdollEntity.
function Entity:GetRagdollOwner() end

-- Returns the entity's render angles, set by Entity:SetRenderAngles in a drawing hook.
function Entity:GetRenderAngles() end

-- Returns render bounds of the entity as local vectors. Can be overridden by Entity:SetRenderBounds.If the render bounds are not inside players view, the entity will not be drawn!
function Entity:GetRenderBounds() end

-- Returns current render FX of the entity.
function Entity:GetRenderFX() end

-- Returns the render group of the entity.
function Entity:GetRenderGroup() end

-- Returns the render mode of the entity.
function Entity:GetRenderMode() end

-- Returns the entity's render origin, set by Entity:SetRenderOrigin in a drawing hook.
function Entity:GetRenderOrigin() end

-- Returns the rightward vector of the entity, as a normalized direction vector
function Entity:GetRight() end

-- Returns axis-aligned bounding box (AABB) of a orientated bounding box (OBB) based on entity's rotation.
---@param min Vector
---@param max Vector
function Entity:GetRotatedAABB(min,max) end

-- Returns a table of save values for an entity.These tables are not the same between the client and the server, and different entities may have different fields.You can get the list different fields an entity has by looking at it's source code (the 2013 SDK can be found [online](https://github.com/ValveSoftware/source-sdk-2013)). Accessible fields are defined by each `DEFINE_FIELD` and `DEFINE_KEYFIELD` inside the `DATADESC` block.Take the headcrab, for example:```BEGIN_DATADESC( CBaseHeadcrab )// m_nGibCount - don't saveDEFINE_FIELD( m_bHidden, FIELD_BOOLEAN ),DEFINE_FIELD( m_flTimeDrown, FIELD_TIME ),DEFINE_FIELD( m_bCommittedToJump, FIELD_BOOLEAN ),DEFINE_FIELD( m_vecCommittedJumpPos, FIELD_POSITION_VECTOR ),DEFINE_FIELD( m_flNextNPCThink, FIELD_TIME ),DEFINE_FIELD( m_flIgnoreWorldCollisionTime, FIELD_TIME ),DEFINE_KEYFIELD( m_bStartBurrowed, FIELD_BOOLEAN, "startburrowed" ),DEFINE_FIELD( m_bBurrowed, FIELD_BOOLEAN ),DEFINE_FIELD( m_flBurrowTime, FIELD_TIME ),DEFINE_FIELD( m_nContext, FIELD_INTEGER ),DEFINE_FIELD( m_bCrawlFromCanister, FIELD_BOOLEAN ),DEFINE_FIELD( m_bMidJump, FIELD_BOOLEAN ),DEFINE_FIELD( m_nJumpFromCanisterDir, FIELD_INTEGER ),DEFINE_FIELD( m_bHangingFromCeiling, FIELD_BOOLEAN ),DEFINE_FIELD( m_flIlluminatedTime, FIELD_TIME ),DEFINE_INPUTFUNC( FIELD_VOID, "Burrow", InputBurrow ),DEFINE_INPUTFUNC( FIELD_VOID, "BurrowImmediate", InputBurrowImmediate ),DEFINE_INPUTFUNC( FIELD_VOID, "Unburrow", InputUnburrow ),DEFINE_INPUTFUNC( FIELD_VOID, "StartHangingFromCeiling", InputStartHangingFromCeiling ),DEFINE_INPUTFUNC( FIELD_VOID, "DropFromCeiling", InputDropFromCeiling ),// Function PointersDEFINE_THINKFUNC( EliminateRollAndPitch ),DEFINE_THINKFUNC( ThrowThink ),DEFINE_ENTITYFUNC( LeapTouch ),END_DATADESC()```* For each **DEFINE_FIELD**, the save table will have a key with name of **first** argument.* For each **DEFINE_KEYFIELD**, the save table will have a key with name of the **third** argument.See Entity:GetInternalVariable for only retrieving one key of the save table.
---@param showAll boolean
function Entity:GetSaveTable(showAll) end

-- Return the index of the model sequence that is currently active for the entity.
function Entity:GetSequence() end

-- Return activity id out of sequence id. Opposite of Entity:SelectWeightedSequence.
---@param seq number
function Entity:GetSequenceActivity(seq) end

-- Returns the activity name for the given sequence id.
---@param sequenceId number
function Entity:GetSequenceActivityName(sequenceId) end

-- Returns the amount of sequences ( animations ) the entity's model has.
function Entity:GetSequenceCount() end

-- Returns the ground speed of the entity's sequence.
---@param sequenceId number
function Entity:GetSequenceGroundSpeed(sequenceId) end

-- Returns a table of information about an entity's sequence.
---@param sequenceId number
function Entity:GetSequenceInfo(sequenceId) end

-- Returns a list of all sequences ( animations ) the model has.
function Entity:GetSequenceList() end

-- Returns an entity's sequence move distance (the change in position over the course of the entire sequence).See Entity:GetSequenceMovement for a similar function with more options.
---@param sequenceId number
function Entity:GetSequenceMoveDist(sequenceId) end

-- Returns the delta movement and angles of a sequence of the entity's model.
---@param sequenceId number
---@param startCycle number
---@param endCyclnde number
function Entity:GetSequenceMovement(sequenceId,startCycle,endCyclnde) end

-- Returns the change in heading direction in between the start and the end of the sequence.
---@param seq number
function Entity:GetSequenceMoveYaw(seq) end

-- Return the name of the sequence for the index provided.Refer to Entity:GetSequence to find the current active sequence on this entity.See Entity:LookupSequence for a function that does the opposite.
---@param index number
function Entity:GetSequenceName(index) end

-- Returns an entity's sequence velocity at given animation frame.
---@param sequenceId number
---@param cycle number
function Entity:GetSequenceVelocity(sequenceId,cycle) end

-- Checks if the entity plays a sound when picked up by a player.This will return nil if Entity:SetShouldPlayPickupSound has not been called.
function Entity:GetShouldPlayPickupSound() end

-- Returns if entity should create a server ragdoll on death or a client one.
function Entity:GetShouldServerRagdoll() end

-- Returns the skin index of the current skin.
function Entity:GetSkin() end

-- Returns solid type of an entity.
function Entity:GetSolid() end

-- Returns solid flag(s) of an entity.
function Entity:GetSolidFlags() end

-- Returns if we should show a spawn effect on spawn on this entity.
function Entity:GetSpawnEffect() end

-- Returns the bitwise spawn flags used by the entity.
function Entity:GetSpawnFlags() end

-- Returns the material override for the given index.Returns "" if no material override exists. Use Entity:GetMaterials to list it's default materials.The server's value takes priority on the client.
---@param index number
function Entity:GetSubMaterial(index) end

-- Returns a list of models included into the entity's model in the .qc file.
function Entity:GetSubModels() end

-- Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box for hitbox detection. In most cases, this will return the same bounding box as Entity:WorldSpaceAABB unless it was changed by Entity:SetSurroundingBounds or Entity:SetSurroundingBoundsType.
function Entity:GetSurroundingBounds() end

-- Returns the table that contains all values saved within the entity.
function Entity:GetTable() end

-- Returns the last trace used in the collision callbacks such as ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch.This returns the last collision trace used, regardless of the entity that caused it. As such, it's only reliable when used in the hooks mentioned above
function Entity:GetTouchTrace() end

-- Returns true if the TransmitWithParent flag is set or not.
function Entity:GetTransmitWithParent() end

-- Returns if the entity is unfreezable, meaning it can't be frozen with the physgun. By default props are freezable, so this function will typically return false.This will return nil if Entity:SetUnFreezable has not been called.
function Entity:GetUnFreezable() end

-- Returns the upward vector of the entity, as a normalized direction vector
function Entity:GetUp() end

-- Retrieves a value from entity's Entity:GetTable. Set by Entity:SetVar.
---@param key any
---@param default any
function Entity:GetVar(key,default) end

-- Returns the entity's velocity.Actually binds to `CBaseEntity::GetAbsVelocity()` on the server and `C_BaseEntity::EstimateAbsVelocity()` on the client. This returns the total velocity of the entity and is equal to local velocity + base velocity.This can become out-of-sync on the client if the server has been up for a long time.
function Entity:GetVelocity() end

-- Returns ID of workshop addon that the entity is from.The function **currently** does nothing and always returns nil
function Entity:GetWorkshopID() end

-- Returns the position and angle of the entity as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.This returns incorrect results for the angular component (columns 1-3) for the local player clientside.This will use the local player's Global.EyeAngles in Category:3D_Rendering_Hooks.Columns 1-3 will be all 0 (angular component) in Category:3D_Rendering_Hooks while paused in single-player.
function Entity:GetWorldTransformMatrix() end

-- Causes the entity to break into its current models gibs, if it has any.You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs.If called on server, the gibs will be spawned on the currently connected clients and will not be synchronized. Otherwise the gibs will be spawned only for the client the function is called on.this function will not remove or hide the entity it is called on.For more expensive version of this function see Entity:GibBreakServer.
---@param force Vector
---@param clr table
function Entity:GibBreakClient(force,clr) end

-- Causes the entity to break into its current models gibs, if it has any.You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs.The gibs will be spawned on the server and be synchronized with all clients.Note, that this function will not remove or hide the entity it is called on.This function is affected by `props_break_max_pieces_perframe` and `props_break_max_pieces` console variables.Large numbers of serverside gibs will cause lag.You can avoid this cost by spawning the gibs on the client using Entity:GibBreakClientDespite existing on client, it doesn't actually do anything on client.
---@param force Vector
function Entity:GibBreakServer(force) end

-- Returns whether or not the bone manipulation functions have ever been called on given  entity.Related functions are Entity:ManipulateBonePosition, Entity:ManipulateBoneAngles, Entity:ManipulateBoneJiggle, and Entity:ManipulateBoneScale.This will return true if the entity's bones have ever been manipulated. Resetting the position/angles/jiggle/scaling to 0,0,0 will not affect this function.
function Entity:HasBoneManipulations() end

-- Returns whether or not the the entity has had flex manipulations performed with Entity:SetFlexWeight or Entity:SetFlexScale.
function Entity:HasFlexManipulatior() end

-- Returns whether this entity has the specified spawnflags bits set.
---@param spawnFlags number
function Entity:HasSpawnFlags(spawnFlags) end

-- Returns the position of the head of this entity, NPCs use this internally to aim at their targets.This only works on players and NPCs.
---@param origin Vector
function Entity:HeadTarget(origin) end

-- Returns the health of the entity.
function Entity:Health() end

-- Sets the entity on fire.See also Entity:Extinguish.
---@param length number
---@param radius number
function Entity:Ignite(length,radius) end

-- Initializes this entity as being clientside only.Only works on entities fully created clientside, and as such it has currently no use due this being automatically called by ents.CreateClientProp, ents.CreateClientside, Global.ClientsideModel and Global.ClientsideScene.Calling this on a clientside entity will crash the game.
function Entity:InitializeAsClientEntity() end

-- Fires input to the entity with the ability to make another entity responsible, bypassing the event queue system.You should only use this function over Entity:Fire if you know what you are doing.See also Entity:Fire for a function that conforms to the internal map IO event queue and GM:AcceptInput for a hook that can intercept inputs.
---@param input string
---@param activator Entity
---@param caller Entity
---@param param any
function Entity:Input(input,activator,caller,param) end

--  Sets up Data Tables from entity to use with Entity:NetworkVar.
function Entity:InstallDataTable() end

-- Resets the entity's bone cache values in order to prepare for a model change.This should be called after calling Entity:SetPoseParameter.
function Entity:InvalidateBoneCache() end

-- Returns true if the entity has constraints attached to itThis will only update clientside if the server calls it first. This only checks constraints added through the constraint so this will not react to map constraints.
function Entity:IsConstrained() end

-- Returns if entity is constraint or not
function Entity:IsConstraint() end

-- Returns whether the entity is dormant or not. Client/server entities become dormant when they leave the PVS on the server. Client side entities can decide for themselves whether to become dormant. This mainly applies to PVS.
function Entity:IsDormant() end

-- Returns whether an entity has engine effect applied or not.
---@param effect number
function Entity:IsEffectActive(effect) end

-- Checks if given flag is set or not.
---@param flag number
function Entity:IsEFlagSet(flag) end

-- Checks if given flag(s) is set or not.
---@param flag number
function Entity:IsFlagSet(flag) end

-- Returns whether the entity is inside a wall or outside of the map.Internally this function uses util.IsInWorld, that means that this function only checks Entity:GetPos of the entity. If an entity is only partially inside a wall, or has a weird GetPos offset, this function may not give reliable output.
function Entity:IsInWorld() end

-- Returns whether the entity is lag compensated or not.
function Entity:IsLagCompensated() end

-- Returns true if the target is in line of sight.This will only work when called on CBaseCombatCharacter entities. This includes players, NPCs, grenades, RPG rockets, crossbow bolts, and physics cannisters.
---@param target Vector
function Entity:IsLineOfSightClear(target) end

-- Returns if the entity is going to be deleted in the next frame.
function Entity:IsMarkedForDeletion() end

-- Checks if the entity is a NextBot or not.
function Entity:IsNextBot() end

-- Checks if the entity is an NPC or not.This will return false for NextBots, see Entity:IsNextBot for that.
function Entity:IsNPC() end

-- Returns whether the entity is on fire.
function Entity:IsOnFire() end

-- Returns whether the entity is on ground or not.Internally, this checks if Enums/FL is set on the entity.This function is an alias of Entity:OnGround.
function Entity:IsOnGround() end

-- Checks if the entity is a player or not.
function Entity:IsPlayer() end

-- Returns true if the entity is being held by a player. Either by physics gun, gravity gun or use-key (+use).If multiple players are holding an object and one drops it, this will return false despite the object still being held.
function Entity:IsPlayerHolding() end

-- Returns whether there's a gesture with the given activity being played.This function only works on BaseAnimatingOverlay entites!
---@param activity number
function Entity:IsPlayingGesture(activity) end

-- Checks if the entity is a ragdoll.
function Entity:IsRagdoll() end

-- Checks if the entity is a SENT or a built-in entity.
function Entity:IsScripted() end

-- Returns whether the entity's current sequence is finished or not.
function Entity:IsSequenceFinished() end

-- Returns if the entity is solid or not.Very useful for determining if the entity is a trigger or not.
function Entity:IsSolid() end

-- Returns whether the entity is a valid entity or not.An entity is valid if:* It is not a Global_Variables entity* It is not the worldspawn entity (game.GetWorld)Instead of calling this method directly, it's a good idea to call the global Global.IsValid instead, however if you're sure the variable you're using is always an entity object it's better to use this methodIt will check whether the given variable contains an object (an Entity) or nothing at all for you. See examples.NULL entities can still be assigned with key/value pairs, but they will be instantly negated. See example 3This might be a cause for a lot of headache. Usually happening during networking etc., when completely valid entities suddenly become invalid on the client, but are never filtered with IsValid(). See GM:InitPostEntity for more details.
function Entity:IsValid() end

-- Returns whether the given layer ID is valid and exists on this entity.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
function Entity:IsValidLayer(layerID) end

-- Checks if the entity is a vehicle or not.
function Entity:IsVehicle() end

-- Checks if the entity is a weapon or not.
function Entity:IsWeapon() end

-- Returns whether the entity is a widget or not.This is used by the "Edit Bones" context menu property.
function Entity:IsWidget() end

-- Returns if the entity is the map's Entity[0] worldspawn
function Entity:IsWorld() end

-- Converts a vector local to an entity into a worldspace vector
---@param lpos Vector
function Entity:LocalToWorld(lpos) end

-- Converts a local angle (local to the entity) to a world angle.
---@param ang Angle
function Entity:LocalToWorldAngles(ang) end

-- Returns the attachment index of the given attachment name.
---@param attachmentName string
function Entity:LookupAttachment(attachmentName) end

-- Gets the bone index of the given bone name, returns nothing if the bone does not exist.
---@param boneName string
function Entity:LookupBone(boneName) end

-- Returns pose parameter ID from its name.
---@param name string
function Entity:LookupPoseParameter(name) end

-- Returns sequence ID from its name. See Entity:GetSequenceName for a function that does the opposite.
---@param name string
function Entity:LookupSequence(name) end

-- Turns the Entity:GetPhysicsObject into a physics shadow.It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.A physics shadow can be used to have static entities that never move by setting both arguments to false.Unlike Entity:PhysicsInitShadow, this function doesn't remove the current physics object.
---@param allowPhysicsMovement boolean
---@param allowPhysicsRotation boolean
function Entity:MakePhysicsObjectAShadow(allowPhysicsMovement,allowPhysicsRotation) end

-- Sets custom bone angles.When used repeatedly serverside, this method is strongly discouraged due to the huge network traffic produced.
---@param boneID number
---@param ang Angle
---@param networking boolean
function Entity:ManipulateBoneAngles(boneID,ang,networking) end

-- Manipulates the bone's jiggle status. This allows non jiggly bones to become jiggly.
---@param boneID number
---@param enabled number
function Entity:ManipulateBoneJiggle(boneID,enabled) end

-- Sets custom bone offsets.
---@param boneID number
---@param pos Vector
---@param networking boolean
function Entity:ManipulateBonePosition(boneID,pos,networking) end

-- Sets custom bone scale.When used repeatedly serverside, this method is strongly discouraged due to the huge network traffic produced.This does not scale procedural bones.
---@param boneID number
---@param scale Vector
function Entity:ManipulateBoneScale(boneID,scale) end

-- Returns entity's map creation ID. Unlike Entity:EntIndex or Entity:GetCreationID, it will always be the same on same map, no matter how much you clean up or restart it.To be used in conjunction with ents.GetMapCreatedEntity.
function Entity:MapCreationID() end

-- Refreshes the shadow of the entity.
function Entity:MarkShadowAsDirty() end

-- Fires the muzzle flash effect of the weapon the entity is carrying. This only creates a light effect and is often called alongside Weapon:SendWeaponAnim
function Entity:MuzzleFlash() end

-- Performs a Ray-Orientated Bounding Box intersection from the given position to the origin of the OBBox with the entity and returns the hit position on the OBBox.This relies on the entity having a collision mesh (not a physics object) and will be affected by `SOLID_NONE`
---@param position Vector
function Entity:NearestPoint(position) end

-- Creates a network variable on the entity and adds Set/Get functions for it. This function should only be called in ENTITY:SetupDataTables.See Entity:NetworkVarNotify for a function to hook NetworkVar changes.Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing.Entity NetworkVars may briefly be incorrect due to how PVS networking and entity indexes work.
---@param type string
---@param slot number
---@param name string
---@param extended table
function Entity:NetworkVar(type,slot,name,extended) end

-- Similarly to Entity:NetworkVar, creates a network variable on the entity and adds Set/Get functions for it. This method stores it's value as a member value of a vector or an angle. This allows to go beyond the normal variable limit of Entity:NetworkVar for `Int` and `Float` types, at the expense of `Vector` and `Angle` limit.This function should only be called in ENTITY:SetupDataTables.Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing.
---@param type string
---@param slot number
---@param element string
---@param name string
---@param extended table
function Entity:NetworkVarElement(type,slot,element,name,extended) end

-- Creates a callback that will execute when the given network variable changes - that is, when the `Set()` function is run.The callback is executed **before** the value is changed, and is called even if the new and old values are the same.This function does not exist on entities in which Entity:InstallDataTable has not been called. By default, this means this function only exists on SENTs (both serverside and clientside) and on players with a Player_Classes (serverside and clientside Global.LocalPlayer only). It's therefore safest to only use this in ENTITY:SetupDataTables.The callback will not be called clientside if the var is changed right after entity spawn.
---@param name string
---@param callback function
function Entity:NetworkVarNotify(name,callback) end

-- In the case of a scripted entity, this will cause the next ENTITY:Think event to be run at the given time.Does not work clientside! Use Entity:SetNextClientThink instead.This does not work with SWEPs or Nextbots.
---@param timestamp number
function Entity:NextThink(timestamp) end

-- Returns the center of an entity's bounding box as a local vector.
function Entity:OBBCenter() end

-- Returns the highest corner of an entity's bounding box as a local vector.
function Entity:OBBMaxs() end

-- Returns the lowest corner of an entity's bounding box as a local vector.
function Entity:OBBMins() end

-- Returns the entity's capabilities as a bitfield.In the engine this function is mostly used to check the use type, the save/restore system and level transitions flags.Even though the function is defined shared, it is not guaranteed to return the same value across states.The enums for this are not currently implemented in Lua, however you can access the defines [here](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/shared/baseentity_shared.h#L21-L38).
function Entity:ObjectCaps() end

-- Returns true if the entity is on the ground, and false if it isn't.Internally, this checks if Enums/FL is set on the entity. This is only updated for players and NPCs, and thus won't inherently work for other entities.
function Entity:OnGround() end

-- Tests whether the damage passes the entity filter.This will call ENTITY:PassesDamageFilter on scripted entities of the type "filter".This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
---@param dmg CTakeDamageInfo
function Entity:PassesDamageFilter(dmg) end

-- Tests whether the entity passes the entity filter.This will call ENTITY:PassesFilter on scripted entities of the type "filter".This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
---@param caller Entity
---@param ent Entity
function Entity:PassesFilter(caller,ent) end

-- Destroys the current physics object of an entity.Cannot be used on a ragdoll or the world entity.
function Entity:PhysicsDestroy() end

-- Initializes the physics mesh of the entity from a triangle soup defined by a table of vertices. The resulting mesh is hollow, may contain holes, and always has a volume of 0.While this is very useful for static geometry such as terrain displacements, it is advised to use Entity:PhysicsInitConvex or Entity:PhysicsInitMultiConvex for moving solid objects instead.Entity:EnableCustomCollisions needs to be called if you want players to collide with the entity correctly.
---@param vertices table
---@param surfaceprop string
function Entity:PhysicsFromMesh(vertices,surfaceprop) end

-- Initializes the Entity:GetPhysicsObject of the entity using its current Entity:GetModel. Deletes the previous physics object if it existed and the new object creation was successful.If the entity's current model has no physics mesh associated to it, no physics object will be created and the previous object will still exist, if applicable.When called clientside, this will not create a valid PhysObj if the model hasn't been util.PrecacheModel serverside.If successful, this function will automatically call Entity:SetSolid( solidType ) and Entity:SetSolidFlags( 0 ).Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param solidType number
function Entity:PhysicsInit(solidType) end

-- Makes the physics object of the entity a AABB.This function will automatically destroy any previous physics objects and do the following:* Entity:SetSolid( `SOLID_BBOX` )* Entity:SetMoveType( `MOVETYPE_VPHYSICS` )* Entity:SetCollisionBounds( `mins`, `maxs` )If the volume of the resulting box is 0 (the mins and maxs are the same), the mins and maxs will be changed to Global.Vector( -1, -1, -1 ) and Global.Vector( 1, 1, 1 ), respectively.Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param mins Vector
---@param maxs Vector
---@param surfaceprop string
function Entity:PhysicsInitBox(mins,maxs,surfaceprop) end

-- Initializes the physics mesh of the entity with a convex mesh defined by a table of points. The resulting mesh is the  of all the input points. If successful, the previous physics object will be removed.This is the standard way of creating moving physics objects with a custom convex shape. For more complex, concave shapes, see Entity:PhysicsInitMultiConvex.This will crash if given all Global.Vector(0,0,0)s.Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.You can use the following workaround for movement, though clientside collisions will still be broken.```function ENT:Think()if ( CLIENT ) thenlocal physobj = self:GetPhysicsObject()if ( IsValid( physobj ) ) thenphysobj:SetPos( self:GetPos() )physobj:SetAngles( self:GetAngles() )endendend```
---@param points table
---@param surfaceprop string
function Entity:PhysicsInitConvex(points,surfaceprop) end

-- An advanced version of Entity:PhysicsInitConvex which initializes a physics object from multiple convex meshes. This should be used for physics objects with a custom shape which cannot be represented by a single convex mesh.If successful, the previous physics object will be removed.Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param vertices table
---@param surfaceprop string
function Entity:PhysicsInitMultiConvex(vertices,surfaceprop) end

-- Initializes the entity's physics object as a physics shadow. Removes the previous physics object if successful. This is used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.A physics shadow can be used to have static entities that never move by setting both arguments to false.Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param allowPhysicsMovement boolean
---@param allowPhysicsRotation boolean
function Entity:PhysicsInitShadow(allowPhysicsMovement,allowPhysicsRotation) end

-- Makes the physics object of the entity a sphere.This function will automatically destroy any previous physics objects and do the following:* Entity:SetSolid( `SOLID_BBOX` )* Entity:SetMoveType( `MOVETYPE_VPHYSICS` )Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param radius number
---@param physmat string
function Entity:PhysicsInitSphere(radius,physmat) end

-- Initializes a static physics object of the entity using its Entity:GetModel. If successful, the previous physics object is removed.This is what used by entities such as `func_breakable`, `prop_dynamic`, `item_suitcharger`, `prop_thumper` and `npc_rollermine` while it is in its "buried" state in the Half-Life 2 Campaign.If the entity's current model has no physics mesh associated to it, no physics object will be created.This function will automatically call Entity:SetSolid( `solidType` ).Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.A workaround is available on the Entity:PhysicsInitConvex page.
---@param solidType number
function Entity:PhysicsInitStatic(solidType) end

-- Wakes up the entity's physics object
function Entity:PhysWake() end

-- Makes the entity play a .vcd scene. [All scenes from Half-Life 2](https://developer.valvesoftware.com/wiki/Half-Life_2_Scenes_List).
---@param scene string
---@param delay number
function Entity:PlayScene(scene,delay) end

-- Changes an entities angles so that it faces the target entity.
---@param target Entity
function Entity:PointAtEntity(target) end

-- Precaches gibs for the entity's model.Normally this function should be ran when the entity is spawned, for example the ENTITY:Initialize, after Entity:SetModel is called.This is required for Entity:GibBreakServer and Entity:GibBreakClient to work.
function Entity:PrecacheGibs() end

-- Normalizes the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
function Entity:RagdollSolve() end

-- Sets the function to build the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
function Entity:RagdollStopControlling() end

-- Makes the physics objects follow the set bone positions. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
function Entity:RagdollUpdatePhysics() end

-- Removes the entity it is used on. The entity will be removed at the start of next tick.
function Entity:Remove() end

-- Removes all decals from the entities surface.
function Entity:RemoveAllDecals() end

-- Removes and stops all gestures.This function only works on BaseAnimatingOverlay entites!
function Entity:RemoveAllGestures() end

-- Removes a callback previously added with Entity:AddCallback
---@param hook string
---@param callbackid number
function Entity:RemoveCallback(hook,callbackid) end

-- Removes a function previously added via Entity:CallOnRemove.
---@param identifier string
function Entity:RemoveCallOnRemove(identifier) end

-- Removes an engine effect applied to an entity.
---@param effect number
function Entity:RemoveEffects(effect) end

-- Removes specified engine flag
---@param flag number
function Entity:RemoveEFlags(flag) end

-- Removes specified flag(s) from the entity
---@param flag number
function Entity:RemoveFlags(flag) end

-- Removes a PhysObject from the entity's motion controller so that ENTITY:PhysicsSimulate will no longer be called for given PhysObject.You must first create a motion controller with Entity:StartMotionController.Only works on a scripted Entity of anim type
---@param physObj PhysObj
function Entity:RemoveFromMotionController(physObj) end

-- Removes and stops the gesture with given activity.This function only works on BaseAnimatingOverlay entites!
---@param activity number
function Entity:RemoveGesture(activity) end

-- Breaks internal Ragdoll constrains, so you can for example separate an arm from the body of a ragdoll and preserve all physics.The visual mesh will still stretch as if it was properly connected unless the ragdoll model is specifically designed to avoid that.
---@param num number
function Entity:RemoveInternalConstraint(num) end

-- Removes solid flag(s) from the entity.
---@param flags number
function Entity:RemoveSolidFlags(flags) end

-- Plays an animation on the entity. This may not always work on engine entities.This will not reset the animation on viewmodels, use Entity:SendViewModelMatchingSequence instead.This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick.Will not work on players due to the animations being reset every frame by the base gamemode animation system. See GM:CalcMainActivity.For custom scripted entities you will want to apply example from ENTITY:Think to make animations work.
---@param sequence number
function Entity:ResetSequence(sequence) end

-- Reset entity sequence info such as playback rate, ground speed, last event check, etc.
function Entity:ResetSequenceInfo() end

-- Makes the entity/weapon respawn.Only usable on HL2/HL:S pickups and any weapons. Seems to be buggy with weapons.Very unreliable.
function Entity:Respawn() end

-- Restarts the entity's animation gesture. If the given gesture is already playing, it will reset it and play it from the beginning.This function only works on BaseAnimatingOverlay entites.
---@param activity number
---@param addIfMissing boolean
---@param autokill boolean
function Entity:RestartGesture(activity,addIfMissing,autokill) end

-- Returns sequence ID corresponding to given activity ID.Opposite of Entity:GetSequenceActivity.Similar to Entity:LookupSequence.See also Entity:SelectWeightedSequenceSeeded.
---@param act number
function Entity:SelectWeightedSequence(act) end

-- Returns the sequence ID corresponding to given activity ID, and uses the provided seed for random selection. The seed should be the same server-side and client-side if used in a predicted environment.See Entity:SelectWeightedSequence for a provided-seed version of this function.
---@param act number
---@param seed number
function Entity:SelectWeightedSequenceSeeded(act,seed) end

-- Sends sequence animation to the view model. It is recommended to use this for view model animations, instead of Entity:ResetSequence.This function is only usable on view models.Sequences 0-6 will not be looped regardless if they're marked as a looped animation or not.
---@param seq number
function Entity:SendViewModelMatchingSequence(seq) end

-- Returns length of currently played sequence.This will return incorrect results for weapons and viewmodels clientside in thirdperson.
---@param seqid number
function Entity:SequenceDuration(seqid) end

-- Sets the entity's velocity.Actually binds to CBaseEntity::SetLocalVelocity() which sets the entity's velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.
---@param velocity Vector
function Entity:SetAbsVelocity(velocity) end

-- Sets the angles of the entity.To set a player's angles, use Player:SetEyeAngles instead.
---@param angles Angle
function Entity:SetAngles(angles) end

-- Sets a player's third-person animation. Mainly used by Weapons to start the player's weapon attack and reload animations.
---@param playerAnim number
function Entity:SetAnimation(playerAnim) end

-- Sets the start time (relative to Global.CurTime) of the current animation, which is used to determine Entity:GetCycle. Should be less than CurTime to play an animation from the middle.
---@param time number
function Entity:SetAnimTime(time) end

-- You should be using Entity:SetParent instead.Parents the sprite to an attachment on another model.Works only on env_sprite.Despite existing on client, it doesn't actually do anything on client.
---@param ent Entity
---@param attachment number
function Entity:SetAttachment(ent,attachment) end

-- Sets the blood color this entity uses.
---@param bloodColor number
function Entity:SetBloodColor(bloodColor) end

-- Sets an entities' bodygroup.If called for Weapon (after Initialize hook) with different body groups on world model and view model, check will occur by view model.
---@param bodygroup number
---@param value number
function Entity:SetBodygroup(bodygroup,value) end

-- Sets the bodygroups from a string. A convenience function for Entity:SetBodygroup.If called for Weapon (after Initialize hook) with different body groups on world model and view model, check will occur by view model.
---@param bodygroups string
function Entity:SetBodyGroups(bodygroups) end

-- Sets the specified value on the bone controller with the given ID of this entity, it's used in HL1 to change the head rotation of NPCs, turret aiming and so on.This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
---@param boneControllerID number
---@param value number
function Entity:SetBoneController(boneControllerID,value) end

-- Sets the bone matrix of given bone to given matrix. See also Entity:GetBoneMatrix.Despite existing serverside, it does nothing.
---@param boneid number
---@param matrix VMatrix
function Entity:SetBoneMatrix(boneid,matrix) end

-- Sets the bone position and angles.
---@param bone number
---@param pos Vector
---@param ang Angle
function Entity:SetBonePosition(bone,pos,ang) end

-- Sets the collision bounds for the entity, which are used for triggers (Entity:SetTrigger, ENTITY:Touch), and collision (If Entity:SetSolid set as Enums/SOLID).Input bounds are relative to Entity:GetPos!See also Entity:SetCollisionBoundsWS.Player collision bounds are reset every frame to player's Player:SetHull values.
---@param mins Vector
---@param maxs Vector
function Entity:SetCollisionBounds(mins,maxs) end

-- A convenience function that sets the collision bounds for the entity in world space coordinates by transforming given vectors to entity's local space and passing them to Entity:SetCollisionBounds
---@param vec1 Vector
---@param vec2 Vector
function Entity:SetCollisionBoundsWS(vec1,vec2) end

-- Sets the entity's collision group.
---@param group number
function Entity:SetCollisionGroup(group) end

-- Sets the color of an entity.Some entities may need a custom [render mode](Enums/RENDERMODE) set for transparency to work. See example 2.Entities also must have a proper [render group](Enums/RENDERGROUP) set for transparency to work.
---@param color table
function Entity:SetColor(color) end

-- Sets the color of an entity.This function overrides Colors set with Entity:SetColor
---@param r number
---@param g number
---@param b number
---@param a number
function Entity:SetColor4Part(r,g,b,a) end

-- Sets the creator of the Entity. This is set automatically in Sandbox gamemode when spawning SENTs, but is never used/read by default.
---@param ply Player
function Entity:SetCreator(ply) end

-- Marks the entity to call GM:ShouldCollide. Not to be confused with Entity:EnableCustomCollisions.
---@param enable boolean
function Entity:SetCustomCollisionCheck(enable) end

-- Sets the progress of the current animation to a specific value between 0 and 1.This does not work with viewmodels.
---@param value number
function Entity:SetCycle(value) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified angle on the entity's datatable.
---@param key number
---@param ang Angle
function Entity:SetDTAngle(key,ang) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified bool on the entity's datatable.
---@param key number
---@param bool boolean
function Entity:SetDTBool(key,bool) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified entity on this entity's datatable.
---@param key number
---@param ent Entity
function Entity:SetDTEntity(key,ent) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified float on the entity's datatable.
---@param key number
---@param float number
function Entity:SetDTFloat(key,float) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified integer on the entity's datatable.
---@param key number
---@param integer number
function Entity:SetDTInt(key,integer) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified string on the entity's datatable.The length of these strings are capped at 512 characters.
---@param key number
---@param str string
function Entity:SetDTString(key,str) end

-- This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.Sets the specified vector on the entity's datatable.
---@param key number
---@param vec Vector
function Entity:SetDTVector(key,vec) end

-- Sets the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
---@param elasticity number
function Entity:SetElasticity(elasticity) end

-- Allows you to set the Start or End entity attachment for the rope.
---@param name string
---@param entity Entity
function Entity:SetEntity(name,entity) end

-- Sets the position an entity's eyes look toward. This works as an override for default behavior. Set to `0,0,0` to disable the override.
---@param pos Vector
function Entity:SetEyeTarget(pos) end

-- Sets the flex scale of the entity.This does not work on Global.ClientsideModels or Global.ClientsideRagdolls.
---@param scale number
function Entity:SetFlexScale(scale) end

-- Sets the flex weight.
---@param flex number
---@param weight number
function Entity:SetFlexWeight(flex,weight) end

-- Sets how much friction an entity has when sliding against a surface. Entities default to 1 (100%) and can be higher or even negative.This only multiplies the friction of the entity, to change the value itself use PhysObj:SetMaterial.Works only for MOVETYPE_STEP entities.This has no effect on players.
---@param friction number
function Entity:SetFriction(friction) end

-- Sets the gravity multiplier of the entity.This function is not predicted.
---@param gravityMultiplier number
function Entity:SetGravity(gravityMultiplier) end

-- Sets the ground the entity is standing on.
---@param ground Entity
function Entity:SetGroundEntity(ground) end

-- Sets the health of the entity.You may want to take Entity:GetMaxHealth into account when calculating what to set health to, in case a gamemode has a different max health than 100.In some cases, setting health only on server side can cause hitches in movement, for example if something modifying the player speed based on health. To solve this issue, it is better to set it shared in a predicted hook.
---@param newHealth number
function Entity:SetHealth(newHealth) end

-- Sets the current Hitbox set for the entity.
---@param id number
function Entity:SetHitboxSet(id) end

-- Enables or disable the inverse kinematic usage of this entity.
---@param useIK boolean
function Entity:SetIK(useIK) end

-- Sets Hammer key values on an entity.You can look up which entities have what key values on the [Valve Developer Community](https://developer.valvesoftware.com/wiki/) on entity pages.A  list of basic entities can be found [here](https://developer.valvesoftware.com/wiki/List_of_entities).Alternatively you can look at the .fgd files shipped with Garry's Mod in the bin/ folder with a text editor to see the key values as they appear in Hammer.
---@param key string
---@param value string
function Entity:SetKeyValue(key,value) end

-- This allows the entity to be lag compensated during Player:LagCompensation.Players are lag compensated by default and there's no need to call this function for them.It's best to not enable lag compensation on parented entities, as the system does not handle it that well ( they will be moved back but then the entity will lag behind ).Parented entities move back with the parent if it's lag compensated, so if you are making some kind of armor piece you shouldn't do anything.As a side note for parented entities, if your entity can be shot at, keep in mind that its collision bounds need to be bigger than the bone's hitbox the entity is parented to, or hull/line traces ( such as the crowbar attack or bullets ) might not hit at all.
---@param enable boolean
function Entity:SetLagCompensated(enable) end

-- This function only works on BaseAnimatingOverlay entites!
---@param layerID number
---@param blendIn number
function Entity:SetLayerBlendIn(layerID,blendIn) end

-- This function only works on BaseAnimatingOverlay entites!
---@param layerID number
---@param blendOut number
function Entity:SetLayerBlendOut(layerID,blendOut) end

-- Sets the animation cycle/frame of given layer.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
---@param cycle number
function Entity:SetLayerCycle(layerID,cycle) end

-- Sets the duration of given layer. This internally overrides the Entity:SetLayerPlaybackRate.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
---@param duration number
function Entity:SetLayerDuration(layerID,duration) end

-- Sets whether the layer should loop or not.This function only works on BaseAnimatingOverlay entites!
---@param layerID number
---@param loop boolean
function Entity:SetLayerLooping(layerID,loop) end

-- Sets the layer playback rate. See also Entity:SetLayerDuration.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
---@param rate number
function Entity:SetLayerPlaybackRate(layerID,rate) end

-- Sets the priority of given layer.This function only works on BaseAnimatingOverlay entites!
---@param layerID number
---@param priority number
function Entity:SetLayerPriority(layerID,priority) end

-- Sets the sequence of given layer.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
---@param seq number
function Entity:SetLayerSequence(layerID,seq) end

-- Sets the layer weight. This influences how strongly the animation should be overriding the normal animations of the entity.This function only works on BaseAnimatingOverlay entities.
---@param layerID number
---@param weight number
function Entity:SetLayerWeight(layerID,weight) end

-- This forces an entity to use the bone transformation behaviour from versions prior to **8 July 2014**.This behaviour affects Entity:EnableMatrix and Entity:SetModelScale and is incorrect, therefore this function be used exclusively as a quick fix for old scripts that rely on it.
---@param enabled boolean
function Entity:SetLegacyTransform(enabled) end

-- Sets the entity to be used as the light origin position for this entity.
---@param lightOrigin Entity
function Entity:SetLightingOriginEntity(lightOrigin) end

-- Sets angles relative to angles of Entity:GetParent
---@param ang Angle
function Entity:SetLocalAngles(ang) end

-- Sets the entity's angular velocity (rotation speed).
---@param angVel Angle
function Entity:SetLocalAngularVelocity(angVel) end

-- Sets local position relative to the parented position. This is for use with Entity:SetParent to offset position.
---@param pos Vector
function Entity:SetLocalPos(pos) end

-- Sets the entity's local velocity which is their velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.Same as Entity:SetAbsVelocity, but clamps the given velocity, and is not recommended to be used because of that.
---@param velocity Vector
function Entity:SetLocalVelocity(velocity) end

-- Sets the Level Of Detail model to use with this entity. This may not work for all models if the model doesn't include any LOD sub models.This function works exactly like the clientside r_lod convar and takes priority over it.
---@param lod number
function Entity:SetLOD(lod) end

-- Sets the rendering material override of the entity.To set a Lua material created with Global.CreateMaterial, just prepend a "!" to the material name.If you wish to override a single material on the model, use Entity:SetSubMaterial instead.To apply materials to models, that material **must** have **VertexLitGeneric** shader. For that reason you cannot apply map textures onto models, map textures use a different material shader - **LightmappedGeneric**, which can be used on brush entities.The server's value takes priority on the client.
---@param materialName string
function Entity:SetMaterial(materialName) end

-- Sets the maximum health for entity. Note, that you can still set entity's health above this amount with Entity:SetHealth.
---@param maxhealth number
function Entity:SetMaxHealth(maxhealth) end

-- Sets the model of the entity.This does not update the physics of the entity - see Entity:PhysicsInit.This silently fails when given an empty string.
---@param modelName string
function Entity:SetModel(modelName) end

-- Alter the model name returned by Entity:GetModel. Does not affect the entity's actual model.
---@param modelname string
function Entity:SetModelName(modelname) end

-- Scales the model of the entity, if the entity is a Player or an NPC the hitboxes will be scaled as well.For some entities, calling Entity:Activate after this will scale the collision bounds and PhysObj as well; be wary as there's no optimization being done internally and highly complex collision models might crash the server.This is the same system used in TF2 for the Mann Vs Machine robots.To resize the entity along any axis, use Entity:EnableMatrix instead.Client-side trace detection seems to mess up if deltaTime is set to anything but zero. A very small decimal can be used instead of zero to solve this issue.If your old scales are wrong, use Entity:SetLegacyTransform as a quick fix.If you do not want the physics to be affected by Entity:Activate, you can use Entity:ManipulateBoneScale`( 0, Vector( scale, scale, scale ) )` instead.This does not scale procedural bones and disables IK.
---@param scale number
---@param deltaTime number
function Entity:SetModelScale(scale,deltaTime) end

-- Sets the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
---@param moveCollideType number
function Entity:SetMoveCollide(moveCollideType) end

-- Sets the Movement Parent of an entity to another entity.Similar to Entity:SetParent, except the object's coordinates are not translated automatically before parenting.Does nothing on client.
---@param Parent Entity
function Entity:SetMoveParent(Parent) end

-- Sets the entity's move type. This should be called before initializing the physics object on the entity, unless it will override SetMoveType such as Entity:PhysicsInitBox.Despite existing on client, it doesn't actually do anything on client.
---@param movetype number
function Entity:SetMoveType(movetype) end

-- Sets the mapping name of the entity.
---@param mappingName string
function Entity:SetName(mappingName) end

-- Alters the entity's perceived serverside angle on the client.
---@param angle Angle
function Entity:SetNetworkAngles(angle) end

-- Sets a networked angle value on the entity.The value can then be accessed with Entity:GetNetworked2Angle both from client and server. You should be using Entity:SetNW2Angle instead.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWAngle insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Angle
function Entity:SetNetworked2Angle(key,value) end

-- Sets a networked boolean value on the entity.The value can then be accessed with Entity:GetNetworked2Bool both from client and server.You should be using Entity:SetNW2Bool instead.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWBool insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value boolean
function Entity:SetNetworked2Bool(key,value) end

-- Sets a networked entity value on the entity.The value can then be accessed with Entity:GetNetworked2Entity both from client and server.You should be using Entity:SetNW2Entity instead.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWEntity insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Entity
function Entity:SetNetworked2Entity(key,value) end

-- Sets a networked float (number) value on the entity.The value can then be accessed with Entity:GetNetworked2Float both from client and server.Unlike Entity:SetNetworked2Int, floats don't have to be whole numbers.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWFloat insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value number
function Entity:SetNetworked2Float(key,value) end

-- Sets a networked integer (whole number) value on the entity.The value can then be accessed with Entity:GetNetworked2Int both from client and server.See Entity:SetNW2Float for numbers that aren't integers.You should be using Entity:SetNW2Int instead.The value will only be updated clientside if the entity is or enters the clients PVS.The integer has a 32 bit limit. Use Entity:SetNWInt insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value number
function Entity:SetNetworked2Int(key,value) end

-- Sets a networked string value on the entity.The value can then be accessed with Entity:GetNetworked2String both from client and server.You should be using Entity:SetNW2String instead.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWString insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value string
function Entity:SetNetworked2String(key,value) end

-- Sets a networked value on the entity.The value can then be accessed with Entity:GetNetworked2Var both from client and server.| Allowed Types   || --------------- || Angle           || Boolean         || Entity          || Float           || Int             || String          || Vector          |You should be using Entity:SetNW2Var instead.Trying to network a type that is not listed above leads to the value not being networked!Running this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only ne networked once and not every 10 seconds.
---@param key string
---@param value any
function Entity:SetNetworked2Var(key,value) end

-- Sets a function to be called when the NW2Var changes. Internally uses GM:EntityNetworkedVarChanged to call the function.Only one NW2VarProxy can be set per-varRunning this function clientside will only set it for the client it is called on.
---@param name string
---@param callback function
function Entity:SetNetworked2VarProxy(name,callback) end

-- Sets a networked vector value on the entity.The value can then be accessed with Entity:GetNetworked2Vector both from client and server.You should be using Entity:SetNW2Vector instead.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWVector insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Vector
function Entity:SetNetworked2Vector(key,value) end

-- You should use Entity:SetNWAngle instead.Sets a networked angle value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedAngle both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value Angle
function Entity:SetNetworkedAngle(key,value) end

-- You should use Entity:SetNWBool instead.Sets a networked boolean value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedBool both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value boolean
function Entity:SetNetworkedBool(key,value) end

-- You should use Entity:SetNWEntity instead.Sets a networked entity value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedEntity both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value Entity
function Entity:SetNetworkedEntity(key,value) end

-- You should use Entity:SetNWFloat instead.Sets a networked float value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedFloat both from client and server.Seems to be the same as Entity:GetNetworkedInt.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value number
function Entity:SetNetworkedFloat(key,value) end

-- You should use Entity:SetNWInt instead.Sets a networked integer value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedInt both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value number
function Entity:SetNetworkedInt(key,value) end

-- You should be using Entity:SetNWFloat instead.Sets a networked number at the specified index on the entity.
---@param index any
---@param number number
function Entity:SetNetworkedNumber(index,number) end

-- You should use Entity:SetNWString instead.Sets a networked string value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedString both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value string
function Entity:SetNetworkedString(key,value) end

-- Sets a networked value on the entity.The value can then be accessed with Entity:GetNetworkedVar both from client and server.| Allowed Types   || --------------- || Angle           || Boolean         || Entity          || Float           || Int             || String          || Vector          |Trying to network a type that is not listed above leads to the value not being networked!the value will only be updated clientside if the entity is or enters the clients PVS.Running this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value any
function Entity:SetNetworkedVar(key,value) end

-- You should be using Entity:SetNWVarProxy instead.Sets callback function to be called when given NWVar changes.
---@param name string
---@param callback function
function Entity:SetNetworkedVarProxy(name,callback) end

-- You should use Entity:SetNWVector instead.Sets a networked vector value at specified index on the entity.The value then can be accessed with Entity:GetNetworkedVector both from client and server.Running this function clientside will only set it clientside for the client it is called on.
---@param key string
---@param value Vector
function Entity:SetNetworkedVector(key,value) end

-- Virtually changes entity position for clients. Does the same thing as Entity:SetPos when used serverside.
---@param origin Vector
function Entity:SetNetworkOrigin(origin) end

-- Sets the next time the clientside ENTITY:Think is called.
---@param nextthink number
function Entity:SetNextClientThink(nextthink) end

-- Sets if the entity's model should render at all.If set on the server, this entity will no longer network to clients, and for all intents and purposes cease to exist clientside.
---@param shouldNotDraw boolean
function Entity:SetNoDraw(shouldNotDraw) end

-- Sets whether the entity is solid or not.
---@param IsNotSolid boolean
function Entity:SetNotSolid(IsNotSolid) end

-- Sets a networked angle value on the entity.The value can then be accessed with Entity:GetNW2Angle both from client and server.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWAngle insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Angle
function Entity:SetNW2Angle(key,value) end

-- Sets a networked boolean value on the entity.The value can then be accessed with Entity:GetNW2Bool both from client and server.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWBool insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value boolean
function Entity:SetNW2Bool(key,value) end

-- Sets a networked entity value on the entity.The value can then be accessed with Entity:GetNW2Entity both from client and server.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWEntity insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Entity
function Entity:SetNW2Entity(key,value) end

-- Sets a networked float (number) value on the entity.The value can then be accessed with Entity:GetNW2Float both from client and server.Unlike Entity:SetNW2Int, floats don't have to be whole numbers.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWFloat insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value number
function Entity:SetNW2Float(key,value) end

-- Sets a networked integer (whole number) value on the entity.The value can then be accessed with Entity:GetNW2Int both from client and server.See Entity:SetNW2Float for numbers that aren't integers.The value will only be updated clientside if the entity is or enters the clients PVS.The integer has a 32 bit limit. Use Entity:SetNWInt insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value number
function Entity:SetNW2Int(key,value) end

-- Sets a networked string value on the entity.The value can then be accessed with Entity:GetNW2String both from client and server.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWString insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value string
function Entity:SetNW2String(key,value) end

-- Sets a networked value on the entity.The value can then be accessed with Entity:GetNW2Var both from client and server.| Allowed Types   || --------------- || Angle           || Boolean         || Entity          || Float           || Int             || String          || Vector          |Trying to network a type that is not listed above leads to the value not being networked!the value will only be updated clientside if the entity is or enters the clients PVS.Running this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value any
function Entity:SetNW2Var(key,value) end

-- Sets a function to be called when the NW2Var changes. Internally uses GM:EntityNetworkedVarChanged to call the function.Alias of Entity:SetNetworked2VarProxyOnly one NW2VarProxy can be set per-varRunning this function will only set it for the realm it is called on.
---@param key any
---@param callback function
function Entity:SetNW2VarProxy(key,callback) end

-- Sets a networked vector value on the entity.The value can then be accessed with Entity:GetNW2Vector both from client and server.The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWVector insteadRunning this function clientside will only set it for the client it is called on.The value will only be networked if it isn't the same as the current value and unlike SetNW*the value will only be networked once and not every 10 seconds.
---@param key string
---@param value Vector
function Entity:SetNW2Vector(key,value) end

-- Sets a networked angle value on the entity.The value can then be accessed with Entity:GetNWAngle both from client and server.There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Angle. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value Angle
function Entity:SetNWAngle(key,value) end

-- Sets a networked boolean value on the entity.The value can then be accessed with Entity:GetNWBool both from client and server.There's a 4096 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Bool. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value boolean
function Entity:SetNWBool(key,value) end

-- Sets a networked entity value on the entity.The value can then be accessed with Entity:GetNWEntity both from client and server.There's a 4096 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Entity. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value Entity
function Entity:SetNWEntity(key,value) end

-- Sets a networked float (number) value on the entity.The value can then be accessed with Entity:GetNWFloat both from client and server.Unlike Entity:SetNWInt, floats don't have to be whole numbers.There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Float. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value number
function Entity:SetNWFloat(key,value) end

-- Sets a networked integer (whole number) value on the entity.The value can then be accessed with Entity:GetNWInt both from client and server.See Entity:SetNWFloat for numbers that aren't integers.There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Int. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.This function will not round decimal values as it actually networks a float internally.
---@param key string
---@param value number
function Entity:SetNWInt(key,value) end

-- Sets a networked string value on the entity.The value can then be accessed with Entity:GetNWString both from client and server.There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2String. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value string
function Entity:SetNWString(key,value) end

-- Only one NWVarProxy can be set per-varRunning this function will only set it for the realm it is called on.Sets a function to be called when the NWVar changes.
---@param key any
---@param callback function
function Entity:SetNWVarProxy(key,callback) end

-- Sets a networked vector value on the entity.The value can then be accessed with Entity:GetNWVector both from client and server.There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Vector. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_UsageRunning this function clientside will only set it for the client it is called on.
---@param key string
---@param value Vector
function Entity:SetNWVector(key,value) end

-- Sets the owner of this entity, disabling all physics interaction with it.This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.
---@param owner Entity
function Entity:SetOwner(owner) end

-- Sets the parent of this entity, making it move with its parent. This will make the child entity non solid, nothing can interact with them, including traces.This does not work on game.GetWorld.This can cause undefined physics behaviour when used on entities that don't support parenting. See the [Valve developer wiki](https://developer.valvesoftware.com/wiki/Entity_Hierarchy_(parenting)) for more information.
---@param parent Entity
---@param attachmentId number
function Entity:SetParent(parent,attachmentId) end

-- Sets the parent of an entity to another entity with the given physics bone number. Similar to Entity:SetParent, except it is parented to a physbone. This function is useful mainly for ragdolls.Despite this function being available server side, it doesn't actually do anything server side.
---@param bone number
function Entity:SetParentPhysNum(bone) end

-- Sets whether or not the given entity is persistent. A persistent entity will be saved on server shutdown and loaded back when the server starts up. Additionally, by default persistent entities cannot be grabbed with the physgun and tools cannot be used on them.In sandbox, this can be set on an entity by opening the context menu, right clicking the entity, and choosing "Make Persistent".Persistence can only be enabled with the sbox_persist convar, which works as an identifier for the current set of persistent entities. An empty identifier (which is the default value) disables this feature.
---@param persist boolean
function Entity:SetPersistent(persist) end

-- When called on a constraint entity, sets the two physics objects to be constrained.Usage is not recommended as the Constraint library provides easier ways to deal with constraints.
---@param Phys1 PhysObj
---@param Phys2 PhysObj
function Entity:SetPhysConstraintObjects(Phys1,Phys2) end

-- Sets the player who gets credit if this entity kills something with physics damage within the time limit.This can only be called on props, "anim" type SENTs and vehicles.
---@param ent Player
---@param timeLimit number
function Entity:SetPhysicsAttacker(ent,timeLimit) end

-- Allows you to set how fast an entity's animation will play, with 1.0 being the default speed.
---@param fSpeed number
function Entity:SetPlaybackRate(fSpeed) end

-- Moves the entity to the specified position.If the new position doesn't take effect right away, you can use Entity:SetupBones to force it to do so. This issue is especially common when trying to render the same entity twice or more in a single frame at different positions.Entities with Entity:GetSolid of SOLID_BBOX will have their angles reset!This will fail inside of predicted functions called during player movement processing. This includes WEAPON:PrimaryAttack and WEAPON:Think.Some entities, such as ragdolls, will appear unaffected by this function in the next frame. Consider PhysObj:SetPos if necessary.
---@param position Vector
function Entity:SetPos(position) end

-- Sets the specified pose parameter to the specified value.You should call Entity:InvalidateBoneCache after calling this function.Avoid calling this in draw hooks, especially when animating things, as it might cause visual artifacts.
---@param poseName string
---@param poseValue number
function Entity:SetPoseParameter(poseName,poseValue) end

-- Sets whether an entity should be predictable or not.When an entity is set as predictable, its DT vars can be changed during predicted hooks. This is useful for entities which can be controlled by player input.Any datatable value that mismatches from the server will be overridden and a prediction error will be spewed.Weapons are predictable by default, and the drive system uses this function to make the controlled prop predictable as well.Visit  for a list of all predicted hooks, and the Prediction page.For further technical information on the subject, visit [valve's wiki](https://developer.valvesoftware.com/wiki/Prediction).This function resets the datatable variables everytime it's called, it should ideally be called when a player starts using the entity and when he stopsEntities set as predictable with this function will be unmarked when the user lags and receives a full packet update, to handle such case visit GM:NotifyShouldTransmit
---@param setPredictable boolean
function Entity:SetPredictable(setPredictable) end

-- Prevents the server from sending any further information about the entity to a player.You must also call this function on a player's children if you would like to prevent transmission for players. See Entity:GetChildren.This does not work for nextbots unless you recursively loop their children and update them too.When using this function, Entity:SetFlexScale will conflict with this function. Instead, consider using Entity:SetFlexScale on the client.
---@param player Player
---@param stopTransmitting boolean
function Entity:SetPreventTransmit(player,stopTransmitting) end

-- Sets the bone angles. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
---@param boneid number
---@param pos Angle
function Entity:SetRagdollAng(boneid,pos) end

-- Sets the function to build the ragdoll. This is used alongside Kinect, for more info see ragdoll_motion entity.
---@param func function
function Entity:SetRagdollBuildFunction(func) end

-- Sets the bone position. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
---@param boneid number
---@param pos Vector
function Entity:SetRagdollPos(boneid,pos) end

-- Sets the render angles of the Entity.
---@param newAngles Angle
function Entity:SetRenderAngles(newAngles) end

-- Sets the render bounds for the entity. For world space coordinates see Entity:SetRenderBoundsWS.
---@param mins Vector
---@param maxs Vector
---@param add Vector
function Entity:SetRenderBounds(mins,maxs,add) end

-- Sets the render bounds for the entity in world space coordinates. For relative coordinates see Entity:SetRenderBounds.
---@param mins Vector
---@param maxs Vector
---@param add Vector
function Entity:SetRenderBoundsWS(mins,maxs,add) end

-- Used to specify a plane, past which an object will be visually clipped.
---@param planeNormal Vector
---@param planePosition number
function Entity:SetRenderClipPlane(planeNormal,planePosition) end

-- Enables the use of clipping planes to "cut" objects.
---@param enabled boolean
function Entity:SetRenderClipPlaneEnabled(enabled) end

-- Sets entity's render FX.
---@param renderFX number
function Entity:SetRenderFX(renderFX) end

-- Sets the render mode of the entity.
---@param renderMode number
function Entity:SetRenderMode(renderMode) end

-- Set the origin in which the Entity will be drawn from.
---@param newOrigin Vector
function Entity:SetRenderOrigin(newOrigin) end

-- Sets a save value for an entity. You can see a full list of an entity's save values by creating it and printing Entity:GetSaveTable().See Entity:GetInternalVariable for the opposite of this function.This does not type-check entity keys. Setting an entity key to a non-entity value will treat it as NULL.
---@param name string
---@param value any
function Entity:SetSaveValue(name,value) end

-- Sets the entity's model sequence.If the specified sequence is already active, the animation will not be restarted. See Entity:ResetSequence for a function that restarts the animation even if it is already playing.In some cases you want to run Entity:ResetSequenceInfo to make this function run.This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick.Will not work on players due to the animations being reset every frame by the base gamemode animation system. See GM:CalcMainActivity.For custom scripted entities you will want to apply example from ENTITY:Think to make animations work.
---@param sequenceId number
function Entity:SetSequence(sequenceId) end

-- Sets whether or not the entity should make a physics contact sound when it's been picked up by a player.
---@param playsound boolean
function Entity:SetShouldPlayPickupSound(playsound) end

-- Sets if entity should create a server ragdoll on death or a client one.Player ragdolls created with this enabled will have an owner set, see Entity:SetOwner for more information on what effects this has.This is reset for players when they respawn (Entity:Spawn).
---@param serverragdoll boolean
function Entity:SetShouldServerRagdoll(serverragdoll) end

-- Sets the skin of the entity.
---@param skinIndex number
function Entity:SetSkin(skinIndex) end

-- Sets the solidity of an entity.
---@param solid_type number
function Entity:SetSolid(solid_type) end

-- Sets solid flag(s) for the entity.This overrides any other flags the entity might have had. See Entity:AddSolidFlags for adding flags.
---@param flags number
function Entity:SetSolidFlags(flags) end

-- Sets whether the entity should use a spawn effect when it is created on the client.See Entity:GetSpawnEffect for more information on how the effect is applied.This function will only have an effect when the entity spawns. After that it will do nothing even is set to true.
---@param spawnEffect boolean
function Entity:SetSpawnEffect(spawnEffect) end

-- Overrides a single material on the model of this entity.To set a Lua material created with Global.CreateMaterial, just prepend a "!" to the material name.The server's value takes priority on the client.
---@param index number
---@param material string
function Entity:SetSubMaterial(index,material) end

-- Sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.See also Entity:SetSurroundingBoundsType (mutually exclusive).
---@param min Vector
---@param max Vector
function Entity:SetSurroundingBounds(min,max) end

-- Automatically sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.See also Entity:SetSurroundingBounds (mutually exclusive).
---@param bounds number
function Entity:SetSurroundingBoundsType(bounds) end

-- Changes the table that can be accessed by indexing an entity. Each entity starts with its own table by default.
---@param tab table
function Entity:SetTable(tab) end

-- When this flag is set the entity will only transmit to the player when its parent is transmitted. This is useful for things like viewmodel attachments since without this flag they will transmit to everyone (and cause the viewmodels to transmit to everyone too).In the case of scripted entities, this will override ENTITY:UpdateTransmitState
---@param onoff boolean
function Entity:SetTransmitWithParent(onoff) end

-- Marks the entity as a trigger, so it will generate ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch callbacks.Internally this is stored as Enums/FSOLID flag.
---@param maketrigger boolean
function Entity:SetTrigger(maketrigger) end

-- Sets whether an entity can be unfrozen, meaning that it cannot be unfrozen using the physgun.
---@param freezable boolean
function Entity:SetUnFreezable(freezable) end

-- Forces the entity to reconfigure its bones. You might need to call this after changing your model's scales or when manually drawing the entity multiple times at different positions.This calls the BuildBonePositions callback added via Entity:AddCallback, so avoid calling this function inside it to prevent an infinite loop.
function Entity:SetupBones() end

-- Initializes the class names of an entity's phoneme mappings (mouth movement data). This is called by default with argument "phonemes" when a flex-based entity (such as an NPC) is created.TF2 phonemes can be accessed by using a path such as "player/scout/phonemes/phonemes" , check TF2's "tf2_misc_dir.vpk" with GCFScape for other paths, however it seems that TF2 sounds don't contain phoneme definitions anymore after being converted to mp3 and only rely on VCD animations, this needs to be further investigated
---@param fileRoot string
function Entity:SetupPhonemeMappings(fileRoot) end

-- Sets the use type of an entity, affecting how often ENTITY:Use will be called for Lua entities.
---@param useType number
function Entity:SetUseType(useType) end

-- Allows to quickly set variable to entity's Entity:GetTable.This will not network the variable to client(s). You want Entity:SetNWString and similar functions for that
---@param key any
---@param value any
function Entity:SetVar(key,value) end

-- Sets the entity's velocity. For entities with physics, consider using PhysObj:SetVelocity on the PhysObj of the entity.Actually binds to CBaseEntity::SetBaseVelocity() which sets the entity's velocity due to forces applied by other entities.If applied to a player, this will actually **ADD** velocity, not set it.
---@param velocity Vector
function Entity:SetVelocity(velocity) end

-- Sets the model and associated weapon to this viewmodel entity.This is used internally when the player switches weapon.View models are not drawn without a weapons associated to them.This will silently fail if the entity is not a viewmodel.
---@param viewModel string
---@param weapon Weapon
function Entity:SetWeaponModel(viewModel,weapon) end

-- Returns the amount of skins the entity has.
function Entity:SkinCount() end

-- Moves the model instance from the source entity to this entity. This can be used to transfer decals that have been applied on one entity to another.Both entities must have the same model.
---@param srcEntity Entity
function Entity:SnatchModelInstance(srcEntity) end

-- Initializes the entity and starts its networking. If called on a player, it will respawn them.This calls ENTITY:Initialize on Lua-defined entities.
function Entity:Spawn() end

-- Starts a "looping" sound. As with any other sound playing methods, this function expects the sound file to be looping itself and will not automatically loop a non looping sound file as one might expect.This function is almost identical to Global.CreateSound, with the exception of the sound being created in the STATIC channel and with normal attenuation.See also Entity:StopLoopingSound
---@param sound string
function Entity:StartLoopingSound(sound) end

-- Starts a motion controller in the physics engine tied to this entity's PhysObj, which enables the use of ENTITY:PhysicsSimulate.The motion controller can later be destroyed via Entity:StopMotionController.Motion controllers are used internally to control other Entities' PhysObjects, such as the Gravity Gun, +use pickup and the Physics Gun.This function should be called every time you recreate the Entity's PhysObj. Or alternatively you should call Entity:AddToMotionController on the new PhysObj.Also see Entity:AddToMotionController and Entity:RemoveFromMotionController.Only works on a scripted Entity of anim type.
function Entity:StartMotionController() end

-- Stops all particle effects parented to the entity and immediately destroys them.
function Entity:StopAndDestroyParticles() end

-- Stops a sound created by Entity:StartLoopingSound.
---@param id number
function Entity:StopLoopingSound(id) end

-- Stops the motion controller created with Entity:StartMotionController.
function Entity:StopMotionController() end

-- Stops all particle effects parented to the entity.This is ran automatically on every client by Entity:StopParticles if called on the server.
function Entity:StopParticleEmission() end

-- Stops any attached to the entity .pcf particles using Global.ParticleEffectAttach or Global.ParticleEffect.On client, this is the same as Entity:StopParticleEmission. ( and you should use StopParticleEmission instead )On server, this is the same as running Entity:StopParticleEmission on every client.
function Entity:StopParticles() end

-- Stops all particle effects parented to the entity with given name.
---@param name string
function Entity:StopParticlesNamed(name) end

-- Stops all particle effects parented to the entity with given name on given attachment.
---@param name string
---@param attachment number
function Entity:StopParticlesWithNameAndAttachment(name,attachment) end

-- Stops emitting the given sound from the entity, especially useful for looping sounds.
---@param sound string
function Entity:StopSound(sound) end

-- Applies the specified amount of damage to the entity with Enums/DMG flag.Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.This function does not seem to do any damage if you apply it to a player who is into a vehicle.
---@param damageAmount number
---@param attacker Entity
---@param inflictor Entity
function Entity:TakeDamage(damageAmount,attacker,inflictor) end

-- Applies the damage specified by the damage info to the entity.This function will not deal damage to a player inside a vehicle. You need to call it on the vehicle instead.Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
---@param damageInfo CTakeDamageInfo
function Entity:TakeDamageInfo(damageInfo) end

-- Applies forces to our physics object in response to damage.
---@param dmginfo CTakeDamageInfo
function Entity:TakePhysicsDamage(dmginfo) end

-- Check if the given position or entity is within this entity's PVS.See also Entity:IsDormant.The function won't take in to account Global.AddOriginToPVS and the like.
---@param testPoint any
function Entity:TestPVS(testPoint) end

-- Returns the ID of a PhysObj attached to the given bone. To be used with Entity:GetPhysicsObjectNum.See Entity:TranslatePhysBoneToBone for reverse function.
---@param boneID number
function Entity:TranslateBoneToPhysBone(boneID) end

-- Returns the boneID of the bone the given PhysObj is attached to.See Entity:TranslateBoneToPhysBone for reverse function.
---@param physNum number
function Entity:TranslatePhysBoneToBone(physNum) end

-- Updates positions of bone followers created by Entity:CreateBoneFollowers.This should be called every tick.This function only works on `anim` type entities.
function Entity:UpdateBoneFollowers() end

-- Simulates a `+use` action on an entity.
---@param activator Entity
---@param caller Entity
---@param useType number
---@param value number
function Entity:Use(activator,caller,useType,value) end

-- Does nothing on server.Animations will be handled purely clientside instead of a fixed animtime, enabling interpolation. This does not affect layers and gestures.
function Entity:UseClientSideAnimation() end

-- Enables or disables trigger bounds.This will give the entity a "trigger box" that extends around its bounding box by boundSize units in X/Y and (boundSize / 2) in +Z (-Z remains the same).The trigger box is world aligned and will work regardless of the object's solidity and collision group.Valve use trigger boxes for all pickup items. Their bloat size is 24, a surprisingly large figure.The trigger boxes can be made visible as a light blue box by using the **ent_bbox** console command while looking at the entity. Alternatively a classname or entity index can be used as the first argument.This requires **developer** to be set to **1**.
---@param enable boolean
---@param boundSize number
function Entity:UseTriggerBounds(enable,boundSize) end

-- Returns the index of this view model, it can be used to identify which one of the player's view models this entity is.
function Entity:ViewModelIndex() end

-- Returns whether the target/given entity is visible from the this entity.This is meant to be used only with NPCs.Differences from a simple trace include:* If target has **FL_NOTARGET**, returns false* If **ai_ignoreplayers** is turned on and target is a player, returns false* Reacts to **ai_LOS_mode**:* * If 1, does a simple trace with **COLLISION_GROUP_NONE** and **MASK_BLOCKLOS*** * If not, does a trace with **MASK_BLOCKLOS_AND_NPCS** ( - **CONTENTS_BLOCKLOS** is target is player ) and a custom LOS filter ( **CTraceFilterLOS** )* Returns true if hits a vehicle the target is driving
---@param target Entity
function Entity:Visible(target) end

-- Returns true if supplied vector is visible from the entity's line of sight.This is achieved similarly to a trace.
---@param pos Vector
function Entity:VisibleVec(pos) end

-- Returns an integer that represents how deep in water the entity is.This function will currently work on players only due to the way it is implemented in the engine. If you need to check interaction with water for regular entities you better use util.PointContents.* **0** - The entity isn't in water.* **1** - Slightly submerged (at least to the feet).* **2** - The majority of the entity is submerged (at least to the waist).* **3** - Completely submerged.
function Entity:WaterLevel() end

-- Sets the activity of the entity's active weapon.This does nothing on the client.Only works for CBaseCombatCharacter entities, which includes players and NPCs.
---@param act number
---@param duration number
function Entity:Weapon_SetActivity(act,duration) end

-- Calls and returns WEAPON:TranslateActivity on the weapon the entity ( player or NPC ) carries.Despite existing on client, it doesn't actually do anything on client.
---@param act number
function Entity:Weapon_TranslateActivity(act) end

-- Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box (which is calculated from entity's collision bounds.
function Entity:WorldSpaceAABB() end

-- Returns the center of the entity according to its collision model.
function Entity:WorldSpaceCenter() end

-- Converts a worldspace vector into a vector local to an entity
---@param wpos Vector
function Entity:WorldToLocal(wpos) end

-- Converts world angles to local angles ( local to the entity )
---@param ang Angle
function Entity:WorldToLocalAngles(ang) end



---@class ENTITY
ENTITY = ENTITY

-- Called to override the preferred carry angles of this object.This callback is only called for `anim` type entities.
---@param ply Player
function ENTITY:GetPreferredCarryAngles(ply) end

-- Sets the NPC max yaw speed. Internally sets the `m_fMaxYawSpeed` variable which is polled by the engine.This is a helper function only available if your SENT is based on `base_ai`
---@param maxyaw number
function ENTITY:SetMaxYawSpeed(maxyaw) end

-- Sets the NPC classification. Internally sets the `m_iClass` variable which is polled by the engine.This is a helper function only available if your SENT is based on `base_ai`
---@param classification number
function ENTITY:SetNPCClass(classification) end



---@class File
File = File

-- Dumps the file changes to disk and closes the file handle which makes the handle useless.
function File:Close() end

-- Returns whether the File object has reached the end of file or not.
function File:EndOfFile() end

-- Dumps the file changes to disk and saves the file.
function File:Flush() end

-- Reads the specified amount of chars and returns them as a binary string.
---@param length number
function File:Read(length) end

-- Reads one byte of the file and returns whether that byte was not 0.
function File:ReadBool() end

-- Reads one unsigned 8-bit integer from the file.
function File:ReadByte() end

-- Reads an 8-byte little-endian IEEE-754 floating point double from the file.
function File:ReadDouble() end

-- Reads an IEEE 754 little-endian 4-byte float from the file.
function File:ReadFloat() end

-- Returns the contents of the file from the current position up until the end of the current line.This function will look specifically for `Line Feed` characters `\n` and will **completely ignore `Carriage Return` characters** `\r`.This function will not return more than 8192 characters. The return value will include the `\n` character.
function File:ReadLine() end

-- Reads a signed little-endian 32-bit integer from the file.
function File:ReadLong() end

-- Reads a signed little-endian 16-bit integer from the file.
function File:ReadShort() end

-- Reads an unsigned little-endian 32-bit integer from the file.
function File:ReadULong() end

-- Reads an unsigned little-endian 16-bit integer from the file.
function File:ReadUShort() end

-- Sets the file pointer to the specified position.
---@param pos number
function File:Seek(pos) end

-- Returns the size of the file in bytes.
function File:Size() end

-- Moves the file pointer by the specified amount of chars.
---@param amount number
function File:Skip(amount) end

-- Returns the current position of the file pointer.
function File:Tell() end

-- Writes the given string into the file.
---@param data string
function File:Write(data) end

-- Writes a boolean value to the file as one **byte**.
---@param bool boolean
function File:WriteBool(bool) end

-- Write an 8-bit unsigned integer to the file.
---@param uint8 number
function File:WriteByte(uint8) end

-- Writes an 8-byte little-endian IEEE-754 floating point double to the file.
---@param double number
function File:WriteDouble(double) end

-- Writes an IEEE 754 little-endian 4-byte float to the file.
---@param float number
function File:WriteFloat(float) end

-- Writes a signed little-endian 32-bit integer to the file.
---@param int32 number
function File:WriteLong(int32) end

-- Writes a signed little-endian 16-bit integer to the file.
---@param int16 number
function File:WriteShort(int16) end

-- Writes an unsigned little-endian 32-bit integer to the file.
---@param uint32 number
function File:WriteULong(uint32) end

-- Writes an unsigned little-endian 16-bit integer to the file.
---@param uint16 number
function File:WriteUShort(uint16) end



---@class IGModAudioChannel
IGModAudioChannel = IGModAudioChannel

-- Enables or disables looping of audio channel, requires noblock flag.
---@param enable boolean
function IGModAudioChannel:EnableLooping(enable) end

-- Computes the [DFT (discrete Fourier transform)](https://en.wikipedia.org/wiki/Discrete_Fourier_transform) of the sound channel.The size parameter specifies the number of consecutive audio samples to use as the input to the DFT and is restricted to a power of two. A [Hann window](https://en.wikipedia.org/wiki/Hann_function) is applied to the input data.The computed DFT has the same number of frequency bins as the number of samples. Only half of this DFT is returned, since [the DFT magnitudes are symmetric for real input data](https://en.wikipedia.org/wiki/Discrete_Fourier_transform#The_real-input_DFT). The magnitudes of the DFT (values from 0 to 1) are used to fill the output table, starting at index 1.**Visualization protip:** For a size N DFT, bin k (1-indexed) corresponds to a frequency of (k - 1) / N * sampleRate.**Visualization protip:** Sound energy is proportional to the square of the magnitudes. Adding magnitudes together makes no sense physically, but adding energies does.**Visualization protip:** The human ear works on a logarithmic amplitude scale. You can convert to [decibels](https://en.wikipedia.org/wiki/Decibel) by taking 20 * math.log10 of frequency magnitudes, or 10 * math.log10 of energy. The decibel values will range from -infinity to 0.
---@param tbl table
---@param size number
function IGModAudioChannel:FFT(tbl,size) end

-- Returns 3D cone of the sound channel. See IGModAudioChannel:Set3DCone.
function IGModAudioChannel:Get3DCone() end

-- Returns if the sound channel is currently in 3D mode or not. This value will be affected by IGModAudioChannel:Set3DEnabled.
function IGModAudioChannel:Get3DEnabled() end

-- Returns 3D fade distances of a sound channel.
function IGModAudioChannel:Get3DFadeDistance() end

-- Returns the average bit rate of the sound channel.
function IGModAudioChannel:GetAverageBitRate() end

-- Retrieves the number of bits per sample of the sound channel.Doesn't work for mp3 and ogg files.
function IGModAudioChannel:GetBitsPerSample() end

-- Returns the filename for the sound channel.
function IGModAudioChannel:GetFileName() end

-- Returns the length of sound played by the sound channel.
function IGModAudioChannel:GetLength() end

-- Returns the right and left levels of sound played by the sound channel.
function IGModAudioChannel:GetLevel() end

-- Gets the relative volume of the left and right channels.
function IGModAudioChannel:GetPan() end

-- Returns the playback rate of the sound channel.
function IGModAudioChannel:GetPlaybackRate() end

-- Returns position of the sound channel
function IGModAudioChannel:GetPos() end

-- Returns the sample rate for currently playing sound.
function IGModAudioChannel:GetSamplingRate() end

-- Returns the state of a sound channel
function IGModAudioChannel:GetState() end

-- Retrieves HTTP headers from a bass stream channel created by sound.PlayURL, if available.
function IGModAudioChannel:GetTagsHTTP() end

-- Retrieves the ID3 version 1 info from a bass channel created by sound.PlayFile or sound.PlayURL, if available.ID3v2 is not supported.
function IGModAudioChannel:GetTagsID3() end

-- Retrieves meta stream info from a bass stream channel created by sound.PlayURL, if available.
function IGModAudioChannel:GetTagsMeta() end

-- Retrieves OGG media info tag, from a bass channel created by sound.PlayURL or sound.PlayFile, if available.
function IGModAudioChannel:GetTagsOGG() end

-- Retrieves OGG Vendor tag, usually containing the application that created the file, from a bass channel created by sound.PlayURL or sound.PlayFile, if available.
function IGModAudioChannel:GetTagsVendor() end

-- Returns the current time of the sound channel in seconds
function IGModAudioChannel:GetTime() end

-- Returns volume of a sound channel
function IGModAudioChannel:GetVolume() end

-- Returns if the sound channel is in 3D mode or not.
function IGModAudioChannel:Is3D() end

-- Returns whether the audio stream is block streamed or not.
function IGModAudioChannel:IsBlockStreamed() end

-- Returns if the sound channel is looping or not.
function IGModAudioChannel:IsLooping() end

-- Returns if the sound channel is streamed from the Internet or not.
function IGModAudioChannel:IsOnline() end

-- Returns if the sound channel is valid or not.
function IGModAudioChannel:IsValid() end

-- Pauses the stream. It can be started again using IGModAudioChannel:Play
function IGModAudioChannel:Pause() end

-- Starts playing the stream.
function IGModAudioChannel:Play() end

-- Sets 3D cone of the sound channel.
---@param innerAngle number
---@param outerAngle number
---@param outerVolume number
function IGModAudioChannel:Set3DCone(innerAngle,outerAngle,outerVolume) end

-- Sets the 3D mode of the channel. This will affect IGModAudioChannel:Get3DEnabled but not IGModAudioChannel:Is3D.This feature **requires** the channel to be initially created in 3D mode, i.e. IGModAudioChannel:Is3D should return true or this function will do nothing.
---@param enable boolean
function IGModAudioChannel:Set3DEnabled(enable) end

-- Sets 3D fade distances of a sound channel.
---@param min number
---@param max number
function IGModAudioChannel:Set3DFadeDistance(min,max) end

-- Sets the relative volume of the left and right channels.
---@param pan number
function IGModAudioChannel:SetPan(pan) end

-- Sets the playback rate of the sound channel. May not work with high values for radio streams.
---@param rate number
function IGModAudioChannel:SetPlaybackRate(rate) end

-- Sets position of sound channel in case the sound channel has a 3d option set.
---@param pos Vector
---@param dir Vector
function IGModAudioChannel:SetPos(pos,dir) end

-- Sets the sound channel to specified time ( Rewind to that position of the song ). Does not work on online radio streams.Streamed sounds must have "noblock" parameter for this to work and IGModAudioChannel:IsBlockStreamed must return false.
---@param secs number
---@param dont_decode boolean
function IGModAudioChannel:SetTime(secs,dont_decode) end

-- Sets the volume of a sound channel
---@param volume number
function IGModAudioChannel:SetVolume(volume) end

-- Stop the stream. It can be started again using IGModAudioChannel:Play.Calling this invalidates the IGModAudioChannel object rendering it unusable for further functions.
function IGModAudioChannel:Stop() end



---@class IMaterial
IMaterial = IMaterial

-- Returns the color of the specified pixel of the $basetexture, only works for materials created from PNG files.Basically identical to ITexture:GetColor used on IMaterial:GetTexture( "$basetexture" ).The returned color will not have the color metatable.
---@param x number
---@param y number
function IMaterial:GetColor(x,y) end

-- Returns the specified material value as a float, or nil if the value is not set.
---@param materialFloat string
function IMaterial:GetFloat(materialFloat) end

-- Returns the specified material value as a int, rounds the value if its a float, or nil if the value is not set.Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly retrieved with this function. See the full list here: Material Flags
---@param materialInt string
function IMaterial:GetInt(materialInt) end

-- Gets all the key values defined for the material.
function IMaterial:GetKeyValues() end

-- Returns the specified material matrix as a int, or nil if the value is not set or is not a matrix.
---@param materialMatrix string
function IMaterial:GetMatrix(materialMatrix) end

-- Returns the name of the material, in most cases the path.
function IMaterial:GetName() end

-- Returns the name of the materials shader.This function does not work serverside on Linux SRCDS.
function IMaterial:GetShader() end

-- Returns the specified material string, or nil if the value is not set or if the value can not be converted to a string.
---@param materialString string
function IMaterial:GetString(materialString) end

-- Returns an ITexture based on the passed shader parameter.
---@param param string
function IMaterial:GetTexture(param) end

-- Returns the specified material vector, or nil if the value is not set.See also IMaterial:GetVectorLinear
---@param materialVector string
function IMaterial:GetVector(materialVector) end

-- Returns the specified material vector as a 4 component vector.
---@param name string
function IMaterial:GetVector4D(name) end

-- Returns the specified material linear color vector, or nil if the value is not set.See https://en.wikipedia.org/wiki/Gamma_correctionSee also IMaterial:GetVector
---@param materialVector string
function IMaterial:GetVectorLinear(materialVector) end

-- Returns the height of the member texture set for $basetexture.
function IMaterial:Height() end

-- Returns whenever the material is valid, i.e. whether it was not loaded successfully from disk or not.
function IMaterial:IsError() end

-- Recomputes the material's snapshot. This needs to be called if you have changed variables on your material and it isn't changing.Be careful though - this function is slow - so try to call it only when needed!
function IMaterial:Recompute() end

-- Changes the Material into the give Image.This is used by the Background to change the Image.
---@param path string
function IMaterial:SetDynamicImage(path) end

-- Sets the specified material float to the specified float, does nothing on a type mismatch.
---@param materialFloat string
---@param float number
function IMaterial:SetFloat(materialFloat,float) end

-- Sets the specified material value to the specified int, does nothing on a type mismatch.Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly set with this function. See the full list here: Material Flags
---@param materialInt string
---@param int number
function IMaterial:SetInt(materialInt,int) end

-- Sets the specified material value to the specified matrix, does nothing on a type mismatch.
---@param materialMatrix string
---@param matrix VMatrix
function IMaterial:SetMatrix(materialMatrix,matrix) end

-- This function does nothingThe functionality of this function was removed due to the amount of crashes it caused.
---@param shaderName string
function IMaterial:SetShader(shaderName) end

-- Sets the specified material value to the specified string, does nothing on a type mismatch.
---@param materialString string
---@param string string
function IMaterial:SetString(materialString,string) end

-- Sets the specified material texture to the specified texture, does nothing on a type mismatch.
---@param materialTexture string
---@param texture ITexture
function IMaterial:SetTexture(materialTexture,texture) end

-- Unsets the value for the specified material value.
---@param materialValueName string
function IMaterial:SetUndefined(materialValueName) end

-- Sets the specified material vector to the specified vector, does nothing on a type mismatch.
---@param MaterialVector string
---@param vec Vector
function IMaterial:SetVector(MaterialVector,vec) end

-- Sets the specified material vector to the specified 4 component vector, does nothing on a type mismatch.
---@param name string
---@param x number
---@param y number
---@param z number
---@param w number
function IMaterial:SetVector4D(name,x,y,z,w) end

-- Returns the width of the member texture set for $basetexture.
function IMaterial:Width() end



---@class IMesh
IMesh = IMesh

-- Builds the mesh from a table mesh vertexes.See Global.Mesh and util.GetModelMeshes for examples.
---@param vertexes table
function IMesh:BuildFromTriangles(vertexes) end

-- Deletes the mesh and frees the memory used by it.
function IMesh:Destroy() end

-- Renders the mesh with the active matrix.
function IMesh:Draw() end

-- Returns whether this IMesh is valid or not.
function IMesh:IsValid() end



---@class IRestore
IRestore = IRestore

-- Ends current data block started with IRestore:StartBlock and returns to the parent block.To avoid all sorts of errors, you **must** end all blocks you start.
function IRestore:EndBlock() end

-- Reads next bytes from the restore object as an Angle.
function IRestore:ReadAngle() end

-- Reads next bytes from the restore object as a boolean.
function IRestore:ReadBool() end

-- Reads next bytes from the restore object as an Entity.
function IRestore:ReadEntity() end

-- Reads next bytes from the restore object as a floating point number.
function IRestore:ReadFloat() end

-- Reads next bytes from the restore object as an integer number.
function IRestore:ReadInt() end

-- Reads next bytes from the restore object as a string.
function IRestore:ReadString() end

-- Reads next bytes from the restore object as a Vector.
function IRestore:ReadVector() end

-- Loads next block of data to be read inside current block. Blocks **must** be ended with IRestore:EndBlock.
function IRestore:StartBlock() end



---@class ISave
ISave = ISave

-- Ends current data block started with ISave:StartBlock and returns to the parent block.To avoid all sorts of errors, you **must** end all blocks you start.
function ISave:EndBlock() end

-- Starts a new block of data that you can write to inside current block. Blocks **must** be ended with ISave:EndBlock.
---@param name string
function ISave:StartBlock(name) end

-- Writes an Angle to the save object.
---@param ang Angle
function ISave:WriteAngle(ang) end

-- Writes a boolean to the save object.
---@param bool boolean
function ISave:WriteBool(bool) end

-- Writes an Entity to the save object.
---@param ent Entity
function ISave:WriteEntity(ent) end

-- Writes a floating point number to the save object.
---@param float number
function ISave:WriteFloat(float) end

-- Writes an integer number to the save object.
---@param int number
function ISave:WriteInt(int) end

-- Writes a **null terminated** string to the save object.
---@param str string
function ISave:WriteString(str) end

-- Writes a Vector to the save object.
---@param vec Vector
function ISave:WriteVector(vec) end



---@class ITexture
ITexture = ITexture

-- Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.
function ITexture:Download() end

-- Returns the color of the specified pixel, only works for textures created from PNG files.The returned color will not have the color metatable.
---@param x number
---@param y number
function ITexture:GetColor(x,y) end

-- Returns the true unmodified height of the texture.
function ITexture:GetMappingHeight() end

-- Returns the true unmodified width of the texture.
function ITexture:GetMappingWidth() end

-- Returns the name of the texture, in most cases the path.
function ITexture:GetName() end

-- Returns the number of animation frames in this texture.
function ITexture:GetNumAnimationFrames() end

-- Returns the modified height of the texture, this value may be affected by mipmapping and other factors.
function ITexture:Height() end

-- Returns whenever the texture is valid. (i.e. was loaded successfully or not)The "error" texture is a valid texture, and therefore this function will return false when used on it. Use ITexture:IsErrorTexture, instead.
function ITexture:IsError() end

-- Returns whenever the texture is the error texture (pink and black checkerboard pattern).
function ITexture:IsErrorTexture() end

-- Returns the modified width of the texture, this value may be affected by mipmapping and other factors.
function ITexture:Width() end



---@class IVideoWriter
IVideoWriter = IVideoWriter

-- Adds the current framebuffer to the video stream.
---@param frameTime number
---@param downsample boolean
function IVideoWriter:AddFrame(frameTime,downsample) end

-- Ends the video recording and dumps it to disk.
function IVideoWriter:Finish() end

-- Returns the height of the video stream.
function IVideoWriter:Height() end

-- Sets whether to record sound or not.
---@param record boolean
function IVideoWriter:SetRecordSound(record) end

-- Returns the width of the video stream.
function IVideoWriter:Width() end



---@class MarkupObject
MarkupObject = MarkupObject

-- Draws the computed markupobject to the screen. See markup.Parse.
---@param xOffset number
---@param yOffset number
---@param xAlign number
---@param yAlign number
---@param alphaoverride number
---@param textAlign number
function MarkupObject:Draw(xOffset,yOffset,xAlign,yAlign,alphaoverride,textAlign) end

-- Gets computed the height of the markupobject.
function MarkupObject:GetHeight() end

-- Gets maximum width for this markup object as defined in markup.Parse.
function MarkupObject:GetMaxWidth() end

-- Gets computed the width of the markupobject.
function MarkupObject:GetWidth() end

-- Gets computed the width and height of the markupobject.
function MarkupObject:Size() end



---@class NextBot
NextBot = NextBot

-- Become a ragdoll and remove the entity.
---@param info CTakeDamageInfo
function NextBot:BecomeRagdoll(info) end

-- Should only be called in NEXTBOT:BodyUpdate. This sets the `move_x` and `move_y` pose parameters of the bot to fit how they're currently moving, sets the animation speed (Entity:GetPlaybackRate) to suit the ground speed, and calls Entity:FrameAdvance.This function might cause crashes with some activities.
function NextBot:BodyMoveXY() end

-- Like NextBot:FindSpots but only returns a vector.
---@param type string
---@param options table
function NextBot:FindSpot(type,options) end

-- Returns a table of hiding spots.
---@param specs table
function NextBot:FindSpots(specs) end

-- Returns the currently running activity
function NextBot:GetActivity() end

-- Returns the Field of View of the Nextbot NPC, used for its vision functionality, such as NextBot:IsAbleToSee.
function NextBot:GetFOV() end

-- Returns the maximum range the nextbot can see other nextbots/players at. See NextBot:IsAbleToSee.
function NextBot:GetMaxVisionRange() end

-- Returns squared distance to an entity or a position.See also NextBot:GetRangeTo.
---@param to Vector
function NextBot:GetRangeSquaredTo(to) end

-- Returns the distance to an entity or position.See also NextBot:GetRangeSquaredTo.
---@param to Vector
function NextBot:GetRangeTo(to) end

-- Returns the solid mask for given NextBot.
function NextBot:GetSolidMask() end

-- Called from Lua when the NPC is stuck. This should only be called from the behaviour coroutine - so if you want to override this function and do something special that yields - then go for it.You should always call self.loco:ClearStuck() in this function to reset the stuck status - so it knows it's unstuck. See CLuaLocomotion:ClearStuck.
function NextBot:HandleStuck() end

-- Returns if the Nextbot NPC can see the give entity or not.Using this function creates the nextbot vision interface which will cause a significant performance hit!
---@param ent Entity
---@param useFOV number
function NextBot:IsAbleToSee(ent,useFOV) end

-- To be called in the behaviour coroutine only! Will yield until the bot has reached the goal or is stuck
---@param pos Vector
---@param options table
function NextBot:MoveToPos(pos,options) end

-- To be called in the behaviour coroutine only! Plays an animation sequence and waits for it to end before returning.
---@param name string
---@param speed number
function NextBot:PlaySequenceAndWait(name,speed) end

-- Sets the Field of View for the Nextbot NPC, used for its vision functionality, such as NextBot:IsAbleToSee.
---@param fov number
function NextBot:SetFOV(fov) end

-- Sets the maximum range the nextbot can see other nextbots/players at. See NextBot:IsAbleToSee.
---@param range number
function NextBot:SetMaxVisionRange(range) end

-- Sets the solid mask for given NextBot.The default solid mask of a NextBot is Enums/MASK.
---@param mask number
function NextBot:SetSolidMask(mask) end

-- Start doing an activity (animation)
---@param activity number
function NextBot:StartActivity(activity) end



---@class NPC
NPC = NPC

-- Makes the NPC like, hate, feel neutral towards, or fear the entity in question. If you want to setup relationship towards a certain entity `class`, use NPC:AddRelationship.NPCs do not see NextBots by default. This can be fixed by adding the Enums/FL flag to the NextBot.
---@param target Entity
---@param disposition number
---@param priority number
function NPC:AddEntityRelationship(target,disposition,priority) end

-- Changes how an NPC feels towards another NPC.  If you want to setup relationship towards a certain `entity`, use NPC:AddEntityRelationship.Avoid using this in GM:OnEntityCreated to prevent crashing due to infinite loops. This function may create an entity with given class and delete it immediately after.
---@param relationstring string
function NPC:AddRelationship(relationstring) end

-- Force an NPC to play their Alert sound.
function NPC:AlertSound() end

-- Executes any movement the current sequence may have.
---@param interval number
---@param target Entity
function NPC:AutoMovement(interval,target) end

-- Adds a capability to the NPC.
---@param capabilities number
function NPC:CapabilitiesAdd(capabilities) end

-- Removes all of Capabilities the NPC has.
function NPC:CapabilitiesClear() end

-- Returns the NPC's capabilities along the ones defined on its weapon.
function NPC:CapabilitiesGet() end

-- Remove a certain capability.
---@param capabilities number
function NPC:CapabilitiesRemove(capabilities) end

-- Returns the NPC class. Do not confuse with Entity:GetClass!
function NPC:Classify() end

-- Resets the NPC:GetBlockingEntity.
function NPC:ClearBlockingEntity() end

-- Clears out the specified Enums/COND on this NPC.
---@param condition number
function NPC:ClearCondition(condition) end

-- Clears the Enemy from the NPC's memory, effectively forgetting it until met again with either the NPC vision or with NPC:UpdateEnemyMemory.
---@param enemy Entity
function NPC:ClearEnemyMemory(enemy) end

-- Clears the NPC's current expression which can be set with NPC:SetExpression.
function NPC:ClearExpression() end

-- Clears the current NPC goal or target.
function NPC:ClearGoal() end

-- Stops the current schedule that the NPC is doing.
function NPC:ClearSchedule() end

-- Translates condition ID to a string.
---@param cond number
function NPC:ConditionName(cond) end

-- Returns the way the NPC "feels" about the entity.
---@param ent Entity
function NPC:Disposition(ent) end

-- Forces the NPC to drop the specified weapon.
---@param weapon Weapon
---@param target Vector
---@param velocity Vector
function NPC:DropWeapon(weapon,target,velocity) end

-- Makes an NPC exit a scripted sequence, if one is playing.
function NPC:ExitScriptedSequence() end

-- Force an NPC to play its Fear sound.
function NPC:FearSound() end

-- Force an NPC to play its FoundEnemy sound.
function NPC:FoundEnemySound() end

-- Returns the weapon the NPC is currently carrying, or Global_Variables.
function NPC:GetActiveWeapon() end

-- Returns the NPC's current activity.
function NPC:GetActivity() end

-- Returns the aim vector of the NPC. NPC alternative of Player:GetAimVector.
function NPC:GetAimVector() end

-- Returns the activity to be played when the NPC arrives at its goal
function NPC:GetArrivalActivity() end

-- Returns the sequence to be played when the NPC arrives at its goal.
function NPC:GetArrivalSequence() end

-- Returns the most dangerous/closest sound hint based on the NPCs location and the types of sounds it can sense.
---@param types number
function NPC:GetBestSoundHint(types) end

-- Returns the entity blocking the NPC along its path.
function NPC:GetBlockingEntity() end

-- Returns the NPC's current schedule.
function NPC:GetCurrentSchedule() end

-- Returns how proficient (skilled) an NPC is with its current weapon.
function NPC:GetCurrentWeaponProficiency() end

-- Gets the NPC's current waypoint position (where NPC is currently moving towards), if any is available.
function NPC:GetCurWaypointPos() end

-- Returns the entity that this NPC is trying to fight.This returns nil if the NPC has no enemy. You should use Global.IsValid (which accounts for nil and NULL) on the return to verify validity of the enemy.
function NPC:GetEnemy() end

-- Returns the first time an NPC's enemy was seen by the NPC.
---@param enemy Entity
function NPC:GetEnemyFirstTimeSeen(enemy) end

-- Returns the last known position of an NPC's enemy.Similar to NPC:GetEnemyLastSeenPos, but the known position will be a few seconds ahead of the last seen position.
---@param enemy Entity
function NPC:GetEnemyLastKnownPos(enemy) end

-- Returns the last seen position of an NPC's enemy.Similar to NPC:GetEnemyLastKnownPos, but the known position will be a few seconds ahead of the last seen position.
---@param enemy Entity
function NPC:GetEnemyLastSeenPos(enemy) end

-- Returns the last time an NPC's enemy was seen by the NPC.
---@param enemy Entity
function NPC:GetEnemyLastTimeSeen(enemy) end

-- Returns the expression file the NPC is currently playing.
function NPC:GetExpression() end

-- Returns NPCs hull type set by NPC:SetHullType.
function NPC:GetHullType() end

-- Returns the ideal activity the NPC currently wants to achieve.
function NPC:GetIdealActivity() end

-- Returns the ideal move acceleration of the NPC.
function NPC:GetIdealMoveAcceleration() end

-- Returns the ideal move speed of the NPC.
function NPC:GetIdealMoveSpeed() end

-- Returns all known enemies this NPC has.See also NPC:GetKnownEnemyCount
function NPC:GetKnownEnemies() end

-- Returns known enemy count of this NPC.See also NPC:GetKnownEnemies
function NPC:GetKnownEnemyCount() end

-- Returns Global.CurTime based time since this NPC last received damage from given enemy.
---@param enemy Entity
function NPC:GetLastTimeTookDamageFromEnemy(enemy) end

-- Returns NPCs max view distance. An NPC will not be able to see enemies outside of this distance.
function NPC:GetMaxLookDistance() end

-- Returns how far should the NPC look ahead in its route.
function NPC:GetMinMoveCheckDist() end

-- Returns how far before the NPC can come to a complete stop.
---@param minResult  number
function NPC:GetMinMoveStopDist(minResult ) end

-- Returns the current timestep the internal NPC motor is working on.
function NPC:GetMoveInterval() end

-- Returns the NPC's current movement activity.
function NPC:GetMovementActivity() end

-- Returns the index of the sequence the NPC uses to move.
function NPC:GetMovementSequence() end

-- Returns the current move velocity of the NPC.
function NPC:GetMoveVelocity() end

-- Returns the NPC's navigation type.
function NPC:GetNavType() end

-- Returns the nearest member of the squad the NPC is in.
function NPC:GetNearestSquadMember() end

-- Gets the NPC's next waypoint position, where NPC will be moving after reaching current waypoint, if any is available.
function NPC:GetNextWaypointPos() end

-- Returns the NPC's state.
function NPC:GetNPCState() end

-- Returns the distance the NPC is from Target Goal.
function NPC:GetPathDistanceToGoal() end

-- Returns the amount of time it will take for the NPC to get to its Target Goal.
function NPC:GetPathTimeToGoal() end

-- Returns the shooting position of the NPC.This only works properly when called on an NPC that can hold weapons, otherwise it will return the same value as Entity:GetPos.
function NPC:GetShootPos() end

-- Returns the current squad name of the NPC.
function NPC:GetSquad() end

-- Returns the NPC's current target set by NPC:SetTarget.This returns nil if the NPC has no target. You should use Global.IsValid (which accounts for nil and NULL) on the return to verify validity of the target.
function NPC:GetTarget() end

-- Returns the status of the current task.
function NPC:GetTaskStatus() end

-- Returns Global.CurTime based time since the enemy was reacquired, meaning it is currently in Line of Sight of the NPC.
---@param enemy Entity
function NPC:GetTimeEnemyLastReacquired(enemy) end

-- Returns a specific weapon the NPC owns.
---@param class string
function NPC:GetWeapon(class) end

-- Returns a table of the NPC's weapons.
function NPC:GetWeapons() end

-- Used to give a weapon to an already spawned NPC.
---@param weapon string
function NPC:Give(weapon) end

-- Returns whether or not the NPC has the given condition.
---@param condition number
function NPC:HasCondition(condition) end

-- Polls the enemy memory to check if the given entity has eluded us or not.
---@param enemy Entity
function NPC:HasEnemyEluded(enemy) end

-- Polls the enemy memory to check if the NPC has any memory of given enemy.
---@param enemy Entity
function NPC:HasEnemyMemory(enemy) end

-- Returns true if the current navigation has a obstacle, this is different from NPC:GetBlockingEntity, this includes obstacles that it can steer around.
function NPC:HasObstacles() end

-- Force an NPC to play their Idle sound.
function NPC:IdleSound() end

-- Makes the NPC ignore given entity/enemy until given time.
---@param enemy Entity
---@param until number
function NPC:IgnoreEnemyUntil(enemy,until) end

-- Returns whether or not the NPC is performing the given schedule.
---@param schedule number
function NPC:IsCurrentSchedule(schedule) end

-- Returns whether the NPC has an active goal.
function NPC:IsGoalActive() end

-- Returns if the current movement is locked on the Yaw axis.
function NPC:IsMoveYawLocked() end

-- Returns whether the NPC is moving or not.
function NPC:IsMoving() end

-- Checks if the NPC is running an **ai_goal**. ( e.g. An npc_citizen NPC following the Player. )
function NPC:IsRunningBehavior() end

-- Returns whether the current NPC is the leader of the squad it is in.
function NPC:IsSquadLeader() end

-- Returns true if the entity was remembered as unreachable. The memory is updated automatically from following engine tasks if they failed:* TASK_GET_CHASE_PATH_TO_ENEMY* TASK_GET_PATH_TO_ENEMY_LKP* TASK_GET_PATH_TO_INTERACTION_PARTNER* TASK_ANTLIONGUARD_GET_CHASE_PATH_ENEMY_TOLERANCE* SCHED_FAIL_ESTABLISH_LINE_OF_FIRE - Combine NPCs, also when failing to change their enemy
---@param testEntity Entity
function NPC:IsUnreachable(testEntity) end

-- Force an NPC to play their LostEnemy sound.
function NPC:LostEnemySound() end

-- Tries to achieve our ideal animation state, playing any transition sequences that we need to play to get there.
function NPC:MaintainActivity() end

-- Causes the NPC to temporarily forget the current enemy and switch on to a better one.
---@param enemy Entity
function NPC:MarkEnemyAsEluded(enemy) end

-- Marks the NPC as took damage from given entity.See also NPC:GetLastTimeTookDamageFromEnemy.
---@param enemy Entity
function NPC:MarkTookDamageFromEnemy(enemy) end

-- Executes a climb move.Related functions are NPC:MoveClimbStart and NPC:MoveClimbStop.
---@param destination Vector
---@param dir Vector
---@param distance number
---@param yaw number
---@param left number
function NPC:MoveClimbExec(destination,dir,distance,yaw,left) end

-- Starts a climb move.Related functions are NPC:MoveClimbExec and NPC:MoveClimbStop.
---@param destination Vector
---@param dir Vector
---@param distance number
---@param yaw number
function NPC:MoveClimbStart(destination,dir,distance,yaw) end

-- Stops a climb move.Related functions are NPC:MoveClimbExec and NPC:MoveClimbStart.
function NPC:MoveClimbStop() end

-- Executes a jump move.Related functions are NPC:MoveJumpStart and NPC:MoveJumpStop.
function NPC:MoveJumpExec() end

-- Starts a jump move.Related functions are NPC:MoveJumpExec and NPC:MoveJumpStop.
---@param vel Vector
function NPC:MoveJumpStart(vel) end

-- Stops a jump move.Related functions are NPC:MoveJumpExec and NPC:MoveJumpStart.
function NPC:MoveJumpStop() end

-- Makes the NPC walk toward the given position. The NPC will return to the player after amount of time set by **player_squad_autosummon_time** ConVar.Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.The NPC **must** be in the player's squad for this to work.
---@param position Vector
function NPC:MoveOrder(position) end

-- Pauses the NPC movement?Related functions are NPC:MoveStart, NPC:MoveStop and NPC:ResetMoveCalc.
function NPC:MovePause() end

-- Starts NPC movement?Related functions are NPC:MoveStop, NPC:MovePause and NPC:ResetMoveCalc.
function NPC:MoveStart() end

-- Stops the NPC movement?Related functions are NPC:MoveStart, NPC:MovePause and NPC:ResetMoveCalc.
function NPC:MoveStop() end

-- Works similarly to NPC:NavSetRandomGoal.
---@param pos Vector
---@param length number
---@param dir Vector
function NPC:NavSetGoal(pos,length,dir) end

-- Creates a path to closest node at given position. This won't actually force the NPC to move.See also NPC:NavSetRandomGoal.
---@param pos Vector
function NPC:NavSetGoalPos(pos) end

-- Set the goal target for an NPC.
---@param target Entity
---@param offset Vector
function NPC:NavSetGoalTarget(target,offset) end

-- Creates a random path of specified minimum length between a closest start node and random node in the specified direction. This won't actually force the NPC to move.
---@param minPathLength number
---@param dir Vector
function NPC:NavSetRandomGoal(minPathLength,dir) end

-- Sets a goal in x, y offsets for the NPC to wander to
---@param xOffset number
---@param yOffset number
function NPC:NavSetWanderGoal(xOffset,yOffset) end

-- Forces the NPC to pickup an existing weapon entity. The NPC will not pick up the weapon if they already own a weapon of given type, or if the NPC could not normally have this weapon in their inventory.
---@param wep Weapon
function NPC:PickupWeapon(wep) end

-- Forces the NPC to play a sentence from scripts/sentences.txt
---@param sentence string
---@param delay number
---@param volume number
function NPC:PlaySentence(sentence,delay,volume) end

-- Makes the NPC remember an entity or an enemy as unreachable, for a specified amount of time. Use NPC:IsUnreachable to check if an entity is still unreachable.
---@param ent Entity
---@param time number
function NPC:RememberUnreachable(ent,time) end

-- This function crashes the game no matter how it is used and will be removed in a future update.Use NPC:ClearEnemyMemory instead.
function NPC:RemoveMemory() end

-- Resets the ideal activity of the NPC. See also NPC:SetIdealActivity.
---@param act number
function NPC:ResetIdealActivity(act) end

-- Resets all the movement calculations.Related functions are NPC:MoveStart, NPC:MovePause and NPC:MoveStop.
function NPC:ResetMoveCalc() end

-- Starts an engine task.Used internally by the ai_task.
---@param taskID number
---@param taskData number
function NPC:RunEngineTask(taskID,taskData) end

-- Forces the NPC to switch to a specific weapon the NPC owns. See NPC:GetWeapons.
---@param class string
function NPC:SelectWeapon(class) end

-- Stops any sounds (speech) the NPC is currently palying.Equivalent to `Entity:EmitSound( "AI_BaseNPC.SentenceStop" )`
function NPC:SentenceStop() end

-- Sets the NPC's current activity.
---@param act number
function NPC:SetActivity(act) end

---@param act number
function NPC:SetArrivalActivity(act) end

---@param dir Vector
function NPC:SetArrivalDirection(dir) end

-- Sets the distance to goal at which the NPC should stop moving and continue to other business such as doing the rest of their tasks in a schedule.
---@param dist number
function NPC:SetArrivalDistance(dist) end

---@param seq number
function NPC:SetArrivalSequence(seq) end

-- Sets the arrival speed? of the NPC
---@param speed number
function NPC:SetArrivalSpeed(speed) end

-- Sets an NPC condition.
---@param condition number
function NPC:SetCondition(condition) end

-- Sets the weapon proficiency of an NPC (how skilled an NPC is with its current weapon).
---@param proficiency number
function NPC:SetCurrentWeaponProficiency(proficiency) end

-- Sets the target for an NPC.
---@param enemy Entity
---@param newenemy boolean
function NPC:SetEnemy(enemy,newenemy) end

-- Sets the NPC's .vcd expression. Similar to Entity:PlayScene except the scene is looped until it's interrupted by default NPC behavior or NPC:ClearExpression.
---@param expression string
function NPC:SetExpression(expression) end

-- Updates the NPC's hull and physics hull in order to match its model scale. Entity:SetModelScale seems to take care of this regardless.
function NPC:SetHullSizeNormal() end

-- Sets the hull type for the NPC.
---@param hullType number
function NPC:SetHullType(hullType) end

-- Sets the ideal activity the NPC currently wants to achieve. This is most useful for custom SNPCs.
---@param  number
function NPC:SetIdealActivity() end

-- Sets the ideal yaw angle (left-right rotation) for the NPC and forces them to turn to that angle.
---@param angle number
---@param speed number
function NPC:SetIdealYawAndUpdate(angle,speed) end

-- Sets the last registered or memorized position for an npc. When using scheduling, the NPC will focus on navigating to the last position via nodes.The navigation requires ground nodes to function properly, otherwise the NPC could only navigate in a small area. (https://developer.valvesoftware.com/wiki/Info_node)
---@param Position Vector
function NPC:SetLastPosition(Position) end

-- Sets NPC's max view distance. An NPC will not be able to see enemies outside of this distance.
---@param dist number
function NPC:SetMaxLookDistance(dist) end

-- Sets how long to try rebuilding path before failing task.
---@param time number
function NPC:SetMaxRouteRebuildTime(time) end

-- Sets the timestep the internal NPC motor is working on.
---@param time number
function NPC:SetMoveInterval(time) end

-- Sets the activity the NPC uses when it moves.
---@param activity number
function NPC:SetMovementActivity(activity) end

-- Sets the sequence the NPC navigation path uses for speed calculation. Doesn't seem to have any visible effect on NPC movement.
---@param sequenceId number
function NPC:SetMovementSequence(sequenceId) end

-- Sets the move velocity of the NPC
---@param vel Vector
function NPC:SetMoveVelocity(vel) end

-- Sets whether the current movement should locked on the Yaw axis or not.
---@param lock boolean
function NPC:SetMoveYawLocked(lock) end

-- Sets the navigation type of the NPC.
---@param navtype number
function NPC:SetNavType(navtype) end

-- Sets the state the NPC is in to help it decide on a ideal schedule.
---@param state number
function NPC:SetNPCState(state) end

-- Sets the NPC's current schedule.
---@param schedule number
function NPC:SetSchedule(schedule) end

-- Assigns the NPC to a new squad. A squad can have up to 16 NPCs. NPCs in a single squad should be friendly to each other.
---@param name string
function NPC:SetSquad(name) end

-- Sets the NPC's target. This is used in some engine schedules.
---@param entity Entity
function NPC:SetTarget(entity) end

-- Sets the status of the current task.
---@param status number
function NPC:SetTaskStatus(status) end

-- Forces the NPC to start an engine task, this has different results for every NPC.
---@param task number
---@param taskData number
function NPC:StartEngineTask(task,taskData) end

-- Resets the NPC's movement animation and velocity. Does not actually stop the NPC from moving.
function NPC:StopMoving() end

-- Cancels NPC:MoveOrder basically.Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.The NPC **must** be in the player's squad for this to work.
---@param target Entity
function NPC:TargetOrder(target) end

-- Marks the current NPC task as completed.This is meant to be used alongside NPC:TaskFail to complete or fail custom Lua defined tasks. (Schedule:AddTask)
function NPC:TaskComplete() end

-- Marks the current NPC task as failed.This is meant to be used alongside NPC:TaskComplete to complete or fail custom Lua defined tasks. (Schedule:AddTask)
---@param task string
function NPC:TaskFail(task) end

-- Force the NPC to update information on the supplied enemy, as if it had line of sight to it.
---@param enemy Entity
---@param pos Vector
function NPC:UpdateEnemyMemory(enemy,pos) end

-- Updates the turn activity. Basically applies the turn animations depending on the current turn yaw.
function NPC:UpdateTurnActivity() end

-- Only usable on "ai" base entities.
function NPC:UseActBusyBehavior() end

function NPC:UseAssaultBehavior() end

-- Only usable on "ai" base entities.
function NPC:UseFollowBehavior() end

function NPC:UseFuncTankBehavior() end

function NPC:UseLeadBehavior() end

-- Undoes the other Use*Behavior functions.Only usable on "ai" base entities.
function NPC:UseNoBehavior() end



---@class Panel
Panel = Panel

-- Set to true by the dragndrop system when the panel is being drawn for the drag'n'drop.
function Panel:PaintingDragging() end

-- Adds the specified object to the panel.
---@param object Panel
function Panel:Add(object) end

-- Does nothingThis function does nothing.
function Panel:AddText() end

-- Aligns the panel on the bottom of its parent with the specified offset.
---@param offset number
function Panel:AlignBottom(offset) end

-- Aligns the panel on the left of its parent with the specified offset.
---@param offset number
function Panel:AlignLeft(offset) end

-- Aligns the panel on the right of its parent with the specified offset.
---@param offset number
function Panel:AlignRight(offset) end

-- Aligns the panel on the top of its parent with the specified offset.
---@param offset number
function Panel:AlignTop(offset) end

-- Uses animation to transition the current alpha value of a panel to a new alpha, over a set period of time and after a specified delay.
---@param alpha number
---@param duration number
---@param delay number
---@param callback function
function Panel:AlphaTo(alpha,duration,delay,callback) end

--  Performs the per-frame operations required for panel animations.This is called every frame by PANEL:AnimationThink.
function Panel:AnimationThinkInternal() end

-- Returns the Global.SysTime value when all animations for this panel object will end.
function Panel:AnimTail() end

-- Appends text to a RichText element. This does not automatically add a new line.
---@param txt string
function Panel:AppendText(txt) end

-- Used by Panel:LoadGWENFile and Panel:LoadGWENString to apply a GWEN controls table to a panel object.You can do this manually using file.Read and util.JSONToTable to import and create a GWEN table structure from a `.gwen` file. This method can then be called, passing the GWEN table's `Controls` member.
---@param GWENTable table
function Panel:ApplyGWEN(GWENTable) end

-- Centers the panel on its parent.
function Panel:Center() end

-- Centers the panel horizontally with specified fraction.
---@param fraction number
function Panel:CenterHorizontal(fraction) end

-- Centers the panel vertically with specified fraction.
---@param fraction number
function Panel:CenterVertical(fraction) end

-- Returns the amount of children of the of panel.
function Panel:ChildCount() end

-- Returns the width and height of the space between the position of the panel (upper-left corner) and the max bound of the children panels (farthest reaching lower-right corner).
function Panel:ChildrenSize() end

-- Marks all of the panel's children for deletion.
function Panel:Clear() end

-- Fades panels color to specified one. It won't work unless panel has SetColor function.
---@param color table
---@param length number
---@param delay number
---@param callback function
function Panel:ColorTo(color,length,delay,callback) end

-- Sends an action command signal to the panel. The response is handled by PANEL:ActionSignal.
---@param command string
function Panel:Command(command) end

-- Updates a panel object's associated console variable. This must first be set up with Global.Derma_Install_Convar_Functions, and have a ConVar set using Panel:SetConVar.
---@param newValue string
function Panel:ConVarChanged(newValue) end

-- A think hook for Panels using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.This function is best for: checkboxes, sliders, number wangsFor a string alternative, see Panel:ConVarStringThink.Make sure your Panel has a SetValue function, else you may get errors.
function Panel:ConVarNumberThink() end

-- A think hook for Panel using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.This function is best for: text inputs, read-only inputs, dropdown selectsFor a number alternative, see Panel:ConVarNumberThink.Make sure your Panel has a SetValue function, else you may get errors.
function Panel:ConVarStringThink() end

-- Gets the size, position and dock state of the passed panel object, and applies it to this one.
---@param srcPanel Panel
function Panel:CopyBase(srcPanel) end

-- Copies position and size of the panel.
---@param base Panel
function Panel:CopyBounds(base) end

-- Copies the height of the panel.
---@param base Panel
function Panel:CopyHeight(base) end

-- Copies the position of the panel.
---@param base Panel
function Panel:CopyPos(base) end

-- Performs the CONTROL + C key combination effect ( Copy selection to clipboard ) on selected text in a TextEntry or RichText based element.
function Panel:CopySelected() end

-- Copies the width of the panel.
---@param base Panel
function Panel:CopyWidth(base) end

-- Returns the cursor position relative to the top left of the panel.This is equivalent to calling gui.MousePos and then Panel:ScreenToLocal.This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass.ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
function Panel:CursorPos() end

-- Performs the CONTROL + X (delete text and copy it to clipboard buffer) action on selected text in a TextEntry or RichText based element.
function Panel:CutSelected() end

-- Deletes a cookie value using the panel's cookie name ( Panel:GetCookieName ) and the passed extension.
---@param cookieName string
function Panel:DeleteCookie(cookieName) end

-- Resets the panel object's Panel:SetPos method and removes its animation table (`Panel.LerpAnim`). This effectively undoes the changes made by Panel:LerpPositions.In order to use Lerp animation again, you must call Panel:Stop before setting its `SetPosReal` property to `nil`. See the example below.
function Panel:DisableLerp() end

-- Returns the linear distance from the center of this panel object and another. **Both panels must have the same parent for this function to work properly.**
---@param tgtPanel Panel
function Panel:Distance(tgtPanel) end

-- Returns the distance between the center of this panel object and a specified point **local to the parent panel**.
---@param posX number
---@param posY number
function Panel:DistanceFrom(posX,posY) end

-- Sets the dock type for the panel, making the panel "dock" in a certain direction, modifying it's position and size.You can set the inner spacing of a panel's docking using Panel:DockPadding, which will affect docked child panels, and you can set the outer spacing of a panel's docking using Panel:DockMargin, which affects how docked siblings are positioned/sized.You may need to use Panel:SetZPos to ensure child panels (DTextEntry) stay in a specific order.After using this function, if you want to get the correct panel's bounds (position, size), use Panel:InvalidateParent (use `true` as argument if you need to update immediately)
---@param dockType number
function Panel:Dock(dockType) end

-- Sets the dock margin of the panel.The dock margin is the extra space that will be left around the edge when this element is docked inside its parent element.
---@param marginLeft number
---@param marginTop number
---@param marginRight number
---@param marginBottom number
function Panel:DockMargin(marginLeft,marginTop,marginRight,marginBottom) end

-- Sets the dock padding of the panel.The dock padding is the extra space that will be left around the edge when child elements are docked inside this element.
---@param paddingLeft number
---@param paddingTop number
---@param paddingRight number
---@param paddingBottom number
function Panel:DockPadding(paddingLeft,paddingTop,paddingRight,paddingBottom) end

-- Makes the panel "lock" the screen until it is removed. All input will be directed to the given panel.It will silently fail if used while cursor is not visible.Call Panel:MakePopup before calling this function.This must be called on a panel derived from EditablePanel.
function Panel:DoModal() end

--  Called by Panel:DragMouseRelease when a user clicks one mouse button whilst dragging with another.
function Panel:DragClick() end

--  Called by dragndrop.HoverThink to perform actions on an object that is dragged and hovered over another.
---@param HoverTime number
function Panel:DragHover(HoverTime) end

--  Called to end a drag and hover action. This resets the panel's PANEL:PaintOver method, and is primarily used by dragndrop.StopDragging.
function Panel:DragHoverEnd() end

-- Called to inform the dragndrop that a mouse button is being held down on a panel object.
---@param mouseCode number
function Panel:DragMousePress(mouseCode) end

-- Called to inform the dragndrop that a mouse button has been depressed on a panel object.
---@param mouseCode number
function Panel:DragMouseRelease(mouseCode) end

--  Called to draw the drop target when an object is being dragged across another. See Panel:SetDropTarget.
---@param x number
---@param y number
---@param width number
---@param height number
function Panel:DrawDragHover(x,y,width,height) end

-- Draws a coloured rectangle to fill the panel object this method is called on. The colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawRect.
function Panel:DrawFilledRect() end

-- Draws a hollow rectangle the size of the panel object this method is called on, with a border width of 1 px. The border colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawOutlinedRect.
function Panel:DrawOutlinedRect() end

-- Used to draw the magenta highlight colour of a panel object when it is selected. This should be called in the object's PANEL:PaintOver hook. Once this is implemented, the highlight colour will be displayed only when the object is selectable and selected. This is achieved using Panel:SetSelectable and Panel:SetSelected respectively.
function Panel:DrawSelections() end

-- Used to draw the text in a DTextEntry within a derma skin. This should be called within the SKIN:PaintTextEntry skin hook.Will silently fail if any of arguments are not Color.
---@param textCol table
---@param highlightCol table
---@param cursorCol table
function Panel:DrawTextEntryText(textCol,highlightCol,cursorCol) end

-- Draws a textured rectangle to fill the panel object this method is called on. The texture is set using surface.SetTexture or surface.SetMaterial. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawTexturedRect.
function Panel:DrawTexturedRect() end

-- Makes this panel droppable. This is used with Panel:Receiver to create drag and drop events.Can be called multiple times with different names allowing to be dropped onto different receivers.
---@param name string
function Panel:Droppable(name) end

-- Completes a box selection. If the end point of the selection box is within the selection canvas, mouse capture is disabled for the panel object, and the selected state of each child object within the selection box is toggled.
function Panel:EndBoxSelection() end

--  Used to run commands within a DHTML window.
---@param cmd string
function Panel:Exec(cmd) end

-- Finds a panel in its children(and sub children) with the given name.
---@param panelName string
function Panel:Find(panelName) end

-- Focuses the next panel in the focus queue.
function Panel:FocusNext() end

-- Focuses the previous panel in the focus queue.
function Panel:FocusPrevious() end

-- Returns the alpha multiplier for this panel.
function Panel:GetAlpha() end

-- Returns the background color of a panel such as a RichText, Label or DColorCube.This doesn't apply to all VGUI elements and its function varies between them
function Panel:GetBGColor() end

-- Returns the position and size of the panel.This is equivalent to calling Panel:GetPos and Panel:GetSize together.
function Panel:GetBounds() end

-- Returns the position/offset of the caret (or text cursor) in a text-based panel object.
function Panel:GetCaretPos() end

-- Gets a child by its index. For use with Panel:ChildCount.
---@param childIndex number
function Panel:GetChild(childIndex) end

-- Gets a child object's position relative to this panel object. The number of levels is not relevant; the child may have many parents between itself and the object on which the method is called.
---@param pnl Panel
function Panel:GetChildPosition(pnl) end

-- Returns a table with all the child panels of the panel.
function Panel:GetChildren() end

-- Returns a table of all visible, selectable children of the panel object that lie at least partially within the specified rectangle.
---@param x number
---@param y number
---@param w number
---@param h number
function Panel:GetChildrenInRect(x,y,w,h) end

-- Returns the class name of the panel.
function Panel:GetClassName() end

-- Returns the child of this panel object that is closest to the specified point. The point is relative to the object on which the method is called. The distance the child is from this point is also returned.
---@param x number
---@param y number
function Panel:GetClosestChild(x,y) end

-- Gets the size of the content/children within a panel object.Only works with Label derived panels by default such as DLabel.Will also work on any panel that manually implements this method.
function Panel:GetContentSize() end

-- Gets the value of a cookie stored by the panel object. This can also be done with cookie.GetString, using the panel's cookie name, a fullstop, and then the actual name of the cookie.Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
---@param cookieName string
---@param default string
function Panel:GetCookie(cookieName,default) end

-- Gets the name the panel uses to store cookies. This is set with Panel:SetCookieName.
function Panel:GetCookieName() end

-- Gets the value of a cookie stored by the panel object, as a number. This can also be done with cookie.GetNumber, using the panel's cookie name, a fullstop, and then the actual name of the cookie.Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
---@param cookieName string
---@param default number
function Panel:GetCookieNumber(cookieName,default) end

-- Returns a dock enum for the panel's current docking type.
function Panel:GetDock() end

-- Returns the docked margins of the panel. (set by Panel:DockMargin)
function Panel:GetDockMargin() end

-- Returns the docked padding of the panel. (set by Panel:DockPadding)
function Panel:GetDockPadding() end

-- Returns the foreground color of the panel.For a Label or RichText, this is the color of its text.This doesn't apply to all VGUI elements (such as DLabel) and its function varies between them
function Panel:GetFGColor() end

-- Returns the name of the font that the panel renders its text with.This is the same font name set with Panel:SetFontInternal.
function Panel:GetFont() end

-- Returns the panel's HTML material. Only works with Awesomium, HTML and DHTML panels that have been fully loaded.
function Panel:GetHTMLMaterial() end

-- Returns the current maximum character count.This function will only work on RichText and TextEntry panels and their derivatives.
function Panel:GetMaximumCharCount() end

-- Returns the internal name of the panel. Can be set via Panel:SetName.
function Panel:GetName() end

-- Returns the number of lines in a RichText. You must wait a couple frames before calling this after using Panel:AppendText or Panel:SetText, otherwise it will return the number of text lines before the text change.Even though this function can be called on any panel, it will only work with RichText
function Panel:GetNumLines() end

-- Returns the parent of the panel, returns nil if there is no parent.
function Panel:GetParent() end

-- Returns the position of the panel relative to its Panel:GetParent.If you require the panel's position **and** size, consider using Panel:GetBounds instead.If you need the position in screen space, see Panel:LocalToScreen.See also Panel:GetX and Panel:GetY.
function Panel:GetPos() end

-- Returns a table of all children of the panel object that are selected. This is recursive, and the returned table will include tables for any child objects that also have children. This means that not all first-level members in the returned table will be of type Panel.
function Panel:GetSelectedChildren() end

-- Returns the currently selected range of text.This function will only work on RichText and TextEntry panels and their derivatives.
function Panel:GetSelectedTextRange() end

-- Returns the panel object (`self`) if it has been enabled as a selection canvas. This is achieved using Panel:SetSelectionCanvas.
function Panel:GetSelectionCanvas() end

-- Returns the size of the panel.If you require both the panel's position and size, consider using Panel:GetBounds instead.
function Panel:GetSize() end

-- Returns the table for the derma skin currently being used by this panel object.
function Panel:GetSkin() end

-- Returns the internal Lua table of the panel.
function Panel:GetTable() end

-- Returns the height of the panel.
function Panel:GetTall() end

-- Returns the panel's text (where applicable).This method returns a maximum of 1023 bytes, except for DTextEntry.
function Panel:GetText() end

-- Gets the left and top text margins of a text-based panel object, such as a DButton or DLabel. This is set with Panel:SetTextInset.
function Panel:GetTextInset() end

-- Gets the size of the text within a Label derived panel.
function Panel:GetTextSize() end

-- Returns the tooltip text that was set with PANEL:SetTooltip.
function Panel:GetTooltip() end

-- Returns the tooltip panel that was set with PANEL:SetTooltipPanel.
function Panel:GetTooltipPanel() end

-- Gets valid receiver slot of currently dragged panel.
function Panel:GetValidReceiverSlot() end

-- Returns the value the panel holds.In engine is only implemented for CheckButton, Label and TextEntry as a string.This function is limited to 8092 Bytes. If using DTextEntry, use Panel:GetText for unlimited bytes.
function Panel:GetValue() end

-- Returns the width of the panel.
function Panel:GetWide() end

-- Returns the X position of the panel relative to its Panel:GetParent.Uses Panel:GetPos internally.
function Panel:GetX() end

-- Returns the Y position of the panel relative to its Panel:GetParent.Uses Panel:GetPos internally.
function Panel:GetY() end

-- Returns the Z position of the panel.
function Panel:GetZPos() end

-- Goes back one page in the HTML panel's history if available.
function Panel:GoBack() end

-- Goes forward one page in the HTML panel's history if available.
function Panel:GoForward() end

-- Goes to the page in the HTML panel's history at the specified relative offset.
---@param offset number
function Panel:GoToHistoryOffset(offset) end

-- Causes a RichText element to scroll to the bottom of its text.
function Panel:GotoTextEnd() end

-- Causes a RichText element to scroll to the top of its text.This does not work on the same frame as Panel:SetText.
function Panel:GotoTextStart() end

--  Used by Panel:ApplyGWEN to apply the `CheckboxText` property to a DCheckBoxLabel. This does exactly the same as Panel:GWEN_SetText, but exists to cater for the seperate GWEN properties.
---@param txt string
function Panel:GWEN_SetCheckboxText(txt) end

--  Used by Panel:ApplyGWEN to apply the `ControlName` property to a panel. This calls Panel:SetName.
---@param name string
function Panel:GWEN_SetControlName(name) end

--  Used by Panel:ApplyGWEN to apply the `Dock` property to a  panel object. This calls Panel:Dock.
---@param dockState string
function Panel:GWEN_SetDock(dockState) end

--  Used by Panel:ApplyGWEN to apply the `HorizontalAlign` property to a  panel object. This calls Panel:SetContentAlignment.
---@param hAlign string
function Panel:GWEN_SetHorizontalAlign(hAlign) end

--  Used by Panel:ApplyGWEN to apply the `Margin` property to a  panel object. This calls Panel:DockMargin.
---@param margins table
function Panel:GWEN_SetMargin(margins) end

--  Used by Panel:ApplyGWEN to apply the `Max` property to a  DNumberWang, Slider, DNumSlider or DNumberScratch. This calls `SetMax` on one of the previously listed methods.
---@param maxValue number
function Panel:GWEN_SetMax(maxValue) end

--  Used by Panel:ApplyGWEN to apply the `Min` property to a  DNumberWang, Slider, DNumSlider or DNumberScratch. This calls `SetMin` on one of the previously listed methods.
---@param minValue number
function Panel:GWEN_SetMin(minValue) end

--  Used by Panel:ApplyGWEN to apply the `Position` property to a  panel object. This calls Panel:SetPos.
---@param pos table
function Panel:GWEN_SetPosition(pos) end

--  Used by Panel:ApplyGWEN to apply the `Size` property to a  panel object. This calls Panel:SetSize.
---@param size table
function Panel:GWEN_SetSize(size) end

--  Used by Panel:ApplyGWEN to apply the `Text` property to a panel.
---@param txt string
function Panel:GWEN_SetText(txt) end

-- Returns whenever the panel has child panels.
function Panel:HasChildren() end

-- Returns if the panel is focused.
function Panel:HasFocus() end

-- Returns if the panel or any of its children(sub children and so on) has the focus.
function Panel:HasHierarchicalFocus() end

-- Returns whether the panel is a descendent of the given panel.
---@param parentPanel Panel
function Panel:HasParent(parentPanel) end

-- Makes a panel invisible.
function Panel:Hide() end

-- Marks the end of a clickable text segment in a RichText element, started with Panel:InsertClickableTextStart.
function Panel:InsertClickableTextEnd() end

-- Starts the insertion of clickable text for a RichText element. Any text appended with Panel:AppendText between this call and Panel:InsertClickableTextEnd will become clickable text.The hook PANEL:ActionSignal is called when the text is clicked, with "TextClicked" as the signal name and `signalValue` as the signal value.The clickable text is a separate Derma panel which will not inherit the current font from the `RichText`.
---@param signalValue string
function Panel:InsertClickableTextStart(signalValue) end

-- Inserts a color change in a RichText element, which affects the color of all text added with Panel:AppendText until another color change is applied.
---@param r number
---@param g number
---@param b number
---@param a number
function Panel:InsertColorChange(r,g,b,a) end

-- Begins a text fade for a RichText element where the last appended text segment is fully faded out after a specific amount of time, at a specific speed.The alpha of the text at any given time is determined by the text's base alpha * ((`sustain` - Global.CurTime) / `length`) where Global.CurTime is added to `sustain` when this method is called.
---@param sustain number
---@param length number
function Panel:InsertFade(sustain,length) end

-- Invalidates the layout of this panel object and all its children. This will cause these objects to re-layout immediately, calling PANEL:PerformLayout. If you want to perform the layout in the next frame, you will have loop manually through all children, and call Panel:InvalidateLayout on each.
---@param recursive boolean
function Panel:InvalidateChildren(recursive) end

-- Causes the panel to re-layout in the next frame. During the layout process  PANEL:PerformLayout will be called on the target panel.You should avoid calling this function every frame.Using this on a panel after clicking on a docked element will cause docked elements to reorient themselves incorrectly. This can be fixed by assigning a unique Panel:SetZPos to each docked element.
---@param layoutNow boolean
function Panel:InvalidateLayout(layoutNow) end

-- Calls Panel:InvalidateLayout on the panel's Panel:GetParent. This function will silently fail if the panel has no parent.This will cause the parent panel to re-layout, calling PANEL:PerformLayout.Internally sets `LayingOutParent` to `true` on this panel, and will silently fail if it is already set.
---@param layoutNow boolean
function Panel:InvalidateParent(layoutNow) end

-- Determines whether the mouse cursor is hovered over one of this panel object's children. This is a reverse process using vgui.GetHoveredPanel, and looks upward to find the parent.
---@param immediate boolean
function Panel:IsChildHovered(immediate) end

-- Returns whether this panel is draggable ( if user is able to drag it ) or not.
function Panel:IsDraggable() end

-- Returns whether this panel is currently being dragged or not.
function Panel:IsDragging() end

-- Returns whether the the panel is enabled or disabled.See Panel:SetEnabled for a function that makes the panel enabled or disabled.
function Panel:IsEnabled() end

-- Returns whether the mouse cursor is hovering over this panel or notUses vgui.GetHoveredPanel internally.Requires Panel:SetMouseInputEnabled to be set to true.
function Panel:IsHovered() end

-- Returns true if the panel can receive keyboard input.
function Panel:IsKeyboardInputEnabled() end

-- Determines whether or not a HTML or DHTML element is currently loading a page.Before calling Panel:SetHTML or DHTML:OpenURL, the result seems to be `false` with the Awesomium web renderer and `true` for the Chromium web renderer. This difference can be used to determine the available HTML5 capabilities.On Awesomium, the result remains `true` until the root document is loaded and when in-page content is loading (when adding pictures, frames, etc.). During this state, the HTML texture is not refreshed and the panel is not painted (it becomes invisible).On Chromium, the value is only `true` when the root document is not ready. The rendering is not suspended when in-page elements are loading.
function Panel:IsLoading() end

-- Returns if the panel is going to be deleted in the next frame.
function Panel:IsMarkedForDeletion() end

-- Returns whether the panel was made modal or not. See Panel:DoModal.
function Panel:IsModal() end

-- Returns true if the panel can receive mouse input.
function Panel:IsMouseInputEnabled() end

-- Returns whether the panel contains the given panel, recursively.
---@param childPanel Panel
function Panel:IsOurChild(childPanel) end

-- Returns if the panel was made popup or not. See Panel:MakePopup
function Panel:IsPopup() end

-- Determines if the panel object is selectable (like icons in the Spawn Menu, holding Shift). This is set with Panel:SetSelectable.
function Panel:IsSelectable() end

-- Returns if the panel object is selected (like icons in the Spawn Menu, holding Shift). This can be set in Lua using Panel:SetSelected.
function Panel:IsSelected() end

-- Determines if the panel object is a selection canvas or not. This is set with Panel:SetSelectionCanvas.
function Panel:IsSelectionCanvas() end

-- Returns if the panel is valid and not marked for deletion.
function Panel:IsValid() end

-- Returns if the panel is visible. This will **NOT** take into account visibility of the parent.
function Panel:IsVisible() end

-- Returns if a panel allows world clicking set by Panel:SetWorldClicker.
function Panel:IsWorldClicker() end

-- Remove the focus from the panel.
function Panel:KillFocus() end

-- Redefines the panel object's Panel:SetPos method to operate using frame-by-frame linear interpolation (Global.Lerp). When the panel's position is changed, it will move to the target position at the speed defined. You can undo this with Panel:DisableLerp.Unlike the other panel animation functions, such as Panel:MoveTo, this animation method will not operate whilst the game is paused. This is because it relies on Global.FrameTime.
---@param speed number
---@param easeOut boolean
function Panel:LerpPositions(speed,easeOut) end

-- Similar to Panel:LoadControlsFromString but loads controls from a file.
---@param path string
function Panel:LoadControlsFromFile(path) end

-- Loads controls(positions, etc) from given data. This is what the default options menu uses.
---@param data string
function Panel:LoadControlsFromString(data) end

-- Loads a .gwen file (created by GWEN Designer) and calls Panel:LoadGWENString with the contents of the loaded file.Used to load panel controls from a file.
---@param filename string
---@param path string
function Panel:LoadGWENFile(filename,path) end

-- Loads controls for the panel from a JSON string.
---@param str string
function Panel:LoadGWENString(str) end

-- Sets a new image to be loaded by a TGAImage.
---@param imageName string
---@param strPath string
function Panel:LoadTGAImage(imageName,strPath) end

-- Returns the cursor position local to the position of the panel (usually the upper-left corner).
function Panel:LocalCursorPos() end

-- Gets the absolute screen position of the position specified relative to the panel.See also Panel:ScreenToLocal.This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.If the panel uses Panel:Dock, this function will return 0, 0 when the panel was created. The position will be updated in the next frame.
---@param posX number
---@param posY number
function Panel:LocalToScreen(posX,posY) end

-- Focuses the panel and enables it to receive input.This automatically calls Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled and sets them to `true`.Panels derived from Panel will not work properly with this function. Due to this, any children will not be intractable with keyboard. Derive from EditablePanel instead.For non gui related mouse focus, you can use gui.EnableScreenClicker.
function Panel:MakePopup() end

-- Allows the panel to receive mouse input even if the mouse cursor is outside the bounds of the panel.
---@param doCapture boolean
function Panel:MouseCapture(doCapture) end

-- Places the panel above the passed panel with the specified offset.
---@param panel Panel
---@param offset number
function Panel:MoveAbove(panel,offset) end

-- Places the panel below the passed panel with the specified offset.
---@param panel Panel
---@param offset number
function Panel:MoveBelow(panel,offset) end

-- Moves the panel by the specified coordinates using animation.
---@param moveX number
---@param moveY number
---@param time number
---@param delay number
---@param ease number
---@param callback function
function Panel:MoveBy(moveX,moveY,time,delay,ease,callback) end

-- Places the panel left to the passed panel with the specified offset.
---@param panel Panel
---@param offset number
function Panel:MoveLeftOf(panel,offset) end

-- Places the panel right to the passed panel with the specified offset.
---@param panel Panel
---@param offset number
function Panel:MoveRightOf(panel,offset) end

-- Moves the panel to the specified position using animation.Setting the ease argument to 0 will result in the animation happening instantly, this applies to all MoveTo/SizeTo functions
---@param posX number
---@param posY number
---@param time number
---@param delay number
---@param ease number
---@param callback function
function Panel:MoveTo(posX,posY,time,delay,ease,callback) end

-- Moves this panel object in front of the specified sibling (child of the same parent) in the render order, and shuffles up the Z-positions of siblings now behind.
---@param siblingPanel Panel
function Panel:MoveToAfter(siblingPanel) end

-- Moves the panel object behind all other panels on screen. If the panel has been made a pop-up with Panel:MakePopup, it will still draw in front of any panels that haven't.
function Panel:MoveToBack() end

-- Moves this panel object behind the specified sibling (child of the same parent) in the render order, and shuffles up the Panel:SetZPos of siblings now in front.
---@param siblingPanel Panel
function Panel:MoveToBefore(siblingPanel) end

-- Moves the panel in front of all other panels on screen. Unless the panel has been made a pop-up using Panel:MakePopup, it will still draw behind any that have.
function Panel:MoveToFront() end

-- Creates a new animation for the panel object.Methods that use this function:* Panel:MoveTo* Panel:SizeTo* Panel:SlideUp* Panel:SlideDown* Panel:ColorTo* Panel:AlphaTo* Panel:MoveBy* Panel:LerpPositions
---@param length number
---@param delay number
---@param ease number
---@param callback function
function Panel:NewAnimation(length,delay,ease,callback) end

-- 
---@param objectName string
function Panel:NewObject(objectName) end

-- 
---@param objectName string
---@param callbackName string
function Panel:NewObjectCallback(objectName,callbackName) end

-- Sets whether this panel's drawings should be clipped within the parent panel's bounds.See also Global.DisableClipping.
---@param clip boolean
function Panel:NoClipping(clip) end

-- Returns the number of children of the panel object that are selected. This is equivalent to calling Panel:IsSelected on all child objects and counting the number of returns that are `true`.
function Panel:NumSelectedChildren() end

-- Instructs a HTML control to download and parse a HTML script using the passed URL.This function can also be used on [HTML](https://wiki.facepunch.com/gmod/HTML).
---@param URL string
function Panel:OpenURL(URL) end

-- Paints a ghost copy of the panel at the given position.Breaks Z pos of panel PANEL:SetZPos
---@param posX number
---@param posY number
function Panel:PaintAt(posX,posY) end

-- Paints the panel at its current position. To use this you must call Panel:SetPaintedManually(true).
function Panel:PaintManual() end

-- Parents the panel to the HUD.Makes it invisible on the escape-menu and disables controls.
function Panel:ParentToHUD() end

-- Due to privacy concerns, this function has been disabledOnly works for TextEntries.Pastes the contents of the clipboard into the TextEntry.Tab characters will be dropped from the pasted text
function Panel:Paste() end

-- Sets the width and position of a DLabel and places the passed panel object directly to the right of it. Returns the `y` value of the bottom of the tallest object. The panel on which this method is run is not relevant; only the passed objects are affected.
---@param lblWidth number
---@param x number
---@param y number
---@param lbl Panel
---@param panelObj Panel
function Panel:PositionLabel(lblWidth,x,y,lbl,panelObj) end

-- Only used in deprecated Derma controls.Sends a command to the panel.
---@param messageName string
---@param valueType string
---@param value string
function Panel:PostMessage(messageName,valueType,value) end

-- Installs Lua defined functions into the panel.
function Panel:Prepare() end

-- Enables the queue for panel animations. If enabled, the next new animation will begin after all current animations have ended. This must be called before Panel:NewAnimation to work, and only applies to the next new animation. If you want to queue many, you must call this before each.
function Panel:Queue() end

-- Causes a SpawnIcon to rebuild its model image.
function Panel:RebuildSpawnIcon() end

-- Re-renders a spawn icon with customized cam data.Global.PositionSpawnIcon can be used to easily calculate the necessary camera parameters.This function does **not** accept the standard Structures/CamData.
---@param data table
function Panel:RebuildSpawnIconEx(data) end

-- Allows the panel to receive drag and drop events. Can be called multiple times with different names to receive multiple different draggable panel events.
---@param name string
---@param func function
---@param menu table
function Panel:Receiver(name,func,menu) end

-- Refreshes the HTML panel's current page.
---@param ignoreCache boolean
function Panel:Refresh(ignoreCache) end

-- Marks a panel for deletion so it will be deleted on the next frame.This will not mark child panels for deletion this frame, but they will be marked and deleted in the next frame.See also Panel:IsMarkedForDeletionWill automatically call Panel:InvalidateParent.
function Panel:Remove() end

-- Attempts to obtain focus for this panel.
function Panel:RequestFocus() end

-- Resets all text fades in a RichText element made with Panel:InsertFade.
---@param hold boolean
---@param expiredOnly boolean
---@param newSustain number
function Panel:ResetAllFades(hold,expiredOnly,newSustain) end

-- Runs/Executes a string as JavaScript code in a panel.This function does **NOT** evaluate expression (i.e. allow you to pass variables from JavaScript (JS) to Lua context).Because a return value is nil/no value (a.k.a. void).If you wish to pass/return values from JS to Lua, you may want to use DHTML:AddFunction function to accomplish that job.The Awesomium web renderer automatically delays the code execution if the document is not ready, but the Chromium web renderer does not!This means that with Chromium, you cannot JavaScript run code immediatly after calling Panel:SetHTML or DHTML:OpenURL. You should wait for the events PANEL:OnDocumentReady or PANEL:OnFinishLoadingDocument to be triggered before proceeding, otherwise you may manipulate an empty / incomplete document.
---@param js string
function Panel:RunJavascript(js) end

-- Saves the current state (caret position and the text inside) of a TextEntry as an undo state.See also Panel:Undo.
function Panel:SaveUndoState() end

-- Translates global screen coordinate to coordinates relative to the panel.See also Panel:LocalToScreen.This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
---@param screenX number
---@param screenY number
function Panel:ScreenToLocal(screenX,screenY) end

-- Selects all items within a panel or object. For text-based objects, selects all text.
function Panel:SelectAll() end

-- If called on a text entry, clicking the text entry for the first time will automatically select all of the text ready to be copied by the user.
function Panel:SelectAllOnFocus() end

-- Duplicate of Panel:SelectAll.Selects all the text in a panel object. Will not select non-text items; for this, use Panel:SelectAll.
function Panel:SelectAllText() end

-- Deselects all items in a panel object. For text-based objects, this will deselect all text.
function Panel:SelectNone() end

-- Sets the achievement to be displayed by AchievementIcon.
---@param id number
function Panel:SetAchievement(id) end

-- Does nothing at all.Used in Button to call a function when the button is clicked and in Slider when the value changes.
---@param func function
function Panel:SetActionFunction(func) end

-- Configures a text input to allow user to type characters that are not included in the US-ASCII (7-bit ASCII) character set.Characters not included in US-ASCII are multi-byte characters in UTF-8. They can be accented characters, non-Latin characters and special characters.
---@param allowed boolean
function Panel:SetAllowNonAsciiCharacters(allowed) end

-- Sets the alpha multiplier for the panel
---@param alpha number
function Panel:SetAlpha(alpha) end

-- Enables or disables animations for the panel object by overriding the PANEL:AnimationThink hook to nil and back.
---@param enable boolean
function Panel:SetAnimationEnabled(enable) end

-- Sets whenever the panel should be removed if the parent was removed.
---@param autoDelete boolean
function Panel:SetAutoDelete(autoDelete) end

-- Sets the background color of a panel such as a RichText, Label or DColorCube.This doesn't apply to all VGUI elements and its function varies between themFor DLabel elements, you must use Panel:SetPaintBackgroundEnabled( true ) before applying the color.This will not work on setup of the panel - you should use this function in a hook like PANEL:ApplySchemeSettings or PANEL:PerformLayout.
---@param r or color number
---@param g number
---@param b number
---@param a number
function Panel:SetBGColor(r or color,g,b,a) end

-- Sets the background color of the panel.
---@param r number
---@param g number
---@param b number
---@param a number
function Panel:SetBGColorEx(r,g,b,a) end

-- Sets the position of the caret (or text cursor) in a text-based panel object.
---@param offset number
function Panel:SetCaretPos(offset) end

-- Sets the action signal command that's fired when a Button is clicked. The hook PANEL:ActionSignal is called as the click response.This has no effect on buttons unless it has had its `AddActionSignalTarget` method called (an internal function not available by default in Garry's Mod LUA).A better alternative is calling Panel:Command when a DButton is clicked.
function Panel:SetCommand() end

-- Sets the alignment of the contents.
---@param alignment number
function Panel:SetContentAlignment(alignment) end

-- This function does not exist on all panelsThis function cannot interact with serverside convars unless you are hostBlocked convars will not work with this, see Blocked ConCommandsSets this panel's convar. When the convar changes this panel will update automatically.For developer implementation, see Global.Derma_Install_Convar_Functions.
---@param convar string
function Panel:SetConVar(convar) end

-- Stores a string in the named cookie using Panel:GetCookieName as prefix.You can also retrieve and modify this cookie by using the cookie. Cookies are stored in this format:```panelCookieName.cookieName```The panel's cookie name MUST be set for this function to work. See Panel:SetCookieName.
---@param cookieName string
---@param value string
function Panel:SetCookie(cookieName,value) end

-- Sets the panel's cookie name. Calls PANEL:LoadCookies if defined.
---@param name string
function Panel:SetCookieName(name) end

-- Sets the appearance of the cursor. You can find a list of all available cursors with image previews [here](https://wiki.facepunch.com/gmod/Cursors).
---@param cursor string
function Panel:SetCursor(cursor) end

-- Sets the drag parent.Drag parent means that when we start to drag this panel, we'll really start dragging the defined parent.
---@param parent Panel
function Panel:SetDragParent(parent) end

-- Makes the panel render in front of all others, including the spawn menu and main menu.Priority is given based on the last call, so of two panels that call this method, the second will draw in front of the first.This only makes the panel **draw** above other panels. If there's another panel that would have otherwise covered it, users will not be able to interact with it.Completely disregards PANEL:ParentToHUD.This does not work when using PANEL:SetPaintedManually or PANEL:PaintAt.
---@param drawOnTop boolean
function Panel:SetDrawOnTop(drawOnTop) end

-- Sets the target area for dropping when an object is being dragged around this panel using the dragndrop.This draws a target box of the specified size and position, until Panel:DragHoverEnd is called. It uses Panel:DrawDragHover to draw this area.
---@param x number
---@param y number
---@param width number
---@param height number
function Panel:SetDropTarget(x,y,width,height) end

-- Sets the enabled state of a disable-able panel object, such as a DButton or DTextEntry.See Panel:IsEnabled for a function that retrieves the "enabled" state of a panel.
---@param enable boolean
function Panel:SetEnabled(enable) end

-- Adds a shadow falling to the bottom right corner of the panel's text. This has no effect on panels that do not derive from Label.
---@param distance number
---@param Color table
function Panel:SetExpensiveShadow(distance,Color) end

-- Sets the foreground color of a panel.For a Label or RichText, this is the color of its text.This function calls Panel:SetFGColorEx internally.This doesn't apply to all VGUI elements (such as DLabel) and its function varies between them
---@param r or color number
---@param g number
---@param b number
---@param a number
function Panel:SetFGColor(r or color,g,b,a) end

-- Sets the foreground color of the panel.For labels, this is the color of their text.
---@param r number
---@param g number
---@param b number
---@param a number
function Panel:SetFGColorEx(r,g,b,a) end

-- Sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy. This function will only work on EditablePanel class panels and its derivatives.
---@param state boolean
function Panel:SetFocusTopLevel(state) end

-- Sets the font used to render this panel's text. This works for Label, TextEntry and RichText, but it's a better idea to use their local `SetFont` (DTextEntry:SetFont, DLabel:SetFont) methods when available.To retrieve the font used by a panel, call Panel:GetFont.
---@param fontName string
function Panel:SetFontInternal(fontName) end

-- Sets the height of the panel.Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).See also Panel:SetSize.
---@param height number
function Panel:SetHeight(height) end

-- Allows you to set HTML code within a panel.
---@param HTML code string
function Panel:SetHTML(HTML code) end

-- Allows or disallows the panel to receive keyboard focus and input. This is recursively applied to all children.
---@param enable boolean
function Panel:SetKeyboardInputEnabled(enable) end

-- Alias of Panel:SetKeyboardInputEnabled(lowercase)Enables or disables the keyboard input for the panel.
---@param keyboardInput boolean
function Panel:SetKeyBoardInputEnabled(keyboardInput) end

-- Sets the maximum character count this panel should have.This function will only work on RichText and TextEntry panels and their derivatives.
---@param maxChar number
function Panel:SetMaximumCharCount(maxChar) end

-- Sets the minimum dimensions of the panel or object.You can restrict either or both values.Calling the function without arguments will remove the minimum size.
---@param minW number
---@param minH number
function Panel:SetMinimumSize(minW,minH) end

-- Sets the model to be displayed by SpawnIcon.This must be called after setting size if you wish to use a different size spawnicon
---@param ModelPath string
---@param skin number
---@param bodygroups string
function Panel:SetModel(ModelPath,skin,bodygroups) end

-- Enables or disables the mouse input for the panel.Panels parented to the context menu will not be clickable unless Panel:SetKeyboardInputEnabled(lowercase) is enabled or Panel:MakePopup has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set Panel:SetKeyboardInputEnabled(lowercase) to false immediately after calling Panel:MakePopup.
---@param mouseInput boolean
function Panel:SetMouseInputEnabled(mouseInput) end

-- Sets the internal name of the panel. Can be retrieved with Panel:GetName.
---@param name string
function Panel:SetName(name) end

-- Sets whenever all the default background of the panel should be drawn or not.
---@param paintBackground boolean
function Panel:SetPaintBackgroundEnabled(paintBackground) end

-- Sets whenever all the default border of the panel should be drawn or not.
---@param paintBorder boolean
function Panel:SetPaintBorderEnabled(paintBorder) end

-- Enables or disables painting of the panel manually with Panel:PaintManual.
---@param paintedManually boolean
function Panel:SetPaintedManually(paintedManually) end

-- This function does nothing.This function does nothing.
function Panel:SetPaintFunction() end

-- Sets the parent of the panel.Panels parented to the context menu will not be clickable unless Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled(lowercase) are both true or Panel:MakePopup has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set Panel:SetKeyboardInputEnabled(lowercase) to false immediately after calling Panel:MakePopup.
---@param parent Panel
function Panel:SetParent(parent) end

-- Used by AvatarImage to load an avatar for given player.
---@param player Player
---@param size number
function Panel:SetPlayer(player,size) end

-- If this panel object has been made a popup with Panel:MakePopup, this method will prevent it from drawing in front of other panels when it receives input focus.
---@param stayAtBack boolean
function Panel:SetPopupStayAtBack(stayAtBack) end

-- Sets the position of the panel's top left corner.This will trigger PANEL:PerformLayout. You should avoid calling this function in PANEL:PerformLayout to avoid infinite loops.See also Panel:SetX and Panel:SetY.If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
---@param posX number
---@param posY number
function Panel:SetPos(posX,posY) end

-- Sets whenever the panel should be rendered in the next screenshot.
---@param renderInScreenshot boolean
function Panel:SetRenderInScreenshots(renderInScreenshot) end

-- Sets whether the panel object can be selected or not (like icons in the Spawn Menu, holding Shift). If enabled, this will affect the function of a DButton whilst Shift is pressed. Panel:SetSelected can be used to select/deselect the object.
---@param selectable boolean
function Panel:SetSelectable(selectable) end

-- Sets the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable.
---@param selected boolean
function Panel:SetSelected(selected) end

-- Enables the panel object for selection (much like the spawn menu).
---@param set boolean
function Panel:SetSelectionCanvas(set) end

-- Sets the size of the panel.Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).See also Panel:SetWidth and Panel:SetHeight.If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
---@param width number
---@param height number
function Panel:SetSize(width,height) end

-- Sets the derma skin that the panel object will use, and refreshes all panels with derma.RefreshSkins.
---@param skinName string
function Panel:SetSkin(skinName) end

-- Sets the `.png` image to be displayed on a  SpawnIcon or the panel it is based on - ModelImage.Only `.png` images can be used with this function.
---@param icon string
function Panel:SetSpawnIcon(icon) end

-- Used by AvatarImage panels to load an avatar by its 64-bit Steam ID (community ID).
---@param steamid string
---@param size number
function Panel:SetSteamID(steamid,size) end

-- When TAB is pressed, the next selectable panel in the number sequence is selected.
---@param position number
function Panel:SetTabPosition(position) end

-- Sets height of a panel. An alias of Panel:SetHeight.
---@param height number
function Panel:SetTall(height) end

-- Removes the panel after given time in seconds.This function will not work if PANEL:AnimationThink is overridden, unless Panel:AnimationThinkInternal is called every frame.
---@param delay number
function Panel:SetTerm(delay) end

-- Sets the text value of a panel object containing text, such as a Label, TextEntry or  RichText and their derivatives, such as DLabel, DTextEntry or DButton.When used on a Label or its derivatives ( DLabel and DButton ), it will automatically call Panel:InvalidateLayout, meaning that you should avoid running this function every frame on these panels to avoid unnecessary performance loss.
---@param text string
function Panel:SetText(text) end

-- Sets the left and top text margins of a text-based panel object, such as a DButton or DLabel.
---@param insetX number
---@param insetY number
function Panel:SetTextInset(insetX,insetY) end

-- Sets text selection colors of a RichText element.
---@param color table
---@param color table
function Panel:SetTextSelectionColors(color,color) end

-- Sets the height of a RichText element to accommodate the text inside.This function internally relies on Panel:GetNumLines, so it should be called at least a couple frames after modifying the text using Panel:AppendText
function Panel:SetToFullHeight() end

-- Sets the tooltip to be displayed when a player hovers over the panel object with their cursor.
---@param str string
function Panel:SetTooltip(str) end

-- Sets the panel to be displayed as contents of a DTooltip when a player hovers over the panel object with their cursor. See Panel:SetTooltipPanelOverride if you are looking to override DTooltip itself.Panel:SetTooltip will override this functionality.Calling this from PANEL:OnCursorEntered is too late! The tooltip will not be displayed or be updated.Given panel or the previously set one will **NOT** be automatically removed.
---@param tooltipPanel Panel
function Panel:SetTooltipPanel(tooltipPanel) end

-- Sets the panel class to be created instead of DTooltip when the player hovers over this panel and a tooltip needs creating.
---@param override string
function Panel:SetTooltipPanelOverride(override) end

-- Sets the underlined font for use by clickable text in a RichText. See also Panel:InsertClickableTextStartThis function will only work on RichText panels.
---@param fontName string
function Panel:SetUnderlineFont(fontName) end

-- Sets the URL of a link-based panel such as DLabelURL.
---@param url string
function Panel:SetURL(url) end

-- Sets the visibility of the vertical scrollbar.Works for RichText and TextEntry.
---@param display boolean
function Panel:SetVerticalScrollbarEnabled(display) end

-- Sets the "visibility" of the panel.
---@param visible boolean
function Panel:SetVisible(visible) end

-- Sets width of a panel. An alias of Panel:SetWidth.
---@param width number
function Panel:SetWide(width) end

-- Sets the width of the panel.Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).See also Panel:SetSize.
---@param width number
function Panel:SetWidth(width) end

-- This makes it so that when you're hovering over this panel you can `click` on the world. Your viewmodel will aim etc. This is primarily used for the Sandbox context menu.This function doesn't scale with custom FOV specified by GM:CalcView or WEAPON:TranslateFOV.
---@param enabled boolean
function Panel:SetWorldClicker(enabled) end

-- Sets whether text wrapping should be enabled or disabled on Label and DLabel panels.Use DLabel:SetAutoStretchVertical to automatically correct vertical size; Panel:SizeToContents will not set the correct height.
---@param wrap boolean
function Panel:SetWrap(wrap) end

-- Sets the X position of the panel.Uses Panel:SetPos internally.
---@param x number
function Panel:SetX(x) end

-- Sets the Y position of the panel.Uses Panel:SetPos internally.
---@param y number
function Panel:SetY(y) end

-- Sets the panels z position which determines the rendering order.Panels with lower z positions appear behind panels with higher z positions.This also controls in which order panels docked with Panel:Dock appears.
---@param zIndex number
function Panel:SetZPos(zIndex) end

-- Makes a panel visible.
function Panel:Show() end

-- Uses animation to resize the panel to the specified size.
---@param sizeW number
---@param sizeH number
---@param time number
---@param delay number
---@param ease number
---@param callback function
function Panel:SizeTo(sizeW,sizeH,time,delay,ease,callback) end

-- Resizes the panel to fit the bounds of its children.Your panel must have its layout updated (Panel:InvalidateLayout) for this function to work properly.The sizeW and sizeH parameters are false by default. Therefore, calling this function with no arguments will result in a no-op.
---@param sizeW boolean
---@param sizeH boolean
function Panel:SizeToChildren(sizeW,sizeH) end

-- Resizes the panel so that its width and height fit all of the content inside.Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.You must call this function **AFTER** setting text/font, adjusting child panels or otherwise altering the panel.
function Panel:SizeToContents() end

-- Resizes the panel object's width to accommodate all child objects/contents.Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.You must call this function **AFTER** setting text/font or adjusting child panels.
---@param addVal number
function Panel:SizeToContentsX(addVal) end

-- Resizes the panel object's height to accommodate all child objects/contents.Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.You must call this function **AFTER** setting text/font or adjusting child panels.
---@param addVal number
function Panel:SizeToContentsY(addVal) end

-- Slides the panel in from above.
---@param Length number
function Panel:SlideDown(Length) end

-- Slides the panel out to the top.
---@param Length number
function Panel:SlideUp(Length) end

-- Begins a box selection, enables mouse capture for the panel object, and sets the start point of the selection box to the mouse cursor's position, relative to this object. For this to work, either the object or its parent must be enabled as a selection canvas. This is set using Panel:SetSelectionCanvas.
function Panel:StartBoxSelection() end

-- Stops all panel animations by clearing its animation list. This also clears all delayed animations.
function Panel:Stop() end

-- Resizes the panel object's height so that its bottom is aligned with the top of the passed panel. An offset greater than zero will reduce the panel's height to leave a gap between it and the passed panel.
---@param tgtPanel Panel
---@param offset number
function Panel:StretchBottomTo(tgtPanel,offset) end

-- Resizes the panel object's width so that its right edge is aligned with the left of the passed panel. An offset greater than zero will reduce the panel's width to leave a gap between it and the passed panel.
---@param tgtPanel Panel
---@param offset number
function Panel:StretchRightTo(tgtPanel,offset) end

-- Sets the dimensions of the panel to fill its parent. It will only stretch in directions that aren't nil.
---@param offsetLeft number
---@param offsetTop number
---@param offsetRight number
---@param offsetBottom number
function Panel:StretchToParent(offsetLeft,offsetTop,offsetRight,offsetBottom) end

-- Toggles the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable. To check whether the object is selected or not, Panel:IsSelected is used.
function Panel:ToggleSelection() end

-- Toggles the visibility of a panel and all its children.
function Panel:ToggleVisible() end

-- Restores the last saved state (caret position and the text inside) of a TextEntry. Should act identically to pressing CTRL+Z in a TextEntry.See also Panel:SaveUndoState.
function Panel:Undo() end

-- Recursively deselects this panel object and all of its children. This will cascade to all child objects at every level below the parent.
function Panel:UnselectAll() end

-- Forcibly updates the panels' HTML Material, similar to when Paint is called on it.This is only useful if the panel is not normally visible, i.e the panel exists purely for its HTML Material.Only works on with panels that have a HTML Material. See Panel:GetHTMLMaterial for more details.A good place to call this is in the GM:PreRender hook
function Panel:UpdateHTMLTexture() end

-- Use Panel:IsValid instead.Returns if a given panel is valid or not.
function Panel:Valid() end



---@class PathFollower
PathFollower = PathFollower

-- If you created your path with type "Chase" this functions should be used in place of PathFollower:Update to cause the bot to chase the specified entity.
---@param bot NextBot
---@param ent Entity
function PathFollower:Chase(bot,ent) end

-- Compute shortest path from bot to 'goal' via A* algorithm.
---@param from NextBot
---@param to Vector
---@param generator function
function PathFollower:Compute(from,to,generator) end

-- Draws the path. This is meant for debugging - and uses debug overlay.
function PathFollower:Draw() end

-- Returns the first segment of the path.
function PathFollower:FirstSegment() end

-- Returns the age since the path was built
function PathFollower:GetAge() end

-- Returns all of the segments of the given path.
function PathFollower:GetAllSegments() end

-- The closest position along the path to a position
---@param position Vector
function PathFollower:GetClosestPosition(position) end

-- Returns the current goal data. Can return nil if the current goal is invalid, for example immediately after PathFollower:Update.
function PathFollower:GetCurrentGoal() end

-- Returns the cursor data
function PathFollower:GetCursorData() end

-- Returns the current progress along the path
function PathFollower:GetCursorPosition() end

-- Returns the path end position
function PathFollower:GetEnd() end

-- Returns how close we can get to the goal to call it done.
function PathFollower:GetGoalTolerance() end

function PathFollower:GetHindrance() end

-- Returns the total length of the path
function PathFollower:GetLength() end

-- Returns the minimum range movement goal must be along path.
function PathFollower:GetMinLookAheadDistance() end

-- Returns the vector position of distance along path
---@param distance number
function PathFollower:GetPositionOnPath(distance) end

-- Returns the path start position
function PathFollower:GetStart() end

-- Invalidates the current path
function PathFollower:Invalidate() end

-- Returns true if the path is valid
function PathFollower:IsValid() end

-- Returns the last segment of the path.
function PathFollower:LastSegment() end

-- Moves the cursor by give distance.For a function that sets the distance, see PathFollower:MoveCursorTo.
---@param distance number
function PathFollower:MoveCursor(distance) end

-- Sets the cursor position to given distance.For relative distance, see PathFollower:MoveCursor.
---@param distance number
function PathFollower:MoveCursorTo(distance) end

-- Moves the cursor of the path to the closest position compared to given vector.
---@param pos Vector
---@param type number
---@param alongLimit number
function PathFollower:MoveCursorToClosestPosition(pos,type,alongLimit) end

-- Moves the cursor to the end of the path
function PathFollower:MoveCursorToEnd() end

-- Moves the cursor to the end of the path
function PathFollower:MoveCursorToStart() end

-- Resets the age which is retrieved by PathFollower:GetAge to 0.
function PathFollower:ResetAge() end

-- How close we can get to the goal to call it done
---@param distance number
function PathFollower:SetGoalTolerance(distance) end

-- Sets minimum range movement goal must be along path
---@param mindist number
function PathFollower:SetMinLookAheadDistance(mindist) end

-- Move the bot along the path.
---@param bot NextBot
function PathFollower:Update(bot) end



---@class PhysCollide
PhysCollide = PhysCollide

-- Destroys the PhysCollide object.
function PhysCollide:Destroy() end

-- Checks whether this PhysCollide object is valid or not.You should just use Global.IsValid instead.
function PhysCollide:IsValid() end

-- Performs a trace against this PhysCollide with the given parameters. This can be used for both line traces and box traces.
---@param origin Vector
---@param angles Angle
---@param rayStart Vector
---@param rayEnd Vector
---@param rayMins Vector
---@param rayMaxs Vector
function PhysCollide:TraceBox(origin,angles,rayStart,rayEnd,rayMins,rayMaxs) end



---@class PhysObj
PhysObj = PhysObj

-- Adds the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) velocity to the current PhysObj.
---@param angularVelocity Vector
function PhysObj:AddAngleVelocity(angularVelocity) end

-- Adds one or more bit flags.
---@param flags number
function PhysObj:AddGameFlag(flags) end

-- Adds the specified velocity to the current.
---@param velocity Vector
function PhysObj:AddVelocity(velocity) end

-- Rotates the object so that it's angles are aligned to the ones inputted.
---@param from Angle
---@param to Angle
function PhysObj:AlignAngles(from,to) end

-- Applies the specified impulse in the mass center of the physics object.This will not work on players, use Entity:SetVelocity instead.
---@param impulse Vector
function PhysObj:ApplyForceCenter(impulse) end

-- Applies the specified impulse on the physics object at the specified position.
---@param impulse Vector
---@param position Vector
function PhysObj:ApplyForceOffset(impulse,position) end

-- Applies the specified angular impulse to the physics object. See PhysObj:CalculateForceOffset
---@param angularImpulse Vector
function PhysObj:ApplyTorqueCenter(angularImpulse) end

-- Calculates the linear and angular impulse on the object's center of mass for an offset impulse.The outputs can be used with PhysObj:ApplyForceCenter and PhysObj:ApplyTorqueCenter, respectively. **Be careful to convert the angular impulse to world frame (PhysObj:LocalToWorldVector) if you are going to use it with ApplyTorqueCenter.**
---@param impulse Vector
---@param position Vector
function PhysObj:CalculateForceOffset(impulse,position) end

-- Calculates the linear and angular velocities on the center of mass for an offset impulse. The outputs can be directly passed to PhysObj:AddVelocity and PhysObj:AddAngleVelocity, respectively.This will return zero length vectors if the physics object's motion is disabled. See PhysObj:IsMotionEnabled.
---@param impulse Vector
---@param position Vector
function PhysObj:CalculateVelocityOffset(impulse,position) end

-- Removes one of more specified flags.
---@param flags number
function PhysObj:ClearGameFlag(flags) end

-- Allows you to move a PhysObj to a point and angle in 3D space.
---@param shadowparams table
function PhysObj:ComputeShadowControl(shadowparams) end

-- Sets whether the physics object should collide with anything or not, including world.This function currently has major problems with player collisions, and as such should be avoided at all costs.A better alternative to this function would be using Entity:SetCollisionGroup( COLLISION_GROUP_WORLD ).
---@param enable boolean
function PhysObj:EnableCollisions(enable) end

-- Sets whenever the physics object should be affected by drag.
---@param enable boolean
function PhysObj:EnableDrag(enable) end

-- Sets whether the PhysObject should be affected by gravity
---@param enable boolean
function PhysObj:EnableGravity(enable) end

-- Sets whether the physobject should be able to move or not.This is the exact method the Physics Gun uses to freeze props. If a motion-disabled physics object is grabbed with the physics gun, the object will be able to move again. To disallow this, use GM:PhysgunPickup.
---@param enable boolean
function PhysObj:EnableMotion(enable) end

-- Returns the mins and max of the physics object.
function PhysObj:GetAABB() end

-- Returns the angles of the physics object in degrees.
function PhysObj:GetAngles() end

-- Gets the angular velocity of the object in degrees per second as a local vector. You can use dot product to read the magnitude from a specific axis.
function PhysObj:GetAngleVelocity() end

-- Returns the contents flag of the PhysObj.
function PhysObj:GetContents() end

-- Returns the linear and angular damping of the physics object.
function PhysObj:GetDamping() end

-- Returns the sum of the linear and rotational kinetic energies of the physics object.
function PhysObj:GetEnergy() end

-- Returns the parent entity of the physics object.
function PhysObj:GetEntity() end

-- Returns the friction snapshot of this physics object. This is useful for determining if an object touching ground for example.
function PhysObj:GetFrictionSnapshot() end

-- Returns the principal moments of inertia `(Ixx, Iyy, Izz)` of the physics object, in the local frame, with respect to the center of mass.
function PhysObj:GetInertia() end

-- Returns 1 divided by the angular inertia. See PhysObj:GetInertia
function PhysObj:GetInvInertia() end

-- Returns 1 divided by the physics object's mass (in kilograms).
function PhysObj:GetInvMass() end

-- Returns the mass of the physics object.
function PhysObj:GetMass() end

-- Returns the center of mass of the physics object as a local vector.
function PhysObj:GetMassCenter() end

-- Returns the physical material of the physics object.
function PhysObj:GetMaterial() end

-- Returns the physics mesh of the object which is used for physobj-on-physobj collision.
function PhysObj:GetMesh() end

-- Returns all convex physics meshes of the object. See Entity:PhysicsInitMultiConvex for more information.
function PhysObj:GetMeshConvexes() end

-- Returns the name of the physics object.
function PhysObj:GetName() end

-- Returns the position of the physics object.
function PhysObj:GetPos() end

-- Returns the position and angle of the physics object as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.
function PhysObj:GetPositionMatrix() end

-- Returns the rotation damping of the physics object.
function PhysObj:GetRotDamping() end

-- Returns the angles of the PhysObj shadow. See PhysObj:UpdateShadow.
function PhysObj:GetShadowAngles() end

-- Returns the position of the PhysObj shadow. See PhysObj:UpdateShadow.
function PhysObj:GetShadowPos() end

-- Returns the speed damping of the physics object.
function PhysObj:GetSpeedDamping() end

-- Returns the internal and external stress of the entity.
function PhysObj:GetStress() end

-- Returns the surface area of the physics object in source-units². Or nil if the PhysObj is a generated sphere or box.
function PhysObj:GetSurfaceArea() end

-- Returns the absolute directional velocity of the physobject.
function PhysObj:GetVelocity() end

-- Returns the world velocity of a point in world coordinates about the object. This is useful for objects rotating around their own axis/origin.
---@param point Vector
function PhysObj:GetVelocityAtPoint(point) end

-- Returns the volume in source units³. Or nil if the PhysObj is a generated sphere or box.
function PhysObj:GetVolume() end

-- Returns whenever the specified flag(s) is/are set.
---@param flags number
function PhysObj:HasGameFlag(flags) end

-- Returns whether the physics object is "sleeping".See PhysObj:Sleep for more information.
function PhysObj:IsAsleep() end

-- Returns whenever the entity is able to collide or not.
function PhysObj:IsCollisionEnabled() end

-- Returns whenever the entity is affected by drag.
function PhysObj:IsDragEnabled() end

-- Returns whenever the entity is affected by gravity.
function PhysObj:IsGravityEnabled() end

-- Returns if the physics object can move itself (by velocity, acceleration)
function PhysObj:IsMotionEnabled() end

-- Returns whenever the entity is able to move.
function PhysObj:IsMoveable() end

-- Returns whenever the physics object is penetrating another physics object.This is internally implemented as `PhysObj:HasGameFlag( FVPHYSICS_PENETRATING )` and thus is only updated for non-static physics objects.
function PhysObj:IsPenetrating() end

-- Returns if the physics object is valid/not NULL.
function PhysObj:IsValid() end

-- Mapping a vector in local frame of the physics object to world frame.this function does translation and rotation, with translation done first.
---@param LocalVec Vector
function PhysObj:LocalToWorld(LocalVec) end

-- Rotate a vector from the local frame of the physics object to world frame.This function only rotates the vector, without any translation operation.
---@param LocalVec Vector
function PhysObj:LocalToWorldVector(LocalVec) end

-- Prints debug info about the state of the physics object to the console.
function PhysObj:OutputDebugInfo() end

-- Call this when the collision filter conditions change due to this object's state (e.g. changing solid type or collision group)
function PhysObj:RecheckCollisionFilter() end

-- A convinience function for Angle:RotateAroundAxis.
---@param dir Vector
---@param ang number
function PhysObj:RotateAroundAxis(dir,ang) end

-- Sets the amount of [drag](https://en.wikipedia.org/wiki/Drag_(physics)) to apply to a physics object when attempting to rotate.
---@param coefficient number
function PhysObj:SetAngleDragCoefficient(coefficient) end

-- Sets the angles of the physobject in degrees.
---@param angles Angle
function PhysObj:SetAngles(angles) end

-- Sets the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the PhysObj
---@param angularVelocity Vector
function PhysObj:SetAngleVelocity(angularVelocity) end

-- Sets the specified instantaneous [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the PhysObj
---@param angularVelocity Vector
function PhysObj:SetAngleVelocityInstantaneous(angularVelocity) end

-- Sets the buoyancy ratio of the physics object. (How well it floats in water)
---@param buoyancy number
function PhysObj:SetBuoyancyRatio(buoyancy) end

-- Sets the contents flag of the PhysObj.
---@param contents number
function PhysObj:SetContents(contents) end

-- Sets the linear and angular damping of the physics object.
---@param linearDamping number
---@param angularDamping number
function PhysObj:SetDamping(linearDamping,angularDamping) end

-- Modifies how much drag (air resistance) affects the object.
---@param drag number
function PhysObj:SetDragCoefficient(drag) end

-- Sets the angular inertia. See PhysObj:GetInertia.This does not affect linear inertia.
---@param angularInertia Vector
function PhysObj:SetInertia(angularInertia) end

-- Sets the mass of the physics object.
---@param mass number
function PhysObj:SetMass(mass) end

-- Sets the material of the physobject.Impact sounds will only change if this is called on client
---@param materialName string
function PhysObj:SetMaterial(materialName) end

-- Sets the position of the physobject.
---@param position Vector
---@param teleport boolean
function PhysObj:SetPos(position,teleport) end

-- Sets the velocity of the physics object for the next iteration.
---@param velocity Vector
function PhysObj:SetVelocity(velocity) end

-- Sets the velocity of the physics object.
---@param velocity Vector
function PhysObj:SetVelocityInstantaneous(velocity) end

-- Makes the physics object "sleep".The physics object will no longer be moving unless it is "woken up" by either a collision with another moving object, or by PhysObj:Wake. This is an optimization feature of the physics engine.
function PhysObj:Sleep() end

-- Unlike PhysObj:SetPos and PhysObj:SetAngles, this allows the movement of a physobj while leaving physics interactions intact.This is used internally by the motion controller of the Gravity Gun , the +use pickup and the Physics Gun, and entities such as the crane.This is the ideal function to move a physics shadow created with Entity:PhysicsInitShadow or Entity:MakePhysicsObjectAShadow.
---@param targetPosition Vector
---@param targetAngles Angle
---@param frameTime number
function PhysObj:UpdateShadow(targetPosition,targetAngles,frameTime) end

-- Wakes the physics object.See PhysObj:Sleep for more information.
function PhysObj:Wake() end

-- Converts a vector to a relative to the physics object coordinate system.
---@param vec Vector
function PhysObj:WorldToLocal(vec) end

-- Rotate a vector from the world frame to the local frame of the physics object.This function only rotates the vector, without any translation operation.
---@param WorldVec Vector
function PhysObj:WorldToLocalVector(WorldVec) end



---@class pixelvis_handle_t
pixelvis_handle_t = pixelvis_handle_t



---@class Player
Player = Player

-- Returns the player's AccountID aka SteamID3. (`[U:1:AccountID]`)See Player:SteamID for the text representation of the full SteamID.See Player:SteamID64 for a 64bit representation of the full SteamID.Unlike other variations of SteamID, SteamID3 does not include the "Account Type" and "Account Instance" part of the SteamID.In a `-multirun` environment, this will return `no value` for all "copies" of a player because they are not authenticated with Steam.For bots this will return values starting with `0` for the first bot, `1` for the second bot and so on.
function Player:AccountID() end

-- Adds an entity to the player's clean up list.
---@param type string
---@param ent Entity
function Player:AddCleanup(type,ent) end

-- See [GetCount](/gmod/Player:GetCount) for list of typesAdds an entity to the total count of entities of same type.
---@param str string
---@param ent Entity
function Player:AddCount(str,ent) end

-- Add a certain amount to the player's death count
---@param count number
function Player:AddDeaths(count) end

-- Add a certain amount to the player's frag count (or kills count)
---@param count number
function Player:AddFrags(count) end

-- Adds a entity to the player's list of frozen objects.
---@param ent Entity
---@param physobj PhysObj
function Player:AddFrozenPhysicsObject(ent,physobj) end

-- Sets up the voting system for the player.This is a really barebone system. By calling this a vote gets started, when the player presses 0-9 the callback function gets called along with the key the player pressed. Use the draw callback to draw the vote panel.
---@param name string
---@param timeout number
---@param vote_callback function
---@param draw_callback function
function Player:AddPlayerOption(name,timeout,vote_callback,draw_callback) end

-- Plays a sequence directly from a sequence number, similar to Player:AnimRestartGesture. This function has the advantage to play sequences that haven't been bound to an existing Enums/ACT
---@param slot number
---@param sequenceId number
---@param cycle number
---@param autokill boolean
function Player:AddVCDSequenceToGestureSlot(slot,sequenceId,cycle,autokill) end

-- Checks if the player is alive.
function Player:Alive() end

-- Sets if the player can toggle their flashlight. Function exists on both the server and client but has no effect when ran on the client.
---@param canFlashlight boolean
function Player:AllowFlashlight(canFlashlight) end

-- Lets the player spray their decal without delay
---@param allow boolean
function Player:AllowImmediateDecalPainting(allow) end

-- Resets player gesture in selected slot.
---@param slot number
function Player:AnimResetGestureSlot(slot) end

-- Restart a gesture on a player, within a gesture slot.This is not automatically networked. This function has to be called on the client to be seen by said client.
---@param slot number
---@param activity number
---@param autokill boolean
function Player:AnimRestartGesture(slot,activity,autokill) end

-- Restarts the main animation on the player, has the same effect as calling Entity:SetCycle( 0 ).
function Player:AnimRestartMainSequence() end

-- Sets the sequence of the animation playing in the given gesture slot.
---@param slot number
---@param sequenceID number
function Player:AnimSetGestureSequence(slot,sequenceID) end

-- Sets the weight of the animation playing in the given gesture slot.
---@param slot number
---@param weight number
function Player:AnimSetGestureWeight(slot,weight) end

-- Returns the player's armor.
function Player:Armor() end

-- Bans the player from the server for a certain amount of minutes.
---@param minutes number
---@param kick boolean
function Player:Ban(minutes,kick) end

-- Returns true if the player's flashlight hasn't been disabled by Player:AllowFlashlight.This is not synchronized between clients and server automatically!
function Player:CanUseFlashlight() end

-- Prints a string to the chatbox of the client.Just like the usermessage, this function is affected by the 255 byte limit!
---@param message string
function Player:ChatPrint(message) end

-- Checks if the limit is hit or not. If it is, it will throw a notification saying so.
---@param limitType string
function Player:CheckLimit(limitType) end

-- Runs the concommand on the player. This does not work on bots.If you wish to directly modify the movement input of bots, use GM:StartCommand instead.Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see Blocked ConCommands.On clientside running a ConCommand on an other player will not throw any warnings or errors but will run the ConCommand on LocalPlayer() instead.
---@param command string
function Player:ConCommand(command) end

-- Creates the player's death ragdoll entity and deletes the old one.This is normally used when a player dies, to create their death ragdoll.The ragdoll will be created with the player's properties such as Entity:GetPos, Entity:GetAngles, Player:GetPlayerColor, Entity:GetVelocity and Entity:GetModel.You can retrieve the entity this creates with Player:GetRagdollEntity.
function Player:CreateRagdoll() end

-- Disables the default player's crosshair. Can be reenabled with Player:CrosshairEnable. This will affect WEAPON:DoDrawCrosshair.
function Player:CrosshairDisable() end

-- Enables the player's crosshair, if it was previously disabled via Player:CrosshairDisable.
function Player:CrosshairEnable() end

-- Returns whether the player is crouching or not (Enums/FL flag).
function Player:Crouching() end

-- Returns the player's death count
function Player:Deaths() end

-- Prints the players' name and position to the console.
function Player:DebugInfo() end

-- Detonates all tripmines belonging to the player.
function Player:DetonateTripmines() end

-- Disables world clicking for given player. See Panel:SetWorldClicker and Player:IsWorldClickingDisabled.
---@param disable boolean
function Player:DisableWorldClicking(disable) end

-- Sends a third person animation event to the player.Calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event, data as the given data.
---@param data number
function Player:DoAnimationEvent(data) end

-- Starts the player's attack animation. The attack animation is determined by the weapon's HoldType.Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoAttackEvent() end

-- Sends a specified third person animation event to the player.Calls GM:DoAnimationEvent with specified arguments.
---@param event number
---@param data number
function Player:DoCustomAnimEvent(event,data) end

-- Sends a third person reload animation event to the player.Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoReloadEvent() end

-- Sends a third person secondary fire animation event to the player.Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoSecondaryAttack() end

-- Show/Hide the player's weapon's viewmodel.
---@param draw boolean
---@param vm number
function Player:DrawViewModel(draw,vm) end

-- Show/Hide the player's weapon's worldmodel.
---@param draw boolean
function Player:DrawWorldModel(draw) end

-- Drops the players' weapon of a specific class.
---@param class string
---@param target Vector
---@param velocity Vector
function Player:DropNamedWeapon(class,target,velocity) end

-- Drops any object the player is currently holding with either gravitygun or +Use (E key)
function Player:DropObject() end

-- Forces the player to drop the specified weapon
---@param weapon Weapon
---@param target Vector
---@param velocity Vector
function Player:DropWeapon(weapon,target,velocity) end

-- Enters the player into specified vehicle
---@param vehicle Vehicle
function Player:EnterVehicle(vehicle) end

-- Equips the player with the HEV suit.Allows the player to zoom, walk slowly, sprint, pickup armor batteries, use the health and armor stations and also shows the HUD.The player also emits a flatline sound on death, which can be overridden with GM:PlayerDeathSound.The player is automatically equipped with the suit on spawn, if you wish to stop that, use Player:RemoveSuit.
function Player:EquipSuit() end

-- Makes the player exit the vehicle if they're in one.
function Player:ExitVehicle() end

-- Enables/Disables the player's flashlight.Player:CanUseFlashlight must be true in order for the player's flashlight to be changed.
---@param isOn boolean
function Player:Flashlight(isOn) end

-- Returns true if the player's flashlight is on.
function Player:FlashlightIsOn() end

-- Returns the amount of frags a player has.The value will change depending on the player's kill or suicide: +1 for a kill, -1 for a suicide. 
function Player:Frags() end

-- Freeze the player. Frozen players cannot move, look around, or attack. Key bindings are still called. Similar to Player:Lock but the player can still take damage.Adds or removes the Enums/FL flag from the player.Frozen bots will still be able to look around.
---@param frozen boolean
function Player:Freeze(frozen) end

-- Returns the player's active weapon.If used on a Global.LocalPlayer() and the player is spectating another player with `OBS_MODE_IN_EYE`, the weapon returned will be of the spectated player.
function Player:GetActiveWeapon() end

-- Returns the player's current activity.
function Player:GetActivity() end

-- Returns the direction that the player is aiming.
function Player:GetAimVector() end

-- Returns true if the players' model is allowed to rotate around the pitch and roll axis.
function Player:GetAllowFullRotation() end

-- Returns whether the player is allowed to use their weapons in a vehicle or not.
function Player:GetAllowWeaponsInVehicle() end

-- Returns a table of all ammo the player has.
function Player:GetAmmo() end

-- Gets the amount of ammo the player has.
---@param ammotype any
function Player:GetAmmoCount(ammotype) end

-- Gets if the player will be pushed out of nocollided players.
function Player:GetAvoidPlayers() end

-- Returns true if the player is able to walk using the (default) alt key.
function Player:GetCanWalk() end

-- Determines whenever the player is allowed to use the zoom functionality.
function Player:GetCanZoom() end

-- Returns the player's class id.
function Player:GetClassID() end

-- Gets total count of entities of same type.Default types:```balloonsbuttonscamerasdynamiteemittershoverballslampslightspropsragdollsthrusterswheels```
---@param type string
---@param minus number
function Player:GetCount(type,minus) end

-- Returns the crouched walk speed multiplier.See also Player:GetWalkSpeed and Player:SetCrouchedWalkSpeed.
function Player:GetCrouchedWalkSpeed() end

-- Returns the last command which was sent by the specified player. This can only be called on the player which Global.GetPredictionPlayer() returns.When called clientside in singleplayer during WEAPON:Think, it will return nothing as the hook is not technically predicted in that instance. See the note on the page.This will fail in GM:StartCommand.
function Player:GetCurrentCommand() end

-- Gets the **actual** view offset which equals the difference between the players actual position and their view when standing.Do not confuse with Player:GetViewOffset and Player:GetViewOffsetDucked
function Player:GetCurrentViewOffset() end

-- Gets the entity the player is currently driving via the drive library.
function Player:GetDrivingEntity() end

-- Returns driving mode of the player. See Entity Driving.
function Player:GetDrivingMode() end

-- Returns a player's duck speed (in seconds)
function Player:GetDuckSpeed() end

-- Returns the entity the player is currently using, like func_tank mounted turrets or +use prop pickups.
function Player:GetEntityInUse() end

-- Returns a table with information of what the player is looking at.The results of this function are **cached** clientside every frame.Uses util.GetPlayerTrace internally and is therefore bound by its limits.See also Player:GetEyeTraceNoCursor.
function Player:GetEyeTrace() end

-- Returns the trace according to the players view direction, ignoring their mouse (holding C and moving the mouse in Sandbox).The results of this function are **cached** clientside every frame.Uses util.GetPlayerTrace internally and is therefore bound by its limits.See also Player:GetEyeTrace.
function Player:GetEyeTraceNoCursor() end

-- Returns the FOV of the player.
function Player:GetFOV() end

-- Returns the steam "relationship" towards the player.
function Player:GetFriendStatus() end

-- Gets the hands entity of a player
function Player:GetHands() end

-- Returns the widget the player is hovering with their mouse.
function Player:GetHoveredWidget() end

-- Gets the bottom base and the top base size of the player's hull.
function Player:GetHull() end

-- Gets the bottom base and the top base size of the player's crouch hull.
function Player:GetHullDuck() end

-- Retrieves the value of a client-side ConVar. The ConVar must have a Enums/FCVAR flag for this to work.The returned value is truncated to 31 bytes.On client this function will return value of the local player, regardless of which player the function was called on!
---@param cVarName string
function Player:GetInfo(cVarName) end

-- Retrieves the numeric value of a client-side convar, returns nil if value is not convertible to a number. The ConVar must have a Enums/FCVAR flag for this to work.
---@param cVarName string
---@param default number
function Player:GetInfoNum(cVarName,default) end

-- Returns the jump power of the player
function Player:GetJumpPower() end

-- Returns the player's ladder climbing speed.See Player:GetWalkSpeed for normal walking speed, Player:GetRunSpeed for sprinting speed and Player:GetSlowWalkSpeed for slow walking speed.
function Player:GetLadderClimbSpeed() end

-- Returns the timescale multiplier of the player movement.
function Player:GetLaggedMovementValue() end

-- Returns the maximum amount of armor the player should have. Default value is 100.
function Player:GetMaxArmor() end

-- Returns the player's maximum movement speed.See also Player:SetMaxSpeed, Player:GetWalkSpeed and Player:GetRunSpeed.
function Player:GetMaxSpeed() end

-- Returns the player's name, this is an alias of Player:Nick.This function overrides Entity:GetName (in the Lua metatable, not in c++), keep it in mind when dealing with ents.FindByName or any engine function which requires the mapping name.
function Player:GetName() end

-- Returns whenever the player is set not to collide with their teammates.
function Player:GetNoCollideWithTeammates() end

-- Returns the the observer mode of the player
function Player:GetObserverMode() end

-- Returns the entity the player is currently observing.Set using Player:SpectateEntity.
function Player:GetObserverTarget() end

-- Returns a **P**layer **Data** key-value pair from the SQL database. (sv.db when called on server,  cl.db when called on client)Internally uses the sql.This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.PData is not networked from servers to clients!
---@param key string
---@param default any
function Player:GetPData(key,default) end

-- Returns a player model's color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
function Player:GetPlayerColor() end

-- Returns a table containing player information.
function Player:GetPlayerInfo() end

-- Returns the preferred carry angles of an object, if any are set.Calls GM:GetPreferredCarryAngles with the target entity and returns the carry angles.
---@param carryEnt Entity
function Player:GetPreferredCarryAngles(carryEnt) end

-- Returns the widget entity the player is using.Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.
function Player:GetPressedWidget() end

-- Returns the weapon the player previously had equipped.
function Player:GetPreviousWeapon() end

-- You should use Player:GetViewPunchAngles instead.Returns players screen punch effect angle. See Player:ViewPunch and Player:SetViewPunchAngles
function Player:GetPunchAngle() end

-- Returns players death ragdoll. The ragdoll is created by Player:CreateRagdoll.
function Player:GetRagdollEntity() end

-- Returns the render angles for the player.
function Player:GetRenderAngles() end

-- Returns the player's sprint speed.See also Player:SetRunSpeed, Player:GetWalkSpeed and Player:GetMaxSpeed.
function Player:GetRunSpeed() end

-- Returns the position of a Player's viewThis is the same as calling Entity:EyePos on the player.
function Player:GetShootPos() end

-- Returns the player's slow walking speed, which is activated via +WALK keybind.See Player:GetWalkSpeed for normal walking speed, Player:GetRunSpeed for sprinting speed and Player:GetLadderClimbSpeed for ladder climb speed.
function Player:GetSlowWalkSpeed() end

-- Returns the maximum height player can step onto.
function Player:GetStepSize() end

-- Returns the player's HEV suit power.This will only work for the local player when used clientside.
function Player:GetSuitPower() end

-- Returns the number of seconds that the player has been timing out for. You can check if a player is timing out with Player:IsTimingOut.This function is relatively useless because it is tied to the value of the `sv_timeout` ConVar, which is irrelevant to the description above. [This is not considered as a bug](https://discord.com/channels/565105920414318602/567617926991970306/748970396224585738).
function Player:GetTimeoutSeconds() end

-- Returns Structures/TOOL table of players current tool, or of the one specified.
---@param mode string
function Player:GetTool(mode) end

-- Returns a player's unduck speed (in seconds)
function Player:GetUnDuckSpeed() end

-- Returns the entity the player would use if they would press their `+use` keybind.Because entity physics objects usually do not exist on the client, the client's use entity will resolve to whatever the crosshair is placed on within a little less than 72 units of the player's eye position. This differs from the entity returned by the server, which has fully physical use checking. See util.TraceHull.Issue tracker: [5027](https://github.com/Facepunch/garrysmod-issues/issues/5027)
function Player:GetUseEntity() end

-- Returns the player's user group. By default, player user groups are loaded from `garrysmod/settings/users.txt`.
function Player:GetUserGroup() end

-- Gets the vehicle the player is driving, returns NULL ENTITY if the player is not driving.
function Player:GetVehicle() end

-- Returns the entity the player is using to see from (such as the player itself, the camera, or another entity).This function will return a [NULL Entity] until Player:SetViewEntity has been used
function Player:GetViewEntity() end

-- Returns the player's view model entity by the index.Each player has 3 view models by default, but only the first one is used.To use the other viewmodels in your SWEP, see Entity:SetWeaponModel.In the Client States, other players' viewmodels are not available unless they are being spectated.
---@param index number
function Player:GetViewModel(index) end

-- Returns the view offset of the player which equals the difference between the players actual position and their view.See also Player:GetViewOffsetDucked.
function Player:GetViewOffset() end

-- Returns the view offset of the player which equals the difference between the players actual position and their view when ducked.See also Player:GetViewOffset.
function Player:GetViewOffsetDucked() end

-- Returns players screen punch effect angle.
function Player:GetViewPunchAngles() end

-- Returns client's view punch velocity. See Player:ViewPunch and Player:SetViewPunchVelocity
function Player:GetViewPunchVelocity() end

-- Returns the current voice volume scale for given player on client.
function Player:GetVoiceVolumeScale() end

-- Returns the player's normal walking speed. Not sprinting, not slow walking. (+walk)See also Player:SetWalkSpeed, Player:GetMaxSpeed and Player:GetRunSpeed.
function Player:GetWalkSpeed() end

-- Returns the weapon for the specified class
---@param className string
function Player:GetWeapon(className) end

-- Returns a player's weapon color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
function Player:GetWeaponColor() end

-- Returns a table of the player's weapons.
function Player:GetWeapons() end

-- Gives the player a weapon.While this function is meant for weapons/pickupables only, it is **not** restricted to weapons. Any entity can be spawned using this function, including NPCs and SENTs.
---@param weaponClassName string
---@param bNoAmmo boolean
function Player:Give(weaponClassName,bNoAmmo) end

-- Gives ammo to a player
---@param amount number
---@param type any
---@param hidePopup boolean
function Player:GiveAmmo(amount,type,hidePopup) end

-- Disables god mode on the player.
function Player:GodDisable() end

-- Enables god mode on the player.
function Player:GodEnable() end

-- Returns whether the player has god mode or not, contolled by Player:GodEnable and Player:GodDisable.This is not synced between the client and server. This will cause the client to always return false even in godmode.
function Player:HasGodMode() end

-- Returns if the player has the specified weapon
---@param className string
function Player:HasWeapon(className) end

-- Returns if the player is in a vehicle
function Player:InVehicle() end

-- Returns the player's IP address and connection port in ip:port formReturns `Error!` for bots.
function Player:IPAddress() end

-- Returns whether the player is an admin or not. It will also return `true` if the player is Player:IsSuperAdmin by default.Internally this is determined by Player:IsUserGroup.
function Player:IsAdmin() end

-- Returns if the player is an bot or not
function Player:IsBot() end

-- Returns true from the point when the player is sending client info but not fully in the game until they disconnect.
function Player:IsConnected() end

-- Used to find out if a player is currently 'driving' an entity (by which we mean 'right click &gt; drive' ).
function Player:IsDrivingEntity() end

-- Returns whether the players movement is currently frozen, controlled by Player:Freeze.
function Player:IsFrozen() end

-- Returns whether the player identity was confirmed by the steam network.See also GM:PlayerAuthed.
function Player:IsFullyAuthenticated() end

-- Returns if a player is the host of the current session.
function Player:IsListenServerHost() end

-- Returns whether or not the player is muted locally.
function Player:IsMuted() end

-- Returns true if the player is playing a taunt.
function Player:IsPlayingTaunt() end

-- Returns whenever the player is heard by the local player clientside, or if the player is speaking serverside.
function Player:IsSpeaking() end

-- Returns whether the player is currently sprinting or not, specifically if they are holding their sprint key and are allowed to sprint.This will not check if the player is currently sprinting into a wall. (i.e. holding their sprint key but not moving)
function Player:IsSprinting() end

-- Returns whenever the player is equipped with the suit item.This will only work for the local player when used clientside.
function Player:IsSuitEquipped() end

-- Returns whether the player is a super admin.Internally this is determined by Player:IsUserGroup. See also Player:IsAdmin.
function Player:IsSuperAdmin() end

-- Returns true if the player is timing out (i.e. is losing connection), false otherwise.A player is considered timing out when more than 4 seconds has elapsed since a network packet was received from given player.
function Player:IsTimingOut() end

-- Returns whether the player is typing in their chat.This may not work properly if the server uses a custom chatbox.
function Player:IsTyping() end

-- Returns true/false if the player is in specified group or not. See Player:GetUserGroup for a way to get player's usergroup.
---@param groupname string
function Player:IsUserGroup(groupname) end

-- Returns if the player can be heard by the local player.
function Player:IsVoiceAudible() end

-- Returns if the player is in the context menu.Although this is shared, it will only work properly on the CLIENT for the local player. Using this serverside or on other players will return false.
function Player:IsWorldClicking() end

-- Returns whether the world clicking is disabled for given player or not. See Player:DisableWorldClicking.This value is meant to be networked to the client, but is not currently.
function Player:IsWorldClickingDisabled() end

-- Gets whether a key is down. This is not networked to other players, meaning only the local client can see the keys they are pressing.
---@param key number
function Player:KeyDown(key) end

-- Gets whether a key was down one tick ago.
---@param key number
function Player:KeyDownLast(key) end

-- Gets whether a key was just pressed this tick.
---@param key number
function Player:KeyPressed(key) end

-- Gets whether a key was just released this tick.
---@param key number
function Player:KeyReleased(key) end

-- Kicks the player from the server.This can not be run before the player has fully joined in. Use game.KickID for that.
---@param reason string
function Player:Kick(reason) end

-- Kills a player and calls GM:PlayerDeath.
function Player:Kill() end

-- Kills a player without notifying the rest of the server.This will call GM:PlayerSilentDeath instead of GM:PlayerDeath.
function Player:KillSilent() end

-- This allows the server to mitigate the lag of the player by moving back all the entities that can be lag compensated to the time the player attacked with his weapon.This technique is most commonly used on things that hit other entities instantaneously, such as traces.Entity:FireBullets calls this function internally.Lag compensation only works for players and entities that have been enabled with Entity:SetLagCompensatedDespite being defined shared, it can only be used server-side in a ~search:%3Cpredicted%3EYes.This function NEEDS to be disabled after you're done with it or it will break the movement of the entities affected!Lag compensation does not support pose parameters.
---@param lagCompensation boolean
function Player:LagCompensation(lagCompensation) end

-- Returns the hitgroup where the player was last hit.
function Player:LastHitGroup() end

-- Shows "limit hit" notification in sandbox.This function is only available in Sandbox and its derivatives.
---@param type string
function Player:LimitHit(type) end

-- Returns the direction a player is looking as a entity/local-oriented angle.Unlike Entity:EyeAngles, this function does not include angles of the Player's Entity:GetParent.
function Player:LocalEyeAngles() end

-- Stops a player from using any inputs, such as moving, turning, or attacking. Key binds are still called. Similar to Player:Freeze but the player takes no damage.Adds the Enums/FL and Enums/FL flags to the player.Frozen bots will still be able to look around.
function Player:Lock() end

-- Returns the position of a Kinect bone.
---@param bone number
function Player:MotionSensorPos(bone) end

-- Returns the players name. Identical to Player:Nick and Player:GetName.
function Player:Name() end

-- Returns the player's nickname.
function Player:Nick() end

-- Returns the 64-bit SteamID aka CommunityID of the Steam Account that owns the Garry's Mod license this player is using. This is useful for detecting players using Steam Family Sharing.If player is not using Steam Family Sharing, this will return the player's actual SteamID64().This data will only be available after the player has fully authenticated with Steam. See Player:IsFullyAuthenticated.
function Player:OwnerSteamID64() end

-- Returns the packet loss of the client. It is not networked so it only returns 0 when run clientside.
function Player:PacketLoss() end

-- Unfreezes the props player is looking at. This is essentially the same as pressing reload with the physics gun, including double press for unfreeze all.
function Player:PhysgunUnfreeze() end

-- This makes the player hold ( same as pressing E on a small prop ) the provided entity.Don't get this confused with picking up items like ammo or health kitsThis picks up the passed entity regardless of its mass or distance from the player
---@param entity Entity
function Player:PickupObject(entity) end

-- Forces the player to pickup an existing weapon entity. The player will not pick up the weapon if they already own a weapon of given type, or if the player could not normally have this weapon in their inventory.This function **will** bypass GM:PlayerCanPickupWeapon.
---@param wep Weapon
---@param ammoOnly boolean
function Player:PickupWeapon(wep,ammoOnly) end

-- Returns the player's ping to server.
function Player:Ping() end

-- Plays the correct step sound according to what the player is staying on.
---@param volume number
function Player:PlayStepSound(volume) end

-- Displays a message either in their chat, console, or center of the screen. See also Global.PrintMessage.When called serverside, this uses the archaic user message system (the umsg) and hence is limited to ≈250 characters.`HUD_PRINTCENTER` will not work when this is called clientside.
---@param type number
---@param message string
function Player:PrintMessage(type,message) end

-- Removes all ammo from a certain player
function Player:RemoveAllAmmo() end

-- Removes all weapons and ammo from the player.
function Player:RemoveAllItems() end

-- Removes the amount of the specified ammo from the player.
---@param ammoCount number
---@param ammoName string
function Player:RemoveAmmo(ammoCount,ammoName) end

-- Removes a **P**layer **Data** key-value pair from the SQL database. (sv.db when called on server,  cl.db when called on client)Internally uses the sql.This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
---@param key string
function Player:RemovePData(key) end

-- Strips the player's suit item.
function Player:RemoveSuit() end

-- Resets both normal and duck hulls to their default values.
function Player:ResetHull() end

-- Forces the player to say whatever the first argument is. Works on bots too.This function ignores the default chat message cooldown
---@param text string
---@param teamOnly boolean
function Player:Say(text,teamOnly) end

-- Fades the screen
---@param flags number
---@param clr number
---@param fadeTime number
---@param fadeHold number
function Player:ScreenFade(flags,clr,fadeTime,fadeHold) end

-- Sets the active weapon of the player by its class name.This will switch the weapon out of prediction, causing delay on the client and WEAPON:Deploy and WEAPON:Holster to be called out of prediction. Try using CUserCmd:SelectWeapon or input.SelectWeapon, instead.This will trigger the weapon switch event and associated animations. To switch weapons silently, use Player:SetActiveWeapon.
---@param className string
function Player:SelectWeapon(className) end

-- Sends a hint to a player.This function is only available in Sandbox and its derivatives. Since this adds `#Hint_` to the beginning of each message, you should only use it with default hint messages, or those cached with language.Add. For hints with custom text, look at notification.AddLegacy.
---@param name string
---@param delay number
function Player:SendHint(name,delay) end

-- Executes a simple Lua string on the player.If you need to use this function more than once consider using net library. Send net message and make the entire code you want to execute in net.Receive on client.The string is limited to 254 bytes. Consider using the Net_Library_Usage for more advanced server-client interaction.
---@param script string
function Player:SendLua(script) end

-- Sets the player's active weapon. You should use CUserCmd:SelectWeapon or Player:SelectWeapon, instead in most cases.This function will not trigger the weapon switch events or associated equip animations. It will bypassGM:PlayerSwitchWeapon and the currently active weapon's WEAPON:Holster return value.
---@param weapon Weapon
function Player:SetActiveWeapon(weapon) end

-- Sets the player's activity.
---@param act number
function Player:SetActivity(act) end

-- Set if the players' model is allowed to rotate around the pitch and roll axis.
---@param Allowed boolean
function Player:SetAllowFullRotation(Allowed) end

-- Allows player to use their weapons in a vehicle. You need to call this before entering a vehicle.Shooting in a vehicle fires two bullets.
---@param allow boolean
function Player:SetAllowWeaponsInVehicle(allow) end

-- Sets the amount of the specified ammo for the player.
---@param ammoCount number
---@param ammoType any
function Player:SetAmmo(ammoCount,ammoType) end

-- Sets the player armor to the argument.
---@param Amount number
function Player:SetArmor(Amount) end

-- Pushes the player away from another player whenever it's inside the other players bounding box.
---@param avoidPlayers boolean
function Player:SetAvoidPlayers(avoidPlayers) end

-- Set if the player should be allowed to walk using the (default) alt key.
---@param abletowalk boolean
function Player:SetCanWalk(abletowalk) end

-- Sets whether the player can use the HL2 suit zoom ("+zoom" bind) or not.
---@param canZoom boolean
function Player:SetCanZoom(canZoom) end

-- Sets the player's class id.
---@param classID number
function Player:SetClassID(classID) end

-- Sets the crouched walk speed multiplier.Doesn't work for values above 1.See also Player:SetWalkSpeed and Player:GetCrouchedWalkSpeed.
---@param speed number
function Player:SetCrouchedWalkSpeed(speed) end

-- Sets the **actual** view offset which equals the difference between the players actual position and their view when standing.Do not confuse with Player:SetViewOffset and Player:SetViewOffsetDucked
---@param viewOffset Vector
function Player:SetCurrentViewOffset(viewOffset) end

-- Sets a player's death count
---@param deathcount number
function Player:SetDeaths(deathcount) end

-- Sets the driving entity and driving mode.Use drive.PlayerStartDriving instead, see Entity Driving.
---@param drivingEntity Entity
---@param drivingMode number
function Player:SetDrivingEntity(drivingEntity,drivingMode) end

-- Applies the specified sound filter to the player.
---@param soundFilter number
---@param fastReset boolean
function Player:SetDSP(soundFilter,fastReset) end

-- Sets how quickly a player ducks.This will not work for values &gt;= 1.
---@param duckSpeed number
function Player:SetDuckSpeed(duckSpeed) end

-- Sets the local angle of the player's view (may rotate body too if angular difference is large)
---@param angle Angle
function Player:SetEyeAngles(angle) end

-- Set a player's FOV (Field Of View) over a certain amount of time.
---@param fov number
---@param time number
---@param requester Entity
function Player:SetFOV(fov,time,requester) end

-- Sets a player's frags (kills)
---@param fragcount number
function Player:SetFrags(fragcount) end

-- Sets the hands entity of a player.The hands entity is an entity introduced in Garry's Mod 13 and it's used to show the player's hands attached to the viewmodel.This is similar to the approach used in L4D and CS:GO, for more information on how to implement this system in your gamemode visit Using Viewmodel Hands.
---@param hands Entity
function Player:SetHands(hands) end

-- Sets the widget that is currently hovered by the player's mouse.
---@param widget Entity
function Player:SetHoveredWidget(widget) end

-- Sets the mins and maxs of the AABB of the players collision.See Player:SetHullDuck for the hull while crouching/ducking.
---@param hullMins Vector
---@param hullMaxs Vector
function Player:SetHull(hullMins,hullMaxs) end

-- Sets the mins and maxs of the AABB of the players collision when ducked.See Player:SetHull for setting the hull while standing.
---@param hullMins Vector
---@param hullMaxs Vector
function Player:SetHullDuck(hullMins,hullMaxs) end

-- Sets the jump power, eg. the velocity that will be applied to the player when they jump.
---@param jumpPower number
function Player:SetJumpPower(jumpPower) end

-- Sets the player's ladder climbing speed.See Player:SetWalkSpeed for normal walking speed, Player:SetRunSpeed for sprinting speed and Player:SetSlowWalkSpeed for slow walking speed.
---@param speed number
function Player:SetLadderClimbSpeed(speed) end

-- Slows down the player movement simulation by the timescale, this is used internally in the HL2 weapon stripping sequence.It achieves such behavior by multiplying the Global.FrameTime by the specified timescale at the start of the movement simulation and then restoring it afterwards.This is reset to 1 on spawn.There is no weapon counterpart to this, you'll have to hardcode the multiplier in the weapon or call Weapon:SetNextPrimaryFire / Weapon:SetNextSecondaryFire manually from a.
---@param timescale number
function Player:SetLaggedMovementValue(timescale) end

-- Sets the hitgroup where the player was last hit.
---@param hitgroup number
function Player:SetLastHitGroup(hitgroup) end

-- Sets the maximum amount of armor the player should have. This affects default built-in armor pickups, but not Player:SetArmor.
---@param maxarmor number
function Player:SetMaxArmor(maxarmor) end

-- Sets the maximum speed which the player can move at.This is called automatically by the engine. If you wish to limit player speed without setting their run/sprint speeds, see CMoveData:SetMaxClientSpeed.
---@param walkSpeed number
function Player:SetMaxSpeed(walkSpeed) end

-- Sets if the player should be muted locally.
---@param mute boolean
function Player:SetMuted(mute) end

-- Sets whenever the player should not collide with their teammates.This will only work for teams with ID 1 to 4 due to internal Engine limitations.This causes traces with Enums/COLLISION_GROUP to pass through players.
---@param shouldNotCollide boolean
function Player:SetNoCollideWithTeammates(shouldNotCollide) end

-- Sets the players visibility towards NPCs.Internally this toggles the Enums/FL flag, which you can manually test for using Entity:IsFlagSet
---@param visibility boolean
function Player:SetNoTarget(visibility) end

-- Sets the players observer mode. You must start the spectating first with Player:Spectate.
---@param mode number
function Player:SetObserverMode(mode) end

-- Writes a **P**layer **Data** key-value pair to the SQL database. (sv.db when called on server,  cl.db when called on client)Internally uses the sql.This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.PData is not networked from servers to clients!
---@param key string
---@param value any
function Player:SetPData(key,value) end

-- Sets the player model's color. The part of the model that is colored is determined by the model itself, and is different for each model.
---@param Color Vector
function Player:SetPlayerColor(Color) end

-- Sets the widget that is currently in use by the player's mouse.Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.
---@param pressedWidget Entity
function Player:SetPressedWidget(pressedWidget) end

-- Sets the render angles of a player.
---@param ang Angle
function Player:SetRenderAngles(ang) end

-- Sets the player's sprint speed.See also Player:GetRunSpeed, Player:SetWalkSpeed and Player:SetMaxSpeed.player_default class run speed is: `600`
---@param runSpeed number
function Player:SetRunSpeed(runSpeed) end

-- Sets the player's slow walking speed, which is activated via +WALK keybind.See Player:SetWalkSpeed for normal walking speed, Player:SetRunSpeed for sprinting speed and Player:SetLadderClimbSpeed for ladder climb speed.
---@param speed number
function Player:SetSlowWalkSpeed(speed) end

-- Sets the maximum height a player can step onto without jumping.
---@param stepHeight number
function Player:SetStepSize(stepHeight) end

-- Sets the player's HEV suit power.This will only work for the local player when used clientside.
---@param power number
function Player:SetSuitPower(power) end

-- Sets whenever to suppress the pickup notification for the player.
---@param doSuppress boolean
function Player:SetSuppressPickupNotices(doSuppress) end

-- Sets the player to the chosen team.
---@param Team number
function Player:SetTeam(Team) end

-- Sets how quickly a player un-ducks
---@param UnDuckSpeed number
function Player:SetUnDuckSpeed(UnDuckSpeed) end

-- Sets up the players view model hands. Calls GM:PlayerSetHandsModel to set the model of the hands.
---@param ent Entity
function Player:SetupHands(ent) end

-- Sets the usergroup of the player.
---@param groupName string
function Player:SetUserGroup(groupName) end

-- Attaches the players view to the position and angles of the specified entity.
---@param viewEntity Entity
function Player:SetViewEntity(viewEntity) end

-- Sets the **desired** view offset which equals the difference between the players actual position and their view when standing.If you want to set **actual** view offset, use Player:SetCurrentViewOffsetSee also Player:SetViewOffsetDucked for **desired** view offset when crouching.
---@param viewOffset Vector
function Player:SetViewOffset(viewOffset) end

-- Sets the **desired** view offset which equals the difference between the players actual position and their view when crouching.If you want to set **actual** view offset, use Player:SetCurrentViewOffsetSee also Player:SetViewOffset for **desired** view offset when standing.
---@param viewOffset Vector
function Player:SetViewOffsetDucked(viewOffset) end

-- Sets client's view punch angle, but not the velocity. See Player:ViewPunch
---@param punchAngle Angle
function Player:SetViewPunchAngles(punchAngle) end

-- Sets client's view punch velocity. See Player:ViewPunch and Player:SetViewPunchAngles
---@param punchVel Angle
function Player:SetViewPunchVelocity(punchVel) end

-- Sets the voice volume scale for given player on client. This value will persist from server to server, but will be reset when the game is shut down.This doesn't work on bots, their scale will always be `1`.
---@param  number
function Player:SetVoiceVolumeScale() end

-- Sets the player's normal walking speed. Not sprinting, not slow walking +walk.See also Player:SetSlowWalkSpeed, Player:GetWalkSpeed, Player:SetCrouchedWalkSpeed, Player:SetMaxSpeed and Player:SetRunSpeed.Using a speed of `0` can lead to prediction errors.player_default class walk speed is: `400`
---@param walkSpeed number
function Player:SetWalkSpeed(walkSpeed) end

-- Sets the player weapon's color. The part of the model that is colored is determined by the model itself, and is different for each model.
---@param Color Vector
function Player:SetWeaponColor(Color) end

-- Returns whether the player's player model will be drawn at the time the function is called.
function Player:ShouldDrawLocalPlayer() end

-- Sets whether the player's current weapon should drop on death.This is reset on spawn to the Player_Classes's **DropWeaponOnDie** field by player_manager.OnPlayerSpawn.
---@param drop boolean
function Player:ShouldDropWeapon(drop) end

-- Opens the player steam profile page in the steam overlay browser.
function Player:ShowProfile() end

-- Signals the entity that it was dropped by the gravity gun.
---@param ent Entity
function Player:SimulateGravGunDrop(ent) end

-- Signals the entity that it was picked up by the gravity gun. This call is only required if you want to simulate the situation of picking up objects.
---@param ent Entity
function Player:SimulateGravGunPickup(ent) end

-- Starts spectate mode for given player. This will also affect the players movetype in some cases.Using this function while spectating the player's own ragdoll will cause it to teleport it to the center of the map. You will spectate the ragdoll even after it's been teleported. This only happens on the client of the player spectating the ragdoll and is purely client-side.
---@param mode number
function Player:Spectate(mode) end

-- Makes the player spectate the entity.To get the applied spectated entity, use Player:GetObserverTarget.
---@param entity Entity
function Player:SpectateEntity(entity) end

-- Makes a player spray their decal.
---@param sprayOrigin Vector
---@param sprayEndPos Vector
function Player:SprayDecal(sprayOrigin,sprayEndPos) end

-- Disables the sprint on the player.Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead.
function Player:SprintDisable() end

-- Enables the sprint on the player.Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead.
function Player:SprintEnable() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.Doesn't appear to do anything.
function Player:StartSprinting() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.When used in a GM:SetupMove hook, this function will force the player to walk, as well as preventing the player from sprinting.
function Player:StartWalking() end

-- Returns the player's SteamID.See Player:AccountID for a shorter version of the SteamID and Player:SteamID64 for the Community/Profile formatted SteamID.In a `-multirun` environment, this will return `STEAM_0:0:0` (serverside) or `NULL` (clientside) for all "copies" of a player because they are not authenticated with Steam.For Bots this will return `BOT` on the server and on the client it returns `NULL`.
function Player:SteamID() end

-- Returns the player's 64-bit SteamID aka CommunityID.See Player:AccountID for a shorter version of the SteamID and Player:SteamID for the normal version of the SteamID.In a `-multirun` environment, this will return `nil` for all "copies" of a player because they are not authenticated with Steam.For bots, this will return `90071996842377216` (equivalent to `STEAM_0:0:0`) for the first bot to join.For each additional bot, the number increases by 1. So the next bot will be `90071996842377217` (`STEAM_0:1:0`) then `90071996842377218` (`STEAM_0:0:1`) and so on.It returns `no value` for bots clientside.
function Player:SteamID64() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.When used in a GM:SetupMove hook, this function will prevent the player from sprinting.When +walk is engaged, the player will still be able to sprint to half speed (normal run speed) as opposed to full sprint speed without this function.
function Player:StopSprinting() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.When used in a GM:SetupMove hook, this function behaves unexpectedly by preventing the player from sprinting similar to Player:StopSprinting.
function Player:StopWalking() end

-- Turns off the zoom mode of the player. (+zoom console command)Basically equivalent of entering "-zoom" into player's console.
function Player:StopZooming() end

-- Removes all ammo from the player.
function Player:StripAmmo() end

-- Removes the specified weapon class from a certain playerthis function will call the Entity:OnRemove but if you try use Entity:GetOwner it will return nil
---@param weapon string
function Player:StripWeapon(weapon) end

-- Removes all weapons from a certain player
function Player:StripWeapons() end

-- Prevents a hint from showing up.This function is only available in Sandbox and its derivatives
---@param name string
function Player:SuppressHint(name) end

-- Attempts to switch the player weapon to the one specified in the "cl_defaultweapon" convar, if the player does not own the specified weapon nothing will happen.If you want to switch to a specific weapon, use: Player:SetActiveWeapon
function Player:SwitchToDefaultWeapon() end

-- Returns the player's team ID.Returns 0 clientside when the game is not fully loaded.
function Player:Team() end

-- Returns the time in seconds since the player connected.Bots will always return value 0.
function Player:TimeConnected() end

-- Performs a trace hull and applies damage to the entities hit, returns the first entity hit.Hitting the victim entity with this function in ENTITY:OnTakeDamage can cause infinite loops.
---@param startPos Vector
---@param endPos Vector
---@param mins Vector
---@param maxs Vector
---@param damage number
---@param damageFlags number
---@param damageForce number
---@param damageAllNPCs boolean
function Player:TraceHullAttack(startPos,endPos,mins,maxs,damage,damageFlags,damageForce,damageAllNPCs) end

-- Translates Enums/ACT according to the holdtype of players currently held weapon.
---@param act number
function Player:TranslateWeaponActivity(act) end

-- Unfreezes all objects the player has frozen with their Physics Gun. Same as double pressing R while holding Physics Gun.
function Player:UnfreezePhysicsObjects() end

-- Use Player:SteamID64, Player:SteamID or Player:AccountID to uniquely identify players instead.**This function has collisions,** where more than one player has the same UniqueID. It is **highly** recommended to use Player:AccountID, Player:SteamID or Player:SteamID64 instead, which are guaranteed to be unique to each player.Returns a 32 bit integer that remains constant for a player across joins/leaves and across different servers. This can be used when a string is inappropriate - e.g. in a database primary key.In Singleplayer, this function will always return 1.
function Player:UniqueID() end

-- This is based on Player:UniqueID which is deprecated and vulnerable to collisions.Returns a table that will stay allocated for the specific player between connects until the server shuts down.This table is not synchronized between client and server.
---@param key any
function Player:UniqueIDTable(key) end

-- Unlocks the player movement if locked previously.Will disable godmode for the player if locked previously.
function Player:UnLock() end

-- Stops the player from spectating another entity.
function Player:UnSpectate() end

-- Returns the player's ID.You can use Global.Player() to get the player by their ID.
function Player:UserID() end

-- Simulates a push on the client's screen. This **adds** view punch velocity, and does not touch the current view punch angle, for which you can use Player:SetViewPunchAngles.
---@param PunchAngle Angle
function Player:ViewPunch(PunchAngle) end

-- Resets the player's view punch (and the view punch velocity, read more at Player:ViewPunch) effect back to normal.
---@param tolerance number
function Player:ViewPunchReset(tolerance) end

-- Returns the players voice volume, how loud the player's voice communication currently is, as a normal number. Doesn't work on local player unless the voice_loopback convar is set to 1.
function Player:VoiceVolume() end



---@class ProjectedTexture
ProjectedTexture = ProjectedTexture

-- Returns the angle of the ProjectedTexture, which were previously set by ProjectedTexture:SetAngles
function ProjectedTexture:GetAngles() end

-- Returns the brightness of the ProjectedTexture, which was previously set by ProjectedTexture:SetBrightness
function ProjectedTexture:GetBrightness() end

-- Returns the color of the ProjectedTexture, which was previously set by ProjectedTexture:SetColor.The returned color will not have the color metatable.
function ProjectedTexture:GetColor() end

-- Returns the constant attenuation of the projected texture, which can also be set by ProjectedTexture:SetConstantAttenuation.
function ProjectedTexture:GetConstantAttenuation() end

-- Returns whether shadows are enabled for this ProjectedTexture, which was previously set by ProjectedTexture:SetEnableShadows
function ProjectedTexture:GetEnableShadows() end

-- Returns the projection distance of the ProjectedTexture, which was previously set by ProjectedTexture:SetFarZ
function ProjectedTexture:GetFarZ() end

-- Returns the horizontal FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetHorizontalFOV or ProjectedTexture:SetFOV
function ProjectedTexture:GetHorizontalFOV() end

-- Returns the linear attenuation of the projected texture, which can also be set by ProjectedTexture:SetLinearAttenuation.
function ProjectedTexture:GetLinearAttenuation() end

-- Returns the NearZ value of the ProjectedTexture, which was previously set by ProjectedTexture:SetNearZ
function ProjectedTexture:GetNearZ() end

-- Returns the current orthographic settings of the Projected Texture. To set these values, use ProjectedTexture:SetOrthographic.
function ProjectedTexture:GetOrthographic() end

-- Returns the position of the ProjectedTexture, which was previously set by ProjectedTexture:SetPos
function ProjectedTexture:GetPos() end

-- Returns the quadratic attenuation of the projected texture, which can also be set by ProjectedTexture:SetQuadraticAttenuation.
function ProjectedTexture:GetQuadraticAttenuation() end

-- Returns the shadow depth bias of the projected texture.Set by ProjectedTexture:SetShadowDepthBias.
function ProjectedTexture:GetShadowDepthBias() end

-- Returns the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more.Set by ProjectedTexture:SetShadowFilter.
function ProjectedTexture:GetShadowFilter() end

-- Returns the shadow depth slope scale bias of the projected texture.Set by ProjectedTexture:SetShadowSlopeScaleDepthBias.
function ProjectedTexture:GetShadowSlopeScaleDepthBias() end

-- Returns the target entity of this projected texture.
function ProjectedTexture:GetTargetEntity() end

-- Returns the texture of the ProjectedTexture, which was previously set by ProjectedTexture:SetTexture
function ProjectedTexture:GetTexture() end

-- Returns the texture frame of the ProjectedTexture, which was previously set by ProjectedTexture:SetTextureFrame
function ProjectedTexture:GetTextureFrame() end

-- Returns the vertical FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetVerticalFOV or ProjectedTexture:SetFOV
function ProjectedTexture:GetVerticalFOV() end

-- Returns true if the projected texture is valid (i.e. has not been removed), false otherwise.Instead of calling this directly it's a good idea to call Global.IsValid in case the variable is nil.```IsValid( ptexture )```This not only checks whether the projected texture is valid - but also checks whether it's nil.
function ProjectedTexture:IsValid() end

-- Removes the projected texture. After calling this, ProjectedTexture:IsValid will return false, and any hooks with the projected texture as the identifier will be automatically deleted.
function ProjectedTexture:Remove() end

-- Sets the angles (direction) of the projected texture.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param angle Angle
function ProjectedTexture:SetAngles(angle) end

-- Sets the brightness of the projected texture.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param brightness number
function ProjectedTexture:SetBrightness(brightness) end

-- Sets the color of the projected texture.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param color table
function ProjectedTexture:SetColor(color) end

-- Sets the constant attenuation of the projected texture.See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetQuadraticAttenuation.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param constAtten number
function ProjectedTexture:SetConstantAttenuation(constAtten) end

-- Enable or disable shadows cast from the projected texture.As with all types of projected textures (including the player's flashlight and env_projectedtexture), there can only be 8 projected textures with shadows enabled in total.This limit can be increased with the launch parameter `-numshadowtextures LIMIT` where `LIMIT` is the new limit.Naturally, many projected lights with shadows enabled will drastically decrease framerate.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param newState boolean
function ProjectedTexture:SetEnableShadows(newState) end

-- Sets the distance at which the projected texture ends.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param farZ number
function ProjectedTexture:SetFarZ(farZ) end

-- Sets the angle of projection.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param fov number
function ProjectedTexture:SetFOV(fov) end

-- Sets the horizontal angle of projection without affecting the vertical angle.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param hFOV number
function ProjectedTexture:SetHorizontalFOV(hFOV) end

-- Sets the linear attenuation of the projected texture.See also ProjectedTexture:SetConstantAttenuation and ProjectedTexture:SetQuadraticAttenuation.The default value of linear attenuation when the projected texture is created is 100. (others are 0, as you are not supposed to mix them)You must call ProjectedTexture:Update after using this function for it to take effect.
---@param linearAtten number
function ProjectedTexture:SetLinearAttenuation(linearAtten) end

-- Sets the distance at which the projected texture begins its projection.You must call ProjectedTexture:Update after using this function for it to take effect.Setting this to 0 will disable the projected texture completely! This may be useful if you want to disable a projected texture without actually removing itThis seems to affect the rendering of shadows - a higher Near Z value will have shadows begin to render closer to their casting object. Comparing a low Near Z value (like 1) with a normal one (12) or high one (1000) is the easiest way to understand this artifact
---@param nearZ number
function ProjectedTexture:SetNearZ(nearZ) end

-- Changes the current projected texture between orthographic and perspective projection.You must call ProjectedTexture:Update after using this function for it to take effect.Shadows dont work. (For non static props and for most map brushes)
---@param orthographic boolean
---@param left number
---@param top number
---@param right number
---@param bottom number
function ProjectedTexture:SetOrthographic(orthographic,left,top,right,bottom) end

-- Move the Projected Texture to the specified position.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param position Vector
function ProjectedTexture:SetPos(position) end

-- Sets the quadratic attenuation of the projected texture.See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetConstantAttenuation.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param quadAtten number
function ProjectedTexture:SetQuadraticAttenuation(quadAtten) end

-- Sets the shadow depth bias of the projected texture.The initial value is `0.0001`. Normal projected textures obey the value of the `mat_depthbias_shadowmap` ConVar.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param bias number
function ProjectedTexture:SetShadowDepthBias(bias) end

-- Sets the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more. The initial value is the value of `r_projectedtexture_filter` ConVar.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param filter number
function ProjectedTexture:SetShadowFilter(filter) end

-- Sets the shadow depth slope scale bias of the projected texture.The initial value is `2`. Normal projected textures obey the value of the `mat_slopescaledepthbias_shadowmap` ConVar.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param bias number
function ProjectedTexture:SetShadowSlopeScaleDepthBias(bias) end

-- Sets the target entity for this projected texture, meaning it will only be lighting the given entity and the world.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param target Entity
function ProjectedTexture:SetTargetEntity(target) end

-- Sets the texture to be projected.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param texture string
function ProjectedTexture:SetTexture(texture) end

-- For animated textures, this will choose which frame in the animation will be projected.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param frame number
function ProjectedTexture:SetTextureFrame(frame) end

-- Sets the vertical angle of projection without affecting the horizontal angle.You must call ProjectedTexture:Update after using this function for it to take effect.
---@param vFOV number
function ProjectedTexture:SetVerticalFOV(vFOV) end

-- Updates the Projected Light and applies all previously set parameters.
function ProjectedTexture:Update() end



---@class Schedule
Schedule = Schedule

-- Adds a task to the schedule. See also Schedule:AddTaskEx if you wish to customize task start and run function names.See also ENTITY:StartSchedule, NPC:StartEngineTask, and NPC:RunEngineTask.
---@param taskname string
---@param taskdata any
function Schedule:AddTask(taskname,taskdata) end

-- Adds a task to the schedule with completely custom function names.See also Schedule:AddTask.
---@param start string
---@param run string
---@param data number
function Schedule:AddTaskEx(start,run,data) end

-- Adds an engine task to the schedule.
---@param taskname string
---@param taskdata number
function Schedule:EngTask(taskname,taskdata) end

-- Returns the task at the given index.
---@param num number
function Schedule:GetTask(num) end

--  Initialises the Schedule. Called by ai_schedule.New when the Schedule is created.
---@param debugName string
function Schedule:Init(debugName) end

-- Returns the number of tasks in the schedule.
function Schedule:NumTasks() end



---@class Stack
Stack = Stack

-- Pop an item from the stack
---@param amount number
function Stack:Pop(amount) end

-- Pop an item from the stack
---@param amount number
function Stack:PopMulti(amount) end

-- Push an item onto the stack
---@param object any
function Stack:Push(object) end

-- Returns the size of the stack
function Stack:Size() end

-- Get the item at the top of the stack
function Stack:Top() end



---@class SurfaceInfo
SurfaceInfo = SurfaceInfo

-- Returns the brush surface's material.
function SurfaceInfo:GetMaterial() end

-- Returns a list of vertices the brush surface is built from.
function SurfaceInfo:GetVertices() end

-- Checks if the brush surface is a nodraw surface, meaning it will not be drawn by the engine.This internally checks the SURFDRAW_NODRAW flag.
function SurfaceInfo:IsNoDraw() end

-- Checks if the brush surface is displaying the skybox.This internally checks the SURFDRAW_SKY flag.
function SurfaceInfo:IsSky() end

-- Checks if the brush surface is water.This internally checks the SURFDRAW_WATER flag.
function SurfaceInfo:IsWater() end



---@class Task
Task = Task

--  Initialises the AI task. Called by ai_task.New.
function Task:Init() end

-- Initialises the AI task as an engine task.
---@param taskname string
---@param taskdata number
function Task:InitEngine(taskname,taskdata) end

-- Initialises the AI task as NPC method-based.
---@param startname string
---@param runname string
---@param taskdata number
function Task:InitFunctionName(startname,runname,taskdata) end

-- Determines if the task is an engine task (`TYPE_ENGINE`, 1).
function Task:IsEngineType() end

-- Determines if the task is an NPC method-based task (`TYPE_FNAME`, 2).
function Task:IsFNameType() end

-- Runs the AI task.
---@param target NPC
function Task:Run(target) end

--  Runs the AI task as an NPC method. This requires the task to be of type `TYPE_FNAME`.
---@param target NPC
function Task:Run_FName(target) end

-- Starts the AI task.
---@param target NPC
function Task:Start(target) end

--  Starts the AI task as an NPC method.
---@param target NPC
function Task:Start_FName(target) end



---@class Tool
Tool = Tool

-- Returns whether the tool is allowed to be used or not. This function ignores the SANDBOX:CanTool hook.By default this will always return true clientside and uses `TOOL.AllowedCVar`which is a ConVar object pointing to  `toolmode_allow_*toolname*` convar on the server.
function Tool:Allowed() end

-- Builds a list of all ConVars set via the ClientConVar variable on the Structures/TOOL and their default values. This is used for the preset system.
function Tool:BuildConVarList() end

-- This is called automatically for most toolgun actions so you shouldn't need to use it.Checks all added objects to see if they're still valid, if not, clears the list of objects.
function Tool:CheckObjects() end

-- Clears all objects previously set with Tool:SetObject.
function Tool:ClearObjects() end

-- This is called automatically for all tools.Initializes the tool object
function Tool:Create() end

-- This is called automatically for all tools.Creates clientside ConVars based on the ClientConVar table specified in the tool structure. Also creates the 'toolmode_allow_X' ConVar.
function Tool:CreateConVars() end

-- Retrieves a physics bone number previously stored using Tool:SetObject.
---@param id number
function Tool:GetBone(id) end

-- Attempts to grab a clientside tool ConVar value as a boolean.
---@param name string
---@param default boolean
function Tool:GetClientBool(name,default) end

-- Attempts to grab a clientside tool ConVar as a string.
---@param name string
function Tool:GetClientInfo(name) end

-- Attempts to grab a clientside tool ConVar's value as a number.
---@param name string
---@param default number
function Tool:GetClientNumber(name,default) end

-- Retrieves an Entity previously stored using Tool:SetObject.
---@param id number
function Tool:GetEnt(id) end

-- Returns a language key based on this tool's name and the current stage it is on.
function Tool:GetHelpText() end

-- Retrieves an local vector previously stored using Tool:SetObject.See also Tool:GetPos.
---@param id number
function Tool:GetLocalPos(id) end

-- Returns the name of the current tool mode.
function Tool:GetMode() end

-- Retrieves an normal vector previously stored using Tool:SetObject.
---@param id number
function Tool:GetNormal(id) end

-- Returns the current operation of the tool set by Tool:SetOperation.
function Tool:GetOperation() end

-- Returns the owner of this tool.
function Tool:GetOwner() end

-- Retrieves an PhysObj previously stored using Tool:SetObject.See also Tool:GetEnt.
---@param id number
function Tool:GetPhys(id) end

-- Retrieves an vector previously stored using Tool:SetObject. See also Tool:GetLocalPos.
---@param id number
function Tool:GetPos(id) end

-- Attempts to grab a serverside tool ConVar.This will not do anything on client, despite the function being defined shared.
---@param name string
function Tool:GetServerInfo(name) end

-- Returns the current stage of the tool set by Tool:SetStage.
function Tool:GetStage() end

-- Initializes the ghost entity with the given model. Removes any old ghost entity if called multiple times.The ghost is a regular prop_physics entity in singleplayer games, and a clientside prop in multiplayer games.
---@param model string
---@param pos Vector
---@param angle Angle
function Tool:MakeGhostEntity(model,pos,angle) end

-- Returns the amount of stored objects ( Entitys ) the tool has.Are TOOLs limited to 4 entities?
function Tool:NumObjects() end

-- Automatically forces the tool's control panel to be rebuilt.
---@param extra_args vararg
function Tool:RebuildControlPanel(extra_args) end

-- Removes any ghost entity created for this tool.
function Tool:ReleaseGhostEntity() end

-- Stores an Entity for later use in the tool.The stored values can be retrieved by Tool:GetEnt, Tool:GetPos, Tool:GetLocalPos, Tool:GetPhys, Tool:GetBone and Tool:GetNormal
---@param id number
---@param ent Entity
---@param pos Vector
---@param phys PhysObj
---@param bone number
---@param normal Vector
function Tool:SetObject(id,ent,pos,phys,bone,normal) end

-- Sets the current operation of the tool. Does nothing clientside. See also Tool:SetStage.Operations and stages work as follows:* Operation 1* * Stage 1* * Stage 2* * Stage 3* Operation 2* * Stage 1* * Stage 2* * Stage ...
---@param operation number
function Tool:SetOperation(operation) end

-- Sets the current stage of the tool. Does nothing clientside.See also Tool:SetOperation.
---@param stage number
function Tool:SetStage(stage) end

-- Initializes the ghost entity based on the supplied entity.
---@param ent Entity
function Tool:StartGhostEntity(ent) end

-- Called on deploy automaticallySets the tool's stage to how many stored objects the tool has.
function Tool:UpdateData() end

-- Updates the position and orientation of the ghost entity based on where the toolgun owner is looking along with data from object with id 1 set by Tool:SetObject.This should be called in the tool's TOOL:Think hook.This command is only used for tools that move props, such as easy weld, axis and motor. If you want to update a ghost like the thruster tool does it for example, check its [source code](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stools/thruster.lua#L179).
function Tool:UpdateGhostEntity() end



---@class Vector
Vector = Vector

-- Adds the values of the argument vector to the original vector. This function is the same as vector1 + vector2 without creating a new vector object, skipping object construction and garbage collection.
---@param vector Vector
function Vector:Add(vector) end

-- Returns an angle representing the normal of the vector.
function Vector:Angle() end

-- Returns the angle of this vector (normalized), but instead of assuming that up is Global.Vector( 0, 0, 1 ) (Like Vector:Angle does) you can specify which direction is 'up' for the angle.
---@param up Vector
function Vector:AngleEx(up) end

-- Calculates the cross product of this vector and the passed one.The cross product of two vectors is a 3-dimensional vector with a direction perpendicular (at right angles) to both of them (according to the right-hand rule), and magnitude equal to the area of parallelogram they span. This is defined as the product of the magnitudes, the sine of the angle between them, and unit (normal) vector `n` defined by the right-hand rule::**a** × **b** = |**a**| |**b**| sin(θ) **n̂**where **a** and **b** are vectors, and **n̂** is a unit vector (magnitude of 1) perpendicular to both.
---@param otherVector Vector
function Vector:Cross(otherVector) end

-- Returns the euclidean distance between the vector and the other vector.This function is more expensive than Vector:DistToSqr. However, please see the notes for Vector:DistToSqr before using it as squared distances are not the same as euclidean distances.
---@param otherVector Vector
function Vector:Distance(otherVector) end

-- Returns the squared distance of 2 vectors, this is faster than Vector:Distance as calculating the square root is an expensive process.Squared distances should not be summed. If you need to sum distances, use Vector:Distance.When performing a distance check, ensure the distance being checked against is squared. See example code below.
---@param otherVec Vector
function Vector:DistToSqr(otherVec) end

-- Divide the vector by the given number, that means x, y and z are divided by that value. This will change the value of the original vector, see example 2 for division without changing the value.
---@param divisor number
function Vector:Div(divisor) end

-- Returns the [dot product](https://en.wikipedia.org/wiki/Dot_product#Geometric_definition)  of this vector and the passed one.The dot product of two vectors is the product of their magnitudes (lengths), and the cosine of the angle between them:**a · b** = |**a**| |**b**| cos(θ) where **a** and **b** are vectors.See Vector:Length for obtaining magnitudes.A dot product returns just the cosine of the angle if both vectors are normalized, and zero if the vectors are at right angles to each other.
---@param otherVector Vector
function Vector:Dot(otherVector) end

-- This is an alias of Vector:Dot. Use that instead.Returns the dot product of the two vectors.
---@param Vector Vector
function Vector:DotProduct(Vector) end

-- Returns the negative version of this vector, i.e. a vector with every component to the negative value of itself.See also Vector:Negate.
function Vector:GetNegated() end

-- Use Vector:GetNormalized instead.Returns a normalized version of the vector. This is a alias of Vector:GetNormalized.
function Vector:GetNormal() end

-- Returns a normalized version of the vector. Normalized means vector with same direction but with length of 1.This does not affect the vector you call it on; to do this, use Vector:Normalize.
function Vector:GetNormalized() end

-- Returns if the vector is equal to another vector with the given tolerance.
---@param compare Vector
---@param tolerance number
function Vector:IsEqualTol(compare,tolerance) end

-- Checks whenever all fields of the vector are 0.
function Vector:IsZero() end

-- Returns the [Euclidean length](https://en.wikipedia.org/wiki/Euclidean_vector#Length) of the vector: √(x² + y² + z²).This is a relatively expensive process since it uses the square root. It is recommended that you use Vector:LengthSqr whenever possible.
function Vector:Length() end

-- Returns the length of the vector in two dimensions, without the Z axis.This is a relatively expensive process since it uses the square root. It is recommended that you use Vector:Length2DSqr whenever possible.
function Vector:Length2D() end

-- Returns the squared length of the vectors x and y value, x² + y².This is faster than Vector:Length2D as calculating the square root is an expensive process.
function Vector:Length2DSqr() end

-- Returns the squared length of the vector, x² + y² + z².This is faster than Vector:Length as calculating the square root is an expensive process.
function Vector:LengthSqr() end

-- Scales the vector by the given number (that means x, y and z are multiplied by that value) or Vector.
---@param multiplier number
function Vector:Mul(multiplier) end

-- Negates this vector, i.e. sets every component to the negative value of itself. Same as `Vector( -vec.x, -vec.y, -vec.z )`
function Vector:Negate() end

-- Normalizes the given vector. This changes the vector you call it on, if you want to return a normalized copy without affecting the original, use Vector:GetNormalized.
function Vector:Normalize() end

-- Randomizes each element of this Vector object.
---@param min number
---@param max number
function Vector:Random(min,max) end

-- Rotates a vector by the given angle.Doesn't return anything, but rather changes the original vector.
---@param rotation Angle
function Vector:Rotate(rotation) end

-- Copies the values from the second vector to the first vector.
---@param vector Vector
function Vector:Set(vector) end

-- Sets the x, y, and z of the vector.
---@param x number
---@param y number
---@param z number
function Vector:SetUnpacked(x,y,z) end

-- Substracts the values of the second vector from the orignal vector, this function can be used to avoid garbage collection.
---@param vector Vector
function Vector:Sub(vector) end

-- Translates the Vector (values ranging from 0 to 1) into a Color. This will also range the values from 0 - 1 to 0 - 255.x * 255 -&gt; ry * 255 -&gt; gz * 255 -&gt; bThis is the opposite of Color:ToVector
function Vector:ToColor() end

-- Returns where on the screen the specified position vector would appear. A related function is gui.ScreenToVector, which converts a 2D coordinate to a 3D direction.Should be called from a 3D rendering environment or after cam.Start3D or it may not work correctly.Errors in a render hook can make this value incorrect until the player restarts their game.cam.Start3D or 3D context cam.Start with non-default parameters incorrectly sets the reference FOV for this function, causing incorrect return values. This can be fixed by creating and ending a default 3D context (cam.Start3D with no arguments).
function Vector:ToScreen() end

-- Returns the vector as a table with three elements.
function Vector:ToTable() end

-- Returns the x, y, and z of the vector.
function Vector:Unpack() end

-- Returns whenever the given vector is in a box created by the 2 other vectors.
---@param boxStart Vector
---@param boxEnd Vector
function Vector:WithinAABox(boxStart,boxEnd) end

-- Sets x, y and z to 0.
function Vector:Zero() end



---@class Vehicle
Vehicle = Vehicle

-- Returns the remaining boosting time left.
function Vehicle:BoostTimeLeft() end

-- Tries to find an Exit Point for leaving vehicle, if one is unobstructed in the direction given.
---@param yaw number
---@param distance number
function Vehicle:CheckExitPoint(yaw,distance) end

-- Sets whether the engine is enabled or disabled, i.e. can be started or not.
---@param enable boolean
function Vehicle:EnableEngine(enable) end

-- Returns information about the ammo of the vehicle
function Vehicle:GetAmmo() end

-- Returns third person camera distance.
function Vehicle:GetCameraDistance() end

-- Gets the driver of the vehicle, returns `NULL` if no driver is present.
function Vehicle:GetDriver() end

-- Returns the current speed of the vehicle in Half-Life Hammer Units (in/s). Same as Entity:GetVelocity + Vector:Length.
function Vehicle:GetHLSpeed() end

-- Returns the max speed of the vehicle in MPH.
function Vehicle:GetMaxSpeed() end

-- Returns some info about the vehicle.
function Vehicle:GetOperatingParams() end

-- Gets the passenger of the vehicle, returns NULL if no drivers is present.
---@param passenger number
function Vehicle:GetPassenger(passenger) end

-- Returns the seat position and angle of a given passenger seat.
---@param role number
function Vehicle:GetPassengerSeatPoint(role) end

-- Returns the current RPM of the vehicle. This value is fake and doesn't actually affect the vehicle movement.
function Vehicle:GetRPM() end

-- Returns the current speed of the vehicle in MPH.
function Vehicle:GetSpeed() end

-- Returns the current steering of the vehicle.
function Vehicle:GetSteering() end

-- Returns the maximum steering degree of the vehicle
function Vehicle:GetSteeringDegrees() end

-- Returns if vehicle has thirdperson mode enabled or not.
function Vehicle:GetThirdPersonMode() end

-- Returns the current throttle of the vehicle.
function Vehicle:GetThrottle() end

-- Returns the vehicle class name. This is only useful for Sandbox spawned vehicles or any vehicle that properly sets the vehicle class with Vehicle:SetVehicleClass.
function Vehicle:GetVehicleClass() end

-- Returns the vehicle parameters of given vehicle.
function Vehicle:GetVehicleParams() end

-- Returns the view position and forward angle of a given passenger seat.
---@param role number
function Vehicle:GetVehicleViewPosition(role) end

-- Returns the PhysObj of given wheel.
---@param wheel number
function Vehicle:GetWheel(wheel) end

-- Returns the base wheel height.
---@param wheel number
function Vehicle:GetWheelBaseHeight(wheel) end

-- Returns the wheel contact point.
---@param wheel number
function Vehicle:GetWheelContactPoint(wheel) end

-- Returns the wheel count of the vehicle
function Vehicle:GetWheelCount() end

-- Returns the total wheel height.
---@param wheel number
function Vehicle:GetWheelTotalHeight(wheel) end

-- Returns whether this vehicle has boost at all.
function Vehicle:HasBoost() end

-- Returns whether this vehicle has a brake pedal. See Vehicle:SetHasBrakePedal.
function Vehicle:HasBrakePedal() end

-- Returns whether this vehicle is currently boosting or not.
function Vehicle:IsBoosting() end

-- Returns whether the engine is enabled or not, i.e. whether it can be started.
function Vehicle:IsEngineEnabled() end

-- Returns whether the engine is started or not.
function Vehicle:IsEngineStarted() end

-- Returns true if the vehicle object is a valid or not. This will return false when Vehicle functions are not usable on the vehicle.
function Vehicle:IsValidVehicle() end

-- Returns whether this vehicle's engine is underwater or not. ( Internally the attachment point "engine" or "vehicle_engine" is checked )
function Vehicle:IsVehicleBodyInWater() end

-- Releases the vehicle's handbrake (Jeep) so it can roll without any passengers.This will be overwritten if the vehicle has a driver. Same as Vehicle:SetHandbrake( false )
function Vehicle:ReleaseHandbrake() end

-- Sets the boost. It is possible that this function does not work while the vehicle has a valid driver in it.
---@param boost number
function Vehicle:SetBoost(boost) end

-- Sets the third person camera distance of the vehicle.
---@param distance number
function Vehicle:SetCameraDistance(distance) end

-- Turns on or off the Jeep handbrake so it can roll without a driver inside.Does nothing while the vehicle has a driver in it.
---@param handbrake boolean
function Vehicle:SetHandbrake(handbrake) end

-- Sets whether this vehicle has a brake pedal.
---@param brakePedal boolean
function Vehicle:SetHasBrakePedal(brakePedal) end

-- Sets maximum reverse throttle
---@param maxRevThrottle number
function Vehicle:SetMaxReverseThrottle(maxRevThrottle) end

-- Sets maximum forward throttle
---@param maxThrottle number
function Vehicle:SetMaxThrottle(maxThrottle) end

-- Sets spring length of given wheel
---@param wheel number
---@param length number
function Vehicle:SetSpringLength(wheel,length) end

-- Sets the steering of the vehicle.The correct range, 0 to 1 or -1 to 1
---@param front number
---@param rear number
function Vehicle:SetSteering(front,rear) end

-- Sets the maximum steering degrees of the vehicle
---@param steeringDegrees number
function Vehicle:SetSteeringDegrees(steeringDegrees) end

-- Sets the third person mode state.
---@param enable boolean
function Vehicle:SetThirdPersonMode(enable) end

-- Sets the throttle of the vehicle. It is possible that this function does not work with a valid driver in it.
---@param throttle number
function Vehicle:SetThrottle(throttle) end

-- Sets the vehicle class name.
---@param class string
function Vehicle:SetVehicleClass(class) end

-- Sets whether the entry or exit camera animation should be played or not.
---@param bOn boolean
function Vehicle:SetVehicleEntryAnim(bOn) end

-- Sets the vehicle parameters for given vehicle.Not all variables from the Structures/VehicleParams can be set.
---@param params table
function Vehicle:SetVehicleParams(params) end

-- Sets friction of given wheel.  This function may be broken.
---@param wheel number
---@param friction number
function Vehicle:SetWheelFriction(wheel,friction) end

-- Starts or stops the engine.
---@param start boolean
function Vehicle:StartEngine(start) end



---@class VMatrix
VMatrix = VMatrix

-- Adds given matrix to this matrix.
---@param input VMatrix
function VMatrix:Add(input) end

-- Returns the absolute rotation of the matrix.
function VMatrix:GetAngles() end

-- Returns a specific field in the matrix.
---@param row number
---@param column number
function VMatrix:GetField(row,column) end

-- Gets the forward direction of the matrix.ie. The first column of the matrix, excluding the w coordinate.
function VMatrix:GetForward() end

-- Returns an inverted matrix without modifying the original matrix.Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)See also VMatrix:GetInverseTR.
function VMatrix:GetInverse() end

-- Returns an inverted matrix without modifying the original matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.Using this function on a matrix with modified scale may return an incorrect inverted matrix.To get the inverse of a matrix that contains other modifications, see VMatrix:GetInverse.
function VMatrix:GetInverseTR() end

-- Gets the right direction of the matrix.ie. The second column of the matrix, negated, excluding the w coordinate.
function VMatrix:GetRight() end

-- Returns the absolute scale of the matrix.
function VMatrix:GetScale() end

-- Returns the absolute translation of the matrix.
function VMatrix:GetTranslation() end

-- Returns the transpose (each row becomes a column) of this matrix.
function VMatrix:GetTransposed() end

-- Gets the up direction of the matrix.ie. The third column of the matrix, excluding the w coordinate.
function VMatrix:GetUp() end

-- Initializes the matrix as Identity matrix.
function VMatrix:Identity() end

-- Inverts the matrix.Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)If the matrix cannot be inverted, it does not get modified.See also VMatrix:InvertTR.
function VMatrix:Invert() end

-- Inverts the matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.Using this function on a matrix with modified scale may return an incorrect inverted matrix.To invert a matrix that contains other modifications, see VMatrix:Invert.
function VMatrix:InvertTR() end

-- Returns whether the matrix is equal to Identity matrix or not.
function VMatrix:IsIdentity() end

-- Returns whether the matrix is a rotation matrix or not.Technically it checks if the forward, right and up vectors are orthogonal and normalized.
function VMatrix:IsRotationMatrix() end

-- Checks whenever all fields of the matrix are 0, aka if this is a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).
function VMatrix:IsZero() end

-- Multiplies this matrix by given matrix.
---@param input VMatrix
function VMatrix:Mul(input) end

-- Rotates the matrix by the given angle.Postmultiplies the matrix by a rotation matrix (A = AR).
---@param rotation Angle
function VMatrix:Rotate(rotation) end

-- Scales the matrix by the given vector.Postmultiplies the matrix by a scaling matrix (A = AS).
---@param scale Vector
function VMatrix:Scale(scale) end

-- Scales the absolute translation with the given value.
---@param scale number
function VMatrix:ScaleTranslation(scale) end

-- Copies values from the given matrix object.
---@param src VMatrix
function VMatrix:Set(src) end

-- Sets the absolute rotation of the matrix.
---@param angle Angle
function VMatrix:SetAngles(angle) end

-- Sets a specific field in the matrix.
---@param row number
---@param column number
---@param value number
function VMatrix:SetField(row,column,value) end

-- Sets the forward direction of the matrix.ie. The first column of the matrix, excluding the w coordinate.
---@param forward Vector
function VMatrix:SetForward(forward) end

-- Sets the right direction of the matrix.ie. The second column of the matrix, negated, excluding the w coordinate.
---@param forward Vector
function VMatrix:SetRight(forward) end

-- Modifies the scale of the matrix while preserving the rotation and translation.
---@param scale Vector
function VMatrix:SetScale(scale) end

-- Sets the absolute translation of the matrix.
---@param translation Vector
function VMatrix:SetTranslation(translation) end

-- Sets each component of the matrix.
---@param e11 number
---@param e12 number
---@param e13 number
---@param e14 number
---@param e21 number
---@param e22 number
---@param e23 number
---@param e24 number
---@param e31 number
---@param e32 number
---@param e33 number
---@param e34 number
---@param e41 number
---@param e42 number
---@param e43 number
---@param e44 number
function VMatrix:SetUnpacked(e11,e12,e13,e14,e21,e22,e23,e24,e31,e32,e33,e34,e41,e42,e43,e44) end

-- Sets the up direction of the matrix.ie. The third column of the matrix, excluding the w coordinate.
---@param forward Vector
function VMatrix:SetUp(forward) end

-- Subtracts given matrix from this matrix.
---@param input VMatrix
function VMatrix:Sub(input) end

-- Converts the matrix to a 4x4 table. See Global.Matrix function.
function VMatrix:ToTable() end

-- Translates the matrix by the given vector aka. adds the vector to the translation.Postmultiplies the matrix by a translation matrix (A = AT).
---@param translation Vector
function VMatrix:Translate(translation) end

-- Returns each component of the matrix, expanding rows before columns.
function VMatrix:Unpack() end

-- Sets all components of the matrix to 0, also known as a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).This function is more efficient than setting each element manually.
function VMatrix:Zero() end



---@class Weapon
Weapon = Weapon

-- Returns whether the weapon allows to being switched from when a better ( Weapon:GetWeight ) weapon is being picked up.
function Weapon:AllowsAutoSwitchFrom() end

-- Returns whether the weapon allows to being switched to when a better ( Weapon:GetWeight ) weapon is being picked up.
function Weapon:AllowsAutoSwitchTo() end

-- Calls a SWEP function on client.This uses the usermessage internally, because of that, the combined length of the arguments of this function may not exceed 254 bytes/characters or the function will cease to function!
---@param functionName string
---@param arguments string
function Weapon:CallOnClient(functionName,arguments) end

-- Returns how much primary ammo is in the magazine.This is not shared between clients and will instead return the maximum primary clip size.
function Weapon:Clip1() end

-- Returns how much secondary ammo is in the magazine.This is not shared between clients and will instead return the maximum secondary clip size.
function Weapon:Clip2() end

-- Forces the weapon to reload while playing given animation.This will stop the Weapon:Think function from getting called while the weapon is reloading!
---@param act number
function Weapon:DefaultReload(act) end

-- Returns the sequence enumeration number that the weapon is playing.This can return inconsistent results between the server and client.
function Weapon:GetActivity() end

-- Returns the hold type of the weapon.
function Weapon:GetHoldType() end

-- Returns maximum primary clip size
function Weapon:GetMaxClip1() end

-- Returns maximum secondary clip size
function Weapon:GetMaxClip2() end

-- Gets the next time the weapon can primary fire. ( Can call WEAPON:PrimaryAttack )
function Weapon:GetNextPrimaryFire() end

-- Gets the next time the weapon can secondary fire. ( Can call WEAPON:SecondaryAttack )
function Weapon:GetNextSecondaryFire() end

-- Gets the primary ammo type of the given weapon.
function Weapon:GetPrimaryAmmoType() end

-- Returns the non-internal name of the weapon, that should be for displaying.If that returns an untranslated message (#HL2_XX), use language.GetPhrase to see the "nice" name.If SWEP.PrintName is not set in the Weapon or the Weapon Base then "&lt;MISSING SWEP PRINT NAME&gt;" will be returned.
function Weapon:GetPrintName() end

-- Gets the ammo type of the given weapons secondary fire.
function Weapon:GetSecondaryAmmoType() end

-- Returns the slot of the weapon.The slot numbers start from 0.
function Weapon:GetSlot() end

-- Returns slot position of the weapon
function Weapon:GetSlotPos() end

-- Returns the view model of the weapon.
function Weapon:GetWeaponViewModel() end

-- Returns the world model of the weapon.
function Weapon:GetWeaponWorldModel() end

-- Returns the "weight" of the weapon, which is used when deciding which Weapon is better by the engine.
function Weapon:GetWeight() end

-- Returns whether the weapon has ammo left or not. It will return false when there's no ammo left in the magazine **and** when there's no reserve ammo left.This will return true for weapons like crowbar, gravity gun, etc.
function Weapon:HasAmmo() end

-- Returns whenever the weapon is carried by the local player.
function Weapon:IsCarriedByLocalPlayer() end

-- Checks if the weapon is a SWEP or a built-in weapon.
function Weapon:IsScripted() end

-- Returns whether the weapon is visible. The term visibility is not exactly what gets checked here, first it checks if the owner is a player, then checks if the active view model has EF_NODRAW flag NOT set.
function Weapon:IsWeaponVisible() end

-- Returns the time since this weapon last fired a bullet with Entity:FireBullets in seconds. It is not networked.
function Weapon:LastShootTime() end

-- Forces weapon to play activity/animation.
---@param act number
function Weapon:SendWeaponAnim(act) end

-- Sets the activity the weapon is playing.See also Weapon:GetActivity.
---@param act number
function Weapon:SetActivity(act) end

-- Lets you change the number of bullets in the given weapons primary clip.
---@param ammo number
function Weapon:SetClip1(ammo) end

-- Lets you change the number of bullets in the given weapons secondary clip.
---@param ammo number
function Weapon:SetClip2(ammo) end

-- Sets the hold type of the weapon. This function also calls WEAPON:SetWeaponHoldType and properly networks it to all clients.This only works on scripted weapons.Using this function on weapons held by bots will not network holdtype changes to clients if the world model is set to an empty string (SWEP.WorldModel = "").
---@param name string
function Weapon:SetHoldType(name) end

-- Sets the time since this weapon last fired in seconds. Used in conjunction with Weapon:LastShootTime
---@param time number
function Weapon:SetLastShootTime(time) end

-- Sets when the weapon can fire again. Time should be based on Global.CurTime.The standard HL2 "weapon_pistol" bypasses this function due to an [internal implementation](https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/server/hl2/weapon_pistol.cpp#L313-L317).This will fire extra bullets if the time is set to less than Global.CurTime.
---@param time number
function Weapon:SetNextPrimaryFire(time) end

-- Sets when the weapon can alt-fire again. Time should be based on Global.CurTime.
---@param time number
function Weapon:SetNextSecondaryFire(time) end



