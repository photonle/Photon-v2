---@meta

---@class Angle
Angle = Angle

-- Adds the values of the argument angle to the orignal angle.  This functions the same as angle1 + angle2 without creating a new angle object, skipping object construction and garbage collection.
---@param angle Angle The angle to add.
function Angle:Add(angle) end

-- Divides all values of the original angle by a scalar. This functions the same as angle1 / num without creating a new angle object, skipping object construction and garbage collection.
---@param scalar number The number to divide by.
function Angle:Div(scalar) end

-- Returns a normal vector facing in the direction that the angle points.
---@return Vector
function Angle:Forward() end

-- Returns whether the pitch, yaw and roll are 0 or not.
---@return boolean
function Angle:IsZero() end

-- Multiplies a scalar to all the values of the orignal angle. This functions the same as num * angle without creating a new angle object, skipping object construction and garbage collection.
---@param scalar number The number to multiply.
function Angle:Mul(scalar) end

-- Normalizes the angles by applying a module with 360 to pitch, yaw and roll.
function Angle:Normalize() end

-- Randomizes each element of this Angle object.
---@param min? number The minimum value for each component.
---@param max? number The maximum value for each component.
function Angle:Random(min,max) end

-- Returns a normal vector facing in the direction that points right relative to the angle's direction.
---@return Vector
function Angle:Right() end

-- Rotates the angle around the specified axis by the specified degrees.
---@param axis Vector The axis to rotate around as a normalized unit vector. When argument is not a unit vector, you will experience numerical offset errors in the rotated angle.
---@param rotation number The degrees to rotate around the specified axis.
function Angle:RotateAroundAxis(axis,rotation) end

-- Copies pitch, yaw and roll from the second angle to the first.
---@param originalAngle Angle The angle to copy the values from.
function Angle:Set(originalAngle) end

-- Sets the p, y, and r of the angle.
---@param p number The pitch component of the Angle
---@param y number The yaw component of the Angle
---@param r number The roll component of the Angle
function Angle:SetUnpacked(p,y,r) end

-- Snaps the angle to nearest interval of degrees.  This will modify the original angle too!
---@param axis string The component/axis to snap. Can be either `p`/`pitch`, `y`/`yaw` or `r`/`roll`.
---@param target number The target angle snap interval
---@return Angle
function Angle:SnapTo(axis,target) end

-- Subtracts the values of the argument angle to the orignal angle. This functions the same as angle1 - angle2 without creating a new angle object, skipping object construction and garbage collection.
---@param angle Angle The angle to subtract.
function Angle:Sub(angle) end

-- Returns the angle as a table with three elements.
---@return table
function Angle:ToTable() end

-- Returns the pitch, yaw, and roll components of the angle.
---@return number
---@return number
---@return number
function Angle:Unpack() end

-- Returns a normal vector facing in the direction that points up relative to the angle's direction.
---@return Vector
function Angle:Up() end

-- Sets pitch, yaw and roll to 0. This function is faster than doing it manually.
function Angle:Zero() end



---@class bf_read
bf_read = bf_read

-- Reads an returns an angle object from the bitstream.
---@return Angle
function bf_read:ReadAngle() end

-- Reads 1 bit an returns a bool representing the bit.
---@return boolean
function bf_read:ReadBool() end

-- Reads a signed char and returns a number from -127 to 127 representing the ascii value of that char.
---@return number
function bf_read:ReadChar() end

-- Reads a short representing an entity index and returns the matching entity handle.
---@return Entity
function bf_read:ReadEntity() end

-- Reads a 4 byte float from the bitstream and returns it.
---@return number
function bf_read:ReadFloat() end

-- Reads a 4 byte long from the bitstream and returns it.
---@return number
function bf_read:ReadLong() end

-- Reads a 2 byte short from the bitstream and returns it.
---@return number
function bf_read:ReadShort() end

-- Reads a null terminated string from the bitstream.
---@return string
function bf_read:ReadString() end

-- Reads a special encoded vector from the bitstream and returns it, this function is not suitable to send normals.
---@return Vector
function bf_read:ReadVector() end

-- Reads a special encoded vector normal from the bitstream and returns it, this function is not suitable to send vectors that represent a position.
---@return Vector
function bf_read:ReadVectorNormal() end

-- Rewinds the bitstream so it can be read again.
function bf_read:Reset() end



---@class CEffectData
CEffectData = CEffectData

-- Returns the angles of the effect.
---@return Angle
function CEffectData:GetAngles() end

-- Returns the attachment ID for the effect.
---@return number
function CEffectData:GetAttachment() end

-- Returns byte which represents the color of the effect.
---@return number
function CEffectData:GetColor() end

-- Returns the damage type of the effect
---@return number
function CEffectData:GetDamageType() end

-- Returns the entity index of the entity set for the effect.
---@return number
function CEffectData:GetEntIndex() end

-- Returns the entity assigned to the effect.
---@return Entity
function CEffectData:GetEntity() end

-- Returns the flags of the effect.
---@return number
function CEffectData:GetFlags() end

-- Returns the hit box ID of the effect.
---@return number
function CEffectData:GetHitBox() end

-- Returns the magnitude of the effect.
---@return number
function CEffectData:GetMagnitude() end

-- Returns the material ID of the effect.
---@return number
function CEffectData:GetMaterialIndex() end

-- Returns the normalized direction vector of the effect.
---@return Vector
function CEffectData:GetNormal() end

-- Returns the origin position of the effect.
---@return Vector
function CEffectData:GetOrigin() end

-- Returns the radius of the effect.
---@return number
function CEffectData:GetRadius() end

-- Returns the scale of the effect.
---@return number
function CEffectData:GetScale() end

-- Returns the start position of the effect.
---@return Vector
function CEffectData:GetStart() end

-- Returns the surface property index of the effect.
---@return number
function CEffectData:GetSurfaceProp() end

-- Sets the angles of the effect.
---@param ang Angle The new angles to be set.
function CEffectData:SetAngles(ang) end

-- Sets the attachment id of the effect to be created with this effect data.  This is internally stored as an integer, but only the first 5 bits will be networked, effectively limiting this function to 0-31 range.
---@param attachment number New attachment ID of the effect.
function CEffectData:SetAttachment(attachment) end

-- Sets the "color" of the effect.  All this does is provide an addition 8 bits of data for the effect to use. What this will actually do will vary from effect to effect, depending on how a specific effect uses this given data, if at all.  Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to 0-255 range.
---@param color number Color represented by a byte.
function CEffectData:SetColor(color) end

-- Sets the damage type of the effect to be created with this effect data.
---@param damageType number Damage type, see Enums/DMG.
function CEffectData:SetDamageType(damageType) end

-- Sets the entity of the effect via its index.
---@param entIndex number The entity index to be set.
function CEffectData:SetEntIndex(entIndex) end

-- Sets the entity of the effect to be created with this effect data.
---@param entity Entity Entity of the effect, mostly used for parenting.
function CEffectData:SetEntity(entity) end

-- Sets the flags of the effect. Can be used to change the appearance of a MuzzleFlash effect.  ## Example values for MuzzleFlash effect Flags |  Description | ------|--------------| 1 | Regular muzzleflash| 5 | Combine muzzleflash| 7 | Regular muzzle but bigger|  Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `0-255` range.
---@param flags number The flags of the effect. Each effect has their own flags.
function CEffectData:SetFlags(flags) end

-- Sets the hit box index of the effect.  Internally stored as an integer, but only first 11 bits are networked, effectively limiting this function to 0-2047 range.
---@param hitBoxIndex number The hit box index of the effect.
function CEffectData:SetHitBox(hitBoxIndex) end

-- Sets the magnitude of the effect. Internally stored as a float with 12 bit precision for networking purposes, limited to range of 0-1023.
---@param magnitude number The magnitude of the effect.
function CEffectData:SetMagnitude(magnitude) end

-- Sets the material index of the effect.  Internally stored as an integer, but only first 12 bits are networked, effectively limiting this function to 0-4095 range.
---@param materialIndex number The material index of the effect.
function CEffectData:SetMaterialIndex(materialIndex) end

-- Sets the normalized (length=1) direction vector of the effect to be created with this effect data. This **must** be a normalized vector for networking purposes.
---@param normal Vector The normalized direction vector of the effect.
function CEffectData:SetNormal(normal) end

-- Sets the origin of the effect to be created with this effect data. Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)
---@param origin Vector Origin of the effect.
function CEffectData:SetOrigin(origin) end

-- Sets the radius of the effect to be created with this effect data.  Internally stored as a float, but networked as a 10bit float, and is clamped to 0-1023 range.
---@param radius number Radius of the effect.
function CEffectData:SetRadius(radius) end

-- Sets the scale of the effect to be created with this effect data.
---@param scale number Scale of the effect.
function CEffectData:SetScale(scale) end

-- Sets the start of the effect to be created with this effect data. Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)
---@param start Vector Start of the effect.
function CEffectData:SetStart(start) end

-- Sets the surface property index of the effect. Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `-1`-`254` range.(yes, that's not a mistake)
---@param surfaceProperties number The surface property index of the effect.
function CEffectData:SetSurfaceProp(surfaceProperties) end



---@class CLuaEmitter
CLuaEmitter = CLuaEmitter

-- Creates a new CLuaParticle with the given material and position.
---@param material string The particles material. Can also be an IMaterial.
---@param position Vector The position to spawn the particle on.
---@return CLuaParticle
function CLuaEmitter:Add(material,position) end

-- Manually renders all particles the emitter has created.
function CLuaEmitter:Draw() end

-- Removes the emitter, making it no longer usable from Lua. If particles remain, the emitter will be removed when all particles die.
function CLuaEmitter:Finish() end

-- Returns the amount of active particles of this emitter.
---@return number
function CLuaEmitter:GetNumActiveParticles() end

-- Returns the position of this emitter. This is set when creating the emitter with Global.ParticleEmitter.
---@return Vector
function CLuaEmitter:GetPos() end

-- Returns whether this emitter is 3D or not. This is set when creating the emitter with Global.ParticleEmitter.
---@return boolean
function CLuaEmitter:Is3D() end

-- Returns whether this CLuaEmitter is valid or not.
---@return boolean
function CLuaEmitter:IsValid() end

-- Sets the bounding box for this emitter.  Usually the bounding box is automatically determined by the particles, but this function overrides it.
---@param mins Vector The minimum position of the box
---@param maxs Vector The maximum position of the box
function CLuaEmitter:SetBBox(mins,maxs) end

-- This function sets the the distance between the render camera and the emitter at which the particles should start fading and at which distance fade ends ( alpha becomes 0 ).
---@param distanceMin number Min distance where the alpha becomes 0.
---@param distanceMax number Max distance where the alpha starts fading.
function CLuaEmitter:SetNearClip(distanceMin,distanceMax) end

-- Prevents all particles of the emitter from automatically drawing.
---@param noDraw boolean Whether we should draw the particles ( false ) or not ( true )
function CLuaEmitter:SetNoDraw(noDraw) end

-- The function name has not much in common with its actual function, it applies a radius to every particles that affects the building of the bounding box, as it, usually is constructed by the particle that has the lowest x, y and z and the highest x, y and z, this function just adds/subtracts the radius and inflates the bounding box.
---@param radius number Particle radius.
function CLuaEmitter:SetParticleCullRadius(radius) end

-- Sets the position of the particle emitter.
---@param position Vector New position.
function CLuaEmitter:SetPos(position) end



---@class CLuaLocomotion
CLuaLocomotion = CLuaLocomotion

-- Sets the location we want to get to.  Each call of CLuaLocomotion:Approach moves the NextBot 1 unit towards the specified goal. The size of this unit is determined by CLuaLocomotion:SetDesiredSpeed; the default is `0` (each call of CLuaLocomotion:Approach moves the NextBot 0).  To achieve smooth movement with CLuaLocomotion:Approach, it should be called in a hook like ENTITY:Think, as shown in the example.
---@param goal Vector The vector we want to get to.
---@param goalweight number If unsure then set this to `1`.
function CLuaLocomotion:Approach(goal,goalweight) end

-- Removes the stuck status from the bot
function CLuaLocomotion:ClearStuck() end

-- Sets the direction we want to face
---@param goal Vector The vector we want to face
function CLuaLocomotion:FaceTowards(goal) end

-- Returns the acceleration speed
---@return number
function CLuaLocomotion:GetAcceleration() end

-- Returns whether the Nextbot is allowed to avoid obstacles or not.
---@return boolean
function CLuaLocomotion:GetAvoidAllowed() end

-- Returns whether the Nextbot is allowed to climb or not.
---@return boolean
function CLuaLocomotion:GetClimbAllowed() end

-- Returns the current acceleration as a vector
---@return Vector
function CLuaLocomotion:GetCurrentAcceleration() end

-- Gets the height the bot is scared to fall from
---@return number
function CLuaLocomotion:GetDeathDropHeight() end

-- Gets the deceleration speed
---@return number
function CLuaLocomotion:GetDeceleration() end

-- Returns the desired movement speed set by CLuaLocomotion:SetDesiredSpeed
---@return number
function CLuaLocomotion:GetDesiredSpeed() end

-- Returns the locomotion's gravity.
---@return number
function CLuaLocomotion:GetGravity() end

-- Return unit vector in XY plane describing our direction of motion - even if we are currently not moving
---@return Vector
function CLuaLocomotion:GetGroundMotionVector() end

-- Returns the current ground normal.
---@return Vector
function CLuaLocomotion:GetGroundNormal() end

-- Returns whether the Nextbot is allowed to jump gaps or not.
---@return boolean
function CLuaLocomotion:GetJumpGapsAllowed() end

-- Gets the height of the bot's jump
---@return number
function CLuaLocomotion:GetJumpHeight() end

-- Returns maximum jump height of this CLuaLocomotion.
---@return number
function CLuaLocomotion:GetMaxJumpHeight() end

-- Returns the max rate at which the NextBot can visually rotate.
---@return number
function CLuaLocomotion:GetMaxYawRate() end

-- Returns the NextBot this locomotion is associated with.
---@return NextBot
function CLuaLocomotion:GetNextBot() end

-- Gets the max height the bot can step up
---@return number
function CLuaLocomotion:GetStepHeight() end

-- Returns the current movement velocity as a vector
---@return Vector
function CLuaLocomotion:GetVelocity() end

-- Returns whether this CLuaLocomotion can reach and/or traverse/move in given CNavArea.
---@param area CNavArea The area to test
---@return boolean
function CLuaLocomotion:IsAreaTraversable(area) end

-- Returns true if we're trying to move.
---@return boolean
function CLuaLocomotion:IsAttemptingToMove() end

-- Returns true of the locomotion engine is jumping or climbing
---@return boolean
function CLuaLocomotion:IsClimbingOrJumping() end

-- Returns whether the nextbot this locomotion is attached to is on ground or not.
---@return boolean
function CLuaLocomotion:IsOnGround() end

-- Returns true if we're stuck
---@return boolean
function CLuaLocomotion:IsStuck() end

-- Returns whether or not the target in question is on a ladder or not.
---@return boolean
function CLuaLocomotion:IsUsingLadder() end

-- Makes the bot jump. It must be on ground (Entity:IsOnGround) and its model must have `ACT_JUMP` activity.
function CLuaLocomotion:Jump() end

-- Makes the bot jump across a gap. The bot must be on ground (Entity:IsOnGround) and its model must have `ACT_JUMP` activity.
---@param landingGoal Vector
---@param landingForward Vector
function CLuaLocomotion:JumpAcrossGap(landingGoal,landingForward) end

-- Sets the acceleration speed
---@param speed number Speed acceleration (default is 400)
function CLuaLocomotion:SetAcceleration(speed) end

-- Sets whether the Nextbot is allowed try to to avoid obstacles or not. This is used during path generation. Works similarly to `nb_allow_avoiding` convar. By default bots are allowed to try to avoid obstacles.
---@param allowed boolean Whether this bot should be allowed to try to avoid obstacles.
function CLuaLocomotion:SetAvoidAllowed(allowed) end

-- Sets whether the Nextbot is allowed to climb or not. This is used during path generation. Works similarly to `nb_allow_climbing` convar. By default bots are allowed to climb.
---@param allowed boolean Whether this bot should be allowed to climb.
function CLuaLocomotion:SetClimbAllowed(allowed) end

-- Sets the height the bot is scared to fall from.
---@param height number Height (default is 200)
function CLuaLocomotion:SetDeathDropHeight(height) end

-- Sets the deceleration speed.
---@param deceleration number New deceleration speed (default is 400)
function CLuaLocomotion:SetDeceleration(deceleration) end

-- Sets movement speed.
---@param speed number The new desired speed
function CLuaLocomotion:SetDesiredSpeed(speed) end

-- Sets the locomotion's gravity.  With values 0 or below, or even lower positive values, the nextbot will start to drift sideways, use CLuaLocomotion:SetVelocity to counteract this.
---@param gravity number New gravity to set. Default is 1000.
function CLuaLocomotion:SetGravity(gravity) end

-- Sets whether the Nextbot is allowed to jump gaps or not. This is used during path generation. Works similarly to `nb_allow_gap_jumping` convar. By default bots are allowed to jump gaps.
---@param allowed boolean Whether this bot should be allowed to jump gaps.
function CLuaLocomotion:SetJumpGapsAllowed(allowed) end

-- Sets the height of the bot's jump
---@param height number Height (default is 58)
function CLuaLocomotion:SetJumpHeight(height) end

-- Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.
---@param yawRate number Desired new maximum yaw rate
function CLuaLocomotion:SetMaxYawRate(yawRate) end

-- Sets the max height the bot can step up
---@param height number Height (default is 18)
function CLuaLocomotion:SetStepHeight(height) end

-- Sets the current movement velocity
---@param velocity Vector
function CLuaLocomotion:SetVelocity(velocity) end



---@class CLuaParticle
CLuaParticle = CLuaParticle

-- Returns the air resistance of the particle.
---@return number
function CLuaParticle:GetAirResistance() end

-- Returns the current orientation of the particle.
---@return Angle
function CLuaParticle:GetAngles() end

-- Returns the angular velocity of the particle
---@return Angle
function CLuaParticle:GetAngleVelocity() end

-- Returns the 'bounciness' of the particle.
---@return number
function CLuaParticle:GetBounce() end

-- Returns the color of the particle.
---@return number
---@return number
---@return number
function CLuaParticle:GetColor() end

-- Returns the amount of time in seconds after which the particle will be destroyed.
---@return number
function CLuaParticle:GetDieTime() end

-- Returns the alpha value that the particle will reach on its death.
---@return number
function CLuaParticle:GetEndAlpha() end

-- Returns the length that the particle will reach on its death.
---@return number
function CLuaParticle:GetEndLength() end

-- Returns the size that the particle will reach on its death.
---@return number
function CLuaParticle:GetEndSize() end

-- Returns the gravity of the particle.
---@return Vector
function CLuaParticle:GetGravity() end

-- Returns the 'life time' of the particle, how long the particle existed since its creation.  This value will always be between 0 and CLuaParticle:GetDieTime.   It changes automatically as time goes.  It can be manipulated using CLuaParticle:SetLifeTime.   If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
---@return number
function CLuaParticle:GetLifeTime() end

-- Returns the current material of the particle.
---@return IMaterial
function CLuaParticle:GetMaterial() end

-- Returns the absolute position of the particle.
---@return Vector
function CLuaParticle:GetPos() end

-- Returns the current rotation of the particle in radians, this should only be used for 2D particles.
---@return number
function CLuaParticle:GetRoll() end

-- Returns the current rotation speed of the particle in radians, this should only be used for 2D particles.
---@return number
function CLuaParticle:GetRollDelta() end

-- Returns the alpha value which the particle has when it's created.
---@return number
function CLuaParticle:GetStartAlpha() end

-- Returns the length which the particle has when it's created.
---@return number
function CLuaParticle:GetStartLength() end

-- Returns the size which the particle has when it's created.
---@return number
function CLuaParticle:GetStartSize() end

-- Returns the current velocity of the particle.
---@return Vector
function CLuaParticle:GetVelocity() end

-- Sets the air resistance of the the particle.
---@param airResistance number New air resistance.
function CLuaParticle:SetAirResistance(airResistance) end

-- Sets the angles of the particle.
---@param ang Angle New angle.
function CLuaParticle:SetAngles(ang) end

-- Sets the angular velocity of the the particle.
---@param angVel Angle New angular velocity.
function CLuaParticle:SetAngleVelocity(angVel) end

-- Sets the 'bounciness' of the the particle.
---@param bounce number New 'bounciness' of the particle  2 means it will gain 100% of its previous velocity,   1 means it will not lose velocity,   0.5 means it will lose half of its velocity with each bounce.
function CLuaParticle:SetBounce(bounce) end

-- Sets the whether the particle should collide with the world or not.
---@param shouldCollide boolean Whether the particle should collide with the world or not
function CLuaParticle:SetCollide(shouldCollide) end

-- Sets the function that gets called whenever the particle collides with the world.
---@param collideFunc function Collide callback, the arguments are:     CLuaParticle particle - The particle itself  Vector hitPos - Position of the collision  Vector hitNormal - Direction of the collision, perpendicular to the hit surface
function CLuaParticle:SetCollideCallback(collideFunc) end

-- Sets the color of the particle.
---@param r number The red component.
---@param g number The green component.
---@param b number The blue component.
function CLuaParticle:SetColor(r,g,b) end

-- Sets the time where the particle will be removed.
---@param dieTime number The new die time.
function CLuaParticle:SetDieTime(dieTime) end

-- Sets the alpha value of the particle that it will reach when it dies.
---@param endAlpha number The new alpha value of the particle that it will reach when it dies.
function CLuaParticle:SetEndAlpha(endAlpha) end

-- Sets the length of the particle that it will reach when it dies.
---@param endLength number The new length of the particle that it will reach when it dies.
function CLuaParticle:SetEndLength(endLength) end

-- Sets the size of the particle that it will reach when it dies.
---@param endSize number The new size of the particle that it will reach when it dies.
function CLuaParticle:SetEndSize(endSize) end

-- Sets the directional gravity aka. acceleration of the particle.
---@param gravity Vector The directional gravity.
function CLuaParticle:SetGravity(gravity) end

-- Sets the 'life time' of the particle, how long the particle existed since its creation.  This value should always be between 0 and CLuaParticle:GetDieTime.   It changes automatically as time goes.   If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
---@param lifeTime number The new life time of the particle.
function CLuaParticle:SetLifeTime(lifeTime) end

-- Sets whether the particle should be affected by lighting.
---@param useLighting boolean Whether the particle should be affected by lighting.
function CLuaParticle:SetLighting(useLighting) end

-- Sets the material of the particle.
---@param mat IMaterial The new material to set. Can also be a string.
function CLuaParticle:SetMaterial(mat) end

-- Sets when the particles think function should be called next, this uses the synchronized server time returned by Global.CurTime.
---@param nextThink number Next think time.
function CLuaParticle:SetNextThink(nextThink) end

-- Sets the absolute position of the particle.
---@param pos Vector The new particle position.
function CLuaParticle:SetPos(pos) end

-- Sets the roll of the particle in radians. This should only be used for 2D particles.
---@param roll number The new rotation of the particle in radians.
function CLuaParticle:SetRoll(roll) end

-- Sets the rotation speed of the particle in radians. This should only be used for 2D particles.
---@param rollDelta number The new rotation speed of the particle in radians.
function CLuaParticle:SetRollDelta(rollDelta) end

-- Sets the initial alpha value of the particle.
---@param startAlpha number Initial alpha.
function CLuaParticle:SetStartAlpha(startAlpha) end

-- Sets the initial length value of the particle.
---@param startLength number Initial length.
function CLuaParticle:SetStartLength(startLength) end

-- Sets the initial size value of the particle.
---@param startSize number Initial size.
function CLuaParticle:SetStartSize(startSize) end

-- Sets the think function of the particle.
---@param thinkFunc function Think function. It has only one argument:   CLuaParticle particle - The particle the think hook is set on
function CLuaParticle:SetThinkFunction(thinkFunc) end

-- Sets the velocity of the particle.
---@param vel Vector The new velocity of the particle.
function CLuaParticle:SetVelocity(vel) end

-- Scales the velocity based on the particle speed.
---@param doScale? boolean Use velocity scaling.
function CLuaParticle:SetVelocityScale(doScale) end



---@class CMoveData
CMoveData = CMoveData

-- Adds keys to the move data, as if player pressed them.
---@param keys number Keys to add, see Enums/IN
function CMoveData:AddKey(keys) end

-- Gets the aim angle. Seems to be same as CMoveData:GetAngles.
---@return Angle
function CMoveData:GetAbsMoveAngles() end

-- Gets the aim angle. On client is the same as Entity:GetAngles.
---@return Angle
function CMoveData:GetAngles() end

-- Gets which buttons are down
---@return number
function CMoveData:GetButtons() end

-- Returns the center of the player movement constraint. See CMoveData:SetConstraintCenter.
---@return Vector
function CMoveData:GetConstraintCenter() end

-- Returns the radius that constrains the players movement. See CMoveData:SetConstraintRadius.
---@return number
function CMoveData:GetConstraintRadius() end

-- Returns the player movement constraint speed scale. See CMoveData:SetConstraintSpeedScale.
---@return number
function CMoveData:GetConstraintSpeedScale() end

-- Returns the width (distance from the edge of the radius, inward) where the actual movement constraint functions.
---@return number
function CMoveData:GetConstraintWidth() end

-- Returns an internal player movement variable `m_outWishVel`.
---@return Vector
function CMoveData:GetFinalIdealVelocity() end

-- Returns an internal player movement variable `m_outJumpVel`.
---@return Vector
function CMoveData:GetFinalJumpVelocity() end

-- Returns an internal player movement variable `m_outStepHeight`.
---@return number
function CMoveData:GetFinalStepHeight() end

-- Returns the players forward speed.
---@return number
function CMoveData:GetForwardSpeed() end

-- Gets the number passed to "impulse" console command
---@return number
function CMoveData:GetImpulseCommand() end

-- Returns the maximum client speed of the player
---@return number
function CMoveData:GetMaxClientSpeed() end

-- Returns the maximum speed of the player.
---@return number
function CMoveData:GetMaxSpeed() end

-- Returns the angle the player is moving at. For more info, see CMoveData:SetMoveAngles.
---@return Angle
function CMoveData:GetMoveAngles() end

-- Gets the aim angle. Only works clientside, server returns same as CMoveData:GetAngles.
---@return Angle
function CMoveData:GetOldAngles() end

-- Get which buttons were down last frame
---@return number
function CMoveData:GetOldButtons() end

-- Gets the player's position.
---@return Vector
function CMoveData:GetOrigin() end

-- Returns the strafe speed of the player.
---@return number
function CMoveData:GetSideSpeed() end

-- Returns the vertical speed of the player. ( Z axis of CMoveData:GetVelocity )
---@return number
function CMoveData:GetUpSpeed() end

-- Gets the players velocity.  This will return Vector(0,0,0) sometimes when walking on props.
---@return Vector
function CMoveData:GetVelocity() end

-- Returns whether the key is down or not
---@param key number The key to test, see Enums/IN
---@return boolean
function CMoveData:KeyDown(key) end

-- Returns whether the key was pressed. If you want to check if the key is held down, try CMoveData:KeyDown
---@param key number The key to test, see Enums/IN
---@return boolean
function CMoveData:KeyPressed(key) end

-- Returns whether the key was released
---@param key number A key to test, see Enums/IN
---@return boolean
function CMoveData:KeyReleased(key) end

-- Returns whether the key was down or not.     Unlike CMoveData:KeyDown, it will return false if CMoveData:KeyPressed is true and it will return true if CMoveData:KeyReleased is true.
---@param key number The key to test, see Enums/IN
---@return boolean
function CMoveData:KeyWasDown(key) end

-- Sets absolute move angles.( ? ) Doesn't seem to do anything.
---@param ang Angle New absolute move angles
function CMoveData:SetAbsMoveAngles(ang) end

-- Sets angles.  This function does nothing.
---@param ang Angle The angles.
function CMoveData:SetAngles(ang) end

-- Sets the pressed buttons on the move data
---@param buttons number A number representing which buttons are down, see Enums/IN
function CMoveData:SetButtons(buttons) end

-- Sets the center of the player movement constraint. See CMoveData:SetConstraintRadius.
---@param pos Vector The constraint origin.
function CMoveData:SetConstraintCenter(pos) end

-- Sets the radius that constrains the players movement.  Works with conjunction of: * CMoveData:SetConstraintWidth * CMoveData:SetConstraintSpeedScale * CMoveData:SetConstraintCenter
---@param radius number The new constraint radius
function CMoveData:SetConstraintRadius(radius) end

-- Sets the player movement constraint speed scale. This will be applied to the player within the CMoveData:SetConstraintRadius when approaching its edge.
---@param var number The constraint speed scale
function CMoveData:SetConstraintSpeedScale(var) end

-- Sets  the width (distance from the edge of the CMoveData:SetConstraintRadius, inward) where the actual movement constraint functions.
---@param var number The constraint width
function CMoveData:SetConstraintWidth(var) end

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
---@param speed number New forward speed
function CMoveData:SetForwardSpeed(speed) end

-- Sets the impulse command. This isn't actually utilised in the engine anywhere.
---@param impulse number The impulse to set
function CMoveData:SetImpulseCommand(impulse) end

-- Sets the maximum player speed. Player won't be able to run or sprint faster then this value.   This also automatically sets CMoveData:SetMaxSpeed when used in the GM:SetupMove hook. You must set it manually in the GM:Move hook.   This must be called on both client and server to avoid prediction errors.   This will **not** reduce speed in air. Setting this to 0 will not make the player stationary. It won't do anything.
---@param maxSpeed number The new maximum speed
function CMoveData:SetMaxClientSpeed(maxSpeed) end

-- Sets the maximum speed of the player. This must match with CMoveData:SetMaxClientSpeed both, on server and client.   Doesn't seem to be doing anything on it's own, use CMoveData:SetMaxClientSpeed instead.
---@param maxSpeed number The new maximum speed
function CMoveData:SetMaxSpeed(maxSpeed) end

-- Sets the serverside move angles, making the movement keys act as if player was facing that direction.  This does nothing clientside.
---@param dir Angle The aim direction.
function CMoveData:SetMoveAngles(dir) end

-- Sets old aim angles. ( ? ) Doesn't seem to be doing anything.
---@param aimAng Angle The old angles
function CMoveData:SetOldAngles(aimAng) end

-- Sets the 'old' pressed buttons on the move data. These buttons are used to work out which buttons have been released, which have just been pressed and which are being held down.
---@param buttons number A number representing which buttons were down, see Enums/IN
function CMoveData:SetOldButtons(buttons) end

-- Sets the players position.
---@param pos Vector The position
function CMoveData:SetOrigin(pos) end

-- Sets players strafe speed.
---@param speed number Strafe speed
function CMoveData:SetSideSpeed(speed) end

-- Sets vertical speed of the player. ( Z axis of CMoveData:SetVelocity )
---@param speed number Vertical speed to set
function CMoveData:SetUpSpeed(speed) end

-- Sets the player's velocity
---@param velocity Vector The velocity to set
function CMoveData:SetVelocity(velocity) end



---@class CNavArea
CNavArea = CNavArea

-- Adds a hiding spot onto this nav area.  There's a limit of 255 hiding spots per area.
---@param pos Vector The position on the nav area
---@param flags? number Flags describing what kind of hiding spot this is. * 0 = None (Not recommended) * 1 = In Cover/basically a hiding spot, in a corner with good hard cover nearby * 2 = good sniper spot, had at least one decent sniping corridor * 4 = perfect sniper spot, can see either very far, or a large area, or both * 8 = exposed, spot in the open, usually on a ledge or cliff  Values over 255 will be clamped.
function CNavArea:AddHidingSpot(pos,flags) end

-- Adds this CNavArea to the closed list, a list of areas that have been checked by A* pathfinding algorithm.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
function CNavArea:AddToClosedList() end

-- Adds this CNavArea to the Open List.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
function CNavArea:AddToOpenList() end

-- Clears the open and closed lists for a new search.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
function CNavArea:ClearSearchLists() end

-- Returns the height difference between the edges of two connected navareas.
---@param navarea CNavArea
---@return number
function CNavArea:ComputeAdjacentConnectionHeightChange(navarea) end

-- Returns the Enums/NavDir direction that the given vector faces on this CNavArea.
---@param pos Vector The position to compute direction towards.
---@return number
function CNavArea:ComputeDirection(pos) end

-- Returns the height difference on the Z axis of the two CNavAreas. This is calculated from the center most point on both CNavAreas.
---@param navArea CNavArea The nav area to test against.
---@return number
function CNavArea:ComputeGroundHeightChange(navArea) end

-- Connects this CNavArea to another CNavArea or CNavLadder with a one way connection. ( From this area to the target )  See CNavLadder:ConnectTo for making the connection from ladder to area.
---@param area CNavArea The CNavArea or CNavLadder this area leads to.
function CNavArea:ConnectTo(area) end

-- Returns true if this CNavArea contains the given vector.
---@param pos Vector The position to test.
---@return boolean
function CNavArea:Contains(pos) end

-- Disconnects this nav area from given area or ladder. (Only disconnects one way)
---@param area CNavArea The CNavArea or CNavLadder this to disconnect from.
function CNavArea:Disconnect(area) end

-- Draws this navarea on debug overlay.
function CNavArea:Draw() end

-- Draws the hiding spots on debug overlay. This includes sniper/exposed spots too!
function CNavArea:DrawSpots() end

-- Returns a table of all the CNavAreas that have a  ( one and two way ) connection **from** this CNavArea.  If an area has a one-way incoming connection to this CNavArea, then it will **not** be returned from this function, use CNavArea:GetIncomingConnections to get all one-way incoming connections.  See CNavArea:GetAdjacentAreasAtSide for a function that only returns areas from one side/direction.
---@return table
function CNavArea:GetAdjacentAreas() end

-- Returns a table of all the CNavAreas that have a ( one and two way ) connection **from** this CNavArea in given direction.  If an area has a one-way incoming connection to this CNavArea, then it will **not** be returned from this function, use CNavArea:GetIncomingConnections to get all incoming connections.  See CNavArea:GetAdjacentAreas for a function that returns all areas from all sides/directions.
---@param navDir number The direction, in which to look for CNavAreas, see Enums/NavDir.
---@return table
function CNavArea:GetAdjacentAreasAtSide(navDir) end

-- Returns the amount of CNavAreas that have a connection ( one and two way ) **from** this CNavArea.  See CNavArea:GetAdjacentCountAtSide for a function that only returns area count from one side/direction.
---@return number
function CNavArea:GetAdjacentCount() end

-- Returns the amount of CNavAreas that have a connection ( one or two way ) **from** this CNavArea in given direction.  See CNavArea:GetAdjacentCount for a function that returns CNavArea count from/in all sides/directions.
---@param navDir number The direction, in which to look for CNavAreas, see Enums/NavDir.
---@return number
function CNavArea:GetAdjacentCountAtSide(navDir) end

-- Returns the attribute mask for the given CNavArea.
---@return number
function CNavArea:GetAttributes() end

-- Returns the center most vector point for the given CNavArea.
---@return Vector
function CNavArea:GetCenter() end

-- Returns the closest point of this Nav Area from the given position.
---@param pos Vector The given position, can be outside of the Nav Area bounds.
---@return Vector
function CNavArea:GetClosestPointOnArea(pos) end

-- Returns the vector position of the corner for the given CNavArea.
---@param cornerid number The target corner to get the position of, takes Enums/NavCorner.
---@return Vector
function CNavArea:GetCorner(cornerid) end

-- Returns the cost from starting area this area when pathfinding. Set by CNavArea:SetCostSoFar.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return number
function CNavArea:GetCostSoFar() end

-- Returns a table of very bad hiding spots in this area.  See also CNavArea:GetHidingSpots.
---@return table
function CNavArea:GetExposedSpots() end

-- Returns size info about the nav area.
---@return table
function CNavArea:GetExtentInfo() end

-- Returns a table of good hiding spots in this area.  See also CNavArea:GetExposedSpots.
---@param type? number The type of spots to include.  * 0 = None (Not recommended) * 1 = In Cover/basically a hiding spot, in a corner with good hard cover nearby * 2 = good sniper spot, had at least one decent sniping corridor * 4 = perfect sniper spot, can see either very far, or a large area, or both * 8 = exposed, spot in the open, usually on a ledge or cliff, same as GetExposedSpots * Values over 255 and below 0 will be clamped.
---@return table
function CNavArea:GetHidingSpots(type) end

-- Returns this CNavAreas unique ID.
---@return number
function CNavArea:GetID() end

-- Returns a table of all the CNavAreas that have a one-way connection **to** this CNavArea.  If a CNavArea has a two-way connection **to or from** this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections.  See CNavArea:GetIncomingConnectionsAtSide for a function that returns one-way incoming connections from  only one side/direction.
---@return table
function CNavArea:GetIncomingConnections() end

-- Returns a table of all the CNavAreas that have a one-way connection **to** this CNavArea from given direction.  If a CNavArea has a two-way connection **to or from** this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections.  See CNavArea:GetIncomingConnections for a function that returns one-way incoming connections from  all sides/directions.
---@param navDir number The direction, from which to look for CNavAreas, see Enums/NavDir.
---@return table
function CNavArea:GetIncomingConnectionsAtSide(navDir) end

-- Returns all CNavLadders that have a ( one or two way ) connection **from** this CNavArea.  See CNavArea:GetLaddersAtSide for a function that only returns CNavLadders in given direction.
---@return table
function CNavArea:GetLadders() end

-- Returns all CNavLadders that have a ( one or two way ) connection **from** ( one and two way ) this CNavArea in given direction.  See CNavArea:GetLadders for a function that returns CNavLadder from/in all sides/directions.
---@param navDir number The direction, in which to look for CNavLadders.  0 = Up ( LadderDirectionType::LADDER_UP ) 1 = Down ( LadderDirectionType::LADDER_DOWN )
---@return table
function CNavArea:GetLaddersAtSide(navDir) end

-- Returns the parent CNavArea
---@return CNavArea
function CNavArea:GetParent() end

-- Returns how this CNavArea is connected to its parent.
---@return number
function CNavArea:GetParentHow() end

-- Returns the Place of the nav area.
---@return string
function CNavArea:GetPlace() end

-- Returns a random CNavArea that has an outgoing ( one or two way ) connection **from** this CNavArea in given direction.
---@param navDir number The direction, in which to look for CNavAreas, see Enums/NavDir.
---@return CNavArea
function CNavArea:GetRandomAdjacentAreaAtSide(navDir) end

-- Returns a random point on the nav area.
---@return Vector
function CNavArea:GetRandomPoint() end

-- Returns the width this Nav Area.
---@return number
function CNavArea:GetSizeX() end

-- Returns the height of this Nav Area.
---@return number
function CNavArea:GetSizeY() end

-- Returns the total cost when passing from starting area to the goal area through this node. Set by CNavArea:SetTotalCost.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return number
function CNavArea:GetTotalCost() end

-- Returns the elevation of this Nav Area at the given position.
---@param pos Vector The position to get the elevation from, the z value from this position is ignored and only the X and Y values are used to this task.
---@return number
function CNavArea:GetZ(pos) end

-- Returns true if the given CNavArea has this attribute flag set.
---@param attribs number Attribute mask to check for, see Enums/NAV_MESH
---@return boolean
function CNavArea:HasAttributes(attribs) end

-- Returns whether the nav area is blocked or not, i.e. whether it can be walked through or not.
---@param teamID? number The team ID to test, -2 = any team.  Only 2 actual teams are available, 0 and 1.
---@param ignoreNavBlockers? boolean Whether to ignore [func_nav_blocker](https://developer.valvesoftware.com/wiki/Func_nav_blocker) entities.
---@return boolean
function CNavArea:IsBlocked(teamID,ignoreNavBlockers) end

-- Returns whether this node is in the Closed List.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return boolean
function CNavArea:IsClosed() end

-- Returns whether this CNavArea can completely (i.e. all corners of this area can see all corners of the given area) see the given CNavArea.
---@param area CNavArea The CNavArea to test.
---@return boolean
function CNavArea:IsCompletelyVisible(area) end

-- Returns whether this CNavArea has an outgoing ( one or two way ) connection **to** given CNavArea.  See CNavArea:IsConnectedAtSide for a function that only checks for outgoing connections in one direction.
---@param navArea CNavArea The CNavArea to test against.
---@return boolean
function CNavArea:IsConnected(navArea) end

-- Returns whether this CNavArea has an outgoing ( one or two way ) connection **to** given CNavArea in given direction.  See CNavArea:IsConnected for a function that checks all sides.
---@param navArea CNavArea The CNavArea to test against.
---@param navDirType number The direction, in which to look for the connection. See Enums/NavDir
---@return boolean
function CNavArea:IsConnectedAtSide(navArea,navDirType) end

-- Returns whether this Nav Area is in the same plane as the given one.
---@param navArea CNavArea The Nav Area to test.
---@return boolean
function CNavArea:IsCoplanar(navArea) end

-- Returns whether this Nav Area is flat within the tolerance of the **nav_coplanar_slope_limit_displacement** and **nav_coplanar_slope_limit** convars.
---@return boolean
function CNavArea:IsFlat() end

-- Returns whether this area is in the Open List.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return boolean
function CNavArea:IsOpen() end

-- Returns whether the Open List is empty or not.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return boolean
function CNavArea:IsOpenListEmpty() end

-- Returns if this position overlaps the Nav Area within the given tolerance.
---@param pos Vector The overlapping position to test.
---@param tolerance? number The tolerance of the overlapping, set to 0 for no tolerance.
---@return boolean
function CNavArea:IsOverlapping(pos,tolerance) end

-- Returns true if this CNavArea is overlapping the given CNavArea.
---@param navArea CNavArea The CNavArea to test against.
---@return boolean
function CNavArea:IsOverlappingArea(navArea) end

-- Returns whether this CNavArea can see given position.
---@param pos Vector The position to test.
---@param ignoreEnt? Entity If set, the given entity will be ignored when doing LOS tests
---@return boolean
function CNavArea:IsPartiallyVisible(pos,ignoreEnt) end

-- Returns whether this CNavArea can potentially see the given CNavArea.
---@param area CNavArea The CNavArea to test.
---@return boolean
function CNavArea:IsPotentiallyVisible(area) end

-- Returns if we're shaped like a square.
---@return boolean
function CNavArea:IsRoughlySquare() end

-- Whether this Nav Area is placed underwater.
---@return boolean
function CNavArea:IsUnderwater() end

-- Returns whether this CNavArea is valid or not.
---@return boolean
function CNavArea:IsValid() end

-- Returns whether we can be seen from the given position.
---@param pos Vector The position to check.
---@return boolean
---@return Vector
function CNavArea:IsVisible(pos) end

-- Drops a corner or all corners of a CNavArea to the ground below it.
---@param corner number The corner(s) to drop, uses Enums/NavCorner
function CNavArea:PlaceOnGround(corner) end

-- Removes a CNavArea from the Open List with the lowest cost to traverse to from the starting node, and returns it.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@return CNavArea
function CNavArea:PopOpenList() end

-- Removes the given nav area.
function CNavArea:Remove() end

-- Removes this node from the Closed List.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
function CNavArea:RemoveFromClosedList() end

-- Sets the attributes for given CNavArea.
---@param attribs number The attribute bitflag. See Enums/NAV_MESH
function CNavArea:SetAttributes(attribs) end

-- Sets the position of a corner of a nav area.
---@param corner number The corner to set, uses Enums/NavCorner
---@param position Vector The new position to set.
function CNavArea:SetCorner(corner,position) end

-- Sets the cost from starting area this area when pathfinding.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@param cost number The cost so far
function CNavArea:SetCostSoFar(cost) end

-- Sets the new parent of this CNavArea.
---@param parent CNavArea The new parent to set
---@param how number How we get from parent to us using Enums/NavTraverseType
function CNavArea:SetParent(parent,how) end

-- Sets the Place of the nav area.  There is a limit of 256 Places per nav file.
---@param place string Set to "" to remove place from the nav area.
---@return boolean
function CNavArea:SetPlace(place) end

-- Sets the total cost when passing from starting area to the goal area through this node.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
---@param cost number The total cost of the path to set.  Must be above or equal 0.
function CNavArea:SetTotalCost(cost) end

-- Moves this open list to appropriate position based on its CNavArea:GetTotalCost compared to the total cost of other areas in the open list.  Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).   More information can be found on the Simple Pathfinding page.
function CNavArea:UpdateOnOpenList() end



---@class CNavLadder
CNavLadder = CNavLadder

-- Connects this ladder to a CNavArea with a one way connection. ( From this ladder to the target area ).  See CNavArea:ConnectTo for making the connection from area to ladder.
---@param area CNavArea The area this ladder leads to.
function CNavLadder:ConnectTo(area) end

-- Disconnects this ladder from given area in a single direction.
---@param area CNavArea The CNavArea this to disconnect from.
function CNavLadder:Disconnect(area) end

-- Returns the bottom most position of the ladder.
---@return Vector
function CNavLadder:GetBottom() end

-- Returns the bottom area of the CNavLadder.
---@return CNavArea
function CNavLadder:GetBottomArea() end

-- Returns this CNavLadders unique ID.
---@return number
function CNavLadder:GetID() end

-- Returns the length of the ladder.
---@return number
function CNavLadder:GetLength() end

-- Returns the direction of this CNavLadder. ( The direction in which players back will be facing if they are looking directly at the ladder )
---@return Vector
function CNavLadder:GetNormal() end

-- Returns the world position based on given height relative to the ladder.
---@param height number The Z position in world space coordinates.
---@return Vector
function CNavLadder:GetPosAtHeight(height) end

-- Returns the topmost position of the ladder.
---@return Vector
function CNavLadder:GetTop() end

-- Returns the top behind CNavArea of the CNavLadder.
---@return CNavArea
function CNavLadder:GetTopBehindArea() end

-- Returns the top forward CNavArea of the CNavLadder.
---@return CNavArea
function CNavLadder:GetTopForwardArea() end

-- Returns the top left CNavArea of the CNavLadder.
---@return CNavArea
function CNavLadder:GetTopLeftArea() end

-- Returns the top right CNavArea of the CNavLadder.
---@return CNavArea
function CNavLadder:GetTopRightArea() end

-- Returns the width of the ladder in Hammer Units.
---@return number
function CNavLadder:GetWidth() end

-- Returns whether this CNavLadder has an outgoing ( one or two way ) connection **to** given CNavArea in given direction.
---@param navArea CNavArea The CNavArea to test against.
---@param navDirType number The direction, in which to look for the connection. See Enums/NavDir
---@return boolean
function CNavLadder:IsConnectedAtSide(navArea,navDirType) end

-- Returns whether this CNavLadder is valid or not.
---@return boolean
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

-- Adds a control point to the particle system.  This function will not work if the CNewParticleEffect:GetOwner entity is not valid
---@param cpID number The control point ID, 0 to 63.
---@param ent Entity The entity to attach the control point to.
---@param partAttachment number See Enums/PATTACH.
---@param entAttachment? number The attachment ID on the entity to attach the particle system to
---@param offset? Vector The offset from the Entity:GetPos of the entity we are attaching this CP to.
function CNewParticleEffect:AddControlPoint(cpID,ent,partAttachment,entAttachment,offset) end

---@return boolean
function CNewParticleEffect:GetAutoUpdateBBox() end

-- Returns the name of the particle effect this system is set to emit.
---@return string
function CNewParticleEffect:GetEffectName() end

-- Returns the highest control point number for given particle system.
---@return boolean
function CNewParticleEffect:GetHighestControlPoint() end

-- Returns the owner of the particle system, the entity the particle system is attached to.
---@return Entity
function CNewParticleEffect:GetOwner() end

-- Returns whether the particle system has finished emitting particles or not.
---@return boolean
function CNewParticleEffect:IsFinished() end

-- Returns whether the particle system is valid or not.
---@return boolean
function CNewParticleEffect:IsValid() end

-- Returns whether the particle system is intended to be used on a view model?
---@return boolean
function CNewParticleEffect:IsViewModelEffect() end

-- Forces the particle system to render using current rendering context.  Can be used to render the particle system in vgui panels, etc.  Used in conjunction with CNewParticleEffect:SetShouldDraw.
function CNewParticleEffect:Render() end

-- Forces the particle system to restart emitting particles.
function CNewParticleEffect:Restart() end

-- Sets a value for given control point.
---@param cpID number The control point ID, 0 to 63.
---@param value Vector The value to set for given control point.
function CNewParticleEffect:SetControlPoint(cpID,value) end

-- Essentially makes child control point follow the parent entity.
---@param child number The child control point ID, 0 to 63.
---@param parent Entity The parent entity to follow.
function CNewParticleEffect:SetControlPointEntity(child,parent) end

-- Sets the forward direction for given control point.
---@param cpID number The control point ID, 0 to 63.
---@param forward Vector The forward direction for given control point
function CNewParticleEffect:SetControlPointForwardVector(cpID,forward) end

-- Sets the orientation for given control point.
---@param cpID number The control point ID, 0 to 63.
---@param forward Vector The forward direction for given control point
---@param right Vector The right direction for given control point
---@param up Vector The up direction for given control point
function CNewParticleEffect:SetControlPointOrientation(cpID,forward,right,up) end

-- Essentially makes child control point follow the parent control point.
---@param child number The child control point ID, 0 to 63.
---@param parent number The parent control point ID, 0 to 63.
function CNewParticleEffect:SetControlPointParent(child,parent) end

-- Sets the right direction for given control point.
---@param cpID number The control point ID, 0 to 63.
---@param right Vector The right direction for given control point.
function CNewParticleEffect:SetControlPointRightVector(cpID,right) end

-- Sets the upward direction for given control point.
---@param cpID number The control point ID, 0 to 63.
---@param upward Vector The upward direction for given control point
function CNewParticleEffect:SetControlPointUpVector(cpID,upward) end

---@param isViewModel boolean
function CNewParticleEffect:SetIsViewModelEffect(isViewModel) end

-- Forces the particle system to stop automatically rendering.  Used in conjunction with CNewParticleEffect:Render.
---@param should boolean Whether to automatically draw the particle effect or not.
function CNewParticleEffect:SetShouldDraw(should) end

-- Sets the sort origin for given particle system. This is used as a helper to determine which particles are in front of which.
---@param origin Vector The new sort origin.
function CNewParticleEffect:SetSortOrigin(origin) end

-- Starts the particle emission.
---@param infiniteOnly? boolean
function CNewParticleEffect:StartEmission(infiniteOnly) end

-- Stops the particle emission.
---@param infiniteOnly? boolean
---@param removeAllParticles? boolean
---@param wakeOnStop? boolean
function CNewParticleEffect:StopEmission(infiniteOnly,removeAllParticles,wakeOnStop) end

-- Stops particle emission and destroys all particles instantly. Also detaches the particle effect from the entity it was attached to.  This function will work identically to CNewParticleEffect:StopEmission( false, true ) if  CNewParticleEffect:GetOwner entity is not valid.  Consider using CNewParticleEffect:StopEmission( false, true ) instead, which has same effect, but doesn't require owner entity, and does't detach the particle system from its entity.
function CNewParticleEffect:StopEmissionAndDestroyImmediately() end



---@class Color
Color = Color

-- Sets the red, green, blue, and alpha of the color.
---@param r number The red component
---@param g number The green component
---@param b number The blue component
---@param a number The alpha component
function Color:SetUnpacked(r,g,b,a) end

-- Converts a Color into HSL color space. This calls Global.ColorToHSL internally.
---@return number
---@return number
---@return number
function Color:ToHSL() end

-- Converts a Color into HSV color space. This calls Global.ColorToHSV internally.
---@return number
---@return number
---@return number
function Color:ToHSV() end

-- Returns the color as a table with four elements.
---@return table
function Color:ToTable() end

-- Translates the Color into a Vector, losing the alpha channel. This will also range the values from 0 - 255 to 0 - 1  r / 255 -&gt; x g / 255 -&gt; y b / 255 -&gt; z  This is the opposite of Vector:ToColor
---@return Vector
function Color:ToVector() end

-- Returns the red, green, blue, and alpha of the color.
---@return number
---@return number
---@return number
---@return number
function Color:Unpack() end



---@class ConVar
ConVar = ConVar

-- Tries to convert the current string value of a ConVar to a boolean.
---@return boolean
function ConVar:GetBool() end

-- Returns the default value of the ConVar
---@return string
function ConVar:GetDefault() end

-- Returns the Enums/FCVAR flags of the ConVar
---@return number
function ConVar:GetFlags() end

-- Attempts to convert the ConVar value to a float
---@return number
function ConVar:GetFloat() end

-- Returns the help text assigned to that convar.
---@return string
function ConVar:GetHelpText() end

-- Attempts to convert the ConVar value to a integer.
---@return number
function ConVar:GetInt() end

-- Returns the maximum value of the ConVar
---@return number
function ConVar:GetMax() end

-- Returns the minimum value of the ConVar
---@return number
function ConVar:GetMin() end

-- Returns the name of the ConVar.
---@return string
function ConVar:GetName() end

-- Returns the current ConVar value as a string.
---@return string
function ConVar:GetString() end

-- Returns whether the specified flag is set on the ConVar
---@param flag number The Enums/FCVAR flag to test
---@return boolean
function ConVar:IsFlagSet(flag) end

-- Reverts ConVar to its default value
function ConVar:Revert() end

-- Sets a ConVar's value to 1 or 0 based on the input boolean. This can only be ran on ConVars created from within Lua.
---@param value boolean Value to set the ConVar to.
function ConVar:SetBool(value) end

-- Sets a ConVar's value to the input number. This can only be ran on ConVars created from within Lua.
---@param value number Value to set the ConVar to.
function ConVar:SetFloat(value) end

-- Sets a ConVar's value to the input number after converting it to an integer.  This can only be ran on ConVars created from within Lua.
---@param value number Value to set the ConVar to.
function ConVar:SetInt(value) end

-- Sets a ConVar's value to the input string. This can only be ran on ConVars created from within Lua.
---@param value string Value to set the ConVar to.
function ConVar:SetString(value) end



---@class CRecipientFilter
CRecipientFilter = CRecipientFilter

-- Adds all players to the recipient filter.
function CRecipientFilter:AddAllPlayers() end

-- Adds all players that are in the same [PAS (Potentially Audible Set)](https://developer.valvesoftware.com/wiki/PAS "PAS - Valve Developer Community") as this position.
---@param pos Vector A position that players may be able to hear, usually the position of an entity the sound is playing played from.
function CRecipientFilter:AddPAS(pos) end

-- Adds a player to the recipient filter
---@param Player Player Player to add to the recipient filter.
function CRecipientFilter:AddPlayer(Player) end

-- Adds all players that are in the same [PVS(Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") as this position.
---@param Position Vector PVS position that players may be able to see.
function CRecipientFilter:AddPVS(Position) end

-- Adds all players that are on the given team to the filter.
---@param teamid number Team index to add players from.
function CRecipientFilter:AddRecipientsByTeam(teamid) end

-- Returns the number of valid players in the recipient filter.
---@return number
function CRecipientFilter:GetCount() end

-- Returns a table of all valid players currently in the recipient filter.
---@return table
function CRecipientFilter:GetPlayers() end

-- Removes all players from the recipient filter.
function CRecipientFilter:RemoveAllPlayers() end

-- Removes all players from the filter that are in Potentially Audible Set for given position.
---@param position Vector The position to test
function CRecipientFilter:RemovePAS(position) end

-- Removes the player from the recipient filter.
---@param Player Player The player that should be in the recipient filter if you call this function.
function CRecipientFilter:RemovePlayer(Player) end

-- Removes all players that can see this PVS from the recipient filter.
---@param pos Vector Position that players may be able to see.
function CRecipientFilter:RemovePVS(pos) end

-- Removes all players that are on the given team from the filter.
---@param teamid number Team index to remove players from.
function CRecipientFilter:RemoveRecipientsByTeam(teamid) end

-- Removes all players that are not on the given team from the filter.
---@param teamid number Team index.
function CRecipientFilter:RemoveRecipientsNotOnTeam(teamid) end



---@class CSEnt
CSEnt = CSEnt

-- Removes the clientside entity
function CSEnt:Remove() end



---@class CSoundPatch
CSoundPatch = CSoundPatch

-- Adjust the pitch, alias the speed at which the sound is being played.  This invokes the GM:EntityEmitSound.
---@param pitch number The pitch can range from 0-255. Where 100 is the original pitch.
---@param deltaTime? number The time to fade from previous to the new pitch.
function CSoundPatch:ChangePitch(pitch,deltaTime) end

-- Adjusts the volume of the sound played. Appears to only work while the sound is being played.
---@param volume number The volume ranges from 0 to 1.
---@param deltaTime? number Time to fade the volume from previous to new value from.
function CSoundPatch:ChangeVolume(volume,deltaTime) end

-- Fades out the volume of the sound from the current volume to 0 in the given amount of seconds.
---@param seconds number Fade time.
function CSoundPatch:FadeOut(seconds) end

-- Returns the DSP ( Digital Signal Processor ) effect for the sound.
---@return number
function CSoundPatch:GetDSP() end

-- Returns the current pitch.
---@return number
function CSoundPatch:GetPitch() end

-- Returns the current sound level.
---@return number
function CSoundPatch:GetSoundLevel() end

-- Returns the current volume.
---@return number
function CSoundPatch:GetVolume() end

-- Returns whenever the sound is being played.
---@return boolean
function CSoundPatch:IsPlaying() end

-- Starts to play the sound. This will reset the sound's volume and pitch to their default values. See CSoundPatch:PlayEx
function CSoundPatch:Play() end

-- Same as CSoundPatch:Play but with 2 extra arguments allowing to set volume and pitch directly.
---@param volume number The volume ranges from 0 to 1.
---@param pitch number The pitch can range from 0-255.
function CSoundPatch:PlayEx(volume,pitch) end

-- Sets the DSP (Digital Signal Processor) effect for the sound. Similar to Player:SetDSP but for individual sounds.
---@param dsp number The DSP effect to set. Pick from the [list of DSP's](https://developer.valvesoftware.com/wiki/Dsp_presets)
function CSoundPatch:SetDSP(dsp) end

-- Sets the sound level in decibel.
---@param level number The sound level in decibel. See Enums/SNDLVL
function CSoundPatch:SetSoundLevel(level) end

-- Stops the sound from being played.  This will not work if the entity attached to this sound patch (specified by Global.CreateSound) is invalid.
function CSoundPatch:Stop() end



---@class CTakeDamageInfo
CTakeDamageInfo = CTakeDamageInfo

-- Increases the damage by damageIncrease.
---@param damageIncrease number The damage to add.
function CTakeDamageInfo:AddDamage(damageIncrease) end

-- Returns the ammo type used by the weapon that inflicted the damage.
---@return number
function CTakeDamageInfo:GetAmmoType() end

-- Returns the attacker ( character who originated the attack ), for example a player or an NPC that shot the weapon.
---@return Entity
function CTakeDamageInfo:GetAttacker() end

-- Returns the initial unmodified by skill level ( game.GetSkillLevel ) damage.
---@return number
function CTakeDamageInfo:GetBaseDamage() end

-- Returns the total damage.
---@return number
function CTakeDamageInfo:GetDamage() end

-- Gets the current bonus damage.
---@return number
function CTakeDamageInfo:GetDamageBonus() end

-- Gets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
---@return number
function CTakeDamageInfo:GetDamageCustom() end

-- Returns a vector representing the damage force.  Can be set with CTakeDamageInfo:SetDamageForce.
---@return Vector
function CTakeDamageInfo:GetDamageForce() end

-- Returns the position where the damage was or is going to be applied to.  Can be set using CTakeDamageInfo:SetDamagePosition.
---@return Vector
function CTakeDamageInfo:GetDamagePosition() end

-- Returns a bitflag which indicates the damage type(s) of the damage.  Consider using CTakeDamageInfo:IsDamageType instead. Value returned by this function can contain multiple damage types.
---@return number
function CTakeDamageInfo:GetDamageType() end

-- Returns the inflictor of the damage. This is not necessarily a weapon.  For hitscan weapons this is the weapon.   For projectile weapons this is the projectile.      For a more reliable method of getting the weapon that damaged an entity, use CTakeDamageInfo:GetAttacker with Player:GetActiveWeapon.
---@return Entity
function CTakeDamageInfo:GetInflictor() end

-- Returns the maximum damage. See CTakeDamageInfo:SetMaxDamage
---@return number
function CTakeDamageInfo:GetMaxDamage() end

-- Returns the initial, unmodified position where the damage occured.
---@return Vector
function CTakeDamageInfo:GetReportedPosition() end

-- Returns true if the damage was caused by a bullet.
---@return boolean
function CTakeDamageInfo:IsBulletDamage() end

-- Returns whenever the damageinfo contains the damage type specified.
---@param dmgType number Damage type to test. See Enums/DMG.
---@return boolean
function CTakeDamageInfo:IsDamageType(dmgType) end

-- Returns whenever the damageinfo contains explosion damage.
---@return boolean
function CTakeDamageInfo:IsExplosionDamage() end

-- Returns whenever the damageinfo contains fall damage.
---@return boolean
function CTakeDamageInfo:IsFallDamage() end

-- Scales the damage by the given value.
---@param scale number Value to scale the damage with.
function CTakeDamageInfo:ScaleDamage(scale) end

-- Changes the ammo type used by the weapon that inflicted the damage.
---@param ammoType number Ammo type ID
function CTakeDamageInfo:SetAmmoType(ammoType) end

-- Sets the attacker ( character who originated the attack ) of the damage, for example a player or an NPC.
---@param ent Entity The entity to be set as the attacker.
function CTakeDamageInfo:SetAttacker(ent) end

-- Sets the initial unmodified by skill level ( game.GetSkillLevel ) damage. This function will not update or touch CTakeDamageInfo:GetDamage.
---@param var number baseDamage
function CTakeDamageInfo:SetBaseDamage(var) end

-- Sets the amount of damage.
---@param damage number The value to set the absolute damage to.
function CTakeDamageInfo:SetDamage(damage) end

-- Sets the bonus damage. Bonus damage isn't automatically applied, so this will have no outer effect by default.
---@param damage number The extra damage to be added.
function CTakeDamageInfo:SetDamageBonus(damage) end

-- Sets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
---@param DamageType number Any integer - can be based on your own custom enums.
function CTakeDamageInfo:SetDamageCustom(DamageType) end

-- Sets the directional force of the damage.  This function seems to have no effect on player knockback. To disable knockback entirely, see [EFL_NO_DAMAGE_FORCES](https://wiki.facepunch.com/gmod/Enums/EFL#EFL_NO_DAMAGE_FORCES) or use workaround example below. 
---@param force Vector The vector to set the force to.
function CTakeDamageInfo:SetDamageForce(force) end

-- Sets the position of where the damage gets applied to.
---@param pos Vector The position where the damage will be applied.
function CTakeDamageInfo:SetDamagePosition(pos) end

-- Sets the damage type.
---@param type number The damage type, see Enums/DMG.
function CTakeDamageInfo:SetDamageType(type) end

-- Sets the inflictor of the damage for example a weapon.  For hitscan/bullet weapons this should the weapon.   For projectile ( rockets, etc ) weapons this should be the projectile.
---@param inflictor Entity The new inflictor.
function CTakeDamageInfo:SetInflictor(inflictor) end

-- Sets the maximum damage this damage event can cause.
---@param maxDamage number Maximum damage value.
function CTakeDamageInfo:SetMaxDamage(maxDamage) end

-- Sets the origin of the damage.
---@param pos Vector The location of where the damage is originating
function CTakeDamageInfo:SetReportedPosition(pos) end

-- Subtracts the specified amount from the damage.
---@param damage number Value to subtract.
function CTakeDamageInfo:SubtractDamage(damage) end



---@class CUserCmd
CUserCmd = CUserCmd

-- Adds a single key to the active buttons bitflag. See also CUserCmd:SetButtons.
---@param key number Key to add, see Enums/IN.
function CUserCmd:AddKey(key) end

-- Removes all keys from the command.  If you are looking to affect player movement, you may need to use CUserCmd:ClearMovement instead of clearing the buttons.
function CUserCmd:ClearButtons() end

-- Clears the movement from the command.  See also CUserCmd:SetForwardMove, CUserCmd:SetSideMove and  CUserCmd:SetUpMove.
function CUserCmd:ClearMovement() end

-- Returns an increasing number representing the index of the user cmd.  The value returned is occasionally 0 inside GM:CreateMove and GM:StartCommand. It is advised to check for a non-zero value if you wish to get the correct number.
---@return number
function CUserCmd:CommandNumber() end

-- Returns a bitflag indicating which buttons are pressed.
---@return number
function CUserCmd:GetButtons() end

-- The speed the client wishes to move forward with, negative if the clients wants to move backwards.
---@return number
function CUserCmd:GetForwardMove() end

-- Gets the current impulse from the client, usually 0. [See impulses list](https://developer.valvesoftware.com/wiki/Impulse) and some CUserCmd:SetImpulse.
---@return number
function CUserCmd:GetImpulse() end

-- Returns the scroll delta as whole number.
---@return number
function CUserCmd:GetMouseWheel() end

-- Returns the delta of the angular horizontal mouse movement of the player.
---@return number
function CUserCmd:GetMouseX() end

-- Returns the delta of the angular vertical mouse movement of the player.
---@return number
function CUserCmd:GetMouseY() end

-- The speed the client wishes to move sideways with, positive if it wants to move right, negative if it wants to move left.
---@return number
function CUserCmd:GetSideMove() end

-- The speed the client wishes to move up with, negative if the clients wants to move down.
---@return number
function CUserCmd:GetUpMove() end

-- Gets the direction the player is looking in.
---@return Angle
function CUserCmd:GetViewAngles() end

-- When players are not sending usercommands to the server (often due to lag), their last usercommand will be executed multiple times as a backup. This function returns true if that is happening.  This will never return true clientside.
---@return boolean
function CUserCmd:IsForced() end

-- Returns true if the specified button(s) is pressed.
---@param key number Bitflag representing which button to check, see Enums/IN.
---@return boolean
function CUserCmd:KeyDown(key) end

-- Removes a key bit from the current key bitflag.  For movement you will want to use CUserCmd:SetForwardMove, CUserCmd:SetUpMove and CUserCmd:SetSideMove.
---@param button number Bitflag to be removed from the key bitflag, see Enums/IN.
function CUserCmd:RemoveKey(button) end

-- Forces the associated player to select a weapon. This is used internally in the default HL2 weapon selection HUD.  This may not work immediately if the current command is in prediction. Use input.SelectWeapon to switch the weapon from the client when the next available command can do so.  This is the ideal function to use to create a custom weapon selection HUD, as it allows prediction to run properly for WEAPON:Deploy and GM:PlayerSwitchWeapon
---@param weapon Weapon The weapon entity to select.
function CUserCmd:SelectWeapon(weapon) end

-- Sets the buttons as a bitflag. See also CUserCmd:GetButtons.  If you are looking to affect player movement, you may need to use CUserCmd:SetForwardMove instead of setting the keys.
---@param buttons number Bitflag representing which buttons are "down", see Enums/IN.
function CUserCmd:SetButtons(buttons) end

-- Sets speed the client wishes to move forward with, negative if the clients wants to move backwards.  See also CUserCmd:ClearMovement, CUserCmd:SetSideMove and CUserCmd:SetUpMove.
---@param speed number The new speed to request. The client will not be able to move faster than their set walk/sprint speed.
function CUserCmd:SetForwardMove(speed) end

-- Sets the impulse command to be sent to the server.  Here are a few examples of impulse numbers: - `100` toggles their flashlight - `101` gives the player all Half-Life 2 weapons with `sv_cheats` set to `1` - `200` toggles holstering / restoring the current weapon When holstered, the `EF_NODRAW` flag is set on the active weapon. - `154` toggles noclip  [See full list](https://developer.valvesoftware.com/wiki/Impulse)
---@param impulse number The impulse to send.
function CUserCmd:SetImpulse(impulse) end

-- Sets the scroll delta.
---@param speed number The scroll delta.
function CUserCmd:SetMouseWheel(speed) end

-- Sets the delta of the angular horizontal mouse movement of the player.  See also CUserCmd:SetMouseY.
---@param speed number Angular horizontal move delta.
function CUserCmd:SetMouseX(speed) end

-- Sets the delta of the angular vertical mouse movement of the player.  See also CUserCmd:SetMouseX.
---@param speed number Angular vertical move delta.
function CUserCmd:SetMouseY(speed) end

-- Sets speed the client wishes to move sidewards with, positive to move right, negative to move left.  See also CUserCmd:SetForwardMove and  CUserCmd:SetUpMove.
---@param speed number The new speed to request.
function CUserCmd:SetSideMove(speed) end

-- Sets speed the client wishes to move upwards with, negative to move down.  See also CUserCmd:SetSideMove and  CUserCmd:SetForwardMove. This function does **not** move the client up/down ladders. To force ladder movement, consider CUserCMD:SetButtons and use IN_FORWARD from Enums/IN.
---@param speed number The new speed to request.
function CUserCmd:SetUpMove(speed) end

-- Sets the direction the client wants to move in.  For human players, the pitch (vertical) angle should be clamped to +/- 89° to prevent the player's view from glitching. For fake clients (those created with player.CreateNextBot), this functionally dictates the 'move angles' of the bot. This typically functions separately from the colloquial view angles. This can be utilized by CUserCmd:SetForwardMove and its related functions.
---@param viewAngle Angle New view angles.
function CUserCmd:SetViewAngles(viewAngle) end

-- Returns tick count since joining the server.  This will always return 0 for bots.  Returns 0 clientside during prediction calls. If you are trying to use CUserCmd:Set*() on the client in a movement or command hook, keep doing so till TickCount returns a non-zero number to maintain prediction.
---@return number
function CUserCmd:TickCount() end



---@class Entity
Entity = Entity

-- Activates the entity. This needs to be used on some entities (like constraints) after being spawned.  For some entity types when this function is used after Entity:SetModelScale, the physics object will be recreated with the new scale. [Source-sdk-2013](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/baseanimating.cpp#L321-L327).  Calling this method after Entity:SetModelScale will recreate a new scaled `SOLID_VPHYSICS` PhysObj on scripted entities. This can be a problem if you made a properly scaled PhysObj of another kind (using Entity:PhysicsInitSphere for instance) or if you edited the PhysObj's properties. This is especially the behavior of the Sandbox spawn menu. This crashes the game with scaled vehicles.
function Entity:Activate() end

-- Add a callback function to a specific event. This is used instead of hooks to avoid calling empty functions unnecessarily.  This also allows you to use certain hooks in engine entities (non-scripted entities).  This method does not check if the function has already been added to this object before, so if you add the same callback twice, it will be run twice! Make sure to add your callback only once.
---@param hook string The hook name to hook onto. See Entity Callbacks
---@param func function The function to call
---@return number
function Entity:AddCallback(hook,func) end

-- Applies an engine effect to an entity.  See also Entity:IsEffectActive and  Entity:RemoveEffects.
---@param effect number The effect to apply, see Enums/EF.
function Entity:AddEffects(effect) end

-- Adds engine flags.
---@param flag number Engine flag to add, see Enums/EFL
function Entity:AddEFlags(flag) end

-- Adds flags to the entity.
---@param flag number Flag to add, see Enums/FL
function Entity:AddFlags(flag) end

-- Adds a gesture animation to the entity and plays it.   See Entity:AddGestureSequence and Entity:AddLayeredSequence for functions that takes sequences instead of Enums/ACT.  This function only works on BaseAnimatingOverlay entites!
---@param activity number The activity to play as the gesture. See Enums/ACT.
---@param autokill? boolean
---@return number
function Entity:AddGesture(activity,autokill) end

-- Adds a gesture animation to the entity and plays it.   See Entity:AddGesture for a function that takes Enums/ACT.   See also Entity:AddLayeredSequence.  This function only works on BaseAnimatingOverlay entites!
---@param sequence number The sequence ID to play as the gesture. See Entity:LookupSequence.
---@param autokill? boolean
---@return number
function Entity:AddGestureSequence(sequence,autokill) end

-- Adds a gesture animation to the entity and plays it.   See Entity:AddGestureSequence for a function that doesn't take priority.   See Entity:AddGesture for a function that takes Enums/ACT.  This function only works on BaseAnimatingOverlay entites!
---@param sequence number The sequence ID to play as the gesture. See Entity:LookupSequence.
---@param priority number
---@return number
function Entity:AddLayeredSequence(sequence,priority) end

-- Adds solid flag(s) to the entity.
---@param flags number The flag(s) to apply, see Enums/FSOLID.
function Entity:AddSolidFlags(flags) end

-- Adds a PhysObject to the entity's motion controller so that ENTITY:PhysicsSimulate will be called for given PhysObject as well.  You must first create a motion controller with Entity:StartMotionController.  You can remove added PhysObjects by using Entity:RemoveFromMotionController.  Only works on a scripted Entity of anim type
---@param physObj PhysObj The PhysObj to add to the motion controller.
function Entity:AddToMotionController(physObj) end

-- Returns an angle based on the ones inputted that you can use to align an object.  This function doesn't change the angle of the entity on its own (see example).
---@param from Angle The angle you want to align from
---@param to Angle The angle you want to align to
---@return Angle
function Entity:AlignAngles(from,to) end

-- Spawns a clientside ragdoll for the entity, positioning it in place of the original entity, and makes the entity invisible. It doesn't preserve flex values (face posing) as CSRagdolls don't support flex.  It does not work on players. Use Player:CreateRagdoll instead.  The original entity is not removed, and neither are any ragdolls previously generated with this function.  To make the entity re-appear, run Entity:SetNoDraw( false )
---@return Entity
function Entity:BecomeRagdollOnClient() end

-- Returns true if the entity is being looked at by the local player and is within 256 units of distance.  This function is only available in entities that are based off of sandbox's base_gmodentity.
---@return boolean
function Entity:BeingLookedAtByLocalPlayer() end

--  Dispatches blocked events to this entity's blocked handler. This function is only useful when interacting with entities like func_movelinear.
---@param entity Entity The entity that is blocking us
function Entity:Blocked(entity) end

-- Returns a centered vector of this entity, NPCs use this internally to aim at their targets.  This only works on players and NPCs.
---@param origin Vector The vector of where the the attack comes from.
---@param noisy? boolean Decides if it should return the centered vector with a random offset to it.
---@return Vector
function Entity:BodyTarget(origin,noisy) end

-- Returns whether the entity's bone has the flag or not.
---@param boneID number Bone ID to test flag of.
---@param flag number The flag to test, see Enums/BONE
---@return boolean
function Entity:BoneHasFlag(boneID,flag) end

-- Returns the length between given bone's position and the position of given bone's parent.
---@param boneID number The ID of the bone you want the length of. You may want to get the length of the next bone ( boneID + 1 ) for decent results
---@return number
function Entity:BoneLength(boneID) end

-- Returns the distance between the center of the bounding box and the furthest bounding box corner.
---@return number
function Entity:BoundingRadius() end

-- Calls all NetworkVarNotify functions with the given new value, but doesn't change the real value.
---@param Type string The NetworkVar Type. * `String` * `Bool` * `Float` * `Int` (32-bit signed integer) * `Vector` * `Angle` * `Entity`
---@param index number The NetworkVar index.
---@param new_value any The new value.
function Entity:CallDTVarProxies(Type,index,new_value) end

-- Causes a specified function to be run if the entity is removed by any means. This can later be undone by Entity:RemoveCallOnRemove if you need it to not run.  This hook is called during clientside full updates. See ENTITY:OnRemove#clientsidebehaviourremarks for more information. Using players with this function will provide a gimped entity to the callback.
---@param identifier string Identifier of the function within CallOnRemove
---@param removeFunc function Function to be called on remove
---@param ...? any Optional arguments to pass to removeFunc. Do note that the first argument passed to the function will always be the entity being removed, and the arguments passed on here start after that.
function Entity:CallOnRemove(identifier,removeFunc,...) end

-- Clears all registered events for map i/o outputs of the Entity.
function Entity:ClearAllOutputs() end

-- Resets all pose parameters such as aim_yaw, aim_pitch and rotation.
function Entity:ClearPoseParameters() end

-- Declares that the collision rules of the entity have changed, and subsequent calls for GM:ShouldCollide with this entity may return a different value than they did previously.  This function must **not** be called inside of GM:ShouldCollide. Instead, it must be called in advance when the condition is known to change.  Failure to use this function correctly will result in a crash of the physics engine.
function Entity:CollisionRulesChanged() end

-- Creates bone followers based on the current entity model.  Bone followers are physics objects that follow the visual mesh. This is what is used by `prop_dynamic` for things like big combine doors for vehicles with multiple physics objects which follow the visual mesh of the door when it animates.  You must call Entity:UpdateBoneFollowers every tick for bone followers to update their positions.  This function only works on `anim` type entities.
function Entity:CreateBoneFollowers() end

-- Returns whether the entity was created by map or not.
---@return boolean
function Entity:CreatedByMap() end

-- Creates a clientside particle system attached to the entity. See also Global.CreateParticleSystem  The particle effect must be precached with Global.PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
---@param particle string The particle name to create
---@param attachment number Attachment ID to attach the particle to
---@param options? table A table of tables ( IDs 1 to 64 ) having the following structure: * number attachtype - The particle attach type. See Enums/PATTACH. **Default:** PATTACH_ABSORIGIN * Entity entity - The parent entity? **Default:** NULL * Vector position - The offset position for given control point. **Default:**  nil  This only affects the control points of the particle effects and will do nothing if the effect doesn't use control points.
---@return CNewParticleEffect
function Entity:CreateParticleEffect(particle,attachment,options) end

-- Draws the shadow of an entity.
function Entity:CreateShadow() end

-- Whenever the entity is removed, entityToRemove will be removed also.
---@param entityToRemove Entity The entity to be removed
function Entity:DeleteOnRemove(entityToRemove) end

-- Destroys bone followers created by Entity:CreateBoneFollowers.  This function only works on `anim` type entities.
function Entity:DestroyBoneFollowers() end

-- Removes the shadow for the entity.  The shadow will be recreated as soon as the entity wakes.   Doesn't affect shadows from flashlight/lamps/env_projectedtexture.
function Entity:DestroyShadow() end

-- Disables an active matrix.
---@param matrixType string The name of the matrix type to disable.     The only known matrix type is "RenderMultiply".
function Entity:DisableMatrix(matrixType) end

-- Performs a trace attack towards the entity this function is called on. Visually identical to Entity:TakeDamageInfo.  Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
---@param damageInfo CTakeDamageInfo The damage to apply.
---@param traceRes table Trace result to use to deal damage. See Structures/TraceResult
---@param dir? Vector Direction of the attack.
function Entity:DispatchTraceAttack(damageInfo,traceRes,dir) end

-- This removes the argument entity from an ent's list of entities to 'delete on remove' Also see Entity:DeleteOnRemove
---@param entityToUnremove Entity The entity to be removed from the list of entities to delete
function Entity:DontDeleteOnRemove(entityToUnremove) end

-- Draws the entity or model.  If called inside ENTITY:Draw or ENTITY:DrawTranslucent, it only draws the entity's model itself.  If called outside of those hooks, it will call both of said hooks depending on Entity:GetRenderGroup, drawing the entire entity again.  When drawing an entity more than once per frame in different positions, you should call Entity:SetupBones before each draw; Otherwise, the entity will retain its first drawn position.    Calling this on entities with Enums/EF and Enums/EF applied causes a crash.  Using this with a map model (game.GetWorld():Entity:GetModel()) crashes the game.
---@param flags? number The optional Enums/STUDIO flags, usually taken from ENTITY:Draw and similar hooks.
function Entity:DrawModel(flags) end

-- Sets whether an entity's shadow should be drawn.
---@param shouldDraw boolean True to enable, false to disable shadow drawing.
function Entity:DrawShadow(shouldDraw) end

-- Move an entity down until it collides with something. The entity needs to already have something below it within 256 units.
function Entity:DropToFloor() end

-- You should use Entity:NetworkVar instead  Sets up a self.dt.NAME alias for a Data Table variable.
---@param Type string The type of the DTVar being set up. It can be one of the following: 'Int', 'Float', 'Vector', 'Angle', 'Bool', 'Entity' or 'String'
---@param ID number The ID of the DTVar. Can be between 0 and 3 for strings, 0 and 31 for everything else.
---@param Name string Name by which you will refer to DTVar. It must be a valid variable name. (No spaces!)
function Entity:DTVar(Type,ID,Name) end

-- Plays a sound on an entity. If run clientside, the sound will only be heard locally.  If used on a player or NPC character with the mouth rigged, the character will "lip-sync". This does not work with all sound files.  When using this function with weapons, use the Weapon itself as the entity, not its owner!  This does not respond to Global.SuppressHostEvents.
---@param soundName string The name of the sound to be played.  This should either be a sound script name (sound.Add) or a file path relative to the `sound/` folder. (Make note that it's not sound**s**)  The string cannot have whitespace at the start or end. You can remove this with string.Trim.
---@param soundLevel? number A modifier for the distance this sound will reach, acceptable range is 0 to 511. 100 means no adjustment to the level. See Enums/SNDLVL  Will not work if a [sound script](https://developer.valvesoftware.com/wiki/Soundscripts) is used.
---@param pitchPercent? number The pitch applied to the sound. The acceptable range is from 0 to 255. 100 means the pitch is not changed.
---@param volume? number The volume, from 0 to 1.
---@param channel? number The sound channel, see Enums/CHAN.  Will not work if a [sound script](https://developer.valvesoftware.com/wiki/Soundscripts) is used.
---@param soundFlags? number The flags of the sound, see Enums/SND
---@param dsp? number The DSP preset for this sound. [List of DSP presets](https://developer.valvesoftware.com/wiki/Dsp_presets)
function Entity:EmitSound(soundName,soundLevel,pitchPercent,volume,channel,soundFlags,dsp) end

-- Toggles the constraints of this ragdoll entity on and off.
---@param toggleConstraints boolean Set to true to enable the constraints and false to disable them.  Disabling constraints will delete the constraint entities.
function Entity:EnableConstraints(toggleConstraints) end

-- Flags an entity as using custom lua defined collisions. Fixes entities having spongy player collisions or not hitting traces, such as after Entity:PhysicsFromMesh  Internally identical to `Entity:AddSolidFlags( bit.bor( FSOLID_CUSTOMRAYTEST, FSOLID_CUSTOMBOXTEST ) )`  Do not confuse this function with Entity:SetCustomCollisionCheck, they are not the same.
---@param useCustom boolean True to flag this entity
function Entity:EnableCustomCollisions(useCustom) end

-- Can be used to apply a custom VMatrix to the entity, mostly used for scaling the model by a Vector.  To disable it, use Entity:DisableMatrix.  If your old scales are wrong due to a recent update, use Entity:SetLegacyTransform as a quick fix.  The matrix can also be modified to apply a custom rotation and offset via the VMatrix:SetAngles and VMatrix:SetTranslation functions. This does not scale procedural bones. This disables inverse kinematics of an entity.
---@param matrixType string The name of the matrix type.  The only implemented matrix type is "RenderMultiply".
---@param matrix VMatrix The matrix to apply before drawing the entity.
function Entity:EnableMatrix(matrixType,matrix) end

-- Gets the unique entity index of an entity.  Entity indices are marked as unused after deletion, and can be reused by newly-created entities
---@return number
function Entity:EntIndex() end

-- Extinguishes the entity if it is on fire.  Has no effect if called inside GM:EntityTakeDamage (and the attacker is the flame that's hurting the entity)  See also Entity:Ignite.
function Entity:Extinguish() end

-- Returns the direction a player, npc or ragdoll is looking as a world-oriented angle.  This can return an incorrect value in vehicles (like pods, buggy, ...). **This bug has been fixed in the past but was causing many addons being broken, so the fix has been removed but applied to Player:GetAimVector only**.  This may return local angles in jeeps when used with Player:EnterVehicle. **A workaround is available in the second example.**
---@return Angle
function Entity:EyeAngles() end

-- Returns the position of an Player/NPC's view.
---@return Vector
function Entity:EyePos() end

-- Searches for bodygroup with given name. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param name string The bodygroup name to search for.
---@return number
function Entity:FindBodygroupByName(name) end

-- Returns a transition from the given start and end sequence.  This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures.
---@param currentSequence number The currently playing sequence
---@param goalSequence number The goal sequence.
---@return number
function Entity:FindTransitionSequence(currentSequence,goalSequence) end

-- Fires an entity's input, conforming to the map IO event queue system. You can find inputs for most entities on the [Valve Developer Wiki](https://developer.valvesoftware.com/wiki/Output)  See also Entity:Input for a function that bypasses the event queue and GM:AcceptInput.
---@param input string The name of the input to fire
---@param param? string The value to give to the input, can also be a number or a boolean.
---@param delay? number Delay in seconds before firing
---@param activator? Entity The entity that caused this input (i.e. the player who pushed a button)
---@param caller? Entity The entity that is triggering this input (i.e. the button that was pushed)
function Entity:Fire(input,param,delay,activator,caller) end

-- Fires a bullet.  When used in a  hook such as WEAPON:Think or WEAPON:PrimaryAttack, it will use Player:LagCompensation internally.  Lag compensation will not work if this function is called in a timer, regardless if the timer was made in a  hook.  Due to how FireBullets is set up internally, bullet tracers will always originate from attachment 1.
---@param bulletInfo table The bullet data to be used. See the Structures/Bullet.
---@param suppressHostEvents? boolean Has the effect of encasing the FireBullets call in Global.SuppressHostEvents, only works in multiplayer.
function Entity:FireBullets(bulletInfo,suppressHostEvents) end

-- Makes an entity follow another entity's bone.  Internally this function calls Entity:SetParent( parent, boneid ), Entity:AddEffects( EF_FOLLOWBONE ) and sets an internal flag to always rebuild all bones. If the entity vibrates or stops following the parent, you probably need to run Entity:SetPredictable( true ) clientside. This function will not work if the target bone's parent bone is invalid or if the bone is not used by VERTEX LOD0
---@param parent? Entity The entity to follow the bone of. If unset, removes the FollowBone effect.
---@param boneid number The bone to follow
function Entity:FollowBone(parent,boneid) end

-- Forces the Entity to be dropped, when it is being held by a player's gravitygun or physgun.
function Entity:ForcePlayerDrop() end

-- Advances the cycle of an animated entity.  Animations that loop will automatically reset the cycle so you don't have to - ones that do not will stop animating once you reach the end of their sequence.  Do not call this function multiple times a frame, as it can cause unexpected results, such as animations playing at increased rate, etc.  NextBot:BodyMoveXY calls this internally, so do not call this function before or after NextBot:BodyMoveXY.
function Entity:FrameAdvance() end

-- Returns the entity's velocity.  Actually binds to CBaseEntity::GetLocalVelocity() which retrieves the velocity of the entity due to its movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision.
---@return Vector
function Entity:GetAbsVelocity() end

-- Gets the angles of given entity.  This returns incorrect results for the local player clientside.  This will return the local player's Global.EyeAngles in Category:3D_Rendering_Hooks.  This will return Global.Angle(0,0,0) in Category:3D_Rendering_Hooks while paused in single-player.
---@return Angle
function Entity:GetAngles() end

-- Returns the amount of animations (not to be confused with sequences) the entity's model has. A sequence can consist of multiple animations.  See also Entity:GetAnimInfo
---@return number
function Entity:GetAnimCount() end

-- Returns a table containing the number of frames, flags, name, and FPS of an entity's animation ID.  Animation ID is not the same as sequence ID. See Entity:GetAnimCount
---@param animIndex number The animation ID to look up
---@return table
function Entity:GetAnimInfo(animIndex) end

-- Returns the last time the entity had an animation update. Returns 0 if the entity doesn't animate.
---@return number
function Entity:GetAnimTime() end

-- Returns the amount of time since last animation.  Works only on `CBaseAnimating` entities.
---@return number
function Entity:GetAnimTimeInterval() end

-- Gets the orientation and position of the attachment by its ID, returns nothing if the attachment does not exist.  The update rate of this function is limited by the setting of ENT.AutomaticFrameAdvance for Scripted Entities!  This will return improper values for viewmodels if used in GM:CalcView.
---@param attachmentId number The internal ID of the attachment.
---@return table
function Entity:GetAttachment(attachmentId) end

-- Returns a table containing all attachments of the given entity's model.  Returns an empty table or **nil** in case its model has no attachments.  This can have inconsistent results in single-player.
---@return table
function Entity:GetAttachments() end

-- Returns the entity's base velocity which is their velocity due to forces applied by other entities. This includes entity-on-entity collision or riding a treadmill.
---@return Vector
function Entity:GetBaseVelocity() end

-- Returns the blood color of this entity. This can be set with Entity:SetBloodColor.
---@return number
function Entity:GetBloodColor() end

-- Gets the exact value for specific bodygroup of given entity. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param id number The id of bodygroup to get value of. Starts from 0.
---@return number
function Entity:GetBodygroup(id) end

-- Returns the count of possible values for this bodygroup.  This is **not** the maximum value, since the bodygroups start with 0, not 1. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param bodygroup number The ID of bodygroup to retrieve count of.
---@return number
function Entity:GetBodygroupCount(bodygroup) end

-- Gets the name of specific bodygroup for given entity. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@param id number The id of bodygroup to get the name of.
---@return string
function Entity:GetBodygroupName(id) end

-- Returns a list of all body groups of the entity. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return body groups form view model.
---@return table
function Entity:GetBodyGroups() end

-- Returns the contents of the specified bone.
---@param bone number The bone id, starting at index 0. See Entity:LookupBone.
---@return number
function Entity:GetBoneContents(bone) end

-- Returns the value of the bone controller with the specified ID.  This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
---@param boneID number ID of the bone controller. Goes from 0 to 3.
---@return number
function Entity:GetBoneController(boneID) end

-- Returns the amount of bones in the entity.  Will return -1 for Global.ClientsideModel or undrawn entities until Entity:SetupBones is called on the entity.
---@return number
function Entity:GetBoneCount() end

-- Returns the transformation matrix of a given bone on the entity's model. The matrix contains the transformation used to position the bone in the world. It is not relative to the parent bone.  This is equivalent to constructing a VMatrix using Entity:GetBonePosition.  This can return the server's matrix during server lag.  This can return garbage serverside or a 0,0,0 fourth column (represents position) for v49 models.
---@param boneID number The bone ID to retrieve matrix of, starting at index 0. * Bones clientside and serverside will differ
---@return VMatrix
function Entity:GetBoneMatrix(boneID) end

-- Returns name of given bone id.
---@param index number ID of bone to lookup name of, starting at index 0.
---@return string
function Entity:GetBoneName(index) end

-- Returns parent bone of given bone.  Will return -1 for Global.ClientsideModel until Entity:SetupBones is called on the entity.
---@param bone number The bode ID of the bone to get parent of, starting at index 0.
---@return number
function Entity:GetBoneParent(bone) end

-- Returns the position and angle of the given attachment, relative to the world.  This function can return entity's `GetPos()` instead if the entity doesn't have it's bone cache set up.  To ensure the bone position is correct use this: ```lua local pos = ent:GetBonePosition(0) if pos == ent:GetPos() then pos = ent:GetBoneMatrix(0):GetTranslation() end ```   This function returns the bone position from the last tick, so if your framerate is higher than the server's tickrate it may appear to lag behind if used on a fast moving entity. You can fix this by using the bone's matrix instead: ```lua local matrix = entity:GetBoneMatrix(0) local pos = matrix:GetTranslation() local ang = matrix:GetAngles() ```   This can return the server's position during server lag.  This can return garbage serverside or Global.Vector(0,0,0) for v49 models.  This can return garbage if a trace passed through the target bone during bone matrix access.
---@param boneIndex number The bone index of the bone to get the position of, starting at index 0. See Entity:LookupBone.
---@return Vector
---@return Angle
function Entity:GetBonePosition(boneIndex) end

-- Returns the surface property of the specified bone.
---@param bone number The bone id, starting at index 0. See Entity:LookupBone.
---@return string
function Entity:GetBoneSurfaceProp(bone) end

-- Returns info about given plane of non-nodraw brush model surfaces of the entity's model. Works on worldspawn as well.  This only works on entities with brush models.
---@param id number The index of the plane to get info of. Starts from 0.
---@return Vector
---@return Vector
---@return number
function Entity:GetBrushPlane(id) end

-- Returns the amount of planes of non-nodraw brush model surfaces of the entity's model.
---@return number
function Entity:GetBrushPlaneCount() end

-- Returns a table of brushes surfaces for brush model entities.
---@return table
function Entity:GetBrushSurfaces() end

-- Returns the specified hook callbacks for this entity added with Entity:AddCallback  The callbacks can then be removed with Entity:RemoveCallback.
---@param hook string The hook to retrieve the callbacks from, see Entity Callbacks for the possible hooks.
---@return table
function Entity:GetCallbacks(hook) end

-- Returns ids of child bones of given bone.
---@param boneid number Bone id to lookup children of
---@return table
function Entity:GetChildBones(boneid) end

-- Gets the children of the entity - that is, every entity whose move parent is this entity.  This function returns Entity:SetMoveParent children, **NOT** Entity:SetParent!  Entity:SetParent however also calls Entity:SetMoveParent.    This means that some entities in the returned list might have a NULL Entity:GetParent.  This also means that using this function on players will return their weapons on the client but not the server.
---@return table
function Entity:GetChildren() end

-- Returns the classname of a entity. This is often the name of the Lua file or folder containing the files for the entity
---@return string
function Entity:GetClass() end

-- Returns an entity's collision bounding box. In most cases, this will return the same bounding box as Entity:GetModelBounds unless the entity does not have a physics mesh or it has a PhysObj different from the default.  This can be out-of-sync between the client and server for weapons.
---@return Vector
---@return Vector
function Entity:GetCollisionBounds() end

-- Returns the entity's collision group
---@return number
function Entity:GetCollisionGroup() end

-- Returns the color the entity is set to.  The returned color will not have the color metatable.
---@return table
function Entity:GetColor() end

-- Returns the color the entity is set to. This functions will return Colors set with Entity:GetColor
---@return number
---@return number
---@return number
---@return number
function Entity:GetColor4Part() end

-- Returns the two entities involved in a constraint ent, or nil if the entity is not a constraint.
---@return Entity
---@return Entity
function Entity:GetConstrainedEntities() end

-- Returns the two entities physobjects involved in a constraint ent, or no value if the entity is not a constraint.
---@return PhysObj
---@return PhysObj
function Entity:GetConstrainedPhysObjects() end

-- Returns entity's creation ID. Unlike Entity:EntIndex or  Entity:MapCreationID, it will always increase and old values won't be reused.
---@return number
function Entity:GetCreationID() end

-- Returns the time the entity was created on, relative to Global.CurTime.
---@return number
function Entity:GetCreationTime() end

-- Gets the creator of the SENT.
---@return Player
function Entity:GetCreator() end

-- Returns whether this entity uses custom collision check set by Entity:SetCustomCollisionCheck.
---@return boolean
function Entity:GetCustomCollisionCheck() end

-- Returns the frame of the currently played sequence. This will be a number between 0 and 1 as a representation of sequence progress.
---@return number
function Entity:GetCycle() end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get an angle stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return Angle
function Entity:GetDTAngle(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get a boolean stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return boolean
function Entity:GetDTBool(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Returns an entity stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return Entity
function Entity:GetDTEntity(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get a float stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return number
function Entity:GetDTFloat(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get an integer stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return number
function Entity:GetDTInt(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get a string stored in the datatable of the entity.
---@param key number Goes from 0 to 3. Specifies what key to grab from datatable.
---@return string
function Entity:GetDTString(key) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Get a vector stored in the datatable of the entity.
---@param key number Goes from 0 to 31. Specifies what key to grab from datatable.
---@return Vector
function Entity:GetDTVector(key) end

-- Returns internal data about editable Entity:NetworkVars.  This is used internally by DEntityProperties and Editable Entities system.  This function will only work on entities which had Entity:InstallDataTable called on them, which is done automatically for players and all Scripted Entities 
---@return table
function Entity:GetEditingData() end

-- Returns a bit flag of all engine effect flags of the entity.
---@return number
function Entity:GetEffects() end

-- Returns a bit flag of all engine flags of the entity.
---@return number
function Entity:GetEFlags() end

-- Returns the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
---@return number
function Entity:GetElasticity() end

-- Returns all flags of given entity.
---@return number
function Entity:GetFlags() end

-- Returns acceptable value range for the flex.
---@param flex number The ID of the flex to look up bounds of
---@return number
---@return number
function Entity:GetFlexBounds(flex) end

-- Returns the ID of the flex based on given name. This function will search by beginning of a name.
---@param name string The name of the flex to get the ID of. Case sensitive.
---@return number
function Entity:GetFlexIDByName(name) end

-- Returns flex name.
---@param id number The flex id to look up name of
---@return string
function Entity:GetFlexName(id) end

-- Returns the number of flexes this entity has.
---@return number
function Entity:GetFlexNum() end

-- Returns the flex scale of the entity.
---@return number
function Entity:GetFlexScale() end

-- Returns current weight ( value ) of the flex.
---@param flex number The ID of the flex to get weight of
---@return number
function Entity:GetFlexWeight(flex) end

-- Returns the forward vector of the entity, as a normalized direction vector
---@return Vector
function Entity:GetForward() end

-- Returns how much friction an entity has. Entities default to 1 (100%) and can be higher or even negative.
---@return number
function Entity:GetFriction() end

-- Gets the gravity multiplier of the entity.
---@return number
function Entity:GetGravity() end

-- Returns the object the entity is standing on.
---@return Entity
function Entity:GetGroundEntity() end

-- Returns the entity's ground speed velocity, which is based on the entity's walk/run speed and/or the ground speed of their sequence ( Entity:GetSequenceGroundSpeed ). Will return an empty Vector if the entity isn't moving on the ground.
---@return Vector
function Entity:GetGroundSpeedVelocity() end

-- Gets the bone the hit box is attached to.
---@param hitbox number The number of the hit box.
---@param hboxset number The number of the hit box set. This should be 0 in most cases.  Numbering for these sets start from 0. The total amount of sets can be found with Entity:GetHitBoxSetCount.
---@return number
function Entity:GetHitBoxBone(hitbox,hboxset) end

-- Gets the bounds (min and max corners) of a hit box.
---@param hitbox number The number of the hit box.
---@param set number The hitbox set of the hit box. This should be 0 in most cases.
---@return Vector
---@return Vector
function Entity:GetHitBoxBounds(hitbox,set) end

-- Gets how many hit boxes are in a given hit box group.
---@param group number The number of the hit box group.
---@return number
function Entity:GetHitBoxCount(group) end

-- You should use Entity:GetHitboxSetCount instead.  Returns the number of hit box sets that an entity has. Functionally identical to Entity:GetHitboxSetCount
---@return number
function Entity:GetHitBoxGroupCount() end

-- Gets the hit group of a given hitbox in a given hitbox set.
---@param hitbox number The number of the hit box.
---@param hitboxset number The number of the hit box set. This should be 0 in most cases.  Numbering for these sets start from 0. The total group count can be found with Entity:GetHitBoxSetCount.
---@return number
function Entity:GetHitBoxHitGroup(hitbox,hitboxset) end

-- Returns entity's current hit box set
---@return number
---@return string
function Entity:GetHitboxSet() end

-- Returns the amount of hitbox sets in the entity.
---@return number
function Entity:GetHitboxSetCount() end

-- An interface for accessing internal key values on entities.  See Entity:GetSaveTable for a more detailed explanation. See Entity:SetSaveValue for the opposite of this function.
---@param variableName string Name of variable corresponding to an entity save value.
---@return any
function Entity:GetInternalVariable(variableName) end

-- Returns a table containing all key values the entity has.  Single key values can usually be retrieved with Entity:GetInternalVariable.  This only includes engine defined key values. For custom key values, use GM:EntityKeyValue or ENTITY:KeyValue to capture and store them.  Here's a list of keyvalues that will not appear in this list, as they are not stored/defined as actual keyvalues internally: * rendercolor - Entity:GetColor (Only RGB) * rendercolor32 - Entity:GetColor (RGBA) * renderamt - Entity:GetColor (Alpha) * disableshadows - EF_NOSHADOW * mins - Entity:GetCollisionBounds * maxs - Entity:GetCollisionBounds * disablereceiveshadows - EF_NORECEIVESHADOW * nodamageforces - EFL_NO_DAMAGE_FORCES * angle - Entity:GetAngles * angles - Entity:GetAngles * origin - Entity:GetPos * targetname - Entity:GetName
---@return table
function Entity:GetKeyValues() end

-- Returns the animation cycle/frame for given layer.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@return number
function Entity:GetLayerCycle(layerID) end

-- Returns the duration of given layer.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@return number
function Entity:GetLayerDuration(layerID) end

-- Returns the layer playback rate. See also Entity:GetLayerDuration. This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@return number
function Entity:GetLayerPlaybackRate(layerID) end

-- Returns the sequence id of given layer.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID.
---@return number
function Entity:GetLayerSequence(layerID) end

-- Returns the current weight of the layer. See Entity:SetLayerWeight for more information.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@return number
function Entity:GetLayerWeight(layerID) end

-- Returns the entity that is being used as the light origin position for this entity.
---@return Entity
function Entity:GetLightingOriginEntity() end

-- Returns the rotation of the entity relative to its parent entity.
---@return Angle
function Entity:GetLocalAngles() end

-- Returns the non-VPhysics angular velocity of the entity relative to its parent entity.
---@return Angle
function Entity:GetLocalAngularVelocity() end

-- Returns entity's position relative to it's parent.
---@return Vector
function Entity:GetLocalPos() end

-- Gets the entity's angle manipulation of the given bone. This is relative to the default angle, so the angle is zero when unmodified.
---@param boneID number The bone's ID
---@return Angle
function Entity:GetManipulateBoneAngles(boneID) end

-- Returns the jiggle amount of the entity's bone.  See Entity:ManipulateBoneJiggle for more info.
---@param boneID number The bone ID
---@return number
function Entity:GetManipulateBoneJiggle(boneID) end

-- Gets the entity's position manipulation of the given bone. This is relative to the default position, so it is zero when unmodified.
---@param boneId number The bone's ID
---@return Vector
function Entity:GetManipulateBonePosition(boneId) end

-- Gets the entity's scale manipulation of the given bone. Normal scale is Vector( 1, 1, 1 )
---@param boneID number The bone's ID
---@return Vector
function Entity:GetManipulateBoneScale(boneID) end

-- Returns the material override for this entity.  Returns an empty string if no material override exists. Use Entity:GetMaterials to list it's default materials.  The server's value takes priority on the client.
---@return string
function Entity:GetMaterial() end

-- Returns all materials of the entity's model.  This function is unaffected by Entity:SetSubMaterial as it returns the original materials.  The table returned by this function will not contain materials if they are missing from the disk/repository. This means that if you are attempting to find the ID of a material to replace with Entity:SetSubMaterial and there are missing materials on the model, all subsequent materials will be offset in the table, meaning that the ID you are trying to get will be incorrect.
---@return table
function Entity:GetMaterials() end

-- Returns the surface material of this entity.
---@return number
function Entity:GetMaterialType() end

-- Returns the max health that the entity was given. It can be set via Entity:SetMaxHealth.
---@return number
function Entity:GetMaxHealth() end

-- Gets the model of given entity.  This does not necessarily return the model's path, as is the case for brush and virtual models. This is intentional behaviour, however, there is currently no way to retrieve the actual file path.
---@return string
function Entity:GetModel() end

-- Returns the entity's model bounds, not scaled by Entity:SetModelScale.  These bounds are affected by all the animations the model has at compile time, if they go outside of the models' render bounds at any point. See Entity:GetModelRenderBounds for just the render bounds of the model.  This is different than the collision bounds/hull, which are set via Entity:SetCollisionBounds.
---@return Vector
---@return Vector
function Entity:GetModelBounds() end

-- Returns the contents of the entity's current model.
---@return number
function Entity:GetModelContents() end

-- Gets the physics bone count of the entity's model. This is only applicable to `anim` type Scripted Entities with ragdoll models.
---@return number
function Entity:GetModelPhysBoneCount() end

-- Gets the models radius.
---@return number
function Entity:GetModelRadius() end

-- Returns the entity's model render bounds. Unlike Entity:GetModelBounds, bounds returning by this function will not be affected by animations (at compile time).
---@return Vector
---@return Vector
function Entity:GetModelRenderBounds() end

-- Gets the selected entity's model scale.
---@return number
function Entity:GetModelScale() end

-- Returns the amount a momentary_rot_button entity is turned based on the given angle. 0 meaning completely turned closed, 1 meaning completely turned open.  This only works on momentary_rot_button entities.
---@param turnAngle Angle The angle of rotation to compare - usually should be Entity:GetAngles.
---@return number
function Entity:GetMomentaryRotButtonPos(turnAngle) end

-- Returns the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
---@return number
function Entity:GetMoveCollide() end

-- Returns the movement parent of this entity.  See Entity:SetMoveParent for more info.
---@return Entity
function Entity:GetMoveParent() end

-- Returns the entity's movetype
---@return number
function Entity:GetMoveType() end

-- Returns the map/hammer targetname of this entity.
---@return string
function Entity:GetName() end

-- Gets networked angles for entity.
---@return Angle
function Entity:GetNetworkAngles() end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNetworked2Angle. You should be using Entity:GetNW2Angle instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Angle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNetworked2Bool. You should be using Entity:GetNW2Bool instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Bool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNetworked2Entity. You should be using Entity:GetNW2Entity instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Entity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworked2Float. You should be using Entity:GetNW2Float instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Float(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNetworked2Int. You should be using Entity:GetNW2Int instead. The integer has a 32 bit limit. Use Entity:SetNWInt and Entity:GetNWInt instead
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value (If it isn't set).
---@return any
function Entity:GetNetworked2Int(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNetworked2String. You should be using Entity:GetNW2String instead.
---@param key string The key that is associated with the value
---@param fallback any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2String(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNetworked2Var. You should be using Entity:GetNW2Var instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Var(key,fallback) end

-- Returns callback function for given NWVar of this entity.
---@param key any The key of the NWVar to get callback of.
---@return function
function Entity:GetNetworked2VarProxy(key) end

-- Returns all the networked2 variables in an entity. You should be using Entity:GetNW2VarTable instead.
---@return table
function Entity:GetNetworked2VarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNetworked2Vector. You should be using Entity:GetNW2Vector instead.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworked2Vector(key,fallback) end

-- You should use Entity:GetNWAngle instead.  Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNetworkedAngle.
---@param key string The key that is associated with the value
---@param fallback? Angle The value to return if we failed to retrieve the value. ( If it isn't set )
---@return Angle
function Entity:GetNetworkedAngle(key,fallback) end

-- You should use Entity:GetNWBool instead.  Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNetworkedBool.
---@param key string The key that is associated with the value
---@param fallback? boolean The value to return if we failed to retrieve the value. ( If it isn't set )
---@return boolean
function Entity:GetNetworkedBool(key,fallback) end

-- You should use Entity:GetNWEntity instead.  Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedEntity.
---@param key string The key that is associated with the value
---@param fallback? Entity The value to return if we failed to retrieve the value. ( If it isn't set )
---@return Entity
function Entity:GetNetworkedEntity(key,fallback) end

-- You should use Entity:GetNWFloat instead.  Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedFloat.  Seems to be the same as Entity:GetNetworkedInt.
---@param key string The key that is associated with the value
---@param fallback? number The value to return if we failed to retrieve the value. ( If it isn't set )
---@return number
function Entity:GetNetworkedFloat(key,fallback) end

-- You should use Entity:GetNWInt instead.  Retrieves a networked integer value at specified index on the entity that is set by Entity:SetNetworkedInt.
---@param key string The key that is associated with the value
---@param fallback? number The value to return if we failed to retrieve the value. ( If it isn't set )
---@return number
function Entity:GetNetworkedInt(key,fallback) end

-- You should use Entity:GetNWString instead.  Retrieves a networked string value at specified index on the entity that is set by Entity:SetNetworkedString.
---@param key string The key that is associated with the value
---@param fallback string The value to return if we failed to retrieve the value. ( If it isn't set )
---@return string
function Entity:GetNetworkedString(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNetworkedVar. 
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNetworkedVar(key,fallback) end

-- This function was superseded by Entity:GetNetworked2VarProxy. This page still exists an archive in case anybody ever stumbles across old code and needs to know what it is Returns callback function for given NWVar of this entity.
---@param name string The name of the NWVar to get callback of.
---@return function
function Entity:GetNetworkedVarProxy(name) end

-- You should be using Entity:GetNWVarTable instead.  Returns all the networked variables in an entity.
---@return table
function Entity:GetNetworkedVarTable() end

-- You should use Entity:GetNWVector instead.  Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNetworkedVector.
---@param key string The key that is associated with the value
---@param fallback? Vector The value to return if we failed to retrieve the value. ( If it isn't set )
---@return Vector
function Entity:GetNetworkedVector(key,fallback) end

-- Gets networked origin for entity.
---@return Vector
function Entity:GetNetworkOrigin() end

-- Returns all network vars created by Entity:NetworkVar and Entity:NetworkVarElement and their current values.  This is used internally by the duplicator.  For NWVars see Entity:GetNWVarTable.  This function will only work on entities which had Entity:InstallDataTable called on them, which is done automatically for players and all Scripted Entities
---@return table
function Entity:GetNetworkVars() end

-- Returns if the entity's rendering and transmitting has been disabled.  This is equivalent to calling Entity:IsEffectActive( EF_NODRAW )
---@return boolean
function Entity:GetNoDraw() end

-- Returns the body group count of the entity. If called for Weapon (after Initialize hook) with different body groups on world model and view model will return value form view model.
---@return number
function Entity:GetNumBodyGroups() end

-- Returns the number of pose parameters this entity has.
---@return number
function Entity:GetNumPoseParameters() end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNW2Angle.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Angle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNW2Bool.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Bool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNW2Entity.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Entity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNW2Float.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Float(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNW2Int. The integer has a 32 bit limit. Use Entity:SetNWInt and Entity:GetNWInt instead
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value (If it isn't set).
---@return any
function Entity:GetNW2Int(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNW2String.
---@param key string The key that is associated with the value
---@param fallback any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2String(key,fallback) end

-- Retrieves a networked value at specified index on the entity that is set by Entity:SetNW2Var.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Var(key,fallback) end

-- Returns callback function for given NWVar of this entity. Alias of Entity:GetNetworked2VarProxy
---@param key any The key of the NWVar to get callback of.
---@return function
function Entity:GetNW2VarProxy(key) end

-- Returns all the NW2 variables in an entity. This function will return keys with empty tables if the NW2Var is nil.
---@return table
function Entity:GetNW2VarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNW2Vector.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNW2Vector(key,fallback) end

-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNWAngle.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWAngle(key,fallback) end

-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNWBool.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWBool(key,fallback) end

-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNWEntity.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWEntity(key,fallback) end

-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNWFloat.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWFloat(key,fallback) end

-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNWInt.  This function will not round decimal values as it actually networks a float internally.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value (If it isn't set).
---@return any
function Entity:GetNWInt(key,fallback) end

-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNWString.
---@param key string The key that is associated with the value
---@param fallback any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWString(key,fallback) end

-- Returns callback function for given NWVar of this entity. This function was superseded by Entity:GetNW2VarProxy. This page still exists an archive in case anybody ever stumbles across old code and needs to know what it is
---@param key any The key of the NWVar to get callback of.
---@return function
function Entity:GetNWVarProxy(key) end

-- Returns all the networked variables in an entity.
---@return table
function Entity:GetNWVarTable() end

-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNWVector.
---@param key string The key that is associated with the value
---@param fallback? any The value to return if we failed to retrieve the value. (If it isn't set)
---@return any
function Entity:GetNWVector(key,fallback) end

-- Returns the owner entity of this entity. See Entity:SetOwner for more info.  This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.
---@return Entity
function Entity:GetOwner() end

-- Returns the parent entity of this entity.
---@return Entity
function Entity:GetParent() end

-- Returns the attachment index of the entity's parent. Returns 0 if the entity is not parented to a specific attachment or if it isn't parented at all.  This is set by second argument of Entity:SetParent or the **SetParentAttachment** input.
---@return number
function Entity:GetParentAttachment() end

-- If the entity is parented to an entity that has a model with multiple physics objects (like a ragdoll), this is used to retrieve what physics object number the entity is parented to on it's parent.
---@return number
function Entity:GetParentPhysNum() end

-- Returns the position and angle of the entity's move parent as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.
---@return VMatrix
function Entity:GetParentWorldTransformMatrix() end

-- Returns whether the entity is persistent or not.  See Entity:SetPersistent for more information on persistence.
---@return boolean
function Entity:GetPersistent() end

-- Returns player who is claiming kills of physics damage the entity deals.
---@param timeLimit? number The time to check if the entity was still a proper physics attacker.  Some entities such as the Combine Ball disregard the time limit and always return the physics attacker.
---@return Player
function Entity:GetPhysicsAttacker(timeLimit) end

-- Returns the entity's physics object, if the entity has physics.  Entities don't have clientside physics objects by default, so this will return `[NULL PHYSOBJ]` on the client in most cases.
---@return PhysObj
function Entity:GetPhysicsObject() end

-- Returns the number of physics objects an entity has (usually 1 for non-ragdolls)
---@return number
function Entity:GetPhysicsObjectCount() end

-- Returns a specific physics object from an entity with multiple PhysObjects (like ragdolls)  See also Entity:TranslateBoneToPhysBone.
---@param physNum number The number corresponding to the PhysObj to grab. Starts at 0.
---@return PhysObj
function Entity:GetPhysicsObjectNum(physNum) end

-- Returns the playback rate of the main sequence on this entity, with 1.0 being the default speed.
---@return number
function Entity:GetPlaybackRate() end

-- Gets the position of entity in world.
---@return Vector
function Entity:GetPos() end

-- Returns the pose parameter value
---@param name string Pose parameter name to look up
---@return number
function Entity:GetPoseParameter(name) end

-- Returns name of given pose parameter
---@param id number Id of the pose paremeter
---@return string
function Entity:GetPoseParameterName(id) end

-- Returns pose parameter range
---@param id number Pose parameter ID to look up
---@return number
---@return number
function Entity:GetPoseParameterRange(id) end

-- Returns whether this entity is predictable or not.  See Entity:SetPredictable for more information
---@return boolean
function Entity:GetPredictable() end

-- Returns the entity which the ragdoll came from. The opposite of Player:GetRagdollEntity.
---@return Entity
function Entity:GetRagdollOwner() end

-- Returns the entity's render angles, set by Entity:SetRenderAngles in a drawing hook.
---@return Angle
function Entity:GetRenderAngles() end

-- Returns render bounds of the entity as local vectors. Can be overridden by Entity:SetRenderBounds.  If the render bounds are not inside players view, the entity will not be drawn!
---@return Vector
---@return Vector
function Entity:GetRenderBounds() end

-- Returns current render FX of the entity.
---@return number
function Entity:GetRenderFX() end

-- Returns the render group of the entity.
---@return number
function Entity:GetRenderGroup() end

-- Returns the render mode of the entity.
---@return number
function Entity:GetRenderMode() end

-- Returns the entity's render origin, set by Entity:SetRenderOrigin in a drawing hook.
---@return Vector
function Entity:GetRenderOrigin() end

-- Returns the rightward vector of the entity, as a normalized direction vector
---@return Vector
function Entity:GetRight() end

-- Returns axis-aligned bounding box (AABB) of a orientated bounding box (OBB) based on entity's rotation.
---@param min Vector Minimum extent of an OBB in local coordinates.
---@param max Vector Maximum extent of an OBB in local coordinates.
---@return Vector
---@return Vector
function Entity:GetRotatedAABB(min,max) end

-- Returns a table of save values for an entity.  These tables are not the same between the client and the server, and different entities may have different fields.  You can get the list different fields an entity has by looking at it's source code (the 2013 SDK can be found [online](https://github.com/ValveSoftware/source-sdk-2013)). Accessible fields are defined by each `DEFINE_FIELD` and `DEFINE_KEYFIELD` inside the `DATADESC` block.  Take the headcrab, for example:  ``` BEGIN_DATADESC( CBaseHeadcrab ) // m_nGibCount - don't save DEFINE_FIELD( m_bHidden, FIELD_BOOLEAN ), DEFINE_FIELD( m_flTimeDrown, FIELD_TIME ), DEFINE_FIELD( m_bCommittedToJump, FIELD_BOOLEAN ), DEFINE_FIELD( m_vecCommittedJumpPos, FIELD_POSITION_VECTOR ), DEFINE_FIELD( m_flNextNPCThink, FIELD_TIME ), DEFINE_FIELD( m_flIgnoreWorldCollisionTime, FIELD_TIME ),  DEFINE_KEYFIELD( m_bStartBurrowed, FIELD_BOOLEAN, "startburrowed" ), DEFINE_FIELD( m_bBurrowed, FIELD_BOOLEAN ), DEFINE_FIELD( m_flBurrowTime, FIELD_TIME ), DEFINE_FIELD( m_nContext, FIELD_INTEGER ), DEFINE_FIELD( m_bCrawlFromCanister, FIELD_BOOLEAN ), DEFINE_FIELD( m_bMidJump, FIELD_BOOLEAN ), DEFINE_FIELD( m_nJumpFromCanisterDir, FIELD_INTEGER ), DEFINE_FIELD( m_bHangingFromCeiling, FIELD_BOOLEAN ), DEFINE_FIELD( m_flIlluminatedTime, FIELD_TIME ),  DEFINE_INPUTFUNC( FIELD_VOID, "Burrow", InputBurrow ), DEFINE_INPUTFUNC( FIELD_VOID, "BurrowImmediate", InputBurrowImmediate ), DEFINE_INPUTFUNC( FIELD_VOID, "Unburrow", InputUnburrow ), DEFINE_INPUTFUNC( FIELD_VOID, "StartHangingFromCeiling", InputStartHangingFromCeiling ), DEFINE_INPUTFUNC( FIELD_VOID, "DropFromCeiling", InputDropFromCeiling ),  // Function Pointers DEFINE_THINKFUNC( EliminateRollAndPitch ), DEFINE_THINKFUNC( ThrowThink ), DEFINE_ENTITYFUNC( LeapTouch ), END_DATADESC() ```  * For each **DEFINE_FIELD**, the save table will have a key with name of **first** argument. * For each **DEFINE_KEYFIELD**, the save table will have a key with name of the **third** argument.  See Entity:GetInternalVariable for only retrieving one key of the save table.
---@param showAll boolean If set, shows all variables, not just the ones for save.
---@return table
function Entity:GetSaveTable(showAll) end

-- Return the index of the model sequence that is currently active for the entity.
---@return number
function Entity:GetSequence() end

-- Return activity id out of sequence id. Opposite of Entity:SelectWeightedSequence.
---@param seq number The sequence ID
---@return number
function Entity:GetSequenceActivity(seq) end

-- Returns the activity name for the given sequence id.
---@param sequenceId number The sequence id.
---@return string
function Entity:GetSequenceActivityName(sequenceId) end

-- Returns the amount of sequences ( animations ) the entity's model has.
---@return number
function Entity:GetSequenceCount() end

-- Returns the ground speed of the entity's sequence.
---@param sequenceId number The sequence ID.
---@return number
function Entity:GetSequenceGroundSpeed(sequenceId) end

-- Returns a table of information about an entity's sequence.
---@param sequenceId number The sequence id of the entity.
---@return table
function Entity:GetSequenceInfo(sequenceId) end

-- Returns a list of all sequences ( animations ) the model has.
---@return table
function Entity:GetSequenceList() end

-- Returns an entity's sequence move distance (the change in position over the course of the entire sequence).  See Entity:GetSequenceMovement for a similar function with more options.
---@param sequenceId number The sequence index.
---@return number
function Entity:GetSequenceMoveDist(sequenceId) end

-- Returns the delta movement and angles of a sequence of the entity's model.
---@param sequenceId number The sequence index. See Entity:LookupSequence.
---@param startCycle? number The sequence start cycle. 0 is the start of the animation, 1 is the end.
---@param endCyclnde? number The sequence end cycle. 0 is the start of the animation, 1 is the end. Values like 2, etc are allowed.
---@return boolean
---@return Vector
---@return Angle
function Entity:GetSequenceMovement(sequenceId,startCycle,endCyclnde) end

-- Returns the change in heading direction in between the start and the end of the sequence.
---@param seq number The sequence index. See Entity:LookupSequence.
---@return number
function Entity:GetSequenceMoveYaw(seq) end

-- Return the name of the sequence for the index provided. Refer to Entity:GetSequence to find the current active sequence on this entity.  See Entity:LookupSequence for a function that does the opposite.
---@param index number The index of the sequence to look up.
---@return string
function Entity:GetSequenceName(index) end

-- Returns an entity's sequence velocity at given animation frame.
---@param sequenceId number The sequence index.
---@param cycle number The point in animation, from `0` to `1`.
---@return Vector
function Entity:GetSequenceVelocity(sequenceId,cycle) end

-- Checks if the entity plays a sound when picked up by a player.  This will return nil if Entity:SetShouldPlayPickupSound has not been called.
---@return boolean
function Entity:GetShouldPlayPickupSound() end

-- Returns if entity should create a server ragdoll on death or a client one.
---@return boolean
function Entity:GetShouldServerRagdoll() end

-- Returns the skin index of the current skin.
---@return number
function Entity:GetSkin() end

-- Returns solid type of an entity.
---@return number
function Entity:GetSolid() end

-- Returns solid flag(s) of an entity.
---@return number
function Entity:GetSolidFlags() end

-- Returns if we should show a spawn effect on spawn on this entity.
---@return boolean
function Entity:GetSpawnEffect() end

-- Returns the bitwise spawn flags used by the entity.
---@return number
function Entity:GetSpawnFlags() end

-- Returns the material override for the given index.  Returns "" if no material override exists. Use Entity:GetMaterials to list it's default materials.  The server's value takes priority on the client.
---@param index number The index of the sub material. Acceptable values are from 0 to 31.
---@return string
function Entity:GetSubMaterial(index) end

-- Returns a list of models included into the entity's model in the .qc file.
---@return table
function Entity:GetSubModels() end

-- Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box for hitbox detection. In most cases, this will return the same bounding box as Entity:WorldSpaceAABB unless it was changed by Entity:SetSurroundingBounds or Entity:SetSurroundingBoundsType.
---@return Vector
---@return Vector
function Entity:GetSurroundingBounds() end

-- Returns the table that contains all values saved within the entity.
---@return table
function Entity:GetTable() end

-- Returns the last trace used in the collision callbacks such as ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch.  This returns the last collision trace used, regardless of the entity that caused it. As such, it's only reliable when used in the hooks mentioned above
---@return table
function Entity:GetTouchTrace() end

-- Returns true if the TransmitWithParent flag is set or not.
---@return boolean
function Entity:GetTransmitWithParent() end

-- Returns if the entity is unfreezable, meaning it can't be frozen with the physgun. By default props are freezable, so this function will typically return false.  This will return nil if Entity:SetUnFreezable has not been called.
---@return boolean
function Entity:GetUnFreezable() end

-- Returns the upward vector of the entity, as a normalized direction vector
---@return Vector
function Entity:GetUp() end

-- Retrieves a value from entity's Entity:GetTable. Set by Entity:SetVar.
---@param key any Key of the value to retrieve
---@param default? any A default value to fallback to if we couldn't retrieve the value from entity
---@return any
function Entity:GetVar(key,default) end

-- Returns the entity's velocity.  Actually binds to `CBaseEntity::GetAbsVelocity()` on the server and `C_BaseEntity::EstimateAbsVelocity()` on the client. This returns the total velocity of the entity and is equal to local velocity + base velocity.  This can become out-of-sync on the client if the server has been up for a long time.
---@return Vector
function Entity:GetVelocity() end

-- Returns ID of workshop addon that the entity is from.  The function **currently** does nothing and always returns nil
---@return number
function Entity:GetWorkshopID() end

-- Returns the position and angle of the entity as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.  This returns incorrect results for the angular component (columns 1-3) for the local player clientside.  This will use the local player's Global.EyeAngles in Category:3D_Rendering_Hooks.  Columns 1-3 will be all 0 (angular component) in Category:3D_Rendering_Hooks while paused in single-player.
---@return VMatrix
function Entity:GetWorldTransformMatrix() end

-- Causes the entity to break into its current models gibs, if it has any.  You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs.  If called on server, the gibs will be spawned on the currently connected clients and will not be synchronized. Otherwise the gibs will be spawned only for the client the function is called on.   this function will not remove or hide the entity it is called on. For more expensive version of this function see Entity:GibBreakServer. 
---@param force Vector The force to apply to the created gibs.
---@param clr? table If set, this will be color of the broken gibs instead of the entity's color.
function Entity:GibBreakClient(force,clr) end

-- Causes the entity to break into its current models gibs, if it has any.  You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs.  The gibs will be spawned on the server and be synchronized with all clients.  Note, that this function will not remove or hide the entity it is called on.  This function is affected by `props_break_max_pieces_perframe` and `props_break_max_pieces` console variables.  Large numbers of serverside gibs will cause lag.  You can avoid this cost by spawning the gibs on the client using Entity:GibBreakClient  Despite existing on client, it doesn't actually do anything on client.
---@param force Vector The force to apply to the created gibs
function Entity:GibBreakServer(force) end

-- Returns whether or not the bone manipulation functions have ever been called on given  entity.  Related functions are Entity:ManipulateBonePosition, Entity:ManipulateBoneAngles, Entity:ManipulateBoneJiggle, and Entity:ManipulateBoneScale.  This will return true if the entity's bones have ever been manipulated. Resetting the position/angles/jiggle/scaling to 0,0,0 will not affect this function.
---@return boolean
function Entity:HasBoneManipulations() end

-- Returns whether or not the the entity has had flex manipulations performed with Entity:SetFlexWeight or Entity:SetFlexScale.
---@return boolean
function Entity:HasFlexManipulatior() end

-- Returns whether this entity has the specified spawnflags bits set.
---@param spawnFlags number The spawnflag bits to check, see Enums/SF.
---@return boolean
function Entity:HasSpawnFlags(spawnFlags) end

-- Returns the position of the head of this entity, NPCs use this internally to aim at their targets.  This only works on players and NPCs.
---@param origin Vector The vector of where the attack comes from.
---@return Vector
function Entity:HeadTarget(origin) end

-- Returns the health of the entity.
---@return number
function Entity:Health() end

-- Sets the entity on fire.  See also Entity:Extinguish.
---@param length number How long to keep the entity ignited, in seconds.
---@param radius? number The radius of the ignition, will ignite everything around the entity that is in this radius.
function Entity:Ignite(length,radius) end

--   Initializes this entity as being clientside only.  Only works on entities fully created clientside, and as such it has currently no use due this being automatically called by ents.CreateClientProp, ents.CreateClientside, Global.ClientsideModel and Global.ClientsideScene.  Calling this on a clientside entity will crash the game.
function Entity:InitializeAsClientEntity() end

-- Fires input to the entity with the ability to make another entity responsible, bypassing the event queue system.  You should only use this function over Entity:Fire if you know what you are doing.  See also Entity:Fire for a function that conforms to the internal map IO event queue and GM:AcceptInput for a hook that can intercept inputs.
---@param input string The name of the input to fire
---@param activator? Entity The entity that caused this input (i.e. the player who pushed a button)
---@param caller? Entity The entity that is triggering this input (i.e. the button that was pushed)
---@param param? any The value to give to the input. Can be either a string, a number or a boolean.
function Entity:Input(input,activator,caller,param) end

--  Sets up Data Tables from entity to use with Entity:NetworkVar.
function Entity:InstallDataTable() end

-- Resets the entity's bone cache values in order to prepare for a model change.  This should be called after calling Entity:SetPoseParameter.
function Entity:InvalidateBoneCache() end

-- Returns true if the entity has constraints attached to it  This will only update clientside if the server calls it first. This only checks constraints added through the constraint so this will not react to map constraints.
---@return boolean
function Entity:IsConstrained() end

-- Returns if entity is constraint or not
---@return boolean
function Entity:IsConstraint() end

-- Returns whether the entity is dormant or not. Client/server entities become dormant when they leave the PVS on the server. Client side entities can decide for themselves whether to become dormant. This mainly applies to PVS.
---@return boolean
function Entity:IsDormant() end

-- Returns whether an entity has engine effect applied or not.
---@param effect number The effect to check for, see Enums/EF.
---@return boolean
function Entity:IsEffectActive(effect) end

-- Checks if given flag is set or not.
---@param flag number The engine flag to test, see Enums/EFL
---@return boolean
function Entity:IsEFlagSet(flag) end

-- Checks if given flag(s) is set or not.
---@param flag number The engine flag(s) to test, see Enums/FL
---@return boolean
function Entity:IsFlagSet(flag) end

-- Returns whether the entity is inside a wall or outside of the map.  Internally this function uses util.IsInWorld, that means that this function only checks Entity:GetPos of the entity. If an entity is only partially inside a wall, or has a weird GetPos offset, this function may not give reliable output.
---@return boolean
function Entity:IsInWorld() end

-- Returns whether the entity is lag compensated or not.
---@return boolean
function Entity:IsLagCompensated() end

-- Returns true if the target is in line of sight. This will only work when called on CBaseCombatCharacter entities. This includes players, NPCs, grenades, RPG rockets, crossbow bolts, and physics cannisters.
---@param target Vector The target to test. You can also supply an Entity instead of a Vector
---@return boolean
function Entity:IsLineOfSightClear(target) end

-- Returns if the entity is going to be deleted in the next frame.
---@return boolean
function Entity:IsMarkedForDeletion() end

-- Checks if the entity is a NextBot or not.
---@return boolean
function Entity:IsNextBot() end

-- Checks if the entity is an NPC or not.  This will return false for NextBots, see Entity:IsNextBot for that.
---@return boolean
function Entity:IsNPC() end

-- Returns whether the entity is on fire.
---@return boolean
function Entity:IsOnFire() end

-- Returns whether the entity is on ground or not.  Internally, this checks if Enums/FL is set on the entity.  This function is an alias of Entity:OnGround.
---@return boolean
function Entity:IsOnGround() end

-- Checks if the entity is a player or not.
---@return boolean
function Entity:IsPlayer() end

-- Returns true if the entity is being held by a player. Either by physics gun, gravity gun or use-key (+use).  If multiple players are holding an object and one drops it, this will return false despite the object still being held.
---@return boolean
function Entity:IsPlayerHolding() end

-- Returns whether there's a gesture with the given activity being played.  This function only works on BaseAnimatingOverlay entites!
---@param activity number The activity to test. See Enums/ACT.
---@return boolean
function Entity:IsPlayingGesture(activity) end

-- Checks if the entity is a ragdoll.
---@return boolean
function Entity:IsRagdoll() end

-- Checks if the entity is a SENT or a built-in entity.
---@return boolean
function Entity:IsScripted() end

-- Returns whether the entity's current sequence is finished or not.
---@return boolean
function Entity:IsSequenceFinished() end

-- Returns if the entity is solid or not. Very useful for determining if the entity is a trigger or not.
---@return boolean
function Entity:IsSolid() end

-- Returns whether the entity is a valid entity or not.  An entity is valid if: * It is not a Global_Variables entity * It is not the worldspawn entity (game.GetWorld)  Instead of calling this method directly, it's a good idea to call the global Global.IsValid instead, however if you're sure the variable you're using is always an entity object it's better to use this method  It will check whether the given variable contains an object (an Entity) or nothing at all for you. See examples.  NULL entities can still be assigned with key/value pairs, but they will be instantly negated. See example 3 This might be a cause for a lot of headache. Usually happening during networking etc., when completely valid entities suddenly become invalid on the client, but are never filtered with IsValid(). See GM:InitPostEntity for more details.
---@return boolean
function Entity:IsValid() end

-- Returns whether the given layer ID is valid and exists on this entity.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@return boolean
function Entity:IsValidLayer(layerID) end

-- Checks if the entity is a vehicle or not.
---@return boolean
function Entity:IsVehicle() end

-- Checks if the entity is a weapon or not.
---@return boolean
function Entity:IsWeapon() end

-- Returns whether the entity is a widget or not.  This is used by the "Edit Bones" context menu property.
---@return boolean
function Entity:IsWidget() end

-- Returns if the entity is the map's Entity[0] worldspawn
---@return boolean
function Entity:IsWorld() end

-- Converts a vector local to an entity into a worldspace vector
---@param lpos Vector The local vector
---@return Vector
function Entity:LocalToWorld(lpos) end

-- Converts a local angle (local to the entity) to a world angle.
---@param ang Angle The local angle
---@return Angle
function Entity:LocalToWorldAngles(ang) end

-- Returns the attachment index of the given attachment name.
---@param attachmentName string The name of the attachment.
---@return number
function Entity:LookupAttachment(attachmentName) end

-- Gets the bone index of the given bone name, returns nothing if the bone does not exist.
---@param boneName string The name of the bone.  Common generic bones ( for player models and some HL2 models ): * ValveBiped.Bip01_Head1 * ValveBiped.Bip01_Spine * ValveBiped.Anim_Attachment_RH  Common hand bones (left hand equivalents also available, replace _R_ with _L_) * ValveBiped.Bip01_R_Hand * ValveBiped.Bip01_R_Forearm * ValveBiped.Bip01_R_Foot * ValveBiped.Bip01_R_Thigh * ValveBiped.Bip01_R_Calf * ValveBiped.Bip01_R_Shoulder * ValveBiped.Bip01_R_Elbow
---@return number
function Entity:LookupBone(boneName) end

-- Returns pose parameter ID from its name.
---@param name string Pose parameter name
---@return number
function Entity:LookupPoseParameter(name) end

-- Returns sequence ID from its name. See Entity:GetSequenceName for a function that does the opposite.
---@param name string Sequence name
---@return number
---@return number
function Entity:LookupSequence(name) end

-- Turns the Entity:GetPhysicsObject into a physics shadow. It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.  A physics shadow can be used to have static entities that never move by setting both arguments to false.  Unlike Entity:PhysicsInitShadow, this function doesn't remove the current physics object.
---@param allowPhysicsMovement? boolean Whether to allow the physics shadow to move under stress.
---@param allowPhysicsRotation? boolean Whether to allow the physics shadow to rotate under stress.
function Entity:MakePhysicsObjectAShadow(allowPhysicsMovement,allowPhysicsRotation) end

-- Sets custom bone angles.  When used repeatedly serverside, this method is strongly discouraged due to the huge network traffic produced.
---@param boneID number Index of the bone you want to manipulate
---@param ang Angle Angle to apply.  The angle is relative to the original bone angle, not relative to the world or the entity.
---@param networking? boolean boolean to network these changes (if called from server)
function Entity:ManipulateBoneAngles(boneID,ang,networking) end

-- Manipulates the bone's jiggle status. This allows non jiggly bones to become jiggly.
---@param boneID number Index of the bone you want to manipulate.
---@param enabled number * `0` = No Jiggle * `1` = Jiggle
function Entity:ManipulateBoneJiggle(boneID,enabled) end

-- Sets custom bone offsets.
---@param boneID number Index of the bone you want to manipulate.
---@param pos Vector Position vector to apply. Note that the position is relative to the original bone position, not relative to the world or the entity.
---@param networking? boolean boolean to network these changes (if called from server)
function Entity:ManipulateBonePosition(boneID,pos,networking) end

-- Sets custom bone scale.  When used repeatedly serverside, this method is strongly discouraged due to the huge network traffic produced.  This does not scale procedural bones.
---@param boneID number Index of the bone you want to manipulate
---@param scale Vector Scale vector to apply. Note that the scale is relative to the original bone scale, not relative to the world or the entity.  The vector will be normalised if its longer than 32 units.
function Entity:ManipulateBoneScale(boneID,scale) end

-- Returns entity's map creation ID. Unlike Entity:EntIndex or Entity:GetCreationID, it will always be the same on same map, no matter how much you clean up or restart it.  To be used in conjunction with ents.GetMapCreatedEntity.
---@return number
function Entity:MapCreationID() end

-- Refreshes the shadow of the entity.
function Entity:MarkShadowAsDirty() end

-- Fires the muzzle flash effect of the weapon the entity is carrying. This only creates a light effect and is often called alongside Weapon:SendWeaponAnim
function Entity:MuzzleFlash() end

-- Performs a Ray-Orientated Bounding Box intersection from the given position to the origin of the OBBox with the entity and returns the hit position on the OBBox.  This relies on the entity having a collision mesh (not a physics object) and will be affected by `SOLID_NONE`
---@param position Vector The vector to start the intersection from.
---@return Vector
function Entity:NearestPoint(position) end

-- Creates a network variable on the entity and adds Set/Get functions for it. This function should only be called in ENTITY:SetupDataTables.  See Entity:NetworkVarNotify for a function to hook NetworkVar changes.  Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing. Entity NetworkVars may briefly be incorrect due to how PVS networking and entity indexes work.
---@param type string Supported choices:  * `String` * `Bool` * `Float` * `Int` (32-bit signed integer) * `Vector` * `Angle` * `Entity`
---@param slot number Each network variable has to have a unique slot. The slot is per type - so you can have an int in slot `0`, a bool in slot `0` and a float in slot `0` etc. You can't have two ints in slot `0`, instead you would do a int in slot `0` and another int in slot `1`.  The max slots right now are `32` - so you should pick a number between `0` and `31`. An exception to this is strings which has a max slots of `4`.
---@param name string The name will affect how you access it. If you call it `Foo` you would add two new functions on your entity - `SetFoo()` and `GetFoo()`. So be careful that what you call it won't collide with any existing functions (don't call it `Pos` for example).
---@param extended? table A table of extended information.  `KeyName` * Allows the NetworkVar to be set using Entity:SetKeyValue. This is useful if you're making an entity that you want to be loaded in a map. The sky entity uses this.  `Edit` * The edit key lets you mark this variable as editable. See Editable Entities for more information.
function Entity:NetworkVar(type,slot,name,extended) end

-- Similarly to Entity:NetworkVar, creates a network variable on the entity and adds Set/Get functions for it. This method stores it's value as a member value of a vector or an angle. This allows to go beyond the normal variable limit of Entity:NetworkVar for `Int` and `Float` types, at the expense of `Vector` and `Angle` limit.  This function should only be called in ENTITY:SetupDataTables.  Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing.
---@param type string Supported choices: * `Vector` * `Angle`
---@param slot number The slot for this `Vector` or `Angle`, from `0` to `31`. See Entity:NetworkVar for more detailed explanation.
---@param element string Which element of a `Vector` or an `Angle` to store the value on. This can be `p`, `y`, `r` for Angles, and `x`, `y`, `z` for Vectors
---@param name string The name will affect how you access it. If you call it `Foo` you would add two new functions on your entity - `SetFoo()` and `GetFoo()`. So be careful that what you call it won't collide with any existing functions (don't call it "Pos" for example).
---@param extended? table A table of extra information. See Entity:NetworkVar for details.
function Entity:NetworkVarElement(type,slot,element,name,extended) end

-- Creates a callback that will execute when the given network variable changes - that is, when the `Set()` function is run.  The callback is executed **before** the value is changed, and is called even if the new and old values are the same.  This function does not exist on entities in which Entity:InstallDataTable has not been called. By default, this means this function only exists on SENTs (both serverside and clientside) and on players with a Player_Classes (serverside and clientside Global.LocalPlayer only). It's therefore safest to only use this in ENTITY:SetupDataTables.  The callback will not be called clientside if the var is changed right after entity spawn. 
---@param name string Name of variable to track changes of.
---@param callback function The function to call when the variable changes. It is passed 4 arguments: * Entity entity - Entity whos variable changed. * string name - Name of changed variable. * any old - Old/current variable value. * any new - New variable value that it was set to.
function Entity:NetworkVarNotify(name,callback) end

-- In the case of a scripted entity, this will cause the next ENTITY:Think event to be run at the given time.  Does not work clientside! Use Entity:SetNextClientThink instead.  This does not work with SWEPs or Nextbots.
---@param timestamp number The relative to Global.CurTime timestamp, at which the next think should occur.
function Entity:NextThink(timestamp) end

-- Returns the center of an entity's bounding box as a local vector.
---@return Vector
function Entity:OBBCenter() end

-- Returns the highest corner of an entity's bounding box as a local vector.
---@return Vector
function Entity:OBBMaxs() end

-- Returns the lowest corner of an entity's bounding box as a local vector.
---@return Vector
function Entity:OBBMins() end

-- Returns the entity's capabilities as a bitfield.  In the engine this function is mostly used to check the use type, the save/restore system and level transitions flags.  Even though the function is defined shared, it is not guaranteed to return the same value across states.  The enums for this are not currently implemented in Lua, however you can access the defines [here](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/shared/baseentity_shared.h#L21-L38).
---@return number
function Entity:ObjectCaps() end

-- Returns true if the entity is on the ground, and false if it isn't.  Internally, this checks if Enums/FL is set on the entity. This is only updated for players and NPCs, and thus won't inherently work for other entities.
---@return boolean
function Entity:OnGround() end

-- Tests whether the damage passes the entity filter.  This will call ENTITY:PassesDamageFilter on scripted entities of the type "filter".  This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
---@param dmg CTakeDamageInfo The damage info to test
---@return boolean
function Entity:PassesDamageFilter(dmg) end

-- Tests whether the entity passes the entity filter.  This will call ENTITY:PassesFilter on scripted entities of the type "filter".  This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
---@param caller Entity The initiator of the test.  For example the trigger this filter entity is used in.
---@param ent Entity The entity to test against the entity filter.
---@return boolean
function Entity:PassesFilter(caller,ent) end

-- Destroys the current physics object of an entity.  Cannot be used on a ragdoll or the world entity.
function Entity:PhysicsDestroy() end

-- Initializes the physics mesh of the entity from a triangle soup defined by a table of vertices. The resulting mesh is hollow, may contain holes, and always has a volume of 0.  While this is very useful for static geometry such as terrain displacements, it is advised to use Entity:PhysicsInitConvex or Entity:PhysicsInitMultiConvex for moving solid objects instead.  Entity:EnableCustomCollisions needs to be called if you want players to collide with the entity correctly.
---@param vertices table A table consisting of Structures/MeshVertex (only the `pos` element is taken into account). Every 3 vertices define a triangle in the physics mesh.
---@param surfaceprop? string Physical material from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt) or added with physenv.AddSurfaceData.
---@return boolean
function Entity:PhysicsFromMesh(vertices,surfaceprop) end

-- Initializes the Entity:GetPhysicsObject of the entity using its current Entity:GetModel. Deletes the previous physics object if it existed and the new object creation was successful.  If the entity's current model has no physics mesh associated to it, no physics object will be created and the previous object will still exist, if applicable.  When called clientside, this will not create a valid PhysObj if the model hasn't been util.PrecacheModel serverside.  If successful, this function will automatically call Entity:SetSolid( solidType ) and Entity:SetSolidFlags( 0 ).  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param solidType number The solid type of the physics object to create, see Enums/SOLID. Should be `SOLID_VPHYSICS` in most cases.  Using `SOLID_NONE` will only delete the current physics object - it does not create a new one.
---@return boolean
function Entity:PhysicsInit(solidType) end

-- Makes the physics object of the entity a AABB.  This function will automatically destroy any previous physics objects and do the following: * Entity:SetSolid( `SOLID_BBOX` ) * Entity:SetMoveType( `MOVETYPE_VPHYSICS` ) * Entity:SetCollisionBounds( `mins`, `maxs` )  If the volume of the resulting box is 0 (the mins and maxs are the same), the mins and maxs will be changed to Global.Vector( -1, -1, -1 ) and Global.Vector( 1, 1, 1 ), respectively.  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param mins Vector The minimum position of the box. This is automatically ordered with the maxs.
---@param maxs Vector The maximum position of the box. This is automatically ordered with the mins.
---@param surfaceprop? string Physical material from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt) or added with physenv.AddSurfaceData.
---@return boolean
function Entity:PhysicsInitBox(mins,maxs,surfaceprop) end

-- Initializes the physics mesh of the entity with a convex mesh defined by a table of points. The resulting mesh is the  of all the input points. If successful, the previous physics object will be removed.  This is the standard way of creating moving physics objects with a custom convex shape. For more complex, concave shapes, see Entity:PhysicsInitMultiConvex.  This will crash if given all Global.Vector(0,0,0)s.  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  You can use the following workaround for movement, though clientside collisions will still be broken. ``` function ENT:Think() if ( CLIENT ) then local physobj = self:GetPhysicsObject()  if ( IsValid( physobj ) ) then physobj:SetPos( self:GetPos() ) physobj:SetAngles( self:GetAngles() ) end end end ``` 
---@param points table A table of eight Vectors, in local coordinates, to be used in the computation of the convex mesh. Order does not matter.
---@param surfaceprop? string Physical material from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt) or added with physenv.AddSurfaceData.
---@return boolean
function Entity:PhysicsInitConvex(points,surfaceprop) end

-- An advanced version of Entity:PhysicsInitConvex which initializes a physics object from multiple convex meshes. This should be used for physics objects with a custom shape which cannot be represented by a single convex mesh.  If successful, the previous physics object will be removed.  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param vertices table A table consisting of tables of Vectors. Each sub-table defines a set of points to be used in the computation of one convex mesh.
---@param surfaceprop? string Physical material from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt) or added with physenv.AddSurfaceData.
---@return boolean
function Entity:PhysicsInitMultiConvex(vertices,surfaceprop) end

-- Initializes the entity's physics object as a physics shadow. Removes the previous physics object if successful. This is used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.  A physics shadow can be used to have static entities that never move by setting both arguments to false.  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param allowPhysicsMovement? boolean Whether to allow the physics shadow to move under stress.
---@param allowPhysicsRotation? boolean Whether to allow the physics shadow to rotate under stress.
---@return boolean
function Entity:PhysicsInitShadow(allowPhysicsMovement,allowPhysicsRotation) end

-- Makes the physics object of the entity a sphere.  This function will automatically destroy any previous physics objects and do the following: * Entity:SetSolid( `SOLID_BBOX` ) * Entity:SetMoveType( `MOVETYPE_VPHYSICS` )  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param radius number The radius of the sphere.
---@param physmat? string Physical material from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt) or added with physenv.AddSurfaceData.
---@return boolean
function Entity:PhysicsInitSphere(radius,physmat) end

-- Initializes a static physics object of the entity using its Entity:GetModel. If successful, the previous physics object is removed.  This is what used by entities such as `func_breakable`, `prop_dynamic`, `item_suitcharger`, `prop_thumper` and `npc_rollermine` while it is in its "buried" state in the Half-Life 2 Campaign.  If the entity's current model has no physics mesh associated to it, no physics object will be created.  This function will automatically call Entity:SetSolid( `solidType` ).  Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.  A workaround is available on the Entity:PhysicsInitConvex page.
---@param solidType number The solid type of the physics object to create, see Enums/SOLID. Should be `SOLID_VPHYSICS` in most cases.
---@return boolean
function Entity:PhysicsInitStatic(solidType) end

-- Wakes up the entity's physics object
function Entity:PhysWake() end

-- Makes the entity play a .vcd scene. [All scenes from Half-Life 2](https://developer.valvesoftware.com/wiki/Half-Life_2_Scenes_List).
---@param scene string Filepath to scene.
---@param delay? number Delay in seconds until the scene starts playing.
---@return number
---@return Entity
function Entity:PlayScene(scene,delay) end

-- Changes an entities angles so that it faces the target entity.
---@param target Entity The entity to face.
function Entity:PointAtEntity(target) end

-- Precaches gibs for the entity's model.  Normally this function should be ran when the entity is spawned, for example the ENTITY:Initialize, after Entity:SetModel is called.  This is required for Entity:GibBreakServer and Entity:GibBreakClient to work.
---@return number
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

-- Removes and stops all gestures.  This function only works on BaseAnimatingOverlay entites!
function Entity:RemoveAllGestures() end

-- Removes a callback previously added with Entity:AddCallback
---@param hook string The hook name to remove. See Entity Callbacks
---@param callbackid number The callback id previously retrieved with the return of Entity:AddCallback or Entity:GetCallbacks
function Entity:RemoveCallback(hook,callbackid) end

-- Removes a function previously added via Entity:CallOnRemove.
---@param identifier string Identifier of the function within CallOnRemove
function Entity:RemoveCallOnRemove(identifier) end

-- Removes an engine effect applied to an entity.
---@param effect number The effect to remove, see Enums/EF.
function Entity:RemoveEffects(effect) end

-- Removes specified engine flag
---@param flag number The flag to remove, see Enums/EFL
function Entity:RemoveEFlags(flag) end

-- Removes specified flag(s) from the entity
---@param flag number The flag(s) to remove, see Enums/FL
function Entity:RemoveFlags(flag) end

-- Removes a PhysObject from the entity's motion controller so that ENTITY:PhysicsSimulate will no longer be called for given PhysObject.  You must first create a motion controller with Entity:StartMotionController.  Only works on a scripted Entity of anim type
---@param physObj PhysObj The PhysObj to remove from the motion controller.
function Entity:RemoveFromMotionController(physObj) end

-- Removes and stops the gesture with given activity.  This function only works on BaseAnimatingOverlay entites!
---@param activity number The activity remove. See Enums/ACT.
function Entity:RemoveGesture(activity) end

-- Breaks internal Ragdoll constrains, so you can for example separate an arm from the body of a ragdoll and preserve all physics.  The visual mesh will still stretch as if it was properly connected unless the ragdoll model is specifically designed to avoid that.
---@param num? number Which constraint to break, values below 0 mean break them all
function Entity:RemoveInternalConstraint(num) end

-- Removes solid flag(s) from the entity.
---@param flags number The flag(s) to remove, see Enums/FSOLID.
function Entity:RemoveSolidFlags(flags) end

-- Plays an animation on the entity. This may not always work on engine entities.  This will not reset the animation on viewmodels, use Entity:SendViewModelMatchingSequence instead.  This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick.  Will not work on players due to the animations being reset every frame by the base gamemode animation system. See GM:CalcMainActivity.  For custom scripted entities you will want to apply example from ENTITY:Think to make animations work.
---@param sequence number The sequence to play. Also accepts strings.  If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
function Entity:ResetSequence(sequence) end

-- Reset entity sequence info such as playback rate, ground speed, last event check, etc.
function Entity:ResetSequenceInfo() end

-- Makes the entity/weapon respawn.  Only usable on HL2/HL:S pickups and any weapons. Seems to be buggy with weapons. Very unreliable.
function Entity:Respawn() end

-- Restarts the entity's animation gesture. If the given gesture is already playing, it will reset it and play it from the beginning.  This function only works on BaseAnimatingOverlay entites.
---@param activity number The activity number to send to the entity. See Enums/ACT and Entity:GetSequenceActivity
---@param addIfMissing? boolean Add/start the gesture to if it has not been yet started.
---@param autokill? boolean
function Entity:RestartGesture(activity,addIfMissing,autokill) end

-- Returns sequence ID corresponding to given activity ID.  Opposite of Entity:GetSequenceActivity.  Similar to Entity:LookupSequence.  See also Entity:SelectWeightedSequenceSeeded.
---@param act number The activity ID, see Enums/ACT.
---@return number
function Entity:SelectWeightedSequence(act) end

-- Returns the sequence ID corresponding to given activity ID, and uses the provided seed for random selection. The seed should be the same server-side and client-side if used in a predicted environment.  See Entity:SelectWeightedSequence for a provided-seed version of this function.
---@param act number The activity ID, see Enums/ACT.
---@param seed number The seed to use for randomly selecting a sequence in the case the activity ID has multiple sequences bound to it. Entity:SelectWeightedSequence uses the same seed as util.SharedRandom internally for this.
---@return number
function Entity:SelectWeightedSequenceSeeded(act,seed) end

-- Sends sequence animation to the view model. It is recommended to use this for view model animations, instead of Entity:ResetSequence.  This function is only usable on view models.  Sequences 0-6 will not be looped regardless if they're marked as a looped animation or not.
---@param seq number The sequence ID returned by Entity:LookupSequence or  Entity:SelectWeightedSequence.
function Entity:SendViewModelMatchingSequence(seq) end

-- Returns length of currently played sequence.  This will return incorrect results for weapons and viewmodels clientside in thirdperson.
---@param seqid? number A sequence ID to return the length specific sequence of instead of the entity's main/currently playing sequence.
---@return number
function Entity:SequenceDuration(seqid) end

-- Sets the entity's velocity.  Actually binds to CBaseEntity::SetLocalVelocity() which sets the entity's velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.
---@param velocity Vector The new velocity to set.
function Entity:SetAbsVelocity(velocity) end

-- Sets the angles of the entity.  To set a player's angles, use Player:SetEyeAngles instead.
---@param angles Angle The new angles.
function Entity:SetAngles(angles) end

-- Sets a player's third-person animation. Mainly used by Weapons to start the player's weapon attack and reload animations.
---@param playerAnim number Player animation, see Enums/PLAYER.
function Entity:SetAnimation(playerAnim) end

-- Sets the start time (relative to Global.CurTime) of the current animation, which is used to determine Entity:GetCycle. Should be less than CurTime to play an animation from the middle.
---@param time number The time the animation was supposed to begin.
function Entity:SetAnimTime(time) end

-- You should be using Entity:SetParent instead.  Parents the sprite to an attachment on another model.  Works only on env_sprite.  Despite existing on client, it doesn't actually do anything on client.
---@param ent Entity The entity to attach/parent to
---@param attachment number The attachment ID to parent to
function Entity:SetAttachment(ent,attachment) end

-- Sets the blood color this entity uses.
---@param bloodColor number An integer corresponding to Enums/BLOOD_COLOR.
function Entity:SetBloodColor(bloodColor) end

-- Sets an entities' bodygroup. If called for Weapon (after Initialize hook) with different body groups on world model and view model, check will occur by view model.
---@param bodygroup number The id of the bodygroup you're setting. Starts from 0.
---@param value number The value you're setting the bodygroup to. Starts from 0.
function Entity:SetBodygroup(bodygroup,value) end

-- Sets the bodygroups from a string. A convenience function for Entity:SetBodygroup. If called for Weapon (after Initialize hook) with different body groups on world model and view model, check will occur by view model.
---@param bodygroups string Body groups to set. Each character in the string represents a separate bodygroup. (`0` to `9`, `a` to `z` being (`10` to `35`))
function Entity:SetBodyGroups(bodygroups) end

-- Sets the specified value on the bone controller with the given ID of this entity, it's used in HL1 to change the head rotation of NPCs, turret aiming and so on.  This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
---@param boneControllerID number The ID of the bone controller to set the value to. Goes from 0 to 3.
---@param value number The value to set on the specified bone controller.
function Entity:SetBoneController(boneControllerID,value) end

-- Sets the bone matrix of given bone to given matrix. See also Entity:GetBoneMatrix.  Despite existing serverside, it does nothing.
---@param boneid number The ID of the bone
---@param matrix VMatrix The matrix to set.
function Entity:SetBoneMatrix(boneid,matrix) end

-- Sets the bone position and angles.
---@param bone number The bone ID to manipulate
---@param pos Vector The position to set
---@param ang Angle The angles to set
function Entity:SetBonePosition(bone,pos,ang) end

-- Sets the collision bounds for the entity, which are used for triggers (Entity:SetTrigger, ENTITY:Touch), and collision (If Entity:SetSolid set as Enums/SOLID).  Input bounds are relative to Entity:GetPos! See also Entity:SetCollisionBoundsWS.  Player collision bounds are reset every frame to player's Player:SetHull values.
---@param mins Vector The minimum vector of the bounds.
---@param maxs Vector The maximum vector of the bounds.
function Entity:SetCollisionBounds(mins,maxs) end

-- A convenience function that sets the collision bounds for the entity in world space coordinates by transforming given vectors to entity's local space and passing them to Entity:SetCollisionBounds
---@param vec1 Vector The first vector of the bounds.
---@param vec2 Vector The second vector of the bounds.
function Entity:SetCollisionBoundsWS(vec1,vec2) end

-- Sets the entity's collision group.
---@param group number Collision group of the entity, see Enums/COLLISION_GROUP
function Entity:SetCollisionGroup(group) end

-- Sets the color of an entity.  Some entities may need a custom [render mode](Enums/RENDERMODE) set for transparency to work. See example 2. Entities also must have a proper [render group](Enums/RENDERGROUP) set for transparency to work.
---@param color? table The color to set. Uses the Color.
function Entity:SetColor(color) end

-- Sets the color of an entity. This function overrides Colors set with Entity:SetColor
---@param r number
---@param g number
---@param b number
---@param a number
function Entity:SetColor4Part(r,g,b,a) end

-- Sets the creator of the Entity. This is set automatically in Sandbox gamemode when spawning SENTs, but is never used/read by default.
---@param ply Player The creator
function Entity:SetCreator(ply) end

-- Marks the entity to call GM:ShouldCollide. Not to be confused with Entity:EnableCustomCollisions.
---@param enable boolean Enable or disable the custom collision check
function Entity:SetCustomCollisionCheck(enable) end

-- Sets the progress of the current animation to a specific value between 0 and 1.  This does not work with viewmodels.
---@param value number The desired cycle value
function Entity:SetCycle(value) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified angle on the entity's datatable.
---@param key number Goes from 0 to 31.
---@param ang Angle The angle to write on the entity's datatable.
function Entity:SetDTAngle(key,ang) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified bool on the entity's datatable.
---@param key number Goes from 0 to 31.
---@param bool boolean The boolean to write on the entity's metatable.
function Entity:SetDTBool(key,bool) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified entity on this entity's datatable.
---@param key number Goes from 0 to 31.
---@param ent Entity The entity to write on this entity's datatable.
function Entity:SetDTEntity(key,ent) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified float on the entity's datatable.
---@param key number Goes from 0 to 31.
---@param float number The float to write on the entity's datatable.
function Entity:SetDTFloat(key,float) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified integer on the entity's datatable.
---@param key number Goes from 0 to 31.
---@param integer number The integer to write on the entity's datatable. This will be cast to a 32-bit signed integer internally.
function Entity:SetDTInt(key,integer) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified string on the entity's datatable.  The length of these strings are capped at 512 characters.
---@param key number Goes from 0 to 3.
---@param str string The string to write on the entity's datatable, can't be more than 512 characters per string.
function Entity:SetDTString(key,str) end

--  This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible.  Sets the specified vector on the entity's datatable.
---@param key number Goes from 0 to 31.
---@param vec Vector The vector to write on the entity's datatable.
function Entity:SetDTVector(key,vec) end

-- Sets the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
---@param elasticity number The elasticity to set.
function Entity:SetElasticity(elasticity) end

-- Allows you to set the Start or End entity attachment for the rope.
---@param name string The name of the variable to modify. Accepted names are StartEntity and EndEntity.
---@param entity Entity The entity to apply to the specific attachment.
function Entity:SetEntity(name,entity) end

-- Sets the position an entity's eyes look toward. This works as an override for default behavior. Set to `0,0,0` to disable the override.
---@param pos Vector If NPC, the **world position** for the entity to look towards, for Ragdolls, a **local position** in front of their `eyes` attachment.
function Entity:SetEyeTarget(pos) end

-- Sets the flex scale of the entity.  This does not work on Global.ClientsideModels or Global.ClientsideRagdolls.
---@param scale number The new flex scale to set to
function Entity:SetFlexScale(scale) end

-- Sets the flex weight.
---@param flex number The ID of the flex to modify weight of
---@param weight number The new weight to set
function Entity:SetFlexWeight(flex,weight) end

-- Sets how much friction an entity has when sliding against a surface. Entities default to 1 (100%) and can be higher or even negative. This only multiplies the friction of the entity, to change the value itself use PhysObj:SetMaterial.  Works only for MOVETYPE_STEP entities.  This has no effect on players.
---@param friction number Friction multiplier
function Entity:SetFriction(friction) end

-- Sets the gravity multiplier of the entity.  This function is not predicted.
---@param gravityMultiplier number Value which specifies the gravity multiplier.
function Entity:SetGravity(gravityMultiplier) end

-- Sets the ground the entity is standing on.
---@param ground Entity The ground entity.
function Entity:SetGroundEntity(ground) end

-- Sets the health of the entity.  You may want to take Entity:GetMaxHealth into account when calculating what to set health to, in case a gamemode has a different max health than 100.  In some cases, setting health only on server side can cause hitches in movement, for example if something modifying the player speed based on health. To solve this issue, it is better to set it shared in a predicted hook.
---@param newHealth number New health value.
function Entity:SetHealth(newHealth) end

-- Sets the current Hitbox set for the entity.
---@param id number The new hitbox set to set. Can be a name as a string, or the ID as a number.  If the operation failed, the function will silently fail.
function Entity:SetHitboxSet(id) end

-- Enables or disable the inverse kinematic usage of this entity.
---@param useIK? boolean The state of the IK.
function Entity:SetIK(useIK) end

-- Sets Hammer key values on an entity.  You can look up which entities have what key values on the [Valve Developer Community](https://developer.valvesoftware.com/wiki/) on entity pages.   A  list of basic entities can be found [here](https://developer.valvesoftware.com/wiki/List_of_entities).  Alternatively you can look at the .fgd files shipped with Garry's Mod in the bin/ folder with a text editor to see the key values as they appear in Hammer.
---@param key string The internal key name
---@param value string The value to set
function Entity:SetKeyValue(key,value) end

-- This allows the entity to be lag compensated during Player:LagCompensation.  Players are lag compensated by default and there's no need to call this function for them.  It's best to not enable lag compensation on parented entities, as the system does not handle it that well ( they will be moved back but then the entity will lag behind ). Parented entities move back with the parent if it's lag compensated, so if you are making some kind of armor piece you shouldn't do anything.  As a side note for parented entities, if your entity can be shot at, keep in mind that its collision bounds need to be bigger than the bone's hitbox the entity is parented to, or hull/line traces ( such as the crowbar attack or bullets ) might not hit at all.
---@param enable boolean Whether the entity should be lag compensated or not.
function Entity:SetLagCompensated(enable) end

-- This function only works on BaseAnimatingOverlay entites!
---@param layerID number The Layer ID
---@param blendIn number
function Entity:SetLayerBlendIn(layerID,blendIn) end

-- This function only works on BaseAnimatingOverlay entites!
---@param layerID number The Layer ID
---@param blendOut number
function Entity:SetLayerBlendOut(layerID,blendOut) end

-- Sets the animation cycle/frame of given layer.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@param cycle number The new animation cycle/frame for given layer.
function Entity:SetLayerCycle(layerID,cycle) end

-- Sets the duration of given layer. This internally overrides the Entity:SetLayerPlaybackRate.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@param duration number The new duration of the layer in seconds.
function Entity:SetLayerDuration(layerID,duration) end

-- Sets whether the layer should loop or not.  This function only works on BaseAnimatingOverlay entites!
---@param layerID number The Layer ID
---@param loop boolean Whether the layer should loop or not.
function Entity:SetLayerLooping(layerID,loop) end

-- Sets the layer playback rate. See also Entity:SetLayerDuration.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@param rate number The new playback rate.
function Entity:SetLayerPlaybackRate(layerID,rate) end

-- Sets the priority of given layer.  This function only works on BaseAnimatingOverlay entites!
---@param layerID number The Layer ID
---@param priority number The new priority of the layer.
function Entity:SetLayerPriority(layerID,priority) end

-- Sets the sequence of given layer.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID.
---@param seq number The sequenceID to set. See Entity:LookupSequence.
function Entity:SetLayerSequence(layerID,seq) end

-- Sets the layer weight. This influences how strongly the animation should be overriding the normal animations of the entity.  This function only works on BaseAnimatingOverlay entities.
---@param layerID number The Layer ID
---@param weight number The new layer weight.
function Entity:SetLayerWeight(layerID,weight) end

-- This forces an entity to use the bone transformation behaviour from versions prior to **8 July 2014**.  This behaviour affects Entity:EnableMatrix and Entity:SetModelScale and is incorrect, therefore this function be used exclusively as a quick fix for old scripts that rely on it.
---@param enabled boolean Whether the entity should use the old bone transformation behaviour or not.
function Entity:SetLegacyTransform(enabled) end

-- Sets the entity to be used as the light origin position for this entity.
---@param lightOrigin Entity The lighting entity.
function Entity:SetLightingOriginEntity(lightOrigin) end

-- Sets angles relative to angles of Entity:GetParent
---@param ang Angle The local angle
function Entity:SetLocalAngles(ang) end

-- Sets the entity's angular velocity (rotation speed).
---@param angVel Angle The angular velocity to set.
function Entity:SetLocalAngularVelocity(angVel) end

-- Sets local position relative to the parented position. This is for use with Entity:SetParent to offset position.
---@param pos Vector The local position
function Entity:SetLocalPos(pos) end

-- Sets the entity's local velocity which is their velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.  Same as Entity:SetAbsVelocity, but clamps the given velocity, and is not recommended to be used because of that.
---@param velocity Vector The new velocity to set.
function Entity:SetLocalVelocity(velocity) end

-- Sets the Level Of Detail model to use with this entity. This may not work for all models if the model doesn't include any LOD sub models.  This function works exactly like the clientside r_lod convar and takes priority over it.
---@param lod? number The Level Of Detail model ID to use. -1 leaves the engine to automatically set the Level of Detail.  The Level Of Detail may range from 0 to 8, with 0 being the highest quality and 8 the lowest.
function Entity:SetLOD(lod) end

-- Sets the rendering material override of the entity.  To set a Lua material created with Global.CreateMaterial, just prepend a "!" to the material name.  If you wish to override a single material on the model, use Entity:SetSubMaterial instead.  To apply materials to models, that material **must** have **VertexLitGeneric** shader. For that reason you cannot apply map textures onto models, map textures use a different material shader - **LightmappedGeneric**, which can be used on brush entities.  The server's value takes priority on the client.
---@param materialName string New material name. Use an empty string ("") to reset to the default materials.
function Entity:SetMaterial(materialName) end

-- Sets the maximum health for entity. Note, that you can still set entity's health above this amount with Entity:SetHealth.
---@param maxhealth number What the max health should be
function Entity:SetMaxHealth(maxhealth) end

-- Sets the model of the entity.  This does not update the physics of the entity - see Entity:PhysicsInit.  This silently fails when given an empty string.
---@param modelName string New model value.
function Entity:SetModel(modelName) end

-- Alter the model name returned by Entity:GetModel. Does not affect the entity's actual model.
---@param modelname string The new model name.
function Entity:SetModelName(modelname) end

-- Scales the model of the entity, if the entity is a Player or an NPC the hitboxes will be scaled as well.  For some entities, calling Entity:Activate after this will scale the collision bounds and PhysObj as well; be wary as there's no optimization being done internally and highly complex collision models might crash the server.  This is the same system used in TF2 for the Mann Vs Machine robots.  To resize the entity along any axis, use Entity:EnableMatrix instead.  Client-side trace detection seems to mess up if deltaTime is set to anything but zero. A very small decimal can be used instead of zero to solve this issue.  If your old scales are wrong, use Entity:SetLegacyTransform as a quick fix.  If you do not want the physics to be affected by Entity:Activate, you can use Entity:ManipulateBoneScale`( 0, Vector( scale, scale, scale ) )` instead.  This does not scale procedural bones and disables IK.
---@param scale number A float to scale the model by. 0 will not draw anything. A number less than 0 will draw the model inverted.
---@param deltaTime? number Transition time of the scale change, set to 0 to modify the scale right away. To avoid issues with client-side trace detection this must be set, and can be an extremely low number to mimic a value of 0 such as .000001.
function Entity:SetModelScale(scale,deltaTime) end

-- Sets the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
---@param moveCollideType number The move collide type, see Enums/MOVECOLLIDE
function Entity:SetMoveCollide(moveCollideType) end

-- Sets the Movement Parent of an entity to another entity.  Similar to Entity:SetParent, except the object's coordinates are not translated automatically before parenting.  Does nothing on client.
---@param Parent Entity The entity to change this entity's Movement Parent to.
function Entity:SetMoveParent(Parent) end

-- Sets the entity's move type. This should be called before initializing the physics object on the entity, unless it will override SetMoveType such as Entity:PhysicsInitBox.  Despite existing on client, it doesn't actually do anything on client.
---@param movetype number The new movetype, see Enums/MOVETYPE
function Entity:SetMoveType(movetype) end

-- Sets the mapping name of the entity.
---@param mappingName string The name to set for the entity.
function Entity:SetName(mappingName) end

-- Alters the entity's perceived serverside angle on the client.
---@param angle Angle Networked angle.
function Entity:SetNetworkAngles(angle) end

-- Sets a networked angle value on the entity.  The value can then be accessed with Entity:GetNetworked2Angle both from client and server.  You should be using Entity:SetNW2Angle instead. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWAngle instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Angle The value to set
function Entity:SetNetworked2Angle(key,value) end

-- Sets a networked boolean value on the entity.  The value can then be accessed with Entity:GetNetworked2Bool both from client and server. You should be using Entity:SetNW2Bool instead. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWBool instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value boolean The value to set
function Entity:SetNetworked2Bool(key,value) end

-- Sets a networked entity value on the entity.  The value can then be accessed with Entity:GetNetworked2Entity both from client and server. You should be using Entity:SetNW2Entity instead. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWEntity instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Entity The value to set
function Entity:SetNetworked2Entity(key,value) end

-- Sets a networked float (number) value on the entity.  The value can then be accessed with Entity:GetNetworked2Float both from client and server.  Unlike Entity:SetNetworked2Int, floats don't have to be whole numbers.  The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWFloat instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNetworked2Float(key,value) end

-- Sets a networked integer (whole number) value on the entity.  The value can then be accessed with Entity:GetNetworked2Int both from client and server.  See Entity:SetNW2Float for numbers that aren't integers. You should be using Entity:SetNW2Int instead. The value will only be updated clientside if the entity is or enters the clients PVS. The integer has a 32 bit limit. Use Entity:SetNWInt instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNetworked2Int(key,value) end

-- Sets a networked string value on the entity.  The value can then be accessed with Entity:GetNetworked2String both from client and server.  You should be using Entity:SetNW2String instead. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWString instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value string The value to set, up to 511 characters.
function Entity:SetNetworked2String(key,value) end

-- Sets a networked value on the entity.  The value can then be accessed with Entity:GetNetworked2Var both from client and server.  | Allowed Types   | | --------------- | | Angle           | | Boolean         | | Entity          | | Float           | | Int             | | String          | | Vector          | You should be using Entity:SetNW2Var instead. Trying to network a type that is not listed above leads to the value not being networked! Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only ne networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value any The value to set
function Entity:SetNetworked2Var(key,value) end

-- Sets a function to be called when the NW2Var changes. Internally uses GM:EntityNetworkedVarChanged to call the function. Only one NW2VarProxy can be set per-var Running this function clientside will only set it for the client it is called on.
---@param name string The name of the NW2Var to add callback for.
---@param callback function The function to be called when the NW2Var changes. It has 4 arguments: * Entity ent - The entity * string name - Name of the NW2Var that has changed * any oldval - The old value * any newval - The new value
function Entity:SetNetworked2VarProxy(name,callback) end

-- Sets a networked vector value on the entity.  The value can then be accessed with Entity:GetNetworked2Vector both from client and server.  You should be using Entity:SetNW2Vector instead. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWVector instead Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Vector The value to set
function Entity:SetNetworked2Vector(key,value) end

-- You should use Entity:SetNWAngle instead.  Sets a networked angle value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedAngle both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? Angle The value to set
function Entity:SetNetworkedAngle(key,value) end

-- You should use Entity:SetNWBool instead.  Sets a networked boolean value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedBool both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? boolean The value to set
function Entity:SetNetworkedBool(key,value) end

-- You should use Entity:SetNWEntity instead.  Sets a networked entity value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedEntity both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? Entity The value to set
function Entity:SetNetworkedEntity(key,value) end

-- You should use Entity:SetNWFloat instead.  Sets a networked float value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedFloat both from client and server.  Seems to be the same as Entity:GetNetworkedInt.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? number The value to set
function Entity:SetNetworkedFloat(key,value) end

-- You should use Entity:SetNWInt instead.  Sets a networked integer value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedInt both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? number The value to set
function Entity:SetNetworkedInt(key,value) end

-- You should be using Entity:SetNWFloat instead.  Sets a networked number at the specified index on the entity.
---@param index any The index that the value is stored in.
---@param number number The value to network.
function Entity:SetNetworkedNumber(index,number) end

-- You should use Entity:SetNWString instead.  Sets a networked string value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedString both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value string The value to set
function Entity:SetNetworkedString(key,value) end

-- Sets a networked value on the entity.  The value can then be accessed with Entity:GetNetworkedVar both from client and server.  | Allowed Types   | | --------------- | | Angle           | | Boolean         | | Entity          | | Float           | | Int             | | String          | | Vector          |  Trying to network a type that is not listed above leads to the value not being networked! the value will only be updated clientside if the entity is or enters the clients PVS.  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value any The value to set
function Entity:SetNetworkedVar(key,value) end

-- You should be using Entity:SetNWVarProxy instead. Sets callback function to be called when given NWVar changes.
---@param name string The name of the NWVar to add callback for.
---@param callback function The function to be called when the NWVar changes.
function Entity:SetNetworkedVarProxy(name,callback) end

-- You should use Entity:SetNWVector instead.  Sets a networked vector value at specified index on the entity.  The value then can be accessed with Entity:GetNetworkedVector both from client and server.  Running this function clientside will only set it clientside for the client it is called on.
---@param key string The key to associate the value with
---@param value? Vector The value to set
function Entity:SetNetworkedVector(key,value) end

-- Virtually changes entity position for clients. Does the same thing as Entity:SetPos when used serverside.
---@param origin Vector The position to make clients think this entity is at.
function Entity:SetNetworkOrigin(origin) end

-- Sets the next time the clientside ENTITY:Think is called.
---@param nextthink number The next time, relative to Global.CurTime, to execute the ENTITY:Think clientside.
function Entity:SetNextClientThink(nextthink) end

-- Sets if the entity's model should render at all.  If set on the server, this entity will no longer network to clients, and for all intents and purposes cease to exist clientside.
---@param shouldNotDraw boolean true disables drawing
function Entity:SetNoDraw(shouldNotDraw) end

-- Sets whether the entity is solid or not.
---@param IsNotSolid boolean True will make the entity not solid, false will make it solid.
function Entity:SetNotSolid(IsNotSolid) end

-- Sets a networked angle value on the entity.  The value can then be accessed with Entity:GetNW2Angle both from client and server. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWAngle instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Angle The value to set
function Entity:SetNW2Angle(key,value) end

-- Sets a networked boolean value on the entity.  The value can then be accessed with Entity:GetNW2Bool both from client and server. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWBool instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value boolean The value to set
function Entity:SetNW2Bool(key,value) end

-- Sets a networked entity value on the entity.  The value can then be accessed with Entity:GetNW2Entity both from client and server. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWEntity instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Entity The value to set
function Entity:SetNW2Entity(key,value) end

-- Sets a networked float (number) value on the entity.  The value can then be accessed with Entity:GetNW2Float both from client and server.  Unlike Entity:SetNW2Int, floats don't have to be whole numbers. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWFloat instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNW2Float(key,value) end

-- Sets a networked integer (whole number) value on the entity.  The value can then be accessed with Entity:GetNW2Int both from client and server.  See Entity:SetNW2Float for numbers that aren't integers. The value will only be updated clientside if the entity is or enters the clients PVS. The integer has a 32 bit limit. Use Entity:SetNWInt instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNW2Int(key,value) end

-- Sets a networked string value on the entity.  The value can then be accessed with Entity:GetNW2String both from client and server. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWString instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value string The value to set, up to 511 characters.
function Entity:SetNW2String(key,value) end

-- Sets a networked value on the entity.  The value can then be accessed with Entity:GetNW2Var both from client and server.  | Allowed Types   | | --------------- | | Angle           | | Boolean         | | Entity          | | Float           | | Int             | | String          | | Vector          | Trying to network a type that is not listed above leads to the value not being networked! the value will only be updated clientside if the entity is or enters the clients PVS.  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value any The value to set
function Entity:SetNW2Var(key,value) end

-- Sets a function to be called when the NW2Var changes. Internally uses GM:EntityNetworkedVarChanged to call the function. Alias of Entity:SetNetworked2VarProxy Only one NW2VarProxy can be set per-var Running this function will only set it for the realm it is called on.
---@param key any The key of the NW2Var to add callback for.
---@param callback function The function to be called when the NW2Var changes. It has 4 arguments: * Entity ent - The entity * string name - Name of the NW2Var that has changed * any oldval - The old value * any newval - The new value
function Entity:SetNW2VarProxy(key,callback) end

-- Sets a networked vector value on the entity.  The value can then be accessed with Entity:GetNW2Vector both from client and server. The value will only be updated clientside if the entity is or enters the clients PVS. use Entity:SetNWVector instead  Running this function clientside will only set it for the client it is called on. The value will only be networked if it isn't the same as the current value and unlike SetNW* the value will only be networked once and not every 10 seconds.
---@param key string The key to associate the value with
---@param value Vector The value to set
function Entity:SetNW2Vector(key,value) end

-- Sets a networked angle value on the entity.  The value can then be accessed with Entity:GetNWAngle both from client and server. There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Angle. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value Angle The value to set
function Entity:SetNWAngle(key,value) end

-- Sets a networked boolean value on the entity.  The value can then be accessed with Entity:GetNWBool both from client and server. There's a 4096 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Bool. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value boolean The value to set
function Entity:SetNWBool(key,value) end

-- Sets a networked entity value on the entity.  The value can then be accessed with Entity:GetNWEntity both from client and server. There's a 4096 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Entity. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value Entity The value to set
function Entity:SetNWEntity(key,value) end

-- Sets a networked float (number) value on the entity.  The value can then be accessed with Entity:GetNWFloat both from client and server.  Unlike Entity:SetNWInt, floats don't have to be whole numbers. There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Float. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNWFloat(key,value) end

-- Sets a networked integer (whole number) value on the entity.  The value can then be accessed with Entity:GetNWInt both from client and server.  See Entity:SetNWFloat for numbers that aren't integers. There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Int. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on. This function will not round decimal values as it actually networks a float internally.
---@param key string The key to associate the value with
---@param value number The value to set
function Entity:SetNWInt(key,value) end

-- Sets a networked string value on the entity.  The value can then be accessed with Entity:GetNWString both from client and server. There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2String. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value string The value to set, up to 199 characters.
function Entity:SetNWString(key,value) end

-- Only one NWVarProxy can be set per-var Running this function will only set it for the realm it is called on.  Sets a function to be called when the NWVar changes.
---@param key any The key of the NWVar to add callback for.
---@param callback function The function to be called when the NWVar changes. It has 4 arguments: * Entity ent - The entity * string name - Name of the NWVar that has changed * any oldval - The old value * any newval - The new value
function Entity:SetNWVarProxy(key,callback) end

-- Sets a networked vector value on the entity.  The value can then be accessed with Entity:GetNWVector both from client and server. There's a 4095 slots Network limit. If you need more, consider using the net library or Entity:SetNW2Vector. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it for the client it is called on.
---@param key string The key to associate the value with
---@param value Vector The value to set
function Entity:SetNWVector(key,value) end

-- Sets the owner of this entity, disabling all physics interaction with it.  This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.
---@param owner? Entity The entity to be set as owner.
function Entity:SetOwner(owner) end

-- Sets the parent of this entity, making it move with its parent. This will make the child entity non solid, nothing can interact with them, including traces.  This does not work on game.GetWorld. This can cause undefined physics behaviour when used on entities that don't support parenting. See the [Valve developer wiki](https://developer.valvesoftware.com/wiki/Entity_Hierarchy_(parenting)) for more information.
---@param parent? Entity The entity to parent to. Setting this to nil will clear the parent.
---@param attachmentId? number The attachment id to use when parenting, defaults to -1 or whatever the parent had set previously.   You must call Entity:SetMoveType( MOVETYPE_NONE ) on the child for this argument to have any effect!
function Entity:SetParent(parent,attachmentId) end

-- Sets the parent of an entity to another entity with the given physics bone number. Similar to Entity:SetParent, except it is parented to a physbone. This function is useful mainly for ragdolls.  Despite this function being available server side, it doesn't actually do anything server side.
---@param bone number Physics bone number to attach to. Use 0 for objects with only one physics bone. (See Entity:GetPhysicsObjectNum)
function Entity:SetParentPhysNum(bone) end

-- Sets whether or not the given entity is persistent. A persistent entity will be saved on server shutdown and loaded back when the server starts up. Additionally, by default persistent entities cannot be grabbed with the physgun and tools cannot be used on them.  In sandbox, this can be set on an entity by opening the context menu, right clicking the entity, and choosing "Make Persistent".  Persistence can only be enabled with the sbox_persist convar, which works as an identifier for the current set of persistent entities. An empty identifier (which is the default value) disables this feature.
---@param persist boolean Whether or not the entity should be persistent.
function Entity:SetPersistent(persist) end

-- When called on a constraint entity, sets the two physics objects to be constrained.  Usage is not recommended as the Constraint library provides easier ways to deal with constraints.
---@param Phys1 PhysObj The first physics object to be constrained.
---@param Phys2 PhysObj The second physics object to be constrained.
function Entity:SetPhysConstraintObjects(Phys1,Phys2) end

-- Sets the player who gets credit if this entity kills something with physics damage within the time limit.  This can only be called on props, "anim" type SENTs and vehicles.
---@param ent Player Player who gets the kills. Setting this to a non-player entity will not work.
---@param timeLimit? number Time in seconds until the entity forgets its physics attacker and prevents it from getting the kill credit.
function Entity:SetPhysicsAttacker(ent,timeLimit) end

-- Allows you to set how fast an entity's animation will play, with 1.0 being the default speed.
---@param fSpeed number How fast the animation will play.
function Entity:SetPlaybackRate(fSpeed) end

-- Moves the entity to the specified position.  If the new position doesn't take effect right away, you can use Entity:SetupBones to force it to do so. This issue is especially common when trying to render the same entity twice or more in a single frame at different positions.  Entities with Entity:GetSolid of SOLID_BBOX will have their angles reset!  This will fail inside of predicted functions called during player movement processing. This includes WEAPON:PrimaryAttack and WEAPON:Think.  Some entities, such as ragdolls, will appear unaffected by this function in the next frame. Consider PhysObj:SetPos if necessary.
---@param position Vector The position to move the entity to.
function Entity:SetPos(position) end

-- Sets the specified pose parameter to the specified value.  You should call Entity:InvalidateBoneCache after calling this function.  Avoid calling this in draw hooks, especially when animating things, as it might cause visual artifacts.
---@param poseName string Name of the pose parameter. Entity:GetPoseParameterName might come in handy here.
---@param poseValue number The value to set the pose to.
function Entity:SetPoseParameter(poseName,poseValue) end

-- Sets whether an entity should be predictable or not. When an entity is set as predictable, its DT vars can be changed during predicted hooks. This is useful for entities which can be controlled by player input.  Any datatable value that mismatches from the server will be overridden and a prediction error will be spewed.  Weapons are predictable by default, and the drive system uses this function to make the controlled prop predictable as well.  Visit  for a list of all predicted hooks, and the Prediction page. For further technical information on the subject, visit [valve's wiki](https://developer.valvesoftware.com/wiki/Prediction).  This function resets the datatable variables everytime it's called, it should ideally be called when a player starts using the entity and when he stops Entities set as predictable with this function will be unmarked when the user lags and receives a full packet update, to handle such case visit GM:NotifyShouldTransmit
---@param setPredictable boolean whether to make this entity predictable or not.
function Entity:SetPredictable(setPredictable) end

-- Prevents the server from sending any further information about the entity to a player.  You must also call this function on a player's children if you would like to prevent transmission for players. See Entity:GetChildren.  This does not work for nextbots unless you recursively loop their children and update them too.    When using this function, Entity:SetFlexScale will conflict with this function. Instead, consider using Entity:SetFlexScale on the client.
---@param player Player The player to stop networking the entity to.
---@param stopTransmitting boolean true to stop the entity from networking, false to make it network again.
function Entity:SetPreventTransmit(player,stopTransmitting) end

-- Sets the bone angles. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
---@param boneid number Bone ID
---@param pos Angle Angle to set
function Entity:SetRagdollAng(boneid,pos) end

-- Sets the function to build the ragdoll. This is used alongside Kinect, for more info see ragdoll_motion entity.
---@param func function The build function. This function has one argument: * Entity ragdoll - The ragdoll to build
function Entity:SetRagdollBuildFunction(func) end

-- Sets the bone position. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
---@param boneid number Bone ID
---@param pos Vector Position to set
function Entity:SetRagdollPos(boneid,pos) end

-- Sets the render angles of the Entity.
---@param newAngles Angle The new render angles to be set to.
function Entity:SetRenderAngles(newAngles) end

-- Sets the render bounds for the entity. For world space coordinates see Entity:SetRenderBoundsWS.
---@param mins Vector The minimum corner of the bounds, relative to origin of the entity.
---@param maxs Vector The maximum corner of the bounds, relative to origin of the entity.
---@param add? Vector If defined, adds this vector to maxs and subtracts this vector from mins.
function Entity:SetRenderBounds(mins,maxs,add) end

-- Sets the render bounds for the entity in world space coordinates. For relative coordinates see Entity:SetRenderBounds.
---@param mins Vector The minimum corner of the bounds, relative to origin of the world/map.
---@param maxs Vector The maximum corner of the bounds, relative to origin of the world/map.
---@param add? Vector If defined, adds this vector to maxs and subtracts this vector from mins.
function Entity:SetRenderBoundsWS(mins,maxs,add) end

-- Used to specify a plane, past which an object will be visually clipped.
---@param planeNormal Vector The normal of the plane. Anything behind the normal will be clipped.
---@param planePosition number The position of the plane.
function Entity:SetRenderClipPlane(planeNormal,planePosition) end

-- Enables the use of clipping planes to "cut" objects.
---@param enabled boolean Enable or disable clipping planes
function Entity:SetRenderClipPlaneEnabled(enabled) end

-- Sets entity's render FX.
---@param renderFX number The new render FX to set, see Enums/kRenderFx
function Entity:SetRenderFX(renderFX) end

-- Sets the render mode of the entity.
---@param renderMode number New render mode to set, see Enums/RENDERMODE.
function Entity:SetRenderMode(renderMode) end

-- Set the origin in which the Entity will be drawn from.
---@param newOrigin Vector The new origin in world coordinates where the Entity's model will now be rendered from.
function Entity:SetRenderOrigin(newOrigin) end

-- Sets a save value for an entity. You can see a full list of an entity's save values by creating it and printing Entity:GetSaveTable().  See Entity:GetInternalVariable for the opposite of this function.  This does not type-check entity keys. Setting an entity key to a non-entity value will treat it as NULL.
---@param name string Name of the save value to set
---@param value any Value to set
---@return boolean
function Entity:SetSaveValue(name,value) end

-- Sets the entity's model sequence.  If the specified sequence is already active, the animation will not be restarted. See Entity:ResetSequence for a function that restarts the animation even if it is already playing.  In some cases you want to run Entity:ResetSequenceInfo to make this function run.  This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick.  Will not work on players due to the animations being reset every frame by the base gamemode animation system. See GM:CalcMainActivity.  For custom scripted entities you will want to apply example from ENTITY:Think to make animations work.
---@param sequenceId number The sequence to play. Also accepts strings.  If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
function Entity:SetSequence(sequenceId) end

-- Sets whether or not the entity should make a physics contact sound when it's been picked up by a player.
---@param playsound? boolean True to play the pickup sound, false otherwise.
function Entity:SetShouldPlayPickupSound(playsound) end

-- Sets if entity should create a server ragdoll on death or a client one.  Player ragdolls created with this enabled will have an owner set, see Entity:SetOwner for more information on what effects this has.  This is reset for players when they respawn (Entity:Spawn).
---@param serverragdoll boolean Set `true` if ragdoll should be created on server, `false` if on client.
function Entity:SetShouldServerRagdoll(serverragdoll) end

-- Sets the skin of the entity.
---@param skinIndex number 0-based index of the skin to use.
function Entity:SetSkin(skinIndex) end

-- Sets the solidity of an entity.
---@param solid_type number The solid type. See the Enums/SOLID.
function Entity:SetSolid(solid_type) end

-- Sets solid flag(s) for the entity.  This overrides any other flags the entity might have had. See Entity:AddSolidFlags for adding flags.
---@param flags number The flag(s) to set, see Enums/FSOLID.
function Entity:SetSolidFlags(flags) end

-- Sets whether the entity should use a spawn effect when it is created on the client.  See Entity:GetSpawnEffect for more information on how the effect is applied.  This function will only have an effect when the entity spawns. After that it will do nothing even is set to true.
---@param spawnEffect boolean Sets if we should show a spawn effect.
function Entity:SetSpawnEffect(spawnEffect) end

-- Overrides a single material on the model of this entity.  To set a Lua material created with Global.CreateMaterial, just prepend a "!" to the material name.  The server's value takes priority on the client.
---@param index? number Index of the material to override, acceptable values are from 0 to 31.  Indexes are by Entity:GetMaterials, but you have to subtract 1 from them.  If called with no arguments, all sub materials will be reset.
---@param material? string The material to override the default one with. Set to nil to revert to default material.
function Entity:SetSubMaterial(index,material) end

-- Sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.  See also Entity:SetSurroundingBoundsType (mutually exclusive).
---@param min Vector Minimum extent of the AABB relative to entity's position.
---@param max Vector Maximum extent of the AABB relative to entity's position.
function Entity:SetSurroundingBounds(min,max) end

-- Automatically sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.  See also Entity:SetSurroundingBounds (mutually exclusive).
---@param bounds number Bounds type of the entity, see Enums/BOUNDS
function Entity:SetSurroundingBoundsType(bounds) end

--   Changes the table that can be accessed by indexing an entity. Each entity starts with its own table by default.
---@param tab table Table for the entity to use
function Entity:SetTable(tab) end

-- When this flag is set the entity will only transmit to the player when its parent is transmitted. This is useful for things like viewmodel attachments since without this flag they will transmit to everyone (and cause the viewmodels to transmit to everyone too).  In the case of scripted entities, this will override ENTITY:UpdateTransmitState
---@param onoff boolean Will set the TransmitWithParent flag on or off
function Entity:SetTransmitWithParent(onoff) end

-- Marks the entity as a trigger, so it will generate ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch callbacks.  Internally this is stored as Enums/FSOLID flag.
---@param maketrigger boolean Make the entity trigger or not
function Entity:SetTrigger(maketrigger) end

-- Sets whether an entity can be unfrozen, meaning that it cannot be unfrozen using the physgun.
---@param freezable? boolean True to make the entity unfreezable, false otherwise.
function Entity:SetUnFreezable(freezable) end

-- Forces the entity to reconfigure its bones. You might need to call this after changing your model's scales or when manually drawing the entity multiple times at different positions.  This calls the BuildBonePositions callback added via Entity:AddCallback, so avoid calling this function inside it to prevent an infinite loop.
function Entity:SetupBones() end

-- Initializes the class names of an entity's phoneme mappings (mouth movement data). This is called by default with argument "phonemes" when a flex-based entity (such as an NPC) is created.  TF2 phonemes can be accessed by using a path such as "player/scout/phonemes/phonemes" , check TF2's "tf2_misc_dir.vpk" with GCFScape for other paths, however it seems that TF2 sounds don't contain phoneme definitions anymore after being converted to mp3 and only rely on VCD animations, this needs to be further investigated
---@param fileRoot string The file prefix of the phoneme mappings (relative to "garrysmod/expressions/").
function Entity:SetupPhonemeMappings(fileRoot) end

-- Sets the use type of an entity, affecting how often ENTITY:Use will be called for Lua entities.
---@param useType number The use type to apply to the entity. Uses Enums/_USE.
function Entity:SetUseType(useType) end

-- Allows to quickly set variable to entity's Entity:GetTable.  This will not network the variable to client(s). You want Entity:SetNWString and similar functions for that
---@param key any Key of the value to set
---@param value any Value to set the variable to
function Entity:SetVar(key,value) end

-- Sets the entity's velocity. For entities with physics, consider using PhysObj:SetVelocity on the PhysObj of the entity.  Actually binds to CBaseEntity::SetBaseVelocity() which sets the entity's velocity due to forces applied by other entities.  If applied to a player, this will actually **ADD** velocity, not set it.
---@param velocity Vector The new velocity to set.
function Entity:SetVelocity(velocity) end

-- Sets the model and associated weapon to this viewmodel entity.  This is used internally when the player switches weapon.  View models are not drawn without a weapons associated to them. This will silently fail if the entity is not a viewmodel.
---@param viewModel string The model string to give to this viewmodel. Example: "models/weapons/c_smg1.mdl"
---@param weapon? Weapon The weapon entity to associate this viewmodel to.
function Entity:SetWeaponModel(viewModel,weapon) end

-- Returns the amount of skins the entity has.
---@return number
function Entity:SkinCount() end

-- Moves the model instance from the source entity to this entity. This can be used to transfer decals that have been applied on one entity to another.  Both entities must have the same model.
---@param srcEntity Entity Entity to move the model instance from.
---@return boolean
function Entity:SnatchModelInstance(srcEntity) end

-- Initializes the entity and starts its networking. If called on a player, it will respawn them.  This calls ENTITY:Initialize on Lua-defined entities.
function Entity:Spawn() end

-- Starts a "looping" sound. As with any other sound playing methods, this function expects the sound file to be looping itself and will not automatically loop a non looping sound file as one might expect.  This function is almost identical to Global.CreateSound, with the exception of the sound being created in the STATIC channel and with normal attenuation.  See also Entity:StopLoopingSound
---@param sound string Sound to play. Can be either a sound script or a filepath.
---@return number
function Entity:StartLoopingSound(sound) end

-- Starts a motion controller in the physics engine tied to this entity's PhysObj, which enables the use of ENTITY:PhysicsSimulate.  The motion controller can later be destroyed via Entity:StopMotionController.  Motion controllers are used internally to control other Entities' PhysObjects, such as the Gravity Gun, +use pickup and the Physics Gun.  This function should be called every time you recreate the Entity's PhysObj. Or alternatively you should call Entity:AddToMotionController on the new PhysObj.  Also see Entity:AddToMotionController and Entity:RemoveFromMotionController.  Only works on a scripted Entity of anim type.
function Entity:StartMotionController() end

-- Stops all particle effects parented to the entity and immediately destroys them.
function Entity:StopAndDestroyParticles() end

-- Stops a sound created by Entity:StartLoopingSound.
---@param id number The sound ID returned by Entity:StartLoopingSound
function Entity:StopLoopingSound(id) end

-- Stops the motion controller created with Entity:StartMotionController.
function Entity:StopMotionController() end

-- Stops all particle effects parented to the entity.  This is ran automatically on every client by Entity:StopParticles if called on the server.
function Entity:StopParticleEmission() end

-- Stops any attached to the entity .pcf particles using Global.ParticleEffectAttach or Global.ParticleEffect.  On client, this is the same as Entity:StopParticleEmission. ( and you should use StopParticleEmission instead )   On server, this is the same as running Entity:StopParticleEmission on every client.
function Entity:StopParticles() end

-- Stops all particle effects parented to the entity with given name.
---@param name string The name of the particle to stop.
function Entity:StopParticlesNamed(name) end

-- Stops all particle effects parented to the entity with given name on given attachment.
---@param name string The name of the particle to stop.
---@param attachment number The attachment of the entity to stop particles on.
function Entity:StopParticlesWithNameAndAttachment(name,attachment) end

-- Stops emitting the given sound from the entity, especially useful for looping sounds.
---@param sound string The name of the sound script or the filepath to stop playback of.
function Entity:StopSound(sound) end

-- Applies the specified amount of damage to the entity with Enums/DMG flag.  Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops. This function does not seem to do any damage if you apply it to a player who is into a vehicle.
---@param damageAmount number The amount of damage to be applied.
---@param attacker Entity The entity that initiated the attack that caused the damage.
---@param inflictor Entity The entity that applied the damage, eg. a weapon.
function Entity:TakeDamage(damageAmount,attacker,inflictor) end

-- Applies the damage specified by the damage info to the entity.  This function will not deal damage to a player inside a vehicle. You need to call it on the vehicle instead. Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
---@param damageInfo CTakeDamageInfo The damage to apply.
function Entity:TakeDamageInfo(damageInfo) end

-- Applies forces to our physics object in response to damage.
---@param dmginfo CTakeDamageInfo The damageinfo to apply. Only CTakeDamageInfo:GetDamageForce and CTakeDamageInfo:GetDamagePosition are used.
function Entity:TakePhysicsDamage(dmginfo) end

-- Check if the given position or entity is within this entity's PVS.  See also Entity:IsDormant.  The function won't take in to account Global.AddOriginToPVS and the like.
---@param testPoint any Entity or Vector to test against. If an entity is given, this function will test using its bounding box.
---@return boolean
function Entity:TestPVS(testPoint) end

-- Returns the ID of a PhysObj attached to the given bone. To be used with Entity:GetPhysicsObjectNum.  See Entity:TranslatePhysBoneToBone for reverse function.
---@param boneID number The ID of a bone to look up the "physics root" bone of.
---@return number
function Entity:TranslateBoneToPhysBone(boneID) end

-- Returns the boneID of the bone the given PhysObj is attached to.  See Entity:TranslateBoneToPhysBone for reverse function.
---@param physNum number The PhysObj number on the entity
---@return number
function Entity:TranslatePhysBoneToBone(physNum) end

-- Updates positions of bone followers created by Entity:CreateBoneFollowers.  This should be called every tick.  This function only works on `anim` type entities.
function Entity:UpdateBoneFollowers() end

-- Simulates a `+use` action on an entity.
---@param activator Entity The entity that caused this input. This will usually be the player who pressed their use key
---@param caller? Entity The entity responsible for the input. This will typically be the same as `activator` unless some other entity is acting as a proxy
---@param useType? number Use type, see Enums/USE.
---@param value? number Any value.
function Entity:Use(activator,caller,useType,value) end

-- Does nothing on server.  Animations will be handled purely clientside instead of a fixed animtime, enabling interpolation. This does not affect layers and gestures.
function Entity:UseClientSideAnimation() end

-- Enables or disables trigger bounds.  This will give the entity a "trigger box" that extends around its bounding box by boundSize units in X/Y and (boundSize / 2) in +Z (-Z remains the same). The trigger box is world aligned and will work regardless of the object's solidity and collision group.  Valve use trigger boxes for all pickup items. Their bloat size is 24, a surprisingly large figure.  The trigger boxes can be made visible as a light blue box by using the **ent_bbox** console command while looking at the entity. Alternatively a classname or entity index can be used as the first argument.  This requires **developer** to be set to **1**.
---@param enable boolean Enable or disable the bounds.
---@param boundSize? number The distance/size of the trigger bounds.
function Entity:UseTriggerBounds(enable,boundSize) end

-- Returns the index of this view model, it can be used to identify which one of the player's view models this entity is.
---@return number
function Entity:ViewModelIndex() end

-- Returns whether the target/given entity is visible from the this entity.  This is meant to be used only with NPCs.  Differences from a simple trace include: * If target has **FL_NOTARGET**, returns false * If **ai_ignoreplayers** is turned on and target is a player, returns false * Reacts to **ai_LOS_mode**: * * If 1, does a simple trace with **COLLISION_GROUP_NONE** and **MASK_BLOCKLOS** * * If not, does a trace with **MASK_BLOCKLOS_AND_NPCS** ( - **CONTENTS_BLOCKLOS** is target is player ) and a custom LOS filter ( **CTraceFilterLOS** ) * Returns true if hits a vehicle the target is driving
---@param target Entity Entity to check for visibility to.
---@return boolean
function Entity:Visible(target) end

-- Returns true if supplied vector is visible from the entity's line of sight.  This is achieved similarly to a trace.
---@param pos Vector The position to check for visibility
---@return boolean
function Entity:VisibleVec(pos) end

-- Returns an integer that represents how deep in water the entity is. This function will currently work on players only due to the way it is implemented in the engine. If you need to check interaction with water for regular entities you better use util.PointContents.  * **0** - The entity isn't in water.  * **1** - Slightly submerged (at least to the feet).  * **2** - The majority of the entity is submerged (at least to the waist).  * **3** - Completely submerged.
---@return number
function Entity:WaterLevel() end

-- Sets the activity of the entity's active weapon.  This does nothing on the client. Only works for CBaseCombatCharacter entities, which includes players and NPCs.
---@param act number Activity number. See Enums/ACT.
---@param duration number How long the animation should take in seconds.
function Entity:Weapon_SetActivity(act,duration) end

-- Calls and returns WEAPON:TranslateActivity on the weapon the entity ( player or NPC ) carries.  Despite existing on client, it doesn't actually do anything on client.
---@param act number The activity to translate
---@return number
function Entity:Weapon_TranslateActivity(act) end

-- Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box (which is calculated from entity's collision bounds.
---@return Vector
---@return Vector
function Entity:WorldSpaceAABB() end

-- Returns the center of the entity according to its collision model.
---@return Vector
function Entity:WorldSpaceCenter() end

-- Converts a worldspace vector into a vector local to an entity
---@param wpos Vector The world vector
---@return Vector
function Entity:WorldToLocal(wpos) end

-- Converts world angles to local angles ( local to the entity )
---@param ang Angle The world angles
---@return Angle
function Entity:WorldToLocalAngles(ang) end



---@class ENTITY
ENTITY = ENTITY

-- Called to override the preferred carry angles of this object.  This callback is only called for `anim` type entities.
---@param ply Player The player who is holding the object.
---@return Angle
function ENTITY:GetPreferredCarryAngles(ply) end

-- Sets the NPC max yaw speed. Internally sets the `m_fMaxYawSpeed` variable which is polled by the engine.  This is a helper function only available if your SENT is based on `base_ai`
---@param maxyaw number The new max yaw value to set
function ENTITY:SetMaxYawSpeed(maxyaw) end

-- Sets the NPC classification. Internally sets the `m_iClass` variable which is polled by the engine.  This is a helper function only available if your SENT is based on `base_ai`
---@param classification number The Enums/CLASS
function ENTITY:SetNPCClass(classification) end



---@class File
File = File

-- Dumps the file changes to disk and closes the file handle which makes the handle useless.
function File:Close() end

-- Returns whether the File object has reached the end of file or not.
---@return boolean
function File:EndOfFile() end

-- Dumps the file changes to disk and saves the file.
function File:Flush() end

-- Reads the specified amount of chars and returns them as a binary string.
---@param length? number Reads the specified amount of chars. If not set, will read the entire file.
---@return string
function File:Read(length) end

-- Reads one byte of the file and returns whether that byte was not 0.
---@return boolean
function File:ReadBool() end

-- Reads one unsigned 8-bit integer from the file.
---@return number
function File:ReadByte() end

-- Reads an 8-byte little-endian IEEE-754 floating point double from the file.
---@return number
function File:ReadDouble() end

-- Reads an IEEE 754 little-endian 4-byte float from the file.
---@return number
function File:ReadFloat() end

-- Returns the contents of the file from the current position up until the end of the current line.  This function will look specifically for `Line Feed` characters `\n` and will **completely ignore `Carriage Return` characters** `\r`. This function will not return more than 8192 characters. The return value will include the `\n` character.
---@return string
function File:ReadLine() end

-- Reads a signed little-endian 32-bit integer from the file.
---@return number
function File:ReadLong() end

-- Reads a signed little-endian 16-bit integer from the file.
---@return number
function File:ReadShort() end

-- Reads an unsigned little-endian 32-bit integer from the file.
---@return number
function File:ReadULong() end

-- Reads an unsigned little-endian 16-bit integer from the file.
---@return number
function File:ReadUShort() end

-- Sets the file pointer to the specified position.
---@param pos number Pointer position, in bytes.
function File:Seek(pos) end

-- Returns the size of the file in bytes.
---@return number
function File:Size() end

-- Moves the file pointer by the specified amount of chars.
---@param amount number The amount of chars to skip, can be negative to skip backwards.
---@return number
function File:Skip(amount) end

-- Returns the current position of the file pointer.
---@return number
function File:Tell() end

-- Writes the given string into the file.
---@param data string Binary data to write to the file.
function File:Write(data) end

-- Writes a boolean value to the file as one **byte**.
---@param bool boolean The bool to be written to the file.
function File:WriteBool(bool) end

-- Write an 8-bit unsigned integer to the file.
---@param uint8 number The 8-bit unsigned integer to be written to the file.
function File:WriteByte(uint8) end

-- Writes an 8-byte little-endian IEEE-754 floating point double to the file.
---@param double number The double to be written to the file.
function File:WriteDouble(double) end

-- Writes an IEEE 754 little-endian 4-byte float to the file.
---@param float number The float to be written to the file.
function File:WriteFloat(float) end

-- Writes a signed little-endian 32-bit integer to the file.
---@param int32 number The 32-bit signed integer to be written to the file.
function File:WriteLong(int32) end

-- Writes a signed little-endian 16-bit integer to the file.
---@param int16 number The 16-bit signed integer to be written to the file.
function File:WriteShort(int16) end

-- Writes an unsigned little-endian 32-bit integer to the file.
---@param uint32 number The unsigned 32-bit integer to be written to the file.
function File:WriteULong(uint32) end

-- Writes an unsigned little-endian 16-bit integer to the file.
---@param uint16 number The unsigned 16-bit integer to the file.
function File:WriteUShort(uint16) end



---@class IGModAudioChannel
IGModAudioChannel = IGModAudioChannel

-- Enables or disables looping of audio channel, requires noblock flag.
---@param enable boolean Enable or disable looping of this audio channel.
function IGModAudioChannel:EnableLooping(enable) end

-- Computes the [DFT (discrete Fourier transform)](https://en.wikipedia.org/wiki/Discrete_Fourier_transform) of the sound channel.  The size parameter specifies the number of consecutive audio samples to use as the input to the DFT and is restricted to a power of two. A [Hann window](https://en.wikipedia.org/wiki/Hann_function) is applied to the input data.  The computed DFT has the same number of frequency bins as the number of samples. Only half of this DFT is returned, since [the DFT magnitudes are symmetric for real input data](https://en.wikipedia.org/wiki/Discrete_Fourier_transform#The_real-input_DFT). The magnitudes of the DFT (values from 0 to 1) are used to fill the output table, starting at index 1.  **Visualization protip:** For a size N DFT, bin k (1-indexed) corresponds to a frequency of (k - 1) / N * sampleRate.  **Visualization protip:** Sound energy is proportional to the square of the magnitudes. Adding magnitudes together makes no sense physically, but adding energies does.  **Visualization protip:** The human ear works on a logarithmic amplitude scale. You can convert to [decibels](https://en.wikipedia.org/wiki/Decibel) by taking 20 * math.log10 of frequency magnitudes, or 10 * math.log10 of energy. The decibel values will range from -infinity to 0.
---@param tbl table The table to output the DFT magnitudes (numbers between 0 and 1) into. Indices start from 1.
---@param size number The number of samples to use. See Enums/FFT
---@return number
function IGModAudioChannel:FFT(tbl,size) end

-- Returns 3D cone of the sound channel. See IGModAudioChannel:Set3DCone.
---@return number
---@return number
---@return number
function IGModAudioChannel:Get3DCone() end

-- Returns if the sound channel is currently in 3D mode or not. This value will be affected by IGModAudioChannel:Set3DEnabled.
---@return boolean
function IGModAudioChannel:Get3DEnabled() end

-- Returns 3D fade distances of a sound channel.
---@return number
---@return number
function IGModAudioChannel:Get3DFadeDistance() end

-- Returns the average bit rate of the sound channel.
---@return number
function IGModAudioChannel:GetAverageBitRate() end

-- Retrieves the number of bits per sample of the sound channel.  Doesn't work for mp3 and ogg files.
---@return number
function IGModAudioChannel:GetBitsPerSample() end

-- Returns the filename for the sound channel.
---@return string
function IGModAudioChannel:GetFileName() end

-- Returns the length of sound played by the sound channel.
---@return number
function IGModAudioChannel:GetLength() end

-- Returns the right and left levels of sound played by the sound channel.
---@return number
---@return number
function IGModAudioChannel:GetLevel() end

-- Gets the relative volume of the left and right channels.
---@return number
function IGModAudioChannel:GetPan() end

-- Returns the playback rate of the sound channel.
---@return number
function IGModAudioChannel:GetPlaybackRate() end

-- Returns position of the sound channel
---@return Vector
function IGModAudioChannel:GetPos() end

-- Returns the sample rate for currently playing sound.
---@return number
function IGModAudioChannel:GetSamplingRate() end

-- Returns the state of a sound channel
---@return number
function IGModAudioChannel:GetState() end

-- Retrieves HTTP headers from a bass stream channel created by sound.PlayURL, if available.
---@return table
function IGModAudioChannel:GetTagsHTTP() end

-- Retrieves the ID3 version 1 info from a bass channel created by sound.PlayFile or sound.PlayURL, if available.  ID3v2 is not supported.
---@return table
function IGModAudioChannel:GetTagsID3() end

-- Retrieves meta stream info from a bass stream channel created by sound.PlayURL, if available.
---@return string
function IGModAudioChannel:GetTagsMeta() end

-- Retrieves OGG media info tag, from a bass channel created by sound.PlayURL or sound.PlayFile, if available.
---@return table
function IGModAudioChannel:GetTagsOGG() end

-- Retrieves OGG Vendor tag, usually containing the application that created the file, from a bass channel created by sound.PlayURL or sound.PlayFile, if available.
---@return string
function IGModAudioChannel:GetTagsVendor() end

-- Returns the current time of the sound channel in seconds
---@return number
function IGModAudioChannel:GetTime() end

-- Returns volume of a sound channel
---@return number
function IGModAudioChannel:GetVolume() end

-- Returns if the sound channel is in 3D mode or not.
---@return boolean
function IGModAudioChannel:Is3D() end

-- Returns whether the audio stream is block streamed or not.
---@return boolean
function IGModAudioChannel:IsBlockStreamed() end

-- Returns if the sound channel is looping or not.
---@return boolean
function IGModAudioChannel:IsLooping() end

-- Returns if the sound channel is streamed from the Internet or not.
---@return boolean
function IGModAudioChannel:IsOnline() end

-- Returns if the sound channel is valid or not.
---@return boolean
function IGModAudioChannel:IsValid() end

-- Pauses the stream. It can be started again using IGModAudioChannel:Play
function IGModAudioChannel:Pause() end

-- Starts playing the stream.
function IGModAudioChannel:Play() end

-- Sets 3D cone of the sound channel.
---@param innerAngle number The angle of the inside projection cone in degrees.     Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
---@param outerAngle number The angle of the outside projection cone in degrees.     Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
---@param outerVolume number The delta-volume outside the outer projection cone.     Range is from 0 (silent) to 1 (same as inside the cone), less than 0 = leave current.
function IGModAudioChannel:Set3DCone(innerAngle,outerAngle,outerVolume) end

-- Sets the 3D mode of the channel. This will affect IGModAudioChannel:Get3DEnabled but not IGModAudioChannel:Is3D.  This feature **requires** the channel to be initially created in 3D mode, i.e. IGModAudioChannel:Is3D should return true or this function will do nothing.
---@param enable boolean true to enable, false to disable 3D.
function IGModAudioChannel:Set3DEnabled(enable) end

-- Sets 3D fade distances of a sound channel.
---@param min number The minimum distance. The channel's volume is at maximum when the listener is within this distance.     0 or less = leave current.
---@param max number The maximum distance. The channel's volume stops decreasing when the listener is beyond this distance.     0 or less = leave current.
function IGModAudioChannel:Set3DFadeDistance(min,max) end

-- Sets the relative volume of the left and right channels.
---@param pan number Relative volume between the left and right channels. -1 means only in left channel, 0 is center and 1 is only in the right channel.
function IGModAudioChannel:SetPan(pan) end

-- Sets the playback rate of the sound channel. May not work with high values for radio streams.
---@param rate number Playback rate to set to. 1 is normal speed, 0.5 is half the normal speed, etc.
function IGModAudioChannel:SetPlaybackRate(rate) end

-- Sets position of sound channel in case the sound channel has a 3d option set.
---@param pos Vector The position to put the sound into
---@param dir? Vector The direction of the sound
function IGModAudioChannel:SetPos(pos,dir) end

-- Sets the sound channel to specified time ( Rewind to that position of the song ). Does not work on online radio streams.  Streamed sounds must have "noblock" parameter for this to work and IGModAudioChannel:IsBlockStreamed must return false.
---@param secs number The time to set the stream to, in seconds.
---@param dont_decode? boolean Set to true to skip decoding to set time, and instead just seek to it which is faster. Certain streams do not support seeking and have to decode to the given position.
function IGModAudioChannel:SetTime(secs,dont_decode) end

-- Sets the volume of a sound channel
---@param volume number Volume to set. 1 meaning 100% volume, 0.5 is 50% and 3 is 300%, etc.
function IGModAudioChannel:SetVolume(volume) end

-- Stop the stream. It can be started again using IGModAudioChannel:Play.  Calling this invalidates the IGModAudioChannel object rendering it unusable for further functions.
function IGModAudioChannel:Stop() end



---@class IMaterial
IMaterial = IMaterial

-- Returns the color of the specified pixel of the $basetexture, only works for materials created from PNG files.  Basically identical to ITexture:GetColor used on IMaterial:GetTexture( "$basetexture" ).  The returned color will not have the color metatable.
---@param x number The X coordinate.
---@param y number The Y coordinate.
---@return table
function IMaterial:GetColor(x,y) end

-- Returns the specified material value as a float, or nil if the value is not set.
---@param materialFloat string The name of the material value.
---@return number
function IMaterial:GetFloat(materialFloat) end

-- Returns the specified material value as a int, rounds the value if its a float, or nil if the value is not set.  Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly retrieved with this function. See the full list here: Material Flags
---@param materialInt string The name of the material integer.
---@return number
function IMaterial:GetInt(materialInt) end

-- Gets all the key values defined for the material.
---@return table
function IMaterial:GetKeyValues() end

-- Returns the specified material matrix as a int, or nil if the value is not set or is not a matrix.
---@param materialMatrix string The name of the material matrix.
---@return VMatrix
function IMaterial:GetMatrix(materialMatrix) end

-- Returns the name of the material, in most cases the path.
---@return string
function IMaterial:GetName() end

-- Returns the name of the materials shader.  This function does not work serverside on Linux SRCDS.
---@return string
function IMaterial:GetShader() end

-- Returns the specified material string, or nil if the value is not set or if the value can not be converted to a string.
---@param materialString string The name of the material string.
---@return string
function IMaterial:GetString(materialString) end

-- Returns an ITexture based on the passed shader parameter.
---@param param string The [shader parameter](https://developer.valvesoftware.com/wiki/Category:List_of_Shader_Parameters) to retrieve. This should normally be `$basetexture`.
---@return ITexture
function IMaterial:GetTexture(param) end

-- Returns the specified material vector, or nil if the value is not set.  See also IMaterial:GetVectorLinear
---@param materialVector string The name of the material vector.
---@return Vector
function IMaterial:GetVector(materialVector) end

-- Returns the specified material vector as a 4 component vector.
---@param name string The name of the material vector to retrieve.
---@return number
---@return number
---@return number
---@return number
function IMaterial:GetVector4D(name) end

-- Returns the specified material linear color vector, or nil if the value is not set.  See https://en.wikipedia.org/wiki/Gamma_correction  See also IMaterial:GetVector
---@param materialVector string The name of the material vector.
---@return Vector
function IMaterial:GetVectorLinear(materialVector) end

-- Returns the height of the member texture set for $basetexture.
---@return number
function IMaterial:Height() end

-- Returns whenever the material is valid, i.e. whether it was not loaded successfully from disk or not.
---@return boolean
function IMaterial:IsError() end

-- Recomputes the material's snapshot. This needs to be called if you have changed variables on your material and it isn't changing.  Be careful though - this function is slow - so try to call it only when needed!
function IMaterial:Recompute() end

-- Changes the Material into the give Image. This is used by the Background to change the Image.
---@param path string The path to a Image.
function IMaterial:SetDynamicImage(path) end

-- Sets the specified material float to the specified float, does nothing on a type mismatch.
---@param materialFloat string The name of the material float.
---@param float number The new float value.
function IMaterial:SetFloat(materialFloat,float) end

-- Sets the specified material value to the specified int, does nothing on a type mismatch.  Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly set with this function. See the full list here: Material Flags
---@param materialInt string The name of the material int.
---@param int number The new int value.
function IMaterial:SetInt(materialInt,int) end

-- Sets the specified material value to the specified matrix, does nothing on a type mismatch.
---@param materialMatrix string The name of the material int.
---@param matrix VMatrix The new matrix.
function IMaterial:SetMatrix(materialMatrix,matrix) end

-- This function does nothingThe functionality of this function was removed due to the amount of crashes it caused.
---@param shaderName string Name of the shader
function IMaterial:SetShader(shaderName) end

-- Sets the specified material value to the specified string, does nothing on a type mismatch.
---@param materialString string The name of the material string.
---@param string string The new string.
function IMaterial:SetString(materialString,string) end

-- Sets the specified material texture to the specified texture, does nothing on a type mismatch.
---@param materialTexture string The name of the keyvalue on the material to store the texture on.
---@param texture ITexture The new texture. This can also be a string, the name of the new texture.
function IMaterial:SetTexture(materialTexture,texture) end

-- Unsets the value for the specified material value.
---@param materialValueName string The name of the material value to be unset.
function IMaterial:SetUndefined(materialValueName) end

-- Sets the specified material vector to the specified vector, does nothing on a type mismatch.
---@param MaterialVector string The name of the material vector.
---@param vec Vector The new vector.
function IMaterial:SetVector(MaterialVector,vec) end

-- Sets the specified material vector to the specified 4 component vector, does nothing on a type mismatch.
---@param name string The name of the material vector.
---@param x number The x component of the new vector.
---@param y number The y component of the new vector.
---@param z number The z component of the new vector.
---@param w number The w component of the new vector.
function IMaterial:SetVector4D(name,x,y,z,w) end

-- Returns the width of the member texture set for $basetexture.
---@return number
function IMaterial:Width() end



---@class IMesh
IMesh = IMesh

-- Builds the mesh from a table mesh vertexes.  See Global.Mesh and util.GetModelMeshes for examples.
---@param vertexes table A table consisting of Structures/MeshVertexs.
function IMesh:BuildFromTriangles(vertexes) end

-- Deletes the mesh and frees the memory used by it.
function IMesh:Destroy() end

-- Renders the mesh with the active matrix.
function IMesh:Draw() end

-- Returns whether this IMesh is valid or not.
---@return boolean
function IMesh:IsValid() end



---@class IRestore
IRestore = IRestore

-- Ends current data block started with IRestore:StartBlock and returns to the parent block.  To avoid all sorts of errors, you **must** end all blocks you start.
function IRestore:EndBlock() end

-- Reads next bytes from the restore object as an Angle.
---@return Angle
function IRestore:ReadAngle() end

-- Reads next bytes from the restore object as a boolean.
---@return boolean
function IRestore:ReadBool() end

-- Reads next bytes from the restore object as an Entity.
---@return Entity
function IRestore:ReadEntity() end

-- Reads next bytes from the restore object as a floating point number.
---@return number
function IRestore:ReadFloat() end

-- Reads next bytes from the restore object as an integer number.
---@return number
function IRestore:ReadInt() end

-- Reads next bytes from the restore object as a string.
---@return string
function IRestore:ReadString() end

-- Reads next bytes from the restore object as a Vector.
---@return Vector
function IRestore:ReadVector() end

-- Loads next block of data to be read inside current block. Blocks **must** be ended with IRestore:EndBlock.
---@return string
function IRestore:StartBlock() end



---@class ISave
ISave = ISave

-- Ends current data block started with ISave:StartBlock and returns to the parent block.  To avoid all sorts of errors, you **must** end all blocks you start.
function ISave:EndBlock() end

-- Starts a new block of data that you can write to inside current block. Blocks **must** be ended with ISave:EndBlock.
---@param name string Name of the new block. Used for determining which block is which, returned by IRestore:StartBlock during game load.
function ISave:StartBlock(name) end

-- Writes an Angle to the save object.
---@param ang Angle The angle to write.
function ISave:WriteAngle(ang) end

-- Writes a boolean to the save object.
---@param bool boolean The boolean to write.
function ISave:WriteBool(bool) end

-- Writes an Entity to the save object.
---@param ent Entity The entity to write.
function ISave:WriteEntity(ent) end

-- Writes a floating point number to the save object.
---@param float number The floating point number to write.
function ISave:WriteFloat(float) end

-- Writes an integer number to the save object.
---@param int number The integer number to write.
function ISave:WriteInt(int) end

-- Writes a **null terminated** string to the save object.
---@param str string The string to write.
function ISave:WriteString(str) end

-- Writes a Vector to the save object.
---@param vec Vector The vector to write.
function ISave:WriteVector(vec) end



---@class ITexture
ITexture = ITexture

-- Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.
function ITexture:Download() end

-- Returns the color of the specified pixel, only works for textures created from PNG files.  The returned color will not have the color metatable.
---@param x number The X coordinate.
---@param y number The Y coordinate.
---@return table
function ITexture:GetColor(x,y) end

-- Returns the true unmodified height of the texture.
---@return number
function ITexture:GetMappingHeight() end

-- Returns the true unmodified width of the texture.
---@return number
function ITexture:GetMappingWidth() end

-- Returns the name of the texture, in most cases the path.
---@return string
function ITexture:GetName() end

-- Returns the number of animation frames in this texture.
---@return number
function ITexture:GetNumAnimationFrames() end

-- Returns the modified height of the texture, this value may be affected by mipmapping and other factors.
---@return number
function ITexture:Height() end

-- Returns whenever the texture is valid. (i.e. was loaded successfully or not)  The "error" texture is a valid texture, and therefore this function will return false when used on it. Use ITexture:IsErrorTexture, instead.
---@return boolean
function ITexture:IsError() end

-- Returns whenever the texture is the error texture (pink and black checkerboard pattern).
---@return boolean
function ITexture:IsErrorTexture() end

-- Returns the modified width of the texture, this value may be affected by mipmapping and other factors.
---@return number
function ITexture:Width() end



---@class IVideoWriter
IVideoWriter = IVideoWriter

-- Adds the current framebuffer to the video stream.
---@param frameTime number Usually set to what Global.FrameTime is, or simply 1/fps.
---@param downsample boolean If true it will downsample the whole screenspace to the videos width and height, otherwise it will just record from the top left corner to the given width and height and therefor not the whole screen.
function IVideoWriter:AddFrame(frameTime,downsample) end

-- Ends the video recording and dumps it to disk.
function IVideoWriter:Finish() end

-- Returns the height of the video stream.
---@return number
function IVideoWriter:Height() end

-- Sets whether to record sound or not.
---@param record boolean Record.
function IVideoWriter:SetRecordSound(record) end

-- Returns the width of the video stream.
---@return number
function IVideoWriter:Width() end



---@class MarkupObject
MarkupObject = MarkupObject

-- Draws the computed markupobject to the screen. See markup.Parse.
---@param xOffset number The X coordinate on the screen.
---@param yOffset number The Y coordinate on the screen.
---@param xAlign? number The alignment of the x coordinate within the text using Enums/TEXT_ALIGN
---@param yAlign? number The alignment of the y coordinate within the text using Enums/TEXT_ALIGN
---@param alphaoverride? number Sets the alpha of all drawn objects to this value.
---@param textAlign? number The alignment of the text horizontally using Enums/TEXT_ALIGN
function MarkupObject:Draw(xOffset,yOffset,xAlign,yAlign,alphaoverride,textAlign) end

-- Gets computed the height of the markupobject.
---@return number
function MarkupObject:GetHeight() end

-- Gets maximum width for this markup object as defined in markup.Parse.
---@return number
function MarkupObject:GetMaxWidth() end

-- Gets computed the width of the markupobject.
---@return number
function MarkupObject:GetWidth() end

-- Gets computed the width and height of the markupobject.
---@return number
---@return number
function MarkupObject:Size() end



---@class NextBot
NextBot = NextBot

-- Become a ragdoll and remove the entity.
---@param info CTakeDamageInfo Damage info passed from an onkilled event
---@return Entity
function NextBot:BecomeRagdoll(info) end

-- Should only be called in NEXTBOT:BodyUpdate. This sets the `move_x` and `move_y` pose parameters of the bot to fit how they're currently moving, sets the animation speed (Entity:GetPlaybackRate) to suit the ground speed, and calls Entity:FrameAdvance.  This function might cause crashes with some activities.
function NextBot:BodyMoveXY() end

-- Like NextBot:FindSpots but only returns a vector.
---@param type string Either "random", "near", "far"
---@param options table This table should contain the search info.      string type - The type (Only'hiding' for now)  Vector pos - the position to search.  number radius - the radius to search.  number stepup - the highest step to step up.  number stepdown - the highest we can step down without being hurt.
---@return Vector
function NextBot:FindSpot(type,options) end

-- Returns a table of hiding spots.
---@param specs? table This table should contain the search info.      string type - The type (optional, only 'hiding' supported)  Vector pos - the position to search.  number radius - the radius to search.  number stepup - the highest step to step up.  number stepdown - the highest we can step down without being hurt.
---@return table
function NextBot:FindSpots(specs) end

-- Returns the currently running activity
---@return number
function NextBot:GetActivity() end

-- Returns the Field of View of the Nextbot NPC, used for its vision functionality, such as NextBot:IsAbleToSee.
---@return number
function NextBot:GetFOV() end

-- Returns the maximum range the nextbot can see other nextbots/players at. See NextBot:IsAbleToSee.
---@return number
function NextBot:GetMaxVisionRange() end

-- Returns squared distance to an entity or a position.  See also NextBot:GetRangeTo.
---@param to Vector The position to measure distance to. Can be an entity.
---@return number
function NextBot:GetRangeSquaredTo(to) end

-- Returns the distance to an entity or position.  See also NextBot:GetRangeSquaredTo.
---@param to Vector The position to measure distance to. Can be an entity.
---@return number
function NextBot:GetRangeTo(to) end

-- Returns the solid mask for given NextBot.
---@return number
function NextBot:GetSolidMask() end

-- Called from Lua when the NPC is stuck. This should only be called from the behaviour coroutine - so if you want to override this function and do something special that yields - then go for it.  You should always call self.loco:ClearStuck() in this function to reset the stuck status - so it knows it's unstuck. See CLuaLocomotion:ClearStuck.
function NextBot:HandleStuck() end

-- Returns if the Nextbot NPC can see the give entity or not.  Using this function creates the nextbot vision interface which will cause a significant performance hit!
---@param ent Entity The entity to test if we can see
---@param useFOV? number Whether to use the Field of View of the Nextbot
---@return boolean
function NextBot:IsAbleToSee(ent,useFOV) end

-- To be called in the behaviour coroutine only! Will yield until the bot has reached the goal or is stuck
---@param pos Vector The position we want to get to
---@param options table A table containing a bunch of tweakable options.      number lookahead - Minimum look ahead distance.   number tolerance - How close we must be to the goal before it can be considered complete.   boolean draw - Draw the path. Only visible on listen servers and single player.   number maxage - Maximum age of the path before it times out.   number repath - Rebuilds the path after this number of seconds.
---@return string
function NextBot:MoveToPos(pos,options) end

-- To be called in the behaviour coroutine only! Plays an animation sequence and waits for it to end before returning.
---@param name string The sequence name
---@param speed? number Playback Rate of that sequence
function NextBot:PlaySequenceAndWait(name,speed) end

-- Sets the Field of View for the Nextbot NPC, used for its vision functionality, such as NextBot:IsAbleToSee.
---@param fov number The new FOV
function NextBot:SetFOV(fov) end

-- Sets the maximum range the nextbot can see other nextbots/players at. See NextBot:IsAbleToSee.
---@param range number The new vision range to set.
function NextBot:SetMaxVisionRange(range) end

-- Sets the solid mask for given NextBot.  The default solid mask of a NextBot is Enums/MASK.
---@param mask number The new mask, see Enums/CONTENTS and Enums/MASK
function NextBot:SetSolidMask(mask) end

-- Start doing an activity (animation)
---@param activity number One of the Enums/ACT
function NextBot:StartActivity(activity) end



---@class NPC
NPC = NPC

-- Makes the NPC like, hate, feel neutral towards, or fear the entity in question. If you want to setup relationship towards a certain entity `class`, use NPC:AddRelationship.  NPCs do not see NextBots by default. This can be fixed by adding the Enums/FL flag to the NextBot.
---@param target Entity The entity for the relationship to be applied to.
---@param disposition number A Enums/D representing the relationship type.
---@param priority? number How strong the relationship is.
function NPC:AddEntityRelationship(target,disposition,priority) end

-- Changes how an NPC feels towards another NPC.  If you want to setup relationship towards a certain `entity`, use NPC:AddEntityRelationship.  Avoid using this in GM:OnEntityCreated to prevent crashing due to infinite loops. This function may create an entity with given class and delete it immediately after.
---@param relationstring string A string representing how the relationship should be set up. Should be formatted as `"npc_class `Enums/D` numberPriority"`.
function NPC:AddRelationship(relationstring) end

-- Force an NPC to play their Alert sound.
function NPC:AlertSound() end

-- Executes any movement the current sequence may have.
---@param interval number This is a good place to use Entity:GetAnimTimeInterval.
---@param target? Entity
---@return boolean
function NPC:AutoMovement(interval,target) end

-- Adds a capability to the NPC.
---@param capabilities number Capabilities to add, see Enums/CAP.
function NPC:CapabilitiesAdd(capabilities) end

-- Removes all of Capabilities the NPC has.
function NPC:CapabilitiesClear() end

-- Returns the NPC's capabilities along the ones defined on its weapon.
---@return number
function NPC:CapabilitiesGet() end

-- Remove a certain capability.
---@param capabilities number Capabilities to remove, see Enums/CAP
function NPC:CapabilitiesRemove(capabilities) end

-- Returns the NPC class. Do not confuse with Entity:GetClass!
---@return number
function NPC:Classify() end

-- Resets the NPC:GetBlockingEntity.
function NPC:ClearBlockingEntity() end

-- Clears out the specified Enums/COND on this NPC.
---@param condition number The Enums/COND to clear out.
function NPC:ClearCondition(condition) end

-- Clears the Enemy from the NPC's memory, effectively forgetting it until met again with either the NPC vision or with NPC:UpdateEnemyMemory.
---@param enemy? Entity The enemy to mark
function NPC:ClearEnemyMemory(enemy) end

-- Clears the NPC's current expression which can be set with NPC:SetExpression.
function NPC:ClearExpression() end

-- Clears the current NPC goal or target.
function NPC:ClearGoal() end

-- Stops the current schedule that the NPC is doing.
function NPC:ClearSchedule() end

-- Translates condition ID to a string.
---@param cond number The NPCs condition ID, see Enums/COND
---@return string
function NPC:ConditionName(cond) end

-- Returns the way the NPC "feels" about the entity.
---@param ent Entity The entity to get the disposition from.
---@return number
function NPC:Disposition(ent) end

-- Forces the NPC to drop the specified weapon.
---@param weapon? Weapon Weapon to be dropped. If unset, will default to the currently equipped weapon.
---@param target? Vector If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
---@param velocity? Vector If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
function NPC:DropWeapon(weapon,target,velocity) end

-- Makes an NPC exit a scripted sequence, if one is playing.
function NPC:ExitScriptedSequence() end

-- Force an NPC to play its Fear sound.
function NPC:FearSound() end

-- Force an NPC to play its FoundEnemy sound.
function NPC:FoundEnemySound() end

-- Returns the weapon the NPC is currently carrying, or Global_Variables.
---@return Entity
function NPC:GetActiveWeapon() end

-- Returns the NPC's current activity.
---@return number
function NPC:GetActivity() end

-- Returns the aim vector of the NPC. NPC alternative of Player:GetAimVector.
---@return Vector
function NPC:GetAimVector() end

-- Returns the activity to be played when the NPC arrives at its goal
---@return number
function NPC:GetArrivalActivity() end

-- Returns the sequence to be played when the NPC arrives at its goal.
---@return number
function NPC:GetArrivalSequence() end

-- Returns the most dangerous/closest sound hint based on the NPCs location and the types of sounds it can sense.
---@param types number The types of sounds to choose from. See Enums/SOUND
---@return table
function NPC:GetBestSoundHint(types) end

-- Returns the entity blocking the NPC along its path.
---@return Entity
function NPC:GetBlockingEntity() end

-- Returns the NPC's current schedule.
---@return number
function NPC:GetCurrentSchedule() end

-- Returns how proficient (skilled) an NPC is with its current weapon.
---@return number
function NPC:GetCurrentWeaponProficiency() end

-- Gets the NPC's current waypoint position (where NPC is currently moving towards), if any is available.
---@return Vector
function NPC:GetCurWaypointPos() end

-- Returns the entity that this NPC is trying to fight.  This returns nil if the NPC has no enemy. You should use Global.IsValid (which accounts for nil and NULL) on the return to verify validity of the enemy.
---@return NPC
function NPC:GetEnemy() end

-- Returns the first time an NPC's enemy was seen by the NPC.
---@param enemy? Entity The enemy to check.
---@return number
function NPC:GetEnemyFirstTimeSeen(enemy) end

-- Returns the last known position of an NPC's enemy.  Similar to NPC:GetEnemyLastSeenPos, but the known position will be a few seconds ahead of the last seen position.
---@param enemy? Entity The enemy to check.
---@return Vector
function NPC:GetEnemyLastKnownPos(enemy) end

-- Returns the last seen position of an NPC's enemy.  Similar to NPC:GetEnemyLastKnownPos, but the known position will be a few seconds ahead of the last seen position.
---@param enemy? Entity The enemy to check.
---@return Vector
function NPC:GetEnemyLastSeenPos(enemy) end

-- Returns the last time an NPC's enemy was seen by the NPC.
---@param enemy? Entity The enemy to check.
---@return number
function NPC:GetEnemyLastTimeSeen(enemy) end

-- Returns the expression file the NPC is currently playing.
---@return string
function NPC:GetExpression() end

-- Returns NPCs hull type set by NPC:SetHullType.
---@return number
function NPC:GetHullType() end

-- Returns the ideal activity the NPC currently wants to achieve.
---@return number
function NPC:GetIdealActivity() end

-- Returns the ideal move acceleration of the NPC.
---@return number
function NPC:GetIdealMoveAcceleration() end

-- Returns the ideal move speed of the NPC.
---@return number
function NPC:GetIdealMoveSpeed() end

-- Returns all known enemies this NPC has.  See also NPC:GetKnownEnemyCount
---@return table
function NPC:GetKnownEnemies() end

-- Returns known enemy count of this NPC.  See also NPC:GetKnownEnemies
---@return number
function NPC:GetKnownEnemyCount() end

-- Returns Global.CurTime based time since this NPC last received damage from given enemy.
---@param enemy? Entity The enemy to test. Defaults to currently active enemy (NPC:GetEnemy)
---@return number
function NPC:GetLastTimeTookDamageFromEnemy(enemy) end

-- Returns NPCs max view distance. An NPC will not be able to see enemies outside of this distance.
---@return number
function NPC:GetMaxLookDistance() end

-- Returns how far should the NPC look ahead in its route.
---@return number
function NPC:GetMinMoveCheckDist() end

-- Returns how far before the NPC can come to a complete stop.
---@param minResult_? number The minimum value that will be returned by this function.
---@return number
function NPC:GetMinMoveStopDist(minResult_) end

-- Returns the current timestep the internal NPC motor is working on.
---@return number
function NPC:GetMoveInterval() end

-- Returns the NPC's current movement activity.
---@return number
function NPC:GetMovementActivity() end

-- Returns the index of the sequence the NPC uses to move.
---@return number
function NPC:GetMovementSequence() end

-- Returns the current move velocity of the NPC.
---@return Vector
function NPC:GetMoveVelocity() end

-- Returns the NPC's navigation type.
---@return number
function NPC:GetNavType() end

-- Returns the nearest member of the squad the NPC is in.
---@return NPC
function NPC:GetNearestSquadMember() end

-- Gets the NPC's next waypoint position, where NPC will be moving after reaching current waypoint, if any is available.
---@return Vector
function NPC:GetNextWaypointPos() end

-- Returns the NPC's state.
---@return number
function NPC:GetNPCState() end

-- Returns the distance the NPC is from Target Goal.
---@return number
function NPC:GetPathDistanceToGoal() end

-- Returns the amount of time it will take for the NPC to get to its Target Goal.
---@return number
function NPC:GetPathTimeToGoal() end

-- Returns the shooting position of the NPC.  This only works properly when called on an NPC that can hold weapons, otherwise it will return the same value as Entity:GetPos.
---@return Vector
function NPC:GetShootPos() end

-- Returns the current squad name of the NPC.
---@return string
function NPC:GetSquad() end

-- Returns the NPC's current target set by NPC:SetTarget.  This returns nil if the NPC has no target. You should use Global.IsValid (which accounts for nil and NULL) on the return to verify validity of the target.
---@return Entity
function NPC:GetTarget() end

-- Returns the status of the current task.
---@return number
function NPC:GetTaskStatus() end

-- Returns Global.CurTime based time since the enemy was reacquired, meaning it is currently in Line of Sight of the NPC.
---@param enemy? Entity The enemy to test. Defaults to currently active enemy (NPC:GetEnemy)
---@return number
function NPC:GetTimeEnemyLastReacquired(enemy) end

-- Returns a specific weapon the NPC owns.
---@param class string A classname of the weapon to try to get.
---@return Weapon
function NPC:GetWeapon(class) end

-- Returns a table of the NPC's weapons.
---@return table
function NPC:GetWeapons() end

-- Used to give a weapon to an already spawned NPC.
---@param weapon string Class name of the weapon to equip to the NPC.
---@return Weapon
function NPC:Give(weapon) end

-- Returns whether or not the NPC has the given condition.
---@param condition number The condition index, see Enums/COND.
---@return boolean
function NPC:HasCondition(condition) end

-- Polls the enemy memory to check if the given entity has eluded us or not.
---@param enemy? Entity The enemy to test.
---@return boolean
function NPC:HasEnemyEluded(enemy) end

-- Polls the enemy memory to check if the NPC has any memory of given enemy.
---@param enemy? Entity The entity to test.
---@return boolean
function NPC:HasEnemyMemory(enemy) end

-- Returns true if the current navigation has a obstacle, this is different from NPC:GetBlockingEntity, this includes obstacles that it can steer around.
---@return boolean
function NPC:HasObstacles() end

-- Force an NPC to play their Idle sound.
function NPC:IdleSound() end

-- Makes the NPC ignore given entity/enemy until given time.
---@param enemy Entity The enemy to ignore.
---@param untilVal number How long to ignore the enemy for. This will be compared to Global.CurTime, so your value should be based on it.
function NPC:IgnoreEnemyUntil(enemy,untilVal) end

-- Returns whether or not the NPC is performing the given schedule.
---@param schedule number The schedule number, see Enums/SCHED.
---@return boolean
function NPC:IsCurrentSchedule(schedule) end

-- Returns whether the NPC has an active goal.
---@return boolean
function NPC:IsGoalActive() end

-- Returns if the current movement is locked on the Yaw axis.
---@return boolean
function NPC:IsMoveYawLocked() end

-- Returns whether the NPC is moving or not.
---@return boolean
function NPC:IsMoving() end

-- Checks if the NPC is running an **ai_goal**. ( e.g. An npc_citizen NPC following the Player. )
---@return boolean
function NPC:IsRunningBehavior() end

-- Returns whether the current NPC is the leader of the squad it is in.
---@return boolean
function NPC:IsSquadLeader() end

-- Returns true if the entity was remembered as unreachable. The memory is updated automatically from following engine tasks if they failed: * TASK_GET_CHASE_PATH_TO_ENEMY * TASK_GET_PATH_TO_ENEMY_LKP * TASK_GET_PATH_TO_INTERACTION_PARTNER * TASK_ANTLIONGUARD_GET_CHASE_PATH_ENEMY_TOLERANCE * SCHED_FAIL_ESTABLISH_LINE_OF_FIRE - Combine NPCs, also when failing to change their enemy
---@param testEntity Entity The entity to test.
---@return boolean
function NPC:IsUnreachable(testEntity) end

-- Force an NPC to play their LostEnemy sound.
function NPC:LostEnemySound() end

-- Tries to achieve our ideal animation state, playing any transition sequences that we need to play to get there.
function NPC:MaintainActivity() end

-- Causes the NPC to temporarily forget the current enemy and switch on to a better one.
---@param enemy? Entity The enemy to mark
function NPC:MarkEnemyAsEluded(enemy) end

-- Marks the NPC as took damage from given entity.  See also NPC:GetLastTimeTookDamageFromEnemy.
---@param enemy? Entity The enemy to mark. Defaults to currently active enemy (NPC:GetEnemy)
function NPC:MarkTookDamageFromEnemy(enemy) end

-- Executes a climb move.  Related functions are NPC:MoveClimbStart and NPC:MoveClimbStop.
---@param destination Vector The destination of the climb.
---@param dir Vector The direction of the climb.
---@param distance number The distance.
---@param yaw number The yaw angle.
---@param left number Amount of climb nodes left?
---@return number
function NPC:MoveClimbExec(destination,dir,distance,yaw,left) end

-- Starts a climb move.  Related functions are NPC:MoveClimbExec and NPC:MoveClimbStop.
---@param destination Vector The destination of the climb.
---@param dir Vector The direction of the climb.
---@param distance number The distance.
---@param yaw number The yaw angle.
function NPC:MoveClimbStart(destination,dir,distance,yaw) end

-- Stops a climb move.  Related functions are NPC:MoveClimbExec and NPC:MoveClimbStart.
function NPC:MoveClimbStop() end

-- Executes a jump move.  Related functions are NPC:MoveJumpStart and NPC:MoveJumpStop.
---@return number
function NPC:MoveJumpExec() end

-- Starts a jump move.  Related functions are NPC:MoveJumpExec and NPC:MoveJumpStop.
---@param vel Vector The jump velocity.
function NPC:MoveJumpStart(vel) end

-- Stops a jump move.  Related functions are NPC:MoveJumpExec and NPC:MoveJumpStart.
---@return number
function NPC:MoveJumpStop() end

-- Makes the NPC walk toward the given position. The NPC will return to the player after amount of time set by **player_squad_autosummon_time** ConVar.  Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.  The NPC **must** be in the player's squad for this to work.
---@param position Vector The target position for the NPC to walk to.
function NPC:MoveOrder(position) end

-- Pauses the NPC movement?  Related functions are NPC:MoveStart, NPC:MoveStop and NPC:ResetMoveCalc.
function NPC:MovePause() end

-- Starts NPC movement?  Related functions are NPC:MoveStop, NPC:MovePause and NPC:ResetMoveCalc.
function NPC:MoveStart() end

-- Stops the NPC movement?  Related functions are NPC:MoveStart, NPC:MovePause and NPC:ResetMoveCalc.
function NPC:MoveStop() end

-- Works similarly to NPC:NavSetRandomGoal.
---@param pos Vector The origin to calculate a path from.
---@param length number The target length of the path to calculate.
---@param dir Vector The direction in which to look for a new path end goal.
---@return boolean
function NPC:NavSetGoal(pos,length,dir) end

-- Creates a path to closest node at given position. This won't actually force the NPC to move.   See also NPC:NavSetRandomGoal.
---@param pos Vector The position to calculate a path to.
---@return boolean
function NPC:NavSetGoalPos(pos) end

-- Set the goal target for an NPC.
---@param target Entity The targeted entity to set the goal to.
---@param offset? Vector The offset to apply to the targeted entity's position.
---@return boolean
function NPC:NavSetGoalTarget(target,offset) end

-- Creates a random path of specified minimum length between a closest start node and random node in the specified direction. This won't actually force the NPC to move.
---@param minPathLength number Minimum length of path in units
---@param dir Vector Unit vector pointing in the direction of the target random node
---@return boolean
function NPC:NavSetRandomGoal(minPathLength,dir) end

-- Sets a goal in x, y offsets for the NPC to wander to
---@param xOffset number X offset
---@param yOffset number Y offset
---@return boolean
function NPC:NavSetWanderGoal(xOffset,yOffset) end

-- Forces the NPC to pickup an existing weapon entity. The NPC will not pick up the weapon if they already own a weapon of given type, or if the NPC could not normally have this weapon in their inventory.
---@param wep Weapon The weapon to try to pick up.
---@return boolean
function NPC:PickupWeapon(wep) end

-- Forces the NPC to play a sentence from scripts/sentences.txt
---@param sentence string The sentence string to speak.
---@param delay number Delay in seconds until the sentence starts playing.
---@param volume number The volume of the sentence, from 0 to 1.
---@return number
function NPC:PlaySentence(sentence,delay,volume) end

-- Makes the NPC remember an entity or an enemy as unreachable, for a specified amount of time. Use NPC:IsUnreachable to check if an entity is still unreachable.
---@param ent Entity The entity to mark as unreachable.
---@param time? number For how long to remember the entity as unreachable. Negative values will act as `3` seconds.
function NPC:RememberUnreachable(ent,time) end

--   This function crashes the game no matter how it is used and will be removed in a future update.  Use NPC:ClearEnemyMemory instead.
function NPC:RemoveMemory() end

-- Resets the ideal activity of the NPC. See also NPC:SetIdealActivity.
---@param act number The new activity. See Enums/ACT.
function NPC:ResetIdealActivity(act) end

-- Resets all the movement calculations.  Related functions are NPC:MoveStart, NPC:MovePause and NPC:MoveStop.
function NPC:ResetMoveCalc() end

-- Starts an engine task.  Used internally by the ai_task.
---@param taskID number The task ID, see [ai_task.h](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/ai_task.h#L89-L502)
---@param taskData number The task data.
function NPC:RunEngineTask(taskID,taskData) end

-- Forces the NPC to switch to a specific weapon the NPC owns. See NPC:GetWeapons.
---@param class string A classname of the weapon or a Weapon entity to switch to.
function NPC:SelectWeapon(class) end

-- Stops any sounds (speech) the NPC is currently palying.  Equivalent to `Entity:EmitSound( "AI_BaseNPC.SentenceStop" )`
function NPC:SentenceStop() end

-- Sets the NPC's current activity.
---@param act number The new activity to set, see Enums/ACT.
function NPC:SetActivity(act) end

---@param act number See Enums/ACT.
function NPC:SetArrivalActivity(act) end

---@param dir Vector
function NPC:SetArrivalDirection(dir) end

-- Sets the distance to goal at which the NPC should stop moving and continue to other business such as doing the rest of their tasks in a schedule.
---@param dist number The distance to goal that is close enough for the NPC
function NPC:SetArrivalDistance(dist) end

---@param seq number See Entity:LookupSequence.
function NPC:SetArrivalSequence(seq) end

-- Sets the arrival speed? of the NPC
---@param speed number The new arrival speed
function NPC:SetArrivalSpeed(speed) end

-- Sets an NPC condition.
---@param condition number The condition index, see Enums/COND.
function NPC:SetCondition(condition) end

-- Sets the weapon proficiency of an NPC (how skilled an NPC is with its current weapon).
---@param proficiency number The proficiency for the NPC's current weapon. See Enums/WEAPON_PROFICIENCY.
function NPC:SetCurrentWeaponProficiency(proficiency) end

-- Sets the target for an NPC.
---@param enemy Entity The enemy that the NPC should target
---@param newenemy? boolean Calls NPC:SetCondition(COND_NEW_ENEMY) if the new enemy is valid and not equal to the last enemy.
function NPC:SetEnemy(enemy,newenemy) end

-- Sets the NPC's .vcd expression. Similar to Entity:PlayScene except the scene is looped until it's interrupted by default NPC behavior or NPC:ClearExpression.
---@param expression string The expression filepath.
---@return number
function NPC:SetExpression(expression) end

-- Updates the NPC's hull and physics hull in order to match its model scale. Entity:SetModelScale seems to take care of this regardless.
function NPC:SetHullSizeNormal() end

-- Sets the hull type for the NPC.
---@param hullType number Hull type. See Enums/HULL
function NPC:SetHullType(hullType) end

-- Sets the ideal activity the NPC currently wants to achieve. This is most useful for custom SNPCs.
---@param var number The ideal activity to set. Enums/ACT.
function NPC:SetIdealActivity(var) end

-- Sets the ideal yaw angle (left-right rotation) for the NPC and forces them to turn to that angle.
---@param angle number The aim direction to set, the `yaw` component.
---@param speed? number The turn speed. Special values are: * `-1` - Calculate automatically * `-2` - Keep the previous yaw speed
function NPC:SetIdealYawAndUpdate(angle,speed) end

-- Sets the last registered or memorized position for an npc. When using scheduling, the NPC will focus on navigating to the last position via nodes.  The navigation requires ground nodes to function properly, otherwise the NPC could only navigate in a small area. (https://developer.valvesoftware.com/wiki/Info_node)
---@param Position Vector Where the NPC's last position will be set.
function NPC:SetLastPosition(Position) end

-- Sets NPC's max view distance. An NPC will not be able to see enemies outside of this distance.
---@param dist number New maximum distance the NPC can see at. Default is 2048 and 6000 for long range NPCs such as the sniper.
function NPC:SetMaxLookDistance(dist) end

-- Sets how long to try rebuilding path before failing task.
---@param time number How long to try rebuilding path before failing task
function NPC:SetMaxRouteRebuildTime(time) end

-- Sets the timestep the internal NPC motor is working on.
---@param time number The new timestep.
function NPC:SetMoveInterval(time) end

-- Sets the activity the NPC uses when it moves.
---@param activity number The movement activity, see Enums/ACT.
function NPC:SetMovementActivity(activity) end

-- Sets the sequence the NPC navigation path uses for speed calculation. Doesn't seem to have any visible effect on NPC movement.
---@param sequenceId number The movement sequence index
function NPC:SetMovementSequence(sequenceId) end

-- Sets the move velocity of the NPC
---@param vel Vector The new movement velocity.
function NPC:SetMoveVelocity(vel) end

-- Sets whether the current movement should locked on the Yaw axis or not.
---@param lock boolean Whether the movement should yaw locked or not.
function NPC:SetMoveYawLocked(lock) end

-- Sets the navigation type of the NPC.
---@param navtype number The new nav type. See Enums/NAV.
function NPC:SetNavType(navtype) end

-- Sets the state the NPC is in to help it decide on a ideal schedule.
---@param state number New NPC state, see Enums/NPC_STATE
function NPC:SetNPCState(state) end

-- Sets the NPC's current schedule.
---@param schedule number The NPC schedule, see Enums/SCHED.
function NPC:SetSchedule(schedule) end

-- Assigns the NPC to a new squad. A squad can have up to 16 NPCs. NPCs in a single squad should be friendly to each other.
---@param name string The new squad name to set.
function NPC:SetSquad(name) end

-- Sets the NPC's target. This is used in some engine schedules.
---@param entity Entity The target of the NPC.
function NPC:SetTarget(entity) end

-- Sets the status of the current task.
---@param status number The status. See Enums/TASKSTATUS.
function NPC:SetTaskStatus(status) end

-- Forces the NPC to start an engine task, this has different results for every NPC.
---@param task number The id of the task to start, see [ai_task.h](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/ai_task.h#L89-L502)
---@param taskData number The task data as a float, not all tasks make use of it.
function NPC:StartEngineTask(task,taskData) end

-- Resets the NPC's movement animation and velocity. Does not actually stop the NPC from moving.
function NPC:StopMoving() end

-- Cancels NPC:MoveOrder basically.  Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.  The NPC **must** be in the player's squad for this to work.
---@param target Entity Must be a player, does nothing otherwise.
function NPC:TargetOrder(target) end

-- Marks the current NPC task as completed.  This is meant to be used alongside NPC:TaskFail to complete or fail custom Lua defined tasks. (Schedule:AddTask)
function NPC:TaskComplete() end

-- Marks the current NPC task as failed.  This is meant to be used alongside NPC:TaskComplete to complete or fail custom Lua defined tasks. (Schedule:AddTask)
---@param task string A string most likely defined as a Source Task, for more information on Tasks go to https://developer.valvesoftware.com/wiki/Task
function NPC:TaskFail(task) end

-- Force the NPC to update information on the supplied enemy, as if it had line of sight to it.
---@param enemy Entity The enemy to update.
---@param pos Vector The last known position of the enemy.
function NPC:UpdateEnemyMemory(enemy,pos) end

-- Updates the turn activity. Basically applies the turn animations depending on the current turn yaw.
function NPC:UpdateTurnActivity() end

-- Only usable on "ai" base entities.
---@return boolean
function NPC:UseActBusyBehavior() end

---@return boolean
function NPC:UseAssaultBehavior() end

-- Only usable on "ai" base entities.
---@return boolean
function NPC:UseFollowBehavior() end

---@return boolean
function NPC:UseFuncTankBehavior() end

---@return boolean
function NPC:UseLeadBehavior() end

-- Undoes the other Use*Behavior functions.  Only usable on "ai" base entities.
function NPC:UseNoBehavior() end



---@class Panel
Panel = Panel

-- Set to true by the dragndrop system when the panel is being drawn for the drag'n'drop.
---@return boolean
function Panel:PaintingDragging() end

-- Adds the specified object to the panel.
---@param object Panel The panel to be added (parented). Can also be: * string Class Name - creates panel with the specified name and adds it to the panel. * table PANEL table - creates a panel from table and adds it to the panel.
---@return Panel
function Panel:Add(object) end

-- Does nothing This function does nothing.
function Panel:AddText() end

-- Aligns the panel on the bottom of its parent with the specified offset.
---@param offset? number The align offset.
function Panel:AlignBottom(offset) end

-- Aligns the panel on the left of its parent with the specified offset.
---@param offset? number The align offset.
function Panel:AlignLeft(offset) end

-- Aligns the panel on the right of its parent with the specified offset.
---@param offset? number The align offset.
function Panel:AlignRight(offset) end

-- Aligns the panel on the top of its parent with the specified offset.
---@param offset? number The align offset.
function Panel:AlignTop(offset) end

-- Uses animation to transition the current alpha value of a panel to a new alpha, over a set period of time and after a specified delay.
---@param alpha number The alpha value (0-255) to approach.
---@param duration number The time in seconds it should take to reach the alpha.
---@param delay? number The delay before the animation starts.
---@param callback function The function to be called once the animation finishes. Arguments are: * table animData - The AnimationData that was used. See Structures/AnimationData * Panel pnl - The panel object whose alpha was changed.
function Panel:AlphaTo(alpha,duration,delay,callback) end

--  Performs the per-frame operations required for panel animations.  This is called every frame by PANEL:AnimationThink.
function Panel:AnimationThinkInternal() end

-- Returns the Global.SysTime value when all animations for this panel object will end.
---@return number
function Panel:AnimTail() end

-- Appends text to a RichText element. This does not automatically add a new line.
---@param txt string The text to append (add on).
function Panel:AppendText(txt) end

-- Used by Panel:LoadGWENFile and Panel:LoadGWENString to apply a GWEN controls table to a panel object.  You can do this manually using file.Read and util.JSONToTable to import and create a GWEN table structure from a `.gwen` file. This method can then be called, passing the GWEN table's `Controls` member.
---@param GWENTable table The GWEN controls table to apply to the panel.
function Panel:ApplyGWEN(GWENTable) end

-- Centers the panel on its parent.
function Panel:Center() end

-- Centers the panel horizontally with specified fraction.
---@param fraction? number The center fraction.
function Panel:CenterHorizontal(fraction) end

-- Centers the panel vertically with specified fraction.
---@param fraction? number The center fraction.
function Panel:CenterVertical(fraction) end

-- Returns the amount of children of the of panel.
---@return number
function Panel:ChildCount() end

-- Returns the width and height of the space between the position of the panel (upper-left corner) and the max bound of the children panels (farthest reaching lower-right corner).
---@return number
---@return number
function Panel:ChildrenSize() end

-- Marks all of the panel's children for deletion.
function Panel:Clear() end

-- Fades panels color to specified one. It won't work unless panel has SetColor function.
---@param color table The color to fade to
---@param length number Length of the animation
---@param delay number Delay before start fading
---@param callback function Function to execute when finished
function Panel:ColorTo(color,length,delay,callback) end

-- Sends an action command signal to the panel. The response is handled by PANEL:ActionSignal.
---@param command string The command to send to the panel.
function Panel:Command(command) end

-- Updates a panel object's associated console variable. This must first be set up with Global.Derma_Install_Convar_Functions, and have a ConVar set using Panel:SetConVar.
---@param newValue string The new value to set the associated console variable to.
function Panel:ConVarChanged(newValue) end

-- A think hook for Panels using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.  This function is best for: checkboxes, sliders, number wangs  For a string alternative, see Panel:ConVarStringThink.  Make sure your Panel has a SetValue function, else you may get errors.
function Panel:ConVarNumberThink() end

-- A think hook for Panel using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.  This function is best for: text inputs, read-only inputs, dropdown selects  For a number alternative, see Panel:ConVarNumberThink.  Make sure your Panel has a SetValue function, else you may get errors.
function Panel:ConVarStringThink() end

-- Gets the size, position and dock state of the passed panel object, and applies it to this one.
---@param srcPanel Panel The panel to copy the boundary and dock settings from.
function Panel:CopyBase(srcPanel) end

-- Copies position and size of the panel.
---@param base Panel The panel to copy size and position from.
function Panel:CopyBounds(base) end

-- Copies the height of the panel.
---@param base Panel Panel to copy the height from.
function Panel:CopyHeight(base) end

-- Copies the position of the panel.
---@param base Panel Panel to position the width from.
function Panel:CopyPos(base) end

-- Performs the CONTROL + C key combination effect ( Copy selection to clipboard ) on selected text in a TextEntry or RichText based element.
function Panel:CopySelected() end

-- Copies the width of the panel.
---@param base Panel Panel to copy the width from.
function Panel:CopyWidth(base) end

-- Returns the cursor position relative to the top left of the panel.  This is equivalent to calling gui.MousePos and then Panel:ScreenToLocal.  This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass.  ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
---@return number
---@return number
function Panel:CursorPos() end

-- Performs the CONTROL + X (delete text and copy it to clipboard buffer) action on selected text in a TextEntry or RichText based element.
function Panel:CutSelected() end

-- Deletes a cookie value using the panel's cookie name ( Panel:GetCookieName ) and the passed extension.
---@param cookieName string The unique cookie name to delete.
function Panel:DeleteCookie(cookieName) end

-- Resets the panel object's Panel:SetPos method and removes its animation table (`Panel.LerpAnim`). This effectively undoes the changes made by Panel:LerpPositions.  In order to use Lerp animation again, you must call Panel:Stop before setting its `SetPosReal` property to `nil`. See the example below.
function Panel:DisableLerp() end

-- Returns the linear distance from the center of this panel object and another. **Both panels must have the same parent for this function to work properly.**
---@param tgtPanel Panel The target object with which to compare position.
---@return number
function Panel:Distance(tgtPanel) end

-- Returns the distance between the center of this panel object and a specified point **local to the parent panel**.
---@param posX number The horizontal (x) position in pixels of the point to compare with. Local to the parent panel, or container, not the panel the function is called on.
---@param posY number The vertical (y) position in pixels of the point to compare with. Local to the parent panel, or container, not the panel the function is called on.
---@return number
function Panel:DistanceFrom(posX,posY) end

-- Sets the dock type for the panel, making the panel "dock" in a certain direction, modifying it's position and size.  You can set the inner spacing of a panel's docking using Panel:DockPadding, which will affect docked child panels, and you can set the outer spacing of a panel's docking using Panel:DockMargin, which affects how docked siblings are positioned/sized.  You may need to use Panel:SetZPos to ensure child panels (DTextEntry) stay in a specific order.  After using this function, if you want to get the correct panel's bounds (position, size), use Panel:InvalidateParent (use `true` as argument if you need to update immediately)
---@param dockType number Dock type using Enums/DOCK.
function Panel:Dock(dockType) end

-- Sets the dock margin of the panel.  The dock margin is the extra space that will be left around the edge when this element is docked inside its parent element.
---@param marginLeft number The left margin to the parent.
---@param marginTop number The top margin to the parent.
---@param marginRight number The right margin to the parent.
---@param marginBottom number The bottom margin to the parent.
function Panel:DockMargin(marginLeft,marginTop,marginRight,marginBottom) end

-- Sets the dock padding of the panel.  The dock padding is the extra space that will be left around the edge when child elements are docked inside this element.
---@param paddingLeft number The left padding to the parent.
---@param paddingTop number The top padding to the parent.
---@param paddingRight number The right padding to the parent.
---@param paddingBottom number The bottom padding to the parent.
function Panel:DockPadding(paddingLeft,paddingTop,paddingRight,paddingBottom) end

-- Makes the panel "lock" the screen until it is removed. All input will be directed to the given panel.  It will silently fail if used while cursor is not visible. Call Panel:MakePopup before calling this function. This must be called on a panel derived from EditablePanel.
function Panel:DoModal() end

--  Called by Panel:DragMouseRelease when a user clicks one mouse button whilst dragging with another.
---@return boolean
function Panel:DragClick() end

--  Called by dragndrop.HoverThink to perform actions on an object that is dragged and hovered over another.
---@param HoverTime number If this time is greater than 0.1, PANEL:DragHoverClick is called, passing it as an argument.
function Panel:DragHover(HoverTime) end

--  Called to end a drag and hover action. This resets the panel's PANEL:PaintOver method, and is primarily used by dragndrop.StopDragging.
function Panel:DragHoverEnd() end

-- Called to inform the dragndrop that a mouse button is being held down on a panel object.
---@param mouseCode number The code for the mouse button pressed, passed by, for example, PANEL:OnMousePressed. See the Enums/MOUSE.
function Panel:DragMousePress(mouseCode) end

-- Called to inform the dragndrop that a mouse button has been depressed on a panel object.
---@param mouseCode number The code for the mouse button pressed, passed by, for example, PANEL:OnMouseReleased. See the Enums/MOUSE.
---@return boolean
function Panel:DragMouseRelease(mouseCode) end

--  Called to draw the drop target when an object is being dragged across another. See Panel:SetDropTarget.
---@param x number The x coordinate of the top-left corner of the drop area.
---@param y number The y coordinate of the top-left corner of the drop area.
---@param width number The width of the drop area.
---@param height number The height of the drop area.
function Panel:DrawDragHover(x,y,width,height) end

-- Draws a coloured rectangle to fill the panel object this method is called on. The colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawRect.
function Panel:DrawFilledRect() end

-- Draws a hollow rectangle the size of the panel object this method is called on, with a border width of 1 px. The border colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawOutlinedRect.
function Panel:DrawOutlinedRect() end

-- Used to draw the magenta highlight colour of a panel object when it is selected. This should be called in the object's PANEL:PaintOver hook. Once this is implemented, the highlight colour will be displayed only when the object is selectable and selected. This is achieved using Panel:SetSelectable and Panel:SetSelected respectively.
function Panel:DrawSelections() end

-- Used to draw the text in a DTextEntry within a derma skin. This should be called within the SKIN:PaintTextEntry skin hook. Will silently fail if any of arguments are not Color.
---@param textCol table The colour of the main text.
---@param highlightCol table The colour of the selection highlight (when selecting text).
---@param cursorCol table The colour of the text cursor (or caret).
function Panel:DrawTextEntryText(textCol,highlightCol,cursorCol) end

-- Draws a textured rectangle to fill the panel object this method is called on. The texture is set using surface.SetTexture or surface.SetMaterial. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawTexturedRect.
function Panel:DrawTexturedRect() end

-- Makes this panel droppable. This is used with Panel:Receiver to create drag and drop events.  Can be called multiple times with different names allowing to be dropped onto different receivers.
---@param name string Name of your droppable panel
---@return table
function Panel:Droppable(name) end

-- Completes a box selection. If the end point of the selection box is within the selection canvas, mouse capture is disabled for the panel object, and the selected state of each child object within the selection box is toggled.
---@return boolean
function Panel:EndBoxSelection() end

--  Used to run commands within a DHTML window.
---@param cmd string The command to be run.
function Panel:Exec(cmd) end

-- Finds a panel in its children(and sub children) with the given name.
---@param panelName string The name of the panel that should be found.
---@return Panel
function Panel:Find(panelName) end

-- Focuses the next panel in the focus queue.
function Panel:FocusNext() end

-- Focuses the previous panel in the focus queue.
function Panel:FocusPrevious() end

-- Returns the alpha multiplier for this panel.
---@return number
function Panel:GetAlpha() end

-- Returns the background color of a panel such as a RichText, Label or DColorCube.  This doesn't apply to all VGUI elements and its function varies between them
---@return number
function Panel:GetBGColor() end

-- Returns the position and size of the panel.  This is equivalent to calling Panel:GetPos and Panel:GetSize together.
---@return number
---@return number
---@return number
---@return number
function Panel:GetBounds() end

-- Returns the position/offset of the caret (or text cursor) in a text-based panel object.
---@return number
function Panel:GetCaretPos() end

-- Gets a child by its index. For use with Panel:ChildCount.
---@param childIndex number The index of the child to get.  This index starts at 0, except when you use this on a DMenu.
function Panel:GetChild(childIndex) end

-- Gets a child object's position relative to this panel object. The number of levels is not relevant; the child may have many parents between itself and the object on which the method is called.
---@param pnl Panel The panel to get the position of.
---@return number
---@return number
function Panel:GetChildPosition(pnl) end

-- Returns a table with all the child panels of the panel.
---@return table
function Panel:GetChildren() end

-- Returns a table of all visible, selectable children of the panel object that lie at least partially within the specified rectangle.
---@param x number The horizontal (x) position of the top-left corner of the rectangle, relative to the panel object.
---@param y number The vertical (y) position of the top-left corner of the rectangle, relative to the panel object.
---@param w number The width of the rectangle.
---@param h number The height of the rectangle.
---@return table
function Panel:GetChildrenInRect(x,y,w,h) end

-- Returns the class name of the panel.
---@return string
function Panel:GetClassName() end

-- Returns the child of this panel object that is closest to the specified point. The point is relative to the object on which the method is called. The distance the child is from this point is also returned.
---@param x number The horizontal (x) position of the point.
---@param y number The vertical (y) position of the point.
---@return Panel
---@return number
function Panel:GetClosestChild(x,y) end

-- Gets the size of the content/children within a panel object.  Only works with Label derived panels by default such as DLabel.   Will also work on any panel that manually implements this method.
---@return number
---@return number
function Panel:GetContentSize() end

-- Gets the value of a cookie stored by the panel object. This can also be done with cookie.GetString, using the panel's cookie name, a fullstop, and then the actual name of the cookie.  Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
---@param cookieName string The name of the cookie from which to retrieve the value.
---@param default string The default value to return if the cookie does not exist.
---@return string
function Panel:GetCookie(cookieName,default) end

-- Gets the name the panel uses to store cookies. This is set with Panel:SetCookieName.
---@return string
function Panel:GetCookieName() end

-- Gets the value of a cookie stored by the panel object, as a number. This can also be done with cookie.GetNumber, using the panel's cookie name, a fullstop, and then the actual name of the cookie.  Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
---@param cookieName string The name of the cookie from which to retrieve the value.
---@param default number The default value to return if the cookie does not exist.
---@return number
function Panel:GetCookieNumber(cookieName,default) end

-- Returns a dock enum for the panel's current docking type.
---@return number
function Panel:GetDock() end

-- Returns the docked margins of the panel. (set by Panel:DockMargin)
---@return number
---@return number
---@return number
---@return number
function Panel:GetDockMargin() end

-- Returns the docked padding of the panel. (set by Panel:DockPadding)
---@return number
---@return number
---@return number
---@return number
function Panel:GetDockPadding() end

-- Returns the foreground color of the panel.  For a Label or RichText, this is the color of its text.  This doesn't apply to all VGUI elements (such as DLabel) and its function varies between them
---@return table
function Panel:GetFGColor() end

-- Returns the name of the font that the panel renders its text with.  This is the same font name set with Panel:SetFontInternal.
---@return string
function Panel:GetFont() end

-- Returns the panel's HTML material. Only works with Awesomium, HTML and DHTML panels that have been fully loaded.
---@return IMaterial
function Panel:GetHTMLMaterial() end

-- Returns the current maximum character count.  This function will only work on RichText and TextEntry panels and their derivatives.
---@return number
function Panel:GetMaximumCharCount() end

-- Returns the internal name of the panel. Can be set via Panel:SetName.
---@return string
function Panel:GetName() end

-- Returns the number of lines in a RichText. You must wait a couple frames before calling this after using Panel:AppendText or Panel:SetText, otherwise it will return the number of text lines before the text change.  Even though this function can be called on any panel, it will only work with RichText
---@return number
function Panel:GetNumLines() end

-- Returns the parent of the panel, returns nil if there is no parent.
---@return Panel
function Panel:GetParent() end

-- Returns the position of the panel relative to its Panel:GetParent.  If you require the panel's position **and** size, consider using Panel:GetBounds instead.  If you need the position in screen space, see Panel:LocalToScreen.  See also Panel:GetX and Panel:GetY.
---@return number
---@return number
function Panel:GetPos() end

-- Returns a table of all children of the panel object that are selected. This is recursive, and the returned table will include tables for any child objects that also have children. This means that not all first-level members in the returned table will be of type Panel.
---@return table
function Panel:GetSelectedChildren() end

-- Returns the currently selected range of text.  This function will only work on RichText and TextEntry panels and their derivatives.
---@return number
---@return number
function Panel:GetSelectedTextRange() end

-- Returns the panel object (`self`) if it has been enabled as a selection canvas. This is achieved using Panel:SetSelectionCanvas.
---@return Panel
function Panel:GetSelectionCanvas() end

-- Returns the size of the panel.  If you require both the panel's position and size, consider using Panel:GetBounds instead.
---@return number
---@return number
function Panel:GetSize() end

-- Returns the table for the derma skin currently being used by this panel object.
---@return table
function Panel:GetSkin() end

-- Returns the internal Lua table of the panel.
---@return table
function Panel:GetTable() end

-- Returns the height of the panel.
---@return number
function Panel:GetTall() end

-- Returns the panel's text (where applicable).  This method returns a maximum of 1023 bytes, except for DTextEntry.
---@return string
function Panel:GetText() end

-- Gets the left and top text margins of a text-based panel object, such as a DButton or DLabel. This is set with Panel:SetTextInset.
---@return number
---@return number
function Panel:GetTextInset() end

-- Gets the size of the text within a Label derived panel.
---@return number
---@return number
function Panel:GetTextSize() end

-- Returns the tooltip text that was set with PANEL:SetTooltip.
---@return string
function Panel:GetTooltip() end

-- Returns the tooltip panel that was set with PANEL:SetTooltipPanel.
---@return Panel
function Panel:GetTooltipPanel() end

-- Gets valid receiver slot of currently dragged panel.
---@return Panel
---@return table
function Panel:GetValidReceiverSlot() end

-- Returns the value the panel holds.  In engine is only implemented for CheckButton, Label and TextEntry as a string.  This function is limited to 8092 Bytes. If using DTextEntry, use Panel:GetText for unlimited bytes.
---@return any
function Panel:GetValue() end

-- Returns the width of the panel.
---@return number
function Panel:GetWide() end

-- Returns the X position of the panel relative to its Panel:GetParent.  Uses Panel:GetPos internally.
---@return number
function Panel:GetX() end

-- Returns the Y position of the panel relative to its Panel:GetParent.  Uses Panel:GetPos internally.
---@return number
function Panel:GetY() end

-- Returns the Z position of the panel.
---@return number
function Panel:GetZPos() end

-- Goes back one page in the HTML panel's history if available.
function Panel:GoBack() end

-- Goes forward one page in the HTML panel's history if available.
function Panel:GoForward() end

-- Goes to the page in the HTML panel's history at the specified relative offset.
---@param offset number The offset in the panel's back/forward history, relative to the current page, that you would like to skip to. Because this is relative, 0 = current page while negative goes back and positive goes forward. For example, -2 will go back 2 pages in the history.
function Panel:GoToHistoryOffset(offset) end

-- Causes a RichText element to scroll to the bottom of its text.
function Panel:GotoTextEnd() end

-- Causes a RichText element to scroll to the top of its text.  This does not work on the same frame as Panel:SetText.
function Panel:GotoTextStart() end

--  Used by Panel:ApplyGWEN to apply the `CheckboxText` property to a DCheckBoxLabel. This does exactly the same as Panel:GWEN_SetText, but exists to cater for the seperate GWEN properties.
---@param txt string The text to be applied to the DCheckBoxLabel.
function Panel:GWEN_SetCheckboxText(txt) end

--  Used by Panel:ApplyGWEN to apply the `ControlName` property to a panel. This calls Panel:SetName.
---@param name string The new name to apply to the panel.
function Panel:GWEN_SetControlName(name) end

--  Used by Panel:ApplyGWEN to apply the `Dock` property to a  panel object. This calls Panel:Dock.
---@param dockState string The dock mode to pass to the panel's `Dock` method. This reads a string and applies the approriate Enums/DOCK. * `Right`: Dock right. * `Left`: Dock left. * `Bottom`: Dock at the bottom. * `Top`: Dock at the top. * `Fill`: Fill the parent panel.
function Panel:GWEN_SetDock(dockState) end

--  Used by Panel:ApplyGWEN to apply the `HorizontalAlign` property to a  panel object. This calls Panel:SetContentAlignment.
---@param hAlign string The alignment, as a string, to pass to Panel:SetContentAlignment. Accepts: * `Right`: Align mid-right. * `Left`: Align mid-left. * `Center`: Align mid-center.
function Panel:GWEN_SetHorizontalAlign(hAlign) end

--  Used by Panel:ApplyGWEN to apply the `Margin` property to a  panel object. This calls Panel:DockMargin.
---@param margins table A four-membered table containing the margins as numbers: * number left - The left margin. * number top - The top margin. * number right - The right margin. * number bottom - The bottom margin.
function Panel:GWEN_SetMargin(margins) end

--  Used by Panel:ApplyGWEN to apply the `Max` property to a  DNumberWang, Slider, DNumSlider or DNumberScratch. This calls `SetMax` on one of the previously listed methods.
---@param maxValue number The maximum value the element is to permit.
function Panel:GWEN_SetMax(maxValue) end

--  Used by Panel:ApplyGWEN to apply the `Min` property to a  DNumberWang, Slider, DNumSlider or DNumberScratch. This calls `SetMin` on one of the previously listed methods.
---@param minValue number The minimum value the element is to permit.
function Panel:GWEN_SetMin(minValue) end

--  Used by Panel:ApplyGWEN to apply the `Position` property to a  panel object. This calls Panel:SetPos.
---@param pos table A two-membered table containing the x and y coordinates as numbers: * number x - The x coordinate. * number y - The y coordinate.
function Panel:GWEN_SetPosition(pos) end

--  Used by Panel:ApplyGWEN to apply the `Size` property to a  panel object. This calls Panel:SetSize.
---@param size table A two-membered table containing the width and heights as numbers: * number w - The width. * number h - The height.
function Panel:GWEN_SetSize(size) end

--  Used by Panel:ApplyGWEN to apply the `Text` property to a panel.
---@param txt string The text to be applied to the panel.
function Panel:GWEN_SetText(txt) end

-- Returns whenever the panel has child panels.
---@return boolean
function Panel:HasChildren() end

-- Returns if the panel is focused.
---@return boolean
function Panel:HasFocus() end

-- Returns if the panel or any of its children(sub children and so on) has the focus.
---@return boolean
function Panel:HasHierarchicalFocus() end

-- Returns whether the panel is a descendent of the given panel.
---@param parentPanel Panel
---@return boolean
function Panel:HasParent(parentPanel) end

-- Makes a panel invisible.
function Panel:Hide() end

-- Marks the end of a clickable text segment in a RichText element, started with Panel:InsertClickableTextStart.
function Panel:InsertClickableTextEnd() end

-- Starts the insertion of clickable text for a RichText element. Any text appended with Panel:AppendText between this call and Panel:InsertClickableTextEnd will become clickable text.  The hook PANEL:ActionSignal is called when the text is clicked, with "TextClicked" as the signal name and `signalValue` as the signal value.  The clickable text is a separate Derma panel which will not inherit the current font from the `RichText`.
---@param signalValue string The text passed as the action signal's value.
function Panel:InsertClickableTextStart(signalValue) end

-- Inserts a color change in a RichText element, which affects the color of all text added with Panel:AppendText until another color change is applied.
---@param r number The red value `(0 - 255)`.
---@param g number The green value `(0 - 255)`.
---@param b number The blue value `(0 - 255)`.
---@param a number The alpha value `(0 - 255)`.
function Panel:InsertColorChange(r,g,b,a) end

-- Begins a text fade for a RichText element where the last appended text segment is fully faded out after a specific amount of time, at a specific speed.  The alpha of the text at any given time is determined by the text's base alpha * ((`sustain` - Global.CurTime) / `length`) where Global.CurTime is added to `sustain` when this method is called.
---@param sustain number The number of seconds the text remains visible.
---@param length number The number of seconds it takes the text to fade out.  If set **lower** than `sustain`, the text will not begin fading out until (`sustain` - `length`) seconds have passed.  If set **higher** than `sustain`, the text will begin fading out immediately at a fraction of the base alpha.  If set to **-1**, the text doesn't fade out.
function Panel:InsertFade(sustain,length) end

-- Invalidates the layout of this panel object and all its children. This will cause these objects to re-layout immediately, calling PANEL:PerformLayout. If you want to perform the layout in the next frame, you will have loop manually through all children, and call Panel:InvalidateLayout on each.
---@param recursive? boolean If `true`, the method will recursively invalidate the layout of all children. Otherwise, only immediate children are affected.
function Panel:InvalidateChildren(recursive) end

-- Causes the panel to re-layout in the next frame. During the layout process  PANEL:PerformLayout will be called on the target panel.  You should avoid calling this function every frame.  Using this on a panel after clicking on a docked element will cause docked elements to reorient themselves incorrectly. This can be fixed by assigning a unique Panel:SetZPos to each docked element.
---@param layoutNow? boolean If true the panel will re-layout instantly and not wait for the next frame.
function Panel:InvalidateLayout(layoutNow) end

-- Calls Panel:InvalidateLayout on the panel's Panel:GetParent. This function will silently fail if the panel has no parent.  This will cause the parent panel to re-layout, calling PANEL:PerformLayout.  Internally sets `LayingOutParent` to `true` on this panel, and will silently fail if it is already set.
---@param layoutNow? boolean If `true`, the re-layout will occur immediately, otherwise it will be performed in the next frame.
function Panel:InvalidateParent(layoutNow) end

-- Determines whether the mouse cursor is hovered over one of this panel object's children. This is a reverse process using vgui.GetHoveredPanel, and looks upward to find the parent.
---@param immediate? boolean Set to true to check only the immediate children of given panel ( first level )
---@return boolean
function Panel:IsChildHovered(immediate) end

-- Returns whether this panel is draggable ( if user is able to drag it ) or not.
---@return boolean
function Panel:IsDraggable() end

-- Returns whether this panel is currently being dragged or not.
---@return boolean
function Panel:IsDragging() end

-- Returns whether the the panel is enabled or disabled.  See Panel:SetEnabled for a function that makes the panel enabled or disabled.
---@return boolean
function Panel:IsEnabled() end

-- Returns whether the mouse cursor is hovering over this panel or not  Uses vgui.GetHoveredPanel internally.  Requires Panel:SetMouseInputEnabled to be set to true.
---@return boolean
function Panel:IsHovered() end

-- Returns true if the panel can receive keyboard input.
---@return boolean
function Panel:IsKeyboardInputEnabled() end

-- Determines whether or not a HTML or DHTML element is currently loading a page.  Before calling Panel:SetHTML or DHTML:OpenURL, the result seems to be `false` with the Awesomium web renderer and `true` for the Chromium web renderer. This difference can be used to determine the available HTML5 capabilities. On Awesomium, the result remains `true` until the root document is loaded and when in-page content is loading (when adding pictures, frames, etc.). During this state, the HTML texture is not refreshed and the panel is not painted (it becomes invisible).  On Chromium, the value is only `true` when the root document is not ready. The rendering is not suspended when in-page elements are loading.
---@return boolean
function Panel:IsLoading() end

-- Returns if the panel is going to be deleted in the next frame.
---@return boolean
function Panel:IsMarkedForDeletion() end

-- Returns whether the panel was made modal or not. See Panel:DoModal.
---@return boolean
function Panel:IsModal() end

-- Returns true if the panel can receive mouse input.
---@return boolean
function Panel:IsMouseInputEnabled() end

-- Returns whether the panel contains the given panel, recursively.
---@param childPanel Panel
---@return boolean
function Panel:IsOurChild(childPanel) end

-- Returns if the panel was made popup or not. See Panel:MakePopup
---@return boolean
function Panel:IsPopup() end

-- Determines if the panel object is selectable (like icons in the Spawn Menu, holding Shift). This is set with Panel:SetSelectable.
---@return boolean
function Panel:IsSelectable() end

-- Returns if the panel object is selected (like icons in the Spawn Menu, holding Shift). This can be set in Lua using Panel:SetSelected.
---@return boolean
function Panel:IsSelected() end

-- Determines if the panel object is a selection canvas or not. This is set with Panel:SetSelectionCanvas.
---@return any
function Panel:IsSelectionCanvas() end

-- Returns if the panel is valid and not marked for deletion.
---@return boolean
function Panel:IsValid() end

-- Returns if the panel is visible. This will **NOT** take into account visibility of the parent.
---@return boolean
function Panel:IsVisible() end

-- Returns if a panel allows world clicking set by Panel:SetWorldClicker.
---@return boolean
function Panel:IsWorldClicker() end

-- Remove the focus from the panel.
function Panel:KillFocus() end

-- Redefines the panel object's Panel:SetPos method to operate using frame-by-frame linear interpolation (Global.Lerp). When the panel's position is changed, it will move to the target position at the speed defined. You can undo this with Panel:DisableLerp.  Unlike the other panel animation functions, such as Panel:MoveTo, this animation method will not operate whilst the game is paused. This is because it relies on Global.FrameTime.
---@param speed number The speed at which to move the panel. This is affected by the value of `easeOut`. Recommended values are: * **0.1 - 10** when `easeOut` is `false`. * **0.1 - 1** when `easeOut` is `true`.
---@param easeOut boolean This causes the panel object to 'jump' at the target, slowing as it approaches. This affects the `speed` value significantly, see above.
function Panel:LerpPositions(speed,easeOut) end

--   Similar to Panel:LoadControlsFromString but loads controls from a file.
---@param path string The path to load the controls from.
function Panel:LoadControlsFromFile(path) end

--   Loads controls(positions, etc) from given data. This is what the default options menu uses.
---@param data string The data to load controls from. Format unknown.
function Panel:LoadControlsFromString(data) end

-- Loads a .gwen file (created by GWEN Designer) and calls Panel:LoadGWENString with the contents of the loaded file.  Used to load panel controls from a file.
---@param filename string The file to open. The path is relative to garrysmod/garrysmod/.
---@param path? string The path used to look up the file.  * "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) * "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons * "DATA" Data folder (garrysmod/data) * "MOD" Strictly the game folder (garrysmod/), ignores mounting.
function Panel:LoadGWENFile(filename,path) end

-- Loads controls for the panel from a JSON string.
---@param str string JSON string containing information about controls to create.
function Panel:LoadGWENString(str) end

-- Sets a new image to be loaded by a TGAImage.
---@param imageName string The file path.
---@param strPath string The PATH to search in. See File Search Paths.  This isn't used internally.
function Panel:LoadTGAImage(imageName,strPath) end

-- Returns the cursor position local to the position of the panel (usually the upper-left corner).
---@return number
---@return number
function Panel:LocalCursorPos() end

-- Gets the absolute screen position of the position specified relative to the panel.  See also Panel:ScreenToLocal.  This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.  If the panel uses Panel:Dock, this function will return 0, 0 when the panel was created. The position will be updated in the next frame.
---@param posX number The X coordinate of the position on the panel to translate.
---@param posY number The Y coordinate of the position on the panel to translate.
---@return number
---@return number
function Panel:LocalToScreen(posX,posY) end

-- Focuses the panel and enables it to receive input.  This automatically calls Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled and sets them to `true`.  Panels derived from Panel will not work properly with this function. Due to this, any children will not be intractable with keyboard. Derive from EditablePanel instead.  For non gui related mouse focus, you can use gui.EnableScreenClicker.
function Panel:MakePopup() end

-- Allows the panel to receive mouse input even if the mouse cursor is outside the bounds of the panel.
---@param doCapture boolean Set to true to enable, set to false to disable.
function Panel:MouseCapture(doCapture) end

-- Places the panel above the passed panel with the specified offset.
---@param panel Panel Panel to position relatively to.
---@param offset? number The align offset.
function Panel:MoveAbove(panel,offset) end

-- Places the panel below the passed panel with the specified offset.
---@param panel Panel Panel to position relatively to.
---@param offset? number The align offset.
function Panel:MoveBelow(panel,offset) end

-- Moves the panel by the specified coordinates using animation.
---@param moveX number The number of pixels to move by in the horizontal (x) direction.
---@param moveY number The number of pixels to move by in the vertical (y) direction.
---@param time number The time (in seconds) in which to perform the animation.
---@param delay? number The delay (in seconds) before the animation begins.
---@param ease? number The easing of the start and/or end speed of the animation. See Panel:NewAnimation for how this works.
---@param callback? function The function to be called once the animation is complete. Arguments are: * table animData - The AnimationData that was used. * Panel pnl - The panel object that was moved.
function Panel:MoveBy(moveX,moveY,time,delay,ease,callback) end

-- Places the panel left to the passed panel with the specified offset.
---@param panel Panel Panel to position relatively to.
---@param offset? number The align offset.
function Panel:MoveLeftOf(panel,offset) end

-- Places the panel right to the passed panel with the specified offset.
---@param panel Panel Panel to position relatively to.
---@param offset? number The align offset.
function Panel:MoveRightOf(panel,offset) end

-- Moves the panel to the specified position using animation. Setting the ease argument to 0 will result in the animation happening instantly, this applies to all MoveTo/SizeTo functions
---@param posX number The target x coordinate of the panel.
---@param posY number The target y coordinate of the panel.
---@param time number The time to perform the animation within.
---@param delay? number The delay before the animation starts.
---@param ease? number The easing of the start and/or end speed of the animation. See Panel:NewAnimation for how this works.
---@param callback function The function to be called once the animation finishes. Arguments are: * table animData - The Structures/AnimationData that was used. * Panel pnl - The panel object that was moved.
function Panel:MoveTo(posX,posY,time,delay,ease,callback) end

-- Moves this panel object in front of the specified sibling (child of the same parent) in the render order, and shuffles up the Z-positions of siblings now behind.
---@param siblingPanel Panel The panel to move this one in front of. Must be a child of the same parent panel.
---@return boolean
function Panel:MoveToAfter(siblingPanel) end

-- Moves the panel object behind all other panels on screen. If the panel has been made a pop-up with Panel:MakePopup, it will still draw in front of any panels that haven't.
function Panel:MoveToBack() end

-- Moves this panel object behind the specified sibling (child of the same parent) in the render order, and shuffles up the Panel:SetZPos of siblings now in front.
---@param siblingPanel Panel The panel to move this one behind. Must be a child of the same parent panel.
---@return boolean
function Panel:MoveToBefore(siblingPanel) end

-- Moves the panel in front of all other panels on screen. Unless the panel has been made a pop-up using Panel:MakePopup, it will still draw behind any that have.
function Panel:MoveToFront() end

-- Creates a new animation for the panel object.  Methods that use this function: * Panel:MoveTo * Panel:SizeTo * Panel:SlideUp * Panel:SlideDown * Panel:ColorTo * Panel:AlphaTo * Panel:MoveBy * Panel:LerpPositions
---@param length number The length of the animation in seconds.
---@param delay? number The delay before the animation starts.
---@param ease? number The power/index to use for easing. * Positive values greater than 1 will ease in; the higher the number, the sharper the curve's gradient (less linear). * A value of 1 removes all easing. * Positive values between 0 and 1 ease out; values closer to 0 increase the curve's gradient (less linear). * A value of 0 will break the animation and should be avoided. * Any value less than zero will ease in/out; the value has no effect on the gradient.
---@param callback? function The function to be called when the animation ends. Arguments passed are: * table animTable - The Structures/AnimationData that was used. * Panel tgtPanel - The panel object that was animated.
---@return table
function Panel:NewAnimation(length,delay,ease,callback) end

-- 
---@param objectName string
function Panel:NewObject(objectName) end

-- 
---@param objectName string
---@param callbackName string
function Panel:NewObjectCallback(objectName,callbackName) end

-- Sets whether this panel's drawings should be clipped within the parent panel's bounds.  See also Global.DisableClipping.
---@param clip boolean Whether to clip or not.
function Panel:NoClipping(clip) end

-- Returns the number of children of the panel object that are selected. This is equivalent to calling Panel:IsSelected on all child objects and counting the number of returns that are `true`.
---@return number
function Panel:NumSelectedChildren() end

-- Instructs a HTML control to download and parse a HTML script using the passed URL.  This function can also be used on [HTML](https://wiki.facepunch.com/gmod/HTML).
---@param URL string URL to open. It has to start or be one of the following: * `http://` * `https://` * `asset://` * `about:blank` * `chrome://credits/`
function Panel:OpenURL(URL) end

-- Paints a ghost copy of the panel at the given position.  Breaks Z pos of panel PANEL:SetZPos 
---@param posX number The x coordinate to draw the panel from.
---@param posY number The y coordinate to draw the panel from.
function Panel:PaintAt(posX,posY) end

-- Paints the panel at its current position. To use this you must call Panel:SetPaintedManually(true).
function Panel:PaintManual() end

-- Parents the panel to the HUD. Makes it invisible on the escape-menu and disables controls.
function Panel:ParentToHUD() end

-- Due to privacy concerns, this function has been disabled  Only works for TextEntries.  Pastes the contents of the clipboard into the TextEntry.  Tab characters will be dropped from the pasted text
function Panel:Paste() end

-- Sets the width and position of a DLabel and places the passed panel object directly to the right of it. Returns the `y` value of the bottom of the tallest object. The panel on which this method is run is not relevant; only the passed objects are affected.
---@param lblWidth number The width to set the label to.
---@param x number The horizontal (x) position at which to place the label.
---@param y number The vertical (y) position at which to place the label.
---@param lbl Panel The label to resize and position.
---@param panelObj Panel The panel object to place to the right of the label.
---@return number
function Panel:PositionLabel(lblWidth,x,y,lbl,panelObj) end

-- Only used in deprecated Derma controls.Sends a command to the panel.
---@param messageName string The name of the message.
---@param valueType string The type of the variable to post.
---@param value string The value to post.
function Panel:PostMessage(messageName,valueType,value) end

--  Installs Lua defined functions into the panel.
function Panel:Prepare() end

-- Enables the queue for panel animations. If enabled, the next new animation will begin after all current animations have ended. This must be called before Panel:NewAnimation to work, and only applies to the next new animation. If you want to queue many, you must call this before each.
function Panel:Queue() end

-- Causes a SpawnIcon to rebuild its model image.
function Panel:RebuildSpawnIcon() end

-- Re-renders a spawn icon with customized cam data.  Global.PositionSpawnIcon can be used to easily calculate the necessary camera parameters.  This function does **not** accept the standard Structures/CamData.
---@param data table A four-membered table containing the information needed to re-render: * Vector cam_pos - The relative camera position the model is viewed from. * Angle cam_ang - The camera angle the model is viewed from. * number cam_fov - The camera's field of view (FOV). * Entity ent - The entity object of the model. See the example below for how to retrieve these values.
function Panel:RebuildSpawnIconEx(data) end

-- Allows the panel to receive drag and drop events. Can be called multiple times with different names to receive multiple different draggable panel events.
---@param name string Name of DnD panels to receive. This is set on the drag'n'drop-able panels via  Panel:Droppable
---@param func function This function is called whenever a panel with valid name is hovering above and dropped on this panel. It has next arguments: * Panel pnl - The receiver panel * table tbl - A table of panels dropped onto receiver panel * boolean dropped - False if hovering over, true if dropped onto * number menuIndex - Index of clicked menu item from third argument of Panel:Receiver * number x - Cursor pos, relative to the receiver * number y - Cursor pos, relative to the receiver
---@param menu table A table of strings that will act as a menu if drag'n'drop was performed with a right click
function Panel:Receiver(name,func,menu) end

-- Refreshes the HTML panel's current page.
---@param ignoreCache? boolean If true, the refresh will ignore cached content similar to "ctrl+f5" in most browsers.
function Panel:Refresh(ignoreCache) end

-- Marks a panel for deletion so it will be deleted on the next frame.  This will not mark child panels for deletion this frame, but they will be marked and deleted in the next frame.  See also Panel:IsMarkedForDeletion  Will automatically call Panel:InvalidateParent.
function Panel:Remove() end

-- Attempts to obtain focus for this panel.
function Panel:RequestFocus() end

-- Resets all text fades in a RichText element made with Panel:InsertFade.
---@param hold boolean True to reset fades, false otherwise.
---@param expiredOnly boolean Any value equating to `true` will reset fades only on text segments that are completely faded out.
---@param newSustain number The new sustain value of each faded text segment. Set to -1 to keep the old sustain value.
function Panel:ResetAllFades(hold,expiredOnly,newSustain) end

-- Runs/Executes a string as JavaScript code in a panel. This function does **NOT** evaluate expression (i.e. allow you to pass variables from JavaScript (JS) to Lua context).Because a return value is nil/no value (a.k.a. void).If you wish to pass/return values from JS to Lua, you may want to use DHTML:AddFunction function to accomplish that job. The Awesomium web renderer automatically delays the code execution if the document is not ready, but the Chromium web renderer does not!  This means that with Chromium, you cannot JavaScript run code immediatly after calling Panel:SetHTML or DHTML:OpenURL. You should wait for the events PANEL:OnDocumentReady or PANEL:OnFinishLoadingDocument to be triggered before proceeding, otherwise you may manipulate an empty / incomplete document.
---@param js string Specify JavaScript code to be executed.
function Panel:RunJavascript(js) end

-- Saves the current state (caret position and the text inside) of a TextEntry as an undo state.  See also Panel:Undo.
function Panel:SaveUndoState() end

-- Translates global screen coordinate to coordinates relative to the panel.  See also Panel:LocalToScreen.  This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
---@param screenX number The x coordinate of the screen position to be translated.
---@param screenY number The y coordinate of the screed position be to translated.
---@return number
---@return number
function Panel:ScreenToLocal(screenX,screenY) end

-- Selects all items within a panel or object. For text-based objects, selects all text.
function Panel:SelectAll() end

-- If called on a text entry, clicking the text entry for the first time will automatically select all of the text ready to be copied by the user.
function Panel:SelectAllOnFocus() end

-- Duplicate of Panel:SelectAll.  Selects all the text in a panel object. Will not select non-text items; for this, use Panel:SelectAll.
function Panel:SelectAllText() end

-- Deselects all items in a panel object. For text-based objects, this will deselect all text.
function Panel:SelectNone() end

-- Sets the achievement to be displayed by AchievementIcon.
---@param id number Achievement number ID
function Panel:SetAchievement(id) end

-- Does nothing at all.  Used in Button to call a function when the button is clicked and in Slider when the value changes.
---@param func function Function to call when the Button is clicked or the Slider value is changed.  Arguments given are: * Panel self - The panel itself * string action - "Command" on button press, "SliderMoved" on slider move. * number val - The new value of the Slider. Will always equal 0 for buttons. * number zed - Always equals 0.
function Panel:SetActionFunction(func) end

-- Configures a text input to allow user to type characters that are not included in the US-ASCII (7-bit ASCII) character set.  Characters not included in US-ASCII are multi-byte characters in UTF-8. They can be accented characters, non-Latin characters and special characters.
---@param allowed boolean Set to true in order not to restrict input characters.
function Panel:SetAllowNonAsciiCharacters(allowed) end

-- Sets the alpha multiplier for the panel
---@param alpha number The alpha value in the range of 0-255.
function Panel:SetAlpha(alpha) end

-- Enables or disables animations for the panel object by overriding the PANEL:AnimationThink hook to nil and back.
---@param enable boolean Whether to enable or disable animations.
function Panel:SetAnimationEnabled(enable) end

-- Sets whenever the panel should be removed if the parent was removed.
---@param autoDelete boolean Whenever to delete if the parent was removed or not.
function Panel:SetAutoDelete(autoDelete) end

-- Sets the background color of a panel such as a RichText, Label or DColorCube.  This doesn't apply to all VGUI elements and its function varies between them  For DLabel elements, you must use Panel:SetPaintBackgroundEnabled( true ) before applying the color.  This will not work on setup of the panel - you should use this function in a hook like PANEL:ApplySchemeSettings or PANEL:PerformLayout.
---@param r_or_color number The red channel of the color, or a Color. If you pass the latter, the following three arguments are ignored.
---@param g number The green channel of the color.
---@param b number The blue channel of the color.
---@param a number The alpha channel of the color.
function Panel:SetBGColor(r_or_color,g,b,a) end

-- Sets the background color of the panel.
---@param r number The red channel of the color.
---@param g number The green channel of the color.
---@param b number The blue channel of the color.
---@param a number The alpha channel of the color.
function Panel:SetBGColorEx(r,g,b,a) end

-- Sets the position of the caret (or text cursor) in a text-based panel object.
---@param offset number Caret position/offset from the start of text. A value of `0` places the caret before the first character.
function Panel:SetCaretPos(offset) end

-- Sets the action signal command that's fired when a Button is clicked. The hook PANEL:ActionSignal is called as the click response.  This has no effect on buttons unless it has had its `AddActionSignalTarget` method called (an internal function not available by default in Garry's Mod LUA).  A better alternative is calling Panel:Command when a DButton is clicked.
function Panel:SetCommand() end

-- Sets the alignment of the contents.
---@param alignment number The direction of the content, based on the number pad.  1: **bottom-left**  2: **bottom-center**  3: **bottom-right**  4: **middle-left**  5: **center**  6: **middle-right**  7: **top-left**  8: **top-center**  9: **top-right**  
function Panel:SetContentAlignment(alignment) end

-- This function does not exist on all panels This function cannot interact with serverside convars unless you are host Blocked convars will not work with this, see Blocked ConCommands  Sets this panel's convar. When the convar changes this panel will update automatically.  For developer implementation, see Global.Derma_Install_Convar_Functions.
---@param convar string The console variable to check.
function Panel:SetConVar(convar) end

-- Stores a string in the named cookie using Panel:GetCookieName as prefix.  You can also retrieve and modify this cookie by using the cookie. Cookies are stored in this format:  ``` panelCookieName.cookieName ```   The panel's cookie name MUST be set for this function to work. See Panel:SetCookieName.
---@param cookieName string The unique name used to retrieve the cookie later.
---@param value string The value to store in the cookie. This can be retrieved later as a string or number.
function Panel:SetCookie(cookieName,value) end

-- Sets the panel's cookie name. Calls PANEL:LoadCookies if defined.
---@param name string The panel's cookie name. Used as prefix for Panel:SetCookie
function Panel:SetCookieName(name) end

-- Sets the appearance of the cursor. You can find a list of all available cursors with image previews [here](https://wiki.facepunch.com/gmod/Cursors).
---@param cursor string The cursor to be set. Can be one of the following:  * [arrow](https://wiki.facepunch.com/gmod/Cursors#:~:text=arrow) * [beam](https://wiki.facepunch.com/gmod/Cursors#:~:text=beam) * [hourglass](https://wiki.facepunch.com/gmod/Cursors#:~:text=hourglass) * [waitarrow](https://wiki.facepunch.com/gmod/Cursors#:~:text=waitarrow) * [crosshair](https://wiki.facepunch.com/gmod/Cursors#:~:text=crosshair) * [up](https://wiki.facepunch.com/gmod/Cursors#:~:text=up) * [sizenwse](https://wiki.facepunch.com/gmod/Cursors#:~:text=sizenwse) * [sizenesw](https://wiki.facepunch.com/gmod/Cursors#:~:text=sizenesw) * [sizewe](https://wiki.facepunch.com/gmod/Cursors#:~:text=sizewe) * [sizens](https://wiki.facepunch.com/gmod/Cursors#:~:text=sizens) * [sizeall](https://wiki.facepunch.com/gmod/Cursors#:~:text=sizeall) * [no](https://wiki.facepunch.com/gmod/Cursors#:~:text=no) * [hand](https://wiki.facepunch.com/gmod/Cursors#:~:text=hand) * [blank](https://wiki.facepunch.com/gmod/Cursors#:~:text=blank)  Set to anything else to set it to "none", the default fallback. Do note that a value of "none" does not, as one might assume, result in no cursor being drawn - hiding the cursor requires a value of "blank" instead.
function Panel:SetCursor(cursor) end

-- Sets the drag parent.  Drag parent means that when we start to drag this panel, we'll really start dragging the defined parent.
---@param parent Panel The panel to set as drag parent.
function Panel:SetDragParent(parent) end

-- Makes the panel render in front of all others, including the spawn menu and main menu.  Priority is given based on the last call, so of two panels that call this method, the second will draw in front of the first.  This only makes the panel **draw** above other panels. If there's another panel that would have otherwise covered it, users will not be able to interact with it.  Completely disregards PANEL:ParentToHUD.  This does not work when using PANEL:SetPaintedManually or PANEL:PaintAt.
---@param drawOnTop? boolean Whether or not to draw the panel in front of all others.
function Panel:SetDrawOnTop(drawOnTop) end

-- Sets the target area for dropping when an object is being dragged around this panel using the dragndrop.  This draws a target box of the specified size and position, until Panel:DragHoverEnd is called. It uses Panel:DrawDragHover to draw this area.
---@param x number The x coordinate of the top-left corner of the drop area.
---@param y number The y coordinate of the top-left corner of the drop area.
---@param width number The width of the drop area.
---@param height number The height of the drop area.
function Panel:SetDropTarget(x,y,width,height) end

-- Sets the enabled state of a disable-able panel object, such as a DButton or DTextEntry.  See Panel:IsEnabled for a function that retrieves the "enabled" state of a panel.
---@param enable boolean Whether to enable or disable the panel object.
function Panel:SetEnabled(enable) end

-- Adds a shadow falling to the bottom right corner of the panel's text. This has no effect on panels that do not derive from Label.
---@param distance number The distance of the shadow from the panel.
---@param Color table The color of the shadow. Uses the Color.
function Panel:SetExpensiveShadow(distance,Color) end

-- Sets the foreground color of a panel.  For a Label or RichText, this is the color of its text.  This function calls Panel:SetFGColorEx internally.  This doesn't apply to all VGUI elements (such as DLabel) and its function varies between them
---@param r_or_color number The red channel of the color, or a Color. If you pass the latter, the following three arguments are ignored.
---@param g number The green channel of the color.
---@param b number The blue channel of the color.
---@param a number The alpha channel of the color.
function Panel:SetFGColor(r_or_color,g,b,a) end

-- Sets the foreground color of the panel.  For labels, this is the color of their text.
---@param r number The red channel of the color.
---@param g number The green channel of the color.
---@param b number The blue channel of the color.
---@param a number The alpha channel of the color.
function Panel:SetFGColorEx(r,g,b,a) end

-- Sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy. This function will only work on EditablePanel class panels and its derivatives.
---@param state boolean
function Panel:SetFocusTopLevel(state) end

-- Sets the font used to render this panel's text. This works for Label, TextEntry and RichText, but it's a better idea to use their local `SetFont` (DTextEntry:SetFont, DLabel:SetFont) methods when available.  To retrieve the font used by a panel, call Panel:GetFont.
---@param fontName string The name of the font.  See Default_Fonts for a list of existing fonts. Alternatively, use surface.CreateFont to create your own custom font.
function Panel:SetFontInternal(fontName) end

-- Sets the height of the panel.  Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).   See also Panel:SetSize.
---@param height number The height to be set.
function Panel:SetHeight(height) end

-- Allows you to set HTML code within a panel.
---@param HTML_code string The code to set.
function Panel:SetHTML(HTML_code) end

-- Allows or disallows the panel to receive keyboard focus and input. This is recursively applied to all children.
---@param enable boolean Whether keyboard input should be enabled for this panel.
function Panel:SetKeyboardInputEnabled(enable) end

-- Alias of Panel:SetKeyboardInputEnabled(lowercase)Enables or disables the keyboard input for the panel.
---@param keyboardInput boolean Whether to enable or disable keyboard input.
function Panel:SetKeyBoardInputEnabled(keyboardInput) end

-- Sets the maximum character count this panel should have.  This function will only work on RichText and TextEntry panels and their derivatives.
---@param maxChar number The new maximum amount of characters this panel is allowed to contain.
function Panel:SetMaximumCharCount(maxChar) end

-- Sets the minimum dimensions of the panel or object.  You can restrict either or both values.  Calling the function without arguments will remove the minimum size.
---@param minW? number The minimum width of the object.
---@param minH? number The minimum height of the object.
function Panel:SetMinimumSize(minW,minH) end

-- Sets the model to be displayed by SpawnIcon.  This must be called after setting size if you wish to use a different size spawnicon
---@param ModelPath string The path of the model to set
---@param skin? number The skin to set
---@param bodygroups string The body groups to set. Each single-digit number in the string represents a separate bodygroup, **This argument must be 9 characters in total**.
function Panel:SetModel(ModelPath,skin,bodygroups) end

-- Enables or disables the mouse input for the panel. Panels parented to the context menu will not be clickable unless Panel:SetKeyboardInputEnabled(lowercase) is enabled or Panel:MakePopup has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set Panel:SetKeyboardInputEnabled(lowercase) to false immediately after calling Panel:MakePopup.
---@param mouseInput boolean Whenever to enable or disable mouse input.
function Panel:SetMouseInputEnabled(mouseInput) end

-- Sets the internal name of the panel. Can be retrieved with Panel:GetName.
---@param name string The new name of the panel.
function Panel:SetName(name) end

-- Sets whenever all the default background of the panel should be drawn or not.
---@param paintBackground boolean Whenever to draw the background or not.
function Panel:SetPaintBackgroundEnabled(paintBackground) end

-- Sets whenever all the default border of the panel should be drawn or not.
---@param paintBorder boolean Whenever to draw the border or not.
function Panel:SetPaintBorderEnabled(paintBorder) end

-- Enables or disables painting of the panel manually with Panel:PaintManual.
---@param paintedManually boolean True if the panel should be painted manually.
function Panel:SetPaintedManually(paintedManually) end

-- This function does nothing. This function does nothing.
function Panel:SetPaintFunction() end

-- Sets the parent of the panel. Panels parented to the context menu will not be clickable unless Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled(lowercase) are both true or Panel:MakePopup has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set Panel:SetKeyboardInputEnabled(lowercase) to false immediately after calling Panel:MakePopup.
---@param parent Panel The new parent of the panel.
function Panel:SetParent(parent) end

-- Used by AvatarImage to load an avatar for given player.
---@param player Player The player to use avatar of.
---@param size number The size of the avatar to use. Acceptable sizes are 32, 64, 184.
function Panel:SetPlayer(player,size) end

-- If this panel object has been made a popup with Panel:MakePopup, this method will prevent it from drawing in front of other panels when it receives input focus.
---@param stayAtBack boolean If `true`, the popup panel will not draw in front of others when it gets focus, for example when it is clicked.
function Panel:SetPopupStayAtBack(stayAtBack) end

-- Sets the position of the panel's top left corner.  This will trigger PANEL:PerformLayout. You should avoid calling this function in PANEL:PerformLayout to avoid infinite loops.  See also Panel:SetX and Panel:SetY.  If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
---@param posX number The x coordinate of the position.
---@param posY number The y coordinate of the position.
function Panel:SetPos(posX,posY) end

-- Sets whenever the panel should be rendered in the next screenshot.
---@param renderInScreenshot boolean Whether to render in the screenshot or not.
function Panel:SetRenderInScreenshots(renderInScreenshot) end

-- Sets whether the panel object can be selected or not (like icons in the Spawn Menu, holding Shift). If enabled, this will affect the function of a DButton whilst Shift is pressed. Panel:SetSelected can be used to select/deselect the object.
---@param selectable boolean Whether the panel object should be selectable or not.
function Panel:SetSelectable(selectable) end

-- Sets the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable.
---@param selected? boolean Whether the object should be selected or deselected. Panel:IsSelected can be used to determine the selected state of the object.
function Panel:SetSelected(selected) end

-- Enables the panel object for selection (much like the spawn menu).
---@param set boolean Whether to enable selection.
function Panel:SetSelectionCanvas(set) end

-- Sets the size of the panel.  Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).   See also Panel:SetWidth and Panel:SetHeight.  If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
---@param width number The width of the panel.
---@param height number The height of the panel.
function Panel:SetSize(width,height) end

-- Sets the derma skin that the panel object will use, and refreshes all panels with derma.RefreshSkins.
---@param skinName string The name of the skin to use. The default derma skin is `Default`.
function Panel:SetSkin(skinName) end

-- Sets the `.png` image to be displayed on a  SpawnIcon or the panel it is based on - ModelImage.  Only `.png` images can be used with this function.
---@param icon string A path to the .png material, for example one of the Silkicons shipped with the game.
function Panel:SetSpawnIcon(icon) end

-- Used by AvatarImage panels to load an avatar by its 64-bit Steam ID (community ID).
---@param steamid string The 64bit SteamID of the player to load avatar of
---@param size number The size of the avatar to use. Acceptable sizes are 32, 64, 184.
function Panel:SetSteamID(steamid,size) end

-- When TAB is pressed, the next selectable panel in the number sequence is selected.
---@param position number
function Panel:SetTabPosition(position) end

-- Sets height of a panel. An alias of Panel:SetHeight.
---@param height number Desired height to set
function Panel:SetTall(height) end

-- Removes the panel after given time in seconds. This function will not work if PANEL:AnimationThink is overridden, unless Panel:AnimationThinkInternal is called every frame.
---@param delay number Delay in seconds after which the panel should be removed.
function Panel:SetTerm(delay) end

-- Sets the text value of a panel object containing text, such as a Label, TextEntry or  RichText and their derivatives, such as DLabel, DTextEntry or DButton.  When used on a Label or its derivatives ( DLabel and DButton ), it will automatically call Panel:InvalidateLayout, meaning that you should avoid running this function every frame on these panels to avoid unnecessary performance loss.
---@param text string The text value to set.
function Panel:SetText(text) end

-- Sets the left and top text margins of a text-based panel object, such as a DButton or DLabel.
---@param insetX number The left margin for the text, in pixels. This will only affect centered text if the margin is greater than its x-coordinate.
---@param insetY number The top margin for the text, in pixels.
function Panel:SetTextInset(insetX,insetY) end

-- Sets text selection colors of a RichText element.
---@param textColor table The Global.Color to set for selected text.
---@param backgroundColor table The Global.Color to set for selected text background.
function Panel:SetTextSelectionColors(textColor,backgroundColor) end

-- Sets the height of a RichText element to accommodate the text inside.  This function internally relies on Panel:GetNumLines, so it should be called at least a couple frames after modifying the text using Panel:AppendText
function Panel:SetToFullHeight() end

-- Sets the tooltip to be displayed when a player hovers over the panel object with their cursor.
---@param str string The text to be displayed in the tooltip. Set false to disable it.
function Panel:SetTooltip(str) end

-- Sets the panel to be displayed as contents of a DTooltip when a player hovers over the panel object with their cursor. See Panel:SetTooltipPanelOverride if you are looking to override DTooltip itself.  Panel:SetTooltip will override this functionality.   Calling this from PANEL:OnCursorEntered is too late! The tooltip will not be displayed or be updated.  Given panel or the previously set one will **NOT** be automatically removed. 
---@param tooltipPanel? Panel The panel to use as the tooltip.
function Panel:SetTooltipPanel(tooltipPanel) end

-- Sets the panel class to be created instead of DTooltip when the player hovers over this panel and a tooltip needs creating.
---@param override string The panel class to override the default DTooltip. The new panel class must have the following methods: * Panel:SetText - If you are using Panel:SetTooltip. * DTooltip:SetContents - If you are using Panel:SetTooltipPanel. * DTooltip:OpenForPanel - A "hook" type function that gets called shortly after creation (and after the above 2) to open and position the tooltip. You can see this logic in `lua/includes/util/tooltips.lua`.
function Panel:SetTooltipPanelOverride(override) end

-- Sets the underlined font for use by clickable text in a RichText. See also Panel:InsertClickableTextStart  This function will only work on RichText panels.
---@param fontName string The name of the font.  See Default_Fonts for a list of existing fonts. Alternatively, use surface.CreateFont to create your own custom font.
function Panel:SetUnderlineFont(fontName) end

-- Sets the URL of a link-based panel such as DLabelURL.
---@param url string The URL to set. It **must** begin with either `http://` or `https://`.
function Panel:SetURL(url) end

-- Sets the visibility of the vertical scrollbar.  Works for RichText and TextEntry.
---@param display? boolean True to display the vertical text scroll bar, false to hide it.
function Panel:SetVerticalScrollbarEnabled(display) end

-- Sets the "visibility" of the panel.
---@param visible boolean The visibility of the panel.
function Panel:SetVisible(visible) end

-- Sets width of a panel. An alias of Panel:SetWidth.
---@param width number Desired width to set
function Panel:SetWide(width) end

-- Sets the width of the panel.  Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout).   See also Panel:SetSize.
---@param width number The new width of the panel.
function Panel:SetWidth(width) end

-- This makes it so that when you're hovering over this panel you can `click` on the world. Your viewmodel will aim etc. This is primarily used for the Sandbox context menu.  This function doesn't scale with custom FOV specified by GM:CalcView or WEAPON:TranslateFOV.
---@param enabled boolean
function Panel:SetWorldClicker(enabled) end

-- Sets whether text wrapping should be enabled or disabled on Label and DLabel panels. Use DLabel:SetAutoStretchVertical to automatically correct vertical size; Panel:SizeToContents will not set the correct height.
---@param wrap boolean `True` to enable text wrapping, `false` otherwise.
function Panel:SetWrap(wrap) end

-- Sets the X position of the panel.  Uses Panel:SetPos internally.
---@param x number The X coordinate of the position.
function Panel:SetX(x) end

-- Sets the Y position of the panel.  Uses Panel:SetPos internally.
---@param y number The Y coordinate of the position.
function Panel:SetY(y) end

-- Sets the panels z position which determines the rendering order.  Panels with lower z positions appear behind panels with higher z positions.  This also controls in which order panels docked with Panel:Dock appears.
---@param zIndex number The z position of the panel.  Can't be lower than -32768 or higher than 32767.
function Panel:SetZPos(zIndex) end

-- Makes a panel visible.
function Panel:Show() end

-- Uses animation to resize the panel to the specified size.
---@param sizeW? number The target width of the panel. Use -1 to retain the current width.
---@param sizeH? number The target height of the panel. Use -1 to retain the current height.
---@param time number The time to perform the animation within.
---@param delay? number The delay before the animation starts.
---@param ease? number Easing of the start and/or end speed of the animation. See Panel:NewAnimation for how this works.
---@param callback function The function to be called once the animation finishes. Arguments are: * table animData - The Structures/AnimationData that was used. * Panel pnl - The panel object that was resized.
function Panel:SizeTo(sizeW,sizeH,time,delay,ease,callback) end

-- Resizes the panel to fit the bounds of its children.  Your panel must have its layout updated (Panel:InvalidateLayout) for this function to work properly. The sizeW and sizeH parameters are false by default. Therefore, calling this function with no arguments will result in a no-op.
---@param sizeW? boolean Resize with width of the panel.
---@param sizeH? boolean Resize the height of the panel.
function Panel:SizeToChildren(sizeW,sizeH) end

-- Resizes the panel so that its width and height fit all of the content inside.  Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.  You must call this function **AFTER** setting text/font, adjusting child panels or otherwise altering the panel.
function Panel:SizeToContents() end

-- Resizes the panel object's width to accommodate all child objects/contents.  Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.  You must call this function **AFTER** setting text/font or adjusting child panels.
---@param addVal? number The number of extra pixels to add to the width. Can be a negative number, to reduce the width.
function Panel:SizeToContentsX(addVal) end

-- Resizes the panel object's height to accommodate all child objects/contents.  Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.  You must call this function **AFTER** setting text/font or adjusting child panels.
---@param addVal? number The number of extra pixels to add to the height.
function Panel:SizeToContentsY(addVal) end

-- Slides the panel in from above.
---@param Length number Time to complete the animation.
function Panel:SlideDown(Length) end

-- Slides the panel out to the top.
---@param Length number Time to complete the animation.
function Panel:SlideUp(Length) end

-- Begins a box selection, enables mouse capture for the panel object, and sets the start point of the selection box to the mouse cursor's position, relative to this object. For this to work, either the object or its parent must be enabled as a selection canvas. This is set using Panel:SetSelectionCanvas.
function Panel:StartBoxSelection() end

-- Stops all panel animations by clearing its animation list. This also clears all delayed animations.
function Panel:Stop() end

-- Resizes the panel object's height so that its bottom is aligned with the top of the passed panel. An offset greater than zero will reduce the panel's height to leave a gap between it and the passed panel.
---@param tgtPanel Panel The panel to align the bottom of this one with.
---@param offset? number The gap to leave between this and the passed panel. Negative values will cause the panel's height to increase, forming an overlap.
function Panel:StretchBottomTo(tgtPanel,offset) end

-- Resizes the panel object's width so that its right edge is aligned with the left of the passed panel. An offset greater than zero will reduce the panel's width to leave a gap between it and the passed panel.
---@param tgtPanel Panel The panel to align the right edge of this one with.
---@param offset? number The gap to leave between this and the passed panel. Negative values will cause the panel's width to increase, forming an overlap.
function Panel:StretchRightTo(tgtPanel,offset) end

-- Sets the dimensions of the panel to fill its parent. It will only stretch in directions that aren't nil.
---@param offsetLeft number The left offset to the parent.
---@param offsetTop number The top offset to the parent.
---@param offsetRight number The right offset to the parent.
---@param offsetBottom number The bottom offset to the parent.
function Panel:StretchToParent(offsetLeft,offsetTop,offsetRight,offsetBottom) end

-- Toggles the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable. To check whether the object is selected or not, Panel:IsSelected is used.
function Panel:ToggleSelection() end

-- Toggles the visibility of a panel and all its children.
function Panel:ToggleVisible() end

-- Restores the last saved state (caret position and the text inside) of a TextEntry. Should act identically to pressing CTRL+Z in a TextEntry.  See also Panel:SaveUndoState.
function Panel:Undo() end

-- Recursively deselects this panel object and all of its children. This will cascade to all child objects at every level below the parent.
function Panel:UnselectAll() end

-- Forcibly updates the panels' HTML Material, similar to when Paint is called on it.This is only useful if the panel is not normally visible, i.e the panel exists purely for its HTML Material. Only works on with panels that have a HTML Material. See Panel:GetHTMLMaterial for more details. A good place to call this is in the GM:PreRender hook
function Panel:UpdateHTMLTexture() end

-- Use Panel:IsValid instead.Returns if a given panel is valid or not.
---@return boolean
function Panel:Valid() end



---@class PathFollower
PathFollower = PathFollower

-- If you created your path with type "Chase" this functions should be used in place of PathFollower:Update to cause the bot to chase the specified entity.
---@param bot NextBot The bot to update along the path. This can also be a nextbot player (player.CreateNextbot)
---@param ent Entity The entity we want to chase
function PathFollower:Chase(bot,ent) end

-- Compute shortest path from bot to 'goal' via A* algorithm.
---@param from NextBot The nextbot we're generating for.  This can also be a nextbot player (player.CreateNextbot).
---@param to Vector To point
---@param generator? function A funtion that allows you to alter the path generation. See example below for the default function.
---@return boolean
function PathFollower:Compute(from,to,generator) end

-- Draws the path. This is meant for debugging - and uses debug overlay.
function PathFollower:Draw() end

-- Returns the first segment of the path.
---@return table
function PathFollower:FirstSegment() end

-- Returns the age since the path was built
---@return number
function PathFollower:GetAge() end

-- Returns all of the segments of the given path.
---@return table
function PathFollower:GetAllSegments() end

-- The closest position along the path to a position
---@param position Vector The point we're querying for
---@return Vector
function PathFollower:GetClosestPosition(position) end

-- Returns the current goal data. Can return nil if the current goal is invalid, for example immediately after PathFollower:Update.
---@return table
function PathFollower:GetCurrentGoal() end

-- Returns the cursor data
---@return table
function PathFollower:GetCursorData() end

-- Returns the current progress along the path
---@return number
function PathFollower:GetCursorPosition() end

-- Returns the path end position
---@return Vector
function PathFollower:GetEnd() end

-- Returns how close we can get to the goal to call it done.
---@return number
function PathFollower:GetGoalTolerance() end

---@return Entity
function PathFollower:GetHindrance() end

-- Returns the total length of the path
---@return number
function PathFollower:GetLength() end

-- Returns the minimum range movement goal must be along path.
---@return number
function PathFollower:GetMinLookAheadDistance() end

-- Returns the vector position of distance along path
---@param distance number The distance along the path to query
---@return Vector
function PathFollower:GetPositionOnPath(distance) end

-- Returns the path start position
---@return Vector
function PathFollower:GetStart() end

-- Invalidates the current path
function PathFollower:Invalidate() end

-- Returns true if the path is valid
---@return boolean
function PathFollower:IsValid() end

-- Returns the last segment of the path.
---@return table
function PathFollower:LastSegment() end

-- Moves the cursor by give distance.  For a function that sets the distance, see PathFollower:MoveCursorTo.
---@param distance number The distance to move the cursor (in relative world units)
function PathFollower:MoveCursor(distance) end

-- Sets the cursor position to given distance.  For relative distance, see PathFollower:MoveCursor.
---@param distance number The distance to move the cursor (in world units)
function PathFollower:MoveCursorTo(distance) end

-- Moves the cursor of the path to the closest position compared to given vector.
---@param pos Vector
---@param type? number Seek type   0 = SEEK_ENTIRE_PATH - Search the entire path length   1 = SEEK_AHEAD - Search from current cursor position forward toward end of path   2 = SEEK_BEHIND - Search from current cursor position backward toward path start
---@param alongLimit? number
function PathFollower:MoveCursorToClosestPosition(pos,type,alongLimit) end

-- Moves the cursor to the end of the path
function PathFollower:MoveCursorToEnd() end

-- Moves the cursor to the end of the path
function PathFollower:MoveCursorToStart() end

-- Resets the age which is retrieved by PathFollower:GetAge to 0.
function PathFollower:ResetAge() end

-- How close we can get to the goal to call it done
---@param distance number The distance we're setting it to
function PathFollower:SetGoalTolerance(distance) end

-- Sets minimum range movement goal must be along path
---@param mindist number The minimum look ahead distance
function PathFollower:SetMinLookAheadDistance(mindist) end

-- Move the bot along the path.
---@param bot NextBot The bot to update along the path
function PathFollower:Update(bot) end



---@class PhysCollide
PhysCollide = PhysCollide

-- Destroys the PhysCollide object.
function PhysCollide:Destroy() end

-- Checks whether this PhysCollide object is valid or not.  You should just use Global.IsValid instead.
---@return boolean
function PhysCollide:IsValid() end

-- Performs a trace against this PhysCollide with the given parameters. This can be used for both line traces and box traces.
---@param origin Vector The origin for the PhysCollide during the trace
---@param angles Angle The angles for the PhysCollide during the trace
---@param rayStart Vector The start position of the trace
---@param rayEnd Vector The end position of the trace
---@param rayMins Vector The mins of the trace's bounds
---@param rayMaxs Vector The maxs of the trace's bounds
---@return Vector
---@return Vector
---@return number
function PhysCollide:TraceBox(origin,angles,rayStart,rayEnd,rayMins,rayMaxs) end



---@class PhysObj
PhysObj = PhysObj

-- Adds the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) velocity to the current PhysObj.
---@param angularVelocity Vector The additional velocity in `degrees/s`. (Local to the physics object.) Does nothing on frozen objects.
function PhysObj:AddAngleVelocity(angularVelocity) end

-- Adds one or more bit flags.
---@param flags number Bitflag, see Enums/FVPHYSICS.
function PhysObj:AddGameFlag(flags) end

-- Adds the specified velocity to the current.
---@param velocity Vector Additional velocity in `source_unit/s`. (World frame) Does nothing on frozen objects.
function PhysObj:AddVelocity(velocity) end

-- Rotates the object so that it's angles are aligned to the ones inputted.
---@param from Angle
---@param to Angle
---@return Angle
function PhysObj:AlignAngles(from,to) end

-- Applies the specified impulse in the mass center of the physics object.  This will not work on players, use Entity:SetVelocity instead.
---@param impulse Vector The [impulse](https://en.wikipedia.org/wiki/Impulse_(physics)) to be applied in `kg*source_unit/s`. (The vector is in world frame)
function PhysObj:ApplyForceCenter(impulse) end

-- Applies the specified impulse on the physics object at the specified position.
---@param impulse Vector The impulse to be applied in `kg*source_unit/s`. (World frame)
---@param position Vector The position in world coordinates (`source units`) where the force is applied to the physics object.
function PhysObj:ApplyForceOffset(impulse,position) end

-- Applies the specified angular impulse to the physics object. See PhysObj:CalculateForceOffset
---@param angularImpulse Vector The angular impulse to be applied in `kg * m^2 * degrees / s`. (The vector is in world frame)  The unit conversion between meters and source units in this case is `1 meter ≈ 39.37 source units (100/2.54 exactly)` 
function PhysObj:ApplyTorqueCenter(angularImpulse) end

-- Calculates the linear and angular impulse on the object's center of mass for an offset impulse.The outputs can be used with PhysObj:ApplyForceCenter and PhysObj:ApplyTorqueCenter, respectively. **Be careful to convert the angular impulse to world frame (PhysObj:LocalToWorldVector) if you are going to use it with ApplyTorqueCenter.**
---@param impulse Vector The impulse acting on the object in `kg*source_unit/s`. (World frame)
---@param position Vector The location of the impulse in world coordinates (`source units`)
---@return Vector
---@return Vector
function PhysObj:CalculateForceOffset(impulse,position) end

-- Calculates the linear and angular velocities on the center of mass for an offset impulse. The outputs can be directly passed to PhysObj:AddVelocity and PhysObj:AddAngleVelocity, respectively.  This will return zero length vectors if the physics object's motion is disabled. See PhysObj:IsMotionEnabled.
---@param impulse Vector The impulse acting on the object in `kg*source_unit/s`. (World frame)
---@param position Vector The location of the impulse in world coordinates (`source units`)
---@return Vector
---@return Vector
function PhysObj:CalculateVelocityOffset(impulse,position) end

-- Removes one of more specified flags.
---@param flags number Bitflag, see Enums/FVPHYSICS.
function PhysObj:ClearGameFlag(flags) end

-- Allows you to move a PhysObj to a point and angle in 3D space.
---@param shadowparams table The parameters for the shadow. See example code to see how its used.
function PhysObj:ComputeShadowControl(shadowparams) end

-- Sets whether the physics object should collide with anything or not, including world.  This function currently has major problems with player collisions, and as such should be avoided at all costs.    A better alternative to this function would be using Entity:SetCollisionGroup( COLLISION_GROUP_WORLD ).
---@param enable boolean True to enable, false to disable.
function PhysObj:EnableCollisions(enable) end

-- Sets whenever the physics object should be affected by drag.
---@param enable boolean True to enable, false to disable.
function PhysObj:EnableDrag(enable) end

-- Sets whether the PhysObject should be affected by gravity
---@param enable boolean True to enable, false to disable.
function PhysObj:EnableGravity(enable) end

-- Sets whether the physobject should be able to move or not.  This is the exact method the Physics Gun uses to freeze props. If a motion-disabled physics object is grabbed with the physics gun, the object will be able to move again. To disallow this, use GM:PhysgunPickup.
---@param enable boolean True to enable, false to disable.
function PhysObj:EnableMotion(enable) end

-- Returns the mins and max of the physics object.
---@return Vector
---@return Vector
function PhysObj:GetAABB() end

-- Returns the angles of the physics object in degrees.
---@return Angle
function PhysObj:GetAngles() end

-- Gets the angular velocity of the object in degrees per second as a local vector. You can use dot product to read the magnitude from a specific axis.
---@return Vector
function PhysObj:GetAngleVelocity() end

-- Returns the contents flag of the PhysObj.
---@return number
function PhysObj:GetContents() end

-- Returns the linear and angular damping of the physics object.
---@return number
---@return number
function PhysObj:GetDamping() end

-- Returns the sum of the linear and rotational kinetic energies of the physics object.
---@return number
function PhysObj:GetEnergy() end

-- Returns the parent entity of the physics object.
---@return Entity
function PhysObj:GetEntity() end

-- Returns the friction snapshot of this physics object. This is useful for determining if an object touching ground for example.
---@return table
function PhysObj:GetFrictionSnapshot() end

-- Returns the principal moments of inertia `(Ixx, Iyy, Izz)` of the physics object, in the local frame, with respect to the center of mass.
---@return Vector
function PhysObj:GetInertia() end

-- Returns 1 divided by the angular inertia. See PhysObj:GetInertia
---@return Vector
function PhysObj:GetInvInertia() end

-- Returns 1 divided by the physics object's mass (in kilograms).
---@return number
function PhysObj:GetInvMass() end

-- Returns the mass of the physics object.
---@return number
function PhysObj:GetMass() end

-- Returns the center of mass of the physics object as a local vector.
---@return Vector
function PhysObj:GetMassCenter() end

-- Returns the physical material of the physics object.
---@return string
function PhysObj:GetMaterial() end

-- Returns the physics mesh of the object which is used for physobj-on-physobj collision.
---@return table
function PhysObj:GetMesh() end

-- Returns all convex physics meshes of the object. See Entity:PhysicsInitMultiConvex for more information.
---@return table
function PhysObj:GetMeshConvexes() end

-- Returns the name of the physics object.
---@return string
function PhysObj:GetName() end

-- Returns the position of the physics object.
---@return Vector
function PhysObj:GetPos() end

-- Returns the position and angle of the physics object as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.
---@return VMatrix
function PhysObj:GetPositionMatrix() end

-- Returns the rotation damping of the physics object.
---@return number
function PhysObj:GetRotDamping() end

-- Returns the angles of the PhysObj shadow. See PhysObj:UpdateShadow.
---@return Angle
function PhysObj:GetShadowAngles() end

-- Returns the position of the PhysObj shadow. See PhysObj:UpdateShadow.
---@return Vector
function PhysObj:GetShadowPos() end

-- Returns the speed damping of the physics object.
---@return number
function PhysObj:GetSpeedDamping() end

-- Returns the internal and external stress of the entity.
---@return number
---@return number
function PhysObj:GetStress() end

-- Returns the surface area of the physics object in source-units². Or nil if the PhysObj is a generated sphere or box.
---@return number
function PhysObj:GetSurfaceArea() end

-- Returns the absolute directional velocity of the physobject.
---@return Vector
function PhysObj:GetVelocity() end

-- Returns the world velocity of a point in world coordinates about the object. This is useful for objects rotating around their own axis/origin.
---@param point Vector A point to test in world space coordinates
---@return Vector
function PhysObj:GetVelocityAtPoint(point) end

-- Returns the volume in source units³. Or nil if the PhysObj is a generated sphere or box.
---@return number
function PhysObj:GetVolume() end

-- Returns whenever the specified flag(s) is/are set.
---@param flags number Bitflag, see Enums/FVPHYSICS.
---@return boolean
function PhysObj:HasGameFlag(flags) end

-- Returns whether the physics object is "sleeping".  See PhysObj:Sleep for more information.
---@return boolean
function PhysObj:IsAsleep() end

-- Returns whenever the entity is able to collide or not.
---@return boolean
function PhysObj:IsCollisionEnabled() end

-- Returns whenever the entity is affected by drag.
---@return boolean
function PhysObj:IsDragEnabled() end

-- Returns whenever the entity is affected by gravity.
---@return boolean
function PhysObj:IsGravityEnabled() end

-- Returns if the physics object can move itself (by velocity, acceleration)
---@return boolean
function PhysObj:IsMotionEnabled() end

-- Returns whenever the entity is able to move.
---@return boolean
function PhysObj:IsMoveable() end

-- Returns whenever the physics object is penetrating another physics object.  This is internally implemented as `PhysObj:HasGameFlag( FVPHYSICS_PENETRATING )` and thus is only updated for non-static physics objects.
---@return boolean
function PhysObj:IsPenetrating() end

-- Returns if the physics object is valid/not NULL.
---@return boolean
function PhysObj:IsValid() end

-- Mapping a vector in local frame of the physics object to world frame.  this function does translation and rotation, with translation done first.
---@param LocalVec Vector A vector in the physics object's local frame
---@return Vector
function PhysObj:LocalToWorld(LocalVec) end

-- Rotate a vector from the local frame of the physics object to world frame.  This function only rotates the vector, without any translation operation.
---@param LocalVec Vector A vector in the physics object's local frame
---@return Vector
function PhysObj:LocalToWorldVector(LocalVec) end

-- Prints debug info about the state of the physics object to the console.
function PhysObj:OutputDebugInfo() end

-- Call this when the collision filter conditions change due to this object's state (e.g. changing solid type or collision group)
function PhysObj:RecheckCollisionFilter() end

-- A convinience function for Angle:RotateAroundAxis.
---@param dir Vector Direction, around which we will rotate
---@param ang number Amount of rotation, in degrees
---@return Angle
function PhysObj:RotateAroundAxis(dir,ang) end

-- Sets the amount of [drag](https://en.wikipedia.org/wiki/Drag_(physics)) to apply to a physics object when attempting to rotate.
---@param coefficient number [Drag coefficient](https://en.wikipedia.org/wiki/Drag_coefficient). The bigger this value is, the slower the angles will change.
function PhysObj:SetAngleDragCoefficient(coefficient) end

-- Sets the angles of the physobject in degrees.
---@param angles Angle The new angles of the physobject. The new angle will not be applied on the parent entity while the physics object is asleep (PhysObj:Sleep)
function PhysObj:SetAngles(angles) end

-- Sets the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the PhysObj
---@param angularVelocity Vector The new velocity in `degrees/s`. (Local frame)
function PhysObj:SetAngleVelocity(angularVelocity) end

-- Sets the specified instantaneous [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the PhysObj
---@param angularVelocity Vector The new velocity to set velocity.
function PhysObj:SetAngleVelocityInstantaneous(angularVelocity) end

-- Sets the buoyancy ratio of the physics object. (How well it floats in water)
---@param buoyancy number Buoyancy ratio, where 0 is not buoyant at all (like a rock), and 1 is very buoyant (like wood). You can set values larger than 1 for greater effect.
function PhysObj:SetBuoyancyRatio(buoyancy) end

-- Sets the contents flag of the PhysObj.
---@param contents number The Enums/CONTENTS.
function PhysObj:SetContents(contents) end

-- Sets the linear and angular damping of the physics object.
---@param linearDamping number Linear damping.
---@param angularDamping number Angular damping.
function PhysObj:SetDamping(linearDamping,angularDamping) end

-- Modifies how much drag (air resistance) affects the object.
---@param drag number The drag coefficient It can be positive or negative.
function PhysObj:SetDragCoefficient(drag) end

-- Sets the angular inertia. See PhysObj:GetInertia.  This does not affect linear inertia.
---@param angularInertia Vector The angular inertia of the object.
function PhysObj:SetInertia(angularInertia) end

-- Sets the mass of the physics object.
---@param mass number The mass in kilograms, in range `[0, 50000]`
function PhysObj:SetMass(mass) end

-- Sets the material of the physobject.  Impact sounds will only change if this is called on client
---@param materialName string The name of the phys material to use. From this list: [Valve Developer](https://developer.valvesoftware.com/wiki/Material_surface_properties)
function PhysObj:SetMaterial(materialName) end

-- Sets the position of the physobject.
---@param position Vector The new position of the physobject in world coordinates. (`source units`). The new position will not be applied on the parent entity while the physics object is asleep (PhysObj:Sleep)
---@param teleport? boolean
function PhysObj:SetPos(position,teleport) end

-- Sets the velocity of the physics object for the next iteration.
---@param velocity Vector The new velocity of the physics object in `source_unit/s`. (World frame)
function PhysObj:SetVelocity(velocity) end

-- Sets the velocity of the physics object.
---@param velocity Vector The new velocity of the physics object.
function PhysObj:SetVelocityInstantaneous(velocity) end

-- Makes the physics object "sleep".  The physics object will no longer be moving unless it is "woken up" by either a collision with another moving object, or by PhysObj:Wake. This is an optimization feature of the physics engine.
function PhysObj:Sleep() end

-- Unlike PhysObj:SetPos and PhysObj:SetAngles, this allows the movement of a physobj while leaving physics interactions intact. This is used internally by the motion controller of the Gravity Gun , the +use pickup and the Physics Gun, and entities such as the crane.  This is the ideal function to move a physics shadow created with Entity:PhysicsInitShadow or Entity:MakePhysicsObjectAShadow.
---@param targetPosition Vector The position we should move to.
---@param targetAngles Angle The angle we should rotate towards.
---@param frameTime number The frame time to use for this movement, can be generally filled with Global.FrameTime or ENTITY:PhysicsSimulate with the deltaTime.  Can be set to 0 when you need to update the physics object just once.
function PhysObj:UpdateShadow(targetPosition,targetAngles,frameTime) end

-- Wakes the physics object.  See PhysObj:Sleep for more information.
function PhysObj:Wake() end

-- Converts a vector to a relative to the physics object coordinate system.
---@param vec Vector The vector in world space coordinates.
---@return Vector
function PhysObj:WorldToLocal(vec) end

-- Rotate a vector from the world frame to the local frame of the physics object.  This function only rotates the vector, without any translation operation.
---@param WorldVec Vector A vector in the world frame
---@return Vector
function PhysObj:WorldToLocalVector(WorldVec) end



---@class pixelvis_handle_t
pixelvis_handle_t = pixelvis_handle_t



---@class Player
Player = Player

-- Returns the player's AccountID aka SteamID3. (`[U:1:AccountID]`)  See Player:SteamID for the text representation of the full SteamID. See Player:SteamID64 for a 64bit representation of the full SteamID.  Unlike other variations of SteamID, SteamID3 does not include the "Account Type" and "Account Instance" part of the SteamID.  In a `-multirun` environment, this will return `no value` for all "copies" of a player because they are not authenticated with Steam.  For bots this will return values starting with `0` for the first bot, `1` for the second bot and so on.
---@return number
function Player:AccountID() end

-- Adds an entity to the player's clean up list.
---@param type string Cleanup type
---@param ent Entity Entity to add
function Player:AddCleanup(type,ent) end

-- See [GetCount](/gmod/Player:GetCount) for list of typesAdds an entity to the total count of entities of same type.
---@param str string Entity type
---@param ent Entity Entity
function Player:AddCount(str,ent) end

-- Add a certain amount to the player's death count
---@param count number number of deaths to add
function Player:AddDeaths(count) end

-- Add a certain amount to the player's frag count (or kills count)
---@param count number number of frags to add
function Player:AddFrags(count) end

-- Adds a entity to the player's list of frozen objects.
---@param ent Entity Entity
---@param physobj PhysObj Physics object belonging to ent
function Player:AddFrozenPhysicsObject(ent,physobj) end

-- Sets up the voting system for the player. This is a really barebone system. By calling this a vote gets started, when the player presses 0-9 the callback function gets called along with the key the player pressed. Use the draw callback to draw the vote panel.
---@param name string Name of the vote
---@param timeout number Time until the vote expires
---@param vote_callback function The function to be run when the player presses 0-9 while a vote is active.
---@param draw_callback function Used to draw the vote panel.
function Player:AddPlayerOption(name,timeout,vote_callback,draw_callback) end

-- Plays a sequence directly from a sequence number, similar to Player:AnimRestartGesture. This function has the advantage to play sequences that haven't been bound to an existing Enums/ACT
---@param slot number Gesture slot using Enums/GESTURE_SLOT
---@param sequenceId number The sequence ID to play, can be retrieved with Entity:LookupSequence.
---@param cycle number The cycle to start the animation at, ranges from 0 to 1.
---@param autokill? boolean If the animation should not loop. true = stops the animation, false = the animation keeps playing.
function Player:AddVCDSequenceToGestureSlot(slot,sequenceId,cycle,autokill) end

-- Checks if the player is alive.
---@return boolean
function Player:Alive() end

-- Sets if the player can toggle their flashlight. Function exists on both the server and client but has no effect when ran on the client.
---@param canFlashlight boolean True allows flashlight toggling
function Player:AllowFlashlight(canFlashlight) end

-- Lets the player spray their decal without delay
---@param allow boolean Allow or disallow
function Player:AllowImmediateDecalPainting(allow) end

-- Resets player gesture in selected slot.
---@param slot number Slot to reset. See the Enums/GESTURE_SLOT.
function Player:AnimResetGestureSlot(slot) end

-- Restart a gesture on a player, within a gesture slot.  This is not automatically networked. This function has to be called on the client to be seen by said client.
---@param slot number Gesture slot using Enums/GESTURE_SLOT
---@param activity number The activity ( see Enums/ACT ) or sequence that should be played
---@param autokill? boolean Whether the animation should be automatically stopped. true = stops the animation, false = the animation keeps playing/looping
function Player:AnimRestartGesture(slot,activity,autokill) end

-- Restarts the main animation on the player, has the same effect as calling Entity:SetCycle( 0 ).
function Player:AnimRestartMainSequence() end

-- Sets the sequence of the animation playing in the given gesture slot.
---@param slot number The gesture slot. See Enums/GESTURE_SLOT
---@param sequenceID number Sequence ID to set.
function Player:AnimSetGestureSequence(slot,sequenceID) end

-- Sets the weight of the animation playing in the given gesture slot.
---@param slot number The gesture slot. See Enums/GESTURE_SLOT
---@param weight number The weight this slot should be set to. Value must be ranging from 0 to 1.
function Player:AnimSetGestureWeight(slot,weight) end

-- Returns the player's armor.
---@return number
function Player:Armor() end

-- Bans the player from the server for a certain amount of minutes.
---@param minutes number Duration of the ban in minutes (0 is permanent)
---@param kick? boolean Whether to kick the player after banning them or not
function Player:Ban(minutes,kick) end

-- Returns true if the player's flashlight hasn't been disabled by Player:AllowFlashlight.  This is not synchronized between clients and server automatically!
---@return boolean
function Player:CanUseFlashlight() end

-- Prints a string to the chatbox of the client.  Just like the usermessage, this function is affected by the 255 byte limit!
---@param message string String to be printed
function Player:ChatPrint(message) end

-- Checks if the limit is hit or not. If it is, it will throw a notification saying so.
---@param limitType string Limit type. In unmodified Sandbox possible values are: * "props" * "ragdolls" * "vehicles" * "effects" * "balloons" * "cameras" * "npcs" * "sents" * "dynamite" * "lamps" * "lights" * "wheels" * "thrusters" * "hoverballs" * "buttons" * "emitters"
---@return boolean
function Player:CheckLimit(limitType) end

-- Runs the concommand on the player. This does not work on bots.  If you wish to directly modify the movement input of bots, use GM:StartCommand instead.  Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see Blocked ConCommands. On clientside running a ConCommand on an other player will not throw any warnings or errors but will run the ConCommand on LocalPlayer() instead.
---@param command string command to run
function Player:ConCommand(command) end

-- Creates the player's death ragdoll entity and deletes the old one.  This is normally used when a player dies, to create their death ragdoll.  The ragdoll will be created with the player's properties such as Entity:GetPos, Entity:GetAngles, Player:GetPlayerColor, Entity:GetVelocity and Entity:GetModel.  You can retrieve the entity this creates with Player:GetRagdollEntity.
function Player:CreateRagdoll() end

-- Disables the default player's crosshair. Can be reenabled with Player:CrosshairEnable. This will affect WEAPON:DoDrawCrosshair.
function Player:CrosshairDisable() end

-- Enables the player's crosshair, if it was previously disabled via Player:CrosshairDisable.
function Player:CrosshairEnable() end

-- Returns whether the player is crouching or not (Enums/FL flag).
---@return boolean
function Player:Crouching() end

-- Returns the player's death count
---@return number
function Player:Deaths() end

-- Prints the players' name and position to the console.
function Player:DebugInfo() end

-- Detonates all tripmines belonging to the player.
function Player:DetonateTripmines() end

-- Disables world clicking for given player. See Panel:SetWorldClicker and Player:IsWorldClickingDisabled.
---@param disable boolean Whether the world clicking should be disabled.
function Player:DisableWorldClicking(disable) end

-- Sends a third person animation event to the player.  Calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event, data as the given data.
---@param data number The data to send.
function Player:DoAnimationEvent(data) end

-- Starts the player's attack animation. The attack animation is determined by the weapon's HoldType.  Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoAttackEvent() end

-- Sends a specified third person animation event to the player.  Calls GM:DoAnimationEvent with specified arguments.
---@param event number The event to send. See Enums/PLAYERANIMEVENT.
---@param data number The data to send alongside the event.
function Player:DoCustomAnimEvent(event,data) end

-- Sends a third person reload animation event to the player.  Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoReloadEvent() end

-- Sends a third person secondary fire animation event to the player.  Similar to other animation event functions, calls GM:DoAnimationEvent with Enums/PLAYERANIMEVENT as the event and no extra data.
function Player:DoSecondaryAttack() end

-- Show/Hide the player's weapon's viewmodel.
---@param draw boolean Should draw
---@param vm? number Which view model to show/hide, 0-2.
function Player:DrawViewModel(draw,vm) end

-- Show/Hide the player's weapon's worldmodel.
---@param draw boolean Should draw
function Player:DrawWorldModel(draw) end

-- Drops the players' weapon of a specific class.
---@param class string The class to drop.
---@param target? Vector If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
---@param velocity? Vector If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
function Player:DropNamedWeapon(class,target,velocity) end

-- Drops any object the player is currently holding with either gravitygun or +Use (E key)
function Player:DropObject() end

-- Forces the player to drop the specified weapon
---@param weapon? Weapon Weapon to be dropped. If unset, will default to the currently equipped weapon.
---@param target? Vector If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
---@param velocity? Vector If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
function Player:DropWeapon(weapon,target,velocity) end

-- Enters the player into specified vehicle
---@param vehicle Vehicle Vehicle the player will enter
function Player:EnterVehicle(vehicle) end

-- Equips the player with the HEV suit.  Allows the player to zoom, walk slowly, sprint, pickup armor batteries, use the health and armor stations and also shows the HUD. The player also emits a flatline sound on death, which can be overridden with GM:PlayerDeathSound.  The player is automatically equipped with the suit on spawn, if you wish to stop that, use Player:RemoveSuit.
function Player:EquipSuit() end

-- Makes the player exit the vehicle if they're in one.
function Player:ExitVehicle() end

-- Enables/Disables the player's flashlight.Player:CanUseFlashlight must be true in order for the player's flashlight to be changed.
---@param isOn boolean Turns the flashlight on/off
function Player:Flashlight(isOn) end

-- Returns true if the player's flashlight is on.
---@return boolean
function Player:FlashlightIsOn() end

-- Returns the amount of frags a player has.  The value will change depending on the player's kill or suicide: +1 for a kill, -1 for a suicide. 
---@return number
function Player:Frags() end

-- Freeze the player. Frozen players cannot move, look around, or attack. Key bindings are still called. Similar to Player:Lock but the player can still take damage.  Adds or removes the Enums/FL flag from the player.  Frozen bots will still be able to look around.
---@param frozen? boolean Whether the player should be frozen.
function Player:Freeze(frozen) end

-- Returns the player's active weapon.  If used on a Global.LocalPlayer() and the player is spectating another player with `OBS_MODE_IN_EYE`, the weapon returned will be of the spectated player.
---@return Weapon
function Player:GetActiveWeapon() end

-- Returns the player's current activity.
---@return number
function Player:GetActivity() end

-- Returns the direction that the player is aiming.
---@return Vector
function Player:GetAimVector() end

-- Returns true if the players' model is allowed to rotate around the pitch and roll axis.
---@return boolean
function Player:GetAllowFullRotation() end

-- Returns whether the player is allowed to use their weapons in a vehicle or not.
---@return boolean
function Player:GetAllowWeaponsInVehicle() end

-- Returns a table of all ammo the player has.
---@return table
function Player:GetAmmo() end

-- Gets the amount of ammo the player has.
---@param ammotype any The ammunition type. Can be either number ammo ID or string ammo name.
---@return number
function Player:GetAmmoCount(ammotype) end

-- Gets if the player will be pushed out of nocollided players.
---@return boolean
function Player:GetAvoidPlayers() end

-- Returns true if the player is able to walk using the (default) alt key.
---@return boolean
function Player:GetCanWalk() end

-- Determines whenever the player is allowed to use the zoom functionality.
---@return boolean
function Player:GetCanZoom() end

-- Returns the player's class id.
---@return number
function Player:GetClassID() end

-- Gets total count of entities of same type.  Default types: ``` balloons buttons cameras dynamite emitters hoverballs lamps lights props ragdolls thrusters wheels ```
---@param type string Type to get entity count of.
---@param minus? number If specified, it will reduce the counter by this value. Works only serverside.
---@return number
function Player:GetCount(type,minus) end

-- Returns the crouched walk speed multiplier.  See also Player:GetWalkSpeed and Player:SetCrouchedWalkSpeed.
---@return number
function Player:GetCrouchedWalkSpeed() end

-- Returns the last command which was sent by the specified player. This can only be called on the player which Global.GetPredictionPlayer() returns.  When called clientside in singleplayer during WEAPON:Think, it will return nothing as the hook is not technically predicted in that instance. See the note on the page.  This will fail in GM:StartCommand.
---@return CUserCmd
function Player:GetCurrentCommand() end

-- Gets the **actual** view offset which equals the difference between the players actual position and their view when standing.  Do not confuse with Player:GetViewOffset and Player:GetViewOffsetDucked
---@return Vector
function Player:GetCurrentViewOffset() end

-- Gets the entity the player is currently driving via the drive library.
---@return Entity
function Player:GetDrivingEntity() end

-- Returns driving mode of the player. See Entity Driving.
---@return number
function Player:GetDrivingMode() end

-- Returns a player's duck speed (in seconds)
---@return number
function Player:GetDuckSpeed() end

-- Returns the entity the player is currently using, like func_tank mounted turrets or +use prop pickups.
---@return Entity
function Player:GetEntityInUse() end

-- Returns a table with information of what the player is looking at.  The results of this function are **cached** clientside every frame.  Uses util.GetPlayerTrace internally and is therefore bound by its limits.  See also Player:GetEyeTraceNoCursor.
---@return table
function Player:GetEyeTrace() end

-- Returns the trace according to the players view direction, ignoring their mouse (holding C and moving the mouse in Sandbox).  The results of this function are **cached** clientside every frame.  Uses util.GetPlayerTrace internally and is therefore bound by its limits.  See also Player:GetEyeTrace.
---@return table
function Player:GetEyeTraceNoCursor() end

-- Returns the FOV of the player.
---@return number
function Player:GetFOV() end

-- Returns the steam "relationship" towards the player.
---@return string
function Player:GetFriendStatus() end

-- Gets the hands entity of a player
---@return Entity
function Player:GetHands() end

-- Returns the widget the player is hovering with their mouse.
---@return Entity
function Player:GetHoveredWidget() end

-- Gets the bottom base and the top base size of the player's hull.
---@return Vector
---@return Vector
function Player:GetHull() end

-- Gets the bottom base and the top base size of the player's crouch hull.
---@return Vector
---@return Vector
function Player:GetHullDuck() end

-- Retrieves the value of a client-side ConVar. The ConVar must have a Enums/FCVAR flag for this to work.  The returned value is truncated to 31 bytes. On client this function will return value of the local player, regardless of which player the function was called on!
---@param cVarName string The name of the client-side ConVar.
---@return string
function Player:GetInfo(cVarName) end

-- Retrieves the numeric value of a client-side convar, returns nil if value is not convertible to a number. The ConVar must have a Enums/FCVAR flag for this to work.
---@param cVarName string The name of the ConVar to query the value of
---@param default number Default value if we failed to retrieve the number.
---@return number
function Player:GetInfoNum(cVarName,default) end

-- Returns the jump power of the player
---@return number
function Player:GetJumpPower() end

-- Returns the player's ladder climbing speed.  See Player:GetWalkSpeed for normal walking speed, Player:GetRunSpeed for sprinting speed and Player:GetSlowWalkSpeed for slow walking speed.
---@return number
function Player:GetLadderClimbSpeed() end

-- Returns the timescale multiplier of the player movement.
---@return number
function Player:GetLaggedMovementValue() end

-- Returns the maximum amount of armor the player should have. Default value is 100.
---@return number
function Player:GetMaxArmor() end

-- Returns the player's maximum movement speed.  See also Player:SetMaxSpeed, Player:GetWalkSpeed and Player:GetRunSpeed.
---@return number
function Player:GetMaxSpeed() end

-- Returns the player's name, this is an alias of Player:Nick.  This function overrides Entity:GetName (in the Lua metatable, not in c++), keep it in mind when dealing with ents.FindByName or any engine function which requires the mapping name.
---@return string
function Player:GetName() end

-- Returns whenever the player is set not to collide with their teammates.
---@return boolean
function Player:GetNoCollideWithTeammates() end

-- Returns the the observer mode of the player
---@return number
function Player:GetObserverMode() end

-- Returns the entity the player is currently observing.  Set using Player:SpectateEntity.
---@return Entity
function Player:GetObserverTarget() end

-- Returns a **P**layer **Data** key-value pair from the SQL database. (sv.db when called on server,  cl.db when called on client)  Internally uses the sql.  This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.  PData is not networked from servers to clients!
---@param key string Name of the PData key
---@param default? any Default value if PData key doesn't exist.
---@return string
function Player:GetPData(key,default) end

-- Returns a player model's color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
---@return Vector
function Player:GetPlayerColor() end

-- Returns a table containing player information.
---@return table
function Player:GetPlayerInfo() end

-- Returns the preferred carry angles of an object, if any are set.  Calls GM:GetPreferredCarryAngles with the target entity and returns the carry angles.
---@param carryEnt Entity Entity to retrieve the carry angles of.
---@return Angle
function Player:GetPreferredCarryAngles(carryEnt) end

-- Returns the widget entity the player is using.  Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.
---@return Entity
function Player:GetPressedWidget() end

-- Returns the weapon the player previously had equipped.
---@return Entity
function Player:GetPreviousWeapon() end

-- You should use Player:GetViewPunchAngles instead. Returns players screen punch effect angle. See Player:ViewPunch and Player:SetViewPunchAngles
---@return Angle
function Player:GetPunchAngle() end

-- Returns players death ragdoll. The ragdoll is created by Player:CreateRagdoll.
---@return Entity
function Player:GetRagdollEntity() end

-- Returns the render angles for the player.
---@return Angle
function Player:GetRenderAngles() end

-- Returns the player's sprint speed.  See also Player:SetRunSpeed, Player:GetWalkSpeed and Player:GetMaxSpeed.
---@return number
function Player:GetRunSpeed() end

-- Returns the position of a Player's view  This is the same as calling Entity:EyePos on the player.
---@return Vector
function Player:GetShootPos() end

-- Returns the player's slow walking speed, which is activated via +WALK keybind.  See Player:GetWalkSpeed for normal walking speed, Player:GetRunSpeed for sprinting speed and Player:GetLadderClimbSpeed for ladder climb speed.
---@return number
function Player:GetSlowWalkSpeed() end

-- Returns the maximum height player can step onto.
---@return number
function Player:GetStepSize() end

-- Returns the player's HEV suit power.  This will only work for the local player when used clientside.
---@return number
function Player:GetSuitPower() end

-- Returns the number of seconds that the player has been timing out for. You can check if a player is timing out with Player:IsTimingOut.  This function is relatively useless because it is tied to the value of the `sv_timeout` ConVar, which is irrelevant to the description above. [This is not considered as a bug](https://discord.com/channels/565105920414318602/567617926991970306/748970396224585738).
---@return number
function Player:GetTimeoutSeconds() end

-- Returns Structures/TOOL table of players current tool, or of the one specified.
---@param mode? string Classname of the tool to retrieve. ( Filename of the tool in gmod_tool/stools/ )
---@return table
function Player:GetTool(mode) end

-- Returns a player's unduck speed (in seconds)
---@return number
function Player:GetUnDuckSpeed() end

-- Returns the entity the player would use if they would press their `+use` keybind. Because entity physics objects usually do not exist on the client, the client's use entity will resolve to whatever the crosshair is placed on within a little less than 72 units of the player's eye position. This differs from the entity returned by the server, which has fully physical use checking. See util.TraceHull.  Issue tracker: [5027](https://github.com/Facepunch/garrysmod-issues/issues/5027)
---@return Entity
function Player:GetUseEntity() end

-- Returns the player's user group. By default, player user groups are loaded from `garrysmod/settings/users.txt`.
---@return string
function Player:GetUserGroup() end

-- Gets the vehicle the player is driving, returns NULL ENTITY if the player is not driving.
---@return Vehicle
function Player:GetVehicle() end

-- Returns the entity the player is using to see from (such as the player itself, the camera, or another entity). This function will return a [NULL Entity] until Player:SetViewEntity has been used
---@return Entity
function Player:GetViewEntity() end

-- Returns the player's view model entity by the index. Each player has 3 view models by default, but only the first one is used.  To use the other viewmodels in your SWEP, see Entity:SetWeaponModel.  In the Client States, other players' viewmodels are not available unless they are being spectated.
---@param index? number optional index of the view model to return, can range from 0 to 2
---@return Entity
function Player:GetViewModel(index) end

-- Returns the view offset of the player which equals the difference between the players actual position and their view.  See also Player:GetViewOffsetDucked.
---@return Vector
function Player:GetViewOffset() end

-- Returns the view offset of the player which equals the difference between the players actual position and their view when ducked.  See also Player:GetViewOffset.
---@return Vector
function Player:GetViewOffsetDucked() end

-- Returns players screen punch effect angle.
---@return Angle
function Player:GetViewPunchAngles() end

-- Returns client's view punch velocity. See Player:ViewPunch and Player:SetViewPunchVelocity
---@return Angle
function Player:GetViewPunchVelocity() end

-- Returns the current voice volume scale for given player on client.
---@return number
function Player:GetVoiceVolumeScale() end

-- Returns the player's normal walking speed. Not sprinting, not slow walking. (+walk)  See also Player:SetWalkSpeed, Player:GetMaxSpeed and Player:GetRunSpeed.
---@return number
function Player:GetWalkSpeed() end

-- Returns the weapon for the specified class
---@param className string Class name of weapon
---@return Weapon
function Player:GetWeapon(className) end

-- Returns a player's weapon color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
---@return Vector
function Player:GetWeaponColor() end

-- Returns a table of the player's weapons.
---@return table
function Player:GetWeapons() end

-- Gives the player a weapon.  While this function is meant for weapons/pickupables only, it is **not** restricted to weapons. Any entity can be spawned using this function, including NPCs and SENTs.
---@param weaponClassName string Class name of weapon to give the player
---@param bNoAmmo? boolean Set to true to not give any ammo on weapon spawn. (Reserve ammo set by DefaultClip)
---@return Weapon
function Player:Give(weaponClassName,bNoAmmo) end

-- Gives ammo to a player
---@param amount number Amount of ammo
---@param type any Type of ammo. This is a string for named ammo types, and a number for ammo ID.  You can find a list of default ammo types Default_Ammo_Types.
---@param hidePopup? boolean Hide display popup when giving the ammo
---@return number
function Player:GiveAmmo(amount,type,hidePopup) end

-- Disables god mode on the player.
function Player:GodDisable() end

-- Enables god mode on the player.
function Player:GodEnable() end

-- Returns whether the player has god mode or not, contolled by Player:GodEnable and Player:GodDisable.  This is not synced between the client and server. This will cause the client to always return false even in godmode.
---@return boolean
function Player:HasGodMode() end

-- Returns if the player has the specified weapon
---@param className string Class name of the weapon
---@return boolean
function Player:HasWeapon(className) end

-- Returns if the player is in a vehicle
---@return boolean
function Player:InVehicle() end

-- Returns the player's IP address and connection port in ip:port form Returns `Error!` for bots.
---@return string
function Player:IPAddress() end

-- Returns whether the player is an admin or not. It will also return `true` if the player is Player:IsSuperAdmin by default.  Internally this is determined by Player:IsUserGroup.
---@return boolean
function Player:IsAdmin() end

-- Returns if the player is an bot or not
---@return boolean
function Player:IsBot() end

-- Returns true from the point when the player is sending client info but not fully in the game until they disconnect.
---@return boolean
function Player:IsConnected() end

-- Used to find out if a player is currently 'driving' an entity (by which we mean 'right click &gt; drive' ).
---@return boolean
function Player:IsDrivingEntity() end

-- Returns whether the players movement is currently frozen, controlled by Player:Freeze.
---@return boolean
function Player:IsFrozen() end

-- Returns whether the player identity was confirmed by the steam network.  See also GM:PlayerAuthed.
---@return boolean
function Player:IsFullyAuthenticated() end

-- Returns if a player is the host of the current session.
---@return boolean
function Player:IsListenServerHost() end

-- Returns whether or not the player is muted locally.
---@return boolean
function Player:IsMuted() end

-- Returns true if the player is playing a taunt.
---@return boolean
function Player:IsPlayingTaunt() end

-- Returns whenever the player is heard by the local player clientside, or if the player is speaking serverside.
---@return boolean
function Player:IsSpeaking() end

-- Returns whether the player is currently sprinting or not, specifically if they are holding their sprint key and are allowed to sprint.  This will not check if the player is currently sprinting into a wall. (i.e. holding their sprint key but not moving)
---@return boolean
function Player:IsSprinting() end

-- Returns whenever the player is equipped with the suit item.  This will only work for the local player when used clientside.
---@return boolean
function Player:IsSuitEquipped() end

-- Returns whether the player is a super admin.  Internally this is determined by Player:IsUserGroup. See also Player:IsAdmin.
---@return boolean
function Player:IsSuperAdmin() end

-- Returns true if the player is timing out (i.e. is losing connection), false otherwise.  A player is considered timing out when more than 4 seconds has elapsed since a network packet was received from given player.
---@return boolean
function Player:IsTimingOut() end

-- Returns whether the player is typing in their chat.  This may not work properly if the server uses a custom chatbox.
---@return boolean
function Player:IsTyping() end

-- Returns true/false if the player is in specified group or not. See Player:GetUserGroup for a way to get player's usergroup.
---@param groupname string Group to check the player for.
---@return boolean
function Player:IsUserGroup(groupname) end

-- Returns if the player can be heard by the local player.
---@return boolean
function Player:IsVoiceAudible() end

-- Returns if the player is in the context menu.  Although this is shared, it will only work properly on the CLIENT for the local player. Using this serverside or on other players will return false.
---@return boolean
function Player:IsWorldClicking() end

-- Returns whether the world clicking is disabled for given player or not. See Player:DisableWorldClicking.  This value is meant to be networked to the client, but is not currently.
---@return boolean
function Player:IsWorldClickingDisabled() end

-- Gets whether a key is down. This is not networked to other players, meaning only the local client can see the keys they are pressing.
---@param key number The key, see Enums/IN
---@return boolean
function Player:KeyDown(key) end

-- Gets whether a key was down one tick ago.
---@param key number The key, see Enums/IN
---@return boolean
function Player:KeyDownLast(key) end

-- Gets whether a key was just pressed this tick.
---@param key number Corresponds to an Enums/IN
---@return boolean
function Player:KeyPressed(key) end

-- Gets whether a key was just released this tick.
---@param key number The key, see Enums/IN
---@return boolean
function Player:KeyReleased(key) end

-- Kicks the player from the server. This can not be run before the player has fully joined in. Use game.KickID for that.
---@param reason? string Reason to show for disconnection.  This will be shortened to ~512 chars, though this includes the command itself and the player index so will realistically be more around ~498. It is recommended to avoid going near the limit to avoid truncation.
function Player:Kick(reason) end

-- Kills a player and calls GM:PlayerDeath.
function Player:Kill() end

-- Kills a player without notifying the rest of the server.  This will call GM:PlayerSilentDeath instead of GM:PlayerDeath.
function Player:KillSilent() end

-- This allows the server to mitigate the lag of the player by moving back all the entities that can be lag compensated to the time the player attacked with his weapon.  This technique is most commonly used on things that hit other entities instantaneously, such as traces.  Entity:FireBullets calls this function internally.  Lag compensation only works for players and entities that have been enabled with Entity:SetLagCompensated  Despite being defined shared, it can only be used server-side in a ~search:%3Cpredicted%3EYes.  This function NEEDS to be disabled after you're done with it or it will break the movement of the entities affected!  Lag compensation does not support pose parameters.
---@param lagCompensation boolean The state of the lag compensation, true to enable and false to disable.
function Player:LagCompensation(lagCompensation) end

-- Returns the hitgroup where the player was last hit.
---@return number
function Player:LastHitGroup() end

-- Shows "limit hit" notification in sandbox. This function is only available in Sandbox and its derivatives.
---@param type string Type of hit limit.
function Player:LimitHit(type) end

-- Returns the direction a player is looking as a entity/local-oriented angle.  Unlike Entity:EyeAngles, this function does not include angles of the Player's Entity:GetParent.
---@return Angle
function Player:LocalEyeAngles() end

-- Stops a player from using any inputs, such as moving, turning, or attacking. Key binds are still called. Similar to Player:Freeze but the player takes no damage.  Adds the Enums/FL and Enums/FL flags to the player.  Frozen bots will still be able to look around.
function Player:Lock() end

-- Returns the position of a Kinect bone.
---@param bone number Bone to get the position of. Must be from 0 to 19.
---@return Vector
function Player:MotionSensorPos(bone) end

-- Returns the players name. Identical to Player:Nick and Player:GetName.
---@return string
function Player:Name() end

-- Returns the player's nickname.
---@return string
function Player:Nick() end

-- Returns the 64-bit SteamID aka CommunityID of the Steam Account that owns the Garry's Mod license this player is using. This is useful for detecting players using Steam Family Sharing.  If player is not using Steam Family Sharing, this will return the player's actual SteamID64().  This data will only be available after the player has fully authenticated with Steam. See Player:IsFullyAuthenticated.
---@return string
function Player:OwnerSteamID64() end

-- Returns the packet loss of the client. It is not networked so it only returns 0 when run clientside.
---@return number
function Player:PacketLoss() end

-- Unfreezes the props player is looking at. This is essentially the same as pressing reload with the physics gun, including double press for unfreeze all.
---@return number
function Player:PhysgunUnfreeze() end

-- This makes the player hold ( same as pressing E on a small prop ) the provided entity.  Don't get this confused with picking up items like ammo or health kits  This picks up the passed entity regardless of its mass or distance from the player
---@param entity Entity Entity to pick up.
function Player:PickupObject(entity) end

-- Forces the player to pickup an existing weapon entity. The player will not pick up the weapon if they already own a weapon of given type, or if the player could not normally have this weapon in their inventory.  This function **will** bypass GM:PlayerCanPickupWeapon.
---@param wep Weapon The weapon to try to pick up.
---@param ammoOnly? boolean If set to true, the player will only attempt to pick up the ammo from the weapon. The weapon will not be picked up even if the player doesn't have a weapon of this type, and the weapon will be removed if the player picks up any ammo from it.
---@return boolean
function Player:PickupWeapon(wep,ammoOnly) end

-- Returns the player's ping to server.
---@return number
function Player:Ping() end

-- Plays the correct step sound according to what the player is staying on.
---@param volume number Volume for the sound, in range from 0 to 1
function Player:PlayStepSound(volume) end

-- Displays a message either in their chat, console, or center of the screen. See also Global.PrintMessage.  When called serverside, this uses the archaic user message system (the umsg) and hence is limited to ≈250 characters.  `HUD_PRINTCENTER` will not work when this is called clientside.
---@param type number Which type of message should be sent to the player (Enums/HUD).
---@param message string Message to be sent to the player.
function Player:PrintMessage(type,message) end

-- Removes all ammo from a certain player
function Player:RemoveAllAmmo() end

-- Removes all weapons and ammo from the player.
function Player:RemoveAllItems() end

-- Removes the amount of the specified ammo from the player.
---@param ammoCount number The amount of ammunition to remove.
---@param ammoName string The name of the ammunition to remove from. This can also be a number ammoID.
function Player:RemoveAmmo(ammoCount,ammoName) end

-- Removes a **P**layer **Data** key-value pair from the SQL database. (sv.db when called on server,  cl.db when called on client)  Internally uses the sql.  This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
---@param key string Key to remove
---@return boolean
function Player:RemovePData(key) end

-- Strips the player's suit item.
function Player:RemoveSuit() end

-- Resets both normal and duck hulls to their default values.
function Player:ResetHull() end

-- Forces the player to say whatever the first argument is. Works on bots too.  This function ignores the default chat message cooldown
---@param text string The text to force the player to say.
---@param teamOnly? boolean Whether to send this message to our own team only.
function Player:Say(text,teamOnly) end

-- Fades the screen
---@param flags number Fade flags defined with Enums/SCREENFADE.
---@param clr? number The color of the screenfade
---@param fadeTime number Fade(in/out) effect transition time ( From no fade to full fade and vice versa ).  This is limited to 7 bits integer part and 9 bits fractional part.
---@param fadeHold number Fade effect hold time.  This is limited to 7 bits integer part and 9 bits fractional part.
function Player:ScreenFade(flags,clr,fadeTime,fadeHold) end

-- Sets the active weapon of the player by its class name.  This will switch the weapon out of prediction, causing delay on the client and WEAPON:Deploy and WEAPON:Holster to be called out of prediction. Try using CUserCmd:SelectWeapon or input.SelectWeapon, instead.  This will trigger the weapon switch event and associated animations. To switch weapons silently, use Player:SetActiveWeapon.
---@param className string The class name of the weapon to switch to.  If the player doesn't have the specified weapon, nothing will happen. You can use Player:Give to give the weapon first.
function Player:SelectWeapon(className) end

-- Sends a hint to a player.  This function is only available in Sandbox and its derivatives. Since this adds `#Hint_` to the beginning of each message, you should only use it with default hint messages, or those cached with language.Add. For hints with custom text, look at notification.AddLegacy.
---@param name string Name/class/index of the hint. The text of the hint will contain this value. ( "#Hint_" .. name ) An example is `PhysgunFreeze`.
---@param delay number Delay in seconds before showing the hint
function Player:SendHint(name,delay) end

-- Executes a simple Lua string on the player. If you need to use this function more than once consider using net library. Send net message and make the entire code you want to execute in net.Receive on client.  The string is limited to 254 bytes. Consider using the Net_Library_Usage for more advanced server-client interaction.
---@param script string The script to execute.
function Player:SendLua(script) end

-- Sets the player's active weapon. You should use CUserCmd:SelectWeapon or Player:SelectWeapon, instead in most cases.  This function will not trigger the weapon switch events or associated equip animations. It will bypass GM:PlayerSwitchWeapon and the currently active weapon's WEAPON:Holster return value.
---@param weapon Weapon The weapon to equip.
function Player:SetActiveWeapon(weapon) end

-- Sets the player's activity.
---@param act number The new activity to set. See Enums/ACT.
function Player:SetActivity(act) end

-- Set if the players' model is allowed to rotate around the pitch and roll axis.
---@param Allowed boolean Allowed to rotate
function Player:SetAllowFullRotation(Allowed) end

-- Allows player to use their weapons in a vehicle. You need to call this before entering a vehicle.  Shooting in a vehicle fires two bullets.
---@param allow boolean Show we allow player to use their weapons in a vehicle or not.
function Player:SetAllowWeaponsInVehicle(allow) end

-- Sets the amount of the specified ammo for the player.
---@param ammoCount number The amount of ammunition to set.
---@param ammoType any The ammunition type. Can be either number ammo ID or string ammo name.
function Player:SetAmmo(ammoCount,ammoType) end

-- Sets the player armor to the argument.
---@param Amount number The amount that the player armor is going to be set to.
function Player:SetArmor(Amount) end

-- Pushes the player away from another player whenever it's inside the other players bounding box.
---@param avoidPlayers boolean Avoid or not avoid.
function Player:SetAvoidPlayers(avoidPlayers) end

-- Set if the player should be allowed to walk using the (default) alt key.
---@param abletowalk boolean True allows the player to walk.
function Player:SetCanWalk(abletowalk) end

-- Sets whether the player can use the HL2 suit zoom ("+zoom" bind) or not.
---@param canZoom boolean Whether to make the player able or unable to zoom.
function Player:SetCanZoom(canZoom) end

-- Sets the player's class id.
---@param classID number The class id the player is being set with.
function Player:SetClassID(classID) end

-- Sets the crouched walk speed multiplier.  Doesn't work for values above 1.  See also Player:SetWalkSpeed and Player:GetCrouchedWalkSpeed.
---@param speed number The walk speed multiplier that crouch speed should be.
function Player:SetCrouchedWalkSpeed(speed) end

-- Sets the **actual** view offset which equals the difference between the players actual position and their view when standing.  Do not confuse with Player:SetViewOffset and Player:SetViewOffsetDucked
---@param viewOffset Vector The new view offset.
function Player:SetCurrentViewOffset(viewOffset) end

-- Sets a player's death count
---@param deathcount number Number of deaths (positive or negative)
function Player:SetDeaths(deathcount) end

--  Sets the driving entity and driving mode.  Use drive.PlayerStartDriving instead, see Entity Driving.
---@param drivingEntity? Entity The entity the player should drive.
---@param drivingMode number The driving mode index.
function Player:SetDrivingEntity(drivingEntity,drivingMode) end

-- Applies the specified sound filter to the player.
---@param soundFilter number The index of the sound filter to apply. Pick from the [list of DSP's](https://developer.valvesoftware.com/wiki/Dsp_presets).
---@param fastReset boolean If set to true the sound filter will be removed faster.
function Player:SetDSP(soundFilter,fastReset) end

-- Sets how quickly a player ducks.  This will not work for values &gt;= 1.
---@param duckSpeed number How quickly the player will duck.
function Player:SetDuckSpeed(duckSpeed) end

-- Sets the local angle of the player's view (may rotate body too if angular difference is large)
---@param angle Angle Angle to set the view to
function Player:SetEyeAngles(angle) end

-- Set a player's FOV (Field Of View) over a certain amount of time.
---@param fov number the angle of perception (FOV). Set to 0 to return to default user FOV. ( Which is ranging from 75 to 90, depending on user settings )
---@param time? number the time it takes to transition to the FOV expressed in a floating point.
---@param requester? Entity The requester or "owner" of the zoom event. Only this entity will be able to change the player's FOV until it is set back to 0.
function Player:SetFOV(fov,time,requester) end

-- Sets a player's frags (kills)
---@param fragcount number Number of frags (positive or negative)
function Player:SetFrags(fragcount) end

-- Sets the hands entity of a player.  The hands entity is an entity introduced in Garry's Mod 13 and it's used to show the player's hands attached to the viewmodel. This is similar to the approach used in L4D and CS:GO, for more information on how to implement this system in your gamemode visit Using Viewmodel Hands.
---@param hands Entity The hands entity to set
function Player:SetHands(hands) end

-- Sets the widget that is currently hovered by the player's mouse.
---@param widget? Entity The widget entity that the player is hovering.
function Player:SetHoveredWidget(widget) end

-- Sets the mins and maxs of the AABB of the players collision.  See Player:SetHullDuck for the hull while crouching/ducking.
---@param hullMins Vector The min coordinates of the hull.
---@param hullMaxs Vector The max coordinates of the hull.
function Player:SetHull(hullMins,hullMaxs) end

-- Sets the mins and maxs of the AABB of the players collision when ducked.  See Player:SetHull for setting the hull while standing.
---@param hullMins Vector The min coordinates of the hull.
---@param hullMaxs Vector The max coordinates of the hull.
function Player:SetHullDuck(hullMins,hullMaxs) end

-- Sets the jump power, eg. the velocity that will be applied to the player when they jump.
---@param jumpPower number The new jump velocity.
function Player:SetJumpPower(jumpPower) end

-- Sets the player's ladder climbing speed.  See Player:SetWalkSpeed for normal walking speed, Player:SetRunSpeed for sprinting speed and Player:SetSlowWalkSpeed for slow walking speed.
---@param speed number The ladder climbing speed.
function Player:SetLadderClimbSpeed(speed) end

-- Slows down the player movement simulation by the timescale, this is used internally in the HL2 weapon stripping sequence.  It achieves such behavior by multiplying the Global.FrameTime by the specified timescale at the start of the movement simulation and then restoring it afterwards.  This is reset to 1 on spawn.  There is no weapon counterpart to this, you'll have to hardcode the multiplier in the weapon or call Weapon:SetNextPrimaryFire / Weapon:SetNextSecondaryFire manually from a.
---@param timescale number The timescale multiplier.
function Player:SetLaggedMovementValue(timescale) end

-- Sets the hitgroup where the player was last hit.
---@param hitgroup number The hitgroup to set as the "last hit", see Enums/HITGROUP.
function Player:SetLastHitGroup(hitgroup) end

-- Sets the maximum amount of armor the player should have. This affects default built-in armor pickups, but not Player:SetArmor.
---@param maxarmor number The new max armor value.
function Player:SetMaxArmor(maxarmor) end

-- Sets the maximum speed which the player can move at.  This is called automatically by the engine. If you wish to limit player speed without setting their run/sprint speeds, see CMoveData:SetMaxClientSpeed.
---@param walkSpeed number The maximum speed.
function Player:SetMaxSpeed(walkSpeed) end

-- Sets if the player should be muted locally.
---@param mute boolean Mute or unmute.
function Player:SetMuted(mute) end

-- Sets whenever the player should not collide with their teammates.  This will only work for teams with ID 1 to 4 due to internal Engine limitations. This causes traces with Enums/COLLISION_GROUP to pass through players.
---@param shouldNotCollide boolean True to disable, false to enable collision.
function Player:SetNoCollideWithTeammates(shouldNotCollide) end

-- Sets the players visibility towards NPCs.  Internally this toggles the Enums/FL flag, which you can manually test for using Entity:IsFlagSet
---@param visibility boolean The visibility.
function Player:SetNoTarget(visibility) end

-- Sets the players observer mode. You must start the spectating first with Player:Spectate.
---@param mode number Spectator mode using Enums/OBS_MODE.
function Player:SetObserverMode(mode) end

-- Writes a **P**layer **Data** key-value pair to the SQL database. (sv.db when called on server,  cl.db when called on client)  Internally uses the sql.  This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.  PData is not networked from servers to clients!
---@param key string Name of the PData key
---@param value any Value to write to the key (**must** be an SQL valid data type, such as a string or integer)
---@return boolean
function Player:SetPData(key,value) end

-- Sets the player model's color. The part of the model that is colored is determined by the model itself, and is different for each model.
---@param Color Vector This is the color to be set. The format is Vector(r, g, b), and each color should be between 0 and 1.
function Player:SetPlayerColor(Color) end

-- Sets the widget that is currently in use by the player's mouse.  Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.
---@param pressedWidget? Entity The widget the player is currently using.
function Player:SetPressedWidget(pressedWidget) end

-- Sets the render angles of a player.
---@param ang Angle The new render angles to set
function Player:SetRenderAngles(ang) end

-- Sets the player's sprint speed.  See also Player:GetRunSpeed, Player:SetWalkSpeed and Player:SetMaxSpeed. player_default class run speed is: `600`
---@param runSpeed number The new sprint speed when `sv_friction` is below `10`. Higher `sv_friction` values will result in slower speed.  Has to be `7` or above or the player **won't** be able to move.
function Player:SetRunSpeed(runSpeed) end

-- Sets the player's slow walking speed, which is activated via +WALK keybind.  See Player:SetWalkSpeed for normal walking speed, Player:SetRunSpeed for sprinting speed and Player:SetLadderClimbSpeed for ladder climb speed.
---@param speed number The new slow walking speed.
function Player:SetSlowWalkSpeed(speed) end

-- Sets the maximum height a player can step onto without jumping.
---@param stepHeight number The new maximum height the player can step onto without jumping
function Player:SetStepSize(stepHeight) end

-- Sets the player's HEV suit power.  This will only work for the local player when used clientside.
---@param power number The new suit power.
function Player:SetSuitPower(power) end

-- Sets whenever to suppress the pickup notification for the player.
---@param doSuppress boolean Whenever to suppress the notice or not.
function Player:SetSuppressPickupNotices(doSuppress) end

-- Sets the player to the chosen team.
---@param Team number The team that the player is being set to.
function Player:SetTeam(Team) end

-- Sets how quickly a player un-ducks
---@param UnDuckSpeed number How quickly the player will un-duck
function Player:SetUnDuckSpeed(UnDuckSpeed) end

-- Sets up the players view model hands. Calls GM:PlayerSetHandsModel to set the model of the hands.
---@param ent Entity If the player is spectating an entity, this should be the entity the player is spectating, so we can use its hands model instead.
function Player:SetupHands(ent) end

-- Sets the usergroup of the player.
---@param groupName string The user group of the player.
function Player:SetUserGroup(groupName) end

-- Attaches the players view to the position and angles of the specified entity.
---@param viewEntity Entity The entity to attach the player view to.
function Player:SetViewEntity(viewEntity) end

-- Sets the **desired** view offset which equals the difference between the players actual position and their view when standing.  If you want to set **actual** view offset, use Player:SetCurrentViewOffset  See also Player:SetViewOffsetDucked for **desired** view offset when crouching.
---@param viewOffset Vector The new desired view offset when standing.
function Player:SetViewOffset(viewOffset) end

-- Sets the **desired** view offset which equals the difference between the players actual position and their view when crouching.  If you want to set **actual** view offset, use Player:SetCurrentViewOffset  See also Player:SetViewOffset for **desired** view offset when standing.
---@param viewOffset Vector The new desired view offset when crouching.
function Player:SetViewOffsetDucked(viewOffset) end

-- Sets client's view punch angle, but not the velocity. See Player:ViewPunch
---@param punchAngle Angle The angle to set.
function Player:SetViewPunchAngles(punchAngle) end

-- Sets client's view punch velocity. See Player:ViewPunch and Player:SetViewPunchAngles
---@param punchVel Angle The angle velocity to set.
function Player:SetViewPunchVelocity(punchVel) end

-- Sets the voice volume scale for given player on client. This value will persist from server to server, but will be reset when the game is shut down.  This doesn't work on bots, their scale will always be `1`.
---@param var number The voice volume scale, where `0` is 0% and `1` is 100%.
function Player:SetVoiceVolumeScale(var) end

-- Sets the player's normal walking speed. Not sprinting, not slow walking +walk.   See also Player:SetSlowWalkSpeed, Player:GetWalkSpeed, Player:SetCrouchedWalkSpeed, Player:SetMaxSpeed and Player:SetRunSpeed.  Using a speed of `0` can lead to prediction errors.  player_default class walk speed is: `400`
---@param walkSpeed number The new walk speed when `sv_friction` is below `10`. Higher `sv_friction` values will result in slower speed.  Has to be `7` or above or the player **won't** be able to move.
function Player:SetWalkSpeed(walkSpeed) end

-- Sets the player weapon's color. The part of the model that is colored is determined by the model itself, and is different for each model.
---@param Color Vector This is the color to be set. The format is Vector(r,g,b), and each color should be between 0 and 1.
function Player:SetWeaponColor(Color) end

-- Returns whether the player's player model will be drawn at the time the function is called.
---@return boolean
function Player:ShouldDrawLocalPlayer() end

-- Sets whether the player's current weapon should drop on death.  This is reset on spawn to the Player_Classes's **DropWeaponOnDie** field by player_manager.OnPlayerSpawn.
---@param drop boolean Whether to drop the player's current weapon or not
function Player:ShouldDropWeapon(drop) end

-- Opens the player steam profile page in the steam overlay browser.
function Player:ShowProfile() end

-- Signals the entity that it was dropped by the gravity gun.
---@param ent Entity Entity that was dropped.
function Player:SimulateGravGunDrop(ent) end

-- Signals the entity that it was picked up by the gravity gun. This call is only required if you want to simulate the situation of picking up objects.
---@param ent Entity The entity picked up
function Player:SimulateGravGunPickup(ent) end

-- Starts spectate mode for given player. This will also affect the players movetype in some cases.  Using this function while spectating the player's own ragdoll will cause it to teleport it to the center of the map. You will spectate the ragdoll even after it's been teleported. This only happens on the client of the player spectating the ragdoll and is purely client-side.
---@param mode number Spectate mode, see Enums/OBS_MODE.
function Player:Spectate(mode) end

-- Makes the player spectate the entity.  To get the applied spectated entity, use Player:GetObserverTarget.
---@param entity Entity Entity to spectate.
function Player:SpectateEntity(entity) end

-- Makes a player spray their decal.
---@param sprayOrigin Vector The location to spray from
---@param sprayEndPos Vector The location to spray to
function Player:SprayDecal(sprayOrigin,sprayEndPos) end

-- Disables the sprint on the player.  Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead.
function Player:SprintDisable() end

-- Enables the sprint on the player.  Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead.
function Player:SprintEnable() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.  Doesn't appear to do anything.
function Player:StartSprinting() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.  When used in a GM:SetupMove hook, this function will force the player to walk, as well as preventing the player from sprinting.
function Player:StartWalking() end

-- Returns the player's SteamID.  See Player:AccountID for a shorter version of the SteamID and Player:SteamID64 for the Community/Profile formatted SteamID.  In a `-multirun` environment, this will return `STEAM_0:0:0` (serverside) or `NULL` (clientside) for all "copies" of a player because they are not authenticated with Steam.  For Bots this will return `BOT` on the server and on the client it returns `NULL`.
---@return string
function Player:SteamID() end

-- Returns the player's 64-bit SteamID aka CommunityID.  See Player:AccountID for a shorter version of the SteamID and Player:SteamID for the normal version of the SteamID.  In a `-multirun` environment, this will return `nil` for all "copies" of a player because they are not authenticated with Steam.  For bots, this will return `90071996842377216` (equivalent to `STEAM_0:0:0`) for the first bot to join.  For each additional bot, the number increases by 1. So the next bot will be `90071996842377217` (`STEAM_0:1:0`) then `90071996842377218` (`STEAM_0:0:1`) and so on.  It returns `no value` for bots clientside.
---@return string
function Player:SteamID64() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.  When used in a GM:SetupMove hook, this function will prevent the player from sprinting.  When +walk is engaged, the player will still be able to sprint to half speed (normal run speed) as opposed to full sprint speed without this function.
function Player:StopSprinting() end

-- This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.  When used in a GM:SetupMove hook, this function behaves unexpectedly by preventing the player from sprinting similar to Player:StopSprinting.
function Player:StopWalking() end

-- Turns off the zoom mode of the player. (+zoom console command)  Basically equivalent of entering "-zoom" into player's console.
function Player:StopZooming() end

-- Removes all ammo from the player.
function Player:StripAmmo() end

-- Removes the specified weapon class from a certain player this function will call the Entity:OnRemove but if you try use Entity:GetOwner it will return nil
---@param weapon string The weapon class to remove
function Player:StripWeapon(weapon) end

-- Removes all weapons from a certain player
function Player:StripWeapons() end

-- Prevents a hint from showing up.   This function is only available in Sandbox and its derivatives
---@param name string Hint name/class/index to prevent from showing up
function Player:SuppressHint(name) end

-- Attempts to switch the player weapon to the one specified in the "cl_defaultweapon" convar, if the player does not own the specified weapon nothing will happen.  If you want to switch to a specific weapon, use: Player:SetActiveWeapon
function Player:SwitchToDefaultWeapon() end

-- Returns the player's team ID.  Returns 0 clientside when the game is not fully loaded.
---@return number
function Player:Team() end

-- Returns the time in seconds since the player connected. Bots will always return value 0.
---@return number
function Player:TimeConnected() end

-- Performs a trace hull and applies damage to the entities hit, returns the first entity hit.  Hitting the victim entity with this function in ENTITY:OnTakeDamage can cause infinite loops.
---@param startPos Vector The start position of the hull trace.
---@param endPos Vector The end position of the hull trace.
---@param mins Vector The minimum coordinates of the hull.
---@param maxs Vector The maximum coordinates of the hull.
---@param damage number The damage to be applied.
---@param damageFlags number Bitflag specifying the damage type, see Enums/DMG.
---@param damageForce number The force to be applied to the hit object.
---@param damageAllNPCs boolean Whether to apply damage to all hit NPCs or not.
---@return Entity
function Player:TraceHullAttack(startPos,endPos,mins,maxs,damage,damageFlags,damageForce,damageAllNPCs) end

-- Translates Enums/ACT according to the holdtype of players currently held weapon.
---@param act number The initial Enums/ACT
---@return number
function Player:TranslateWeaponActivity(act) end

-- Unfreezes all objects the player has frozen with their Physics Gun. Same as double pressing R while holding Physics Gun.
function Player:UnfreezePhysicsObjects() end

-- Use Player:SteamID64, Player:SteamID or Player:AccountID to uniquely identify players instead.  **This function has collisions,** where more than one player has the same UniqueID. It is **highly** recommended to use Player:AccountID, Player:SteamID or Player:SteamID64 instead, which are guaranteed to be unique to each player.  Returns a 32 bit integer that remains constant for a player across joins/leaves and across different servers. This can be used when a string is inappropriate - e.g. in a database primary key.  In Singleplayer, this function will always return 1.
---@return number
function Player:UniqueID() end

-- This is based on Player:UniqueID which is deprecated and vulnerable to collisions.   Returns a table that will stay allocated for the specific player between connects until the server shuts down. This table is not synchronized between client and server.
---@param key any Unique table key.
---@return table
function Player:UniqueIDTable(key) end

-- Unlocks the player movement if locked previously.  Will disable godmode for the player if locked previously.
function Player:UnLock() end

-- Stops the player from spectating another entity.
function Player:UnSpectate() end

-- Returns the player's ID. You can use Global.Player() to get the player by their ID.
---@return number
function Player:UserID() end

-- Simulates a push on the client's screen. This **adds** view punch velocity, and does not touch the current view punch angle, for which you can use Player:SetViewPunchAngles.
---@param PunchAngle Angle The angle in which to push the player's screen.
function Player:ViewPunch(PunchAngle) end

-- Resets the player's view punch (and the view punch velocity, read more at Player:ViewPunch) effect back to normal.
---@param tolerance? number Reset all ViewPunch below this threshold.
function Player:ViewPunchReset(tolerance) end

-- Returns the players voice volume, how loud the player's voice communication currently is, as a normal number. Doesn't work on local player unless the voice_loopback convar is set to 1.
---@return number
function Player:VoiceVolume() end



---@class ProjectedTexture
ProjectedTexture = ProjectedTexture

-- Returns the angle of the ProjectedTexture, which were previously set by ProjectedTexture:SetAngles
---@return Angle
function ProjectedTexture:GetAngles() end

-- Returns the brightness of the ProjectedTexture, which was previously set by ProjectedTexture:SetBrightness
---@return number
function ProjectedTexture:GetBrightness() end

-- Returns the color of the ProjectedTexture, which was previously set by ProjectedTexture:SetColor.  The returned color will not have the color metatable.
---@return table
function ProjectedTexture:GetColor() end

-- Returns the constant attenuation of the projected texture, which can also be set by ProjectedTexture:SetConstantAttenuation.
---@return number
function ProjectedTexture:GetConstantAttenuation() end

-- Returns whether shadows are enabled for this ProjectedTexture, which was previously set by ProjectedTexture:SetEnableShadows
---@return boolean
function ProjectedTexture:GetEnableShadows() end

-- Returns the projection distance of the ProjectedTexture, which was previously set by ProjectedTexture:SetFarZ
---@return number
function ProjectedTexture:GetFarZ() end

-- Returns the horizontal FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetHorizontalFOV or ProjectedTexture:SetFOV
---@return number
function ProjectedTexture:GetHorizontalFOV() end

-- Returns the linear attenuation of the projected texture, which can also be set by ProjectedTexture:SetLinearAttenuation.
---@return number
function ProjectedTexture:GetLinearAttenuation() end

-- Returns the NearZ value of the ProjectedTexture, which was previously set by ProjectedTexture:SetNearZ
---@return number
function ProjectedTexture:GetNearZ() end

-- Returns the current orthographic settings of the Projected Texture. To set these values, use ProjectedTexture:SetOrthographic.
---@return boolean
---@return number
---@return number
---@return number
---@return number
function ProjectedTexture:GetOrthographic() end

-- Returns the position of the ProjectedTexture, which was previously set by ProjectedTexture:SetPos
---@return Vector
function ProjectedTexture:GetPos() end

-- Returns the quadratic attenuation of the projected texture, which can also be set by ProjectedTexture:SetQuadraticAttenuation.
---@return number
function ProjectedTexture:GetQuadraticAttenuation() end

-- Returns the shadow depth bias of the projected texture.  Set by ProjectedTexture:SetShadowDepthBias.
---@return number
function ProjectedTexture:GetShadowDepthBias() end

-- Returns the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more.  Set by ProjectedTexture:SetShadowFilter.
---@return number
function ProjectedTexture:GetShadowFilter() end

-- Returns the shadow depth slope scale bias of the projected texture.  Set by ProjectedTexture:SetShadowSlopeScaleDepthBias.
---@return number
function ProjectedTexture:GetShadowSlopeScaleDepthBias() end

-- Returns the target entity of this projected texture.
---@return Entity
function ProjectedTexture:GetTargetEntity() end

-- Returns the texture of the ProjectedTexture, which was previously set by ProjectedTexture:SetTexture
---@return ITexture
function ProjectedTexture:GetTexture() end

-- Returns the texture frame of the ProjectedTexture, which was previously set by ProjectedTexture:SetTextureFrame
---@return number
function ProjectedTexture:GetTextureFrame() end

-- Returns the vertical FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetVerticalFOV or ProjectedTexture:SetFOV
---@return number
function ProjectedTexture:GetVerticalFOV() end

-- Returns true if the projected texture is valid (i.e. has not been removed), false otherwise.  Instead of calling this directly it's a good idea to call Global.IsValid in case the variable is nil.   ``` IsValid( ptexture ) ```   This not only checks whether the projected texture is valid - but also checks whether it's nil.
---@return boolean
function ProjectedTexture:IsValid() end

-- Removes the projected texture. After calling this, ProjectedTexture:IsValid will return false, and any hooks with the projected texture as the identifier will be automatically deleted.
function ProjectedTexture:Remove() end

-- Sets the angles (direction) of the projected texture.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param angle Angle
function ProjectedTexture:SetAngles(angle) end

-- Sets the brightness of the projected texture.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param brightness number The brightness to give the projected texture.
function ProjectedTexture:SetBrightness(brightness) end

-- Sets the color of the projected texture.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param color table Must be a Color.  Unlike other projected textures, this color can only go up to 255.
function ProjectedTexture:SetColor(color) end

-- Sets the constant attenuation of the projected texture.  See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetQuadraticAttenuation.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param constAtten number
function ProjectedTexture:SetConstantAttenuation(constAtten) end

-- Enable or disable shadows cast from the projected texture.  As with all types of projected textures (including the player's flashlight and env_projectedtexture), there can only be 8 projected textures with shadows enabled in total.This limit can be increased with the launch parameter `-numshadowtextures LIMIT` where `LIMIT` is the new limit.Naturally, many projected lights with shadows enabled will drastically decrease framerate.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param newState boolean
function ProjectedTexture:SetEnableShadows(newState) end

-- Sets the distance at which the projected texture ends.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param farZ number
function ProjectedTexture:SetFarZ(farZ) end

-- Sets the angle of projection.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param fov number Must be higher than 0 and lower than 180
function ProjectedTexture:SetFOV(fov) end

-- Sets the horizontal angle of projection without affecting the vertical angle.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param hFOV number The new horizontal Field Of View for the projected texture. Must be in range between 0 and 180.
function ProjectedTexture:SetHorizontalFOV(hFOV) end

-- Sets the linear attenuation of the projected texture.  See also ProjectedTexture:SetConstantAttenuation and ProjectedTexture:SetQuadraticAttenuation.  The default value of linear attenuation when the projected texture is created is 100. (others are 0, as you are not supposed to mix them)  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param linearAtten number
function ProjectedTexture:SetLinearAttenuation(linearAtten) end

-- Sets the distance at which the projected texture begins its projection.  You must call ProjectedTexture:Update after using this function for it to take effect.  Setting this to 0 will disable the projected texture completely! This may be useful if you want to disable a projected texture without actually removing it  This seems to affect the rendering of shadows - a higher Near Z value will have shadows begin to render closer to their casting object. Comparing a low Near Z value (like 1) with a normal one (12) or high one (1000) is the easiest way to understand this artifact
---@param nearZ number
function ProjectedTexture:SetNearZ(nearZ) end

-- Changes the current projected texture between orthographic and perspective projection.  You must call ProjectedTexture:Update after using this function for it to take effect.  Shadows dont work. (For non static props and for most map brushes)
---@param orthographic boolean When false, all other arguments are ignored and the texture is reset to perspective projection.
---@param left number The amount of units left from the projected texture's origin to project.
---@param top number The amount of units upwards from the projected texture's origin to project.
---@param right number The amount of units right from the projected texture's origin to project.
---@param bottom number The amount of units downwards from the projected texture's origin to project.
function ProjectedTexture:SetOrthographic(orthographic,left,top,right,bottom) end

-- Move the Projected Texture to the specified position.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param position Vector
function ProjectedTexture:SetPos(position) end

-- Sets the quadratic attenuation of the projected texture.  See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetConstantAttenuation.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param quadAtten number
function ProjectedTexture:SetQuadraticAttenuation(quadAtten) end

-- Sets the shadow depth bias of the projected texture.  The initial value is `0.0001`. Normal projected textures obey the value of the `mat_depthbias_shadowmap` ConVar.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param bias number The shadow depth bias to set.
function ProjectedTexture:SetShadowDepthBias(bias) end

-- Sets the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more. The initial value is the value of `r_projectedtexture_filter` ConVar.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param filter number The shadow filter size to set.
function ProjectedTexture:SetShadowFilter(filter) end

-- Sets the shadow depth slope scale bias of the projected texture.  The initial value is `2`. Normal projected textures obey the value of the `mat_slopescaledepthbias_shadowmap` ConVar.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param bias number The shadow depth slope scale bias to set.
function ProjectedTexture:SetShadowSlopeScaleDepthBias(bias) end

-- Sets the target entity for this projected texture, meaning it will only be lighting the given entity and the world.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param target? Entity The target entity, or `NULL` to reset.
function ProjectedTexture:SetTargetEntity(target) end

-- Sets the texture to be projected.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param texture string The name of the texture. Can also be an ITexture.
function ProjectedTexture:SetTexture(texture) end

-- For animated textures, this will choose which frame in the animation will be projected.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param frame number The frame index to use.
function ProjectedTexture:SetTextureFrame(frame) end

-- Sets the vertical angle of projection without affecting the horizontal angle.  You must call ProjectedTexture:Update after using this function for it to take effect.
---@param vFOV number The new vertical Field Of View for the projected texture. Must be in range between 0 and 180.
function ProjectedTexture:SetVerticalFOV(vFOV) end

-- Updates the Projected Light and applies all previously set parameters.
function ProjectedTexture:Update() end



---@class Schedule
Schedule = Schedule

-- Adds a task to the schedule. See also Schedule:AddTaskEx if you wish to customize task start and run function names.  See also ENTITY:StartSchedule, NPC:StartEngineTask, and NPC:RunEngineTask.
---@param taskname string Custom task name
---@param taskdata any Task data to be passed into the NPC's functions
function Schedule:AddTask(taskname,taskdata) end

-- Adds a task to the schedule with completely custom function names.  See also Schedule:AddTask.
---@param start string The full name of a function on the entity's table to be ran when the task is started.
---@param run string The full name of a function on the entity's table to be ran when the task is continuously running.
---@param data number Task data to be passed into the NPC's functions
function Schedule:AddTaskEx(start,run,data) end

-- Adds an engine task to the schedule.
---@param taskname string Task name, see [ai_task.h](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/ai_task.h#L89-L502)
---@param taskdata number Task data, can be a float.
function Schedule:EngTask(taskname,taskdata) end

-- Returns the task at the given index.
---@param num number Task index.
function Schedule:GetTask(num) end

--  Initialises the Schedule. Called by ai_schedule.New when the Schedule is created.
---@param debugName string The name passed from ai_schedule.New.
function Schedule:Init(debugName) end

-- Returns the number of tasks in the schedule.
---@return number
function Schedule:NumTasks() end



---@class Stack
Stack = Stack

-- Pop an item from the stack
---@param amount? number Amount of items you want to pop.
---@return number
function Stack:Pop(amount) end

-- Pop an item from the stack
---@param amount? number Amount of items you want to pop.
---@return table
function Stack:PopMulti(amount) end

-- Push an item onto the stack
---@param object any The item you want to push
function Stack:Push(object) end

-- Returns the size of the stack
---@return number
function Stack:Size() end

-- Get the item at the top of the stack
---@return any
function Stack:Top() end



---@class SurfaceInfo
SurfaceInfo = SurfaceInfo

-- Returns the brush surface's material.
---@return IMaterial
function SurfaceInfo:GetMaterial() end

-- Returns a list of vertices the brush surface is built from.
---@return table
function SurfaceInfo:GetVertices() end

-- Checks if the brush surface is a nodraw surface, meaning it will not be drawn by the engine.  This internally checks the SURFDRAW_NODRAW flag.
---@return boolean
function SurfaceInfo:IsNoDraw() end

-- Checks if the brush surface is displaying the skybox.  This internally checks the SURFDRAW_SKY flag.
---@return boolean
function SurfaceInfo:IsSky() end

-- Checks if the brush surface is water.  This internally checks the SURFDRAW_WATER flag.
---@return boolean
function SurfaceInfo:IsWater() end



---@class Task
Task = Task

--  Initialises the AI task. Called by ai_task.New.
function Task:Init() end

-- Initialises the AI task as an engine task.
---@param taskname string The name of the task.
---@param taskdata number
function Task:InitEngine(taskname,taskdata) end

-- Initialises the AI task as NPC method-based.
---@param startname string The name of the NPC method to call on task start.
---@param runname string The name of the NPC method to call on task run.
---@param taskdata number
function Task:InitFunctionName(startname,runname,taskdata) end

-- Determines if the task is an engine task (`TYPE_ENGINE`, 1).
function Task:IsEngineType() end

-- Determines if the task is an NPC method-based task (`TYPE_FNAME`, 2).
function Task:IsFNameType() end

-- Runs the AI task.
---@param target NPC The NPC to run the task on.
function Task:Run(target) end

--  Runs the AI task as an NPC method. This requires the task to be of type `TYPE_FNAME`.
---@param target NPC The NPC to run the task on.
function Task:Run_FName(target) end

-- Starts the AI task.
---@param target NPC The NPC to start the task on.
function Task:Start(target) end

--  Starts the AI task as an NPC method.
---@param target NPC The NPC to start the task on.
function Task:Start_FName(target) end



---@class Tool
Tool = Tool

-- Returns whether the tool is allowed to be used or not. This function ignores the SANDBOX:CanTool hook.  By default this will always return true clientside and uses `TOOL.AllowedCVar`which is a ConVar object pointing to  `toolmode_allow_*toolname*` convar on the server.
---@return boolean
function Tool:Allowed() end

-- Builds a list of all ConVars set via the ClientConVar variable on the Structures/TOOL and their default values. This is used for the preset system.
---@return table
function Tool:BuildConVarList() end

-- This is called automatically for most toolgun actions so you shouldn't need to use it.  Checks all added objects to see if they're still valid, if not, clears the list of objects.
function Tool:CheckObjects() end

-- Clears all objects previously set with Tool:SetObject.
function Tool:ClearObjects() end

-- This is called automatically for all tools. Initializes the tool object
---@return Tool
function Tool:Create() end

-- This is called automatically for all tools.  Creates clientside ConVars based on the ClientConVar table specified in the tool structure. Also creates the 'toolmode_allow_X' ConVar.
function Tool:CreateConVars() end

-- Retrieves a physics bone number previously stored using Tool:SetObject.
---@param id number The id of the object which was set in Tool:SetObject.
---@return number
function Tool:GetBone(id) end

-- Attempts to grab a clientside tool ConVar value as a boolean.
---@param name string Name of the ConVar to retrieve. The function will automatically add the `mytoolfilename_` part to it.
---@param default? boolean The default value to return in case the lookup fails.
---@return number
function Tool:GetClientBool(name,default) end

-- Attempts to grab a clientside tool ConVar as a string.
---@param name string Name of the convar to retrieve. The function will automatically add the `mytoolfilename_` part to it.
---@return string
function Tool:GetClientInfo(name) end

-- Attempts to grab a clientside tool ConVar's value as a number.
---@param name string Name of the convar to retrieve. The function will automatically add the `mytoolfilename_` part to it.
---@param default? number The default value to return in case the lookup fails.
---@return number
function Tool:GetClientNumber(name,default) end

-- Retrieves an Entity previously stored using Tool:SetObject.
---@param id number The id of the object which was set in Tool:SetObject.
---@return Entity
function Tool:GetEnt(id) end

-- Returns a language key based on this tool's name and the current stage it is on.
---@return string
function Tool:GetHelpText() end

-- Retrieves an local vector previously stored using Tool:SetObject. See also Tool:GetPos.
---@param id number The id of the object which was set in Tool:SetObject.
---@return Vector
function Tool:GetLocalPos(id) end

-- Returns the name of the current tool mode.
---@return string
function Tool:GetMode() end

-- Retrieves an normal vector previously stored using Tool:SetObject.
---@param id number The id of the object which was set in Tool:SetObject.
---@return Vector
function Tool:GetNormal(id) end

-- Returns the current operation of the tool set by Tool:SetOperation.
---@return number
function Tool:GetOperation() end

-- Returns the owner of this tool.
---@return Entity
function Tool:GetOwner() end

-- Retrieves an PhysObj previously stored using Tool:SetObject. See also Tool:GetEnt.
---@param id number The id of the object which was set in Tool:SetObject.
---@return PhysObj
function Tool:GetPhys(id) end

-- Retrieves an vector previously stored using Tool:SetObject. See also Tool:GetLocalPos.
---@param id number The id of the object which was set in Tool:SetObject.
---@return Vector
function Tool:GetPos(id) end

-- Attempts to grab a serverside tool ConVar. This will not do anything on client, despite the function being defined shared.
---@param name string Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
---@return string
function Tool:GetServerInfo(name) end

-- Returns the current stage of the tool set by Tool:SetStage.
---@return number
function Tool:GetStage() end

-- Initializes the ghost entity with the given model. Removes any old ghost entity if called multiple times.  The ghost is a regular prop_physics entity in singleplayer games, and a clientside prop in multiplayer games.
---@param model string The model of the new ghost entity
---@param pos Vector Position to initialize the ghost entity at, usually not needed since this is updated in Tool:UpdateGhostEntity.
---@param angle Angle Angle to initialize the ghost entity at, usually not needed since this is updated in Tool:UpdateGhostEntity.
function Tool:MakeGhostEntity(model,pos,angle) end

-- Returns the amount of stored objects ( Entitys ) the tool has. Are TOOLs limited to 4 entities?
---@return number
function Tool:NumObjects() end

-- Automatically forces the tool's control panel to be rebuilt.
---@param ... any Any arguments given to this function will be added to TOOL.BuildCPanel's arguments.
function Tool:RebuildControlPanel(...) end

-- Removes any ghost entity created for this tool.
function Tool:ReleaseGhostEntity() end

-- Stores an Entity for later use in the tool.  The stored values can be retrieved by Tool:GetEnt, Tool:GetPos, Tool:GetLocalPos, Tool:GetPhys, Tool:GetBone and Tool:GetNormal
---@param id number The id of the object to store.
---@param ent Entity The entity to store.
---@param pos Vector The position to store. this position is in **global space** and is internally converted to **local space** relative to the object, so when you retrieve it later it will be corrected to the object's new position
---@param phys PhysObj The physics object to store.
---@param bone number The hit bone to store.
---@param normal Vector The hit normal to store.
function Tool:SetObject(id,ent,pos,phys,bone,normal) end

-- Sets the current operation of the tool. Does nothing clientside. See also Tool:SetStage.  Operations and stages work as follows: * Operation 1 * * Stage 1 * * Stage 2 * * Stage 3 * Operation 2 * * Stage 1 * * Stage 2 * * Stage ...
---@param operation number The new operation ID to set.
function Tool:SetOperation(operation) end

-- Sets the current stage of the tool. Does nothing clientside.  See also Tool:SetOperation.
---@param stage number The new stage to set.
function Tool:SetStage(stage) end

-- Initializes the ghost entity based on the supplied entity.
---@param ent Entity The entity to copy ghost parameters off
function Tool:StartGhostEntity(ent) end

-- Called on deploy automatically  Sets the tool's stage to how many stored objects the tool has.
function Tool:UpdateData() end

-- Updates the position and orientation of the ghost entity based on where the toolgun owner is looking along with data from object with id 1 set by Tool:SetObject.  This should be called in the tool's TOOL:Think hook.  This command is only used for tools that move props, such as easy weld, axis and motor. If you want to update a ghost like the thruster tool does it for example, check its [source code](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stools/thruster.lua#L179).
function Tool:UpdateGhostEntity() end



---@class Vector
Vector = Vector

-- Adds the values of the argument vector to the original vector. This function is the same as vector1 + vector2 without creating a new vector object, skipping object construction and garbage collection.
---@param vector Vector The vector to add.
function Vector:Add(vector) end

-- Returns an angle representing the normal of the vector.
---@return Angle
function Vector:Angle() end

-- Returns the angle of this vector (normalized), but instead of assuming that up is Global.Vector( 0, 0, 1 ) (Like Vector:Angle does) you can specify which direction is 'up' for the angle.
---@param up Vector The up direction vector
---@return Angle
function Vector:AngleEx(up) end

-- Calculates the cross product of this vector and the passed one.  The cross product of two vectors is a 3-dimensional vector with a direction perpendicular (at right angles) to both of them (according to the right-hand rule), and magnitude equal to the area of parallelogram they span. This is defined as the product of the magnitudes, the sine of the angle between them, and unit (normal) vector `n` defined by the right-hand rule: :**a** × **b** = |**a**| |**b**| sin(θ) **n̂** where **a** and **b** are vectors, and **n̂** is a unit vector (magnitude of 1) perpendicular to both.
---@param otherVector Vector Vector to calculate the cross product with.
---@return Vector
function Vector:Cross(otherVector) end

-- Returns the euclidean distance between the vector and the other vector.  This function is more expensive than Vector:DistToSqr. However, please see the notes for Vector:DistToSqr before using it as squared distances are not the same as euclidean distances.
---@param otherVector Vector The vector to get the distance to.
---@return number
function Vector:Distance(otherVector) end

-- Returns the squared distance of 2 vectors, this is faster than Vector:Distance as calculating the square root is an expensive process.  Squared distances should not be summed. If you need to sum distances, use Vector:Distance.  When performing a distance check, ensure the distance being checked against is squared. See example code below.
---@param otherVec Vector The vector to calculate the distance to.
---@return number
function Vector:DistToSqr(otherVec) end

-- Divide the vector by the given number, that means x, y and z are divided by that value. This will change the value of the original vector, see example 2 for division without changing the value.
---@param divisor number The value to divide the vector with.
function Vector:Div(divisor) end

-- Returns the [dot product](https://en.wikipedia.org/wiki/Dot_product#Geometric_definition)  of this vector and the passed one.  The dot product of two vectors is the product of their magnitudes (lengths), and the cosine of the angle between them: **a · b** = |**a**| |**b**| cos(θ)  where **a** and **b** are vectors. See Vector:Length for obtaining magnitudes.  A dot product returns just the cosine of the angle if both vectors are normalized, and zero if the vectors are at right angles to each other.
---@param otherVector Vector The vector to calculate the dot product with
---@return number
function Vector:Dot(otherVector) end

-- This is an alias of Vector:Dot. Use that instead.Returns the dot product of the two vectors.
---@param Vector Vector The other vector.
---@return number
function Vector:DotProduct(Vector) end

-- Returns the negative version of this vector, i.e. a vector with every component to the negative value of itself.  See also Vector:Negate.
---@return Vector
function Vector:GetNegated() end

-- Use Vector:GetNormalized instead.  Returns a normalized version of the vector. This is a alias of Vector:GetNormalized.
---@return Vector
function Vector:GetNormal() end

-- Returns a normalized version of the vector. Normalized means vector with same direction but with length of 1.  This does not affect the vector you call it on; to do this, use Vector:Normalize.
---@return Vector
function Vector:GetNormalized() end

-- Returns if the vector is equal to another vector with the given tolerance.
---@param compare Vector The vector to compare to.
---@param tolerance number The tolerance range.
---@return boolean
function Vector:IsEqualTol(compare,tolerance) end

-- Checks whenever all fields of the vector are 0.
---@return boolean
function Vector:IsZero() end

-- Returns the [Euclidean length](https://en.wikipedia.org/wiki/Euclidean_vector#Length) of the vector: √(x² + y² + z²).   This is a relatively expensive process since it uses the square root. It is recommended that you use Vector:LengthSqr whenever possible. 
---@return number
function Vector:Length() end

-- Returns the length of the vector in two dimensions, without the Z axis.   This is a relatively expensive process since it uses the square root. It is recommended that you use Vector:Length2DSqr whenever possible. 
---@return number
function Vector:Length2D() end

-- Returns the squared length of the vectors x and y value, x² + y².  This is faster than Vector:Length2D as calculating the square root is an expensive process.
---@return number
function Vector:Length2DSqr() end

-- Returns the squared length of the vector, x² + y² + z².  This is faster than Vector:Length as calculating the square root is an expensive process.
---@return number
function Vector:LengthSqr() end

-- Scales the vector by the given number (that means x, y and z are multiplied by that value) or Vector.
---@param multiplier number The value to scale the vector with.
function Vector:Mul(multiplier) end

-- Negates this vector, i.e. sets every component to the negative value of itself. Same as `Vector( -vec.x, -vec.y, -vec.z )`
function Vector:Negate() end

-- Normalizes the given vector. This changes the vector you call it on, if you want to return a normalized copy without affecting the original, use Vector:GetNormalized.
function Vector:Normalize() end

-- Randomizes each element of this Vector object.
---@param min? number The minimum value for each component.
---@param max? number The maximum value for each component.
function Vector:Random(min,max) end

-- Rotates a vector by the given angle. Doesn't return anything, but rather changes the original vector.
---@param rotation Angle The angle to rotate the vector by.
function Vector:Rotate(rotation) end

-- Copies the values from the second vector to the first vector.
---@param vector Vector The vector to copy from.
function Vector:Set(vector) end

-- Sets the x, y, and z of the vector.
---@param x number The x component
---@param y number The y component
---@param z number The z component
function Vector:SetUnpacked(x,y,z) end

-- Substracts the values of the second vector from the orignal vector, this function can be used to avoid garbage collection.
---@param vector Vector The other vector.
function Vector:Sub(vector) end

-- Translates the Vector (values ranging from 0 to 1) into a Color. This will also range the values from 0 - 1 to 0 - 255.  x * 255 -&gt; r y * 255 -&gt; g z * 255 -&gt; b  This is the opposite of Color:ToVector
---@return table
function Vector:ToColor() end

-- Returns where on the screen the specified position vector would appear. A related function is gui.ScreenToVector, which converts a 2D coordinate to a 3D direction.  Should be called from a 3D rendering environment or after cam.Start3D or it may not work correctly.  Errors in a render hook can make this value incorrect until the player restarts their game.  cam.Start3D or 3D context cam.Start with non-default parameters incorrectly sets the reference FOV for this function, causing incorrect return values. This can be fixed by creating and ending a default 3D context (cam.Start3D with no arguments).
---@return table
function Vector:ToScreen() end

-- Returns the vector as a table with three elements.
---@return table
function Vector:ToTable() end

-- Returns the x, y, and z of the vector.
---@return number
---@return number
---@return number
function Vector:Unpack() end

-- Returns whenever the given vector is in a box created by the 2 other vectors.   
---@param boxStart Vector The first vector.
---@param boxEnd Vector The second vector.
---@return boolean
function Vector:WithinAABox(boxStart,boxEnd) end

-- Sets x, y and z to 0.
function Vector:Zero() end



---@class Vehicle
Vehicle = Vehicle

-- Returns the remaining boosting time left.
---@return number
function Vehicle:BoostTimeLeft() end

-- Tries to find an Exit Point for leaving vehicle, if one is unobstructed in the direction given.
---@param yaw number Yaw/roll from vehicle angle to check for exit
---@param distance number Distance from origin to drop player
---@return Vector
function Vehicle:CheckExitPoint(yaw,distance) end

-- Sets whether the engine is enabled or disabled, i.e. can be started or not.
---@param enable boolean Enable or disable the engine
function Vehicle:EnableEngine(enable) end

-- Returns information about the ammo of the vehicle
---@return number
---@return number
---@return number
function Vehicle:GetAmmo() end

-- Returns third person camera distance.
---@return number
function Vehicle:GetCameraDistance() end

-- Gets the driver of the vehicle, returns `NULL` if no driver is present.
---@return Entity
function Vehicle:GetDriver() end

-- Returns the current speed of the vehicle in Half-Life Hammer Units (in/s). Same as Entity:GetVelocity + Vector:Length.
---@return number
function Vehicle:GetHLSpeed() end

-- Returns the max speed of the vehicle in MPH.
---@return number
function Vehicle:GetMaxSpeed() end

-- Returns some info about the vehicle.
---@return table
function Vehicle:GetOperatingParams() end

-- Gets the passenger of the vehicle, returns NULL if no drivers is present.
---@param passenger number The index of the passenger
---@return Entity
function Vehicle:GetPassenger(passenger) end

-- Returns the seat position and angle of a given passenger seat.
---@param role number The passenger role. ( 1 is the driver )
---@return Vector
---@return Angle
function Vehicle:GetPassengerSeatPoint(role) end

-- Returns the current RPM of the vehicle. This value is fake and doesn't actually affect the vehicle movement.
---@return number
function Vehicle:GetRPM() end

-- Returns the current speed of the vehicle in MPH.
---@return number
function Vehicle:GetSpeed() end

-- Returns the current steering of the vehicle.
---@return number
function Vehicle:GetSteering() end

-- Returns the maximum steering degree of the vehicle
---@return number
function Vehicle:GetSteeringDegrees() end

-- Returns if vehicle has thirdperson mode enabled or not.
---@return boolean
function Vehicle:GetThirdPersonMode() end

-- Returns the current throttle of the vehicle.
---@return number
function Vehicle:GetThrottle() end

-- Returns the vehicle class name. This is only useful for Sandbox spawned vehicles or any vehicle that properly sets the vehicle class with Vehicle:SetVehicleClass.
---@return string
function Vehicle:GetVehicleClass() end

-- Returns the vehicle parameters of given vehicle.
---@return table
function Vehicle:GetVehicleParams() end

-- Returns the view position and forward angle of a given passenger seat.
---@param role? number The passenger role. 0 is the driver. This parameter seems to be ignored by the game engine and is therefore optional.
---@return Vector
---@return Angle
---@return number
function Vehicle:GetVehicleViewPosition(role) end

-- Returns the PhysObj of given wheel.
---@param wheel number The wheel to retrieve
---@return PhysObj
function Vehicle:GetWheel(wheel) end

-- Returns the base wheel height.
---@param wheel number The wheel to get the base wheel height of.
---@return number
function Vehicle:GetWheelBaseHeight(wheel) end

-- Returns the wheel contact point.
---@param wheel number The wheel to check
---@return Vector
---@return number
---@return boolean
function Vehicle:GetWheelContactPoint(wheel) end

-- Returns the wheel count of the vehicle
---@return number
function Vehicle:GetWheelCount() end

-- Returns the total wheel height.
---@param wheel number The wheel to get the base wheel height of.
---@return number
function Vehicle:GetWheelTotalHeight(wheel) end

-- Returns whether this vehicle has boost at all.
---@return boolean
function Vehicle:HasBoost() end

-- Returns whether this vehicle has a brake pedal. See Vehicle:SetHasBrakePedal.
---@return boolean
function Vehicle:HasBrakePedal() end

-- Returns whether this vehicle is currently boosting or not.
---@return boolean
function Vehicle:IsBoosting() end

-- Returns whether the engine is enabled or not, i.e. whether it can be started.
---@return boolean
function Vehicle:IsEngineEnabled() end

-- Returns whether the engine is started or not.
---@return boolean
function Vehicle:IsEngineStarted() end

-- Returns true if the vehicle object is a valid or not. This will return false when Vehicle functions are not usable on the vehicle.
---@return boolean
function Vehicle:IsValidVehicle() end

-- Returns whether this vehicle's engine is underwater or not. ( Internally the attachment point "engine" or "vehicle_engine" is checked )
---@return boolean
function Vehicle:IsVehicleBodyInWater() end

-- Releases the vehicle's handbrake (Jeep) so it can roll without any passengers.  This will be overwritten if the vehicle has a driver. Same as Vehicle:SetHandbrake( false )
function Vehicle:ReleaseHandbrake() end

-- Sets the boost. It is possible that this function does not work while the vehicle has a valid driver in it.
---@param boost number The new boost value
function Vehicle:SetBoost(boost) end

-- Sets the third person camera distance of the vehicle.
---@param distance number Camera distance to set to
function Vehicle:SetCameraDistance(distance) end

-- Turns on or off the Jeep handbrake so it can roll without a driver inside.  Does nothing while the vehicle has a driver in it.
---@param handbrake boolean true to turn on, false to turn off.
function Vehicle:SetHandbrake(handbrake) end

-- Sets whether this vehicle has a brake pedal.
---@param brakePedal boolean Whether this vehicle has a brake pedal
function Vehicle:SetHasBrakePedal(brakePedal) end

-- Sets maximum reverse throttle
---@param maxRevThrottle number The new maximum throttle. This number must be negative.
function Vehicle:SetMaxReverseThrottle(maxRevThrottle) end

-- Sets maximum forward throttle
---@param maxThrottle number The new maximum throttle.
function Vehicle:SetMaxThrottle(maxThrottle) end

-- Sets spring length of given wheel
---@param wheel number The wheel to change spring length of
---@param length number The new spring length
function Vehicle:SetSpringLength(wheel,length) end

-- Sets the steering of the vehicle. The correct range, 0 to 1 or -1 to 1
---@param front number Angle of the front wheels (-1 to 1)
---@param rear number Angle of the rear wheels (-1 to 1)
function Vehicle:SetSteering(front,rear) end

-- Sets the maximum steering degrees of the vehicle
---@param steeringDegrees number The new maximum steering degree
function Vehicle:SetSteeringDegrees(steeringDegrees) end

-- Sets the third person mode state.
---@param enable boolean Enable or disable the third person mode for this vehicle
function Vehicle:SetThirdPersonMode(enable) end

-- Sets the throttle of the vehicle. It is possible that this function does not work with a valid driver in it.
---@param throttle number The new throttle.
function Vehicle:SetThrottle(throttle) end

-- Sets the vehicle class name.
---@param class string The vehicle class name to set
function Vehicle:SetVehicleClass(class) end

-- Sets whether the entry or exit camera animation should be played or not.
---@param bOn boolean Whether the entry or exit camera animation should be played or not.
function Vehicle:SetVehicleEntryAnim(bOn) end

-- Sets the vehicle parameters for given vehicle.  Not all variables from the Structures/VehicleParams can be set.
---@param params table The new new vehicle parameters. See Structures/VehicleParams.
function Vehicle:SetVehicleParams(params) end

-- Sets friction of given wheel.  This function may be broken.
---@param wheel number The wheel to change the friction of
---@param friction number The new friction to set
function Vehicle:SetWheelFriction(wheel,friction) end

-- Starts or stops the engine.
---@param start boolean True to start, false to stop.
function Vehicle:StartEngine(start) end



---@class VMatrix
VMatrix = VMatrix

-- Adds given matrix to this matrix.
---@param input VMatrix The input matrix to add.
function VMatrix:Add(input) end

-- Returns the absolute rotation of the matrix.
---@return Angle
function VMatrix:GetAngles() end

-- Returns a specific field in the matrix.
---@param row number Row of the field whose value is to be retrieved, from 1 to 4
---@param column number Column of the field whose value is to be retrieved, from 1 to 4
---@return number
function VMatrix:GetField(row,column) end

-- Gets the forward direction of the matrix.  ie. The first column of the matrix, excluding the w coordinate.
---@return Vector
function VMatrix:GetForward() end

-- Returns an inverted matrix without modifying the original matrix.  Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)  See also VMatrix:GetInverseTR.
---@return VMatrix
function VMatrix:GetInverse() end

-- Returns an inverted matrix without modifying the original matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.  Using this function on a matrix with modified scale may return an incorrect inverted matrix.  To get the inverse of a matrix that contains other modifications, see VMatrix:GetInverse.
---@return VMatrix
function VMatrix:GetInverseTR() end

-- Gets the right direction of the matrix.  ie. The second column of the matrix, negated, excluding the w coordinate.
---@return Vector
function VMatrix:GetRight() end

-- Returns the absolute scale of the matrix.
---@return Vector
function VMatrix:GetScale() end

-- Returns the absolute translation of the matrix.
---@return Vector
function VMatrix:GetTranslation() end

-- Returns the transpose (each row becomes a column) of this matrix.
---@return VMatrix
function VMatrix:GetTransposed() end

-- Gets the up direction of the matrix.  ie. The third column of the matrix, excluding the w coordinate.
---@return Vector
function VMatrix:GetUp() end

-- Initializes the matrix as Identity matrix.
function VMatrix:Identity() end

-- Inverts the matrix.  Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)  If the matrix cannot be inverted, it does not get modified.  See also VMatrix:InvertTR.
---@return boolean
function VMatrix:Invert() end

-- Inverts the matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.  Using this function on a matrix with modified scale may return an incorrect inverted matrix.  To invert a matrix that contains other modifications, see VMatrix:Invert.
function VMatrix:InvertTR() end

-- Returns whether the matrix is equal to Identity matrix or not.
---@return boolean
function VMatrix:IsIdentity() end

-- Returns whether the matrix is a rotation matrix or not.  Technically it checks if the forward, right and up vectors are orthogonal and normalized.
---@return boolean
function VMatrix:IsRotationMatrix() end

-- Checks whenever all fields of the matrix are 0, aka if this is a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).
---@return boolean
function VMatrix:IsZero() end

-- Multiplies this matrix by given matrix.
---@param input VMatrix The input matrix to multiply by.
function VMatrix:Mul(input) end

-- Rotates the matrix by the given angle.  Postmultiplies the matrix by a rotation matrix (A = AR).
---@param rotation Angle Rotation.
function VMatrix:Rotate(rotation) end

-- Scales the matrix by the given vector.  Postmultiplies the matrix by a scaling matrix (A = AS).
---@param scale Vector Vector to scale with matrix with.
function VMatrix:Scale(scale) end

-- Scales the absolute translation with the given value.
---@param scale number Value to scale the translation with.
function VMatrix:ScaleTranslation(scale) end

-- Copies values from the given matrix object.
---@param src VMatrix The matrix to copy values from.
function VMatrix:Set(src) end

-- Sets the absolute rotation of the matrix.
---@param angle Angle New angles.
function VMatrix:SetAngles(angle) end

-- Sets a specific field in the matrix.
---@param row number Row of the field to be set, from 1 to 4
---@param column number Column of the field to be set, from 1 to 4
---@param value number The value to set in that field
function VMatrix:SetField(row,column,value) end

-- Sets the forward direction of the matrix.  ie. The first column of the matrix, excluding the w coordinate.
---@param forward Vector The forward direction of the matrix.
function VMatrix:SetForward(forward) end

-- Sets the right direction of the matrix.  ie. The second column of the matrix, negated, excluding the w coordinate.
---@param forward Vector The right direction of the matrix.
function VMatrix:SetRight(forward) end

-- Modifies the scale of the matrix while preserving the rotation and translation.
---@param scale Vector The scale to set.
function VMatrix:SetScale(scale) end

-- Sets the absolute translation of the matrix.
---@param translation Vector New translation.
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

-- Sets the up direction of the matrix.  ie. The third column of the matrix, excluding the w coordinate.
---@param forward Vector The up direction of the matrix.
function VMatrix:SetUp(forward) end

-- Subtracts given matrix from this matrix.
---@param input VMatrix The input matrix to subtract.
function VMatrix:Sub(input) end

-- Converts the matrix to a 4x4 table. See Global.Matrix function.
---@return table
function VMatrix:ToTable() end

-- Translates the matrix by the given vector aka. adds the vector to the translation.  Postmultiplies the matrix by a translation matrix (A = AT).
---@param translation Vector Vector to translate the matrix by.
function VMatrix:Translate(translation) end

-- Returns each component of the matrix, expanding rows before columns.
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
function VMatrix:Unpack() end

-- Sets all components of the matrix to 0, also known as a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).  This function is more efficient than setting each element manually.
function VMatrix:Zero() end



---@class Weapon
Weapon = Weapon

-- Returns whether the weapon allows to being switched from when a better ( Weapon:GetWeight ) weapon is being picked up.
---@return boolean
function Weapon:AllowsAutoSwitchFrom() end

-- Returns whether the weapon allows to being switched to when a better ( Weapon:GetWeight ) weapon is being picked up.
---@return boolean
function Weapon:AllowsAutoSwitchTo() end

-- Calls a SWEP function on client.  This uses the usermessage internally, because of that, the combined length of the arguments of this function may not exceed 254 bytes/characters or the function will cease to function!
---@param functionName string Name of function to call. If you want to call SWEP:MyFunc() on client, you type in "MyFunc"
---@param arguments string Arguments for the function, separated by spaces. Only the second argument is passed as argument and must be a string
function Weapon:CallOnClient(functionName,arguments) end

-- Returns how much primary ammo is in the magazine. This is not shared between clients and will instead return the maximum primary clip size.
---@return number
function Weapon:Clip1() end

-- Returns how much secondary ammo is in the magazine. This is not shared between clients and will instead return the maximum secondary clip size.
---@return number
function Weapon:Clip2() end

-- Forces the weapon to reload while playing given animation.  This will stop the Weapon:Think function from getting called while the weapon is reloading! 
---@param act number Sequence to use as reload animation. Uses the Enums/ACT.
---@return boolean
function Weapon:DefaultReload(act) end

-- Returns the sequence enumeration number that the weapon is playing.  This can return inconsistent results between the server and client.
---@return number
function Weapon:GetActivity() end

-- Returns the hold type of the weapon.
---@return string
function Weapon:GetHoldType() end

-- Returns maximum primary clip size
---@return number
function Weapon:GetMaxClip1() end

-- Returns maximum secondary clip size
---@return number
function Weapon:GetMaxClip2() end

-- Gets the next time the weapon can primary fire. ( Can call WEAPON:PrimaryAttack )
---@return number
function Weapon:GetNextPrimaryFire() end

-- Gets the next time the weapon can secondary fire. ( Can call WEAPON:SecondaryAttack )
---@return number
function Weapon:GetNextSecondaryFire() end

-- Gets the primary ammo type of the given weapon.
---@return number
function Weapon:GetPrimaryAmmoType() end

-- Returns the non-internal name of the weapon, that should be for displaying.  If that returns an untranslated message (#HL2_XX), use language.GetPhrase to see the "nice" name. If SWEP.PrintName is not set in the Weapon or the Weapon Base then "&lt;MISSING SWEP PRINT NAME&gt;" will be returned.
---@return string
function Weapon:GetPrintName() end

-- Gets the ammo type of the given weapons secondary fire.
---@return number
function Weapon:GetSecondaryAmmoType() end

-- Returns the slot of the weapon. The slot numbers start from 0.
---@return number
function Weapon:GetSlot() end

-- Returns slot position of the weapon
---@return number
function Weapon:GetSlotPos() end

-- Returns the view model of the weapon.
---@return string
function Weapon:GetWeaponViewModel() end

-- Returns the world model of the weapon.
---@return string
function Weapon:GetWeaponWorldModel() end

-- Returns the "weight" of the weapon, which is used when deciding which Weapon is better by the engine.
---@return number
function Weapon:GetWeight() end

-- Returns whether the weapon has ammo left or not. It will return false when there's no ammo left in the magazine **and** when there's no reserve ammo left.  This will return true for weapons like crowbar, gravity gun, etc.
---@return boolean
function Weapon:HasAmmo() end

-- Returns whenever the weapon is carried by the local player.
---@return boolean
function Weapon:IsCarriedByLocalPlayer() end

-- Checks if the weapon is a SWEP or a built-in weapon.
---@return boolean
function Weapon:IsScripted() end

-- Returns whether the weapon is visible. The term visibility is not exactly what gets checked here, first it checks if the owner is a player, then checks if the active view model has EF_NODRAW flag NOT set.
---@return boolean
function Weapon:IsWeaponVisible() end

-- Returns the time since this weapon last fired a bullet with Entity:FireBullets in seconds. It is not networked.
---@return number
function Weapon:LastShootTime() end

-- Forces weapon to play activity/animation.
---@param act number Activity to play. See the Enums/ACT (specifically ACT_VM_).
function Weapon:SendWeaponAnim(act) end

-- Sets the activity the weapon is playing.  See also Weapon:GetActivity.
---@param act number The new activity to set, see Enums/ACT.
function Weapon:SetActivity(act) end

-- Lets you change the number of bullets in the given weapons primary clip.
---@param ammo number The amount of bullets the clip should contain
function Weapon:SetClip1(ammo) end

-- Lets you change the number of bullets in the given weapons secondary clip.
---@param ammo number The amount of bullets the clip should contain
function Weapon:SetClip2(ammo) end

-- Sets the hold type of the weapon. This function also calls WEAPON:SetWeaponHoldType and properly networks it to all clients.  This only works on scripted weapons.  Using this function on weapons held by bots will not network holdtype changes to clients if the world model is set to an empty string (SWEP.WorldModel = "").
---@param name string Name of the hold type. You can find all default hold types Hold_Types
function Weapon:SetHoldType(name) end

-- Sets the time since this weapon last fired in seconds. Used in conjunction with Weapon:LastShootTime
---@param time? number The time in seconds when the last time the weapon was fired.
function Weapon:SetLastShootTime(time) end

-- Sets when the weapon can fire again. Time should be based on Global.CurTime.  The standard HL2 "weapon_pistol" bypasses this function due to an [internal implementation](https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/server/hl2/weapon_pistol.cpp#L313-L317). This will fire extra bullets if the time is set to less than Global.CurTime.
---@param time number Time when player should be able to use primary fire again
function Weapon:SetNextPrimaryFire(time) end

-- Sets when the weapon can alt-fire again. Time should be based on Global.CurTime.
---@param time number Time when player should be able to use secondary fire again
function Weapon:SetNextSecondaryFire(time) end



