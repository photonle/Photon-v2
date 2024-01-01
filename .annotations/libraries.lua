---@meta

achievements = {}
-- Adds one to the count of balloons burst. Once this count reaches 1000, the 'Popper' achievement is unlocked.
function achievements.BalloonPopped() end

-- Returns the amount of achievements in Garry's Mod.
---@return number
function achievements.Count() end

-- Adds one to the count of balls eaten. Once this count reaches 200, the 'Ball Eater' achievement is unlocked.
function achievements.EatBall() end

-- Retrieves progress of given achievement
---@param achievementID number The ID of achievement to retrieve progress of. Note: IDs start from 0, not 1.
function achievements.GetCount(achievementID) end

-- Retrieves description of given achievement
---@param achievementID number The ID of achievement to retrieve description of. Note: IDs start from 0, not 1.
---@return string
function achievements.GetDesc(achievementID) end

-- Retrieves progress goal of given achievement
---@param achievementID number The ID of achievement to retrieve goal of. Note: IDs start from 0, not 1.
---@return number
function achievements.GetGoal(achievementID) end

-- Retrieves name of given achievement
---@param achievementID number The ID of achievement to retrieve name of. Note: IDs start from 0, not 1.
---@return string
function achievements.GetName(achievementID) end

-- Adds one to the count of baddies killed. Once this count reaches 1000, the 'War Zone' achievement is unlocked.
function achievements.IncBaddies() end

-- Adds one to the count of innocent animals killed. Once this count reaches 1000, the 'Innocent Bystander' achievement is unlocked.
function achievements.IncBystander() end

-- Adds one to the count of friendly NPCs killed. Once this count reaches 1000, the 'Bad Friend' achievement is unlocked.
function achievements.IncGoodies() end

-- Used in GMod 12 in the achievements menu to show the user if they have unlocked certain achievements.
---@param AchievementID number Internal Achievement ID number
---@return boolean
function achievements.IsAchieved(AchievementID) end

-- Adds one to the count of things removed. Once this count reaches 5000, the 'Destroyer' achievement is unlocked.
function achievements.Remover() end

-- Adds one to the count of NPCs spawned. Once this count reaches 1000, the 'Procreator' achievement is unlocked.
function achievements.SpawnedNPC() end

-- Adds one to the count of props spawned. Once this count reaches 5000, the 'Creator' achievement is unlocked.
function achievements.SpawnedProp() end

-- Adds one to the count of ragdolls spawned. Once this count reaches 2000, the 'Dollhouse' achievement is unlocked.
function achievements.SpawnedRagdoll() end

-- Adds one to the count of how many times the spawnmenu has been opened. Once this count reaches 100,000, the 'Menu User' achievement is unlocked.
function achievements.SpawnMenuOpen() end



ai = {}
-- Translates a schedule name to its corresponding ID.
---@param sched string Then schedule name. In most cases, this will be the same as the Enums/SCHED name.
---@return number
function ai.GetScheduleID(sched) end

-- Returns the squad leader of the given squad.
---@param squad string The squad name.
---@return NPC
function ai.GetSquadLeader(squad) end

-- Returns the amount of members a given squad has.
---@param squad string The squad name.
---@return number
function ai.GetSquadMemberCount(squad) end

-- Returns all members of a given squad.
---@param squad string The squad name.
---@return table
function ai.GetSquadMembers(squad) end

-- Translates a task name to its corresponding ID.
---@param task string The task name.
---@return number
function ai.GetTaskID(task) end



ai_schedule = {}
-- Creates a schedule for scripted NPC.
---@param name string Name of the schedule.
---@return table
function ai_schedule.New(name) end



ai_task = {}
-- Create a new empty task. Used by Schedule:AddTask and Schedule:EngTask.
---@return Task
function ai_task.New() end



baseclass = {}
-- Gets the base class of an an object.  This is used not just by entities, but also by widgets, panels, drive modes, weapons and gamemodes (with "gamemode_" prefix).  The keyword **DEFINE_BASECLASS** translates into a call to this function. In the engine, it is replaced with:  ``` local BaseClass = baseclass.Get ```
---@param name string The child class.
---@return table
function baseclass.Get(name) end

-- Add a new base class that can be derived by others. This is done automatically for: * widgets * panels * drive modes * entities * weapons * gamemodes (with prefix "gamemode_")
---@param name string The name of this base class. Must be completely unique.
---@param tab table The base class.
function baseclass.Set(name,tab) end



bit = {}


cam = {}
-- Shakes the screen at a certain position.
---@param pos Vector Origin of the shake.
---@param angles Angle Angles of the shake.
---@param factor number The shake factor.
function cam.ApplyShake(pos,angles,factor) end

-- Switches the renderer back to the previous drawing mode from a 3D context.  This function is an alias of cam.End3D.  This will crash the game if there is no context to end.
function cam.End() end

-- Switches the renderer back to the previous drawing mode from a 2D context.  This will crash the game if there is no context to end.
function cam.End2D() end

-- Switches the renderer back to the previous drawing mode from a 3D context.  This will crash the game if there is no context to end.
function cam.End3D() end

-- Switches the renderer back to the previous drawing mode from a 3D2D context.  This will crash the game if there is no context to end.
function cam.End3D2D() end

-- Switches the renderer back to the previous drawing mode from a 3D orthographic rendering context.
function cam.EndOrthoView() end

-- Returns a copy of the model matrix that is at the top of the stack. Editing the matrix **will not** edit the current view. To do so, you will have to **push** it. This function essentially returns the copy of the last pushed model matrix.
---@return VMatrix
function cam.GetModelMatrix() end

-- Tells the renderer to ignore the depth buffer and draw any upcoming operation "ontop" of everything that was drawn yet.  This is identical to calling `render.DepthRange( 0, 0.01 )` for `true` and  `render.DepthRange( 0, 1 )` for `false`. See render.DepthRange.
---@param ignoreZ boolean Determines whenever to ignore the depth buffer or not.
function cam.IgnoreZ(ignoreZ) end

-- Pops the current active rendering matrix from the stack and reinstates the previous one.
function cam.PopModelMatrix() end

-- Pushes the specified matrix onto the render matrix stack. Unlike opengl, this will replace the current model matrix.  This does not work with cam.Start3D2D if `multiply` is false.
---@param matrix VMatrix The matrix to push.
---@param multiply? boolean If set, multiplies given matrix with currently active matrix (cam.GetModelMatrix) before pushing.
function cam.PushModelMatrix(matrix,multiply) end

-- Sets up a new rendering context. This is an extended version of cam.Start3D and cam.Start2D. Must be finished by cam.End3D or cam.End2D.  This will not update current view properties for 3D contexts.
---@param dataTbl table Render context config. See Structures/RenderCamData
function cam.Start(dataTbl) end

-- Sets up a new 2D rendering context. Must be finished by cam.End2D.  This is almost always used with a render target from the render. To set its position use render.SetViewPort with a target already stored.  This will put an identity matrix at the top of the model matrix stack. If you are trying to use cam.PushModelMatrix, call it after this function and not before. 
function cam.Start2D() end

-- Sets up a new 3D rendering context. Must be finished by cam.End3D.  For more advanced settings such as an orthographic view, use cam.Start instead.   Both zNear and zFar need a value before any of them work.  zNear also requires a value higher than 0.  Negative x/y values won't work.  This will not update current view properties.
---@param pos? Vector Render cam position.
---@param angles? Angle Render cam angles.
---@param fov? number Field of view.
---@param x? number X coordinate of where to start the new view port.
---@param y? number Y coordinate of where to start the new view port.
---@param w? number Width of the new viewport.
---@param h? number Height of the new viewport.
---@param zNear? number Distance to near clipping plane.
---@param zFar? number Distance to far clipping plane.
function cam.Start3D(pos,angles,fov,x,y,w,h,zNear,zFar) end

-- Sets up a new 2D rendering context. Must be finished by cam.End3D2D. This function pushes a new matrix onto the stack. (cam.PushModelMatrix)  Matrix formula: ``` local m = Matrix() m:SetAngles(angles) m:SetTranslation(pos) m:SetScale(Vector(scale, -scale, 1)) ```    This should be closed by cam.End3D2D otherwise the game crashes
---@param pos Vector Origin of the 3D2D context, ie. the top left corner, (0, 0).
---@param angles Angle Angles of the 3D2D context. +x in the 2d context corresponds to +x of the angle (its forward direction). +y in the 2d context corresponds to -y of the angle (its right direction).  If (dx, dy) are your desired (+x, +y) unit vectors, the angle you want is dx:AngleEx(dx:Cross(-dy)).
---@param scale number The scale of the render context. If scale is 1 then 1 pixel in 2D context will equal to 1 unit in 3D context.
function cam.Start3D2D(pos,angles,scale) end

-- Sets up a new 3d context using orthographic projection.
---@param leftOffset number The left plane offset.
---@param topOffset number The top plane offset.
---@param rightOffset number The right plane offset.
---@param bottomOffset number The bottom plane offset.
function cam.StartOrthoView(leftOffset,topOffset,rightOffset,bottomOffset) end



chat = {}
-- Adds text to the local player's chat box (which only they can read).
---@param ... any The arguments. Arguments can be: * table - Color. Will set the color for all following strings until the next Color argument. * string - Text to be added to the chat box. * Player - Adds the name of the player in the player's team color to the chat box. * any - Any other type, such as Entity will be converted to string and added as text.
function chat.AddText(...) end

-- Closes the chat window.
function chat.Close() end

-- Returns the chatbox position.
---@return number
---@return number
function chat.GetChatBoxPos() end

-- Returns the chatbox size.
---@return number
---@return number
function chat.GetChatBoxSize() end

-- Opens the chat window.
---@param mode number If equals 1, opens public chat, otherwise opens team chat
function chat.Open(mode) end

-- Plays the chat "tick" sound.
function chat.PlaySound() end



cleanup = {}
-- Adds an entity to a player's cleanup list.
---@param pl Player Who's cleanup list to add the entity to.
---@param type string The type of cleanup.
---@param ent Entity The entity to add to the player's cleanup list.
function cleanup.Add(pl,type,ent) end

--  Called by the `gmod_admin_cleanup` console command. Allows admins to clean up the server.
---@param pl Player The player that called the console command.
---@param command string The console command that called this function.
---@param args table First and only arg is the cleanup type.
function cleanup.CC_AdminCleanup(pl,command,args) end

--  Called by the `gmod_cleanup` console command. Allows players to cleanup their own props.
---@param pl Player The player that called the console command.
---@param command string The console command that called this function.
---@param args table First and only argument is the cleanup type.
function cleanup.CC_Cleanup(pl,command,args) end

-- Gets the cleanup list.
function cleanup.GetList() end

-- Gets the table of cleanup types.
---@return table
function cleanup.GetTable() end

-- Registers a new cleanup type.
---@param type string Name of type.
function cleanup.Register(type) end

-- Replaces one entity in the cleanup module with another
---@param from Entity Old entity
---@param to Entity New entity
---@return boolean
function cleanup.ReplaceEntity(from,to) end

-- Repopulates the clients cleanup menu
function cleanup.UpdateUI() end



concommand = {}
-- Creates a console command that runs a function in lua with optional autocompletion function and help text.  This will fail if the concommand was previously removed with concommand.Remove in a different realm (creating a command on the client that was removed from the server and vice-versa).
---@param name string The command name to be used in console.  This cannot be a name of existing console command or console variable. It will silently fail if it is.
---@param callback function The function to run when the concommand is executed. Arguments passed are: * Player ply - The player that ran the concommand. NULL entity if command was entered with the dedicated server console. * string cmd - The concommand string (if one callback is used for several concommands). * table args - A table of all string arguments. * string argStr - The arguments as a string.
---@param autoComplete? function The function to call which should return a table of options for autocompletion. (Console_Command_Auto-completion)  This only properly works on the client since it is **not** networked. Arguments passed are: * string cmd - The concommand this autocompletion is for. * string args - The arguments typed so far.
---@param helpText? string The text to display should a user run 'help cmdName'.
---@param flags? number Concommand modifier flags. See Enums/FCVAR.
function concommand.Add(name,callback,autoComplete,helpText,flags) end

--  Used by the engine to call the autocomplete function for a console command, and retrieve returned options.
---@param command string Name of command
---@param arguments string Arguments given to the command
---@return table
function concommand.AutoComplete(command,arguments) end

-- Returns the tables of all console command callbacks, and autocomplete functions, that were added to the game with concommand.Add.
---@return table
---@return table
function concommand.GetTable() end

-- Removes a console command.  This will not always remove the command from auto-complete. concommand.Add will fail if the concommand was previously removed with this function in a different realm (creating a command on the client that was removed from the server and vice-versa).
---@param name string The name of the command to be removed.
function concommand.Remove(name) end

-- You might be looking for Global.RunConsoleCommand or Player:ConCommand.  Used by the engine to run a console command's callback function. This will only be called for commands that were added with Global.AddConsoleCommand, which concommand.Add calls internally. An error is sent to the player's chat if no callback is found.  This will still be called for concommands removed with concommand.Remove but will return false.
---@param ply Player Player to run concommand on
---@param cmd string Command name
---@param args any Command arguments. Can be table or string
---@param argumentString string string of all arguments sent to the command
---@return boolean
function concommand.Run(ply,cmd,args,argumentString) end



constraint = {}
-- Stores information about constraints in an entity's table.
---@param ent1 Entity The entity to store the information on.
---@param constrt Entity The constraint to store in the entity's table.
---@param ent2? Entity Optional. If different from `ent1`, the info will also be stored in the table for this entity.
---@param ent3? Entity Optional. Same as `ent2`.
---@param ent4? Entity Optional. Same as `ent2`.
function constraint.AddConstraintTable(ent1,constrt,ent2,ent3,ent4) end

-- Stores info about the constraints on the entity's table. The only difference between this and constraint.AddConstraintTable is that the constraint does not get deleted when the entity is removed.
---@param ent1 Entity The entity to store the information on.
---@param constrt Entity The constraint to store in the entity's table.
---@param ent2? Entity Optional. If different from `ent1`, the info will also be stored in the table for this entity.
---@param ent3? Entity Optional. Same as `ent2`.
---@param ent4? Entity Optional. Same as `ent2`.
function constraint.AddConstraintTableNoDelete(ent1,constrt,ent2,ent3,ent4) end

-- Creates an advanced ballsocket (ragdoll) constraint.  Uses a https://developer.valvesoftware.com/wiki/Phys_ragdollconstraint
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector Position on the first entity, in its local space coordinates.
---@param LPos2 Vector Position on the second entity, in its local space coordinates.
---@param forcelimit number Amount of force until it breaks (0 = unbreakable)
---@param torquelimit number Amount of torque (rotation speed) until it breaks (0 = unbreakable)
---@param xmin number Minimum angle in rotations around the X axis local to the constraint.
---@param ymin number Minimum angle in rotations around the Y axis local to the constraint.
---@param zmin number Minimum angle in rotations around the Z axis local to the constraint.
---@param xmax number Maximum angle in rotations around the X axis local to the constraint.
---@param ymax number Maximum angle in rotations around the Y axis local to the constraint.
---@param zmax number Maximum angle in rotations around the Z axis local to the constraint.
---@param xfric number Rotational friction in the X axis local to the constraint.
---@param yfric number Rotational friction in the Y axis local to the constraint.
---@param zfric number Rotational friction in the Z axis local to the constraint.
---@param onlyrotation number Only limit rotation, free movement.
---@param nocollide number Whether the entities should be no-collided.
---@return Entity
function constraint.AdvBallsocket(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,forcelimit,torquelimit,xmin,ymin,zmin,xmax,ymax,zmax,xfric,yfric,zfric,onlyrotation,nocollide) end

-- Creates an axis constraint.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector Position on the first entity, in its local space coordinates.
---@param LPos2 Vector Position on the second entity, in its local space coordinates.
---@param forcelimit number Amount of force until it breaks (0 = unbreakable)
---@param torquelimit number Amount of torque (rotational force) until it breaks (0 = unbreakable)
---@param friction number Constraint friction.
---@param nocollide number Whether the entities should be no-collided.
---@param LocalAxis Vector If you include the LocalAxis then LPos2 will not be used in the final constraint. However, LPos2 is still a required argument.
---@param DontAddTable boolean Whether or not to add the constraint info on the entity table. See constraint.AddConstraintTable.
---@return Entity
function constraint.Axis(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,forcelimit,torquelimit,friction,nocollide,LocalAxis,DontAddTable) end

-- Creates a ballsocket joint.
---@param Ent1 Entity First entity
---@param Ent2 Entity Second entity
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LocalPos Vector Centerposition of the joint, relative to the **second** entity.
---@param forcelimit number Amount of force until it breaks (0 = unbreakable)
---@param torquelimit number Amount of torque (rotation speed) until it breaks (0 = unbreakable)
---@param nocollide number Whether the entities should be nocollided
---@return Entity
function constraint.Ballsocket(Ent1,Ent2,Bone1,Bone2,LocalPos,forcelimit,torquelimit,nocollide) end

-- Basic checks to make sure that the specified entity and bone are valid. Returns false if we should not be constraining the entity.
---@param ent Entity The entity to check
---@param bone number The bone of the entity to check (use 0 for mono boned ents)
---@return boolean
function constraint.CanConstrain(ent,bone) end

-- Creates a rope without any constraint.
---@param pos Vector Starting position of the rope.
---@param width number Width of the rope.
---@param material string Material of the rope.
---@param Constraint Entity Constraint for the rope.
---@param Ent1 Entity First entity.
---@param LPos1 Vector Position of first end of the rope. Local to Ent1.
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Ent2 Entity Second entity.
---@param LPos2 Vector Position of second end of the rope. Local to Ent2.
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param kv? table (Optional) Any additional key/values to be set on the rope.
---@return Entity
function constraint.CreateKeyframeRope(pos,width,material,Constraint,Ent1,LPos1,Bone1,Ent2,LPos2,Bone2,kv) end

-- Creates an invisible, non-moveable anchor point in the world to which things can be attached. The entity used internally by this function (`gmod_anchor`) only exists in Sandbox derived gamemodes, meaning this function will only work in these gamemodes.  To use this in other gamemodes, you may need to create your own [gmod_anchor](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/entities/gmod_anchor.lua) entity.
---@param pos Vector The position to spawn the anchor at
---@return Entity
---@return PhysObj
---@return number
---@return Vector
function constraint.CreateStaticAnchorPoint(pos) end

-- Creates an elastic constraint.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector Position of first end of the rope. Local to Ent1.
---@param LPos2 Vector Position of second end of the rope. Local to Ent2.
---@param constant number
---@param damping number
---@param rdamping number
---@param material string The material of the rope.
---@param width number Width of rope.
---@param stretchonly boolean
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
function constraint.Elastic(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,constant,damping,rdamping,material,width,stretchonly,color) end

-- Returns the constraint of a specified type between two entities, if it exists
---@param ent1 Entity The first entity to check
---@param ent2 Entity The second entity to check
---@param type string The type of constraint, case sensitive. List of default constrains is as follows: * `Weld` * `Axis` * `AdvBallsocket` * `Rope` * `Elastic` * `NoCollide` * `Motor` * `Pulley` * `Ballsocket` * `Winch` * `Hydraulic` * `Muscle` * `Keepupright` * `Slider`
---@param bone1 number The bone number for the first entity (0 for monoboned entities)
---@param bone2 number The bone number for the second entity
---@return Entity
function constraint.Find(ent1,ent2,type,bone1,bone2) end

-- Returns the first constraint of a specific type directly connected to the entity found
---@param ent Entity The entity to check
---@param type string The type of constraint, case sensitive. List of default constrains is as follows: * `Weld` * `Axis` * `AdvBallsocket` * `Rope` * `Elastic` * `NoCollide` * `Motor` * `Pulley` * `Ballsocket` * `Winch` * `Hydraulic` * `Muscle` * `Keepupright` * `Slider`
---@return table
function constraint.FindConstraint(ent,type) end

-- Returns the other entity involved in the first constraint of a specific type directly connected to the entity
---@param ent Entity The entity to check
---@param type string The type of constraint, case sensitive. List of default constrains is as follows: * `Weld` * `Axis` * `AdvBallsocket` * `Rope` * `Elastic` * `NoCollide` * `Motor` * `Pulley` * `Ballsocket` * `Winch` * `Hydraulic` * `Muscle` * `Keepupright` * `Slider`
---@return Entity
function constraint.FindConstraintEntity(ent,type) end

-- Returns a table of all constraints of a specific type directly connected to the entity
---@param ent Entity The entity to check
---@param type string The type of constraint, case sensitive. List of default constrains is as follows: * `Weld` * `Axis` * `AdvBallsocket` * `Rope` * `Elastic` * `NoCollide` * `Motor` * `Pulley` * `Ballsocket` * `Winch` * `Hydraulic` * `Muscle` * `Keepupright` * `Slider`
---@return table
function constraint.FindConstraints(ent,type) end

-- Make this entity forget any constraints it knows about. Note that this will not actually remove the constraints.
---@param ent Entity The entity that will forget its constraints.
function constraint.ForgetConstraints(ent) end

-- Returns a table of all entities recursively constrained to an entitiy.
---@param ent Entity The entity to check
---@param ResultTable? table Table used to return result. Optional.
---@return table
function constraint.GetAllConstrainedEntities(ent,ResultTable) end

-- Returns a table of all constraints directly connected to the entity
---@param ent Entity The entity to check
---@return table
function constraint.GetTable(ent) end

-- Returns true if the entity has constraints attached to it
---@param ent Entity The entity to check
---@return boolean
function constraint.HasConstraints(ent) end

-- Creates a Hydraulic constraint.
---@param pl Player The player that will be used to call numpad.OnDown.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls),
---@param Bone2 number Bone of second entity (0 for non-ragdolls).
---@param LPos1 Vector
---@param LPos2 Vector
---@param Length1 number
---@param Length2 number
---@param width number The width of the rope.
---@param key number The key binding, corresponding to an Enums/KEY
---@param fixed number Whether the hydraulic is fixed.
---@param speed number
---@param material string The material of the rope.
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
---@return Entity
---@return Entity
function constraint.Hydraulic(pl,Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,Length1,Length2,width,key,fixed,speed,material,color) end

-- Creates a keep upright constraint.  This function only works on prop_physics or prop_ragdoll.
---@param ent Entity The entity to keep upright
---@param ang Angle The angle defined as "upright"
---@param bone number The bone of the entity to constrain (0 for boneless)
---@param angularLimit number Basically, the strength of the constraint
---@return Entity
function constraint.Keepupright(ent,ang,bone,angularLimit) end

-- Creates a motor constraint.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector
---@param LPos2 Vector
---@param friction number
---@param torque number
---@param forcetime number
---@param nocollide number Whether the entities should be no-collided.
---@param toggle number Whether the constraint is on toggle.
---@param pl Player The player that will be used to call numpad.OnDown and numpad.OnUp.
---@param forcelimit number Amount of force until it breaks (0 = unbreakable)
---@param numpadkey_fwd number The key binding for "forward", corresponding to an Enums/KEY
---@param numpadkey_bwd number The key binding for "backwards", corresponding to an Enums/KEY
---@param direction number
---@param LocalAxis Vector
---@return Entity
---@return Entity
function constraint.Motor(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,friction,torque,forcetime,nocollide,toggle,pl,forcelimit,numpadkey_fwd,numpadkey_bwd,direction,LocalAxis) end

-- Creates a muscle constraint.
---@param pl Player The player that will be used to call numpad.OnDown.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector
---@param LPos2 Vector
---@param Length1 number
---@param Length2 number
---@param width number Width of the rope.
---@param key number The key binding, corresponding to an Enums/KEY
---@param fixed number Whether the constraint is fixed.
---@param period number
---@param amplitude number
---@param starton boolean
---@param material string Material of the rope.
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
---@return Entity
---@return Entity
function constraint.Muscle(pl,Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,Length1,Length2,width,key,fixed,period,amplitude,starton,material,color) end

-- Creates an no-collide "constraint". Disables collision between two entities. Does not work with players.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls).
---@param Bone2 number Bone of second entity (0 for non-ragdolls).
---@return Entity
function constraint.NoCollide(Ent1,Ent2,Bone1,Bone2) end

-- Creates a pulley constraint.
---@param Ent1 Entity
---@param Ent4 Entity
---@param Bone1 number
---@param Bone4 number
---@param LPos1 Vector
---@param LPos4 Vector
---@param WPos2 Vector
---@param WPos3 Vector
---@param forcelimit number Amount of force until it breaks (0 = unbreakable)
---@param rigid boolean Whether the constraint is rigid.
---@param width number Width of the rope.
---@param material string Material of the rope.
---@param color table The color of the rope. See Global.Color.
---@return Entity
function constraint.Pulley(Ent1,Ent4,Bone1,Bone4,LPos1,LPos4,WPos2,WPos3,forcelimit,rigid,width,material,color) end

-- Attempts to remove all constraints associated with an entity
---@param ent Entity The entity to remove constraints from
---@return boolean
---@return number
function constraint.RemoveAll(ent) end

-- Attempts to remove all constraints of a specified type associated with an entity
---@param ent Entity The entity to check
---@param type string The constraint type to remove (eg. "Weld", "Elastic", "NoCollide")
---@return boolean
---@return number
function constraint.RemoveConstraints(ent,type) end

-- Creates a rope constraint - with rope!
---@param Ent1 Entity First entity
---@param Ent2 Entity Second entity
---@param Bone1 number Bone of first entity (0 for non-ragdolls)
---@param Bone2 number Bone of second entity (0 for non-ragdolls)
---@param LPos1 Vector Position of first end of the rope. Local to Ent1.
---@param LPos2 Vector Position of second end of the rope. Local to Ent2.
---@param length number Length of the rope.
---@param addlength number Amount to add to the length of the rope. Works as it does in the Rope tool.
---@param forcelimit number Amount of force until it breaks (0 = unbreakable).
---@param width number Width of the rope.
---@param material string Material of the rope.
---@param rigid boolean Whether the constraint is rigid.
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
function constraint.Rope(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,length,addlength,forcelimit,width,material,rigid,color) end

-- Creates a slider constraint.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls),
---@param Bone2 number Bone of second entity (0 for non-ragdolls).
---@param LPos1 Vector
---@param LPos2 Vector
---@param width number The width of the rope.
---@param material string The material of the rope.
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
function constraint.Slider(Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,width,material,color) end

-- Creates a weld constraint
---@param ent1 Entity The first entity
---@param ent2 Entity The second entity
---@param bone1 number The bonenumber of the first entity (0 for monoboned entities)  PhysObj number for ragdolls, see: Entity:TranslateBoneToPhysBone.
---@param bone2 number The bonenumber of the second entity
---@param forcelimit number The amount of force appliable to the constraint before it will break (0 is never)
---@param nocollide boolean Should ent1 be nocollided to ent2 via this constraint
---@param deleteent1onbreak boolean If true, when ent2 is removed, ent1 will also be removed
---@return Entity
function constraint.Weld(ent1,ent2,bone1,bone2,forcelimit,nocollide,deleteent1onbreak) end

-- Creates a Winch constraint.
---@param pl Player The player that will be used to call numpad.OnDown and numpad.OnUp.
---@param Ent1 Entity First entity.
---@param Ent2 Entity Second entity.
---@param Bone1 number Bone of first entity (0 for non-ragdolls),
---@param Bone2 number Bone of second entity (0 for non-ragdolls).
---@param LPos1 Vector
---@param LPos2 Vector
---@param width number The width of the rope.
---@param fwd_bind number The key binding for "forward", corresponding to an Enums/KEY
---@param bwd_bind number The key binding for "backwards", corresponding to an Enums/KEY
---@param fwd_speed number Forward speed.
---@param bwd_speed number Backwards speed.
---@param material string The material of the rope.
---@param toggle boolean Whether the winch should be on toggle.
---@param color table The color of the rope. See Global.Color.
---@return Entity
---@return Entity
---@return Entity
function constraint.Winch(pl,Ent1,Ent2,Bone1,Bone2,LPos1,LPos2,width,fwd_bind,bwd_bind,fwd_speed,bwd_speed,material,toggle,color) end



construct = {}
-- Creates a magnet.
---@param ply Player Player that will have the numpad control over the magnet
---@param pos Vector The position of the magnet
---@param ang Angle The angles of the magnet
---@param model string The model of the maget
---@param material string Material of the magnet ( texture )
---@param key number The key to toggle the magnet, see Enums/KEY
---@param maxObjects number Maximum amount of objects the magnet can hold
---@param strength number Strength of the magnet
---@param nopull? number If &gt; 0, disallows the magnet to pull objects towards it
---@param allowrot? number If &gt; 0, allows rotation of the objects attached
---@param startOn? number If &gt; 0, enabled from spawn
---@param toggle number If != 0, pressing the key toggles the magnet, otherwise you'll have to hold the key to keep it enabled
---@param vel? Vector Velocity to set on spawn
---@param aVel? Angle Angular velocity to set on spawn
---@param frozen? boolean Freeze the magnet on start
---@return Entity
function construct.Magnet(ply,pos,ang,model,material,key,maxObjects,strength,nopull,allowrot,startOn,toggle,vel,aVel,frozen) end

-- Sets props physical properties.
---@param ply Player The player. This variable is not used and can be left out.
---@param ent Entity The entity to apply properties to
---@param physObjID number You can use this or the argument below. This will be used in case you don't provide argument below.
---@param physObj PhysObj The physics object to apply the properties to
---@param data table The table containing properties to apply. See Structures/PhysProperties
function construct.SetPhysProp(ply,ent,physObjID,physObj,data) end



controlpanel = {}
-- Clears ALL the control panels ( for tools )
function controlpanel.Clear() end

