# Photon 2
 Photon 2 for Garry's Mod

# Major Changes

## New Light Appearance, Types and Rendering Engine
While most lighting is similar in nature to Photon LE's rendering procedure, Photon 2 adds support for new types of lights, such as sub-materials and 3D meshes.

The classic light approach is now referred to as "2D lighting," which has been completely rewritten. The results provide lights with better color saturation, higher detail and better overall fidelity. 

Photon 2 also adds a new glow-effect technique, which allows for complex light shapes to have a more accurate blooming appearance by supplying a "shape" texture. While not as accurate as HDR blooming (used in Photon EX), it provides better performance and appearance when compared to using long chains of circular sprites.

## Component Input Channels
Photon 2 adopts the new system of Component behavior used in Photon S (the S&box version). This dramatically streamlines advanced component behavior, like lightbars that have a special braking pattern, or flash patterns that change based on the current siren tone. 

## Vehicles
### Equipment and Selection Options
* Continued support for adjustable equipment in the familiar Category -> Option -> Variant scheme.
* Directly define equipment in the `Selections` table instead of using just numeric indexes.
* Use alias names on equipment entries for easy reuse by other Options when necessary.
* Inherit an existing equipment entry and specify only overriding parameters.
* Support for both server and client side component addons to add physics or special networking functions when desired.

## Use on Almost Anything
Photon 2 now uses dedicated controller entities that can be attached to anything -- not just cars. This means support for things like traffic lights or scripted vehicle platforms.

# Creator Changes
## Responsive Saving and Refreshing
A major factor in the complete rewrite of Photon was the intent to reduce the number of vehicle respawns, server retries, and game restarts required when making content for Photon.

Current features include:
* Support for adding new Library files that are loaded and usable immediately while in-game.
* Instant equipment updates when saving a file. No more needing to delete and respawn a vehicle for every component you add.

## User Interfaces
Photon 2 is being designed with future UI implementations in mind, however it is not currently a major focus. For now, focus is being made on improving the code-first experience (as it is var more versatile and less time-consuming to modify).

# Advanced Development Changes

## Object Orientation
Photon 2 makes heavy use of metatables and custom inheritance to mimic traditional OOP designs. This makes it far more flexible for Photon asset creators and substantially improves interal operations and debugging.

## Annotations
Photon 2 is now documented using EmmyLua annotations. This provides intellisense, code validation (i.e. Lint), and static typing. 

When using VSCode, use Sumneko's Lua package to enable the annotation functionality. While it unfortunately cannot be used with any GLua plugins, I have generated annotation files scraped from the Garry's Mod Wiki (https://github.com/NullEnt1ty/gmod-wiki-scraper) as a stop-gap measure.

### Identifier Naming Conventions
* Prefix all _string_ identifiers with `Photon2:` (hooks, timers, network strings, etc.)

## Files
### Domain
Use sv_, sh_, and cl_ to designate domains. Aside from that, dashes should be used instead of underscores. (TODO)
The only Lua file in `lua/autorun` is the shared initialization file called `photon-v2_init.lua`. This file will automatically do `AddCSLuaFile()` on all client and shared files in `lua/photon-v2`. Moving code files out of `autorun` is important to control load order (more below) and enables the creation and execution of any new Lua files without restarting the game.

To ensure code initializes in the correct order (and avoid an aborted setup), a corresponding `include()` call should be inserted manually so you can confirm it's below any dependencies.

The integrity of this should also be maintained by _never_ redundantly declaring a major table more than once (e.g. doing `Photon2 = Photon2 or {}` anywhere except in `autorun/photon-v2_init.lua`).

## Internal Structure
All core addon functions and properties should be made under the global `Photon2` table.

Sub-tables of the `Photon2` table should be made for major code sub-components when appropriate. Major sub-components should use an `sv_` or `cl_` prefix to enhance clarity on what domain something should be running in. For example, using `Photon2.cl_Network = {}` in `cl_net.lua` and `Photon2.sv_Network = {}` for `sv_net.lua`.

## Compatibility
Because Photon 2 is to incorporate much of the Photon LE light rendering functionality, 