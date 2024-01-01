---@meta

-- Adds simple Get/Set accessor functions on the specified table. Can also force the value to be set to a number, bool or string.
---@param tab table The table to add the accessor functions to.
---@param key any The key of the table to be get/set.
---@param name string The name of the functions (will be prefixed with Get and Set).
---@param force? number The type the setter should force to (uses Enums/FORCE).
function AccessorFunc(tab,key,name,force) end

-- Defines a global entity class variable with an automatic value in order to prevent collisions with other Enums/CLASS. You should prefix your variable with CLASS_ for consistency.
---@param name string The name of the new enum/global variable.
function Add_NPC_Class(name) end

-- Adds the specified image path to the main menu background pool. Image can be png or jpeg.
---@param path string Path to the image.
function AddBackgroundImage(path) end

-- Use concommand.Add instead.Tells the engine to register a console command. If the command was ran, the engine calls concommand.Run.
---@param name string The name of the console command to add.
---@param helpText string The help text.
---@param flags number Concommand flags using Enums/FCVAR
function AddConsoleCommand(name,helpText,flags) end

-- Marks a Lua file to be sent to clients when they join the server. Doesn't do anything on the client - this means you can use it in a shared file without problems.  If the file trying to be added is empty, an error will occur, and the file will not be sent to the client  The string cannot have whitespace.  This function is not needed for scripts located in **lua/autorun/** and **lua/autorun/client/**: they are automatically sent to clients.  You can add up to **8192** files. Each file can be up to **64KB** compressed (LZMA)
---@param file? string The name/path to the Lua file that should be sent, **relative to the garrysmod/lua folder**. If no parameter is specified, it sends the current file.  The file path can be relative to the script it's ran from. For example, if your script is in `lua/myfolder/stuff.lua`, calling Global.AddCSLuaFile("otherstuff.lua") and Global.AddCSLuaFile("myfolder/otherstuff.lua") is the same thing.  Please make sure your file names are unique, the filesystem is shared across all addons, so a file named `lua/config.lua` in your addon may be overwritten by the same file in another addon.
function AddCSLuaFile(file) end

-- Loads the specified image from the `/cache` folder, used in combination steamworks.Download. Most addons will provide a 512x512 png image.
---@param name string The name of the file.
---@return IMaterial
function AddonMaterial(name) end

-- Adds the specified vector to the PVS which is currently building. This allows all objects in visleafs visible from that vector to be drawn.
---@param position Vector The origin to add.
function AddOriginToPVS(position) end

-- This function creates a Custom Category in the Spawnlist. Use Global.GenerateSpawnlistFromPath if you want to create a category with the contents of a folder. Using this function before SANDBOX:PopulateContent has been called will result in an error
---@param pnlContent Panel The SMContentPanel of the Node
---@param node Panel The Node
---@param parentid number The ParentID to use
---@param customProps table The Table with the Contents of the new Category
function AddPropsOfParent(pnlContent,node,parentid,customProps) end

-- This function creates a World Tip, similar to the one shown when aiming at a Thruster where it shows you its force.  This function will make a World Tip that will only last 50 milliseconds (1/20th of a second), so you must call it continuously as long as you want the World Tip to be shown. It is common to call it inside a Think hook.  Contrary to what the function's name implies, it is impossible to create more than one World Tip at the same time. A new World Tip will overwrite the old one, so only use this function when you know nothing else will also be using it.  See SANDBOX:PaintWorldTips for more information.  This function is only available in Sandbox and its derivatives
---@param entindex? number **This argument is no longer used**; it has no effect on anything. You can use nil in this argument.
---@param text string The text for the world tip to display.
---@param dieTime? number **This argument is no longer used**; when you add a World Tip it will always last only 0.05 seconds. You can use nil in this argument.
---@param pos? Vector Where in the world you want the World Tip to be drawn. If you add a valid Entity in the next argument, this argument will have no effect on the actual World Tip.
---@param ent? Entity Which entity you want to associate with the World Tip. This argument is optional. If set to a valid entity, this will override the position set in `pos` with the Entity's position.
function AddWorldTip(entindex,text,dieTime,pos,ent) end

