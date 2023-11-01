# Photon 2
 Photon 2 for Garry's Mod

# Internal Testers
Thanks for testing. Photon 2 is about 70% ready. Please expect some major instability and know concepts could change significantly.

When getting a feel for Photon 2, I'd recommend just using the Las Vegas FPIU. It's the most recent demonstrator vehicle and is by far the most complete.

## Rules and Conditions
1. Goes without saying, but don't share the code or files with anyone. A leaked pre-release of Photon 2 harms our ability maintain interest, updates, and confidence in the addon.
2. You are free to publicly show off your Photon 2 projects in #waywo, #showcase, etc.

# Default Key Binds
* F: Toggle warning lights (MODE2)
* R: Toggle siren, activate warning lights (MODE3)
* L ALT: Cycle through warning lights modes (MODE1, MODE2, MODE3)
* M: Toggle marker/cruise lights.
* 1-4: Toggle siren tones T1-T4
* H: Quick press toggles headlights. Long press toggles parking lights.

* Arrow LEFT: Toggle left turn signal.
* Arrow RIGHT: Toggle right turn signal.
* Arrow UP: Toggle hazard lights.
* Arrow DOWN: All turn signals off.

* RCtrl + Arrow LEFT: Toggle traffic advisor left.
* RCtrl + Arrow RIGHT: Toggle traffic advisor right.
* RCtrl + Arrow UP: Toggle traffic advisor center-out.
* RCtrl + Arrow DOWN: Turn directional/traffic advisor off.

* RShift + Arrow LEFT: Toggle left scene lighting.
* RShift + Arrow RIGHT: Toggle right scene lighting.
* RShift + Arrow UP: Toggle forward scene lighting.
* RShift + Arrow DOWN: Turn all scene lighting off.

* MOUSE1: Airhorn (momentary).
* MOUSE2: Manual siren (momentary).

While there is currently no UI or in-game process for setting up binds, you can get an idea how they work and modify it yourself by looking at /photon-v2/cl_input.lua

# Known Issues
There's a massive list of issues and to-do items that remain in Photon 2. While I'm fully aware of a number of them, don't hesitate to report problems you run into.

* Sirens break when leaving the controller's PVS and active sirens will play indefinitely. Although I know the reason, I'm still working on a solution and haven't been able to address it yet. In the mean time, use the `stopsound` command to forcefully kill lingering sirens (I've it bound to my mouse for well over a decade).

* Projected textures are rendered even when they're invisible. This can cause a pretty major performance hit and it isn't obvious that it's happening. 

* Lights can be dim-looking, washed out, or weird looking. Light appearance is a major work-in-progress and I don't intend to focus on it until much later.

* This readme file is full of incomplete thoughts and information.

# Major Changes

...WORK IN PROGRESS...

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

### Hard versus Soft Reloading
For optimization purposes, there are two types of reloads that can occur when editing a vehicle file: hard and soft.

Soft reloads update at a superficial level and can be executed very quickly (usually instantaneously). This is for minor tweaks like basic positioning, which are expected to be done frequently.

Hard reloads, on the other hand, reinitialize vehicle equipment at a deeper level. It's a slower process but is necessary in order to apply more significant changes.

A soft reload occurs whenever a vehicle file is saved, and a hard reload occurs when the file is immediately saved again (in other words, double-tapping Ctrl+S).

What needs a soft reload and what needs a hard reload is generally irrelevant to the average Photon content developer. All you need to know is this: if you save a vehicle and the change you expected didn't work, all you have to do is double-tap Ctrl+S again.

HOWEVER: as of writing this (October 31st), be advised that this process is still buggy and certain errors can break the vehicle altogether. So when it comes to applying changes, follow these steps until you get the desired results:

1. Soft reload via single-save
2. Hard reload via rapid double-save
3. Car respawn
4. Map restart (I'd suggest just using the `retry` console command)
5. Game restart

# Advanced Development Changes

## Annotations
Photon 2 is now documented using EmmyLua annotations. This provides intellisense, code validation (i.e. Lint), and static typing. 

When using VSCode, use Sumneko's Lua package to enable the annotation functionality. While it unfortunately cannot be used with any GLua plugins, I have generated annotation files scraped from the Garry's Mod Wiki (https://github.com/NullEnt1ty/gmod-wiki-scraper) as a stop-gap measure.

## Naming Conventions
Photon 2 and its API are based on .NET naming conventions (https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines). This means heavy usage of PascalCasing for exposed functions and properties/fields, camelCasing for local variables, no underscores (mostly), descriptive names and limited acronym usage.

Because Photon 2 uses type annotations (see above), variables names are also not prefixed with types (a common practice in core Garry's Mod code).

## Object Orientation
Photon 2 makes heavy use of metatables and custom inheritance to mimic traditional OOP designs. This makes it far more flexible for Photon asset creators and substantially improves interal operations and debugging.

## Compatibility
While Photon 2 was intended to re-use many aspects of Photon LE for compatability, major changes in the addon architecture and a closer review of Photon LE's code eventually ruled this out. Photon 2 has been written from the ground-up and actually has very, very little in common with Photon LE.

Luckily, the actual data used to define legacy Photon components and vehicles is generally usable enough for automatic compatability to be viable.

Due to the presently fluid nature of Photon 2, compatability functionality has not yet been implemented but remains a late-stage priority.