-- Returns (or creates if not exists) a control panel.
---@param name string The name of the panel. For normal tools this will be equal to `TOOL.Mode` (the tool's filename without the extension).  When you create a tool/option via spawnmenu.AddToolMenuOption, the internal control panel name is `TOOL.Mode .. "_" .. tool_tab:lower() .. "_" .. tool_category:lower()`.
---@return Panel
function controlpanel.Get(name) end



cookie = {}
-- Deletes a cookie on the client.
---@param name string The name of the cookie that you want to delete.
function cookie.Delete(name) end

-- Gets the value of a cookie on the client as a number.
---@param name string The name of the cookie that you want to get.
---@param default? any Value to return if the cookie does not exist.
---@return number
function cookie.GetNumber(name,default) end

-- Gets the value of a cookie on the client as a string.
---@param name string The name of the cookie that you want to get.
---@param default? any Value to return if the cookie does not exist.
---@return string
function cookie.GetString(name,default) end

-- Sets the value of a cookie, which is saved automatically by the sql.  These are stored in the *.db files - cl.db for clients, mn.db for menu state and sv.db for servers.
---@param key string The name of the cookie that you want to set.
---@param value string Value to store in the cookie.
function cookie.Set(key,value) end



coroutine = {}


cvars = {}
-- Adds a callback to be called when the named convar changes.  This does not callback convars in the menu state. This does not callback convars on the client with FCVAR_GAMEDLL and convars on the server without FCVAR_GAMEDLL. This does not callback convars on the client with FCVAR_REPLICATED.
---@param name string The name of the convar to add the change callback to.
---@param callback function The function to be called when the convar changes. The arguments passed are: * string convar - The name of the convar. * string oldValue - The old value of the convar. * string newValue - The new value of the convar.
---@param identifier? string If set, you will be able to remove the callback using cvars.RemoveChangeCallback. The identifier is not required to be globally unique, as it's paired with the actual name of the convar.
function cvars.AddChangeCallback(name,callback,identifier) end

-- Retrieves console variable as a boolean.
---@param cvar string Name of console variable
---@param default? boolean The value to return if the console variable does not exist
---@return boolean
function cvars.Bool(cvar,default) end

-- Returns a table of the given ConVars callbacks.
---@param name string The name of the ConVar.
---@param createIfNotFound? boolean Whether or not to create the internal callback table for given ConVar if there isn't one yet.   This argument is internal and should not be used.
---@return table
function cvars.GetConVarCallbacks(name,createIfNotFound) end

-- Retrieves console variable as a number.
---@param cvar string Name of console variable
---@param default? any The value to return if the console variable does not exist
---@return number
function cvars.Number(cvar,default) end

-- You are probably looking for cvars.AddChangeCallback.  Called by the engine when a convar value changes.
---@param name string Convar name
---@param oldVal string The old value of the convar
---@param newVal string The new value of the convar
function cvars.OnConVarChanged(name,oldVal,newVal) end

-- Removes a callback for a convar using the the callback's identifier. The identifier should be the third argument specified for cvars.AddChangeCallback.
---@param name string The name of the convar to remove the callback from.
---@param indentifier string The callback's identifier.
function cvars.RemoveChangeCallback(name,indentifier) end

-- Retrieves console variable as a string.
---@param cvar string Name of console variable
---@param default? any The value to return if the console variable does not exist
---@return string
function cvars.String(cvar,default) end



debug = {}
-- Prints out the lua function call stack to the console.
function debug.Trace() end



debugoverlay = {}
-- Displays an axis indicator at the specified position.  This function will silently fail if the **developer** ConVar is set to 0
---@param origin Vector Position origin
---@param ang Angle Angle of the axis
---@param size number Size of the axis
---@param lifetime? number Number of seconds to appear
---@param ignoreZ? boolean If true, will draw on top of everything; ignoring the Z buffer
function debugoverlay.Axis(origin,ang,size,lifetime,ignoreZ) end

-- Displays a solid coloured box at the specified position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param origin Vector Position origin
---@param mins Vector Minimum bounds of the box
---@param maxs Vector Maximum bounds of the box
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the box. Uses the Color
function debugoverlay.Box(origin,mins,maxs,lifetime,color) end

-- Displays a solid colored rotated box at the specified position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param pos Vector World position
---@param mins Vector The mins of the box (lowest corner)
---@param maxs Vector The maxs of the box (highest corner)
---@param ang Angle The angle to draw the box at
---@param lifetime? number Amount of seconds to show the box
---@param color? table The color of the box. Uses the Color
function debugoverlay.BoxAngles(pos,mins,maxs,ang,lifetime,color) end

-- Creates a coloured cross at the specified position for the specified time.  This function will silently fail if the **developer** ConVar is set to 0.
---@param position Vector Position origin
---@param size number Size of the cross
---@param lifetime? number Number of seconds the cross will appear for
---@param color? table The color of the cross. Uses the Color
---@param ignoreZ? boolean If true, will draw on top of everything; ignoring the Z buffer
function debugoverlay.Cross(position,size,lifetime,color,ignoreZ) end

-- Displays 2D text at the specified coordinates.  This function will silently fail if the **developer** ConVar is set to 0.
---@param pos Vector The position in 3D to display the text.
---@param line number Line of text, will offset text on the to display the new line unobstructed
---@param text string The text to display
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the box. Uses the Color
function debugoverlay.EntityTextAtPosition(pos,line,text,lifetime,color) end

-- Draws a 3D grid of limited size in given position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param position Vector
function debugoverlay.Grid(position) end

-- Displays a coloured line at the specified position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param pos1 Vector First position of the line
---@param pos2 Vector Second position of the line
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the line. Uses the Color
---@param ignoreZ? boolean If true, will draw on top of everything; ignoring the Z buffer
function debugoverlay.Line(pos1,pos2,lifetime,color,ignoreZ) end

-- Displays text triangle at the specified coordinates.  This function will silently fail if the **developer** ConVar is set to 0.
---@param x number The position of the text, from 0 ( left ) to 1 ( right ).
---@param y number The position of the text, from 0 ( top ) to 1 ( bottom ).
---@param text string The text to display
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the box. Uses the Color
function debugoverlay.ScreenText(x,y,text,lifetime,color) end

-- Displays a coloured sphere at the specified position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param origin Vector Position origin
---@param size number Size of the sphere
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the sphere. Uses the Color
---@param ignoreZ? boolean If true, will draw on top of everything; ignoring the Z buffer
function debugoverlay.Sphere(origin,size,lifetime,color,ignoreZ) end

-- Displays "swept" box, two boxes connected with lines by their verices.  This function will silently fail if the **developer** ConVar is set to 0.
---@param vStart Vector The start position of the box.
---@param vEnd Vector The end position of the box.
---@param vMins Vector The "minimum" edge of the box.
---@param vMaxs Vector The "maximum" edge of the box.
---@param ang Angle
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the box. Uses the Color
function debugoverlay.SweptBox(vStart,vEnd,vMins,vMaxs,ang,lifetime,color) end

-- Displays text at the specified position.  This function will silently fail if the **developer** ConVar is set to 0.
---@param origin Vector Position origin
---@param text string String message to display
---@param lifetime? number Number of seconds to appear
---@param viewCheck? boolean Clip text that is obscured
function debugoverlay.Text(origin,text,lifetime,viewCheck) end

-- Displays a colored triangle at the specified coordinates.  This function will silently fail if the **developer** ConVar is set to 0.
---@param pos1 Vector First point of the triangle
---@param pos2 Vector Second point of the triangle
---@param pos3 Vector Third point of the triangle
---@param lifetime? number Number of seconds to appear
---@param color? table The color of the box. Uses the Color
---@param ignoreZ? boolean If true, will draw on top of everything; ignoring the Z buffer
function debugoverlay.Triangle(pos1,pos2,pos3,lifetime,color,ignoreZ) end



derma = {}
-- Gets the color from a Derma skin of a panel and returns default color if not found
---@param name string
---@param pnl Panel
---@param default table The default color in case of failure.
function derma.Color(name,pnl,default) end

-- Defines a new Derma control with an optional base.  This calls vgui.Register internally, but also does the following: * Adds the control to derma.GetControlList * Adds a key "Derma" - This is returned by derma.GetControlList * Makes a global table with the name of the control (This is technically deprecated and should not be relied upon) * If reloading (i.e. called this function with name of an existing panel), updates all existing instances of panels with this name. (Updates functions, calls PANEL:PreAutoRefresh and PANEL:PostAutoRefresh, etc.)
---@param name string Name of the newly created control
---@param description string Description of the control
---@param tab table Table containing control methods and properties
---@param base string Derma control to base the new control off of
---@return table
function derma.DefineControl(name,description,tab,base) end

-- Defines a new skin so that it is usable by Derma. The default skin can be found in `garrysmod/lua/skins/default.lua`
---@param name string Name of the skin
---@param descriptions string Description of the skin
---@param skin table Table containing skin data
function derma.DefineSkin(name,descriptions,skin) end

-- Returns the derma.Controls table, a list of all derma controls registered with derma.DefineControl.
---@return table
function derma.GetControlList() end

-- Returns the default skin table, which can be changed with the hook GM:ForceDermaSkin
---@return table
function derma.GetDefaultSkin() end

-- Returns the skin table of the skin with the supplied name
---@param name string Name of skin
---@return table
function derma.GetNamedSkin(name) end

-- Returns a copy of the table containing every Derma skin
---@return table
function derma.GetSkinTable() end

-- Clears all cached panels so that they reassess which skin they should be using.
function derma.RefreshSkins() end

-- Returns how many times derma.RefreshSkins has been called.
---@return number
function derma.SkinChangeIndex() end

-- Calls the specified hook for the given panel
---@param type string The type of hook to run
---@param name string The name of the hook to run
---@param panel Panel The panel to call the hook for
---@param w number The width of the panel
---@param h number The height of the panel
---@return any
function derma.SkinHook(type,name,panel,w,h) end

-- Returns a function to draw a specified texture of panels skin.
---@param name string The identifier of the texture
---@param pnl Panel Panel to get the skin of.
---@param fallback? any What to return if we failed to retrieve the texture
---@return function
function derma.SkinTexture(name,pnl,fallback) end



dragndrop = {}
--  Calls the receiver function of hovered panel.
---@param bDoDrop boolean true if the mouse was released, false if we right clicked.
---@param command number The command value. This should be the ID of the clicked dropdown menu ( if right clicked, or nil )
---@param mx number The local to the panel mouse cursor X position when the click happened.
---@param my number The local to the panel  mouse cursor Y position when the click happened.
function dragndrop.CallReceiverFunction(bDoDrop,command,mx,my) end

-- Clears all the internal drag'n'drop variables.
function dragndrop.Clear() end

-- Handles the drop action of drag'n'drop library.
function dragndrop.Drop() end

-- Returns a table of currently dragged panels.
---@param name? string If set, the function will return only the panels with this Panel:Droppable name.
---@return table
function dragndrop.GetDroppable(name) end

-- If returns true, calls dragndrop.StopDragging in dragndrop.Drop. Seems to be broken and does nothing. Is it for override?
function dragndrop.HandleDroppedInGame() end

--  Handles the hover think. Called from dragndrop.Think.
function dragndrop.HoverThink() end

-- Returns whether the user is dragging something with the drag'n'drop system.
---@return boolean
function dragndrop.IsDragging() end

--  Starts the drag'n'drop.
function dragndrop.StartDragging() end

-- Stops the drag'n'drop and calls dragndrop.Clear.
function dragndrop.StopDragging() end

--  Handles all the drag'n'drop processes. Calls dragndrop.UpdateReceiver and dragndrop.HoverThink.
function dragndrop.Think() end

--  Updates the receiver to drop the panels onto. Called from dragndrop.Think.
function dragndrop.UpdateReceiver() end



draw = {}
-- Simple draw text at position, but this will expand newlines and tabs.    See also MarkupObject for limited width and markup support.
---@param text string Text to be drawn.
---@param font? string Name of font to draw the text in. See surface.CreateFont to create your own, or Default Fonts for a list of default fonts.
---@param x? number The X Coordinate.
---@param y? number The Y Coordinate.
---@param color? table Color to draw the text in. Uses the Color.
---@param xAlign? number Where to align the text horizontally. Uses the Enums/TEXT_ALIGN.
function draw.DrawText(text,font,x,y,color,xAlign) end

-- Returns the height of the specified font in pixels. This is equivalent to the height of the character `W`. See surface.GetTextSize.  
---@param font string Name of the font to get the height of.
---@return number
function draw.GetFontHeight(font) end

-- Sets drawing texture to a default white texture (vgui/white) via surface.SetMaterial. Useful for resetting the drawing texture.  
function draw.NoTexture() end

-- Draws a rounded rectangle. If you intend to draw a non-rounded rectangle, then it's more efficient to use surface.DrawRect.  
---@param cornerRadius number Radius of the rounded corners, works best with a multiple of 2.
---@param x number The x coordinate of the top left of the rectangle.
---@param y number The y coordinate of the top left of the rectangle.
---@param width number The width of the rectangle.
---@param height number The height of the rectangle.
---@param color table The color to fill the rectangle with. Uses the Color.
function draw.RoundedBox(cornerRadius,x,y,width,height,color) end

-- Draws a rounded rectangle. This function also lets you specify which corners are drawn rounded.  
---@param cornerRadius number Radius of the rounded corners, works best with a power of 2 number.
---@param x number The x coordinate of the top left of the rectangle.
---@param y number The y coordinate of the top left of the rectangle.
---@param width number The width of the rectangle.
---@param height number The height of the rectangle.
---@param color table The color to fill the rectangle with. Uses the Color.
---@param roundTopLeft? boolean Whether the top left corner should be rounded.
---@param roundTopRight? boolean Whether the top right corner should be rounded.
---@param roundBottomLeft? boolean Whether the bottom left corner should be rounded.
---@param roundBottomRight? boolean Whether the bottom right corner should be rounded.
function draw.RoundedBoxEx(cornerRadius,x,y,width,height,color,roundTopLeft,roundTopRight,roundBottomLeft,roundBottomRight) end

-- Draws text on the screen. This function does not handle newlines properly. See draw.DrawText for a function that does. 
---@param text string The text to be drawn.
---@param font? string The font. See surface.CreateFont to create your own, or see Default Fonts for a list of default fonts.
---@param x? number The X Coordinate.
---@param y? number The Y Coordinate.
---@param color? table The color of the text. Uses the Color.
---@param xAlign? number The alignment of the X coordinate using Enums/TEXT_ALIGN.
---@param yAlign? number The alignment of the Y coordinate using Enums/TEXT_ALIGN.
---@return number
---@return number
function draw.SimpleText(text,font,x,y,color,xAlign,yAlign) end

-- Creates a simple line of text that is outlined.  
---@param Text string The text to draw.
---@param font? string The font name to draw with. See surface.CreateFont to create your own, or Default_Fonts for a list of default fonts.
---@param x? number The X Coordinate.
---@param y? number The Y Coordinate.
---@param color? table The color of the text. Uses the Color.
---@param xAlign? number The alignment of the X Coordinate using Enums/TEXT_ALIGN.
---@param yAlign? number The alignment of the Y Coordinate using Enums/TEXT_ALIGN.
---@param outlinewidth number Width of the outline.
---@param outlinecolor? table Color of the outline. Uses the Color.
---@return number
---@return number
function draw.SimpleTextOutlined(Text,font,x,y,color,xAlign,yAlign,outlinewidth,outlinecolor) end

-- Works like draw.SimpleText but uses a table structure instead.  
---@param textdata table The text properties. See the Structures/TextData
---@return number
---@return number
function draw.Text(textdata) end

-- Works like draw.Text, but draws the text as a shadow.  
---@param textdata table The text properties. See Structures/TextData
---@param distance number How far away the shadow appears.
---@param alpha? number How visible the shadow is (0-255).
function draw.TextShadow(textdata,distance,alpha) end

-- Draws a texture with a table structure.  
---@param texturedata table The texture properties. See Structures/TextureData.
function draw.TexturedQuad(texturedata) end

-- Draws a rounded box with text in it.  
---@param bordersize number Size of border, should be multiple of 2. Ideally this will be 8 or 16.
---@param x number The X Coordinate.
---@param y number The Y Coordinate.
---@param text string Text to draw.
---@param font string Font to draw in. See surface.CreateFont to create your own, or Default_Fonts for a list of default fonts.
---@param boxcolor table The box color. Uses the Color.
---@param textcolor table The text color. Uses the Color.
---@param xalign? number The alignment of the X coordinate using Enums/TEXT_ALIGN.
---@param yalign? number The alignment of the Y coordinate using Enums/TEXT_ALIGN.
---@return number
---@return number
function draw.WordBox(bordersize,x,y,text,font,boxcolor,textcolor,xalign,yalign) end



drive = {}
--  Optionally alter the view.
---@param ply Player The player
---@param view table The view, see Structures/ViewData
---@return boolean
function drive.CalcView(ply,view) end

--  Clientside, the client creates the cmd (usercommand) from their input device (mouse, keyboard) and then it's sent to the server. Restrict view angles here.
---@param cmd CUserCmd The user command
---@return boolean
function drive.CreateMove(cmd) end

--  Destroys players current driving method.
---@param ply Player The player to affect
function drive.DestroyMethod(ply) end

-- Player has stopped driving the entity.
---@param ply Player The player
---@param ent Entity The entity
function drive.End(ply,ent) end

--  The move is finished. Copy mv back into the target.
---@param ply Player The player
---@param mv CMoveData The move data
---@return boolean
function drive.FinishMove(ply,mv) end

--  Returns ( or creates if inexistent ) a driving method.
---@param ply Player The player
---@return table
function drive.GetMethod(ply) end

--  The move is executed here.
---@param ply Player The player
---@param mv CMoveData The move data
---@return boolean
function drive.Move(ply,mv) end

-- Starts driving for the player.
---@param ply Player The player to affect
---@param ent Entity The entity to drive
---@param mode string The driving mode
function drive.PlayerStartDriving(ply,ent,mode) end

-- Stops the player from driving anything. ( For example a prop in sandbox )
---@param ply Player The player to affect
function drive.PlayerStopDriving(ply) end

-- Registers a new entity drive.
---@param name string The name of the drive.
---@param data table The data required to create the drive. This includes the functions used by the drive.
---@param base string The base of the drive.
function drive.Register(name,data,base) end

-- Called when the player first starts driving this entity
---@param ply Player The player
---@param ent Entity The entity
function drive.Start(ply,ent) end

--  The user command is received by the server and then converted into a move. This is also run clientside when in multiplayer, for prediction to work.
---@param ply Player The player
---@param mv CMoveData The move data
---@param cmd CUserCmd The user command
---@return boolean
function drive.StartMove(ply,mv,cmd) end



duplicator = {}
-- Allow this entity to be duplicated
---@param classname string An entity's classname
function duplicator.Allow(classname) end

-- Calls every function registered with duplicator.RegisterBoneModifier on each bone the ent has.
---@param ply Player The player whose entity this is
---@param ent Entity The entity in question
function duplicator.ApplyBoneModifiers(ply,ent) end

-- Calls every function registered with duplicator.RegisterEntityModifier on the entity.
---@param ply Player The player whose entity this is
---@param ent Entity The entity in question
function duplicator.ApplyEntityModifiers(ply,ent) end

-- Clears/removes the chosen entity modifier from the entity.
---@param ent Entity The entity the modification is stored on
---@param key any The key of the stored entity modifier
function duplicator.ClearEntityModifier(ent,key) end

-- Copies the entity, and all of its constraints and entities, then returns them in a table.
---@param ent Entity The entity to duplicate. The function will automatically copy all constrained entities.
---@param tableToAdd? table A preexisting table to add entities and constraints in from. Uses the same table format as the table returned from this function.
---@return table
function duplicator.Copy(ent,tableToAdd) end

-- Copies the passed table of entities to save for later.
---@param ents table A table of entities to save/copy.
---@return table
function duplicator.CopyEnts(ents) end

-- Returns a table with some entity data that can be used to create a new entity with duplicator.CreateEntityFromTable
---@param ent Entity The entity table to save
---@return table
function duplicator.CopyEntTable(ent) end

--  Creates a constraint from a saved/copied constraint table.
---@param constraint table Saved/copied constraint table
---@param entityList table The list of entities that are to be constrained
---@return Entity
function duplicator.CreateConstraintFromTable(constraint,entityList) end

-- "Create an entity from a table."   This creates an entity using the data in EntTable.   If an entity factory has been registered for the entity's Class, it will be called.   Otherwise, duplicator.GenericDuplicatorFunction will be called instead.
---@param ply Player The player who wants to create something
---@param entTable table The duplication data to build the entity with. See Structures/EntityCopyData
---@return Entity
function duplicator.CreateEntityFromTable(ply,entTable) end

-- "Restores the bone's data."   Loops through Bones and calls Entity:ManipulateBoneScale, Entity:ManipulateBoneAngles and Entity:ManipulateBonePosition on ent with the table keys and the subtable values s, a and p respectively.
---@param ent Entity The entity to be bone manipulated
---@param bones table Table with a Structures/BoneManipulationData for every bone (that has manipulations applied) using the bone ID as the table index.
function duplicator.DoBoneManipulator(ent,bones) end

-- Restores the flex data using Entity:SetFlexWeight and Entity:SetFlexScale
---@param ent Entity The entity to restore the flexes on
---@param flex table The flexes to restore
---@param scale? number The flex scale to apply. (Flex scale is unchanged if omitted)
function duplicator.DoFlex(ent,flex,scale) end

-- "Applies generic every-day entity stuff for ent from table data."   Depending on the values of Model, Angle, Pos, Skin, Flex, Bonemanip, ModelScale, ColGroup, Name, and BodyG (table of multiple values) in the data table, this calls Entity:SetModel, Entity:SetAngles, Entity:SetPos, Entity:SetSkin, duplicator.DoFlex, duplicator.DoBoneManipulator, Entity:SetModelScale, Entity:SetCollisionGroup, Entity:SetName, Entity:SetBodygroup on ent.   If ent has a RestoreNetworkVars function, it is called with data.DT.
---@param ent Entity The entity to be applied upon
---@param data table The data to be applied onto the entity
function duplicator.DoGeneric(ent,data) end

-- "Applies bone data, generically."   If data contains a PhysicsObjects table, it moves, re-angles and if relevent freezes all specified bones, first converting from local coordinates to world coordinates.
---@param ent Entity The entity to be applied upon
---@param ply? Player The player who owns the entity. Unused in function as of early 2013
---@param data table The data to be applied onto the entity
function duplicator.DoGenericPhysics(ent,ply,data) end

-- Returns the entity class factory registered with duplicator.RegisterEntityClass.
---@param name string The name of the entity class factory
---@return table
function duplicator.FindEntityClass(name) end

-- "Generic function for duplicating stuff"   This is called when duplicator.CreateEntityFromTable can't find an entity factory to build with. It calls duplicator.DoGeneric and duplicator.DoGenericPhysics to apply standard duplicator stored things such as the model and position.
---@param ply Player The player who wants to create something
---@param data table The duplication data to build the entity with
---@return Entity
function duplicator.GenericDuplicatorFunction(ply,data) end

--  Fills entStorageTable with all of the entities in a group connected with constraints. Fills constraintStorageTable with all of the constrains constraining the group.
---@param ent Entity The entity to start from
---@param entStorageTable table The table the entities will be inserted into
---@param constraintStorageTable table The table the constraints will be inserted into
---@return table
---@return table
function duplicator.GetAllConstrainedEntitiesAndConstraints(ent,entStorageTable,constraintStorageTable) end

-- Returns whether the entity can be duplicated or not
---@param classname string An entity's classname
---@return boolean
function duplicator.IsAllowed(classname) end

-- "Given entity list and constraint list, create all entities and return their tables"  Calls duplicator.CreateEntityFromTable on each sub-table of EntityList. If an entity is actually created, it calls ENTITY:OnDuplicated with the entity's duplicator data, then duplicator.ApplyEntityModifiers, duplicator.ApplyBoneModifiers and finally  ENTITY:PostEntityPaste is called.  The constraints are then created with duplicator.CreateConstraintFromTable.
---@param Player Player The player who wants to create something
---@param EntityList table A table of duplicator data to create the entities from
---@param ConstraintList table A table of duplicator data to create the constraints from
---@return table
---@return table
function duplicator.Paste(Player,EntityList,ConstraintList) end

-- Registers a function to be called on each of an entity's bones when duplicator.ApplyBoneModifiers is called.  This function is available to call on the client, but registered functions aren't used anywhere!
---@param key any The type of the key doesn't appear to matter, but it is preferable to use a string.
---@param boneModifier function Function called on each bone that an ent has. Called during duplicator.ApplyBoneModifiers. Function parameters are: * Player ply * Entity ent * number boneID * PhysObj bone * table data   The data table that is passed to boneModifier is set with duplicator.StoreBoneModifier
function duplicator.RegisterBoneModifier(key,boneModifier) end

-- Register a function used for creating a duplicated constraint.
---@param name string The unique name of new constraint
---@param callback function Function to be called when this constraint is created
---@param ... any Arguments passed to the callback function
function duplicator.RegisterConstraint(name,callback,...) end

-- This allows you to specify a specific function to be run when your SENT is pasted with the duplicator, instead of relying on the generic automatic functions.  Automatically calls duplicator.Allow for the entity class.
---@param name string The ClassName of the entity you wish to register a factory for
---@param func function The factory function you want to have called. It should have the arguments (Player, ...) where ... is whatever arguments you request to be passed. It also should return the entity created, otherwise duplicator.Paste result will not include it!
---@param ... any Strings of the names of arguments you want passed to function the from the Structures/EntityCopyData. As a special case, "Data" will pass the whole structure.
function duplicator.RegisterEntityClass(name,func,...) end

-- This allows you to register tweaks to entities. For instance, if you were making an "unbreakable" addon, you would use this to enable saving the "unbreakable" state of entities between duplications.  This function registers a piece of generic code that is run on all entities with this modifier. In order to have it actually run, use duplicator.StoreEntityModifier.  This function does nothing when run clientside.
---@param name string An identifier for your modification. This is not limited, so be verbose. `Person's 'Unbreakable' mod` is far less likely to cause conflicts than `unbreakable`
---@param func function The function to be called for your modification. It should have the arguments (`Player`, `Entity`, `Data`), where data is what you pass to duplicator.StoreEntityModifier.
function duplicator.RegisterEntityModifier(name,func) end

-- Help to remove certain map created entities before creating the saved entities This is obviously so we don't get duplicate props everywhere. It should be called before calling Paste.
function duplicator.RemoveMapCreatedEntities() end

-- "When a copy is copied it will be translated according to these. If you set them - make sure to set them back to 0 0 0!"
---@param v Angle The angle to offset all pastes from
function duplicator.SetLocalAng(v) end

-- "When a copy is copied it will be translated according to these. If you set them - make sure to set them back to 0 0 0!"
---@param v Vector The position to offset all pastes from
function duplicator.SetLocalPos(v) end

-- Stores bone mod data for a registered bone modification function
---@param ent Entity The entity to add bone mod data to
---@param boneID number The bone ID. See Entity:GetPhysicsObjectNum
---@param key any The key for the bone modification
---@param data table The bone modification data that is passed to the bone modification function
function duplicator.StoreBoneModifier(ent,boneID,key,data) end

-- Stores an entity modifier into an entity for saving
---@param entity Entity The entity to store modifier in
---@param name string Unique modifier name as defined in duplicator.RegisterEntityModifier
---@param data table Modifier data
function duplicator.StoreEntityModifier(entity,name,data) end

-- Works out the AABB size of the duplication
---@param Ents table A table of entity duplication datums.
---@return Vector
---@return Vector
function duplicator.WorkoutSize(Ents) end



effects = {}
-- Creates a "beam ring point" effect.
---@param pos Vector The origin position of the effect.
---@param lifetime number How long the effect will be drawing for, in seconds.
---@param startRad number Initial radius of the effect.
---@param endRad number Final radius of the effect, at the end of the effect's lifetime.
---@param width number How thick the beam should be.
---@param amplitude number How noisy the beam should be.
---@param color table Beam's Global.Color.
---@param extra? table Extra info, all optional. A table with the following keys: (any combination) * number speed - ? * number spread - ? * number delay - Delay in seconds after which the effect should appear. * number flags- Beam flags. * number framerate - texture framerate. * string material - The material to use instead of the default one.
function effects.BeamRingPoint(pos,lifetime,startRad,endRad,width,amplitude,color,extra) end

-- Creates a bunch of bubbles inside a defined box.
---@param mins Vector The lowest extents of the box.
---@param maxs Vector The highest extents of the box.
---@param count number How many bubbles to spawn. There's a hard limit of 500 tempents at any time.
---@param height number How high the bubbles can fly up before disappearing.
---@param speed? number How quickly the bubbles move.
---@param delay? number Delay in seconds after the function call and before the effect actually spawns.
function effects.Bubbles(mins,maxs,count,height,speed,delay) end

-- Creates a bubble trail effect, the very same you get when shooting underwater.
---@param startPos Vector The start position of the effect.
---@param endPos Vector The end position of the effects.
---@param count number How many bubbles to spawn. There's a hard limit of 500 tempents at any time.
---@param height number How high the bubbles can fly up before disappearing.
---@param speed? number How quickly the bubbles move.
---@param delay? number Delay in seconds after the function call and before the effect actually spawns.
function effects.BubbleTrail(startPos,endPos,count,height,speed,delay) end

-- You are looking for util.Effect.Returns the table of the effect specified.
---@param name string Effect name.
---@return table
function effects.Create(name) end

-- Returns a list of all Lua-defined effects.
---@return table
function effects.GetList() end

-- Registers a new effect.
---@param effect_table table Effect table.
---@param name string Effect name.
function effects.Register(effect_table,name) end



engine = {}
-- Returns the name of the currently running gamemode.
---@return string
function engine.ActiveGamemode() end

-- Closes the server and completely exits.  This is only functional when running in server test mode (launch option -systemtest). Server test mode is used internally at Facepunch as part of the build process to make sure that the dedicated servers aren't crashing on startup.
function engine.CloseServer() end

-- Returns a list of addons the player have subscribed to on the workshop.  This list will also include "Floating" .gma addons that are mounted by the game, but not the folder addons.
---@return table
function engine.GetAddons() end

-- When starting playing a demo, engine.GetDemoPlaybackTick will be reset and its old value will be added to this functions return value.
---@return number
function engine.GetDemoPlaybackStartTick() end

-- Current tick of currently loaded demo.  If not playing a demo, it will return amount of ticks since last demo playback.
---@return number
function engine.GetDemoPlaybackTick() end

-- Returns time scale of demo playback.  If not during demo playback, returns 1.
---@return number
function engine.GetDemoPlaybackTimeScale() end

-- Returns total amount of ticks of currently loaded demo.  If not playing a demo, returns 0 or the value of last played demo.
---@return number
function engine.GetDemoPlaybackTotalTicks() end

-- Returns a table containing info for all installed gamemodes
---@return table
function engine.GetGamemodes() end

-- Returns an array of tables corresponding to all games from which Garry's Mod supports mounting content.
---@return table
function engine.GetGames() end

-- Used internally for in-game menus, may be merged in the future into engine.GetAddons.  Returns the UGC (demos, saves and dupes) the player have subscribed to on the workshop.
---@return table
function engine.GetUserContent() end

-- Returns true if we're currently playing a demo.  You will notice that there's no server-side version of this. That's because there is no server when playing a demo. Demos are both recorded and played back purely clientside.
---@return boolean
function engine.IsPlayingDemo() end

-- Returns true if the game is currently recording a demo file (.dem) using gm_demo
---@return boolean
function engine.IsRecordingDemo() end

-- This is a direct binding to the function `engine-&gt;LightStyle`. This function allows you to change the default light style of the map - so you can make lighting lighter or darker. You’ll need to call render.RedownloadAllLightmaps clientside to refresh the lightmaps to this new color.  Calling this function with arguments 0 and "a" will cause dynamic lights such as those produced by the Light tool to stop working.
---@param lightstyle number The lightstyle to edit. 0 to 63. If you want to edit map lighting, you want to set this to 0.
---@param pattern string The pattern to change the lightstyle to. `a` is the darkest, `z` is the brightest. You can use stuff like "abcxyz" to make flashing patterns. The normal brightness for a map is `m`. Values over `z` are allowed, `~` for instance.
function engine.LightStyle(lightstyle,pattern) end

-- Loads a duplication from the local filesystem.
---@param dupeName string Name of the file. e.g, engine.OpenDupe("dupes/8b809dd7a1a9a375e75be01cdc12e61f.dupe")
---@return string
function engine.OpenDupe(dupeName) end

-- Returns an estimate of the server's performance. Equivalent to calling Global.FrameTime from the server, according to source code.
---@return number
---@return number
function engine.ServerFrameTime() end

-- Sets the mounting options for mountable content.
---@param depotID string The depot id of the game to mount.
---@param doMount boolean The mount state, true to mount, false to unmount
function engine.SetMounted(depotID,doMount) end

-- Returns the number of ticks since the game server started.
---@return number
function engine.TickCount() end

-- Returns the number of seconds between each gametick.
---@return number
function engine.TickInterval() end

-- Returns video recording settings set by video.Record. Used by Demo-To-Video feature.
---@return table
function engine.VideoSettings() end

-- Saves a duplication as a file.
---@param dupe string Dupe table, encoded by util.TableToJSON and compressed by util.Compress
---@param jpeg string The dupe icon, created by render.Capture
function engine.WriteDupe(dupe,jpeg) end

-- Stores savedata into the game (can be loaded using the LoadGame menu)
---@param saveData string Data generated by gmsave.SaveMap
---@param name string Name the save will have.
---@param time number When the save was saved during the game (Put CurTime here)
---@param map string The map the save is used for.
function engine.WriteSave(saveData,name,time,map) end



ents = {}
-- Creates an entity. This function will fail and return `NULL` if the networked-edict limit is hit (around **8176**), or the provided entity class doesn't exist.  Do not use before GM:InitPostEntity has been called, otherwise the server will crash! If you need to perform entity creation when the game starts, create a hook for GM:InitPostEntity and do it there.
---@param class string The classname of the entity to create.
---@return Entity
function ents.Create(class) end

-- Creates a clientside only prop. See also Global.ClientsideModel.   For physics to work you **must** use the _model_ argument, a simple `SetModel` call will not be enough. Parented clientside prop will become detached if the parent entity leaves the PVS. **A workaround is available on its github page.**
---@param model? string The model for the entity to be created. Model must be precached with util.PrecacheModel on the server before usage.
---@return Entity
function ents.CreateClientProp(model) end

-- Creates a clientside only scripted entity. The scripted entity must be of "anim" type.
---@param class string The class name of the entity to create.
---@return Entity
function ents.CreateClientside(class) end

-- Returns a table of all entities along the ray. The ray does not stop on collisions, meaning it will go through walls/entities.
---@param start Vector The start position of the ray
---@param endVal Vector The end position of the ray
---@param mins? Vector The mins corner of the ray
---@param maxs? Vector The maxs corner of the ray
---@return table
function ents.FindAlongRay(start,endVal,mins,maxs) end

-- Gets all entities with the given class, supports wildcards. This works internally by iterating over ents.GetAll. Even if internally ents.GetAll is used, It is faster to use ents.FindByClass than ents.GetAll with a single class comparison.  Asterisks (*) are the only wildcard supported.
---@param class string The class of the entities to find.
---@return table
function ents.FindByClass(class) end

-- Finds all entities that are of given class and are children of given entity. This works internally by iterating over ents.GetAll.
---@param class string The class of entities to search for
---@param parent Entity Parent of entities that are being searched for
---@return table
function ents.FindByClassAndParent(class,parent) end

-- Gets all entities with the given model, supports wildcards. This works internally by iterating over ents.GetAll.
---@param model string The model of the entities to find.
---@return table
function ents.FindByModel(model) end

-- Gets all entities with the given hammer targetname. This works internally by iterating over ents.GetAll.  Doesn't do anything on client.
---@param name string The targetname to look for
---@return table
function ents.FindByName(name) end

-- Returns all entities within the specified box.  Clientside entities will not be returned by this function.  There is a limit of 512 entities for the output!
---@param boxMins Vector The box minimum coordinates.
---@param boxMaxs Vector The box maximum coordinates.
---@return table
function ents.FindInBox(boxMins,boxMaxs) end

--  Finds and returns all entities within the specified cone. Only entities whose Entity:WorldSpaceCenter is within the cone are considered to be in it.  The "cone" is actually a conical "slice" of an axis-aligned box (see: ents.FindInBox). The image to the right shows approximately how this function would look in 2D. Due to this, the entity may be farther than the specified range!  Clientside entities will not be returned by this function.  If there are more than 512 entities in the axis-aligned box around the origin, then the result may be incomplete!
---@param origin Vector The tip of the cone.
---@param normal Vector Direction of the cone.
---@param range number The range of the cone/box around the origin.  The function internally adds 1 to this argument before using it. 
---@param angle_cos number The math.cos of the angle between the center of the cone to its edges, which is half the overall angle of the cone.  1 makes a 0° cone, 0.707 makes approximately 90°, 0 makes 180°, and so on.
---@return table
function ents.FindInCone(origin,normal,range,angle_cos) end

-- Finds all entities that lie within a [PVS](https://developer.valvesoftware.com/wiki/PVS).  The function won't take in to account Global.AddOriginToPVS and the like.
---@param viewPoint any Entity or Vector to find entities within the PVS of. If a player is given, this function will use the player's view entity.
---@return table
function ents.FindInPVS(viewPoint) end

-- Gets all entities within the specified sphere.  Clientside entities will not be returned by this function.  This function internally calls ents.FindInBox with some [radius checks](https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/public/collisionutils.cpp#L256-L301).
---@param origin Vector Center of the sphere.
---@param radius number Radius of the sphere.
---@return table
function ents.FindInSphere(origin,radius) end

-- Fires a use event.
---@param target string Name of the target entity.
---@param activator Entity Activator of the event.
---@param caller Entity Caller of the event.
---@param usetype number Use type. See the Enums/USE.
---@param value number This value is passed to ENTITY:Use, but isn't used by any default entities in the engine.
function ents.FireTargets(target,activator,caller,usetype,value) end

-- Returns a table of all existing entities. The table is sequential
---@return table
function ents.GetAll() end

-- Returns an entity by its index. Same as Global.Entity.
---@param entIdx number The index of the entity.
---@return Entity
function ents.GetByIndex(entIdx) end

-- Gives you the amount of currently existing entities.  Similar to **#**ents.GetAll() but with better performance since the entity table doesn't have to be generated. If ents.GetAll is already being called for iteration, than using the **#** operator on the table will be faster than calling this function since it is JITted.
---@param IncludeKillMe? boolean Include entities with the FL_KILLME flag. This will skip an internal loop, and the function will be more efficient as a byproduct.
---@return number
function ents.GetCount(IncludeKillMe) end

-- Returns the amount of networked entities, which is limited to 8192. ents.Create will fail somewhere between 8064 and 8176 - this can vary based on the amount of existing temp ents.
---@return number
function ents.GetEdictCount() end

-- Returns entity that has given Entity:MapCreationID.
---@param id number Entity's creation id
---@return Entity
function ents.GetMapCreatedEntity(id) end



file = {}
-- Appends a file relative to the `data` folder.
---@param name string The file's name.
---@param content string The content which should be appended to the file.
function file.Append(name,content) end

-- Returns the content of a file asynchronously.  All limitations of file.Read also apply.
---@param fileName string The name of the file.
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@param callback function A callback function that will be called when the file read operation finishes. Arguments are: * string fileName - The `fileName` argument above. * string gamePath - The `gamePath` argument above. * number status - The status of the operation. The list can be found in Enums/FSASYNC. * string data - The entirety of the data of the file.
---@param sync? boolean If `true` the file will be read synchronously.
---@return number
function file.AsyncRead(fileName,gamePath,callback,sync) end

-- Creates a directory that is relative to the `data` folder.
---@param name string The directory's name.
function file.CreateDir(name) end

-- Deletes a file or `empty` folder that is relative to the **data** folder. You can't remove any files outside of **data** folder.
---@param name string The file name.
function file.Delete(name) end

-- Returns a boolean of whether the file or directory exists or not.  This will sometimes return false clientside for directories received from the server via a clientside lua file. You can work around this by using file.Find with the path to the directory followed by a wildcard (no trailing forward slash) and see if the directory is inside the returned directories table (**see second example)**.
---@param name string The file or directory's name.
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return boolean
function file.Exists(name,gamePath) end

-- Returns a list of files and directories inside a single folder.
---@param name string The wildcard to search for. `models/*.mdl` will list **.mdl** files in the `models/` folder.
---@param path string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@param sorting? string The sorting to be used, **optional**.  * `nameasc` sort the files ascending by name. * `namedesc` sort the files descending by name. * `dateasc` sort the files ascending by date. * `datedesc` sort the files descending by date.
---@return table
---@return table
function file.Find(name,path,sorting) end

-- Returns whether the given file is a directory or not.  This will sometimes return false clientside for directories received from the server via a clientside lua file. You can work around this by using file.Find with the path to the directory followed by a wildcard (no trailing forward slash) and see if the directory is inside the returned directories table (**see second example)**.
---@param fileName string The file or directory's name.
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return boolean
function file.IsDir(fileName,gamePath) end

-- Attempts to open a file with the given mode.
---@param fileName string The files name. See file.Write for details on filename restrictions when writing to files.
---@param fileMode string The mode to open the file in. Possible values are: * **r** - read mode * **w** - write mode * **a** - append mode * **rb** - binary read mode * **wb** - binary write mode * **ab** - binary append mode
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return File
function file.Open(fileName,fileMode,gamePath) end

-- Returns the content of a file.  Beware of casing -- some filesystems are case-sensitive. SRCDS on Linux seems to force file/directory creation to lowercase, but will not modify read operations.
---@param fileName string The name of the file.
---@param gamePath? string The path to look for the files and directories in. If this argument is set to `true` then the path will be `GAME`, otherwise if the argument is `false` or `nil` then the path will be `DATA`. See File_Search_Paths for a list of valid paths.
---@return string
function file.Read(fileName,gamePath) end

-- Attempts to rename a file with the given name to another given name.  This function is constrained to the `data/` folder.
---@param orignalFileName string The original file or folder name. See file.Write for details on filename restrictions when writing to files.  **This argument will be forced lowercase.**
---@param targetFileName string The target file or folder name. See file.Write for details on filename restrictions when writing to files.  **This argument will be forced lowercase.**
---@return boolean
function file.Rename(orignalFileName,targetFileName) end

-- Returns the file's size in bytes. If the file is not found, returns `-1`.
---@param fileName string The file's name.
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
function file.Size(fileName,gamePath) end

-- Returns when the file or folder was last modified in Unix time.
---@param path string The **file** or **folder** path.
---@param gamePath string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return number
function file.Time(path,gamePath) end

-- Writes the given string to a file. Erases all previous data in the file. To add data without deleting previous data, use file.Append.
---@param fileName string The name of the file being written into. The path is relative to the **data/** folder.  This argument will be forced lowercase.  The filename **must** end with one of the following: * .txt * .dat * .json * .xml * .csv * .jpg * .jpeg * .png * .vtf * .vmt * .mp3 * .wav * .ogg  Restricted symbols are: `" :`
---@param content string The content that will be written into the file.
function file.Write(fileName,content) end



frame_blend = {}
--   Adds a frame to the blend. Calls frame_blend.CompleteFrame once enough frames have passed since last frame_blend.CompleteFrame call.
function frame_blend.AddFrame() end

--   Blends the frame(s).
function frame_blend.BlendFrame() end

--   Renders the frame onto internal render target.
function frame_blend.CompleteFrame() end

--   Actually draws the frame blend effect.
function frame_blend.DrawPreview() end

-- Returns whether frame blend post processing effect is enabled or not.
---@return boolean
function frame_blend.IsActive() end

--    Returns whether the current frame is the last frame?
---@return boolean
function frame_blend.IsLastFrame() end

--   Returns amount of frames needed to render?
---@return number
function frame_blend.RenderableFrames() end

-- Returns whether we should skip frame or not
---@return boolean
function frame_blend.ShouldSkipFrame() end



game = {}
-- Adds a new ammo type to the game.  You can find a list of default ammo types [here](https://wiki.facepunch.com/gmod/Default_Ammo_Types).  This function **must** be called on both the client and server in GM:Initialize or you will have unexpected problems. There is a limit of 256 ammo types, including the default ones.
---@param ammoData table The attributes of the ammo. See the Structures/AmmoData.
function game.AddAmmoType(ammoData) end

-- Registers a new decal.  There's a rather low limit of around 256 for decal materials that may be registered and they are not cleared on map load.
---@param decalName string The name of the decal.
---@param materialName string The material to be used for the decal. May also be a list of material names, in which case a random material from that list will be chosen every time the decal is placed.
function game.AddDecal(decalName,materialName) end

-- Loads a particle file.  You will still need to call this function clientside regardless if you create the particle effects serverside.
---@param particleFileName string The path of the file to add. Must be (file).pcf.
function game.AddParticles(particleFileName) end

-- Consider using game.GetAmmoTypes and game.GetAmmoData instead. Called by the engine to retrieve the ammo types.
---@return table
function game.BuildAmmoTypes() end

-- If called serverside it will remove **ALL** entities which were not created by the map (not players or weapons held by players).  On the client it will remove decals, sounds, gibs, dead NPCs, and entities created via ents.CreateClientProp.  This function calls GM:PreCleanupMap before cleaning up the map and GM:PostCleanupMap after cleaning up the map.  Calling this in a ENTITY:StartTouch or ENTITY:Touch hook will crash the game.  Calling this destroys all BASS streams.  This can crash when removing _firesmoke entities. **You can use the example below to workaround this issue.**
---@param dontSendToClients? boolean If set to `true`, don't run this functions on all clients.
---@param extraFilters? table Entity classes not to reset during cleanup.
function game.CleanUpMap(dontSendToClients,extraFilters) end

-- Runs a console command. Make sure to add a newline ("\n") at the end of the command.  If you use data that were received from a client, you should avoid using this function because newline and semicolon (at least) allow the client to run arbitrary commands!  For safety, you are urged to prefer using Global.RunConsoleCommand in this case.
---@param stringCommand string String containing the command and arguments to be ran.
function game.ConsoleCommand(stringCommand) end

-- Returns the damage type of given ammo type.
---@param id number Ammo ID to retrieve the damage type of. Starts from 1.
---@return number
function game.GetAmmoDamageType(id) end

-- Returns the Structures/AmmoData for given ID.
---@param id number ID of the ammo type to look up the data for
---@return table
function game.GetAmmoData(id) end

-- Returns the ammo bullet force that is applied when an entity is hit by a bullet of given ammo type.
---@param id number Ammo ID to retrieve the force of. Starts from 1.
---@return number
function game.GetAmmoForce(id) end

-- Returns the ammo type ID for given ammo type name.  See game.GetAmmoName for reverse.
---@param name string Name of the ammo type to look up ID of
---@return number
function game.GetAmmoID(name) end

-- Returns the real maximum amount of ammo of given ammo ID, regardless of the setting of `gmod_maxammo` convar.
---@param id number Ammo type ID
---@return number
function game.GetAmmoMax(id) end

-- Returns the ammo name for given ammo type ID.  See game.GetAmmoID for reverse.
---@param id number Ammo ID to retrieve the name of. Starts from 1.
---@return string
function game.GetAmmoName(id) end

-- Returns the damage given ammo type should do to NPCs.
---@param id number Ammo ID to retrieve the damage info of. Starts from 1.
---@return number
function game.GetAmmoNPCDamage(id) end

-- Returns the damage given ammo type should do to players.
---@param id number Ammo ID to retrieve the damage info of. Starts from 1.
---@return number
function game.GetAmmoPlayerDamage(id) end

-- Returns a list of all ammo types currently registered.
---@return table
function game.GetAmmoTypes() end

-- Returns the counter of a Global State.  See Global States for more information.
---@param name string The name of the Global State to set.  If the Global State by that name does not exist, it will be created.  See Global States for a list of default global states.
---@return number
function game.GetGlobalCounter(name) end

-- Returns whether a Global State is off, active or dead ( inactive )  See Global States for more information.
---@param name string The name of the Global State to retrieve the state of.  If the Global State by that name does not exist, **GLOBAL_DEAD** will be returned.  See Global States for a list of default global states.
---@return number
function game.GetGlobalState(name) end

-- Returns the public IP address and port of the current server. This will return the IP/port that you are connecting through when ran clientside. Returns "loopback" in singleplayer.  Returns "0.0.0.0:`port`" on the server when called too early, including in GM:Initialize and GM:InitPostEntity. This bug seems to only happen the first time a server is launched, and will return the correct value after switching maps.
---@return string
function game.GetIPAddress() end

-- Returns the name of the current map, without a file extension. On the menu state, returns "menu". In Multiplayer this does not return the current map in the CLIENT realm before GM:Initialize.
---@return string
function game.GetMap() end

-- Returns the next map that would be loaded according to the file that is set by the mapcyclefile convar.
---@return string
function game.GetMapNext() end

-- Returns the revision (Not to be confused with [VBSP Version](https://developer.valvesoftware.com/wiki/Source_BSP_File_Format#Versions)) of the current map.
---@return number
function game.GetMapVersion() end

-- Returns the difficulty level of the game.  **TIP:** You can use this function in your scripted NPCs or Nextbots to make them harder, however, it is a good idea to lock powerful attacks behind the highest difficulty instead of just increasing the health.  Internally this is tied to the gamerules entity, so you'll have to wait to wait until GM:InitPostEntity is called to return the skill level
---@return number
function game.GetSkillLevel() end

-- Returns the time scale of the game
---@return number
function game.GetTimeScale() end

-- Returns the worldspawn entity.
---@return Entity
function game.GetWorld() end

-- Returns true if the server is a dedicated server, false if it is a listen server or a singleplayer game.  This always returns false on the client.
---@return boolean
function game.IsDedicated() end

-- Kicks a player from the server. This can be ran before the player has spawned.
---@param id string UserID or SteamID of the player to kick.
---@param reason? string Reason to display to the player. This can span across multiple lines.  This will be shortened to ~512 chars, though this includes the command itself and the player index so will realistically be more around ~498. It is recommended to avoid going near the limit to avoid truncation.
function game.KickID(id,reason) end

-- Loads the next map according to the nextlevel convar, or from the current mapcycle file set by the respective convar.
function game.LoadNextMap() end

-- Returns the map load type of the current map.  After changing the map with the console command `changelevel`, "newgame" is returned. With `changelevel2` (single player only), "transition" is returned.
---@return string
function game.MapLoadType() end

-- Returns the maximum amount of players (including bots) that the server can have.
---@return number
function game.MaxPlayers() end

-- Mounts a GMA addon from the disk. Can be used with steamworks.DownloadUGC  Any error models currently loaded that the mounted addon provides will be reloaded.   Any error materials currently loaded that the mounted addon provides will NOT be reloaded. That means that this cannot be used to fix missing map materials, as the map materials are loaded before you are able to call this.
---@param path string Location of the GMA file to mount, retrieved from steamworks.DownloadUGC. This file does not have to end with the .gma extension, but will be interpreted as a GMA.
---@return boolean
---@return table
function game.MountGMA(path) end

-- Removes all the clientside ragdolls.
function game.RemoveRagdolls() end

-- Sets the counter of a Global State.  See Global States for more information.
---@param name string The name of the Global State to set.  If the Global State by that name does not exist, it will be created.  See Global States for a list of default global states.
---@param count number The value to set for that Global State.
function game.SetGlobalCounter(name,count) end

-- Sets whether a Global State is off, active or dead ( inactive )  See Global States for more information.
---@param name string The name of the Global State to set.  If the Global State by that name does not exist, it will be created.  See Global States for a list of default global states.
---@param state number The state of the Global State. See Enums/GLOBAL
function game.SetGlobalState(name,state) end

-- Sets the difficulty level of the game, can be retrieved with game.GetSkillLevel.  This will automatically change whenever the "skill" convar is modified serverside.  This function will not work if the skill convar doesn't match the targeted value. To work around this, you must use RunConsoleCommand("skill", num) alongside this function.
---@param level number The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).
function game.SetSkillLevel(level) end

-- Sets the time scale of the game.  This function is supposed to remove the need of using the host_timescale convar, which is cheat protected.  To slow down or speed up the movement of a specific player, use Player:SetLaggedMovementValue instead.  Like host_timescale, this method does not affect sounds, if you wish to change that, look into GM:EntityEmitSound.
---@param timeScale number The new timescale, minimum value is 0.001 and maximum is 5.
function game.SetTimeScale(timeScale) end

-- Returns whether the current session is a single player game.
---@return boolean
function game.SinglePlayer() end

-- Returns position the player should start from, this is not the same thing as spawn points, it is used to properly transit the player between maps.
---@return Vector
function game.StartSpot() end



gameevent = {}
-- Adds a [game event](gameevent) listener, creating a new hook using the hook library, which can be listened to via hook.Add with the given `eventName` as event.  List of valid events (with examples) can be found [here](gameevent).  All gameevents are called in the **Menu State**, but if you want to use them you need to use some DLL(like [this](https://github.com/RaphaelIT7/gmod-gameeventmanager) one) or you need to create your own. 
---@param eventName string The event to listen to.
function gameevent.Listen(eventName) end



gamemode = {}
-- Called by the engine to call a hook within the loaded gamemode.  The supplied event 'name' must be defined in the active gamemode. Otherwise, nothing will happen - not even hooks added with hook.Add will be called.  This is similar to hook.Run and hook.Call, except the hook library will call hooks created with hook.Add even if there is no corresponding gamemode function.
---@param name string The name of the hook to call.
---@param ... any The arguments
---@return any
function gamemode.Call(name,...) end

--  This returns the internally stored gamemode table.
---@param name string The name of the gamemode you want to get
---@return table
function gamemode.Get(name) end

-- Called by the engine when a gamemode is being loaded.
---@param gm table Your GM table
---@param name string Name of your gamemode, lowercase, no spaces.
---@param derived string The gamemode name that your gamemode is derived from
function gamemode.Register(gm,name,derived) end



gmod = {}
-- Returns GAMEMODE.
---@return table
function gmod.GetGamemode() end



gmsave = {}
-- Loads a saved map.
---@param mapData string The JSON encoded string containing all the map data.
---@param ply? Player The player to load positions for.
---@param callback? function A function to be called after all the entities have been placed.
function gmsave.LoadMap(mapData,ply,callback) end

-- Sets player position and angles from supplied table
---@param ply Player The player to "load" values for
---@param data table A table containing Origin and Angle keys for position and angles to set.
function gmsave.PlayerLoad(ply,data) end

-- Returns a table containing player position and angles. Used by gmsave.SaveMap.
---@param ply Player The player to "save"
---@return table
function gmsave.PlayerSave(ply) end

-- Saves the map
---@param ply Player The player, whose position should be saved for loading the save
---@return string
function gmsave.SaveMap(ply) end

-- Returns if we should save this entity in a duplication or a map save or not.
---@param ent Entity The entity
---@param t table A table containing classname key with entities classname.
---@return boolean
function gmsave.ShouldSaveEntity(ent,t) end



gui = {}
-- Opens the game menu overlay.
function gui.ActivateGameUI() end

-- Enables the mouse cursor without restricting player movement, like using Sandbox's context menu.  Some CUserCmd functions will return incorrect values when this function is active.
---@param enabled boolean Whether the cursor should be enabled or not. (true = enable, false = disable)
function gui.EnableScreenClicker(enabled) end

-- Hides the game menu overlay.
function gui.HideGameUI() end

-- Simulates a mouse move with the given deltas.
---@param deltaX number The movement delta on the x axis.
---@param deltaY number The movement delta on the y axis.
function gui.InternalCursorMoved(deltaX,deltaY) end

-- Simulates a key press for the given key.
---@param key number The key, see Enums/KEY.
function gui.InternalKeyCodePressed(key) end

-- Simulates a key release for the given key.
---@param key number The key, see Enums/KEY.
function gui.InternalKeyCodeReleased(key) end

-- Simulates a key type typing to the specified key.
---@param key number The key, see Enums/KEY.
function gui.InternalKeyCodeTyped(key) end

-- Simulates an ASCII symbol writing. Use to write text in the chat or in VGUI. Doesn't work while the main menu is open!
---@param code number ASCII code of symbol, see http://www.mikroe.com/img/publication/spa/pic-books/programming-in-basic/chapter/04/fig4-24.gif
function gui.InternalKeyTyped(code) end

-- Simulates a double mouse key press for the given mouse key.
---@param key number The key, see Enums/MOUSE.
function gui.InternalMouseDoublePressed(key) end

-- Simulates a mouse key press for the given mouse key.
---@param key number The key, see Enums/MOUSE.
function gui.InternalMousePressed(key) end

-- Simulates a mouse key release for the given mouse key.
---@param key number The key, see Enums/MOUSE.
function gui.InternalMouseReleased(key) end

-- Simulates a mouse wheel scroll with the given delta.
---@param delta number The amount of scrolling to simulate.
function gui.InternalMouseWheeled(delta) end

-- Returns whether the console is visible or not.
---@return boolean
function gui.IsConsoleVisible() end

-- Returns whether the game menu overlay ( main menu ) is open or not.
---@return boolean
function gui.IsGameUIVisible() end

-- Use input.GetCursorPos instead.  Returns the cursor's position on the screen, or 0, 0 if cursor is not visible.
---@return number
---@return number
function gui.MousePos() end

-- Returns x component of the mouse position.
---@return number
function gui.MouseX() end

-- Returns y component of the mouse position.
---@return number
function gui.MouseY() end

-- Opens specified URL in the steam overlay browser.  When called clientside, user will be asked for confirmation before the website will open. Will silently fail if the URL is more than 512 characters long.
---@param url string URL to open, it has to start with either `http://` or `https://`.
function gui.OpenURL(url) end

-- Converts the specified screen position to a **direction** vector local to the player's view. A related function is Vector:ToScreen, which translates a 3D position to a screen coordinate.  util.AimVector is a more generic version of this, using a custom view instead of the player's current view.
---@param x number X coordinate on the screen.
---@param y number Y coordinate on the screen.
---@return Vector
function gui.ScreenToVector(x,y) end

-- Use input.SetCursorPos instead. Sets the cursor's position on the screen, relative to the topleft corner of the window
---@param mouseX number The X coordinate to move the cursor to.
---@param mouseY number The Y coordinate to move the cursor to.
function gui.SetMousePos(mouseX,mouseY) end

-- Shows console in the game UI.
function gui.ShowConsole() end



GWEN = {}
-- Used in derma skins to create a bordered rectangle drawing function from an image. The texture is taken either from last argument or from SKIN.GwenTexture when material source it's not supplied
---@param x number The X coordinate on the texture
---@param y number The Y coordinate on the texture
---@param w number Width of the area on texture
---@param h number Height of the area on texture
---@param left number Left width of border
---@param top number Top width of border
---@param right number Right width of border
---@param bottom number Bottom width of border
---@param source? IMaterial Texture of source image to create a bordered rectangle from. Uses SKIN.GwenTexture if not set.
---@return function
function GWEN.CreateTextureBorder(x,y,w,h,left,top,right,bottom,source) end

-- Used in derma skins to create a rectangle drawing function from an image. The rectangle will not be scaled, but instead it will be drawn in the center of the box. The texture is taken from SKIN.GwenTexture when mat_override it's not defined
---@param x number The X coordinate on the texture
---@param y number The Y coordinate on the texture
---@param w number Width of the area on texture
---@param h number Height of the area on texture
---@param mat_o? IMaterial Optional. Sets the material this function will use
---@return function
function GWEN.CreateTextureCentered(x,y,w,h,mat_o) end

-- Used in derma skins to create a rectangle drawing function from an image. The texture of the rectangle will be scaled. The texture is taken from SKIN.GwenTexture when mat_override it's not supplied
---@param x number The X coordinate on the texture
---@param y number The Y coordinate on the texture
---@param w number Width of the area on texture
---@param h number Height of the area on texture
---@param mat_o? IMaterial Optional. Sets the material this function will use
---@return function
function GWEN.CreateTextureNormal(x,y,w,h,mat_o) end

-- When used in a material skin, it returns a color value from a point in the skin image.
---@param x number X position of the pixel to get the color from.
---@param y number Y position of the pixel to get the color from.
---@return table
function GWEN.TextureColor(x,y) end



halo = {}
-- Applies a halo glow effect to one or multiple entities. Using this function outside of the GM:PreDrawHalos hook can cause instability or crashes. The ignoreZ parameter will cause the halos to draw over the player's viewmodel. You can work around this using render.DepthRange in the GM:PreDrawViewModel, GM:PostDrawViewModel, GM:PreDrawPlayerHands and GM:PostDrawPlayerHands hooks.
---@param entities table A table of entities to add the halo effect to.
---@param color table The desired color of the halo. See Color.
---@param blurX? number The strength of the halo's blur on the x axis.
---@param blurY? number The strength of the halo's blur on the y axis.
---@param passes? number The number of times the halo should be drawn per frame. **Increasing this may hinder player FPS**.
---@param additive? boolean Sets the render mode of the halo to additive.
---@param ignoreZ? boolean Renders the halo through anything when set to `true`.
function halo.Add(entities,color,blurX,blurY,passes,additive,ignoreZ) end

-- Renders a halo according to the specified table, only used internally, called from a GM:PostDrawEffects hook added by the halo library.
---@param entry table Table with info about the halo to draw.
function halo.Render(entry) end

-- Returns the entity the halo library is currently rendering the halo for.  The main purpose of this function is to be used in ENTITY:Draw in order not to draw certain parts of the entity when the halo is being rendered, so there's no halo around unwanted entity parts, such as lasers, 3D2D displays, etc.
---@return Entity
function halo.RenderedEntity() end



hammer = {}
-- Sends command to Hammer, if Hammer is running with the current map loaded.
---@param cmd string Command to send including arguments  All commands are in the format "command var1 var2 etc"  All commands that pick an entity with x y z , must use the exact position including decimals. i.e. -354.4523 123.4  # List of commands | Command       | Description   | | ------------- | ------------- | | "session_begin mapName mapVersion" | Starts a hammer edit, locking the editor. mapName is the current map without path or suffix, mapVersion is the current version in the .vmf file | | "session_end" | Ends a hammer edit, unlocking the editor. | | "map_check_version mapName mapVersion" | This only works after session_begin, so you'd know the right version already and this only returns ok, this function is apparently useless. | | "entity_create entityClass x y z" | Creates an entity of entityClass at position x y z | | "entity_delete entityClass x y z" | Deletes an entity of entityClass at position x y z | | "entity_set_keyvalue entityClass x y z "key" "value"" | Set's the KeyValue pair of an entity of entityClass at x y z. The Key name and Value String must be in quotes. | | "entity_rotate_incremental entityClass x y z incX incY incZ" | Rotates an entity of entityClass at x y z by incX incY incZ | | "node_create nodeClass nodeID x y z" | Creates an AI node of nodeClass with nodeID at x y z you should keep nodeID unique or you will have issues | | "node_delete nodeID" | Deletes node(s) with nodeID, this will delete multiple nodes if they have the same nodeID | | "nodelink_create startNodeID endNodeID" | Creates a link between AI nodes startNodeID and endNodeID | | "nodelink_delete startNodeID endNodeID" | Removes a link between AI nodes startNodeID and endNodeID |
---@return string
function hammer.SendCommand(cmd) end



hook = {}
-- Add a hook to be called upon the given event occurring.
---@param eventName string The event to hook on to. This can be any GM_Hooks hook, gameevent after using gameevent.Listen, or custom hook run with hook.Call or hook.Run.
---@param identifier any The unique identifier, usually a string. This can be used elsewhere in the code to replace or remove the hook. The identifier **should** be unique so that you do not accidentally override some other mods hook, unless that's what you are trying to do.  The identifier can be either a string, or a table/object with an IsValid function defined such as an Entity or Panel. numbers and booleans, for example, are not allowed.  If the identifier is a table/object, it will be inserted in front of the other arguments in the callback and the hook will be called as long as it's valid. However, as soon as IsValid( identifier ) returns false, the hook will be removed.
---@param func function The function to be called, arguments given to it depend on the identifier used. Returning any value besides nil from the hook's function will stop other hooks of the same event down the loop from being executed. Only return a value when absolutely necessary and when you know what you are doing.  It WILL break other addons.
function hook.Add(eventName,identifier,func) end

-- Calls all hooks associated with the given event until one returns something other than `nil`, and then returns that data.  In almost all cases, you should use hook.Run instead - it calls hook.Call internally but supplies the gamemode table by itself, making your code neater.
---@param eventName string The event to call hooks for.
---@param gamemodeTable? table (optional) If the gamemode is specified, the gamemode hook within will be called, otherwise not.
---@param ... any The arguments to be passed to the hooks.
---@return ...
function hook.Call(eventName,gamemodeTable,...) end

-- Returns a list of all the hooks registered with hook.Add.
---@return table
function hook.GetTable() end

-- Removes the hook with the supplied identifier from the given event.
---@param eventName string The event name.
---@param identifier any The unique identifier of the hook to remove, usually a string.
function hook.Remove(eventName,identifier) end

-- Calls all hooks associated with the given event **until** one returns something other than `nil` and then returns that data. If no hook returns any data, it will try to call the `GAMEMODE:`; alternative, if one exists.  This function internally calls hook.Call.  See also: gamemode.Call - same as this, but does not call hooks if the gamemode hasn't defined the function. 
---@param eventName string The event to call hooks for.
---@param ... any The arguments to be passed to the hooks.
---@return any
function hook.Run(eventName,...) end



http = {}
-- Launches an asynchronous **GET** request to a HTTP server.  HTTP requests returning a status code &gt;= `400` are still considered a success and will call the Structures/HTTPRequest callback.  The Structures/HTTPRequest callback is usually only called on DNS or TCP errors (e.g. the website is unavailable or the domain does not exist).  A rough overview of possible Structures/HTTPRequest messages: * `invalid url` - Invalid/empty url ( no request was attempted ) * `invalid request` - Steam HTTP lib failed to create a HTTP request * `error` - OnComplete callback's second argument, `bError`, is `true` * `unsuccessful` - OnComplete's first argument, `pResult-&gt;m_bRequestSuccessful`, returned `false`  HTTP-requests to destinations on private networks (such as `192.168.0.1`) won't work. To enable HTTP-requests to destinations on private networks use Command Line Parameters `-allowlocalhttp` (serverside only).
---@param url string The URL of the website to fetch.
---@param onSuccess? function Function to be called on success. Arguments are * string body * string size - equal to string.len(body). * table headers * number code - The HTTP success code.
---@param onFailure? function Function to be called on failure. Arguments are * string error - The error message.
---@param headers? table KeyValue table for headers.
function http.Fetch(url,onSuccess,onFailure,headers) end

-- Sends an asynchronous **POST** request to a HTTP server.  HTTP requests returning a status code &gt;= `400` are still considered a success and will call the Structures/HTTPRequest callback.  The Structures/HTTPRequest callback is usually only called on DNS or TCP errors (e.g. the website is unavailable or the domain does not exist).  HTTP-requests to destinations on private networks (such as `192.168.0.1`) won't work. To enable HTTP-requests to destinations on private networks use Command Line Parameters `-allowlocalhttp` (serverside only).
---@param url string The url to of the website to post.
---@param parameters table The post parameters (x-www-form-urlencoded) to be send to the server. **Keys and values must be strings**.
---@param onSuccess? function Function to be called on success. Arguments are * string body * string size - equal to string.len(body). * table headers * number code - The HTTP success code.
---@param onFailure? function Function to be called on failure. Arguments are * string error - The error message.
---@param headers? table KeyValue table for headers.
function http.Post(url,parameters,onSuccess,onFailure,headers) end



input = {}
-- Returns the last key captured by key trapping.
---@return number
function input.CheckKeyTrapping() end

-- Returns the digital value of an analog stick on the current (set up via convars) controller.
---@param axis number The analog axis to poll. See Enums/ANALOG.
---@return number
function input.GetAnalogValue(axis) end

-- Returns the cursor's position on the screen. On macOS, the cursor isn't locked on the middle of the screen which causes a significant offset of the positions returned by this function.
---@return number
---@return number
function input.GetCursorPos() end

-- Gets the button code from a button name. This is opposite of input.GetKeyName.
---@param button string The internal button name, such as E or SHIFT.
---@return number
function input.GetKeyCode(button) end

-- Gets the button name from a numeric button code. The name needs to be translated with language.GetPhrase before being displayed.  Despite the name of the function, this also works for the full range of keys in Enums/BUTTON_CODE.
---@param button number The button, see Enums/BUTTON_CODE.
---@return string
function input.GetKeyName(button) end

-- Gets whether the specified button code is down.  Unlike input.IsKeyDown this can also detect joystick presses from Enums/JOYSTICK
---@param button number The button, valid values are in the range of Enums/BUTTON_CODE.
---@return boolean
function input.IsButtonDown(button) end

-- Returns whether a control key is being pressed
---@return boolean
function input.IsControlDown() end

-- Gets whether a key is down.
---@param key number The key, see Enums/KEY.
---@return boolean
function input.IsKeyDown(key) end

-- Returns whether key trapping is activate and the next key press will be captured.
---@return boolean
function input.IsKeyTrapping() end

-- Gets whether a mouse button is down
---@param mouseKey number The key, see Enums/MOUSE
---@return boolean
function input.IsMouseDown(mouseKey) end

-- Gets whether a shift key is being pressed
---@return boolean
function input.IsShiftDown() end

-- Returns the client's bound key for the specified console command. If the player has multiple keys bound to a single command, there is no defined behavior of which key will be returned.
---@param binding string The binding name
---@param exact? boolean True if the binding should match exactly
---@return string
function input.LookupBinding(binding,exact) end

-- Returns the bind string that the given key is bound to.
---@param key number Key from Enums/BUTTON_CODE
---@return string
function input.LookupKeyBinding(key) end

-- Switches to the provided weapon on the next CUserCmd generation/CreateMove call. Direct binding to [CInput::MakeWeaponSelection](https://github.com/LestaD/SourceEngine2007/blob/43a5c90a5ada1e69ca044595383be67f40b33c61/se2007/game/client/in_main.cpp#L929-L932).
---@param weapon Weapon The weapon entity to switch to.
function input.SelectWeapon(weapon) end

-- Sets the cursor's position on the screen, relative to the topleft corner of the window
---@param mouseX number X coordinate for mouse position
---@param mouseY number Y coordinate for mouse position
function input.SetCursorPos(mouseX,mouseY) end

-- Begins waiting for a key to be pressed so we can save it for input.CheckKeyTrapping. Used by the DBinder.
function input.StartKeyTrapping() end

-- Translates a console command alias, basically reverse of the `alias` console command.
---@param command string The alias to lookup.
---@return string
function input.TranslateAlias(command) end

-- Returns whether a key was initially pressed in the same frame this function was called.  This function only works in Move hooks, and will detect key presses even in main menu or when a typing in a text field.
---@param key number The key, see Enums/KEY.
---@return boolean
function input.WasKeyPressed(key) end

-- Returns whether a key was released in the same frame this function was called.  This function only works in Move hooks, and will detect key releases even in main menu or when a typing in a text field.
---@param key number The key, see Enums/KEY.
---@return boolean
function input.WasKeyReleased(key) end

-- Returns whether the key is being held down or not.  This function only works in Move hooks, and will detect key events even in main menu or when a typing in a text field.
---@param key number The key to test, see Enums/KEY
---@return boolean
function input.WasKeyTyped(key) end

-- Returns whether a mouse key was double pressed in the same frame this function was called.   If this function returns true, input.WasMousePressed will return false.  This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
---@param button number The mouse button to test, see Enums/MOUSE
---@return boolean
function input.WasMouseDoublePressed(button) end

-- Returns whether a mouse key was initially pressed in the same frame this function was called.   If input.WasMouseDoublePressed returns true, this function will return false.  This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
---@param key number The key, see Enums/MOUSE
---@return boolean
function input.WasMousePressed(key) end

-- Returns whether a mouse key was released in the same frame this function was called.  This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
---@param key number The key to test, see Enums/MOUSE
---@return boolean
function input.WasMouseReleased(key) end



jit = {}


killicon = {}
-- Creates new kill icon using a texture.
---@param class string Weapon or entity class
---@param texture string Path to the texture
---@param color table Color of the kill icon
function killicon.Add(class,texture,color) end

-- Creates kill icon from existing one.
---@param new_class string New class of the kill icon
---@param existing_class string Already existing kill icon class
function killicon.AddAlias(new_class,existing_class) end

-- Adds kill icon for given weapon/entity class using special font.
---@param class string Weapon or entity class
---@param font string Font to be used
---@param symbol string The symbol to be used
---@param color table Color of the killicon
function killicon.AddFont(class,font,symbol,color) end

-- Draws a kill icon.
---@param x number X coordinate of the icon
---@param y number Y coordinate of the icon
---@param name string Classname of the kill icon
---@param alpha number Alpha/transparency value ( 0 - 255 ) of the icon
function killicon.Draw(x,y,name,alpha) end

-- Checks if kill icon exists for given class.
---@param class string The class to test
---@return boolean
function killicon.Exists(class) end

-- Returns the size of a kill icon.
---@param name string Classname of the kill icon
---@return number
---@return number
function killicon.GetSize(name) end



language = {}
-- Adds a language item. Language placeholders preceded with "#" are replaced with full text in Garry's Mod once registered with this function.
---@param placeholder string The key for this phrase, without the preceding "#".
---@param fulltext string The phrase that should be displayed whenever this key is used.
function language.Add(placeholder,fulltext) end

-- Retrieves the translated version of inputted string. Useful for concentrating multiple translated strings.
---@param phrase string The phrase to translate
---@return string
function language.GetPhrase(phrase) end



list = {}
-- Adds an item to a named list
---@param identifier string The list identifier
---@param item any The item to add to the list
---@return number
function list.Add(identifier,item) end

-- Returns true if the list contains the value. (as a value - not a key)  For a function that looks for a key and not a value see list.HasEntry.
---@param list string List to search through
---@param value any The value to test
---@return boolean
function list.Contains(list,value) end

-- Returns a copy of the list stored at identifier
---@param identifier string The list identifier
---@return table
function list.Get(identifier) end

-- Returns the actual table of the list stored at identifier. Modifying this will affect the stored list
---@param identifier string The list identifier
---@return table
function list.GetForEdit(identifier) end

-- Returns a list of all lists currently in use.
---@return table
function list.GetTable() end

-- Returns true if the list contains the given key.  For a function that looks for values and not keys see list.Contains.
---@param list string List to search through
---@param key any The key to test
---@return boolean
function list.HasEntry(list,key) end

-- Sets a specific position in the named list to a value.
---@param identifier string The list identifier
---@param key any The key in the list to set
---@param item any The item to set to the list as key
function list.Set(identifier,key,item) end



markup = {}
-- A convenience function that converts a Color into its markup ready string representation.
---@param clr Color The Color to convert.
---@return string
function markup.Color(clr) end

-- Converts a string to its escaped, markup-safe equivalent.
---@param text string The string to sanitize.
---@return string
function markup.Escape(text) end

-- Parses markup into a MarkupObject. Currently, this only supports fonts and colors as demonstrated in the example.
---@param markup string The markup to be parsed.
---@param maxWidth? number The max width of the output
---@return MarkupObject
function markup.Parse(markup,maxWidth) end



math = {}
-- Calculates the difference between two angles.
---@param a number The first angle.
---@param b number The second angle.
---@return number
function math.AngleDifference(a,b) end

-- Gradually approaches the target value by the specified amount.
---@param current number The value we're currently at.
---@param target number The target value. This function will never overshoot this value.
---@param change number The amount that the current value is allowed to change by to approach the target. (It makes no difference whether this is positive or negative.)
---@return number
function math.Approach(current,target,change) end

-- Increments an angle towards another by specified rate.  This function is for numbers representing angles (0-360), NOT Angle objects!
---@param currentAngle number The current angle to increase
---@param targetAngle number The angle to increase towards
---@param rate number The amount to approach the target angle by
---@return number
function math.ApproachAngle(currentAngle,targetAngle,rate) end

-- Converts a binary string into a number.
---@param string string Binary string to convert
---@return number
function math.BinToInt(string) end

-- Basic code for  algorithm.
---@param tDiff number From 0 to 1, where alongside the spline the point will be.
---@param tPoints table A table of Vectors. The amount cannot be less than 4.
---@param tMax number Just leave this at 1.
---@return Vector
function math.BSplinePoint(tDiff,tPoints,tMax) end

-- Clamps a number between a minimum and maximum value.
---@param input number The number to clamp.
---@param min number The minimum value, this function will **never** return a number less than this.
---@param max number The maximum value, this function will **never** return a number greater than this.
---@return number
function math.Clamp(input,min,max) end

-- You should use math.Distance instead  Returns the difference between two points in 2D space. Alias of math.Distance.
---@param x1 number X position of first point
---@param y1 number Y position of first point
---@param x2 number X position of second point
---@param y2 number Y position of second point
---@return number
function math.Dist(x1,y1,x2,y2) end

-- Returns the difference between two points in 2D space.
---@param x1 number X position of first point
---@param y1 number Y position of first point
---@param x2 number X position of second point
---@param y2 number Y position of second point
---@return number
function math.Distance(x1,y1,x2,y2) end

-- Returns the squared difference between two points in 2D space. This is computationally faster than math.Distance.
---@param x1 number X position of first point
---@param y1 number Y position of first point
---@param x2 number X position of second point
---@param y2 number Y position of second point
---@return number
function math.DistanceSqr(x1,y1,x2,y2) end

-- Eases in by reversing the direction of the ease slightly before returning. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InBack(fraction) end

-- Eases in like a bouncy ball. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InBounce(fraction) end

-- Eases in using a circular function.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InCirc(fraction) end

-- Eases in by cubing the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InCubic(fraction) end

-- Eases in like a rubber band. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InElastic(fraction) end

-- Eases in using an exponential equation with a base of 2 and where the fraction is used in the exponent.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InExpo(fraction) end

-- Eases in and out by reversing the direction of the ease slightly before returning on both ends. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutBack(fraction) end

-- Eases in and out like a bouncy ball. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutBounce(fraction) end

-- Eases in and out using a circular function.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutCirc(fraction) end

-- Eases in and out by cubing the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutCubic(fraction) end

-- Eases in and out like a rubber band. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutElastic(fraction) end

-- Eases in and out using an exponential equation with a base of 2 and where the fraction is used in the exponent.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutExpo(fraction) end

-- Eases in and out by squaring the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutQuad(fraction) end

-- Eases in and out by raising the fraction to the power of 4.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutQuart(fraction) end

-- Eases in and out by raising the fraction to the power of 5.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutQuint(fraction) end

-- Eases in and out using math.sin.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InOutSine(fraction) end

-- Eases in by squaring the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InQuad(fraction) end

-- Eases in by raising the fraction to the power of 4.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InQuart(fraction) end

-- Eases in by raising the fraction to the power of 5.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InQuint(fraction) end

-- Eases in using math.sin.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.InSine(fraction) end

-- Eases out by reversing the direction of the ease slightly before finishing. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutBack(fraction) end

-- Eases out like a bouncy ball. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutBounce(fraction) end

-- Eases out using a circular function.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutCirc(fraction) end

-- Eases out by cubing the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutCubic(fraction) end

-- Eases out like a rubber band. This doesn't work properly when used with Global.Lerp as it clamps the fraction between 0 and 1. Using your own version of Global.Lerp that is unclamped would be necessary instead.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutElastic(fraction) end

-- Eases out using an exponential equation with a base of 2 and where the fraction is used in the exponent.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutExpo(fraction) end

-- Eases out by squaring the fraction.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutQuad(fraction) end

-- Eases out by raising the fraction to the power of 4.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutQuart(fraction) end

-- Eases out by raising the fraction to the power of 5.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutQuint(fraction) end

-- Eases out using math.sin.
---@param fraction number Fraction of the progress to ease, from 0 to 1
---@return number
function math.OutSine(fraction) end

-- Calculates the progress of a value fraction, taking in to account given easing fractions
---@param progress number Fraction of the progress to ease, from 0 to 1
---@param easeIn number Fraction of how much easing to begin with
---@param easeOut number Fraction of how much easing to end with
---@return number
function math.EaseInOut(progress,easeIn,easeOut) end

-- Converts an integer to a binary (base-2) string.
---@param int number Number to be converted.
---@return string
function math.IntToBin(int) end

-- Normalizes angle, so it returns value between -180 and 180.
---@param angle number The angle to normalize, in degrees.
---@return number
function math.NormalizeAngle(angle) end

-- Returns a random float between min and max.  See also math.random
---@param min number The minimum value.
---@param max number The maximum value.
---@return number
function math.Rand(min,max) end

-- Remaps the value from one range to another
---@param value number The value
---@param inMin number The minimum of the initial range
---@param inMax number The maximum of the initial range
---@param outMin number The minimum of new range
---@param outMax number The maximum of new range
---@return number
function math.Remap(value,inMin,inMax,outMin,outMax) end

-- Rounds the given value to the nearest whole number or to the given decimal places.
---@param value number The value to round.
---@param decimals? number The decimal places to round to.
---@return number
function math.Round(value,decimals) end

-- Snaps a number to the closest multiplicative of given number. See also Angle:SnapTo.
---@param input number The number to snap.
---@param snapTo number What to snap the input number to.
---@return number
function math.SnapTo(input,snapTo) end

-- Returns the fraction of where the current time is relative to the start and end times
---@param start number Start time in seconds
---@param endVal number End time in seconds
---@param current number Current time in seconds
---@return number
function math.TimeFraction(start,endVal,current) end

-- Rounds towards zero.
---@param num number The number to truncate
---@param digits? number The amount of digits to keep after the point.
---@return number
function math.Truncate(num,digits) end



matproxy = {}
-- Adds a material proxy.
---@param MatProxyData table The information about the proxy. See Structures/MatProxyData
function matproxy.Add(MatProxyData) end

-- Called by the engine from OnBind
---@param uname string
---@param mat IMaterial
---@param ent Entity
function matproxy.Call(uname,mat,ent) end

-- Called by the engine from OnBind
---@param name string
---@param uname string
---@param mat IMaterial
---@param values table
function matproxy.Init(name,uname,mat,values) end

-- Called by engine, returns true if we're overriding a proxy
---@param name string The name of proxy in question
---@return boolean
function matproxy.ShouldOverrideProxy(name) end



menu = {}
-- Used by "Demo to Video" to record the frame.
function menu.RecordFrame() end



menubar = {}
-- Creates the menu bar ( The bar at the top of the screen when holding C or Q in sandbox ) and docks it to the top of the screen. It will not appear.   Calling this multiple times will **NOT** remove previous panel.
function menubar.Init() end

-- Checks if the supplied panel is parent to the menubar
---@param pnl Panel The panel to check
---@return boolean
function menubar.IsParent(pnl) end

-- Parents the menubar to the panel and displays the menubar.
---@param pnl Panel The panel to parent to
function menubar.ParentTo(pnl) end



mesh = {}
-- Pushes the new vertex data onto the render stack.
function mesh.AdvanceVertex() end

-- Starts a new dynamic mesh. If an IMesh is passed, it will use that mesh instead.
---@param mesh? IMesh Mesh to build. This argument can be removed if you wish to build a "dynamic" mesh. See examples below.
---@param primitiveType number Primitive type, see Enums/MATERIAL.
---@param primiteCount number The amount of primitives.
function mesh.Begin(mesh,primitiveType,primiteCount) end

-- Sets the color to be used for the next vertex.
---@param r number Red component.
---@param g number Green component.
---@param b number Blue component.
---@param a number Alpha component.
function mesh.Color(r,g,b,a) end

-- Ends the mesh and renders it.
function mesh.End() end

-- Sets the normal to be used for the next vertex.
---@param normal Vector The normal of the vertex.
function mesh.Normal(normal) end

-- Sets the position to be used for the next vertex.
---@param position Vector The position of the vertex.
function mesh.Position(position) end

-- Draws a quad using 4 vertices.
---@param vertex1 Vector The first vertex.
---@param vertex2 Vector The second vertex.
---@param vertex3 Vector The third vertex.
---@param vertex4 Vector The fourth vertex.
function mesh.Quad(vertex1,vertex2,vertex3,vertex4) end

-- Draws a quad using a position, a normal and the size.
---@param position Vector The center of the quad.
---@param normal Vector The normal of the quad.
---@param sizeX number X size in pixels.
---@param sizeY number Y size in pixels.
function mesh.QuadEasy(position,normal,sizeX,sizeY) end

-- Sets the specular map values.  This function actually does nothing.
---@param r number The red channel multiplier of the specular map.
---@param g number The green channel multiplier of the specular map.
---@param b number The blue channel multiplier of the specular map.
---@param a number The alpha channel multiplier of the specular map.
function mesh.Specular(r,g,b,a) end

-- Sets the s tangent to be used.  This function actually does nothing.
---@param sTanger Vector The s tangent.
function mesh.TangentS(sTanger) end

-- Sets the T tangent to be used.  This function actually does nothing.
---@param tTanger Vector The t tangent.
function mesh.TangentT(tTanger) end

-- Sets the texture coordinates for the next vertex.  Non-zero values of stage require the currently bound material to support it. For example, any LightmappedGeneric material supports stages 1 and 2 (lightmap texture coordinates).
---@param stage number The stage of the texture coordinate.
---@param u number U coordinate.
---@param v number V coordinate.
function mesh.TexCoord(stage,u,v) end

-- It is recommended to use IMesh:BuildFromTriangles instead of the mesh library.  A table of four numbers. This is used by most shaders in Source to hold tangent information of the vertex ( tangentX, tangentY, tangentZ, tangentHandedness ).
---@param tangentX number
---@param tangentY number
---@param tangentZ number
---@param tangentHandedness number
function mesh.UserData(tangentX,tangentY,tangentZ,tangentHandedness) end

-- Returns the amount of vertex that have yet been pushed.
---@return number
function mesh.VertexCount() end



motionsensor = {}
---@param translator table
---@param player Player
---@param rotation Angle
---@return Vector
---@return Angle
---@return table
function motionsensor.BuildSkeleton(translator,player,rotation) end

---@param ent Entity Entity to choose builder for
---@return string
function motionsensor.ChooseBuilderFromEntity(ent) end

-- Returns the depth map material.
---@return IMaterial
function motionsensor.GetColourMaterial() end

function motionsensor.GetSkeleton() end

-- Return whether a kinect is connected - and active (ie - Start has been called).
---@return boolean
function motionsensor.IsActive() end

-- Returns true if we have detected that there's a kinect connected to the PC
---@return boolean
function motionsensor.IsAvailable() end

---@param translator table
---@param sensor table
---@param pos Vector
---@param ang Angle
---@param special_vectors table
---@param boneid number
---@param v table
---@return boolean
function motionsensor.ProcessAngle(translator,sensor,pos,ang,special_vectors,boneid,v) end

---@param translator table
---@param sensor table
---@param pos Vector
---@param rotation Angle
---@return Angle
function motionsensor.ProcessAnglesTable(translator,sensor,pos,rotation) end

---@param translator table
---@param sensor table
---@return Vector
function motionsensor.ProcessPositionTable(translator,sensor) end

-- This starts access to the kinect sensor. Note that this usually freezes the game for a couple of seconds.
---@return boolean
function motionsensor.Start() end

-- Stops the motion capture.
function motionsensor.Stop() end



navmesh = {}
-- Add this position and normal to the list of walkable positions, used before map generation with navmesh.BeginGeneration
---@param pos Vector The terrain position.
---@param dir Vector The normal of this terrain position.
function navmesh.AddWalkableSeed(pos,dir) end

-- Starts the generation of a new navmesh.  This process is highly resource intensive and it's not wise to use during normal gameplay
function navmesh.BeginGeneration() end

-- Clears all the walkable positions, used before calling navmesh.BeginGeneration.
function navmesh.ClearWalkableSeeds() end

-- Creates a new CNavArea.
---@param corner Vector The first corner of the new CNavArea
---@param opposite_corner Vector The opposite (diagonally) corner of the new CNavArea
---@return CNavArea
function navmesh.CreateNavArea(corner,opposite_corner) end

-- Returns a bunch of areas within distance, used to find hiding spots by NextBots for example.
---@param pos Vector The position to search around
---@param radius number Radius to search within
---@param stepdown number Maximum stepdown( fall distance ) allowed
---@param stepup number Maximum stepup( jump height ) allowed
---@return table
function navmesh.Find(pos,radius,stepdown,stepup) end

-- Returns an integer indexed table of all CNavAreas on the current map. If the map doesn't have a navmesh generated then this will return an empty table.
---@return table
function navmesh.GetAllNavAreas() end

-- Returns the position of the edit cursor when nav_edit is set to 1.
---@return Vector
function navmesh.GetEditCursorPosition() end

-- Finds the closest standable ground at, above, or below the provided position.  The ground must have at least 32 units of empty space above it to be considered by this function, unless 16 layers are tested without finding valid ground.
---@param pos Vector Position to find the closest ground for.
---@return number
---@return Vector
function navmesh.GetGroundHeight(pos) end

-- Returns the currently marked CNavArea, for use with editing console commands.
---@return CNavArea
function navmesh.GetMarkedArea() end

-- Returns the currently marked CNavLadder, for use with editing console commands.
---@return CNavLadder
function navmesh.GetMarkedLadder() end

-- Returns the Nav Area contained in this position that also satisfies the elevation limit.  This function will properly see blocked CNavAreas. See navmesh.GetNearestNavArea.
---@param pos Vector The position to search for.
---@param beneathLimit number The elevation limit at which the Nav Area will be searched.
---@return CNavArea
function navmesh.GetNavArea(pos,beneathLimit) end

-- Returns a CNavArea by the given ID.  Avoid calling this function every frame, as internally it does a lookup trough all the CNavAreas, call this once and store the result
---@param id number ID of the CNavArea to get. Starts with 1.
---@return CNavArea
function navmesh.GetNavAreaByID(id) end

-- Returns the highest ID of all nav areas on the map. While this can be used to get all nav areas, this number may not actually be the actual number of nav areas on the map.
---@return number
function navmesh.GetNavAreaCount() end

-- Returns a CNavLadder by the given ID.
---@param id number ID of the CNavLadder to get. Starts with 1.
---@return CNavLadder
function navmesh.GetNavLadderByID(id) end

-- Returns the closest CNavArea to given position at the same height, or beneath it.  This function will ignore blocked CNavAreas. See navmesh.GetNavArea for a function that does see blocked areas.
---@param pos Vector The position to look from
---@param anyZ? boolean This argument is ignored and has no effect
---@param maxDist? number This is the maximum distance from the given position that the function will look for a CNavArea
---@param checkLOS? boolean If this is set to true then the function will internally do a util.TraceLine from the starting position to each potential CNavArea with a [MASK_NPCSOLID_BRUSHONLY](https://wiki.facepunch.com/gmod/Enums/MASK). If the trace fails then the CNavArea is ignored.  If this is set to false then the function will find the closest CNavArea through anything, including the world.
---@param checkGround? boolean If checkGround is true then this function will internally call navmesh.GetNavArea to check if there is a CNavArea directly below the position, and return it if so, before checking anywhere else.
---@param team? number This will internally call CNavArea:IsBlocked to check if the target CNavArea is not to be navigated by the given team. Currently this appears to do nothing.
---@return CNavArea
function navmesh.GetNearestNavArea(pos,anyZ,maxDist,checkLOS,checkGround,team) end

-- Returns the classname of the player spawn entity.
---@return string
function navmesh.GetPlayerSpawnName() end

-- Whether we're currently generating a new navmesh with navmesh.BeginGeneration.
---@return boolean
function navmesh.IsGenerating() end

-- Returns true if a navmesh has been loaded when loading the map.
---@return boolean
function navmesh.IsLoaded() end

-- Loads a new navmesh from the .nav file for current map discarding any changes made to the navmesh previously.
function navmesh.Load() end

-- Deletes every CNavArea and CNavLadder on the map **without saving the changes**.
function navmesh.Reset() end

-- Saves any changes made to navmesh to the .nav file.
function navmesh.Save() end

-- Sets the CNavArea as marked, so it can be used with editing console commands.
---@param area CNavArea The CNavArea to set as the marked area.
function navmesh.SetMarkedArea(area) end

-- Sets the CNavLadder as marked, so it can be used with editing console commands.
---@param area CNavLadder The CNavLadder to set as the marked ladder.
function navmesh.SetMarkedLadder(area) end

-- Sets the classname of the default spawn point entity, used before generating a new navmesh with navmesh.BeginGeneration.
---@param spawnPointClass string The classname of what the player uses to spawn, automatically adds it to the walkable positions during map generation.
function navmesh.SetPlayerSpawnName(spawnPointClass) end



net = {}
-- Sends the currently built net message to all connected players. More information can be found in Net Library Usage.
function net.Broadcast() end

-- Returns the amount of data left to read in the current message. Does nothing when sending data.  This will include 6 extra bits (or 1 byte rounded-up) used by the engine internally.
---@return number
---@return number
function net.BytesLeft() end

-- Returns the size of the current message.  This will include 3 extra bytes (24 bits) used by the engine internally to send the data over the network.
---@return number
---@return number
function net.BytesWritten() end

-- You may be looking for net.Receive.  Function called by the engine to tell the Lua state a message arrived.
---@param length number The message length, in **bits**.
---@param client Player The player that sent the message. This will be `nil` in the client state.
function net.Incoming(length,client) end

-- Reads an angle from the received net message.  You **must** read information in same order as you write it.
---@return Angle
function net.ReadAngle() end

-- Reads a bit from the received net message.  You **must** read information in same order as you write it.
---@return number
function net.ReadBit() end

-- Reads a boolean from the received net message.  You **must** read information in same order as you write it.
---@return boolean
function net.ReadBool() end

-- Reads a Color from the current net message.  You **must** read information in same order as you write it.
---@param hasAlpha? boolean If the color has alpha written or not. **Must match what was given to net.WriteColor.**
---@return table
function net.ReadColor(hasAlpha) end

-- Reads pure binary data from the message.  You **must** read information in same order as you write it.
---@param length number The length of the data to be read, in **bytes**.
---@return string
function net.ReadData(length) end

-- Reads a double-precision number from the received net message.  You **must** read information in same order as you write it.
---@return number
function net.ReadDouble() end

-- Reads an entity from the received net message. You should always check if the specified entity exists as it may have been removed and therefore `NULL` if it is outside of the players [PVS](https://developer.valvesoftware.com/wiki/PVS) or was already removed.  You **must** read information in same order as you write it.
---@return Entity
function net.ReadEntity() end

-- Reads a floating point number from the received net message.  You **must** read information in same order as you write it.
---@return number
function net.ReadFloat() end

--   Reads a word, basically unsigned short. This is used internally to read the "header" of the message which is an unsigned short which can be converted to the corresponding message name via util.NetworkIDToString.
---@return number
function net.ReadHeader() end

-- Reads an integer from the received net message.  You **must** read information in same order as you write it.
---@param bitCount number The amount of bits to be read.  This must be set to what you set to net.WriteInt. Read more information at net.WriteInt.
---@return number
function net.ReadInt(bitCount) end

-- Reads a VMatrix from the received net message. You **must** read information in same order as you write it.
---@return VMatrix
function net.ReadMatrix() end

-- Reads a normal vector from the net message.  You **must** read information in same order as you write it.
---@return Vector
function net.ReadNormal() end

-- Reads a [null-terminated string](https://en.wikipedia.org/wiki/Null-terminated_string) from the net stream. The size of the string is 8 bits plus 8 bits for every ASCII character in the string.  You **must** read information in same order as you write it.
---@return string
function net.ReadString() end

-- Reads a table from the received net message.  Sometimes when sending a table through the net library, the order of the keys may be switched. So be cautious when comparing (See example 1).  You **must** read information in same order as you write it.  See net.WriteTable for extra info.  You may get `net.ReadType: Couldn't read type X` during the execution of the function, the problem is that you are sending objects that **cannot** be serialized/sent over the network.
---@return table
function net.ReadTable() end

-- Used internally by net.ReadTable.  Reads a value from the net message with the specified type, written by net.WriteType.  You **must** read information in same order as you write it.
---@param typeID? number The type of value to be read, using Enums/TYPE.
---@return any
function net.ReadType(typeID) end

-- Reads an unsigned integer with the specified number of bits from the received net message.  You **must** read information in same order as you write it.
---@param numberOfBits number The size of the integer to be read, in bits.  This must be set to what you set to net.WriteUInt. Read more information at net.WriteUInt.
---@return number
function net.ReadUInt(numberOfBits) end

-- Reads a vector from the received net message. Vectors sent by this function are **compressed**, which may result in precision loss. See net.WriteVector for more information.  You **must** read information in same order as you write it.
---@return Vector
function net.ReadVector() end

-- Adds a net message handler. Only one receiver can be used to receive the net message. The message-name is converted to lower-case so the message-names "`BigBlue`" and "`bigblue`" would be equal. You **must** put this function **outside** of any other function or hook for it to work properly unless you know what you are doing!  You **must** read information in the same order as you write it.  Each net message has a length limit of **64KB**!
---@param messageName string The message name to hook to.
---@param callback function The function to be called if the specified message was received. Arguments are:  * number len - Length of the message, in bits. * Player ply - The player that sent the message, works **only** server-side.
function net.Receive(messageName,callback) end

-- Sends the current message to the specified player, or to all players listed in the table.
---@param ply Player The player(s) to send the message to. Can be a table of players or a CRecipientFilter.
function net.Send(ply) end

-- Sends the current message to all except the specified, or to all except all players in the table.
---@param ply Player The player(s) to **NOT** send the message to. Can be a table of players.
function net.SendOmit(ply) end

-- Sends the message to all players that are in the same [Potentially Audible Set (PAS)](https://developer.valvesoftware.com/wiki/PAS) as the position, or simply said, it adds all players that can potentially hear sounds from this position.
---@param position Vector PAS position.
function net.SendPAS(position) end

-- Sends the message to all players the position is in the [PVS](https://developer.valvesoftware.com/wiki/PVS) of or, more simply said, sends the message to players that can potentially see this position.
---@param position Vector Position that must be in players' visibility set.
function net.SendPVS(position) end

-- Sends the current message to the server.  Each net message has a length limit of 65,533 bytes (approximately 64 KiB) and your net message will error and fail to send if it is larger than this.  The message name must be pooled with util.AddNetworkString beforehand!
function net.SendToServer() end

-- Begins a new net message. If another net message is already started and hasn't been sent yet, it will be discarded.  Each net message has a length limit of 65,533 bytes (approximately 64 KiB) and your net message will error and fail to send if it is larger than this.  The message name must be pooled with util.AddNetworkString beforehand!  Net messages will not reliably reach the client until the client's GM:InitPostEntity hook is called.
---@param messageName string The name of the message to send
---@param unreliable? boolean If set to `true`, the message is not guaranteed to reach its destination
---@return boolean
function net.Start(messageName,unreliable) end

-- Writes an angle to the current net message.
---@param angle Angle The angle to be sent.
function net.WriteAngle(angle) end

-- Appends a boolean (as `1` or `0`) to the current net message.  Please note that the bit is written here from a boolean (`true/false`) but net.ReadBit returns a number.
---@param boolean boolean Bit status (false = `0`, true = `1`).
function net.WriteBit(boolean) end

-- Appends a boolean to the current net message. Alias of net.WriteBit.
---@param boolean boolean Boolean value to write.
function net.WriteBool(boolean) end

-- Appends a Color to the current net message.
---@param Color table The Color you want to append to the net message.
---@param writeAlpha? boolean If we should write the alpha of the color or not.
function net.WriteColor(Color,writeAlpha) end

-- Writes a chunk of binary data to the message.
---@param binaryData string The binary data to be sent.
---@param length? number The length of the binary data to be sent, in bytes.
function net.WriteData(binaryData,length) end

-- Appends a double-precision number to the current net message.
---@param double number The double to be sent
function net.WriteDouble(double) end

-- Appends an entity to the current net message.
---@param entity Entity The entity to be sent.
function net.WriteEntity(entity) end

-- Appends a float (number with decimals) to the current net message.
---@param float number The float to be sent.
function net.WriteFloat(float) end

-- Appends an integer - a whole number - to the current net message. Can be read back with net.ReadInt on the receiving end.  Use net.WriteUInt to send an unsigned number (that you know will **never** be negative). Use net.WriteFloat for a non-whole number (e.g. `2.25`).
---@param integer number The integer to be sent.
---@param bitCount number The amount of bits the number consists of. This must be **32** or less.  If you are unsure what to set, just set it to `32`.  Consult the table below to determine the bit count you need:  | Bit Count |  Minimum value |  Maximum value | |-----------|:--------------:|:--------------:| | 3 | -4 | 3 | | 4 | -8 | 7 | | 5 | -16 | 15 | | 6 | -32 | 31 | | 7 | -64 | 63 | | 8 | -128 | 127 | | 9 | -256 | 255 | | 10 | -512 | 511 | | 11 | -1024 | 1023 | | 12 | -2048 | 2047 | | 13 | -4096 | 4095 | | 14 | -8192 | 8191 | | 15 | -16384 | 16383 | | 16 | -32768 | 32767 | | 17 | -65536 | 65535 | | 18 | -131072 | 131071 | | 19 | -262144 | 262143 | | 20 | -524288 | 524287 | | 21 | -1048576 | 1048575 | | 22 | -2097152 | 2097151 | | 23 | -4194304 | 4194303 | | 24 | -8388608 | 8388607 | | 25 | -16777216 | 16777215 | | 26 | -33554432 | 33554431 | | 27 | -67108864 | 67108863 | | 28 | -134217728 | 134217727 | | 29 | -268435456 | 268435455 | | 30 | -536870912 | 536870911 | | 31 | -1073741824 | 1073741823 | | 32 | -2147483648 | 2147483647 |
function net.WriteInt(integer,bitCount) end

-- Writes a VMatrix to the current net message.
---@param matrix VMatrix The matrix to be sent.
function net.WriteMatrix(matrix) end

-- Writes a normalized/direction vector ( Vector with length of 1 ) to the net message.  This function uses less bandwidth compared to net.WriteVector and will not send vectors with length of &gt; 1 properly.
---@param normal Vector The normalized/direction vector to be send.
function net.WriteNormal(normal) end

-- Appends a string to the current net message. The size of the string is 8 bits plus 8 bits for every ASCII character in the string. The maximum allowed length of a single written string is **65532 characters**.
---@param string string The string to be sent.
function net.WriteString(string) end

-- Appends a table to the current net message. Adds **16 extra bits** per key/value pair so you're better off writing each individual key/value as the exact type if possible.  All net messages have a **64kb** buffer. This function will not check or error when that buffer is overflown. You might want to consider using util.TableToJSON and util.Compress and send the resulting string in **60kb** chunks, doing the opposite on the receiving end.
---@param table table The table to be sent.  If the table contains a `nil` key the table may not be read correctly.  Not all objects can be sent over the network. Things like functions, IMaterials, etc will cause errors when reading the table from a net message.
function net.WriteTable(table) end

-- Used internally by net.WriteTable.  Appends any type of value to the current net message.  An additional 8-bit unsigned integer indicating the type will automatically be written to the packet before the value, in order to facilitate reading with net.ReadType. If you know the data type you are writing, use a function meant for that specific data type to reduce amount of data sent.
---@param Data any The data to be sent.
function net.WriteType(Data) end

-- Appends an unsigned integer with the specified number of bits to the current net message.  Use net.WriteInt if you want to send negative and positive numbers. Use net.WriteFloat for a non-whole number (e.g. `2.25`).  Unsigned numbers **do not** support negative numbers.
---@param unsignedInteger number The unsigned integer to be sent.
---@param numberOfBits number The size of the integer to be sent, in bits. Acceptable values range from any number `1` to `32` inclusive.  For reference: `1` = bit, `4` = nibble, `8` = byte, `16` = short, `32` = long.  Consult the table below to determine the bit count you need. The minimum value for all bit counts is `0`.  | Bit Count |  Maximum value | |-----------|:--------------:| | 1 | 1  | | 2 | 3  | | 3 | 7  | | 4 | 15 | | 5 | 31 | | 6 | 63 | | 7 | 127 | | 8 | 255 | | 9 | 511 | | 10 | 1023 | | 11 | 2047 | | 12 | 4095 | | 13 | 8191 | | 14 | 16383 | | 15 | 32767 | | 16 | 65535 | | 17 | 131071 | | 18 | 262143 | | 19 | 524287  | | 20 | 1048575  | | 21 | 2097151  | | 22 | 4194303  | | 23 | 8388607  | | 24 | 16777215  | | 25 | 33554431  | | 26 | 67108863  | | 27 | 134217727  | | 28 | 268435455  | | 29 | 536870911  | | 30 | 1073741823 | | 31 | 2147483647 | | 32 | 4294967295 |
function net.WriteUInt(unsignedInteger,numberOfBits) end

-- Appends a vector to the current net message. Vectors sent by this function are compressed, which may result in precision loss. XYZ components greater than `16384` or less than `-16384` are irrecoverably altered (most significant bits are trimmed) and precision after the decimal point is low.
---@param vector Vector The vector to be sent.
function net.WriteVector(vector) end



notification = {}
-- Adds a standard notification to your screen.
---@param text string The text to display.
---@param type number Determines the notification method (e.g. icon) for displaying the notification. See the Enums/NOTIFY.
---@param length number The number of seconds to display the notification for.
function notification.AddLegacy(text,type,length) end

-- Adds a notification with an animated progress bar.
---@param id any Can be any type. It's used as an index.
---@param strText string The text to show
---@param frac? number If set, overrides the progress bar animation with given percentage. Range is 0 to 1.
function notification.AddProgress(id,strText,frac) end

-- Removes the notification after 0.8 seconds.
---@param uid any The unique ID of the notification
function notification.Kill(uid) end



numpad = {}
-- Activates numpad key owned by the player
---@param ply Player The player whose numpad should be simulated
---@param key number The key to press, see Enums/KEY
---@param isButton boolean Should this keypress pretend to be a from a gmod_button? (causes numpad.FromButton to return true)
function numpad.Activate(ply,key,isButton) end

-- Deactivates numpad key owned by the player
---@param ply Player The player whose numpad should be simulated
---@param key number The key to press, corresponding to Enums/KEY
---@param isButton boolean Should this keypress pretend to be a from a gmod_button? (causes numpad.FromButton to return true)
function numpad.Deactivate(ply,key,isButton) end

-- Returns true during a function added with numpad.Register when the third argument to numpad.Activate is true.  This is caused when a numpad function is triggered by a button SENT being used.
---@return boolean
function numpad.FromButton() end

-- Calls a function registered with numpad.Register when a player presses specified key.  See for key released action: numpad.OnUp
---@param ply Player The player whose numpad should be watched
---@param key number The key, corresponding to Enums/KEY
---@param name string The name of the function to run, corresponding with the one used in numpad.Register
---@param ... any Arguments to pass to the function passed to numpad.Register.
---@return number
function numpad.OnDown(ply,key,name,...) end

-- Calls a function registered with numpad.Register when a player releases specified key.  See for key pressed action: numpad.OnDown
---@param ply Player The player whose numpad should be watched
---@param key number The key, corresponding to Enums/KEY
---@param name string The name of the function to run, corresponding with the one used in numpad.Register
---@param ... any Arguments to pass to the function passed to numpad.Register.
---@return number
function numpad.OnUp(ply,key,name,...) end

-- Registers a numpad library action for use with numpad.OnDown and numpad.OnUp
---@param id string The unique id of your action.
---@param func function The function to be executed.  Arguments are:  Player ply - The player who pressed the button  vararg ... - The 4th and all subsequent arguments passed from numpad.OnDown and/or numpad.OnUp  Returning **false** in this function will remove the listener which triggered this function (example: return false if one of your varargs is an entity which is no longer valid)
function numpad.Register(id,func) end

-- Removes a function added by either numpad.OnUp or numpad.OnDown
---@param ID number The impulse ID returned by numpad.OnUp or numpad.OnDown
function numpad.Remove(ID) end

-- Either runs numpad.Activate or numpad.Deactivate depending on the key's current state
---@param ply Player The player whose numpad should be simulated
---@param key number The key to press, corresponding to Enums/KEY
function numpad.Toggle(ply,key) end



os = {}


package = {}


permissions = {}
-- Requests the player to connect to a specified server. The player will be prompted with a confirmation window.
---@param address string The address to ask to connect to. If a port is not given, the default `:27015` port will be added.
function permissions.AskToConnect(address) end

-- Connects player to the server. This is what permissions.AskToConnect uses internally.
---@param ip string IP address to connect.
function permissions.Connect(ip) end

-- Activates player's microphone as if they pressed the speak button themself. The player will be prompted with a confirmation window which grants permission temporarily/permanently(depending on checkbox state) for the connected server (revokable). This is used for TTT's traitor voice channel.
---@param enable boolean Enable or disable voice activity. `true` will run `+voicerecord` command, anything else `-voicerecord`.
function permissions.EnableVoiceChat(enable) end

-- Returns all permissions per server. Permanent permissions are stored in `settings/permissions.bin`.
---@return table
function permissions.GetAll() end

-- Grants permission to the current connected server.
---@param permission string Permission to grant for the server the player is currently connected.
---@param temporary boolean `true` if the permission should be granted temporary.
function permissions.Grant(permission,temporary) end

-- Returns whether the player has granted the current server a specific permission.
---@param permission string The permission to poll. Currently only 2 permission is valid: * "connect" * "voicerecord"
---@return boolean
function permissions.IsGranted(permission) end

-- Revokes permission from the server.
---@param permission string Permission to revoke from the server.
---@param ip string IP of the server.
function permissions.Revoke(permission,ip) end



physenv = {}
-- Adds surface properties to the game's physics environment.  The game has a limit of 128 surface properties - this includes properties loaded automatically from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt). Due to this, there's only a small amount of open slots that can be registered with GMod's provided surfaceproperties.txt.
---@param properties string The properties to add. Each one should include "base" or the game will crash due to some values being missing.
function physenv.AddSurfaceData(properties) end

-- Returns the air density used to calculate drag on physics objects. The unit is in `kg/m^3`.
---@return number
function physenv.GetAirDensity() end

-- Gets the gravitational acceleration used for physics objects in `source_unit/s^2`.
---@return Vector
function physenv.GetGravity() end

-- Returns the last simulation duration of the in-game physics.
---@return number
function physenv.GetLastSimulationTime() end

-- Gets the current performance settings in table form.
---@return table
function physenv.GetPerformanceSettings() end

-- Sets the air density.
---@param airDensity number The new air density.
function physenv.SetAirDensity(airDensity) end

-- Sets the gravitational acceleration used for physics objects. Does not work on players.
---@param gravAccel Vector The new gravity in `source_unit/s^2`.
function physenv.SetGravity(gravAccel) end

-- Sets the performance settings.
---@param performanceSettings table The new performance settings. See Structures/PhysEnvPerformanceSettings
function physenv.SetPerformanceSettings(performanceSettings) end



player = {}
-- Similar to the serverside command "bot", this function creates a new Player bot with the given name. This bot will not obey to the usual "bot_*" commands, and it's the same bot base used in TF2 and CS:S.  The best way to control the behaviour of a Player bot right now is to use the GM:StartCommand hook and modify its input serverside.  Despite this Player being fake, it has to be removed from the server by using Player:Kick and **NOT** Entity:Remove. Also keep in mind that these bots still use player slots, so you won't be able to spawn them in singleplayer!  Any Bot created using this method will be considered UnAuthed by Garry's Mod
---@param botName string The name of the bot, using an already existing name will append brackets at the end of it with a number pertaining it.  Example: "Bot name test", "Bot name test(1)".
---@return Player
function player.CreateNextBot(botName) end

-- Gets all the current players in the server (not including connecting clients).  This function returns bots as well as human players. See player.GetBots and  player.GetHumans. This function returns a sequential table, meaning it should be looped with Global.ipairs instead of Global.pairs for efficiency reasons.
---@return table
function player.GetAll() end

-- Returns a table of all bots on the server.
---@return table
function player.GetBots() end

-- Gets the player with the specified AccountID. Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.
---@param accountID number The Player:AccountID to find the player by.
---@return Player
function player.GetByAccountID(accountID) end

-- Gets the player with the specified connection ID.  Connection ID can be retrieved via gameevent.Listen events.  For a function that returns a player based on their Entity:EntIndex, see Global.Entity.   For a function that returns a player based on their Player:UserID, see Global.Player.
---@param connectionID number The connection ID to find the player by.
---@return Player
function player.GetByID(connectionID) end

-- Gets the player with the specified SteamID. Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.
---@param steamID string The Player:SteamID to find the player by.
---@return Player
function player.GetBySteamID(steamID) end

-- Gets the player with the specified SteamID64. Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.
---@param steamID64 string The Player:SteamID64 to find the player by.
---@return Player
function player.GetBySteamID64(steamID64) end

-- Use player.GetBySteamID64, player.GetBySteamID or player.GetByAccountID to get a player by a unique identifier instead.  Gets the player with the specified uniqueID (not recommended way to identify players).  It is highly recommended to use player.GetByAccountID, player.GetBySteamID or player.GetBySteamID64 instead as this function can have collisions ( be same for different people ) while SteamID is guaranteed to unique to each player. Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.
---@param uniqueID string The Player:UniqueID to find the player by.
---@return Player
function player.GetByUniqueID(uniqueID) end

-- Gives you the player count.  Similar to **#**player.GetAll() but with better performance since the player table doesn't have to be generated. If player.GetAll is already being called for iteration, then using the **#** operator on the table will be faster than calling this function since it is JITted.
---@return number
function player.GetCount() end

-- Returns a table of all human ( non bot/AI ) players.  Unlike player.GetAll, this does not include bots.
---@return table
function player.GetHumans() end



player_manager = {}
-- Assigns view model hands to player model.
---@param name string Player model name
---@param model string Hands model
---@param skin? number Skin to apply to the hands
---@param bodygroups? string Bodygroups to apply to the hands. See Entity:SetBodyGroups for help with the format.
---@param matchBodySkin? boolean If set to `true`, the skin of the hands will be set to the skin of the playermodel. This is useful when player models have multiple user-selectable skins.
function player_manager.AddValidHands(name,model,skin,bodygroups,matchBodySkin) end

-- Associates a simplified name with a path to a valid player model.   Only used internally.
---@param name string Simplified name
---@param model string Valid PlayerModel path
function player_manager.AddValidModel(name,model) end

-- Returns the entire list of valid player models.
function player_manager.AllValidModels() end

-- Clears a player's class association by setting their ClassID to 0
---@param ply Player Player to clear class from
function player_manager.ClearPlayerClass(ply) end

-- Gets a players class
---@param ply Player Player to get class
---@return string
function player_manager.GetPlayerClass(ply) end

-- Retrieves a copy of all registered player classes.
---@return table
function player_manager.GetPlayerClasses() end

-- Applies basic class variables when the player spawns.  Called from GM:PlayerSpawn in the base gamemode.
---@param ply Player Player to setup
function player_manager.OnPlayerSpawn(ply) end

-- Register a class metatable to be assigned to players later
---@param name string Class name
---@param table table Class metatable
---@param base string Base class name
function player_manager.RegisterClass(name,table,base) end

-- Execute a named function within the player's set class
---@param ply Player Player to execute function on.
---@param funcName string Name of function.
---@param ...? any Optional arguments. Can be of any type.
---@return ...
function player_manager.RunClass(ply,funcName,...) end

-- Sets a player's class
---@param ply Player Player to set class
---@param classname string Name of class to set
function player_manager.SetPlayerClass(ply,classname) end

-- Retrieves correct hands for given player model. By default returns citizen hands.
---@param name string Player model name
---@return table
function player_manager.TranslatePlayerHands(name) end

-- Returns the valid model path for a simplified name.
---@param shortName string The short name of the model.
---@return string
function player_manager.TranslatePlayerModel(shortName) end

-- Returns the simplified name for a valid model path of a player model.  Opposite of player_manager.TranslatePlayerModel.
---@param model string The model path to a player model
---@return string
function player_manager.TranslateToPlayerModelName(model) end



presets = {}
-- Adds preset to a preset group.
---@param groupname string The preset group name, usually it's tool class name.
---@param name string Preset name, must be unique.
---@param values table A table of preset console commands.
function presets.Add(groupname,name,values) end

--   Used internally to tell the player that the name they tried to use in their preset is not acceptable.
function presets.BadNameAlert() end

-- Returns whether a preset with given name exists or not
---@param type string The preset group name, usually it's tool class name.
---@param name string Name of the preset to test
---@return boolean
function presets.Exists(type,name) end

-- Returns a table with preset names and values from a single preset group.
---@param groupname string Preset group name.
---@return table
function presets.GetTable(groupname) end

--   Used internally to ask the player if they want to override an already existing preset.
---@param callback function
function presets.OverwritePresetPrompt(callback) end

-- Removes a preset entry from a preset group.
---@param groupname string Preset group to remove from
---@param name string Name of preset to remove
function presets.Remove(groupname,name) end

-- Renames preset.
---@param groupname string Preset group name
---@param oldname string Old preset name
---@param newname string New preset name
function presets.Rename(groupname,oldname,newname) end



properties = {}
-- Add properties to the properties module
---@param name string A unique name used to identify the property
---@param propertyData table A table that defines the property. Uses the Structures/PropertyAdd.
function properties.Add(name,propertyData) end

-- Returns true if given entity can be targeted by the player via the properties system.  This should be used serverside in your properties to prevent abuse by clientside scripting.
---@param ent Entity The entity to test
---@param ply Player If given, will also perform a distance check based on the entity's Orientated Bounding Box.
---@return boolean
function properties.CanBeTargeted(ent,ply) end

-- Returns an entity player is hovering over with their cursor.
---@param pos Vector Eye position of local player, Entity:EyePos
---@param aimVec Vector Aim vector of local player, Player:GetAimVector
---@return Entity
function properties.GetHovered(pos,aimVec) end

-- Checks if player hovers over any entities and open a properties menu for it.
---@param eyepos Vector The eye pos of a player
---@param eyevec Vector The aim vector of a player
function properties.OnScreenClick(eyepos,eyevec) end

-- Opens properties menu for given entity.
---@param ent Entity The entity to open menu for
---@param tr table The trace that is passed as second argument to Action callback of a property
function properties.OpenEntityMenu(ent,tr) end



render = {}
-- Adds a beam segment to the beam started by render.StartBeam.
---@param startPos Vector Beam start position.
---@param width number The width of the beam.
---@param textureEnd number The end coordinate of the texture used.
---@param color table The color to be used. Uses the Color.
function render.AddBeam(startPos,width,textureEnd,color) end

-- Blurs the render target ( or a given texture )
---@param rendertarget ITexture The texture to blur
---@param blurx number Horizontal amount of blur
---@param blury number Vertical amount of blur
---@param passes number Amount of passes to go through
function render.BlurRenderTarget(rendertarget,blurx,blury,passes) end

-- This function overrides the brush material for next render operations. It can be used with Entity:DrawModel.
---@param mat? IMaterial
function render.BrushMaterialOverride(mat) end

-- Captures a part of the current render target and returns the data as a binary string in the given format.  Since the pixel buffer clears itself every frame, this will return a black screen outside of render hooks. To capture the user's final view, use GM:PostRender. This will not capture the Steam overlay or third-party injections (such as the Discord overlay, Overwolf, and advanced cheats) on the user's screen.  In PNG mode, this function can produce unexpected result where foreground is rendered as transparent. This is caused by render.SetWriteDepthToDestAlpha set to `true` when doing most of render operations, including rendering in `_rt_fullframefb`. If you want to capture render target's content as PNG image only for output quality, set Structures/RenderCaptureData's `alpha` to `false` when capturing render targets with render.SetWriteDepthToDestAlpha set to `true`.
---@param captureData table Parameters of the capture. See Structures/RenderCaptureData.
---@return string
function render.Capture(captureData) end

-- Dumps the current render target and allows the pixels to be accessed by render.ReadPixel.
function render.CapturePixels() end

-- Clears the current render target and the specified buffers.  This sets the alpha incorrectly for surface draw calls for render targets.
---@param r number Red component to clear to.
---@param g number Green component to clear to.
---@param b number Blue component to clear to.
---@param a number Alpha component to clear to.
---@param clearDepth? boolean Clear the depth.
---@param clearStencil? boolean Clear the stencil.
function render.Clear(r,g,b,a,clearDepth,clearStencil) end

-- Clears the current rendertarget for obeying the current stencil buffer conditions.
---@param r number Value of the **red** channel to clear the current rt with.
---@param g number Value of the **green** channel to clear the current rt with.
---@param b number Value of the **blue** channel to clear the current rt with.
---@param a number Value of the **alpha** channel to clear the current rt with.
---@param depth boolean Clear the depth buffer.
function render.ClearBuffersObeyStencil(r,g,b,a,depth) end

-- Resets the depth buffer.  This function also clears the stencil buffer. Use render.Clear in the meantime.
function render.ClearDepth() end

-- Clears a render target  It uses render.Clear then render.SetRenderTarget on the modified render target.
---@param texture ITexture
---@param color table The color, see Color
function render.ClearRenderTarget(texture,color) end

-- Resets all values in the stencil buffer to zero.
function render.ClearStencil() end

-- Sets the stencil value in a specified rect.  This is **not** affected by render.SetStencilWriteMask
---@param originX number X origin of the rectangle.
---@param originY number Y origin of the rectangle.
---@param endX number The end X coordinate of the rectangle.
---@param endY number The end Y coordinate of the rectangle.
---@param stencilValue number Value to set cleared stencil buffer to.
function render.ClearStencilBufferRectangle(originX,originY,endX,endY,stencilValue) end

-- Calculates the lighting caused by dynamic lights for the specified surface.
---@param position Vector The position to sample from.
---@param normal Vector The normal of the surface.
---@return Vector
function render.ComputeDynamicLighting(position,normal) end

-- Calculates the light color of a certain surface.
---@param position Vector The position of the surface to get the light from.
---@param normal Vector The normal of the surface to get the light from.
---@return Vector
function render.ComputeLighting(position,normal) end

-- Copies the currently active Render Target to the specified texture.
---@param Target ITexture The texture to copy to
function render.CopyRenderTargetToTexture(Target) end

-- Copies the contents of one texture to another. Only works with rendertargets.
---@param texture_from ITexture
---@param texture_to ITexture
function render.CopyTexture(texture_from,texture_to) end

-- Changes the cull mode.
---@param cullMode number Cullmode, see Enums/MATERIAL_CULLMODE
function render.CullMode(cullMode) end

-- Set's the depth range of the upcoming render.
---@param depthmin number The minimum depth of the upcoming render. `0.0` = render normally; `1.0` = render nothing.
---@param depthmax number The maximum depth of the upcoming render. `0.0` = render everything (through walls); `1.0` = render normally.
function render.DepthRange(depthmin,depthmax) end

-- Draws textured beam.  
---@param startPos Vector Beam start position.
---@param endPos Vector Beam end position.
---@param width number The width of the beam.
---@param textureStart number The start coordinate of the texture used.
---@param textureEnd number The end coordinate of the texture used.
---@param color? table The color to be used. Uses the Color.
function render.DrawBeam(startPos,endPos,width,textureStart,textureEnd,color) end

-- Draws a box in 3D space.  
---@param position Vector Origin of the box.
---@param angles Angle Orientation of the box.
---@param mins Vector Start position of the box, relative to origin.
---@param maxs Vector End position of the box, relative to origin.
---@param color? table The color of the box. Uses the Color.
function render.DrawBox(position,angles,mins,maxs,color) end

-- Draws a line in 3D space.  
---@param startPos Vector Line start position in world coordinates.
---@param endPos Vector Line end position in world coordinates.
---@param color? table The color to be used. Uses the Color.
---@param writeZ? boolean Whether or not to consider the Z buffer. If false, the line will be drawn over everything currently drawn, if true, the line will be drawn with depth considered, as if it were a regular object in 3D space.  Enabling this option will cause the line to ignore the color's alpha.
function render.DrawLine(startPos,endPos,color,writeZ) end

-- Draws 2 connected triangles. Expects material to be set by render.SetMaterial.  
---@param vert1 Vector First vertex.
---@param vert2 Vector The second vertex.
---@param vert3 Vector The third vertex.
---@param vert4 Vector The fourth vertex.
---@param color? table The color of the quad. See Global.Color
function render.DrawQuad(vert1,vert2,vert3,vert4,color) end

-- Draws a quad.  
---@param position Vector Origin of the sprite.
---@param normal Vector The face direction of the quad.
---@param width number The width of the quad.
---@param height number The height of the quad.
---@param color table The color of the quad. Uses the Color.
---@param rotation? number The rotation of the quad counter-clockwise in degrees around the normal axis. In other words, the quad will always face the same way but this will rotate its corners.
function render.DrawQuadEasy(position,normal,width,height,color,rotation) end

-- Draws the current material set by render.SetMaterial to the whole screen. The color cannot be customized.  See also render.DrawScreenQuadEx.  
---@param applyPoster? boolean If set to true, when rendering a poster the quad will be properly drawn in parts in the poster. This is used internally by some Post Processing effects. Certain special textures (frame buffer like textures) do not need this adjustment.
function render.DrawScreenQuad(applyPoster) end

-- Draws the the current material set by render.SetMaterial to the area specified. Color cannot be customized.  See also render.DrawScreenQuad.  
---@param startX number X start position of the rect.
---@param startY number Y start position of the rect.
---@param width number Width of the rect.
---@param height number Height of the rect.
function render.DrawScreenQuadEx(startX,startY,width,height) end

-- Draws a sphere in 3D space. The material previously set with render.SetMaterial will be applied the sphere's surface.  See also render.DrawWireframeSphere for a wireframe equivalent.  
---@param position Vector Position of the sphere.
---@param radius number Radius of the sphere. Negative radius will make the sphere render inwards rather than outwards.
---@param longitudeSteps number The number of longitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.
---@param latitudeSteps number The number of latitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.
---@param color? table The color of the sphere. Uses the Color.
function render.DrawSphere(position,radius,longitudeSteps,latitudeSteps,color) end

-- Draws a sprite in 3D space.  
---@param position Vector Position of the sprite.
---@param width number Width of the sprite.
---@param height number Height of the sprite.
---@param color? table Color of the sprite. Uses the Color.
function render.DrawSprite(position,width,height,color) end

-- Draws a texture over the whole screen.  
---@param tex ITexture The texture to draw
function render.DrawTextureToScreen(tex) end

-- Draws a textured rectangle.  
---@param tex ITexture The texture to draw
---@param x number The x coordinate of the rectangle to draw.
---@param y number The y coordinate of the rectangle to draw.
---@param width number The width of the rectangle to draw.
---@param height number The height of the rectangle to draw.
function render.DrawTextureToScreenRect(tex,x,y,width,height) end

-- Draws a wireframe box in 3D space.  
---@param position Vector Position of the box.
---@param angle Angle Angles of the box.
---@param mins Vector The lowest corner of the box.
---@param maxs Vector The highest corner of the box.
---@param color? table The color of the box. Uses the Color.
---@param writeZ? boolean Sets whenever to write to the zBuffer.
function render.DrawWireframeBox(position,angle,mins,maxs,color,writeZ) end

-- Draws a wireframe sphere in 3d space.  
---@param position Vector Position of the sphere.
---@param radius number The size of the sphere.
---@param longitudeSteps number The amount of longitude steps. The larger this number is, the smoother the sphere is.
---@param latitudeSteps number The amount of latitude steps. The larger this number is, the smoother the sphere is.
---@param color? table The color of the wireframe. Uses the Color.
---@param writeZ? boolean Whether or not to consider the Z buffer. If false, the wireframe will be drawn over everything currently drawn. If true, it will be drawn with depth considered, as if it were a regular object in 3D space.
function render.DrawWireframeSphere(position,radius,longitudeSteps,latitudeSteps,color,writeZ) end

-- Sets the status of the clip renderer, returning previous state.  To prevent unintended rendering behavior of other mods/the game, you must reset the clipping state to its previous value.  Reloading the map does not reset the previous value of this function.
---@param state boolean New clipping state.
---@return boolean
function render.EnableClipping(state) end

-- Ends the beam mesh of a beam started with render.StartBeam.
function render.EndBeam() end

-- Sets the color of the fog.
---@param red number Red channel of the fog color, 0 - 255.
---@param green number Green channel of the fog color, 0 - 255.
---@param blue number Blue channel of the fog color, 0 - 255.
function render.FogColor(red,green,blue) end

-- Sets the at which the fog reaches its max density.
---@param distance number The distance at which the fog reaches its max density.  If used in GM:SetupSkyboxFog, this value **must** be scaled by the first argument of the hook
function render.FogEnd(distance) end

-- Sets the maximum density of the fog.
---@param maxDensity number The maximum density of the fog, 0-1.
function render.FogMaxDensity(maxDensity) end

-- Sets the mode of fog.
---@param fogMode number Fog mode, see Enums/MATERIAL_FOG.
function render.FogMode(fogMode) end

-- Sets the distance at which the fog starts showing up.
---@param fogStart number The distance at which the fog starts showing up. If used in GM:SetupSkyboxFog, this value **must** be scaled by the first argument of the hook
function render.FogStart(fogStart) end

-- Returns the ambient color of the map.
---@return Vector
function render.GetAmbientLightColor() end

-- Returns the current alpha blending.
---@return number
function render.GetBlend() end

---@return ITexture
function render.GetBloomTex0() end

---@return ITexture
function render.GetBloomTex1() end

-- Returns the current color modulation values as normals.
---@return number
---@return number
---@return number
function render.GetColorModulation() end

-- Returns the maximum available directX version.
---@return number
function render.GetDXLevel() end

-- Returns the current fog color.
---@return number
---@return number
---@return number
function render.GetFogColor() end

-- Returns the fog start and end distance.
---@return number
---@return number
---@return number
function render.GetFogDistances() end

-- Returns the fog mode.
---@return number
function render.GetFogMode() end

-- Returns the _rt_FullFrameDepth texture. Alias of _rt_PowerOfTwoFB
---@return ITexture
function render.GetFullScreenDepthTexture() end

-- Returns whether HDR is currently enabled or not. This takes into account hardware support, current map and current client settings.
---@return boolean
function render.GetHDREnabled() end

-- Gets the light exposure on the specified position.
---@param position Vector The position of the surface to get the light from.
---@return Vector
function render.GetLightColor(position) end

---@return ITexture
function render.GetMoBlurTex0() end

---@return ITexture
function render.GetMoBlurTex1() end

---@return ITexture
function render.GetMorphTex0() end

---@return ITexture
function render.GetMorphTex1() end

-- Returns the render target's power of two texture.
---@return ITexture
function render.GetPowerOfTwoTexture() end

-- Alias of render.GetPowerOfTwoTexture.
---@return ITexture
function render.GetRefractTexture() end

-- Returns the currently active render target.  Instead of saving the current render target using this function and restoring to it later, it is generally better practice to use render.PushRenderTarget and render.PopRenderTarget.
---@return ITexture
function render.GetRenderTarget() end

-- Returns the `_rt_ResolvedFullFrameDepth` texture for SSAO depth. It will only be updated if GM:NeedsDepthPass returns true.
---@return ITexture
function render.GetResolvedFullFrameDepth() end

-- Obtain an ITexture of the screen. You must call render.UpdateScreenEffectTexture in order to update this texture with the currently rendered scene.  This texture is mainly used within GM:RenderScreenspaceEffects
---@param textureIndex? number Max index is 3, but engine only creates the first two for you.
---@return ITexture
function render.GetScreenEffectTexture(textureIndex) end

---@return ITexture
function render.GetSmallTex0() end

---@return ITexture
function render.GetSmallTex1() end

-- Returns a floating point texture the same resolution as the screen.  The gmodscreenspace doesn't behave as expected when drawing a floating-point texture to an integer texture (e.g. the default render target). Use an UnlitGeneric material instead
---@return ITexture
function render.GetSuperFPTex() end

-- See render.GetSuperFPTex
---@return ITexture
function render.GetSuperFPTex2() end

-- Performs a render trace and returns the color of the surface hit, this uses a low res version of the texture.
---@param startPos Vector The start position to trace from.
---@param endPos Vector The end position of the trace.
---@return Vector
function render.GetSurfaceColor(startPos,endPos) end

-- Returns a vector representing linear tone mapping scale.
---@return Vector
function render.GetToneMappingScaleLinear() end

-- Returns the current view setup.
---@param noPlayer? boolean If `true`, returns the `view-&gt;GetViewSetup`, if `false` - returns `view-&gt;GetPlayerViewSetup`
---@return table
function render.GetViewSetup(noPlayer) end

-- Sets the render material override for all next calls of Entity:DrawModel. Also overrides render.MaterialOverrideByIndex.
---@param material IMaterial The material to use as override, use nil to disable.
function render.MaterialOverride(material) end

-- Similar to render.MaterialOverride, but overrides the materials per index.  render.MaterialOverride overrides effects of this function.
---@param index number Starts with 0, the index of the material to override
---@param material IMaterial The material to override with
function render.MaterialOverrideByIndex(index,material) end

-- Returns the maximum texture height the renderer can handle.
---@return number
function render.MaxTextureHeight() end

-- Returns the maximum texture width the renderer can handle.
---@return number
function render.MaxTextureWidth() end

-- Creates a new Global.ClientsideModel, renders it at the specified pos/ang, and removes it. Can also be given an existing CSEnt to reuse instead.  This function is only meant to be used in a single render pass kind of scenario, if you need to render a model continuously, use a cached Global.ClientsideModel and provide it as a second argument.  Using this with a map model (game.GetWorld():Entity:GetModel()) crashes the game.
---@param settings table Requires: * string model - The model to draw * Vector pos - The position to draw the model at * Angle angle - The angles to draw the model at
---@param ent? CSEnt If provided, this entity will be reused instead of creating a new one with Global.ClientsideModel. Note that the ent's model, position and angles will be changed, and Entity:SetNoDraw will be set to true.
function render.Model(settings,ent) end

-- Sets a material to override a model's default material. Similar to Entity:SetMaterial except it uses an IMaterial argument and it can be used to change materials on models which are part of the world geometry.
---@param material IMaterial The material override.
function render.ModelMaterialOverride(material) end

-- Overrides the write behaviour of all next rendering operations towards the alpha channel of the current render target.  See also render.OverrideBlend.  Doing surface draw calls with alpha set to 0 is a no-op and will never have any effect.
---@param enable boolean Enable or disable the override.
---@param shouldWrite boolean If the previous argument is true, sets whether the next rendering operations should write to the alpha channel or not. Has no effect if the previous argument is false.
function render.OverrideAlphaWriteEnable(enable,shouldWrite) end

-- Overrides the internal graphical functions used to determine the final color and alpha of a rendered texture.  See also render.OverrideAlphaWriteEnable.  Doing surface draw calls with alpha set to 0 is a no-op and won't have an effect.
---@param enabled boolean true to enable, false to disable. No other arguments are required when disabling.
---@param srcBlend number The source color blend function Enums/BLEND. Determines how a rendered texture's final color should be calculated.
---@param destBlend number The destination color blend function Enums/BLEND.
---@param blendFunc number The blend mode used for drawing the color layer Enums/BLENDFUNC.
---@param srcBlendAlpha? number The source alpha blend function Enums/BLEND. Determines how a rendered texture's final alpha should be calculated.
---@param destBlendAlpha? number The destination alpha blend function Enums/BLEND.
---@param blendFuncAlpha? number The blend mode used for drawing the alpha layer Enums/BLENDFUNC.
function render.OverrideBlend(enabled,srcBlend,destBlend,blendFunc,srcBlendAlpha,destBlendAlpha,blendFuncAlpha) end

-- Use render.OverrideBlend instead.  Overrides the internal graphical functions used to determine the final color and alpha of a rendered texture.  See also render.OverrideAlphaWriteEnable.  Doing surface draw calls with alpha set to 0 is a no-op and will never have any effect.
---@param enabled boolean true to enable, false to disable. No other arguments are required when disabling.
---@param srcBlend number The source color blend function Enums/BLEND. Determines how a rendered texture's final color should be calculated.
---@param destBlend number
---@param srcBlendAlpha? number The source alpha blend function Enums/BLEND. Determines how a rendered texture's final alpha should be calculated.
---@param destBlendAlpha? number
function render.OverrideBlendFunc(enabled,srcBlend,destBlend,srcBlendAlpha,destBlendAlpha) end

-- Overrides the write behaviour of all next rendering operations towards the color channel of the current render target.
---@param enable boolean Enable or disable the override.
---@param shouldWrite boolean If the previous argument is true, sets whether the next rendering operations should write to the color channel or not. Has no effect if the previous argument is false.
function render.OverrideColorWriteEnable(enable,shouldWrite) end

-- Overrides the write behaviour of all next rendering operations towards the depth buffer.
---@param enable boolean Enable or disable the override.
---@param shouldWrite boolean If the previous argument is true, sets whether the next rendering operations should write to the depth buffer or not. Has no effect if the previous argument is false.
function render.OverrideDepthEnable(enable,shouldWrite) end

function render.PerformFullScreenStencilOperation() end

-- Removes the current active clipping plane from the clip plane stack.
function render.PopCustomClipPlane() end

-- Pops the current texture magnification filter from the filter stack.  See render.PushFilterMag
function render.PopFilterMag() end

-- Pops the current texture minification filter from the filter stack.  See render.PushFilterMin
function render.PopFilterMin() end

-- Pops the current flashlight mode from the flashlight mode stack.
function render.PopFlashlightMode() end

-- Pops the last render target and viewport from the RT stack and sets them as the current render target and viewport.  This is should be called to restore the previous render target and viewport after a call to render.PushRenderTarget.
function render.PopRenderTarget() end

-- Pushes a new clipping plane of the clip plane stack and sets it as active.  A max of 2 clip planes are supported on Linux/POSIX, and 6 on Windows.
---@param normal Vector The normal of the clipping plane.
---@param distance number The distance of the plane from the world origin. You can use Vector:Dot between the normal and any point on the plane to find this.
function render.PushCustomClipPlane(normal,distance) end

-- Pushes a texture filter onto the magnification texture filter stack.  See also render.PushFilterMin and render.PopFilterMag.
---@param texFilterType number The texture filter type, see Enums/TEXFILTER
function render.PushFilterMag(texFilterType) end

-- Pushes a texture filter onto the minification texture filter stack.
---@param texFilterType number The texture filter type, see Enums/TEXFILTER
function render.PushFilterMin(texFilterType) end

-- Enables the flashlight projection for the upcoming rendering.  This will leave models lit under specific conditions.
---@param enable? boolean Whether the flashlight mode should be enabled or disabled.
function render.PushFlashlightMode(enable) end

-- Pushes the current render target and viewport to the RT stack then sets a new current render target and viewport. If the viewport is not specified, the dimensions of the render target are used instead.  This is similar to a call to render.SetRenderTarget and render.SetViewPort where the current render target and viewport have been saved beforehand, except the viewport isn't clipped to screen bounds.  See also render.PopRenderTarget.  If you want to render to the render target in 2d mode and it is not the same size as the screen, use cam.Start2D and cam.End2D. If the render target is bigger than the screen, rendering done with the surface library will be clipped to the screen bounds unless you call Global.DisableClipping
---@param texture ITexture The new render target to be used.
---@param x? number X origin of the viewport.
---@param y? number Y origin of the viewport.
---@param w? number Width of the viewport.
---@param h? number Height of the viewport
function render.PushRenderTarget(texture,x,y,w,h) end

-- Reads the color of the specified pixel from the RenderTarget sent by render.CapturePixels
---@param x number The x coordinate.
---@param y number The y coordinate.
---@return number
---@return number
---@return number
---@return number
function render.ReadPixel(x,y) end

-- This applies the changes made to map lighting using engine.LightStyle.
---@param DoStaticProps? boolean When true, this will also apply lighting changes to static props. This is really slow on large maps.
---@param UpdateStaticLighting? boolean Forces all props to update their static lighting. Can be slow.
function render.RedownloadAllLightmaps(DoStaticProps,UpdateStaticLighting) end

-- Renders the HUD on the screen.
---@param x number X position for the HUD draw origin.
---@param y number Y position for the HUD draw origin.
---@param w number Width of the HUD draw.
---@param h number Height of the HUD draw.
function render.RenderHUD(x,y,w,h) end

-- Renders the scene with the specified viewData to the current active render target.  Static props and LODs are rendered improperly due to incorrectly perceived distance.
---@param view? table The view data to be used in the rendering. See Structures/ViewData. Any missing value is assumed to be that of the current view. Similarly, you can make a normal render by simply not passing this table at all.
function render.RenderView(view) end

-- Resets the model lighting to the specified color.  Calls render.SetModelLighting for every direction with given color.
---@param r number The red part of the color, 0-1
---@param g number The green part of the color, 0-1
---@param b number The blue part of the color, 0-1
function render.ResetModelLighting(r,g,b) end

-- Resets the HDR tone multiplier to the specified value.  This will only work on HDR maps, and the value will automatically fade to what it was ( or whatever render.SetGoalToneMappingScale is ) if called only once.
---@param scale number The value which should be used as multiplier.
function render.ResetToneMappingScale(scale) end

-- Sets the ambient lighting for any upcoming render operation.
---@param r number The red part of the color, 0-1.
---@param g number The green part of the color, 0-1.
---@param b number The blue part of the color, 0-1.
function render.SetAmbientLight(r,g,b) end

-- Sets the alpha blending for every upcoming render operation.  This does not affect non-model `render.Draw*` functions.
---@param blending number Blending value from `0-1`.
function render.SetBlend(blending) end

-- Sets the current drawing material to "color".  The material is defined as: ```  "UnlitGeneric" { "$basetexture" "color/white" "$model" 		1 "$translucent" 	1 "$vertexalpha" 	1 "$vertexcolor" 	1 } ```
function render.SetColorMaterial() end

-- Sets the current drawing material to `color_ignorez`.  The material is defined as: ```  "UnlitGeneric" { "$basetexture" "color/white" "$model" 		1 "$translucent" 	1 "$vertexalpha" 	1 "$vertexcolor" 	1 "$ignorez"		1 } ```
function render.SetColorMaterialIgnoreZ() end

-- Sets the color modulation.
---@param r number The red channel multiplier normal ranging from 0-1.
---@param g number The green channel multiplier normal ranging from 0-1.
---@param b number The blue channel multiplier normal ranging from 0-1.
function render.SetColorModulation(r,g,b) end

-- If the fog mode is set to Enums/MATERIAL_FOG, the fog will only be rendered below the specified height.
---@param fogZ number The fog Z.
function render.SetFogZ(fogZ) end

-- Sets the goal HDR tone mapping scale.  Use this in a rendering/think hook as it is reset every frame.
---@param scale number The target scale.
function render.SetGoalToneMappingScale(scale) end

-- Sets lighting mode when rendering something.  **Do not forget to restore the default value** to avoid unexpected behavior, like the world and the HUD/UI being affected Reloading the map does not reset the value of this function.
---@param Mode number Lighting render mode  Possible values are: * 0 - Default * 1 - Total fullbright, similar to `mat_fullbright 1` but excluding some weapon view models * 2 - Increased brightness(?), models look fullbright
function render.SetLightingMode(Mode) end

-- Sets the lighting origin.  This does not work for prop_physics.
---@param lightingOrigin Vector The position from which the light should be "emitted".
function render.SetLightingOrigin(lightingOrigin) end

-- Sets the texture to be used as the lightmap in upcoming rendering operations. This is required when rendering meshes using a material with a lightmapped shader such as LightmappedGeneric.   
---@param tex ITexture The texture to be used as the lightmap.
function render.SetLightmapTexture(tex) end

-- Sets up the local lighting for any upcoming render operation. Up to 4 local lights can be defined, with one of three different types (point, directional, spot).  Disables all local lights if called with no arguments.
---@param lights? table A table containing up to 4 tables for each light source that should be set up. Each of these tables should contain the properties of its associated light source, see Structures/LocalLight.
function render.SetLocalModelLights(lights) end

-- Sets the material to be used in any upcoming render operation using the render.  Not to be confused with surface.SetMaterial.
---@param mat IMaterial The material to be used.
function render.SetMaterial(mat) end

-- Sets up the ambient lighting for any upcoming render operation. Ambient lighting can be seen as a cube enclosing the object to be drawn, each of its faces representing a directional light source that shines towards the object. Thus, there is a total of six different light sources that can be configured separately.  Light color components are not restricted to a specific range (i.e. 0-255), instead, higher values will result in a brighter light.
---@param lightDirection number The light source to edit, see Enums/BOX.
---@param red number The red component of the light color.
---@param green number The green component of the light color.
---@param blue number The blue component of the light color.
function render.SetModelLighting(lightDirection,red,green,blue) end

-- Sets the render target to the specified rt.
---@param texture ITexture The new render target to be used.
function render.SetRenderTarget(texture) end

-- Sets the render target with the specified index to the specified rt.
---@param rtIndex number The index of the rt to set.
---@param texture ITexture The new render target to be used.
function render.SetRenderTargetEx(rtIndex,texture) end

-- Sets a scissoring rect which limits the drawing area.
---@param startX number X start coordinate of the scissor rect.
---@param startY number Y start coordinate of the scissor rect.
---@param endX number X end coordinate of the scissor rect.
---@param endY number Y end coordinate of the scissor rect.
---@param enable boolean Enable or disable the scissor rect.
function render.SetScissorRect(startX,startY,endX,endY,enable) end

-- Sets the shadow color.
---@param red number The red channel of the shadow color.
---@param green number The green channel of the shadow color.
---@param blue number The blue channel of the shadow color.
function render.SetShadowColor(red,green,blue) end

-- Sets the shadow projection direction.
---@param shadowDirections Vector The new shadow direction.
function render.SetShadowDirection(shadowDirections) end

-- Sets the maximum shadow projection range.
---@param shadowDistance number The new maximum shadow distance.
function render.SetShadowDistance(shadowDistance) end

-- Sets whether any future render operations will ignore shadow drawing.
---@param newState boolean
function render.SetShadowsDisabled(newState) end

-- Sets the compare function of the stencil.  Pixels which fail the stencil comparison function are not written to the render target. The operation to be performed on the stencil buffer values for these pixels can be set using render.SetStencilFailOperation.  Pixels which pass the stencil comparison function are written to the render target unless they fail the depth buffer test (where applicable). The operation to perform on the stencil buffer values for these pixels can be set using render.SetStencilPassOperation and render.SetStencilZFailOperation.
---@param compareFunction number Compare function, see Enums/STENCILCOMPARISONFUNCTION, and Enums/STENCIL for short.
function render.SetStencilCompareFunction(compareFunction) end

-- Sets whether stencil tests are carried out for each rendered pixel.  Only pixels passing the stencil test are written to the render target.
---@param newState boolean The new state.
function render.SetStencilEnable(newState) end

-- Sets the operation to be performed on the stencil buffer values if the compare function was not successful. Note that this takes place **before** depth testing.
---@param failOperation number Fail operation function, see Enums/STENCILOPERATION.
function render.SetStencilFailOperation(failOperation) end

-- Sets the operation to be performed on the stencil buffer values if the compare function was successful.
---@param passOperation number Pass operation function, see Enums/STENCILOPERATION.
function render.SetStencilPassOperation(passOperation) end

-- Sets the reference value which will be used for all stencil operations. This is an unsigned integer.
---@param referenceValue number Reference value.
function render.SetStencilReferenceValue(referenceValue) end

-- Sets the unsigned 8-bit test bitflag mask to be used for any stencil testing.
---@param mask number The mask bitflag.
function render.SetStencilTestMask(mask) end

-- Sets the unsigned 8-bit write bitflag mask to be used for any writes to the stencil buffer.
---@param mask number The mask bitflag.
function render.SetStencilWriteMask(mask) end

-- Sets the operation to be performed on the stencil buffer values if the stencil test is passed but the depth buffer test fails.
---@param zFailOperation number Z fail operation function, see Enums/STENCILOPERATION
function render.SetStencilZFailOperation(zFailOperation) end

---@param vec Vector
function render.SetToneMappingScaleLinear(vec) end

-- Changes the view port position and size. The values will be clamped to the game's screen resolution.  If you are looking to render something to a texture (render target), you should use render.PushRenderTarget.  This function will override values of Global.ScrW and Global.ScrH with the ones you set.
---@param x number X origin of the view port.
---@param y number Y origin of the view port.
---@param w number Width of the view port.
---@param h number Height of the view port.
function render.SetViewPort(x,y,w,h) end

-- Sets the internal parameter **INT_RENDERPARM_WRITE_DEPTH_TO_DESTALPHA**
---@param enable boolean
function render.SetWriteDepthToDestAlpha(enable) end

-- Swaps the frame buffers/cycles the frame. In other words, this updates the screen.  If you take a really long time during a single frame render, it is a good idea to use this and let the user know that the game isn't stuck.
function render.Spin() end

-- Start a new beam draw operation.  
---@param segmentCount number Amount of beam segments that are about to be drawn.
function render.StartBeam(segmentCount) end

-- Returns whether the player's hardware supports HDR. (High Dynamic Range) HDR can still be disabled by the `mat_hdr_level` console variable or just not be supported by the map.
---@return boolean
function render.SupportsHDR() end

-- Returns if the current settings and the system allow the usage of pixel shaders 1.4.
---@return boolean
function render.SupportsPixelShaders_1_4() end

-- Returns if the current settings and the system allow the usage of pixel shaders 2.0.
---@return boolean
function render.SupportsPixelShaders_2_0() end

-- Returns if the current settings and the system allow the usage of vertex shaders 2.0.
---@return boolean
function render.SupportsVertexShaders_2_0() end

-- Suppresses or enables any engine lighting for any upcoming render operation.  This does not affect IMeshes.
---@param suppressLighting boolean True to suppress false to enable.
function render.SuppressEngineLighting(suppressLighting) end

-- Enables HDR tone mapping which influences the brightness.
function render.TurnOnToneMapping() end

-- Updates the texture returned by render.GetFullScreenDepthTexture.  Silently fails if render.SupportsPixelShaders_2_0 returns false.
function render.UpdateFullScreenDepthTexture() end

-- Updates the power of two texture.
---@return ITexture
function render.UpdatePowerOfTwoTexture() end

-- Pretty much alias of render.UpdatePowerOfTwoTexture but does not return the texture.
function render.UpdateRefractTexture() end

-- Copies the entire screen to the screen effect texture, which can be acquired via render.GetScreenEffectTexture. This function is mainly intended to be used in GM:RenderScreenspaceEffects
function render.UpdateScreenEffectTexture() end

-- This function overrides all map materials for one frame.
---@param mat? IMaterial
function render.WorldMaterialOverride(mat) end



resource = {}
-- Adds the specified and all related files to the files the client should download.  For convenience, this function will automatically add any other files that are related to the selected one, and throw an error if it can't find them. For example, a `.vmt` file will automatically add the `.vtf` with the same name, and a `.mdl` file will automatically add all `.vvd`, `.ani`, `.dx80.vtx`, `.dx90.vtx`, `.sw.vtx`, `.phy` and `.jpg` files with the same name, with a separate error for each missing file.  If you do not want it to do this, use resource.AddSingleFile.  There's a 8192 downloadable file limit. If you need more, consider using Workshop addons - resource.AddWorkshop. You should also consider the fact that you have way too many downloads. This limit is shared among all resource.Add functions.  Running this function using a path relative to the main `garrysmod/` folder will not work for files in addons and gamemodes. Instead, the files must be added relative to their respective content folders. For example, a sound file from an addon would use the path "sound/[FILENAME_AND_EXTENSION]," despite the file being located in "addons/[ADDON_NAME]/sound/[FILENAME_AND_EXTENSION]"  The file must exist on the server or players will not download it!
---@param path string Virtual path of the file to be added, relative to `garrysmod/`. Do not add `.bz2` to the filepath. Do not put `gamemodes/*gamemodename*/content/` or `addons/*addonname*/` into the path.
function resource.AddFile(path) end

-- Adds the specified file to the files the client should download.  If you wish to add textures or models, consider using resource.AddFile to add all the files required for a texture/model.  There's a 8192 downloadable file limit.  If you need more than 8192, consider using Workshop addons - resource.AddWorkshop. You should also consider the fact that you have way too many downloads. This limit is shared among all resource.Add functions.  The file must exist on the server or players will not download it!
---@param path string Path of the file to be added, relative to garrysmod/
function resource.AddSingleFile(path) end

-- Adds a workshop addon for the client to download before entering the server.  Having the raw files from a workshop item does not count as having already downloaded it. So players who previously downloaded a map through Fast Download will have to re-download it if you use the workshop.  You should try to only add addons that have custom content ( models, sounds, etc ).  Gamemodes that are Gamemode_Creation#Gamemode_Text_File are automatically added to this list - so there's no need to add them.   The server's current map is also automatically added, if it is loaded from a workshop addon.  This will not "install" the addon on your server, see Workshop for Dedicated Servers for installing Steam Workshop addons onto your servers
---@param workshopid string The workshop id of the file. This cannot be a collection.
function resource.AddWorkshop(workshopid) end



saverestore = {}
-- Adds a restore/load hook for the Half-Life 2 save system.
---@param identifier string The unique identifier for this hook.
---@param callback function The function to be called when an engine save is being loaded. It has one argument:   IRestore save - The restore object to be used to read data from save file that is being loaded      You can also use those functions to read data:   saverestore.ReadVar   saverestore.ReadTable   saverestore.LoadEntity
function saverestore.AddRestoreHook(identifier,callback) end

-- Adds a save hook for the Half-Life 2 save system. You can this to carry data through level transitions in Half-Life 2.
---@param identifier string The unique identifier for this hook.
---@param callback function The function to be called when an engine save is being saved. It has one argument:   ISave save - The save object to be used to write data to the save file that is being saved      You can also use those functions to save data:   saverestore.WriteVar   saverestore.WriteTable   saverestore.SaveEntity
function saverestore.AddSaveHook(identifier,callback) end

-- Loads Entity:GetTable from the save game file that is being loaded and merges it with the given entitys Entity:GetTable.
---@param ent Entity The entity which will receive the loaded values from the save.
---@param save IRestore The restore object to read the Entity:GetTable from.
function saverestore.LoadEntity(ent,save) end

--   Called by engine when a save is being loaded.  This handles loading gamemode and calls all of the hooks added with saverestore.AddRestoreHook.
---@param save IRestore The restore object to read data from the save file with.
function saverestore.LoadGlobal(save) end

--   Called by the engine just before saverestore.LoadGlobal is.
function saverestore.PreRestore() end

--   Called by the engine just before saverestore.SaveGlobal is.
function saverestore.PreSave() end

-- Reads a table from the save game file that is being loaded.
---@param save IRestore The restore object to read the table from.
---@return table
function saverestore.ReadTable(save) end

-- Loads a variable from the save game file that is being loaded.  Variables will be read in the save order you have saved them.
---@param save IRestore The restore object to read variables from.
---@return any
function saverestore.ReadVar(save) end

-- Saves entitys Entity:GetTable to the save game file that is being saved.
---@param ent Entity The entity to save Entity:GetTable of.
---@param save ISave The save object to save Entity:GetTable to.
function saverestore.SaveEntity(ent,save) end

--   Called by engine when a save is being saved.  This handles saving gamemode and calls all of the hooks added with saverestore.AddSaveHook.
---@param save ISave The save object to write data into the save file.
function saverestore.SaveGlobal(save) end

-- Returns how many writable keys are in the given table.
---@param table table The table to test.
---@return number
function saverestore.WritableKeysInTable(table) end

-- Write a table to a save game file that is being saved.
---@param table table The table to write
---@param save ISave The save object to write the table to.
function saverestore.WriteTable(table,save) end

-- Writes a variable to the save game file that is being saved.
---@param value any The value to save.  It can be one of the following types: number, boolean, string, Entity, Angle, Vector or table.
---@param save ISave The save object to write the variable to.
function saverestore.WriteVar(value,save) end



scripted_ents = {}
-- Defines an alias string that can be used to refer to another classname
---@param alias string A new string which can be used to refer to another classname
---@param classname string The classname the alias should refer to
function scripted_ents.Alias(alias,classname) end

-- Returns a copy of the ENT table for a class, including functions defined by the base class
---@param classname string The classname of the ENT table to return, can be an alias
---@return table
function scripted_ents.Get(classname) end

-- Returns a copy of the list of all ENT tables registered
---@return table
function scripted_ents.GetList() end

-- Retrieves a member of entity's table.
---@param class string Entity's class name
---@param name string Name of member to retrieve
---@return any
function scripted_ents.GetMember(class,name) end

-- Returns a list of all ENT tables which contain ENT.Spawnable
---@return table
function scripted_ents.GetSpawnable() end

-- Returns the actual ENT table for a class. Modifying functions/variables in this table will change newly spawned entities
---@param classname string The classname of the ENT table to return
---@return table
function scripted_ents.GetStored(classname) end

-- Returns the 'type' of a class, this will one of the following: 'anim', 'ai', 'brush', 'point'.
---@param classname string The classname to check
---@return string
function scripted_ents.GetType(classname) end

-- Checks if name is based on base
---@param name string Entity's class name to be checked
---@param base string Base class name to be checked
---@return boolean
function scripted_ents.IsBasedOn(name,base) end

--   Called after all ENTS have been loaded and runs baseclass.Set on each one.  You can retrieve all the currently registered ENTS with scripted_ents.GetList.  This is not called after an ENT auto refresh, and thus the inherited baseclass functions retrieved with baseclass.Get will not be updated
function scripted_ents.OnLoaded() end

-- Registers an ENT table with a classname. Reregistering an existing classname will automatically update the functions of all existing entities of that class.  Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied.
---@param ENT table The ENT table to register.
---@param classname string The classname to register.
function scripted_ents.Register(ENT,classname) end



search = {}
-- Adds a search result provider. For examples, see gamemodes/sandbox/gamemode/cl_search_models.lua
---@param provider function Provider function. It has one argument: string searchQuery You must return a list of tables structured like this: * string text - Text to "Copy to clipboard" * function func - Function to use/spawn the item * Panel icon - A panel to add to spawnmenu * table words - A table of words?
---@param id? string If provided, ensures that only one provider exists with the given ID at a time.
function search.AddProvider(provider,id) end

-- Retrieves search results.
---@param query string Search query
---@param types? string If set, only searches given provider type(s), instead of everything. For example `"tool"` will only search tools in Sandbox. Can be a table for multiple types.
---@param maxResults? number How many results to stop at
---@return table
function search.GetResults(query,types,maxResults) end



serverlist = {}
-- Adds current server the player is on to their favorites.
function serverlist.AddCurrentServerToFavorites() end

-- Adds the given server address to their favorites.
---@param address string Server Address. **IP:Port like "127.0.0.1:27015"**
function serverlist.AddServerToFavorites(address) end

-- Returns true if the current server address is in their favorites.
---@return boolean
function serverlist.IsCurrentServerFavorite() end

-- Returns true if the given server address is in their favorites.
---@param address string Server Address. **IP:Port like "127.0.0.1:27015"**
---@return boolean
function serverlist.IsServerFavorite(address) end

-- Queries a server for its information/ping.
---@param ip string The IP address of the server, including the port.
---@param callback function The function to be called if and when the request finishes. Function has the same arguments as the callback of serverlist.Query.
function serverlist.PingServer(ip,callback) end

-- Queries a server for its player list.
---@param ip string The IP address of the server, including the port.
---@param callback function The function to be called if and when the request finishes. Function has one argument, a table containing tables with player info.  Each table with player info has next fields:   number time - The amount of time the player is playing on the server, in seconds   string name - The player name   number score - The players score
function serverlist.PlayerList(ip,callback) end

-- Queries the master server for server list.
---@param data table The information about what kind of servers we want. See Structures/ServerQueryData.
function serverlist.Query(data) end

-- Removes the given server address from their favorites.
---@param address string Server Address. **IP:Port like "127.0.0.1:27015"**
function serverlist.RemoveServerFromFavorites(address) end



sound = {}
-- Creates a sound script. It can also override sounds, which seems to only work when set on the server.
---@param soundData table The sounds properties. See Structures/SoundData
function sound.Add(soundData) end

-- Overrides sounds defined inside of a txt file; typically used for adding map-specific sounds.
---@param filepath string Path to the script file to load.
function sound.AddSoundOverrides(filepath) end

-- Emits a sound hint to the game elements to react to, for example to repel or attract antlions.
---@param hint number The hint to emit. See Enums/SOUND
---@param pos Vector The position to emit the hint at
---@param volume number The volume or radius of the hint
---@param duration number The duration of the hint in seconds
---@param owner? Entity
function sound.EmitHint(hint,pos,volume,duration,owner) end

-- Creates a sound from a function.
---@param indentifier string An unique identified for the sound.  You cannot override already existing ones.
---@param samplerate number The sample rate of the sound. Must be `11025`, `22050` or `44100`.
---@param length number The length in seconds of the sound to generate.
---@param callback function A function which will be called to generate every sample on the sound. This function gets the current sample number passed as the first argument. The return value must be between `-1.0` and `1.0`. Other values will wrap back to the -1 to 1 range and basically clip. There are **65535** possible quantifiable values between -1 and 1.
function sound.Generate(indentifier,samplerate,length,callback) end

-- Returns the most dangerous/closest sound hint based on given location and types of sounds to sense.
---@param types number The types of sounds to choose from. See Enums/SOUND.
---@param pos Vector The position to sense sounds at.
---@return table
function sound.GetLoudestSoundHint(types,pos) end

-- Returns properties of the soundscript.
---@param name string The name of the sound script
---@return table
function sound.GetProperties(name) end

-- Returns a list of all registered sound scripts.
---@return table
function sound.GetTable() end

-- Plays a sound from the specified position in the world. If you want to play a sound without a position, such as a UI sound, use surface.PlaySound instead.
---@param Name string A path to the sound.  Does this function support sound scripts? This should either be a sound script name (sound.Add) or a file path relative to the `sound/` folder. (Make note that it's not sound**s**)
---@param Pos Vector Where the sound should play.
---@param Level number Sound level in decibels. 75 is normal. Ranges from 20 to 180, where 180 is super loud. This affects how far away the sound will be heard.
---@param Pitch number The sound pitch. Range is from 0 to 255. 100 is normal pitch.
---@param Volume number Output volume of the sound in range 0 to 1.
function sound.Play(Name,Pos,Level,Pitch,Volume) end

-- Plays a file from GMod directory. You can find a list of all error codes [here](http://www.un4seen.com/doc/#bass/BASS_ErrorGetCode.html)  For external file/stream playback, see sound.PlayURL.  This fails for looping .wav files in 3D mode.  This fails with unicode file names.
---@param path string The path to the file to play.  Unlike other sound functions and structures, the path is relative to `garrysmod/` instead of `garrysmod/sound/`
---@param flags string Flags for the sound. Can be one or more of following, separated by a space (" "): * 3d - Makes the sound 3D, so you can set its position * mono - Forces the sound to have only one channel * noplay - Forces the sound not to play as soon as this function is called * noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime.     If you don't want to use any of the above, you can just leave it as "".
---@param callback function Callback function that is called as soon as the the stream is loaded. It has next arguments: * IGModAudioChannel soundchannel - The sound channel. Will be nil if an error occured. * number errorID - ID of an error if an error has occured. Will be nil, otherwise. * string errorName - Name of an error if an error has occured. Will be nil, otherwise.
function sound.PlayFile(path,flags,callback) end

-- Allows you to play external sound files, as well as online radio streams. You can find a list of all error codes [here](http://www.un4seen.com/doc/#bass/BASS_ErrorGetCode.html)  For offline file playback, see sound.PlayFile.  Due to a bug with [BASS](http://www.un4seen.com/), AAC codec streams cannot be played in 3D mode.
---@param url string The URL of the sound to play
---@param flags string Flags for the sound. Can be one or more of following, separated by a space (" "): * 3d - Makes the sound 3D, so you can set its position * mono - Forces the sound to have only one channel * noplay - Forces the sound not to play as soon as this function is called * noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime.     If you don't want to use any of the above, you can just leave it as "".
---@param callback function Callback function that is called as soon as the the stream is loaded. It has next arguments:   IGModAudioChannel soundchannel - The sound channel   number errorID - ID of an error, if an error has occured   string errorName - Name of an error, if an error has occured
function sound.PlayURL(url,flags,callback) end



spawnmenu = {}
-- Activates a tool, opens context menu and brings up the tool gun.
---@param tool string Tool class/file name
---@param menu_only boolean Should we activate this tool in the menu only or also the toolgun? `true` = menu only,`false` = toolgun aswell
function spawnmenu.ActivateTool(tool,menu_only) end

-- Activates tools context menu in specified tool tab.
---@param tab number The tabID of the tab to open the context menu in
---@param cp Panel The control panel to open
function spawnmenu.ActivateToolPanel(tab,cp) end

-- Returns currently opened control panel of a tool, post process effect or some other menu in spawnmenu.
---@return Panel
function spawnmenu.ActiveControlPanel() end

-- Registers a new content type that is saveable into spawnlists. Created/called by spawnmenu.CreateContentIcon.
---@param name string An unique name of the content type.
---@param constructor function A function that is called whenever we need create a new panel for this content type.  It has two arguments:   Panel container - The container/parent of the new panel   table data - Data for the content type passed from spawnmenu.CreateContentIcon
function spawnmenu.AddContentType(name,constructor) end

-- Inserts a new tab into the CreationMenus table, which will be used by the creation menu to generate its tabs (Spawnlists, Weapons, Entities, etc.)
---@param name string What text will appear on the tab (I.E Spawnlists).
---@param func function The function called to generate the content of the tab.
---@param material? string Path to the material that will be used as an icon on the tab.
---@param order? number The order in which this tab should be shown relative to the other tabs on the creation menu.
---@param tooltip? string The tooltip to be shown for this tab.
function spawnmenu.AddCreationTab(name,func,material,order,tooltip) end

-- Used to add addon spawnlists to the spawnmenu tree. This function should be called within SANDBOX:PopulatePropMenu.  Addon spawnlists will not save to disk if edited.  You should never try to modify player customized spawnlists!
---@param classname string A unique classname of the list.
---@param name string The name of the category displayed to the player, e.g. `Comic Props`.
---@param contents? table A table of entries for the spawn menu. It must be numerically indexed.  Each member of the table is a sub-table containing a type member, and other members depending on the type.  New content types can be added via spawnmenu.AddContentType.  | string type | Description | Other members | | ------------- | ---------- | ----------------- | | "header" | a simple header for organization | string text - The text that the header will display | | "model" | spawns a model where the player is looking | string model - The path to the model file 	 number skin - The skin for the model to use (optional)  string body - The bodygroups for the model (optional)  number wide - The width of the spawnicon (optional)  number tall - The height of the spawnicon (optional) | | "entity" | spawns an entity where the player is looking(appears in the Entities tab by default) | string spawnname - The filename of the entity, for example "sent_ball"  string nicename - The name of the entity to display  string material - The icon to display, this should be set to "entities/.png" 	boolean admin - Whether the entity is only spawnable by admins (optional) | | "vehicle" | spawns a vehicle where the player is looking  (appears in the Vehicles tab by default) | string spawnname - The filename of the vehicle  string nicename - The name of the vehicle to display  string material - The icon to display  boolean admin - Whether the vehicle is only spawnable by admins (optional) | | "npc" | spawns an NPC where the player is looking  (appears in the NPCs tab by default) | string spawnname - The spawn name of the NPC 	string nicename - The name to display  string material - The icon to display  table weapon - A table of potential weapons (each a string) to give to the NPC. When spawned, one of these will be chosen randomly each time.  boolean admin - Whether the NPC is only spawnable by admins (optional) | | "weapon" | When clicked, gives the player a weapon;  When middle-clicked, spawns a weapon where the player is looking  (appears in the Weapons tab by default) |string spawnname - The spawn name of the weapon  string nicename - The name to display  string material - The icon to display  boolean admin - Whether the weapon is only spawnable by admins (optional) | 
---@param icon string The icon to use in the tree.
---@param id? number The unique ID number for the spawnlist category. Used to make sub categories. See "parentID" parameter below. If not set, it will be automatically set to ever increasing number, starting with 1000.
---@param parentID? number The unique ID of the parent category. This will make the created category a subcategory of category with given unique ID. `0` makes this a base category (such as `Builder`).
---@param needsApp string The needed game for this prop category, if one is needed. If the specified game is not mounted, the category isn't shown. This uses the shortcut name, e.g. `cstrike`, and not the Steam AppID.
function spawnmenu.AddPropCategory(classname,name,contents,icon,id,parentID,needsApp) end

-- Used to create a new category in the list inside of a spawnmenu ToolTab.  You must call this function from SANDBOX:AddToolMenuCategories for it to work properly.
---@param tab string The ToolTab name, as created with spawnmenu.AddToolTab.  You can also use the default ToolTab names "Main" and "Utilities".
---@param RealName string The identifier name
---@param PrintName string The displayed name
function spawnmenu.AddToolCategory(tab,RealName,PrintName) end

-- Adds an option to the right side of the spawnmenu
---@param tab string The spawnmenu tab to add into (for example "Utilities")
---@param category string The category to add into (for example "Admin")
---@param class string Unique identifier of option to add
---@param name string The nice name of item
---@param cmd string Command to execute when the item is selected
---@param config string Config name, used in older versions to load tool settings UI from a file. No longer works.  We advise against using this. It may be changed or removed in a future update.
---@param cpanel function A function to build the context panel. The function has one argument: * Panel pnl - A DForm that will be shown in the context menu
---@param table? table Allows to override the table that will be added to the tool list. Some of the fields will be overwritten by this function.
function spawnmenu.AddToolMenuOption(tab,category,class,name,cmd,config,cpanel,table) end

-- Adds a new tool tab to the right side of the spawnmenu via the SANDBOX:AddToolMenuTabs hook.  This function is a inferior duplicate of spawnmenu.GetToolMenu, just without its return value.
---@param name string The internal name of the tab. This is used for sorting.
---@param label? string The 'nice' name of the tab (Tip: language.Add)
---@param icon? string The filepath to the icon of the tab. Should be a .png
function spawnmenu.AddToolTab(name,label,icon) end

-- Clears all the tools from the different tool categories and the categories itself, if ran at the correct place.  Seems to only work when ran at initialization.
function spawnmenu.ClearToolMenus() end

-- Creates a new content icon.
---@param type string The type of the content icon.
---@param parent Panel The parent to add the content icon to.
---@param data table The data to send to the content icon in spawnmenu.AddContentType
---@return Panel
function spawnmenu.CreateContentIcon(type,parent,data) end

--   Calls spawnmenu.SaveToTextFiles.
---@param spawnlists table A table containing spawnlists.
function spawnmenu.DoSaveToTextFiles(spawnlists) end

-- Returns the function to create an vgui element for a specified content type
---@param contentType string
---@return function
function spawnmenu.GetContentType(contentType) end

-- Returns the list of Creation tabs. Creation tabs are added via spawnmenu.AddCreationTab.
---@return table
function spawnmenu.GetCreationTabs() end

-- Similar to spawnmenu.GetPropTable, but only returns spawnlists created by addons via spawnmenu.AddPropCategory.  These spawnlists are shown in a separate menu in-game.
---@return table
function spawnmenu.GetCustomPropTable() end

-- Returns a table of all prop categories and their props in the spawnmenu.  Note that if the spawnmenu has not been populated, this will return an empty table.  This will not return spawnlists created by addons, see  spawnmenu.GetCustomPropTable for that.
---@return table
function spawnmenu.GetPropTable() end

-- Adds a new tool tab (or returns an existing one by name) to the right side of the spawnmenu via the SANDBOX:AddToolMenuTabs hook.
---@param name string The internal name of the tab. This is used for sorting.
---@param label? string The 'nice' name of the tab
---@param icon? string The filepath to the icon of the tab. Should be a .png
---@return table
function spawnmenu.GetToolMenu(name,label,icon) end

-- Gets a table of tools on the client.
---@return table
function spawnmenu.GetTools() end

--   Calls spawnmenu.PopulateFromTextFiles.
function spawnmenu.PopulateFromEngineTextFiles() end

-- Loads spawnlists from text files.
---@param callback function The function to call. Arguments are ( strFilename, strName, tabContents, icon, id, parentid, needsapp )
function spawnmenu.PopulateFromTextFiles(callback) end

--   Saves a table of spawnlists to files.
---@param spawnlists table A table containing spawnlists.
function spawnmenu.SaveToTextFiles(spawnlists) end

-- Sets currently active control panel to be returned by spawnmenu.ActiveControlPanel.
---@param pnl Panel The panel to set.
function spawnmenu.SetActiveControlPanel(pnl) end

-- Switches the creation tab (left side of the spawnmenu) on the spawnmenu to the given tab.
---@param id number The tab ID to open
function spawnmenu.SwitchCreationTab(id) end

-- Opens specified tool tab in spawnmenu.
---@param id number The tab ID to open
function spawnmenu.SwitchToolTab(id) end



sql = {}
-- Tells the engine a set of queries is coming. Will wait until sql.Commit is called to run them. This is most useful when you run more than 100+ queries. This is equivalent to : ``` sql.Query( "BEGIN;" ) ```
function sql.Begin() end

-- Tells the engine to execute a series of queries queued for execution, must be preceded by sql.Begin.  This is equivalent to `sql.Query( "COMMIT;" )`.
function sql.Commit() end

-- Returns true if the index with the specified name exists.
---@param indexName string The name of the index to check.
---@return boolean
function sql.IndexExists(indexName) end

-- Returns the last error from a SQLite query.
---@return string
function sql.LastError() end

-- Performs a query on the local SQLite database, returns a table as result set, nil if result is empty and false on error.
---@param query string The query to execute.
---@return table
function sql.Query(query) end

-- Performs the query like sql.Query, but returns the first row found.  Basically equivalent to : ``` sql.Query( query .. " LIMIT 1;" ) ```
---@param query string The input query.
---@param row? number The row number. Say we receive back 5 rows, putting 3 as this argument will give us row #3.
---@return table
function sql.QueryRow(query,row) end

-- Performs the query like sql.QueryRow, but returns the first value found.
---@param query string The input query.
---@return string
function sql.QueryValue(query) end

-- Escapes dangerous characters and symbols from user input used in an SQLite SQL Query.  this function is not meant to be used with external database engines such as `MySQL`. Escaping strings with inadequate functions is dangerous!
---@param string string The string to be escaped.
---@param bNoQuotes? boolean Set this as `true`, and the function will not wrap the input string in apostrophes.
---@return string
function sql.SQLStr(string,bNoQuotes) end

-- Returns true if the table with the specified name exists.
---@param tableName string The name of the table to check.
---@return boolean
function sql.TableExists(tableName) end



steamworks = {}
-- Refreshes clients addons.
function steamworks.ApplyAddons() end

-- Downloads a file from the supplied addon and saves it as a .cache file in garrysmod/cache folder.  This is mostly used to download the preview image of the addon, but the game seems to also use it to download replays and saves.  In case the retrieved file is an image and you need the IMaterial, use Global.AddonMaterial with the path supplied from the callback.
---@param workshopPreviewID string The Preview ID of workshop item.
---@param uncompress boolean Whether to uncompress the file or not, assuming it was compressed with LZMA. You will usually want to set this to true.
---@param resultCallback function The function to process retrieved data. The first and only argument is a string, containing path to the saved file.
function steamworks.Download(workshopPreviewID,uncompress,resultCallback) end

-- Downloads a Steam Workshop file by its ID and returns a path to it.
---@param workshopID string The ID of workshop item to download. **NOT** a file ID.
---@param resultCallback function The function to process retrieved data. Arguments passed are: * string path - Contains a path to the saved file, or nil if the download failed for any reason. * file_class file - A file object pointing to the downloaded .gma file. The file handle will be closed after the function exits.
function steamworks.DownloadUGC(workshopID,resultCallback) end

-- Retrieves info about supplied Steam Workshop addon.
---@param workshopItemID string The ID of Steam Workshop item.
---@param resultCallback function The function to process retrieved data, with the following arguments: * table data - The data about the item, if the request succeeded, nil otherwise. See Structures/UGCFileInfo.
function steamworks.FileInfo(workshopItemID,resultCallback) end

-- Retrieves a customized list of Steam Workshop addons.
---@param type string The type of items to retrieve. Possible values include: * popular (All invalid options will equal to this) * trending * latest * friends * followed - Items of people the player is following on Steam * friend_favs - Favorites of player's friends * favorite - Player's favorites
---@param tags table A table of tags to match.
---@param offset number How much of results to skip from first one. Mainly used for pages.
---@param numRetrieve number How much items to retrieve, up to 50 at a time.
---@param days number When getting Most Popular content from Steam, this determines a time period. ( 7 = most popular addons in last 7 days, 1 = most popular addons today, etc )
---@param userID string "0" to retrieve all addons, "1" to retrieve addons only published by you, or a valid SteamID64 of a user to get workshop items of.
---@param resultCallback function The function to process retrieved data. The first and only argument is a table, containing all the info, or nil in case of error
function steamworks.GetList(type,tags,offset,numRetrieve,days,userID,resultCallback) end

-- You should use the callback of steamworks.RequestPlayerInfo instead.  Retrieves players name by their 64bit SteamID.  You must call steamworks.RequestPlayerInfo a decent amount of time before calling this function.
---@param steamID64 string The 64bit Steam ID ( aka Community ID ) of the player
---@return string
function steamworks.GetPlayerName(steamID64) end

-- Returns whenever the client is subscribed to the specified Steam Workshop item.
---@param workshopItemID string The ID of the Steam Workshop item.
---@return boolean
function steamworks.IsSubscribed(workshopItemID) end

-- Opens the workshop website in the steam overlay browser.
function steamworks.OpenWorkshop() end

--  Publishes dupes, saves or demos to workshop.
---@param tags table The workshop tags to apply
---@param filename string Path to the file to upload
---@param image string Path to the image to use as icon
---@param name string Name of the Workshop submission
---@param desc string Description of the Workshop submission
function steamworks.Publish(tags,filename,image,name,desc) end

-- Requests information of the player with SteamID64 for later use with steamworks.GetPlayerName.
---@param steamID64 string The 64bit Steam ID of player.
---@param callback function A callback function with only 1 argument - string name.
function steamworks.RequestPlayerInfo(steamID64,callback) end

---@param workshopid string The Steam Workshop item id
---@return string
function steamworks.SetFileCompleted(workshopid) end

-- Sets whether you have played this addon or not. This will be shown to the user in the Steam Workshop itself: 
---@param workshopid string The Steam Workshop item ID
---@return string
function steamworks.SetFilePlayed(workshopid) end

-- Sets if an addon should be enabled or disabled. Call steamworks.ApplyAddons afterwards to update.
---@param workshopItemID string The ID of the Steam Workshop item we should enable/disable
---@param shouldMount boolean true to enable the item, false to disable.
function steamworks.SetShouldMountAddon(workshopItemID,shouldMount) end

-- Returns whenever the specified Steam Workshop addon will be mounted or not.
---@param workshopItemID string The ID of the Steam Workshop
---@return boolean
function steamworks.ShouldMountAddon(workshopItemID) end

--   Subscribes to the specified workshop addon. Call steamworks.ApplyAddons afterwards to update.
---@param workshopItemID string The ID of the Steam Workshop item we should subscribe to
function steamworks.Subscribe(workshopItemID) end

--  Unsubscribes to the specified workshop addon. Call steamworks.ApplyAddons afterwards to update.  This function should `never` be called without a user's consent and should not be called if the addon is currently in use (aka: the user is not in the main menu) as it may result in unexpected behaviour.
---@param workshopItemID string The ID of the Steam Workshop item we should unsubscribe from.
function steamworks.Unsubscribe(workshopItemID) end

-- Opens the workshop website for specified Steam Workshop item in the Steam overlay browser.
---@param workshopItemID string The ID of workshop item.
function steamworks.ViewFile(workshopItemID) end

--  Makes the user vote for the specified addon
---@param workshopItemID string The ID of workshop item.
---@param upOrDown boolean Sets if the user should vote up/down. True makes them upvote, false down
function steamworks.Vote(workshopItemID,upOrDown) end

-- Use data steamworks.FileInfo instead.  Retrieves vote info of supplied addon.
---@param workshopItemID string The ID of workshop item.
---@param resultCallback function The function to process retrieved data. The first and only argument is a table, containing all the info.
function steamworks.VoteInfo(workshopItemID,resultCallback) end



string = {}
-- Inserts commas for every third digit of a given number.
---@param value number The input number to commafy
---@param separator? string An optional string that will be used instead of the default comma.
---@return string
function string.Comma(value,separator) end

-- Returns whether or not the second passed string matches the end of the first.
---@param str string The string whose end is to be checked.
---@param endVal string The string to be matched with the end of the first.
---@return boolean
function string.EndsWith(str,endVal) end

-- Splits a string up wherever it finds the given separator.  This is an alias of string.Split and the reverse operation of string.Implode.
---@param separator string The string will be separated wherever this sequence is found.
---@param str string The string to split up.
---@param use_patterns boolean Set this to true if your separator is a Inputs.
---@return table
function string.Explode(separator,str,use_patterns) end

-- Returns the time as a formatted string or as a table if no format is given.
---@param float number The time in seconds to format.
---@param format? string An optional formatting to use. If no format it specified, a table will be returned instead.
---@return string
function string.FormattedTime(float,format) end

-- Creates a string from a Color variable.
---@param color table The color to put in the string.
---@return string
function string.FromColor(color) end

-- Use either string.sub(str, index, index) or str[index]. Returns char value from the specified index in the supplied string.
---@param str string The string that you will be searching with the supplied index.
---@param index number The index's value of the string to be returned.
---@return string
function string.GetChar(str,index) end

-- Returns extension of the file.
---@param file string String eg. file-path to get the file extensions from.
---@return string
function string.GetExtensionFromFilename(file) end

-- Returns file name and extension.
---@param pathString string The string eg. file-path to get the file-name from.
---@return string
function string.GetFileFromFilename(pathString) end

-- Returns the path only from a file's path.
---@param InputActionstring string String to get path from.
---@return string
function string.GetPathFromFilename(InputActionstring) end

-- You really should just use table.concat.  Joins the values of a table together to form a string.  This is the reverse of string.Explode and is functionally identical to table.concat, but with less features.
---@param separator string The separator to insert between each piece.
---@param pieces table The table of pieces to concatenate. The keys for these must be numeric and sequential.
---@return string
function string.Implode(separator,pieces) end

-- Interpolates a given string with the given table. This is useful for formatting localized strings.
---@param str string The string that should be interpolated.
---@param lookuptable table The table to search in.
---@return string
function string.Interpolate(str,lookuptable) end

-- Escapes special characters for JavaScript in a string, making the string safe for inclusion in to JavaScript strings.
---@param str string The string that should be escaped.
---@return string
function string.JavascriptSafe(str) end

-- Returns everything left of supplied place of that string.
---@param str string The string to extract from.
---@param num number Amount of chars relative to the beginning (starting from 1).
---@return string
function string.Left(str,num) end

-- Converts a digital filesize to human-readable text.
---@param bytes number The filesize in bytes.
---@return string
function string.NiceSize(bytes) end

-- Formats the supplied number (in seconds) to the highest possible time unit.
---@param num number The number to format, in seconds.
---@return string
function string.NiceTime(num) end

-- Escapes all special characters within a string, making the string safe for inclusion in a Lua pattern.
---@param str string The string to be sanitized
---@return string
function string.PatternSafe(str) end

-- Replaces all occurrences of the supplied second string.
---@param str string The string we are seeking to replace an occurrence(s).
---@param find string What we are seeking to replace.
---@param replace string What to replace find with.
---@return string
function string.Replace(str,find,replace) end

-- Returns the last n-th characters of the string.
---@param str string The string to extract from.
---@param num number Amount of chars relative to the end (starting from 1).
---@return string
function string.Right(str,num) end

-- Sets the character at the specific index of the string.
---@param InputString string The input string
---@param Index number The character index, 1 is the first from left.
---@param ReplacementChar string String to replace with.
---@return string
function string.SetChar(InputString,Index,ReplacementChar) end

-- Splits the string into a table of strings, separated by the second argument.  This is an alias of string.Explode.
---@param InputActionstring string String to split
---@param Separator string Character(s) to split with.
---@return table
function string.Split(InputActionstring,Separator) end

-- Returns whether or not the first string starts with the second.
---@param inputStr string String to check.
---@param start string String to check with.
---@return boolean
function string.StartsWith(inputStr,start) end

-- Use string.StartsWith.  Returns whether or not the first string starts with the second. This is a alias of string.StartsWith.
---@param inputStr string String to check.
---@param start string String to check with.
---@return boolean
function string.StartWith(inputStr,start) end

-- Removes the extension of a path.
---@param InputActionstring string The path to change.
---@return string
function string.StripExtension(InputActionstring) end

-- Fetches a Color type from a string.
---@param InputActionstring string The string to convert from.
---@return table
function string.ToColor(InputActionstring) end

-- Returns given time in "MM:SS" format.
---@param time number Time in seconds
---@return string
function string.ToMinutesSeconds(time) end

-- Returns given time in "MM:SS:MS" format.
---@param time number Time in seconds
---@return string
function string.ToMinutesSecondsMilliseconds(time) end

-- Splits the string into characters and creates a sequential table of characters.  As a result of the  encoding, non-ASCII characters will be split into more than one character in the output table. Each character value in the output table will always be 1 byte.
---@param str string The string you'll turn into a table.
---@return table
function string.ToTable(str) end

-- Removes leading and trailing matches of a string.
---@param InputActionstring string The string to trim.
---@param Char? string String to match - can be multiple characters. Matches spaces by default.
---@return string
function string.Trim(InputActionstring,Char) end

-- Removes leading spaces/characters from a string.
---@param str string String to trim
---@param char string Custom character to remove
---@return string
function string.TrimLeft(str,char) end

-- Removes trailing spaces/passed character from a string.
---@param str string String to remove from
---@param char string Custom character to remove, default is a space
---@return string
function string.TrimRight(str,char) end



surface = {}
-- Creates a new font.  To prevent the font from displaying incorrectly when using the `outline` setting, set `antialias` to false. This will ensure the text properly fills out the entire outline.  Be sure to check the Default_Fonts first! Those fonts can be used without using this function.  See Also: Finding the Font Name.  Due to the static nature of fonts, do **NOT** create the font more than once. You should only be creating them once, it is recommended to create them at the top of your script. Do not use this function within GM:HUDPaint or any other hook!  Define fonts that you will actually use, as fonts are very taxing on performance and will cause crashes! Do not create fonts for every size.
---@param fontName string The new font name.
---@param fontData FontCreationData The font properties. See the Structures/FontData.
function surface.CreateFont(fontName, fontData) end

-- Alias of Global.DisableClipping so use that instead.  Enables or disables the clipping used by the VGUI that limits the drawing operations to a panels bounds.  Identical to Global.DisableClipping. See also Panel:NoClipping.
---@param disable boolean True to disable, false to enable the clipping
function surface.DisableClipping(disable) end

-- Draws a hollow circle, made of lines. For a filled circle, see examples for surface.DrawPoly.  
---@param originX number The center x integer coordinate.
---@param originY number The center y integer coordinate.
---@param radius number The radius of the circle.
---@param r number The red value of the color to draw the circle with, or a Color.
---@param g number The green value of the color to draw the circle with. Unused if a Color was given.
---@param b number The blue value of the color to draw the circle with. Unused if a Color was given.
---@param a? number The alpha value of the color to draw the circle with. Unused if a Color was given.
function surface.DrawCircle(originX,originY,radius,r,g,b,a) end

-- Draws a line from one point to another.  
---@param startX number The start x float coordinate.
---@param startY number The start y float coordinate.
---@param endX number The end x float coordinate.
---@param endY number The end y float coordinate.
function surface.DrawLine(startX,startY,endX,endY) end

-- Draws a hollow box with a given border width.  
---@param x number The start x integer coordinate.
---@param y number The start y integer coordinate.
---@param w number The integer width.
---@param h number The integer height.
---@param thickness number The thickness of the outlined box border.
function surface.DrawOutlinedRect(x,y,w,h,thickness) end

-- Draws a textured polygon (secretly a triangle fan) with a maximum of 4096 vertices. Only works properly with convex polygons. You may try to render concave polygons, but there is no guarantee that things wont get messed up.  Unlike most surface library functions, non-integer coordinates are not rounded.  You must reset the drawing color and texture before calling the function to ensure consistent results. See examples below.  
---@param vertices table A table containing integer vertices. See the Structures/PolygonVertex.  **The vertices must be in clockwise order.**
function surface.DrawPoly(vertices) end

-- Draws a solid rectangle on the screen.  
---@param x number The X integer co-ordinate.
---@param y number The Y integer co-ordinate.
---@param width number The integer width of the rectangle.
---@param height number The integer height of the rectangle.
function surface.DrawRect(x,y,width,height) end

-- Draw the specified text on the screen, using the previously set position, font and color.  This function does not handle newlines properly This function sets new text position at the end of the previous drawn text length - this can be used to change text properties (such as font or color) without recalculating and resetting text position. See example #2 for example use of this behavior.  
---@param text string The text to be rendered.
---@param forceAdditive? boolean `true` to force text to render additive, `false` to force not additive, `nil` to use font's value.
function surface.DrawText(text,forceAdditive) end

-- Draw a textured rectangle with the given position and dimensions on the screen, using the current active texture set with surface.SetMaterial. It is also affected by surface.SetDrawColor.  See also render.SetMaterial and render.DrawScreenQuadEx.  See also surface.DrawTexturedRectUV.  
---@param x number The X integer co-ordinate.
---@param y number The Y integer co-ordinate.
---@param width number The integer width of the rectangle.
---@param height number The integer height of the rectangle.
function surface.DrawTexturedRect(x,y,width,height) end

-- Draw a textured rotated rectangle with the given position and dimensions and angle on the screen, using the current active texture.  
---@param x number The X integer co-ordinate, representing the center of the rectangle.
---@param y number The Y integer co-ordinate, representing the center of the rectangle.
---@param width number The integer width of the rectangle.
---@param height number The integer height of the rectangle.
---@param rotation number The rotation of the rectangle, in degrees.
function surface.DrawTexturedRectRotated(x,y,width,height,rotation) end

-- Draws a textured rectangle with a repeated or partial texture.  u and v refer to texture coordinates. * (u, v) = (0, 0) is the top left * (u, v) = (1, 0) is the top right * (u, v) = (1, 1) is the bottom right * (u, v) = (0, 1) is the bottom left  Using a start point of (1, 0) and an end point to (0, 1), you can draw an image flipped horizontally, same goes with other directions. Going above 1 will tile the texture. Negative values are allowed as well.  Here's a helper image:   If you are using a .png image, you need supply the "noclamp" flag as second parameter for Global.Material if you intend to use tiling.  If you find that surface.DrawTexturedRectUV is getting your texture coordinates (u0, v0), (u1, v1) wrong and you're rendering with a material created with Global.CreateMaterial, try adjusting them with the following code:  ``` local du = 0.5 / 32 -- half pixel anticorrection local dv = 0.5 / 32 -- half pixel anticorrection local u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv) local u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv) ```   **Explanation:** surface.DrawTexturedRectUV tries to correct the texture coordinates by half a pixel (something to do with sampling) and computes the correction using IMaterial::GetMappingWidth()/GetMappingHeight(). If the material was created without a $basetexture, then GetMappingWidth()/GetMappingHeight() uses the width and height of the error material (which is 32x32).    The UV offsets might require (sub-)pixel correction for accurate tiling results. 
---@param x number The X integer coordinate.
---@param y number The Y integer coordinate.
---@param width number The integer width of the rectangle.
---@param height number The integer height of the rectangle.
---@param startU number The U texture mapping of the rectangle origin.
---@param startV number The V texture mapping of the rectangle origin.
---@param endU number The U texture mapping of the rectangle end.
---@param endV number The V texture mapping of the rectangle end.
function surface.DrawTexturedRectUV(x,y,width,height,startU,startV,endU,endV) end

-- Returns the current alpha multiplier affecting drawing operations. This is set by surface.SetAlphaMultiplier or by the game engine in certain other cases.
---@return number
function surface.GetAlphaMultiplier() end

-- Returns the current color affecting draw operations.  The returned color will not have the color metatable.
---@return table
function surface.GetDrawColor() end

-- Gets the [HUD icon](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/hud_textures.txt) TextureID with the specified name.
---@param name string The name of the texture.
---@return number
function surface.GetHUDTexture(name) end

-- Returns the current color affecting text draw operations.  The returned color will not have the color metatable.
---@return table
function surface.GetTextColor() end

-- Returns the width and height (in pixels) of the given text, but only if the font has been set with surface.SetFont.
---@param text string The string to check the size of.
---@return number
---@return number
function surface.GetTextSize(text) end

-- Returns the texture id of the material with the given name/path, for use with surface.SetTexture.  Opposite version of this function is surface.GetTextureNameByID.  This function will not work with .png or .jpg images. For that, see Global.Material. You will probably want to use it regardless.
---@param name_path string Name or path of the texture.
---@return number
function surface.GetTextureID(name_path) end

-- Returns name/path of texture by ID. Opposite version of this function is surface.GetTextureID.
---@param id number ID of texture.
---@return string
function surface.GetTextureNameByID(id) end

-- Returns the size of the texture with the associated texture ID.  For `.png/.jpg` textures loaded with Global.Material you can use the `$realheight` and `$realwidth` material parameters (IMaterial:GetInt) to get the size of the image.
---@param textureID number The texture ID, returned by surface.GetTextureID.
---@return number
---@return number
function surface.GetTextureSize(textureID) end

-- Play a sound file directly on the client (such as UI sounds, etc).
---@param soundfile string The path to the sound file.   Currently does not work with sound scripts (sound.Add) This should either be a sound script name (sound.Add) or a file path relative to the `sound/` folder. (Make note that it's not sound**s**)
function surface.PlaySound(soundfile) end

-- You should use Global.ScrH instead. Returns the height of the current client's screen.
---@return number
function surface.ScreenHeight() end

-- You should use Global.ScrW instead. Returns the width of the current client's screen.
---@return number
function surface.ScreenWidth() end

-- Sets the alpha multiplier that will influence all upcoming drawing operations. See also render.SetBlend.
---@param multiplier number The multiplier ranging from 0 to 1.
function surface.SetAlphaMultiplier(multiplier) end

-- Set the color of any future shapes to be drawn, can be set by either using R, G, B, A as separate values or by a Color. Using a color structure is not recommended to be created procedurally. Providing a Color structure is slower than providing four numbers. You may use Color:Unpack for this. The alpha value may not work properly if you're using a material without `$vertexalpha`. Due to post processing and gamma correction the color you set with this function may appear differently when rendered. This problem does not occur on materials drawn with surface.DrawTexturedRect.
---@param r number The red value of color, or a Color.
---@param g number The green value of color. Unused if a Color was given.
---@param b number The blue value of color. Unused if a Color was given.
---@param a? number The alpha value of color. Unused if a Color was given.
function surface.SetDrawColor(r,g,b,a) end

-- Set the current font to be used for text operations later.  The fonts must first be created with surface.CreateFont or be one of the Default Fonts.
---@param fontName string The name of the font to use.
function surface.SetFont(fontName) end

-- Sets the material to be used in all upcoming draw operations using the surface library.  Not to be confused with render.SetMaterial.  If you need to unset the texture, use the draw.NoTexture convenience function.  Global.Material function calls are expensive to be done inside this function or inside rendering context, you should be caching the results of Global.Material calls When using render.PushRenderTarget or render.SetRenderTarget, `material` should have the `$ignorez` flag set to make it visible. If the material is not used in 3D rendering, it is probably safe to add it with this code: ```lua material:SetInt( "$flags", bit.bor( material:GetInt( "$flags" ), 32768 ) ) ``` 
---@param material IMaterial The material to be used.
function surface.SetMaterial(material) end

-- Set the color of any future text to be drawn, can be set by either using R, G, B, A as separate numbers or by a Color.  Using a color structure is not recommended to be created procedurally. Providing a Color structure is slower than providing four numbers. You may use Color:Unpack for this.
---@param r number The red value of color, or a Color.
---@param g number The green value of color
---@param b number The blue value of color
---@param a? number The alpha value of color
function surface.SetTextColor(r,g,b,a) end

-- Set the top-left position to draw any future text at.
---@param x number The X integer co-ordinate.
---@param y number The Y integer co-ordinate.
function surface.SetTextPos(x,y) end

-- Sets the texture to be used in all upcoming draw operations using the surface library.  See surface.SetMaterial for an IMaterial alternative.  It's probably best to use the alternative mentioned above.
---@param textureID number The ID of the texture to draw with returned by surface.GetTextureID.
function surface.SetTexture(textureID) end



system = {}
-- Returns the total uptime of the current application as reported by Steam.  This will return a similar value to Global.SysTime.  This function does not work on Dedicated Servers and will instead return no value.
---@return number
function system.AppTime() end

-- Returns the current battery power.
---@return number
function system.BatteryPower() end

-- Flashes the window, turning the border to white briefly
function system.FlashWindow() end

-- Returns the country code of this computer, determined by the localisation settings of the OS.  This function does not work on Dedicated Servers and will instead return no value.
---@return string
function system.GetCountry() end

-- Returns whether or not the game window has focus.  This function does not work on dedicated servers and will instead return no value.
---@return boolean
function system.HasFocus() end

-- Returns whether the current OS is Linux.
---@return boolean
function system.IsLinux() end

-- Returns whether the current OS is OSX.
---@return boolean
function system.IsOSX() end

-- Returns whether the game is being run in a window or in fullscreen (you can change this by opening the menu, clicking 'Options', then clicking the 'Video' tab, and changing the Display Mode using the dropdown menu):  
---@return boolean
function system.IsWindowed() end

-- Returns whether the current OS is Windows.
---@return boolean
function system.IsWindows() end

-- Returns the synchronized Steam time. This is the number of seconds since the [Unix epoch](http://en.wikipedia.org/wiki/Unix_time).  This function does not work on Dedicated Servers and will instead return no value.
---@return number
function system.SteamTime() end

-- Returns the amount of seconds since the Steam user last moved their mouse.  This is a direct binding to ISteamUtils-&gt;GetSecondsSinceComputerActive, and is most likely related to Steam's automatic "Away" online status.  This function does not work on Dedicated Servers and will instead return no value.
---@return number
function system.UpTime() end



table = {}
-- Adds the contents from one table into another. The target table will be modified.  See also table.insert, table.Inherit and table.Merge.
---@param target table The table to insert the new values into.
---@param source table The table to retrieve the values from.
---@return table
function table.Add(target,source) end

-- Changes all keys to sequential integers. This creates a new table object and does not affect the original.
---@param table table The original table to modify.
---@param saveKeys? boolean Save the keys within each member table. This will insert a new field `__key` into each value, and should not be used if the table contains non-table values.
---@return table
function table.ClearKeys(table,saveKeys) end

-- Collapses a table with keyvalue structure
---@param input table Input table
---@return table
function table.CollapseKeyValue(input) end

-- Creates a deep copy and returns that copy.  This function does NOT copy userdata, such as Vectors and Angles!
---@param originalTable table The table to be copied.
---@return table
function table.Copy(originalTable) end

-- Empties the target table, and merges all values from the source table into it.
---@param source table The table to copy from.
---@param target table The table to write to.
function table.CopyFromTo(source,target) end

-- Counts the amount of keys in a table. This should only be used when a table is not numerically and sequentially indexed. For those tables, consider the length (**#**) operator.  If you only want to test if the table is empty or not, use table.IsEmpty instead as it is a lot faster.
---@param tbl table The table to count the keys of.
---@return number
function table.Count(tbl) end

-- Converts a table that has been sanitised with table.Sanitise back to its original form
---@param tbl table Table to be de-sanitised
---@return table
function table.DeSanitise(tbl) end

-- Removes all values from a table.
---@param tbl table The table to empty.
function table.Empty(tbl) end

-- Instead, iterate the table using ipairs or increment from the previous index using Global.next. Non-numerically indexed tables are not ordered. Returns the value positioned after the supplied value in a table. If it isn't found then the first element in the table is returned
---@param tbl table Table to search
---@param value any Value to return element after
---@return any
function table.FindNext(tbl,value) end

-- Instead, iterate your table with ipairs, storing the previous value and checking for the target. Non-numerically indexed tables are not ordered. Returns the value positioned before the supplied value in a table. If it isn't found then the last element in the table is returned
---@param tbl table Table to search
---@param value any Value to return element before
---@return any
function table.FindPrev(tbl,value) end

-- Inserts a value in to the given table even if the table is non-existent
---@param tab? table Table to insert value in to
---@param value any Value to insert
---@return table
function table.ForceInsert(tab,value) end

-- Instead, expect the first key to be 1.  Non-numerically indexed tables are not ordered and do not have a first key. Returns the first key found in the given table
---@param tab table Table to retrieve key from
---@return any
function table.GetFirstKey(tab) end

-- Instead, index the table with a key of 1.  Non-numerically indexed tables are not ordered and do not have a first key. Returns the first value found in the given table
---@param tab table Table to retrieve value from
---@return any
function table.GetFirstValue(tab) end

-- Returns all keys of a table.
---@param tabl table The table to get keys of
---@return table
function table.GetKeys(tabl) end

-- Instead, use the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key. Returns the last key found in the given table
---@param tab table Table to retrieve key from
---@return any
function table.GetLastKey(tab) end

-- Instead, index the table with the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key. Returns the last value found in the given table
---@param tab table Table to retrieve value from
---@return any
function table.GetLastValue(tab) end

-- Returns a key of the supplied table with the highest number value.
---@param inputTable table The table to search in.
---@return any
function table.GetWinningKey(inputTable) end

-- Checks if a table has a value. This function is **very inefficient for large tables** (O(n)) and should probably not be called in things that run each frame. Instead, consider a table structure such as example 2 below. Also see: Tables: Bad Habits For optimization, functions that look for a value by sorting the table should never be needed if you work on a table that you built yourself.
---@param tbl table Table to check
---@param value any Value to search for
---@return boolean
function table.HasValue(tbl,value) end

-- Copies any missing data from base to target, and sets the target's `BaseClass` member to the base table's pointer.  See table.Merge, which overrides existing values and doesn't add a BaseClass member.   See also table.Add, which simply adds values of one table to another.  Sub-tables aren't inherited. The target's table value will take priority.
---@param target table Table to copy data to
---@param base table Table to copy data from
---@return table
function table.Inherit(target,base) end

-- Returns whether or not the given table is empty.  This works on both sequential and non-sequential tables, and is a lot faster to use than `table.Count(tbl) == 0`. For checking if a table is not empty, try using `next(tbl) ~= nil`.
---@param tab table Table to check.
---@return boolean
function table.IsEmpty(tab) end

-- Returns whether or not the table's keys are sequential
---@param tab table Table to check
---@return boolean
function table.IsSequential(tab) end

-- Returns the first key found to be containing the supplied value
---@param tab table Table to search
---@param value any Value to search for
---@return any
function table.KeyFromValue(tab,value) end

-- Returns a table of keys containing the supplied value
---@param tab table Table to search
---@param value any Value to search for
---@return table
function table.KeysFromValue(tab,value) end

-- Returns a copy of the input table with all string keys converted to be lowercase recursively
---@param tbl table Table to convert
---@return table
function table.LowerKeyNames(tbl) end

-- Returns an array of values of given with given key from each table of given table.  See also table.KeysFromValue.
---@param inputTable table The table to search in.
---@param keyName any The key to lookup.
---@return table
function table.MemberValuesFromKey(inputTable,keyName) end

-- Merges the contents of the second table with the content in the first one. The destination table will be modified.  See table.Inherit, which doesn't override existing values.   See also table.Add, which simply adds values of one table to another. This function will cause a stack overflow under certain circumstances.
---@param destination table The table you want the source table to merge with
---@param source table The table you want to merge with the destination table
---@return table
function table.Merge(destination,source) end

-- Returns a random value from the supplied table.  This function iterates over the given table **twice**, therefore with sequential tables you should instead use following:  ``` mytable[ math.random( #mytable ) ] ``` 
---@param haystack table The table to choose from.
---@return any
---@return any
function table.Random(haystack) end

-- Removes the first instance of a given value from the specified table with table.remove, then returns the key that the value was found at.  Avoid usage of this function. It does not remove all instances of given value in the table, only the first found, and it does not work with non sequential tables!
---@param tbl table The table that will be searched.
---@param val any The value to find within the table.
---@return any
function table.RemoveByValue(tbl,val) end

-- Returns a reversed copy of a sequential table. Any non-sequential and non-numeric keyvalue pairs will not be copied.
---@param tbl table Table to reverse.
---@return table
function table.Reverse(tbl) end

-- Converts Vectors, Angles and booleans to be able to be converted to and from key-values via util.TableToKeyValues.  table.DeSanitise performs the opposite transformation.
---@param tab table Table to sanitise
---@return table
function table.Sanitise(tab) end

-- Performs an inline [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle) on the table in `O(n)` time
---@param target table The table to shuffle.
function table.Shuffle(target) end

-- Returns a list of keys sorted based on values of those keys.  For normal sorting see table.sort.
---@param tab table Table to sort. All values of this table must be of same type.
---@param descending? boolean Should the order be descending?
---@return table
function table.SortByKey(tab,descending) end

-- Sorts a table by a named member.
---@param tab table Table to sort.
---@param memberKey any The key used to identify the member.
---@param ascending? boolean Whether or not the order should be ascending.
function table.SortByMember(tab,memberKey,ascending) end

-- Sorts a table in reverse order from table.sort. This function modifies the table you give to it. Like table.sort, it does not return anything.
---@param tbl table The table to sort in descending order.
function table.SortDesc(tbl) end

-- Converts a table into a string
---@param tbl table The table to iterate over.
---@param displayName? string Optional. A name for the table.
---@param niceFormatting boolean Adds new lines and tabs to the string.
---@return string
function table.ToString(tbl,displayName,niceFormatting) end



team = {}
-- Increases the score of the given team
---@param index number Index of the team
---@param increment number Amount to increase the team's score by
function team.AddScore(index,increment) end

-- Returns the team index of the team with the least players. Falls back to TEAM_UNASSIGNED
---@return number
function team.BestAutoJoinTeam() end

-- Returns a table consisting of information on every defined team
---@return table
function team.GetAllTeams() end

-- Returns the selectable classes for the given team. This can be added to with team.SetClass
---@param index number Index of the team
---@return table
function team.GetClass(index) end

-- Returns the team's color.
---@param teamIndex number The team index.
---@return table
function team.GetColor(teamIndex) end

-- Returns the name of the team.
---@param teamIndex number The team index.
---@return string
function team.GetName(teamIndex) end

-- Returns a table with all player of the specified team.
---@param teamIndex number The team index.
---@return table
function team.GetPlayers(teamIndex) end

-- Returns the score of the team.
---@param teamIndex number The team index.
---@return number
function team.GetScore(teamIndex) end

-- Returns a table of valid spawnpoint classes the team can use. These are set with team.SetSpawnPoint.
---@param index number Index of the team
---@return table
function team.GetSpawnPoint(index) end

-- Returns a table of valid spawnpoint entities the team can use. These are set with  team.SetSpawnPoint.
---@param index number Index of the team
---@return table
function team.GetSpawnPoints(index) end

-- Returns if a team is joinable or not. This is set in team.SetUp.
---@param index number The index of the team.
---@return boolean
function team.Joinable(index) end

-- Returns the amount of players in a team.
---@param teamIndex number The team index.
---@return number
function team.NumPlayers(teamIndex) end

-- Sets valid classes for use by a team. Classes can be created using player_manager.RegisterClass
---@param index number Index of the team
---@param classes any A class ID or table of class IDs
function team.SetClass(index,classes) end

-- Sets the team's color.
---@param teamIndex number The team index.
---@param color table The team's new color as a Color.
function team.SetColor(teamIndex,color) end

-- Sets the score of the given team
---@param index number Index of the team
---@param score number The team's new score
function team.SetScore(index,score) end

-- Sets valid spawnpoint classes for use by a team.  GM.TeamBased must be set to true for this to work
---@param index number Index of the team
---@param classes any A spawnpoint classname or table of spawnpoint classnames
function team.SetSpawnPoint(index,classes) end

-- Creates a new team.
---@param teamIndex number The team index.
---@param teamName string The team name.
---@param teamColor table The team color. Uses the Color.
---@param isJoinable? boolean Whether the team is joinable or not.
function team.SetUp(teamIndex,teamName,teamColor,isJoinable) end

-- Returns the total number of deaths of all players in the team.
---@param index number The team index.
---@return number
function team.TotalDeaths(index) end

-- Get's the total frags in a team.
---@param Entity_or_number Entity Entity or number.
---@return number
function team.TotalFrags(Entity_or_number) end

-- Returns true if the given team index is valid
---@param index number Index of the team
---@return boolean
function team.Valid(index) end



timer = {}
-- Adjusts the timer if the timer with the given identifier exists.
---@param identifier any Identifier of the timer to adjust.
---@param delay number The delay interval in seconds. **Must be specified.**
---@param repetitions number Repetitions. Use `0` for infinite or `nil` to keep previous value.
---@param func function The new function. Use `nil` to keep previous value.
---@return boolean
function timer.Adjust(identifier,delay,repetitions,func) end

-- If you want to check if whether or not a timer exists, use timer.Exists. This function does nothing.
function timer.Check() end

-- Creates a new timer that will repeat its function given amount of times. This function also requires the timer to be named, which allows you to control it after it was created via the timer.  For a simple one-time timer with no identifiers, see timer.Simple.  Timers use Global.CurTime internally. Due to this, they won't advance while the client is timing out from the server or on an empty dedicated server due to hibernation. (unless `sv_hibernate_think` is set to `1`). This is not applicable when the delay is equal to `0`.
---@param identifier string Identifier of the timer to create. Must be unique. If a timer already exists with the same identifier, that timer will be updated to the new settings and reset.
---@param delay number The delay interval in seconds. If the delay is too small, the timer will fire on the next frame/tick.
---@param repetitions number The number of times to repeat the timer. Enter `0` for infinite repetitions.
---@param func function Function called when timer has finished the countdown.
function timer.Create(identifier,delay,repetitions,func) end

-- You should be using timer.Remove instead. Stops and destroys the given timer. Alias of timer.Remove.
---@param identifier string Identifier of the timer to destroy.
function timer.Destroy(identifier) end

-- Returns whenever the given timer exists or not.
---@param identifier string Identifier of the timer.
---@return boolean
function timer.Exists(identifier) end

-- Pauses the given timer.
---@param identifier any Identifier of the timer.
---@return boolean
function timer.Pause(identifier) end

-- Stops and removes a timer created by timer.Create. The timers are removed in the next frame! Keep this in mind when storing identifiers in variables.
---@param identifier string Identifier of the timer to remove.
function timer.Remove(identifier) end

-- Returns amount of repetitions/executions left before the timer destroys itself.
---@param identifier any Identifier of the timer.
---@return number
function timer.RepsLeft(identifier) end

-- Creates a simple timer that runs the given function after a specified delay.  For a more advanced version that you can control after creation, see timer.Create.  Timers use Global.CurTime internally. Due to this, they won't advance while the client is timing out from the server or on an empty dedicated server due to hibernation. (unless `sv_hibernate_think` is set to `1`). This is not applicable when the delay is equal to `0`.
---@param delay number How long until the function should be ran (in seconds). Use `0` to have the function run in the next GM:Think.
---@param func function The function to run after the specified delay.
function timer.Simple(delay,func) end

-- Restarts the given timer.  Timers use Global.CurTime for timing. Timers won't advance while the client is timing out from the server.
---@param identifier any Identifier of the timer.
---@return boolean
function timer.Start(identifier) end

-- Stops the given timer and rewinds it.
---@param identifier any Identifier of the timer.
---@return boolean
function timer.Stop(identifier) end

-- Returns amount of time left (in seconds) before the timer executes its function.  If the timer is paused, the amount will be negative.
---@param identifier any Identifier of the timer.
---@return number
function timer.TimeLeft(identifier) end

-- Runs either timer.Pause or timer.UnPause based on the timer's current status.
---@param identifier any Identifier of the timer.
---@return boolean
function timer.Toggle(identifier) end

-- Unpauses the timer.
---@param identifier any Identifier of the timer.
---@return boolean
function timer.UnPause(identifier) end



umsg = {}
-- Writes an angle to the usermessage.
---@param angle Angle The angle to be sent.
function umsg.Angle(angle) end

-- Writes a bool to the usermessage.
---@param bool boolean The bool to be sent.
function umsg.Bool(bool) end

-- Writes a signed char to the usermessage.
---@param char number The char to be sent.
function umsg.Char(char) end

-- Dispatches the usermessage to the client(s).
function umsg.End() end

-- Writes an entity object to the usermessage.
---@param entity Entity The entity to be sent.
function umsg.Entity(entity) end

-- Writes a float to the usermessage.
---@param float number The float to be sent.
function umsg.Float(float) end

-- Writes a signed int (32 bit) to the usermessage.
---@param int number The int to be sent.
function umsg.Long(int) end

-- Inferior version of util.AddNetworkString  The string specified will be networked to the client and receive a identifying number, which will be sent instead of the string to optimize networking.
---@param string string The string to be pooled.
function umsg.PoolString(string) end

-- Writes a signed short (16 bit) to the usermessage.
---@param short number The short to be sent.
function umsg.Short(short) end

-- You should be using net instead  Starts a new usermessage.  Usermessages have a limit of only 256 bytes!
---@param name string The name of the message to be sent.
---@param filter Player If passed a player object, it will only be sent to the player, if passed a CRecipientFilter of players, it will be sent to all specified players, if passed nil (or another invalid value), the message will be sent to all players.
function umsg.Start(name,filter) end

-- Writes a null terminated string to the usermessage.
---@param string string The string to be sent.
function umsg.String(string) end

-- Writes a Vector to the usermessage.
---@param vector Vector The vector to be sent.
function umsg.Vector(vector) end

-- Writes a vector normal to the usermessage.
---@param normal Vector The vector normal to be sent.
function umsg.VectorNormal(normal) end



undo = {}
-- Adds an entity to the current undo block
---@param ent Entity The entity to add
function undo.AddEntity(ent) end

-- Adds a function to call when the current undo block is undone. Note that if an undo has a function, the player will always be notified when this undo is performed, even if the entity it is meant to undo no longer exists.
---@param func function The function to call. First argument will be the Structures/Undo, all subsequent arguments will be what was passed after this function in the argument below.  Returning `false` will mark execution of this function as "failed", meaning that the undo might be skipped if no other entities are removed by it. This is useful when for example an entity you want to access is removed therefore there's nothing to do.
---@param ... any Arguments to pass to the function (after the undo info table)
function undo.AddFunction(func,...) end

-- Begins a new undo entry
---@param name string Name of the undo message to show to players
function undo.Create(name) end

-- Processes an undo block (in table form). This is used internally by the undo manager when a player presses Z.  You should use `gm_undo` or `gm_undonum *num*` console commands instead of calling this function directly.
---@param tab table The undo block to process as an Structures/Undo
---@return number
function undo.Do_Undo(tab) end

-- Completes an undo entry, and registers it with the player's client
---@param NiceText string Text that appears in the player's undo history
function undo.Finish(NiceText) end

-- Serverside, returns a table containing all undo blocks of all players. Clientside, returns a table of the local player's undo blocks. Serverside, this table's keys use Player:UniqueID to store a player's undo blocks.
---@return table
function undo.GetTable() end

--  Makes the UI dirty - it will re-create the controls the next time it is viewed.
function undo.MakeUIDirty() end

-- Replaces any instance of the "from" reference with the "to" reference, in any existing undo block. Returns true if something was replaced
---@param from Entity The old entity
---@param to Entity The new entity to replace the old one
---@return boolean
function undo.ReplaceEntity(from,to) end

-- Sets a custom undo text for the current undo block
---@param customText string The text to display when the undo block is undone
function undo.SetCustomUndoText(customText) end

-- Sets the player which the current undo block belongs to
---@param ply Player The player responsible for undoing the block
function undo.SetPlayer(ply) end

--  Adds a hook (CPanelPaint) to the control panel paint function so we can determine when it is being drawn.
function undo.SetupUI() end



usermessage = {}
-- Returns a table of every usermessage hook
---@return table
function usermessage.GetTable() end

-- You should be using net instead  Sets a hook for the specified to be called when a usermessage with the specified name arrives.  Usermessages have a limit of only 256 bytes!
---@param name string The message name to hook to.
---@param callback function The function to be called if the specified message was received. * bf_read msg * vararg preArgs
---@param ...? any Arguments that are passed to the callback function when the hook is called.
function usermessage.Hook(name,callback,...) end

--  Called by the engine when a usermessage arrives, this method calls the hook function specified by usermessage.Hook if any.
---@param name string The message name.
---@param msg bf_read The message.
function usermessage.IncomingMessage(name,msg) end



utf8 = {}
-- A UTF-8 compatible version of string.GetChar.
---@param str string The string that you will be searching with the supplied index.
---@param index number The index's value of the string to be returned.
---@return string
function utf8.GetChar(str,index) end



util = {}
-- Adds the specified string to a string table, which will cache it and network it to all clients automatically. Whenever you want to create a net message with net.Start, you must add the name of that message as a networked string via this function.  If the passed string already exists, nothing will happen and the ID of the existing item will be returned.  Each unique network name needs to be pooled once - do not put this function call into any other functions if you're using a constant string. Preferable place for this function is in a serverside lua file, or in a shared file with the net.Receive function.  The string table used for this function does not interfere with the engine string tables and has 4095 slots. This limit is shared among all entities, SetNW* and SetGlobal* functions. If you exceed the limit, you cannot create new variables, and you will get the following warning: ```lua Warning:  Table networkstring is full, can't add [key] ``` Existing variables will still get updated without the warning. You can check the limit by counting up until util.NetworkIDToString returns nil
---@param str string Adds the specified string to the string table.
---@return number
function util.AddNetworkString(str) end

-- Function used to calculate aim vector from 2D screen position. It is used in SuperDOF calculate Distance.  Essentially a generic version of gui.ScreenToVector.
---@param ViewAngles Angle View angles
---@param ViewFOV number View Field of View
---@param x number Mouse X position
---@param y number Mouse Y position
---@param scrWidth number Screen width
---@param scrHeight number Screen height
---@return Vector
function util.AimVector(ViewAngles,ViewFOV,x,y,scrWidth,scrHeight) end

-- Decodes the specified string from base64.
---@param str string String to decode.
---@return string
function util.Base64Decode(str) end

-- Encodes the specified string to base64.  Unless disabled with the `inline` argument, the Base64 returned is compliant to the RFC 2045 standard. **This means it will have a line break after every 76th character.**
---@param str string String to encode.
---@param inline? boolean `true` to disable RFC 2045 compliance (newline every 76th character)
---@return string
function util.Base64Encode(str,inline) end

-- Applies explosion damage to all entities in the specified radius.
---@param inflictor Entity The entity that caused the damage.
---@param attacker Entity The entity that attacked.
---@param damageOrigin Vector The center of the explosion
---@param damageRadius number The radius in which entities will be damaged.
---@param damage number The amount of damage to be applied.
function util.BlastDamage(inflictor,attacker,damageOrigin,damageRadius,damage) end

-- Applies spherical damage based on damage info to all entities in the specified radius.
---@param dmg CTakeDamageInfo The information about the damage
---@param damageOrigin Vector Center of the spherical damage
---@param damageRadius number The radius in which entities will be damaged.
function util.BlastDamageInfo(dmg,damageOrigin,damageRadius) end

-- Compresses the given string using the [LZMA](https://en.wikipedia.org/wiki/LZMA) algorithm.  Use with net.WriteData and net.ReadData for networking and  util.Decompress to decompress the data.
---@param str string String to compress.
---@return string
function util.Compress(str) end

-- Generates the [CRC Checksum](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) of the specified string.   This is NOT a hashing function. It is a checksum, typically used for error detection/data corruption detection. It is possible for this function to generate "collisions", where two different strings will produce the same CRC. If you need a hashing function, use util.SHA256. 
---@param stringToChecksum string The string to calculate the checksum of.
---@return string
function util.CRC(stringToChecksum) end

-- Returns the current date formatted like '2012-10-31 18-00-00'
---@return string
function util.DateStamp() end

-- Performs a trace and paints a decal to the surface hit.
---@param name string The name of the decal to paint.
---@param start Vector The start of the trace.
---@param endVal Vector The end of the trace.
---@param filter? Entity If set, the decal will not be able to be placed on given entity. Can also be a table of entities.
function util.Decal(name,start,endVal,filter) end

-- Performs a trace and paints a decal to the surface hit.  This function has trouble spanning across multiple brushes on the map.
---@param material IMaterial The name of the decal to paint. Can be retrieved with util.DecalMaterial.
---@param ent Entity The entity to apply the decal to
---@param position Vector The position of the decal.
---@param normal Vector The direction of the decal.
---@param color table The color of the decal. Uses the Color.  This only works when used on a brush model and only if the decal material has set **$vertexcolor** to 1.
---@param w number The width scale of the decal.
---@param h number The height scale of the decal.
function util.DecalEx(material,ent,position,normal,color,w,h) end

-- Gets the full material path by the decal name. Used with util.DecalEx.
---@param decalName string Name of the decal.
---@return string
function util.DecalMaterial(decalName) end

-- Decompresses the given string using [LZMA](https://en.wikipedia.org/wiki/LZMA) algorithm. Used to decompress strings previously compressed with util.Compress.
---@param compressedString string The compressed string to decompress.
---@param maxSize? number The maximal size in bytes it will decompress.
---@return string
function util.Decompress(compressedString,maxSize) end

-- Gets the distance between a line and a point in 3d space.
---@param lineStart Vector Start of the line.
---@param lineEnd Vector End of the line.
---@param pointPos Vector The position of the point.
---@return number
---@return Vector
---@return number
function util.DistanceToLine(lineStart,lineEnd,pointPos) end

-- Creates an effect with the specified data.  For Orange Box `.pcf` particles, see Global.ParticleEffect, Global.ParticleEffectAttach and  Global.CreateParticleSystem.   When dispatching an effect from the server, some values may be clamped for networking optimizations. Visit the Set accessors on CEffectData to see which ones are affected.  You will need to couple this function with Global.IsFirstTimePredicted if you want to use it in Prediction. 
---@param effectName string The name of the effect to create.  You can find a list of Effects. You can create your own, [example effects can be found here](https://github.com/garrynewman/garrysmod/tree/master/garrysmod/gamemodes/sandbox/entities/effects) and [here](https://github.com/garrynewman/garrysmod/tree/master/garrysmod/gamemodes/base/entities/effects).
---@param effectData CEffectData The effect data describing the effect.
---@param allowOverride? boolean Whether Lua-defined effects should override engine-defined effects with the same name for this/single function call.
---@param ignorePredictionOrRecipientFilter? any Can either be a boolean to ignore the prediction filter or a CRecipientFilter.  Set this to true if you wish to call this function in multiplayer from server.
function util.Effect(effectName,effectData,allowOverride,ignorePredictionOrRecipientFilter) end

-- Filters given text using Steam's filtering system. The function will obey local client's Steam settings for chat filtering:  In some cases, especially in a chatbox, messages from some players may return an empty string if the context argument used for filtering is `TEXT_FILTER_CHAT` and [if the local player has blocked the sender of the message on Steam](https://github.com/Facepunch/garrysmod-issues/issues/5161#issuecomment-1035153941).   
---@param str string String to filter.
---@param context? number Filtering context. See Enums/TEXT_FILTER.
---@param player? Player Used to determine if the text should be filtered according to local user's Steam chat filtering settings.
---@return string
function util.FilterText(str,context,player) end

-- Converts the Full path of the given GMA file to the Relative Path. You can use util.RelativePathToFull_Menu to convert the Relative path back to the Full Path.
---@param gma string The **Full** path to the GMA file. **like: "[Steam folder]\common\garrysmod\garrysmod\addons\[Name].gma"**
---@param gamePath? string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return string
function util.FullPathToRelative_Menu(gma,gamePath) end

-- Returns a table containing the info about the model.  This function will silently fail if used on models with following strings in them: * _shared * _anims * _gestures * _anim * _postures * _gst * _pst * _shd * _ss * _anm * _include
---@param mdl string Model path
---@return table
function util.GetModelInfo(mdl) end

-- Returns a table of visual meshes of given model. This does not work on brush models (`*number` models) See also ENTITY:GetRenderMesh.
---@param model string The full path to a model to get the visual meshes of.
---@param lod? number
---@param bodygroupMask? number
---@return table
---@return table
function util.GetModelMeshes(model,lod,bodygroupMask) end

-- Gets PData of an offline player using their SteamID This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
---@param steamID string SteamID of the player
---@param name string Variable name to get the value of
---@param default string The default value, in case there's nothing stored
---@return string
function util.GetPData(steamID,name,default) end

-- Creates a new PixVis handle. See util.PixelVisible.
---@return pixelvis_handle_t
function util.GetPixelVisibleHandle() end

-- Utility function to quickly generate a trace table that starts at the players view position, and ends `32768` units along a specified direction.
---@param ply Player The player the trace should be based on
---@param dir? Vector The direction of the trace
---@return table
function util.GetPlayerTrace(ply,dir) end

-- Gets information about the sun position and obstruction or nil if there is no sun.
---@return table
function util.GetSunInfo() end

-- Returns data of a surface property at given ID.
---@param id number Surface property ID. You can get it from Structures/TraceResult.
---@return table
function util.GetSurfaceData(id) end

-- Returns the matching surface property index for the given surface property name.  See also util.GetSurfaceData and util.GetSurfacePropName for opposite function.
---@param surfaceName string The name of the surface.
---@return number
function util.GetSurfaceIndex(surfaceName) end

-- Returns the name of a surface property at given ID.  See also util.GetSurfaceData and util.GetSurfaceIndex for opposite function.
---@param id number Surface property ID. You can get it from Structures/TraceResult.
---@return string
function util.GetSurfacePropName(id) end

-- Returns a table of all SteamIDs that have a usergroup.  This returns the original usergroups table, changes done to this table are not retroactive and will only affect newly connected users  This returns only groups that are registered in the **settings/users.txt** file of your server.  In order to get the usergroup of a connected player, please use Player:GetUserGroup instead.
---@return table
function util.GetUserGroups() end

-- Performs a "ray" box intersection and returns position, normal and the fraction.
---@param rayStart Vector Origin/start position of the ray.
---@param rayDelta Vector The ray vector itself. This can be thought of as: the ray end point relative to the start point.  Note that in this implementation, the ray is not infinite - it's only a segment.
---@param boxOrigin Vector The center of the box.
---@param boxAngles Angle The angles of the box.
---@param boxMins Vector The min position of the box.
---@param boxMaxs Vector The max position of the box.
---@return Vector
---@return Vector
---@return number
function util.IntersectRayWithOBB(rayStart,rayDelta,boxOrigin,boxAngles,boxMins,boxMaxs) end

-- Performs a [ray-plane intersection](https://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection) and returns the hit position or nil.
---@param rayOrigin Vector Origin/start position of the ray.
---@param rayDirection Vector The direction of the ray.
---@param planePosition Vector Any position of the plane.
---@param planeNormal Vector The normal vector of the plane.
---@return Vector
function util.IntersectRayWithPlane(rayOrigin,rayDirection,planePosition,planeNormal) end

-- Returns whether a binary module is installed and is resolvable by Global.require.
---@param name string Name of the binary module, exactly the same as you would enter it as the argument to Global.require.
---@return boolean
function util.IsBinaryModuleInstalled(name) end

-- Checks if a certain position is within the world bounds.
---@param position Vector Position to check.
---@return boolean
function util.IsInWorld(position) end

-- Checks if the model is loaded in the game.
---@param modelName string Name/Path of the model to check.
---@return boolean
function util.IsModelLoaded(modelName) end

-- Check whether the skybox is visible from the point specified.  This will always return true in fullbright maps.
---@param position Vector The position to check the skybox visibility from.
---@return boolean
function util.IsSkyboxVisibleFromPoint(position) end

-- Checks if the specified model is valid.   A model is considered invalid in following cases: * Starts with a space or **maps** * Doesn't start with **models** * Contains any of the following: * * _gestures * * _animations * * _postures * * _gst * * _pst * * _shd * * _ss * * _anm * * .bsp * * cs_fix * If the model isn't precached on the server, AND if the model file doesn't exist on disk * If precache failed * Model is the error model  Running this function will also precache the model.
---@param modelName string Name/Path of the model to check.
---@return boolean
function util.IsValidModel(modelName) end

-- Checks if given numbered physics object of given entity is valid or not. Most useful for ragdolls.
---@param ent Entity The entity
---@param physobj number Number of the physics object to test
---@return boolean
function util.IsValidPhysicsObject(ent,physobj) end

-- Checks if the specified prop is valid.
---@param modelName string Name/Path of the model to check.
---@return boolean
function util.IsValidProp(modelName) end

-- Checks if the specified model name points to a valid ragdoll.
---@param ragdollName string Name/Path of the ragdoll model to check.
---@return boolean
function util.IsValidRagdoll(ragdollName) end

-- Converts a JSON string to a Lua table.  Keys are converted to numbers wherever possible. This means using Player:SteamID64 as keys won't work.  There is a limit of 15,000 keys total. This will attempt cast the string keys "inf", "nan", "true", and "false" to their respective Lua values. This completely ignores nulls in arrays. Colors will not have the color metatable.
---@param json string The JSON string to convert.
---@return table
function util.JSONToTable(json) end

-- Converts a Valve KeyValue string (typically from util.TableToKeyValues) to a Lua table.  Due to how tables work in Lua, keys will not repeat within a table. See util.KeyValuesToTablePreserveOrder for alternative.
---@param keyValues string The KeyValue string to convert.
---@param usesEscapeSequences? boolean If set to true, will replace `\t`, `\n`, `\"` and `\\` in the input text with their escaped variants
---@param preserveKeyCase? boolean Whether we should preserve key case (may fail) or not (always lowercase)
---@return table
function util.KeyValuesToTable(keyValues,usesEscapeSequences,preserveKeyCase) end

-- Similar to util.KeyValuesToTable but it also preserves order of keys.
---@param keyvals string The key value string
---@param usesEscapeSequences? boolean If set to true, will replace `\t`, `\n`, `\"` and `\\` in the input text with their escaped variants
---@param preserveKeyCase? boolean Whether we should preserve key case (may fail) or not (always lowercase)
---@return table
function util.KeyValuesToTablePreserveOrder(keyvals,usesEscapeSequences,preserveKeyCase) end

-- Returns a vector in world coordinates based on an entity and local coordinates
---@param ent Entity The entity lpos is local to
---@param lpos Vector Coordinates local to the ent
---@param bonenum number The bonenumber of the ent lpos is local to
---@return Vector
function util.LocalToWorld(ent,lpos,bonenum) end

-- Generates the [MD5 hash](https://en.wikipedia.org/wiki/MD5) of the specified string. MD5 is considered cryptographically broken and is known to be vulnerable to a variety of attacks including duplicate return values. If security or duplicate returns is a concern, use util.SHA256.
---@param stringToHash string The string to calculate the MD5 hash of.
---@return string
function util.MD5(stringToHash) end

-- Returns the networked string associated with the given ID from the string table.
---@param stringTableID number ID to get the associated string from.
---@return string
function util.NetworkIDToString(stringTableID) end

-- Returns the networked ID associated with the given string from the string table.
---@param networkString string String to get the associated networked ID from.
---@return number
function util.NetworkStringToID(networkString) end

-- Formats a float by stripping off extra `0's` and `.'s`.
---@param float number The float to format.
---@return string
function util.NiceFloat(float) end

-- Creates a tracer effect with the given parameters.
---@param name string The name of the tracer effect.
---@param startPos Vector The start position of the tracer.
---@param endPos Vector The end position of the tracer.
---@param doWhiz boolean Play the hit miss(whiz) sound.
function util.ParticleTracer(name,startPos,endPos,doWhiz) end

-- Creates a tracer effect with the given parameters.
---@param name string The name of the tracer effect.
---@param startPos Vector The start position of the tracer.
---@param endPos Vector The end position of the tracer.
---@param doWhiz boolean Play the hit miss(whiz) sound.
---@param entityIndex number Entity index of the emitting entity.
---@param attachmentIndex number Attachment index to be used as origin.
function util.ParticleTracerEx(name,startPos,endPos,doWhiz,entityIndex,attachmentIndex) end

-- Returns the visibility of a sphere in the world.
---@param position Vector The center of the visibility test.
---@param radius number The radius of the sphere to check for visibility.
---@param PixVis pixelvis_handle_t The PixVis handle created with util.GetPixelVisibleHandle. Don't use the same handle twice per tick or it will give unpredictable results.
---@return number
function util.PixelVisible(position,radius,PixVis) end

-- Returns the contents of the position specified. This function will sample only the world environments. It can be used to check if Entity:GetPos is underwater for example unlike Entity:WaterLevel which works for players only.
---@param position Vector Position to get the contents sample from.
---@return number
function util.PointContents(position) end

-- Precaches a model for later use. Model is cached after being loaded once.  Modelprecache is limited to 4096 unique models. When it reaches the limit the game will crash. 
---@param modelName string The model to precache.
function util.PrecacheModel(modelName) end

-- Precaches a sound for later use. Sound is cached after being loaded once. Soundcache is limited to 16384 unique sounds on the server.  Broken on purpose because hitting the limit above causes the server to shutdown Ultimately does nothing on client, and only works with sound scripts, not direct paths.
---@param soundName string The sound to precache.
function util.PrecacheSound(soundName) end

-- Performs a trace with the given origin, direction, and filter.
---@param origin Vector The origin of the trace.
---@param dir Vector The direction of the trace times the distance of the trace. This is added to the origin to determine the endpos.
---@param filter? Entity Entity which should be ignored by the trace. Can also be a table of entities or a function - see Structures/Trace.
---@return table
function util.QuickTrace(origin,dir,filter) end

-- Converts the relative path of the given GMA file to the Full Path. You can use util.FullPathToRelative_Menu to convert the Full path back to the Relative Path.
---@param gma string The Relative path to the GMA file. **like: "addons/[Name].gma"**
---@param gamePath? string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@return string
function util.RelativePathToFull_Menu(gma,gamePath) end

-- Returns the AddonInfo of the Addon the given file belongs to.
---@param gma string The **Full** path to the GMA file. **like: "[Steam folder]\common\garrysmod\garrysmod\addons\[Name].gma"**
---@return table
function util.RelativePathToGMA_Menu(gma) end

-- Removes PData of offline player using their SteamID.  This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
---@param steamID string SteamID of the player
---@param name string Variable name to remove
function util.RemovePData(steamID,name) end

-- Makes the screen shake.  The screen shake effect is rendered by modifying the view origin on the client. If you override the view origin in GM:CalcView you may not be able to see the shake effect.
---@param pos Vector The origin of the effect. Does nothing on client.
---@param amplitude number The strength of the effect.
---@param frequency number The frequency of the effect in hertz.
---@param duration number The duration of the effect in seconds.
---@param radius number The range from the origin within which views will be affected, in Hammer units. Does nothing on client.
function util.ScreenShake(pos,amplitude,frequency,duration,radius) end

-- Sets PData for offline player using his SteamID. This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
---@param steamID string SteamID of the player.
---@param name string Variable name to store the value in.
---@param value any The value to store.
function util.SetPData(steamID,name,value) end

-- Generates the [SHA-1 hash](https://en.wikipedia.org/wiki/SHA-1) of the specified string. SHA-1 is considered cryptographically broken and is known to be vulnerable to a variety of attacks. If security is a concern, use util.SHA256.
---@param stringToHash string The string to calculate the SHA-1 hash of.
---@return string
function util.SHA1(stringToHash) end

-- Generates the [SHA-256 hash](https://en.wikipedia.org/wiki/SHA-2) of the specified string.
---@param stringToHash string The string to calculate the SHA-256 hash of.
---@return string
function util.SHA256(stringToHash) end

-- Generates a random float value that should be the same on client and server.  This function is best used in a Predicted Hook
---@param uniqueName string The seed for the random value
---@param min number The minimum value of the random range
---@param max number The maximum value of the random range
---@param additionalSeed? number The additional seed
---@return number
function util.SharedRandom(uniqueName,min,max,additionalSeed) end

-- Adds a trail to the specified entity.
---@param ent Entity Entity to attach trail to
---@param attachmentID number Attachment ID of the entities model to attach trail to. If you are not sure, set this to 0
---@param color table Color of the trail, use Global.Color
---@param additive boolean Should the trail be additive or not
---@param startWidth number Start width of the trail
---@param endWidth number End width of the trail
---@param lifetime number How long it takes to transition from startWidth to endWidth
---@param textureRes number The resolution of trails texture. A good value can be calculated using this formula: 1 / ( startWidth + endWidth ) * 0.5
---@param texture string Path to the texture to use as a trail.
---@return Entity
function util.SpriteTrail(ent,attachmentID,color,additive,startWidth,endWidth,lifetime,textureRes,texture) end

-- Returns a new Stack object.
---@return Stack
function util.Stack() end

-- Given a 64bit SteamID will return a STEAM_0: style Steam ID
---@param id string The 64 bit Steam ID
---@return string
function util.SteamIDFrom64(id) end

-- Given a STEAM_0 style Steam ID will return a 64bit Steam ID
---@param id string The STEAM_0 style id
---@return string
function util.SteamIDTo64(id) end

-- Converts a string to the specified type.  This can be useful when dealing with ConVars.
---@param str string The string to convert
---@param typename string The type to attempt to convert the string to. This can be vector, angle, float, int, bool, or string (case insensitive).
---@return any
function util.StringToType(str,typename) end

-- Converts a table to a JSON string. Trying to serialize or deserialize SteamID64s in JSON will NOT work correctly. They will be interpreted as numbers which cannot be precisely stored by JavaScript, Lua and JSON, leading to loss of data. You may want to use util.SteamIDFrom64 to work around this. Alternatively, just append a character to the SteamID64 to force util.JSONToTable to treat it as a string. All integers will be converted to decimals (5 -&gt; 5.0). All keys are strings in the JSON format, so all keys will be converted to strings! This will produce invalid JSON if the provided table contains nan or inf values.
---@param table table Table to convert.
---@param prettyPrint? boolean Format and indent the JSON.
---@return string
function util.TableToJSON(table,prettyPrint) end

-- Converts the given table into a Valve key value string.  Use util.KeyValuesToTable to perform the opposite transformation.  You should consider using util.TableToJSON instead.
---@param table table The table to convert.
---@param rootKey? string The root key name for the output KV table.
---@return string
function util.TableToKeyValues(table,rootKey) end

-- Creates a timer object.
---@param startdelay? number How long you want the timer to be.
---@return table
function util.Timer(startdelay) end

-- Returns the time since this function has been last called
---@return number
function util.TimerCycle() end

-- Runs a trace using the entity's collisionmodel between two points. This does not take the entity's angles into account and will trace its unrotated collisionmodel.  Clientside entities will not be hit by traces.
---@param tracedata table Trace data. See Structures/Trace
---@param ent Entity The entity to use
---@return table
function util.TraceEntity(tracedata,ent) end

-- This function is broken and returns the same values all the time Traces from one entity to another.
---@param ent1 Entity The first entity to trace from
---@param ent2 Entity The second entity to trace to
---@return table
function util.TraceEntityHull(ent1,ent2) end

-- Performs an AABB hull (axis-aligned bounding box, aka not rotated) trace with the given trace data.  Clientside entities will not be hit by traces.  This function may not always give desired results clientside due to certain physics mechanisms not existing on the client. Use it serverside for accurate results.
---@param TraceData table The trace data to use. See Structures/HullTrace
---@return table
function util.TraceHull(TraceData) end

-- Performs a trace with the given trace data.  Clientside entities will not be hit by traces.  When server side trace starts inside a solid, it will hit the most inner solid the beam start position is located in. Traces are triggered by change of boundary.
---@param TraceData table The trace data to use. See Structures/Trace
---@return table
function util.TraceLine(TraceData) end

-- Converts a type to a (nice, but still parsable) string
---@param input any What to convert
---@return string
function util.TypeToString(input) end



vgui = {}
-- Creates a panel by the specified classname. Custom VGUI elements are not loaded instantly. Use GM:OnGamemodeLoaded to create them on startup.
---@param classname string Classname of the panel to create.  Default panel classnames can be found on the VGUI Element List.  New panels can be registered via vgui.Register
---@param parent? Panel Panel to parent to.
---@param name? string Custom name of the created panel for scripting/debugging purposes. Can be retrieved with Panel:GetName.
---@return Panel
function vgui.Create(classname,parent,name) end

-- Creates a panel from table. Typically used with vgui.RegisterFile and vgui.RegisterTable.
---@param metatable table Your PANEL table.
---@param parent? Panel Which panel to parent the newly created panel to.
---@param name? string Custom name of the created panel for scripting/debugging purposes. Can be retrieved with Panel:GetName.
---@return Panel
function vgui.CreateFromTable(metatable,parent,name) end

--  Creates an engine panel.
---@param class string Class of the panel to create
---@param parent? Panel If specified, parents created panel to given one
---@param name? string Name of the created panel
---@return Panel
function vgui.CreateX(class,parent,name) end

-- Returns whenever the cursor is currently active and visible.
---@return boolean
function vgui.CursorVisible() end

-- Returns whether the currently focused panel is a child of the given one.
---@param parent Panel The parent panel to check the currently focused one against. This doesn't need to be a direct parent (focused panel can be a child of a child and so on).
---@return boolean
function vgui.FocusedHasParent(parent) end

-- Gets the method table of this panel. Does not return parent methods!
---@param Panelname string The name of the panel
---@return table
function vgui.GetControlTable(Panelname) end

-- Returns the panel the cursor is hovering above.  This returns a cached value that is only updated after rendering and `before` the next VGUI Think/Layout pass.  ie. it lags one frame behind panel layout and is completely unhelpful for PANEL:Paint if your panels are moving around under the mouse a lot every frame.
---@return Panel
function vgui.GetHoveredPanel() end

-- Returns the panel which is currently receiving keyboard input.
---@return Panel
function vgui.GetKeyboardFocus() end

-- Returns the global world panel which is the parent to all others, except for the HUD panel.  See also Global.GetHUDPanel.
---@return Panel
function vgui.GetWorldPanel() end

-- Returns whenever the cursor is hovering the world panel.
---@return boolean
function vgui.IsHoveringWorld() end

-- Registers a panel for later creation via vgui.Create.
---@param classname string Classname of the panel to register. This is what you will need to pass to vgui.Create's first argument.
---@param panelTable table The table containing the panel information.
---@param baseName? string Classname of a panel to inherit functionality from. Functions with same names will be overwritten preferring the panel that is being registered.
---@return table
function vgui.Register(classname,panelTable,baseName) end

-- Registers a new VGUI panel from a file, to be used with vgui.CreateFromTable.  File file must use the `PANEL` global that is provided just before the file is Global.included, for example:   ``` PANEL.Base = "Panel"  function PANEL:Init() -- Your code... end  function PANEL:Think() -- Your code... end ```
---@param file string The file to register
---@return table
function vgui.RegisterFile(file) end

-- Registers a table to use as a panel, to be used with vgui.CreateFromTable.  All this function does is assigns Base key to your table and returns the table.
---@param panel table The PANEL table.
---@param base? string A base for the panel.
---@return table
function vgui.RegisterTable(panel,base) end



video = {}
-- Attempts to create an IVideoWriter.
---@param config table The video config. See Structures/VideoData.
---@return IVideoWriter
---@return string
function video.Record(config) end



weapons = {}
-- Get a `copy` of weapon table by name. This function also inherits fields from the weapon's base class, unlike weapons.GetStored.  This will only work on SWEP's, this means that this will not return anything for HL2/HL:S weapons. 
---@param classname string Class name of weapon to retrieve
---@return table
function weapons.Get(classname) end

-- Get a list of all the registered SWEPs. This does not include weapons added to spawnmenu manually.
---@return table
function weapons.GetList() end

-- Gets the REAL weapon table, not a copy. The produced table does `not` inherit fields from the weapon's base class, unlike weapons.Get.  Modifying this table will modify what is stored by the weapons library. Take a copy or use weapons.Get to avoid this.
---@param weapon_class string Weapon class to retrieve weapon table of
---@return table
function weapons.GetStored(weapon_class) end

-- Checks if name is based on base
---@param name string Entity's class name to be checked
---@param base string Base class name to be checked
---@return boolean
function weapons.IsBasedOn(name,base) end

--   Called after all SWEPS have been loaded and runs baseclass.Set on each one.  You can retrieve all the currently registered SWEPS with weapons.GetList.  This is not called after a SWEP auto refresh, and thus the inherited baseclass functions retrieved with baseclass.Get will not be updated
function weapons.OnLoaded() end

-- Registers a Scripted Weapon (SWEP) class manually. When the engine spawns an entity, weapons registered with this function will be created if the class names match.  See also scripted_ents.Register for Scripted Entities (SENTs)  Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied.
---@param swep_table table The SWEP table
---@param classname string Classname to assign to that swep
function weapons.Register(swep_table,classname) end



widgets = {}
--  Automatically called to update all widgets.
---@param ply Player The player
---@param mv CMoveData Player move data
function widgets.PlayerTick(ply,mv) end

-- Renders a widget. Normally you won't need to call this.
---@param ent Entity Widget entity to render
function widgets.RenderMe(ent) end