-- Creates an Angle object. This function is very expensive when used in often running hooks or in operations requiring very frequent calls (like loops for example). It is better to store the angle in a variable or to use the [default angle](https://wiki.facepunch.com/gmod/Global_Variables#misc) available.
---@param pitch? number The pitch value of the angle.   If this is an Angle, this function will return a copy of the given angle.   If this is a string, this function will try to parse the string as a angle. If it fails, it returns a 0 angle. (See examples)
---@param yaw? number The yaw value of the angle.
---@param roll? number The roll value of the angle.
---@return Angle
function Angle(pitch,yaw,roll) end

-- Returns an angle with a randomized pitch, yaw, and roll between min(inclusive), max(exclusive).
---@param min? number Min bound inclusive.
---@param max? number Max bound exclusive.
---@return Angle
function AngleRand(min,max) end

-- Sends the specified Lua code to all connected clients and executes it.  If you need to use this function more than once, consider using net library. Send net message and make the entire code you want to execute in net.Receive on client. If executed **clientside** it won't do anything. 
---@param code string The code to be executed. Capped at length of 254 characters.
function BroadcastLua(code) end

-- Dumps the networked variables of all entities into one table and returns it.
---@return table
function BuildNetworkedVarsTable() end

--   Used internally to check if the current server the player is on can be added to favorites or not. Does not check if the server is ALREADY in the favorites.
---@return boolean
function CanAddServerToFavorites() end

-- Aborts joining of the server you are currently joining.
function CancelLoading() end

-- Sets the active main menu background image to a random entry from the background images pool. Images are added with Global.AddBackgroundImage.
---@param currentgm string Apparently does nothing.
function ChangeBackground(currentgm) end

-- Automatically called by the engine when a panel is hovered over with the mouse
---@param panel Panel Panel that has been hovered over
function ChangeTooltip(panel) end

-- Empties the pool of main menu background images.
function ClearBackgroundImages() end

-- Clears all Lua Errors with the given group id.
---@param group_id string group_id to remove. Will be "[addon-name]-0" or "Other-"
function ClearLuaErrorGroup(group_id) end

-- Removes the given Problem from the Problems table and refreshes the Problems panel.
---@param id string The Problem ID to remove
function ClearProblem(id) end

-- Creates a non physical entity that only exists on the client. See also ents.CreateClientProp.  Parented clientside models will become detached if the parent entity leaves the PVS. **A workaround is available on its github page.**  Clientside entities are not garbage-collected, thus you must store a reference to the object and call CSEnt:Remove manually. **To workaround this bug, you need to hold a reference (in a variable) to the entity and remove it when necessary.**  Clientside models will occasionally delete themselves during high server lag.
---@param model string The file path to the model.  Model must be precached with util.PrecacheModel on the server before usage.
---@param renderGroup? number The render group of the entity for the clientside leaf system, see Enums/RENDERGROUP.
---@return CSEnt
function ClientsideModel(model,renderGroup) end

-- Creates a fully clientside ragdoll.  The ragdoll initially starts as hidden and with shadows disabled, see the example for how to enable it.  There's no need to call Entity:Spawn on this entity.  The physics won't initialize at all if the model hasn't been precached serverside first.  Clientside entities are not garbage-collected, thus you must store a reference to the object and call CSEnt:Remove manually.
---@param model string The file path to the model.  Model must be precached with util.PrecacheModel on the server before usage.
---@param renderGroup? number The Enums/RENDERGROUP to assign.
---@return CSEnt
function ClientsideRagdoll(model,renderGroup) end

-- Creates a scene entity based on the scene name and the entity.
---@param name string The name of the scene.
---@param targetEnt Entity The entity to play the scene on.
---@return CSEnt
function ClientsideScene(name,targetEnt) end

-- Closes all Derma menus that have been passed to Global.RegisterDermaMenuForClose and calls GM:CloseDermaMenus
function CloseDermaMenus() end

-- Creates a Color. This function is very expensive when used in rendering hooks or in operations requiring very frequent calls (like loops for example). It is better to store the color in a variable or to use the [default colors](https://wiki.facepunch.com/gmod/Global_Variables#misc) available.
---@param r number An integer from `0-255` describing the red value of the color.
---@param g number An integer from `0-255` describing the green value of the color.
---@param b number An integer from `0-255` describing the blue value of the color.
---@param a? number (optional) An integer from `0-255` describing the alpha (transparency) of the color.
---@return table
function Color(r,g,b,a) end

-- Returns a new Color with the RGB components of the given Color and the alpha value specified.
---@param color table The Color from which to take RGB values. This color will not be modified.
---@param alpha number The new alpha value, a number between 0 and 255. Values above 255 will be clamped.
---@return table
function ColorAlpha(color,alpha) end

-- Creates a Color with randomized red, green, and blue components. If the alpha argument is true, alpha will also be randomized.
---@param a? boolean Should alpha be randomized.
---@return table
function ColorRand(a) end

-- Converts a Color into HSL color space.
---@param color table The Color.
---@return number
---@return number
---@return number
function ColorToHSL(color) end

-- Converts a Color into HSV color space.
---@param color table The Color.
---@return number
---@return number
---@return number
function ColorToHSV(color) end

-- Attempts to compile the given file. If successful, returns a function that can be called to perform the actual execution of the script.
---@param path string Path to the file, relative to the garrysmod/lua/ directory.
---@return function
function CompileFile(path) end

-- This function will compile the code argument as lua code and return a function that will execute that code.  Please note that this function will not automatically execute the given code after compiling it.
---@param code string The code to compile.
---@param identifier string An identifier in case an error is thrown. (The same identifier can be used multiple times)
---@param HandleError? boolean If false this function will return an error string instead of throwing an error.
---@return function
function CompileString(code,identifier,HandleError) end

-- Returns a table of console command names beginning with the given text.
---@param text string Text that the console commands must begin with.
---@return table
function ConsoleAutoComplete(text) end

-- Returns whether a ConVar with the given name exists or not
---@param name string Name of the ConVar.
---@return boolean
function ConVarExists(name) end

-- Makes a clientside-only console variable  This function is a wrapper of Global.CreateConVar, with the difference being that FCVAR_ARCHIVE and FCVAR_USERINFO are added automatically when **shouldsave** and **userinfo** are true, respectively.  Although this function is shared, it should only be used clientside.
---@param name string Name of the ConVar to be created and able to be accessed.  This cannot be a name of existing console command or console variable. It will silently fail if it is.
---@param default string Default value of the ConVar.
---@param shouldsave? boolean Should the ConVar be saved across sessions in the cfg/client.vdf file.
---@param userinfo? boolean Should the ConVar and its containing data be sent to the server when it has changed. This make the convar accessible from server using Player:GetInfoNum and similar functions.
---@param helptext string Help text to display in the console.
---@param min? number If set, the convar cannot be changed to a number lower than this value.
---@param max? number If set, the convar cannot be changed to a number higher than this value.
---@return ConVar
function CreateClientConVar(name,default,shouldsave,userinfo,helptext,min,max) end

-- Creates a ContextMenu. 
function CreateContextMenu() end

-- Creates a console variable (ConVar), in general these are for things like gamemode/server settings. Do not use the FCVAR_NEVER_AS_STRING and FCVAR_REPLICATED flags together, as this can cause the console variable to have strange values on the client.
---@param name string Name of the ConVar.  This cannot be a name of an engine console command or console variable. It will silently fail if it is. If it is the same name as another lua ConVar, it will return that ConVar object.
---@param value string Default value of the convar. Can also be a number.
---@param flags? number Flags of the convar, see Enums/FCVAR, either as bitflag or as table.
---@param helptext string The help text to show in the console.
---@param min? number If set, the ConVar cannot be changed to a number lower than this value.
---@param max? number If set, the ConVar cannot be changed to a number higher than this value.
---@return ConVar
function CreateConVar(name,value,flags,helptext,min,max) end

-- Creates a new material with the specified name and shader.  Materials created with this function can be used in Entity:SetMaterial and Entity:SetSubMaterial by prepending a "!" to their material name argument.  This does not work with [patch materials](https://developer.valvesoftware.com/wiki/Patch).  .pngs must be loaded with Global.Material before being used with this function.  This will not create a new material if another material object with the same name already exists.
---@param name string The material name. Must be unique.
---@param shaderName string The shader name. See Shaders.
---@param materialData table Key-value table that contains shader parameters and proxies.  * See: [List of Shader Parameters on Valve Developers Wiki](https://developer.valvesoftware.com/wiki/Category:List_of_Shader_Parameters) and each shader's page from .  Unlike IMaterial:SetTexture, this table will not accept ITexture values. Instead, use the texture's name (see ITexture:GetName).
---@return IMaterial
function CreateMaterial(name,shaderName,materialData) end

-- Creates a new Preset from the given JSON string.
---@param data string A JSON string containing all necessary informations. JSON structue should be Structures/Preset
function CreateNewAddonPreset(data) end

-- Creates a new particle system.  The particle effect must be precached with Global.PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
---@param ent Entity The entity to attach the control point to.
---@param effect string The name of the effect to create. It must be precached.
---@param partAttachment number See Enums/PATTACH.
---@param entAttachment? number The attachment ID on the entity to attach the particle system to
---@param offset? Vector The offset from the Entity:GetPos of the entity we are attaching this CP to.
---@return CNewParticleEffect
function CreateParticleSystem(ent,effect,partAttachment,entAttachment,offset) end

-- Creates a new PhysCollide from the given bounds.  This fails to create planes or points - no components of the mins or maxs can be the same.
---@param mins Vector Min corner of the box. This is not automatically ordered with the maxs and must contain the smallest vector components. See Global.OrderVectors.
---@param maxs Vector Max corner of the box. This is not automatically ordered with the mins and must contain the largest vector components.
---@return PhysCollide
function CreatePhysCollideBox(mins,maxs) end

-- Creates PhysCollide objects for every physics object the model has. The model must be precached with util.PrecacheModel before being used with this function.
---@param modelName string Model path to get the collision objects of.
---@return table
function CreatePhysCollidesFromModel(modelName) end

-- Returns a sound parented to the specified entity.  You can only create one CSoundPatch per audio file, per entity at the same time.
---@param targetEnt Entity The target entity.
---@param soundName string The sound to play.
---@param filter? CRecipientFilter A CRecipientFilter of the players that will have this sound networked to them.  If not set, the default is a [CPASAttenuationFilter](https://developer.valvesoftware.com/wiki/CRecipientFilter#Derived_classes).  This argument only works serverside.
---@return CSoundPatch
function CreateSound(targetEnt,soundName,filter) end

-- Creates and returns a new DSprite element with the supplied material.
---@param material IMaterial Material the sprite should draw.
---@return Panel
function CreateSprite(material) end

-- Returns the uptime of the server in seconds (to at least 4 decimal places)  This is a synchronised value and affected by various factors such as host_timescale (or game.GetTimeScale) and the server being paused - either by sv_pausable or all players disconnecting.  You should use this function for timing in-game events but not for real-world events.  See also: Global.RealTime, Global.SysTime  This is internally defined as a float, and as such it will be affected by precision loss if your server uptime is more than 6 hours, which will cause jittery movement of players and props and inaccuracy of timers, it is highly encouraged to refresh or change the map when that happens (a server restart is not necessary).    This is **NOT** easy as it sounds to fix in the engine, so please refrain from posting issues about this  This returns 0 in GM:PlayerAuthed.
---@return number
function CurTime() end

-- Returns an CTakeDamageInfo object.  This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once.
---@return CTakeDamageInfo
function DamageInfo() end

-- Writes text to the right hand side of the screen, like the old error system. Messages disappear after a couple of seconds.
---@param slot number The location on the right hand screen to write the debug info to. Starts at 0, no upper limit
---@param info string The debugging information to be written to the screen
function DebugInfo(slot,info) end

-- This is not a function. This is a preprocessor keyword that translates to: ``` local BaseClass = baseclass.Get( "my_weapon" ) ``` If you type `DEFINE_BASECLASS( "my_weapon" )` in your script.  See baseclass.Get for more information. The preprocessor is not smart enough to know when substitution doesn't make sense, such as: table keys and strings.  Running `print("DEFINE_BASECLASS")` will result in `local BaseClass = baseclass.Get`
---@param value string Baseclass name
function DEFINE_BASECLASS(value) end

-- Deletes the given Preset.
---@param name string The name of the Preset to delete.
function DeleteAddonPreset(name) end

-- Loads and registers the specified gamemode, setting the GM table's DerivedFrom field to the value provided, if the table exists. The DerivedFrom field is used post-gamemode-load as the "derived" parameter for gamemode.Register.
---@param base string Gamemode name to derive from.
function DeriveGamemode(base) end

-- Creates a new derma animation.
---@param name string Name of the animation to create
---@param panel Panel Panel to run the animation on
---@param func? function Function to call to process the animation   Arguments: * Panel pnl - the panel passed to Derma_Anim * table anim - the anim table * number delta - the fraction of the progress through the animation * any data - optional data passed to the run metatable method
---@return table
function Derma_Anim(name,panel,func) end

-- Draws background blur around the given panel.
---@param panel Panel Panel to draw the background blur around
---@param startTime number Time that the blur began being painted
function Derma_DrawBackgroundBlur(panel,startTime) end

-- Creates panel method that calls the supplied Derma skin hook via derma.SkinHook
---@param panel Panel Panel to add the hook to
---@param functionName string Name of panel function to create
---@param hookName string Name of Derma skin hook to call within the function
---@param typeName string Type of element to call Derma skin hook for
function Derma_Hook(panel,functionName,hookName,typeName) end

-- Makes the panel (usually an input of sorts) respond to changes in console variables by adding next functions to the panel: * Panel:SetConVar * Panel:ConVarChanged * Panel:ConVarStringThink * Panel:ConVarNumberThink  The console variable value is saved in the `m_strConVar` property of the panel.  The panel should call Panel:ConVarStringThink or Panel:ConVarNumberThink in its PANEL:Think hook and should call Panel:ConVarChanged when the panel's value has changed.
---@param target Panel The panel the functions should be added to.
function Derma_Install_Convar_Functions(target) end

-- Creates a derma window to display information
---@param Text string The text within the created panel.
---@param Title string The title of the created panel.
---@param Button string The text of the button to close the panel.
---@return Panel
function Derma_Message(Text,Title,Button) end

-- Shows a message box in the middle of the screen, with up to 4 buttons they can press.
---@param text? string The message to display.
---@param title? string The title to give the message box.
---@param btn1text string The text to display on the first button.
---@param btn1func? function The function to run if the user clicks the first button.
---@param btn2text? string The text to display on the second button.
---@param btn2func? function The function to run if the user clicks the second button.
---@param btn3text? string The text to display on the third button
---@param btn3func? function The function to run if the user clicks the third button.
---@param btn4text? string The text to display on the fourth button
---@param btn4func? function The function to run if the user clicks the fourth button.
---@return Panel
function Derma_Query(text,title,btn1text,btn1func,btn2text,btn2func,btn3text,btn3func,btn4text,btn4func) end

-- Creates a derma window asking players to input a string.
---@param title string The title of the created panel.
---@param subtitle string The text above the input box
---@param default string The default text for the input box.
---@param confirm function The function to be called once the user has confirmed their input.
---@param cancel? function The function to be called once the user has cancelled their input
---@param confirmText? string Allows you to override text of the "OK" button
---@param cancelText? string Allows you to override text of the "Cancel" button
---@return Panel
function Derma_StringRequest(title,subtitle,default,confirm,cancel,confirmText,cancelText) end

-- Creates a DMenu and closes any current menus.
---@param keepOpen? boolean If we should keep other DMenus open (`true`) or not (`false`).
---@param parent? Panel The panel to parent the created menu to.
---@return Panel
function DermaMenu(keepOpen,parent) end

-- Sets whether rendering should be limited to being inside a panel or not.  See also Panel:NoClipping.
---@param disable boolean Whether or not clipping should be disabled
---@return boolean
function DisableClipping(disable) end

-- Cancels current DOF post-process effect started with Global.DOF_Start
function DOF_Kill() end

-- Cancels any existing DOF post-process effects. Begins the DOF post-process effect.
function DOF_Start() end

-- A hacky method used to fix some bugs regarding DoF. What this basically does it force all `C_BaseAnimating` entities to have the translucent Enums/RENDERGROUP, even if they use opaque or two-pass models.  
---@param enable boolean Enables or disables depth-of-field mode
function DOFModeHack(enable) end

-- Stops searching for new servers in the given category
---@param category string The category to stop searching in. **Working Values: internet, favorite, history, lan**
function DoStopServers(category) end

--  Draws the currently active main menu background image and handles transitioning between background images.  This is called by default in the menu panel's Paint hook.
function DrawBackground() end

-- Draws the bloom shader, which creates a glowing effect from bright objects.
---@param Darken number Determines how much to darken the effect. A lower number will make the glow come from lower light levels. A value of `1` will make the bloom effect unnoticeable. Negative values will make even pitch black areas glow.
---@param Multiply number Will affect how bright the glowing spots are. A value of `0` will make the bloom effect unnoticeable.
---@param SizeX number The size of the bloom effect along the horizontal axis.
---@param SizeY number The size of the bloom effect along the vertical axis.
---@param Passes number Determines how much to exaggerate the effect.
---@param ColorMultiply number Will multiply the colors of the glowing spots, making them more vivid.
---@param Red number How much red to multiply with the glowing color. Should be between `0` and `1`.
---@param Green number How much green to multiply with the glowing color. Should be between `0` and `1`.
---@param Blue number How much blue to multiply with the glowing color. Should be between `0` and `1`.
function DrawBloom(Darken,Multiply,SizeX,SizeY,Passes,ColorMultiply,Red,Green,Blue) end

-- Draws the Bokeh Depth Of Field effect .
---@param intensity number Intensity of the effect.
---@param distance number **Not worldspace distance**. Value range is from `0` to `1`.
---@param focus number Focus. Recommended values are from 0 to 12.
function DrawBokehDOF(intensity,distance,focus) end

-- Draws the Color Modify shader, which can be used to adjust colors on screen.
---@param modifyParameters table Color modification parameters. See Shaders/g_colourmodify and the example below. Note that if you leave out a field, it will retain its last value which may have changed if another caller uses this function.
function DrawColorModify(modifyParameters) end

-- Draws a material overlay on the screen.
---@param Material string This will be the material that is drawn onto the screen.
---@param RefractAmount number This will adjust how much the material will refract your screen.
function DrawMaterialOverlay(Material,RefractAmount) end

-- Creates a motion blur effect by drawing your screen multiple times.
---@param AddAlpha number How much alpha to change per frame.
---@param DrawAlpha number How much alpha the frames will have. A value of 0 will not render the motion blur effect.
---@param Delay number Determines the amount of time between frames to capture.
function DrawMotionBlur(AddAlpha,DrawAlpha,Delay) end

-- Draws the sharpen shader, which creates more contrast.
---@param Contrast number How much contrast to create.
---@param Distance number How large the contrast effect will be.
function DrawSharpen(Contrast,Distance) end

-- Draws the sobel shader, which detects edges and draws a black border.
---@param Threshold number Determines the threshold of edges. A value of `0` will make your screen completely black.
function DrawSobel(Threshold) end

-- Renders the post-processing effect of beams of light originating from the map's sun. Utilises the `pp/sunbeams` material.
---@param darken number `$darken` property for sunbeams material.
---@param multiplier number `$multiply` property for sunbeams material.
---@param sunSize number `$sunsize` property for sunbeams material.
---@param sunX number `$sunx` property for sunbeams material.
---@param sunY number `$suny` property for sunbeams material.
function DrawSunbeams(darken,multiplier,sunSize,sunX,sunY) end

-- Draws the texturize shader, which replaces each pixel on your screen with a different part of the texture depending on its brightness. See Shaders/g_texturize for information on making the texture.
---@param Scale number Scale of the texture. A smaller number creates a larger texture.
---@param BaseTexture number This will be the texture to use in the effect. Make sure you use Global.Material to get the texture number.
function DrawTexturize(Scale,BaseTexture) end

-- Draws the toy town shader, which blurs the top and bottom of your screen. This can make very large objects look like toys, hence the name.
---@param Passes number An integer determining how many times to draw the effect. A higher number creates more blur.
---@param Height number The amount of screen which should be blurred on the top and bottom.
function DrawToyTown(Passes,Height) end

-- Drops the specified entity if it is being held by any player with Gravity Gun or +use pickup.
---@param ent Entity The entity to drop.
function DropEntityIfHeld(ent) end

-- Calls all NetworkVarNotify functions of the given entity with the given new value, but doesn't change the real value. internally uses Entity:CallDTVarProxies
---@param entity Entity The Entity to run the NetworkVarNotify functions from.
---@param Type string The NetworkVar Type. * `String` * `Bool` * `Float` * `Int` (32-bit signed integer) * `Vector` * `Angle` * `Entity`
---@param index number The NetworkVar index.
---@param new_value any The new value.
function DTVar_ReceiveProxyGL(entity,Type,index,new_value) end

-- Creates or replaces a dynamic light with the given id.  Only 32 dlights and 64 elights can be active at once. It is not safe to hold a reference to this object after creation since its data can be replaced by another dlight at any time. The minlight parameter affects the world and entities differently.
---@param index number An unsigned Integer. Usually an Entity:EntIndex is used here.
---@param elight? boolean Allocates an elight instead of a dlight. Elights have a higher light limit and do not light the world (making the "noworld" parameter have no effect).
---@return table
function DynamicLight(index,elight) end

-- Creates a dynamic Material from the given materialPath This function should never be used in a Rendering Hook because it creates a new dynamic material every time and can fill up your vram.
---@param materialPath string The material with path. The path is relative to the `materials/` folder.
---@param flags? string Some bind of bits / byte. What does this argument do / use. Currently working value: "0100010" --nocull smooth
---@return IMaterial
function DynamicMaterial(materialPath,flags) end

-- Returns a CEffectData object to be used with util.Effect.  This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once.
---@return CEffectData
function EffectData() end

-- An [eagerly evaluated](https://en.wikipedia.org/wiki/Eager_evaluation) [ternary operator](https://en.wikipedia.org/wiki/%3F:), or, in layman's terms, a compact "if then else" statement.  In most cases, you should just use Lua's ["pseudo" ternary operator](https://en.wikipedia.org/wiki/%3F:#Lua), like this:  ``` local myCondition = true local consequent = "myCondition is true" local alternative = "myCondition is false"  print(myCondition and consequent or alternative) ```  In the above example, due to [short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation), `consequent` would be "skipped" and ignored (not evaluated) by Lua due to `myCondition` being `true`, and only `alternative` would be evaluated. However, when using `Either`, both `consequent` and `alternative` would be evaluated. A practical example of this can be found at the bottom of the page.  # Falsey values  If `consequent` is "falsey" (Lua considers both `false` and `nil` as false), this will not work. For example:  ``` local X = true local Y = false local Z = "myCondition is false"  print(X and Y or Z) ```  This will actually print the value of `Z`.  In the above case, and other very rare cases, you may find `Either` useful.
---@param condition any The condition to check if true or false.
---@param truevar any If the condition isn't nil/false, returns this value.
---@param falsevar any If the condition is nil/false, returns this value.
---@return any
function Either(condition,truevar,falsevar) end

-- Plays a sentence from `scripts/sentences.txt`
---@param soundName string The sound to play
---@param position Vector The position to play at
---@param entity number The entity to emit the sound from. Must be Entity:EntIndex
---@param channel? number The sound channel, see Enums/CHAN.
---@param volume? number The volume of the sound, from 0 to 1
---@param soundLevel? number The sound level of the sound, see Enums/SNDLVL
---@param soundFlags? number The flags of the sound, see Enums/SND
---@param pitch? number The pitch of the sound, 0-255
function EmitSentence(soundName,position,entity,channel,volume,soundLevel,soundFlags,pitch) end

-- Emits the specified sound at the specified position.  Sounds must be precached serverside manually before they can be played. util.PrecacheSound does not work for this purpose, Entity:EmitSound does the trick
---@param soundName string The sound to play  This should either be a sound script name (sound.Add) or a file path relative to the `sound/` folder. (Make note that it's not sound**s**)
---@param position Vector The position where the sound is meant to play, used only for a network  filter (`CPASAttenuationFilter`) to decide which players will hear the sound.
---@param entity number The entity to emit the sound from. Can be an Entity:EntIndex or one of the following: * `0` - Plays sound on the world (position set to `0,0,0`) * `-1` - Plays sound on the local player (on server acts as `0`) * `-2` - Plays UI sound (position set to `0,0,0`, no spatial sound, on server acts as `0`)
---@param channel? number The sound channel, see Enums/CHAN.
---@param volume? number The volume of the sound, from 0 to 1
---@param soundLevel? number The sound level of the sound, see Enums/SNDLVL
---@param soundFlags? number The flags of the sound, see Enums/SND
---@param pitch? number The pitch of the sound, 0-255
---@param dsp? number The DSP preset for this sound. [List of DSP presets](https://developer.valvesoftware.com/wiki/Dsp_presets)
function EmitSound(soundName,position,entity,channel,volume,soundLevel,soundFlags,pitch,dsp) end

-- Removes the currently active tool tip from the screen.
---@param panel Panel This is the panel that has a tool tip.
function EndTooltip(panel) end

-- Returns the entity with the matching Entity:EntIndex.  Indices `1` through game.MaxPlayers() are always reserved for players.  In examples on this wiki, `Entity( 1 )` is used when a player entity is needed (see ). In singleplayer and listen servers, `Entity( 1 )` will always be the first player. In dedicated servers, however, `Entity( 1 )` won't always be a valid player if there is no one currently on the server.
---@param entityIndex number The entity index.
---@return Entity
function Entity(entityIndex) end

-- Throws an error. This is currently an alias of Global.ErrorNoHalt despite it once throwing a halting error like Global.error(lowercase) without the stack trace appended.  This function throws a non-halting error instead of a halting error.
---@param ... any Converts all arguments to strings and prints them with no spacing or line breaks.
function Error(...) end

-- Throws a Lua error but does not break out of the current call stack. This function will not print a stack trace like a normal error would. Essentially similar if not equivalent to Global.Msg.
---@param ... any Converts all arguments to strings and prints them with no spacing.
function ErrorNoHalt(...) end

-- Throws a Lua error but does not break out of the current call stack.  This function will print a stack trace like a normal error would.
---@param ... any Converts all arguments to strings and prints them with no spacing.
function ErrorNoHaltWithStack(...) end

-- Returns the angles of the current render context as calculated by GM:CalcView.  This function is only reliable inside rendering hooks.
---@return Angle
function EyeAngles() end

-- Returns the origin of the current render context as calculated by GM:CalcView.  This function is only reliable inside rendering hooks.
---@return Vector
function EyePos() end

-- Returns the normal vector of the current render context as calculated by GM:CalcView, similar to Global.EyeAngles.  This function is only reliable inside rendering hooks.
---@return Vector
function EyeVector() end

-- Returns the meta table for the class with the matching name.  Internally returns debug.getregistry()[metaName]  You can learn more about meta tables on the Meta Tables page.  You can find a list of meta tables that can be retrieved with this function on Enums/TYPE. The name in the description is the string to use with this function.
---@param metaName string The object type to retrieve the meta table of.
---@return table
function FindMetaTable(metaName) end

-- Returns the tool-tip text and tool-tip-panel (if any) of the given panel as well as itself
---@param panel Panel Panel to find tool-tip of
---@return string
---@return Panel
---@return Panel
function FindTooltip(panel) end

-- Refreshes all Addon Conflicts and Fires a Problem. Internally uses Global.FireProblem
function FireAddonConflicts() end

-- Fires a Problem with the given Data.
---@param prob table The Problem table. See Structures/Problem
function FireProblem(prob) end

-- Internally uses Global.FireProblem to create / fire the Problem. This function is called from the engine to notify the player about a problem in a more user friendly way compared to a console message.
---@param id string The Problem ID.
---@param severity number The Problem severity.
---@param params string Additional Parameters.
function FireProblemFromEngine(id,severity,params) end

-- Formats the specified values into the string given. Same as string.format.
---@param format string The string to be formatted. Follows this format: http://www.cplusplus.com/reference/cstdio/printf/
---@param ... any Values to be formatted into the string.
---@return string
function Format(format,...) end

-- Returns the number of frames rendered since the game was launched.
function FrameNumber() end

-- Returns the Global.CurTime-based time in seconds it took to render the last frame.  This should be used for frame/tick based timing, such as movement prediction or animations.  For real-time-based frame time that isn't affected by host_timescale, use Global.RealFrameTime. RealFrameTime is more suited for things like GUIs or HUDs.
---@return number
function FrameTime() end

-- Callback function for when the client has joined a server. This function shows the server's loading URL by default.
---@param servername string Server's name.
---@param serverurl string Server's loading screen URL, or "" if the URL is not set.
---@param mapname string Server's current map's name.
---@param maxplayers number Max player count of server.
---@param steamid string The local player's Player:SteamID64.
---@param gamemode string Server's current gamemode's folder name.
function GameDetails(servername,serverurl,mapname,maxplayers,steamid,gamemode) end

-- This function adds all models from a specified folder to a custom Spawnlist category. Internally uses Global.AddPropsOfParent Using this function before SANDBOX:PopulateContent has been called will result in an error
---@param folder string the folder to search for models
---@param path string The path to look for the files and directories in. See File_Search_Paths for a list of valid paths.
---@param name string The Spawnmenu Category name
---@param icon? string The Spawnmenu Category Icon to use
---@param appid number The AppID which is needed for the Content
function GenerateSpawnlistFromPath(folder,path,name,icon,appid) end

-- Returns if the game was started with either -noaddons or -noworkshop
---@return boolean
---@return boolean
function GetAddonStatus() end

--  All dates are in [WDDX](https://www.php.net/manual/en/datetime.formats.compound.php) format  Gets miscellaneous information from Facepunches API.
---@param callback function Callback to be called when the API request is done.  Callback is called with one argument, a JSON which when converted into a table using util.JSONToTable contains the following: ```js { "ManifestVersion": 	number - Version of the manifest  "Date": 			string - Date in WDDX format  // Contains all the blog posts, the things in the top right of the menu "News": { "Blogs": [  // Structure of blog posts { "Date": 		string - Date in WDDX format of the post "ShortName": 	string - Short name of the post, identifier of it on the blog website "Title": 		string - Title of the post "HeaderImage": 	string - Main image of the post, showed in the top right "SummaryHtml": 	string - Summary of the blogpost, text thats shown "Url": 			string - URL to the post on the blog "Tags": 		string - String of the posts tag } ] }  // Array of Facepunches Mods, Admins and Devs "Administrators": [ { "UserId": 		string - SteamID64 of the person "Level": 		string - Level of the user (Administrator, Developer or Moderator) } ]  // Unused and contains nothing useful "Heroes": {}  "SentryUrl": 		string - Nothing "DatabaseUrl" 		string - URL to the Facepunch API (/database/{action}/) "FeedbackUrl" 		string - URL to the Facepunch API (/feedback/add/) "ReportUrl" 		string - URL to the Facepunch API (/feedback/report/) "LeaderboardUrl" 	string - URL to the Facepunch API (/leaderboard/{action}/) "BenchmarkUrl" 		string - URL to the Facepunch API (/benchmark/add/) "AccountUrl" 		string - URL to the Facepunch API (/account/{action}/)  "Servers": { "Official": [] // Nothing  // List of blacklisted servers "Banned": [ string 	- IP of the blacklisted server ] } } ```
function GetAPIManifest(callback) end

-- Gets the ConVar with the specified name.  This function uses Global.GetConVar_Internal internally, but caches the result in Lua for quicker lookups. Due to this function using Global.GetConVar_Internal internally it tends to be relatively slow. Please attempt to 'cache' the return of what you used to make it instead of using this function.  Example: ``` local exampleConvar = CreateClientConVar("exampleConvar", "hi")  print(exampleConvar:GetString()) ```  
---@param name string Name of the ConVar to get
---@return ConVar
function GetConVar(name) end

--  This function is very slow and not recommended. See Global.GetConVar for an example on how to properly store the return of what your using so you can avoid using this function as much as possible. Gets the ConVar with the specified name. This function doesn't cache the convar.
---@param name string Name of the ConVar to get
---@return ConVar
function GetConVar_Internal(name) end

-- Store the ConVar object retrieved with Global.GetConVar and call ConVar:GetInt or ConVar:GetFloat on it.Gets the numeric value ConVar with the specified name.
---@param name string Name of the ConVar to get.
---@return number
function GetConVarNumber(name) end

-- Store the ConVar object retrieved with Global.GetConVar and call ConVar:GetString on it.Gets the string value ConVar with the specified name.
---@param name string Name of the ConVar to get.
---@return string
function GetConVarString(name) end

-- Returns the default loading screen URL (asset://garrysmod/html/loading.html)
---@return string
function GetDefaultLoadingHTML() end

-- Retrieves data about the demo with the specified filename. Similar to Global.GetSaveFileDetails.
---@param filename string The file name of the demo.
---@return table
function GetDemoFileDetails(filename) end

-- Returns a table with the names of files needed from the server you are currently joining.
---@return table
function GetDownloadables() end

-- Returns an angle that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? Angle The value to return if the global value is not set.
---@return Angle
function GetGlobal2Angle(index,default) end

-- Returns a boolean that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? boolean The value to return if the global value is not set.
---@return boolean
function GetGlobal2Bool(index,default) end

-- Returns an entity that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? Entity The value to return if the global value is not set.
---@return Entity
function GetGlobal2Entity(index,default) end

-- Returns a float that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? number The value to return if the global value is not set.
---@return number
function GetGlobal2Float(index,default) end

-- Returns an integer that is shared between the server and all clients.  The integer has a 32 bit limit. Use Global.GetGlobalInt for a higher limit
---@param index string The unique index to identify the global value with.
---@param default? number The value to return if the global value is not set.
---@return number
function GetGlobal2Int(index,default) end

-- Returns a string that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default string The value to return if the global value is not set.
---@return string
function GetGlobal2String(index,default) end

-- Returns a value that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? any The value to return if the global value is not set.
---@return any
function GetGlobal2Var(index,default) end

-- Returns a vector that is shared between the server and all clients.
---@param Index string The unique index to identify the global value with.
---@param Default Vector The value to return if the global value is not set.
---@return Vector
function GetGlobal2Vector(Index,Default) end

-- Returns an angle that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? Angle The value to return if the global value is not set.
---@return Angle
function GetGlobalAngle(index,default) end

-- Returns a boolean that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? boolean The value to return if the global value is not set.
---@return boolean
function GetGlobalBool(index,default) end

-- Returns an entity that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? Entity The value to return if the global value is not set.
---@return Entity
function GetGlobalEntity(index,default) end

-- Returns a float that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? number The value to return if the global value is not set.
---@return number
function GetGlobalFloat(index,default) end

-- Returns an integer that is shared between the server and all clients.  This function will not round decimal values as it actually networks a float internally.
---@param index string The unique index to identify the global value with.
---@param default? number The value to return if the global value is not set.
---@return number
function GetGlobalInt(index,default) end

-- Returns a string that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default string The value to return if the global value is not set.
---@return string
function GetGlobalString(index,default) end

-- Returns a value that is shared between the server and all clients.
---@param index string The unique index to identify the global value with.
---@param default? any The value to return if the global value is not set.
---@return any
function GetGlobalVar(index,default) end

-- Returns a vector that is shared between the server and all clients.
---@param Index string The unique index to identify the global value with.
---@param Default Vector The value to return if the global value is not set.
---@return Vector
function GetGlobalVector(Index,Default) end

-- Returns the name of the current server.
---@return string
function GetHostName() end

-- Returns the panel that is used as a wrapper for the HUD. If you want your panel to be hidden when the main menu is opened, parent it to this. Child panels will also have their controls disabled.  See also vgui.GetWorldPanel
---@return Panel
function GetHUDPanel() end

-- Returns the loading screen panel and creates it if it doesn't exist.
---@return Panel
function GetLoadPanel() end

-- Returns the current status of the server join progress.
---@return string
function GetLoadStatus() end

-- Returns a table with the names of all maps and categories that you have on your client.
---@return table
function GetMapList() end

-- Returns the menu overlay panel, a container for panels like the error panel created in GM:OnLuaError.
---@return Panel
function GetOverlayPanel() end

--  Updates the PlayerList for the Currently Viewed Server. Internally uses serverlist.PlayerList to retrieve the PlayerList.
---@param serverip string The ServerIP to retrieve the PlayerList from.
function GetPlayerList(serverip) end

-- Returns the player whose movement commands are currently being processed. The player this returns can safely have Player:GetCurrentCommand() called on them. See Prediction.
---@return Player
function GetPredictionPlayer() end

-- Creates or gets the rendertarget with the given name.  See Global.GetRenderTargetEx for an advanced version of this function with more options.  This crashes when used on a cubemap texture.   Calling this function is equivalent to ```lua GetRenderTargetEx(name, width, height, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, bit.bor(2, 256), 0, IMAGE_FORMAT_BGRA8888 ) ``` 
---@param name string The internal name of the render target.
---@param width number The width of the render target, must be power of 2. If not set to PO2, the size will be automatically converted to the nearest PO2 size.
---@param height number The height of the render target, must be power of 2. If not set to PO2, the size will be automatically converted to the nearest PO2 size.
---@return ITexture
function GetRenderTarget(name,width,height) end

-- Gets (or creates if it does not exist) the rendertarget with the given name, this function allows to adjust the creation of a rendertarget more than Global.GetRenderTarget.  See also render.PushRenderTarget and render.SetRenderTarget.
---@param name string The internal name of the render target.  The name is treated like a path and gets its extension discarded."name.1" and "name.2" are considered the same name and will result in the same render target being reused.
---@param width number The width of the render target, must be power of 2.
---@param height number The height of the render target, must be power of 2.
---@param sizeMode number Bitflag that influences the sizing of the render target, see Enums/RT_SIZE.
---@param depthMode number Bitflag that determines the depth buffer usage of the render target Enums/MATERIAL_RT_DEPTH.
---@param textureFlags number Bitflag that configurates the texture, see Enums/TEXTUREFLAGS.  List of flags can also be found on the Valve's Developer Wiki: https://developer.valvesoftware.com/wiki/Valve_Texture_Format
---@param rtFlags number Flags that controll the HDR behaviour of the render target, see Enums/CREATERENDERTARGETFLAGS.
---@param imageFormat number Image format, see Enums/IMAGE_FORMAT. Some additional image formats are accepted, but don't have enums. See [VTF Enumerations.](https://developer.valvesoftware.com/wiki/Valve_Texture_Format#VTF_enumerations)
---@return ITexture
function GetRenderTargetEx(name,width,height,sizeMode,depthMode,textureFlags,rtFlags,imageFormat) end

-- Retrieves data about the save with the specified filename. Similar to Global.GetDemoFileDetails.
---@param filename string The file name of the save.
---@return table
function GetSaveFileDetails(filename) end

--  Starts Searching for Servers in the given Category. Can be stopped with Global.DoStopServers. Internally uses serverlist.Query to search for Servers.
---@param category string The Category to start searching the Servers in. **Working Values: internet, favorite, history, lan**
---@param id number Some ID. can be a random number?
function GetServers(category,id) end

-- Returns if the client is timing out, and time since last ping from the server. Similar to the server side Player:IsTimingOut.
---@return boolean
---@return number
function GetTimeoutInfo() end

-- Returns the entity the client is using to see from (such as the player itself, the camera, or another entity).
---@return Entity
function GetViewEntity() end

--  Opens the given URL in a HTML panel.
---@param url string The url to open.
function GMOD_OpenURLNoOverlay(url) end

-- Converts a color from [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV) into RGB color space and returns a Color.  The returned color will not have the color metatable.
---@param hue number The hue in degrees from 0-360.
---@param saturation number The saturation from 0-1.
---@param value number The lightness from 0-1.
---@return table
function HSLToColor(hue,saturation,value) end

-- Converts a color from [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV) into RGB color space and returns a Color.  The returned color will not have the color metatable.
---@param hue number The hue in degrees from 0-360.
---@param saturation number The saturation from 0-1.
---@param value number The value from 0-1.
---@return table
function HSVToColor(hue,saturation,value) end

-- Launches an asynchronous http request with the given parameters.  This cannot send or receive multiple headers with the same name.  HTTP-requests to destinations on private networks (such as `192.168.0.1`) won't work. To enable HTTP-requests to destinations on private networks use Command Line Parameters `-allowlocalhttp`.
---@param parameters table The request parameters. See Structures/HTTPRequest.
---@return boolean
function HTTP(parameters) end

-- To send the target file to the client simply call AddCSLuaFile() in the target file itself.  This function works exactly the same as Global.include both clientside and serverside.  The only difference is that on the serverside it also calls Global.AddCSLuaFile on the filename, so that it gets sent to the client.
---@param filename string The filename of the Lua file you want to include.
function IncludeCS(filename) end

-- Returns whether the given object does or doesn't have a `metatable` of a color.  Engine functions (i.e. those not written in plain Lua) that return color objects do not currently set the color metatable and this function will return false if you use it on them.
---@param Object any The object to be tested
---@return boolean
function IsColor(Object) end

-- Determines whether or not the provided console command will be blocked if it's ran through Lua functions, such as Global.RunConsoleCommand or Player:ConCommand.  For more info on blocked console commands, check out Blocked_ConCommands. 
---@param name string The console command to test.
---@return boolean
function IsConCommandBlocked(name) end

-- Returns if the given NPC class name is an enemy.  Returns true if the entity name is one of the following: * "npc_antlion" * "npc_antlionguard" * "npc_antlionguardian" * "npc_barnacle" * "npc_breen" * "npc_clawscanner" * "npc_combine_s" * "npc_cscanner" * "npc_fastzombie" * "npc_fastzombie_torso" * "npc_headcrab" * "npc_headcrab_fast" * "npc_headcrab_poison" * "npc_hunter" * "npc_metropolice" * "npc_manhack" * "npc_poisonzombie" * "npc_strider" * "npc_stalker" * "npc_zombie" * "npc_zombie_torso" * "npc_zombine"
---@param className string Class name of the entity to check
---@return boolean
function IsEnemyEntityName(className) end

-- Returns if the passed object is an Entity. Alias of Global.isentity.
---@param variable any The variable to check.
---@return boolean
function IsEntity(variable) end

-- Returns if this is the first time this hook was predicted.  This is useful for one-time logic in your SWEPs PrimaryAttack, SecondaryAttack and Reload and other  (to prevent those hooks from being called rapidly in succession). It's also useful in a Move hook for when the client predicts movement.  Visit Prediction for more information about this behavior.  This is already used internally for Entity:EmitSound, Weapon:SendWeaponAnim and Entity:FireBullets, but NOT in  util.Effect.
---@return boolean
function IsFirstTimePredicted() end

-- Returns if the given NPC class name is a friend.  Returns true if the entity name is one of the following: * "npc_alyx" * "npc_barney" * "npc_citizen" * "npc_dog" * "npc_eli" * "npc_fisherman" * "npc_gman" * "npc_kleiner" * "npc_magnusson" * "npc_monk" * "npc_mossman" * "npc_odessa" * "npc_vortigaunt"
---@param className string Class name of the entity to check
---@return boolean
function IsFriendEntityName(className) end

-- Returns true if the client is currently playing either a singleplayer or multiplayer game.
---@return boolean
function IsInGame() end

-- Returns true when the loading panel is active.
---@return boolean
function IsInLoading() end

-- Checks whether or not a game is currently mounted. Uses data given by engine.GetGames.
---@param game string The game string/app ID to check.
---@return boolean
function IsMounted(game) end

-- Checks if the given server data is blacklisted or not.
---@param address string Server ip. can end with *
---@param hostname string Server name
---@param description string description to check
---@param gm string Gamemode name
---@param map string Map name
---@return string
function IsServerBlacklisted(address,hostname,description,gm,map) end

-- Returns whether or not every element within a table is a valid entity
---@param table table Table containing entities to check
---@return boolean
function IsTableOfEntitiesValid(table) end

-- Returns whether or not a model is useless by checking that the file path is that of a proper model.  If the string ".mdl" is not found in the model name, the function will return true.  The function will also return true if any of the following strings are found in the given model name: * "_gesture" * "_anim" * "_gst" * "_pst" * "_shd" * "_ss" * "_posture" * "_anm" * "ghostanim" * "_paths" * "_shared" * "anim_" * "gestures_" * "shared_ragdoll_"
---@param modelName string The model name to be checked
---@return boolean
function IsUselessModel(modelName) end

-- Returns whether an object is valid or not. (Such as Entitys, Panels, custom table objects and more). Checks that an object is not nil, has an IsValid method and if this method returns true.  Due to vehicles being technically valid the moment they're spawned, also use Vehicle:IsValidVehicle to make sure they're fully initialized
---@param toBeValidated any The table or object to be validated.
---@return boolean
function IsValid(toBeValidated) end

-- Joins the server with the specified IP.
---@param IP string The IP of the server to join
function JoinServer(IP) end

-- Adds javascript function 'language.Update' to an HTML panel as a method to call Lua's language.GetPhrase function.
---@param htmlPanel Panel Panel to add javascript function 'language.Update' to.
function JS_Language(htmlPanel) end

-- Adds javascript function 'util.MotionSensorAvailable' to an HTML panel as a method to call Lua's motionsensor.IsAvailable function.
---@param htmlPanel Panel Panel to add javascript function 'util.MotionSensorAvailable' to.
function JS_Utility(htmlPanel) end

-- Adds workshop related javascript functions to an HTML panel, used by the "Dupes" and "Saves" tabs in the spawnmenu.
---@param htmlPanel Panel Panel to add javascript functions to.
function JS_Workshop(htmlPanel) end

-- Convenience function that creates a DLabel, sets the text, and returns it
---@param text string The string to set the label's text to
---@param parent? Panel Optional. The panel to parent the DLabel to
---@return Panel
function Label(text,parent) end

-- Callback function for when the client's language changes. Called by the engine.
---@param lang string The new language code.
function LanguageChanged(lang) end

-- Performs a linear interpolation from the start number to the end number.  This function provides a very efficient and easy way to smooth out movements. This function is not meant to be used with constant value in the first argument, if you're dealing with animation! Use a value that changes over time. See example for **proper** usage of Lerp for animations.
---@param t number The fraction for finding the result. This number is clamped between 0 and 1. Shouldn't be a constant.
---@param from number The starting number. The result will be equal to this if delta is 0.
---@param to number The ending number. The result will be equal to this if delta is 1.
---@return number
function Lerp(t,from,to) end

-- Returns point between first and second angle using given fraction and linear interpolation This function is not meant to be used with constant value in the first argument, if you're dealing with animation! Use a value that changes over time
---@param ratio number Ratio of progress through values
---@param angleStart Angle Angle to begin from
---@param angleEnd Angle Angle to end at
---@return Angle
function LerpAngle(ratio,angleStart,angleEnd) end

-- Linear interpolation between two vectors. It is commonly used to smooth movement between two vectors This function is not meant to be used with constant value in the first argument, if you're dealing with animation! Use a value that changes over time
---@param fraction number Fraction ranging from 0 to 1
---@param from Vector The initial Vector
---@param to Vector The desired Vector
---@return Vector
function LerpVector(fraction,from,to) end

--  Loads all Addon Presets and updates the Preset list.
function ListAddonPresets() end

-- Returns the contents of `addonpresets.txt` located in the `garrysmod/settings` folder. By default, this file stores your addon presets as JSON.  You can use Global.SaveAddonPresets to modify this file.
---@return string
function LoadAddonPresets() end

-- This function is used to get the last map and category to which the map belongs from the cookie saved with Global.SaveLastMap.
function LoadLastMap() end

--  Updates the News List
function LoadNewsList() end

-- Loads all preset settings for the presets and returns them in a table
---@return table
function LoadPresets() end

-- Returns a localisation for the given token, if none is found it will return the default (second) parameter.
---@param localisationToken string The token to find a translation for.
---@param default string The default value to be returned if no translation was found.
function Localize(localisationToken,default) end

-- Returns the player object of the current client.  LocalPlayer() will return NULL until all entities have been initialized. See GM:InitPostEntity.
---@return Player
function LocalPlayer() end

-- Translates the specified position and angle from the specified local coordinate system into worldspace coordinates.  If you're working with an entity's local vectors, use Entity:LocalToWorld and/or Entity:LocalToWorldAngles instead.  See also: Global.WorldToLocal, the reverse of this function.
---@param localPos Vector The position vector in the source coordinate system, that should be translated to world coordinates
---@param localAng Angle The angle in the source coordinate system, that should be converted to a world angle. If you don't need to convert an angle, you can supply an arbitrary valid angle (e.g. Global.Angle()).
---@param originPos Vector The origin point of the source coordinate system, in world coordinates
---@param originAngle Angle The angles of the source coordinate system, as a world angle
---@return Vector
---@return Angle
function LocalToWorld(localPos,localAng,originPos,originAngle) end

-- Either returns the material with the given name, or loads the material interpreting the first argument as the path.  When using .png or .jpg textures, try to make their sizes Power Of 2 (1, 2, 4, 8, 16, 32, 64, etc). While images are no longer scaled to Power of 2 sizes since February 2019, it is a good practice for things like icons, etc. This function is very expensive when used in rendering hooks or in operations requiring very frequent calls. It is better to store the Material in a variable (like in the examples).
---@param materialName string The material name or path. The path is relative to the `materials/` folder. You do not need to add `materials/` to your path.  To retrieve a Lua material created with Global.CreateMaterial, just prepend a `!` to the material name.  Since paths are relative to the materials folder, resource paths like ../data/MyImage.jpg will work since `..` translates to moving up a parent directory in the file tree..
---@param pngParameters? string A string containing space separated keywords which will be used to add material parameters.  See Material Parameters for more information.  This feature only works when importing .png or .jpeg image files.
---@return IMaterial
---@return number
function Material(materialName,pngParameters) end

-- Returns a VMatrix object, a 4x4 matrix.
---@param data? table Initial data to initialize the matrix with. Leave empty to initialize an identity matrix. See examples for usage.  Can be a VMatrix to copy its data.
---@return VMatrix
function Matrix(data) end

-- Internally uses steamworks.FileInfo to fetch the data. This function retrieves the Addon data and passes it onto JS(JavaScript)
---@param workshopItemID string The ID of Steam Workshop item.
function MenuGetAddonData(workshopItemID) end

-- Returns a new mesh object.
---@param mat? IMaterial The material the mesh is intended to be rendered with. It's merely a hint that tells that mesh what vertex format it should use.
---@return IMesh
function Mesh(mat) end

-- Runs util.PrecacheModel and returns the string.
---@param model string The model to precache.
---@return string
function Model(model) end

-- Writes every given argument to the console.  Automatically attempts to convert each argument to a string. (See Global.tostring)  Unlike Global.print, arguments are not separated by anything. They are simply concatenated.  Additionally, a newline isn't added automatically to the end, so subsequent Msg or print operations will continue the same line of text in the console. See Global.MsgN for a version that does add a newline.  The text is blue on the server, orange on the client, and green on the menu: 
---@param ... any List of values to print.
function Msg(...) end

-- Works exactly like Global.Msg except that, if called on the server, will print to all players consoles plus the server console.
---@param ... any List of values to print.
function MsgAll(...) end

-- Just like Global.Msg, except it can also print colored text, just like chat.AddText.
---@param ... any Values to print. If you put in a color, all text after that color will be printed in that color.
function MsgC(...) end

-- Same as Global.print, except it concatinates the arguments without inserting any whitespace in between them.  See also Global.Msg, which doesn't add a newline (`"\n"`) at the end.
---@param ... any List of values to print. They can be of any type and will be converted to strings with Global.tostring.
function MsgN(...) end

-- Returns named color defined in resource/ClientScheme.res.
---@param name string Name of color
---@return table
function NamedColor(name) end

-- Returns the number of files needed from the server you are currently joining.
---@return number
function NumDownloadables() end

-- Returns the amount of skins the specified model has.  See also Entity:SkinCount if you have an entity.
---@param modelName string Model to return amount of skins of
---@return number
function NumModelSkins(modelName) end

--  Called by the engine when a model has been loaded. Caches model information with the sql.
---@param modelName string Name of the model.
---@param numPostParams number Number of pose parameters the model has.
---@param numSeq number Number of sequences the model has.
---@param numAttachments number Number of attachments the model has.
---@param numBoneControllers number Number of bone controllers the model has.
---@param numSkins number Number of skins that the model has.
---@param size number Size of the model.
function OnModelLoaded(modelName,numPostParams,numSeq,numAttachments,numBoneControllers,numSkins,size) end

-- Opens a folder with the given name in the garrysmod folder using the operating system's file browser.  This does not work on OSX or Linux.
---@param folder string The subdirectory to open in the garrysmod folder.
function OpenFolder(folder) end

-- Opens the Problems Panel.
function OpenProblemsPanel() end

-- Modifies the given vectors so that all of vector2's axis are larger than vector1's by switching them around. Also known as ordering vectors.  This function will irreversibly modify the given vectors
---@param vector1 Vector Bounding box min resultant
---@param vector2 Vector Bounding box max resultant
function OrderVectors(vector1,vector2) end

-- Calls game.AddParticles and returns given string.
---@param file string The particle file.
---@return string
function Particle(file) end

-- Creates a particle effect.  The particle effect must be precached with Global.PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
---@param particleName string The name of the particle effect.
---@param position Vector The start position of the effect.
---@param angles Angle The orientation of the effect.
---@param parent? Entity If set, the particle will be parented to the entity.
function ParticleEffect(particleName,position,angles,parent) end

-- Creates a particle effect with specialized parameters.  The particle effect must be precached with Global.PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
---@param particleName string The name of the particle effect.
---@param attachType number Attachment type using Enums/PATTACH.
---@param entity Entity The entity to be used in the way specified by the attachType.
---@param attachmentID number The id of the attachment to be used in the way specified by the attachType.
function ParticleEffectAttach(particleName,attachType,entity,attachmentID) end

-- Creates a new CLuaEmitter.  Do not forget to delete the emitter with CLuaEmitter:Finish once you are done with it
---@param position Vector The start position of the emitter.  This is only used to determine particle drawing order for translucent particles.
---@param use3D boolean Whenever to render the particles in 2D or 3D mode.
---@return CLuaEmitter
function ParticleEmitter(position,use3D) end

-- Creates a path for the bot to follow
---@param type string The name of the path to create. This is going to be "Follow" or "Chase" right now.
---@return PathFollower
function Path(type) end

-- Returns the player with the matching Player:UserID.  For a function that returns a player based on their Entity:EntIndex, see Global.Entity.   For a function that returns a player based on their connection ID, see player.GetByID.
---@param playerIndex number The player index.
---@return Player
function Player(playerIndex) end

-- Moves the given model to the given position and calculates appropriate camera parameters for rendering the model to an icon.  The output table interacts nicely with Panel:RebuildSpawnIconEx with a few key renames.
---@param model Entity Model that is being rendered to the spawn icon
---@param position Vector Position that the model is being rendered at
---@param noAngles boolean If true the function won't reset the angles to 0 for the model.
---@return table
function PositionSpawnIcon(model,position,noAngles) end

-- Precaches the particle with the specified name.
---@param particleSystemName string The name of the particle system.
function PrecacheParticleSystem(particleSystemName) end

-- Precaches a scene file.
---@param scene string Path to the scene file to precache.
function PrecacheScene(scene) end

-- Load and precache a custom sentence file.
---@param filename string The path to the custom sentences.txt.
function PrecacheSentenceFile(filename) end

-- Precache a sentence group in a sentences.txt definition file.
---@param group string The group to precache.
function PrecacheSentenceGroup(group) end

-- Displays a message in the chat, console, or center of screen of every player.  This uses the archaic user message system (umsg) and hence is limited to ≈250 characters.
---@param type number Which type of message should be sent to the players (see Enums/HUD)
---@param message string Message to be sent to the players
function PrintMessage(type,message) end

-- Recursively prints the contents of a table to the console.
---@param tableToPrint table The table to be printed
---@param indent? number Number of tabs to start indenting at. Increases by 2 when entering another table.
---@param done? table Internal argument, you shouldn't normally change this. Used to check if a nested table has already been printed so it doesn't get caught in a loop.
function PrintTable(tableToPrint,indent,done) end

-- Creates a new ProjectedTexture.
---@return ProjectedTexture
function ProjectedTexture() end

-- Runs a function without stopping the whole script on error.  This function is similar to Global.pcall and Global.xpcall except the errors are still printed and sent to the error handler (i.e. sent to server console if clientside and GM:OnLuaError called).
---@param func function Function to run
---@return boolean
function ProtectedCall(func) end

-- Returns an iterator function that can be used to loop through a table in random order
---@param table table Table to create iterator for
---@param descending boolean Whether the iterator should iterate descending or not
---@return function
function RandomPairs(table,descending) end

-- Returns the real frame-time which is unaffected by host_timescale. To be used for GUI effects (for example)
---@return number
function RealFrameTime() end

-- Returns the uptime of the game/server in seconds (to at least **4** decimal places). This value updates itself once every time the realm thinks. For servers, this is the server tickrate. For clients, its their current FPS.  This is **not** synchronised or affected by the game.  This will be affected by precision loss if the uptime is more than 30+(?) days, and effectively cease to be functional after 50+(?) days.  Changing the map will **not** fix it like it does with Global.CurTime. A server restart is necessary.  You should use this function (or Global.SysTime) for timing real-world events such as user interaction, but not for timing game events such as animations.  See also: Global.CurTime, Global.SysTime
---@return number
function RealTime() end

-- Creates a new CRecipientFilter.
---@param unreliable? boolean If set to true, makes the filter unreliable.  This means, when sending over the network in cases like Global.CreateSound (and its subsequent updates), the message is not guaranteed to reach all clients.
---@return CRecipientFilter
function RecipientFilter(unreliable) end

--  Adds a frame to the currently recording demo.
function RecordDemoFrame() end

-- Refreshes all Addon Conflicts after 1 Second. Internally uses Global.FireAddonConflicts
function RefreshAddonConflicts() end

-- Registers a Derma element to be closed the next time Global.CloseDermaMenus is called
---@param menu Panel Menu to be registered for closure
function RegisterDermaMenuForClose(menu) end

-- Saves position of your cursor on screen. You can restore it by using Global.RestoreCursorPosition.
function RememberCursorPosition() end

-- Does the removing of the tooltip panel. Called by Global.EndTooltip.
function RemoveTooltip() end

-- Returns the angle that the clients view is being rendered at
---@return Angle
function RenderAngles() end

-- Renders a Depth of Field effect
---@param origin Vector Origin to render the effect at
---@param angle Angle Angle to render the effect at
---@param usableFocusPoint Vector Point to focus the effect at
---@param angleSize number Angle size of the effect
---@param radialSteps number Amount of radial steps to render the effect with
---@param passes number Amount of render passes
---@param spin boolean Whether to cycle the frame or not
---@param inView table Table of view data
---@param fov number FOV to render the effect with
function RenderDoF(origin,angle,usableFocusPoint,angleSize,radialSteps,passes,spin,inView,fov) end

-- Renders the stereoscopic post-process effect
---@param viewOrigin Vector Origin to render the effect at
---@param viewAngles Angle Angles to render the effect at
function RenderStereoscopy(viewOrigin,viewAngles) end

-- Renders the Super Depth of Field post-process effect
---@param viewOrigin Vector Origin to render the effect at
---@param viewAngles Angle Angles to render the effect at
---@param viewFOV number Field of View to render the effect at
function RenderSuperDoF(viewOrigin,viewAngles,viewFOV) end

-- Called by permissions.AskToConnect If the server has the permission "connect" granted, it will instantly connect you to the server. If the permission is not granted it will, it opens a confirmation window to connect to the server. 
---@param serverip string The server ip to connect to
function RequestConnectToServer(serverip) end

--  Opens a confirmation window to open the url. 
---@param url string The Website URL to open.
function RequestOpenURL(url) end

--  Opens a confirmation window to grant the requested permission. 
---@param permission string The permission to ask
function RequestPermission(permission) end

-- Restores position of your cursor on screen. You can save it by using Global.RememberCursorPosition.
function RestoreCursorPosition() end

-- Executes the given console command with the parameters.  Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see Blocked ConCommands.
---@param command string The command to be executed.
---@param ... any The arguments. Note, that unlike Player:ConCommand, you must pass each argument as a new string, not separating them with a space.
function RunConsoleCommand(command,...) end

-- Runs a menu command. Equivalent to Global.RunConsoleCommand( "gamemenucommand", command ) unless the command starts with the "engine" keyword in which case it is equivalent to Global.RunConsoleCommand( command ).
---@param command string The menu command to run  Should be one of the following: * Disconnect - Disconnects from the current server. * OpenBenchmarkDialog - Opens the "Video Hardware Stress Test" dialog. * OpenChangeGameDialog - Does not work in GMod. * OpenCreateMultiplayerGameDialog - Opens the Source dialog for creating a listen server. * OpenCustomMapsDialog - Does nothing. * OpenFriendsDialog - Does nothing. * OpenGameMenu - Does not work in GMod. * OpenLoadCommentaryDialog - Opens the "Developer Commentary" selection dialog. Useless in GMod. * OpenLoadDemoDialog - Does nothing. * OpenLoadGameDialog - Opens the Source "Load Game" dialog. * OpenNewGameDialog - Opens the "New Game" dialog. Useless in GMod. * OpenOptionsDialog - Opens the options dialog. * OpenPlayerListDialog - Opens the "Mute Players" dialog that shows all players connected to the server and allows to mute them. * OpenSaveGameDialog - Opens the Source "Save Game" dialog. * OpenServerBrowser - Opens the legacy server browser. * Quit - Quits the game `without` confirmation (unlike other Source games). * QuitNoConfirm - Quits the game without confirmation (like other Source games). * ResumeGame - Closes the menu and returns to the game. * engine  - Runs a console command. Unlike Global.RunConsoleCommand(  ) It will ignore Blocked ConCommands
function RunGameUICommand(command) end

-- Evaluates and executes the given code, will throw an error on failure. Local variables are not passed to the given code.
---@param code string The code to execute.
---@param identifier? string The name that should appear in any error messages caused by this code.
---@param handleError? boolean If false, this function will return a string containing any error messages instead of throwing an error.
---@return string
function RunString(code,identifier,handleError) end

-- Alias of Global.RunString.  Use Global.RunString instead.
function RunStringEx() end

-- Removes the given entity unless it is a player or the world entity
---@param ent Entity Entity to safely remove.
function SafeRemoveEntity(ent) end

-- Removes entity after delay using Global.SafeRemoveEntity
---@param entity Entity Entity to be removed
---@param delay number Delay for entity removal in seconds
function SafeRemoveEntityDelayed(entity,delay) end

-- Sets the content of `addonpresets.txt` located in the `garrysmod/settings` folder. By default, this file stores your addon presets as JSON.  You can use Global.LoadAddonPresets to retrieve the data in this file.
---@param JSON string The new contents of the file.
function SaveAddonPresets(JSON) end

--  Hides the News List when set to true. If you call this don't forget to call Global.LoadNewsList to update the News List.
---@param hide boolean true if it should hide the News.
function SaveHideNews(hide) end

--  This function is used to save the last map and category to which the map belongs as a .
---@param map string The name of the map.
---@param category string The name of the category to which this map belongs.
function SaveLastMap(map,category) end

-- Overwrites all presets with the supplied table. Used by the presets for preset saving
---@param presets table Presets to be saved
function SavePresets(presets) end

-- Returns a number based on the Size argument and your screen's width. The screen's width is always equal to size 640. This function is primarily used for scaling font sizes.
---@param Size number The number you want to scale.
---@return number
function ScreenScale(Size) end

-- Gets the height of the game's window (in pixels).
---@return number
function ScrH() end

-- Gets the width of the game's window (in pixels).
---@return number
function ScrW() end

-- This uses the umsg internally, which has been deprecated. Use the net instead. Send a usermessage Useless on client, only server can send info to client.
---@param name string The name of the usermessage
---@param recipients any Can be a CRecipientFilter, table or Player object.
---@param ... any Data to send in the usermessage
function SendUserMessage(name,recipients,...) end

-- Returns approximate duration of a sentence by name. See Global.EmitSentence.
---@param name string The sentence name.
---@return number
function SentenceDuration(name) end

-- Prints `ServerLog: PARAM` without a newline, to the server log and console.  As of June 2022, if `sv_logecho` is set to `0` (defaults to `1`) the message will not print to console and will only be written to the server's log file.
---@param parameter string The value to be printed to console.
function ServerLog(parameter) end

-- Adds the given string to the computers clipboard, which can then be pasted in or outside of GMod with Ctrl + V.
---@param text string The text to add to the clipboard.
function SetClipboardText(text) end

-- Defines an angle to be automatically networked to clients  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global angle with
---@param angle Angle Angle to be networked
function SetGlobal2Angle(index,angle) end

-- Defined a boolean to be automatically networked to clients  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global boolean with
---@param bool boolean Boolean to be networked
function SetGlobal2Bool(index,bool) end

-- Defines an entity to be automatically networked to clients  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global entity with
---@param ent Entity Entity to be networked
function SetGlobal2Entity(index,ent) end

-- Defines a floating point number to be automatically networked to clients  This function has a floating point precision error. Use Global.SetGlobalFloat instead Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global float with
---@param float number Float to be networked
function SetGlobal2Float(index,float) end

-- Sets an integer that is shared between the server and all clients. The integer has a 32 bit limit. Use Global.SetGlobalInt instead Running this function clientside will only set it clientside for the client it is called on!
---@param index string The unique index to identify the global value with.
---@param value number The value to set the global value to
function SetGlobal2Int(index,value) end

-- Defines a string with a maximum of 511 characters to be automatically networked to clients  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global string with
---@param string string String to be networked
function SetGlobal2String(index,string) end

-- Defines a variable to be automatically networked to clients   | Allowed Types   | | --------------- | | Angle           | | Boolean         | | Entity          | | Float           | | Int             | | String          | | Vector          | Trying to network a type that is not listed above will result in a nil value! Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global vector with
---@param value any Value to be networked
function SetGlobal2Var(index,value) end

-- Defines a vector to be automatically networked to clients  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global vector with
---@param vec Vector Vector to be networked
function SetGlobal2Vector(index,vec) end

-- Defines an angle to be automatically networked to clients  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Angle. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global angle with
---@param angle Angle Angle to be networked
function SetGlobalAngle(index,angle) end

-- Defined a boolean to be automatically networked to clients  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Bool. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global boolean with
---@param bool boolean Boolean to be networked
function SetGlobalBool(index,bool) end

-- Defines an entity to be automatically networked to clients  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Entity. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global entity with
---@param ent Entity Entity to be networked
function SetGlobalEntity(index,ent) end

-- Defines a floating point number to be automatically networked to clients  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Float. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global float with
---@param float number Float to be networked
function SetGlobalFloat(index,float) end

-- Sets an integer that is shared between the server and all clients.  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Int. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on! This function will not round decimal values as it actually networks a float internally.
---@param index string The unique index to identify the global value with.
---@param value number The value to set the global value to
function SetGlobalInt(index,value) end

-- Defines a string with a maximum of 199 characters to be automatically networked to clients  There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2String. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage If you want to have a higher characters limit use Global.SetGlobal2String Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global string with
---@param string string String to be networked
function SetGlobalString(index,string) end

-- Defines a variable to be automatically networked to clients   | Allowed Types   | | --------------- | | Angle           | | Boolean         | | Entity          | | Float           | | Int             | | String          | | Vector          | Trying to network a type that is not listed above will result in an error! There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Var. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage  Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global vector with
---@param value any Value to be networked
function SetGlobalVar(index,value) end

-- Defines a vector to be automatically networked to clients There's a 4095 slots Network limit. If you need more, consider using the net library or Global.SetGlobal2Vector. You should also consider the fact that you have way too many variables. You can learn more about this limit here: Networking_Usage Running this function clientside will only set it clientside for the client it is called on!
---@param index any Index to identify the global vector with
---@param vec Vector Vector to be networked
function SetGlobalVector(index,vec) end

-- Called by the engine to set which [constraint system](https://developer.valvesoftware.com/wiki/Phys_constraintsystem) the next created constraints should use.
---@param constraintSystem Entity Constraint system to use
function SetPhysConstraintSystem(constraintSystem) end

-- This function can be used in a for loop instead of Global.pairs. It sorts all **keys** alphabetically.  For sorting by specific **value member**, use Global.SortedPairsByMemberValue.   For sorting by **value**, use Global.SortedPairsByValue.
---@param table table The table to sort
---@param desc? boolean Reverse the sorting order
---@return function
---@return table
function SortedPairs(table,desc) end

-- Returns an iterator function that can be used to loop through a table in order of member values, when the values of the table are also tables and contain that member.  To sort by **value**, use Global.SortedPairsByValue.   To sort by **keys**, use Global.SortedPairs.
---@param table table Table to create iterator for.
---@param memberKey any Key of the value member to sort by.
---@param descending? boolean Whether the iterator should iterate in descending order or not.
---@return function
---@return table
function SortedPairsByMemberValue(table,memberKey,descending) end

-- Returns an iterator function that can be used to loop through a table in order of its **values**.  To sort by specific **value member**, use Global.SortedPairsByMemberValue.   To sort by **keys**, use Global.SortedPairs.
---@param table table Table to create iterator for
---@param descending? boolean Whether the iterator should iterate in descending order or not
---@return function
---@return table
function SortedPairsByValue(table,descending) end

-- Runs util.PrecacheSound and returns the string.  util.PrecacheSound does nothing and therefore so does this function.
---@param soundPath string The soundpath to precache.
---@return string
function Sound(soundPath) end

-- Returns the duration of the specified sound in seconds.  This function does not return the correct duration on MacOS and Linux, or if the file is a non-.wav file on Windows.
---@param soundName string The sound file path.
---@return number
function SoundDuration(soundName) end

-- Returns the input value in an escaped form so that it can safely be used inside of queries. The returned value is surrounded by quotes unless noQuotes is true. Alias of sql.SQLStr
---@param input string String to be escaped
---@param noQuotes? boolean Whether the returned value should be surrounded in quotes or not
---@return string
function SQLStr(input,noQuotes) end

-- You should be using Global.ScreenScale instead.  Returns a number based on the Size argument and your screen's width. Alias of Global.ScreenScale.
---@param Size number The number you want to scale.
function SScale(Size) end

-- Returns the ordinal suffix of a given number.
---@param number number The number to find the ordinal suffix of.
---@return string
function STNDRD(number) end

-- Suppress any networking from the server to the specified player. This is automatically called by the engine before/after a player fires their weapon, reloads, or causes any other similar shared-predicted event to occur.
---@param suppressPlayer Player The player to suppress any networking to.
function SuppressHostEvents(suppressPlayer) end

-- Returns a highly accurate time in seconds since the start up, ideal for benchmarking. Unlike Global.RealTime, this value will be updated any time the function is called, allowing for sub-think precision.
---@return number
function SysTime() end

-- Returns a TauntCamera object
---@return table
function TauntCamera() end

-- Clears focus from any text entries player may have focused.
function TextEntryLoseFocus() end

-- Returns a cosine value that fluctuates based on the current time
---@param frequency number The frequency of fluctuation
---@param min number Minimum value
---@param max number Maximum value
---@param offset number Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
---@return number
function TimedCos(frequency,min,max,offset) end

-- Returns a sine value that fluctuates based on Global.CurTime. The value returned will be between the start value plus/minus the range value.  The range arguments don't work as intended. The existing (bugged) behavior is documented below.
---@param frequency number The frequency of fluctuation, in
---@param origin number The center value of the sine wave.
---@param max number This argument's distance from origin defines the size of the full range of the sine wave. For example, if origin is 3 and max is 5, then the full range of the sine wave is 5-3 = 2. 3 is the center point of the sine wave, so the sine wave will range between 2 and 4.
---@param offset number Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
---@return number
function TimedSin(frequency,origin,max,offset) end

-- Toggles whether or not the named map is favorited in the new game list.
---@param map string Map to toggle favorite.
function ToggleFavourite(map) end

--   Returns "Lua Cache File" if the given file name is in a certain string table, nothing otherwise.
---@param filename string File name to test
---@return string
function TranslateDownloadableName(filename) end

-- Gets the associated type ID of the variable. Unlike Global.type, this does not work with no value - an argument must be provided.  This returns garbage for _LOADLIB objects. This returns TYPE_NIL for protos.
---@param variable any The variable to get the type ID of.
---@return number
function TypeID(variable) end

-- Returns the current asynchronous in-game time.
---@return number
function UnPredictedCurTime() end

--  This function retrieves the values from Global.GetAddonStatus and passes them to JS(JavaScript).
function UpdateAddonDisabledState() end

--  This function is called by Global.UpdateMapList to pass the AddonMaps to JS to be used for the Search.
function UpdateAddonMapList() end

--  Updates the Gamelist.
function UpdateGames() end

--  This function searches for all available languages and passes them to JS(JavaScript). JS then updates the Language list with the given languages.
function UpdateLanguages() end

-- Runs JavaScript on the loading screen panel (Global.GetLoadPanel).
---@param javascript string JavaScript to run on the loading panel.
function UpdateLoadPanel(javascript) end

-- Called from JS when starting a new game This function updates the Map List
function UpdateMapList() end

-- Called from JS when starting a new game Updates the Server Settings when called.
function UpdateServerSettings() end

--  Updates the Addons list.
function UpdateSubscribedAddons() end

-- You should use Global.IsUselessModel instead.  Returns whether or not a model is useless by checking that the file path is that of a proper model.  If the string ".mdl" is not found in the model name, the function will return true.  The function will also return true if any of the following strings are found in the given model name: * "_gesture" * "_anim" * "_gst" * "_pst" * "_shd" * "_ss" * "_posture" * "_anm" * "ghostanim" * "_paths" * "_shared" * "anim_" * "gestures_" * "shared_ragdoll_"
---@param modelName string The model name to be checked
---@return boolean
function UTIL_IsUselessModel(modelName) end

-- You should use Global.IsValid instead  Returns if a panel is safe to use.
---@param panel Panel The panel to validate.
function ValidPanel(panel) end

-- Creates a Vector object. This function is very expensive when used in often running hooks or in operations requiring very frequent calls (like loops for example). It is better to store the vector in a variable or to use the [default vectors](https://wiki.facepunch.com/gmod/Global_Variables#misc) available.
---@param x? number The x component of the vector.   If this is a Vector, this function will return a copy of the given vector.   If this is a string, this function will try to parse the string as a vector. If it fails, it returns a 0 vector. (See examples)
---@param y? number The y component of the vector.
---@param z? number The z component of the vector.
---@return Vector
function Vector(x,y,z) end

-- Returns a random vector whose components are each between min(inclusive), max(exclusive).
---@param min? number Min bound inclusive.
---@param max? number Max bound exclusive.
---@return Vector
function VectorRand(min,max) end

-- Returns the time in seconds it took to render the VGUI.
function VGUIFrameTime() end

-- Creates and returns a DShape rectangle GUI element with the given dimensions.
---@param x number X position of the created element
---@param y number Y position of the created element
---@param w number Width of the created element
---@param h number Height of the created element
---@return Panel
function VGUIRect(x,y,w,h) end

-- Used by the **vgui_visualizelayout** convar Briefly displays layout details of the given panel on-screen
---@param panel Panel Panel to display layout details of
function VisualizeLayout(panel) end

-- Returns a new WorkshopFileBase element
---@param namespace string Namespace for the file base
---@param requiredTags table Tags required for a Workshop submission to be interacted with by the filebase
---@return table
function WorkshopFileBase(namespace,requiredTags) end

-- Translates the specified position and angle into the specified coordinate system.
---@param position Vector The position that should be translated from the current to the new system.
---@param angle Angle The angles that should be translated from the current to the new system.
---@param newSystemOrigin Vector The origin of the system to translate to.
---@param newSystemAngles Angle The angles of the system to translate to.
---@return Vector
---@return Angle
function WorldToLocal(position,angle,newSystemOrigin,newSystemAngles) end



