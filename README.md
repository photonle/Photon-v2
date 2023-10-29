# Photon 2
 Photon 2 for Garry's Mod

# Known Issues
* Siren elements break when leaving the controller's PVS and a playing siren continues indefinitely.

# Major Changes

# All New Components Platform
## A History
The components system in Photon LE, while functional, is actually rather hacky in its implementation. From its release in 2014, Photon was only designed for lights that were statically positioned relative to the vehicle. There was no way to functionally separate lightbars and other lights from each other. Rather, every light visible on the vehicle needed to be defined together, and there was no support for changing the equipment or body groups either.

While it was always possible to add different lightbar props, the lights themselves were still only parented to the vehicle. The props, for all intents and purposes, were strictly decorative, and -- more importantly -- could not be moved without also needing to manually move every light that was meant to align with it.

As modeling techniques and vehicle features evolved through early 2015, new emergency vehicle addons were being released with body groups for different lightbars and lighting configurations. To adapt, Photon added support for different body-grouped lighting equipment in early summer. While all lights still needed to be defined in a singular vehicle file, it was made possible for the different sections of lights to be activated or deactivated based on the selected body groups.

With the growing focus on customization, I realized that Photon needed a way to offer attached props that could be swapped out like body groups. But to allow for reuse of lightbars across different vehicles, it needed to also be possible to define light positions and flash patterns for a single lightbar.

The best solution, my 19-year-old self determined, was to simply write a startup process that translated the light positions of each component and injected the resulting lights into the vehicle's monolithic light table. Instead of treating components as the self-contained entities they were meant to represent, their data was simply copied, renamed, and translated into Photon's original vehicle structure with various running indexes to ensure unique naming.

This procedure was further expanded with the launch of the fully-adjustable equipment configurations that accompanied the release of the Ford Police Interceptor Utility in late 2015. Dozens of components (potentially hundreds) were being injected into a central a vehicle file that contained unique specifications for hundreds, if not thousands, of lights.

The results were functional, but the flexibility was constrained. Not only was debugging made more difficult with many potential points of failure, any changes to complex vehicles required each component to be re-translated and re-indexed, a computationally expensive process made slower with each new addition.

To make matters worse, the position translation code was fundementally flawed and mathematically unsound. Certain angles and orientations weren't accounted for correctly, necessitating hacky workarounds for non-normal angle. Other orientations were simply impossible to achieve without causing major issues with light alignment and visibility.

While surface-level improvements were made over the years, this poor underlying architecture has never changed.

## Today
To avoid the unfixable mess of Photon LE's components, Photon 2 started back at square one. Central to my vision was the concept of independent, reusable, inheritable, flexible and adaptable components. Instead of a rigid behavior pipeline that was hard-coded into core application logic, components were assembled using object-oriented blocks of discrete functions. 

In fact, so much effort was put into this new approach that Photon 2 wasn't capable of even rendering a single light until about three months into the project. Every step prior to that point was in building the foundation.



# Simulate Modern Controller Features
Photon 2 supports the advanced and customizable features provided by real-world emergency lighting and siren controllers, such as SoundOff Signal's BluePrint, Whelen's CORE, Federal Signal's Pathfinder, and Code 3's Matrix.

## Component Input Channels
Photon 2 uses a new, flexible channel-input model that can map a wide variety of events to activate specific lights, patterns, siren tones, and more. This means special flash patterns for vehicle events like braking and turning are now possible. It also allows for flash patterns to change with siren tones and more.

# Elements
Replacing the idea of lights in Photon LE is the new concept of "elements." Because there are multiple techniques and approaches to actually rendering a light in Garry's Mod and Source, Photon 2 uses an abstraction layer to allow different mediums to work together inside a component.

An element is simply a generic name to describe a singular instance of a certain medium. For lights, that medium can be a projected texture (which actually lights the world), a self-illuminating sub-material, a 2D sprite (what Photon LE is based on), a 3D model-based mesh, and more. But elements 

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
While Photon 2 was intended to re-use many aspects of Photon LE for compatability, major changes in the addon architecture and a closer review of Photon LE's code eventually ruled this out. Photon 2 has been written from the ground-up and actually has very, very little in common with Photon LE.

Luckily, the actual data used to define legacy Photon components and vehicles is generally usable enough for automatic compatability to be viable.

Due to the presently fluid nature of Photon 2, compatability functionality has not yet been implemented but remains a late-stage priority.