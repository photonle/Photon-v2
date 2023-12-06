# [Photon 2 Documents](photon.lighting/docs)

# Photon 2
 Photon 2 for Garry's Mod

# Internal Testers
Thanks for testing. Photon 2 is about 70% ready. Please expect some major instability and know concepts could change significantly.

When getting a feel for Photon 2, I'd recommend just using the Las Vegas FPIU. It's the most recent demonstrator vehicle and is by far the most complete.

You'll likely notice some things are considerably more labor-intensive (i.e. requires verbose code) to do than they were in Photon LE. While the underlying logic won't change, many aspects will eventually have macro-like wrappers/helper functions available to simplify content creation (while preserving the ability to significantly change default behavior when needed).

## Rules and Conditions
1. Goes without saying, but don't share the code or files with anyone. A leaked pre-release of Photon 2 harms our ability maintain interest, updates, and confidence in the addon.
2. You are free to publicly show off your Photon 2 projects in #waywo, #showcase, etc.

## Setting Up
I highly recommend using the GitHub desktop appliction so you can easily re-sync the repository with each update. Simply setup the repo inside garrysmod/addons. It's the same as Photon LE.

## Updates
Most the major work happens on my weekends, which is usually Sunday through Wednesday morning. Pushes generally fall within this window. (If I'm busy there may not be any updates for two weeks.)

Version numbering began at v2.0.0 with the launch of internal testing. When I decide to increment the version is completely arbitrary, but I try to do it when there are breaking changes so it's easier to track.

## Timeline
I'm still planning on a Workshop release in late December under a "beta" title. It won't have every feature I'm working on, but it should have enough to be usable.

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

* Projected textures are rendered even when they're invisible. This can cause a pretty major performance hit and it isn't obvious that it's happening. 

* Lights can be dim-looking, washed out, or weird looking. Light appearance is a major work-in-progress and I don't intend to focus on it until much later. This is most noticeable with mesh lights.

* This readme file is full of incomplete thoughts and information.

# Major Changes

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

## Light/Element Groups
Use element groups to reference related elements under one user-friendly name instead of always needing to manage multiple index numbers.

Elements can belong to multiple groups and their names can be used when writing sequences.

# Advanced Development Changes

## Annotations
Photon 2 is now documented using EmmyLua annotations. This provides intellisense, code validation (i.e. Lint), and static typing. 

When using VSCode, use Sumneko's Lua package to enable the annotation functionality. While it unfortunately cannot be used with any GLua plugins, I have generated annotation files scraped from the Garry's Mod Wiki (https://github.com/NullEnt1ty/gmod-wiki-scraper) as a stop-gap measure.

## Naming Conventions
Photon 2 and its API are based on .NET naming conventions (https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines). This means heavy usage of PascalCasing for exposed functions and properties/fields, camelCasing for local variables, no underscores (mostly), descriptive names and limited acronym usage.

Because Photon 2 uses type annotations (see above), variables names are also not prefixed with types (a common practice in core Garry's Mod code).

## Object Orientation
Photon 2 makes heavy use of metatables and custom inheritance to mimic traditional OOP designs. This makes it far more flexible for Photon asset creators and substantially improves interal operations and debugging.

## Inheritance
A common theme throughout Photon 2 is the ability to inherit content. Inheritance allows you to create new components and vehicles that are based on existing ones, but without the need to copy and paste entire files. Instead, simply modify the sections you need to tweak and the rest is handled automatically.

### HOWEVER
When using inheritance functionality, beware of certain quirks that may cause unexpected behavior. Due to how metatable _index tables work, a nil value on a child component will always result in a lookup on its parent table.

Sometimes this is want you want, and sometimes it's not. If you find that a parent value is appearing when you don't want it to, you must manually prevent the particular field/route from being inherited using the global `UNSET` variable.

(See the `photon_siren_secondary` component for an example of this.)

## Frames, StateMaps and State Slots
One of the more significant creator changes in Photon 2 is the addition of frame strings. Using a very basic script-like syntax, frames can be constructed in a less-verbose and non-Lua manner.

In Photon LE, frames written using table pairs that defined a light index and color, like: `{ { 1, R }, { 2, B }, { 3, R }, { 4, B } }`. This assigned the color red to lights 1 and 3, and the color blue to lights 2 and 4. 

In Photon 2, this same frame can be simplified to `"[R] 1 3 [B] 2 4"` using the new frame syntax. The string is parsed in a linear, left-to-right process. The state, defined in brackets (`[R]`), is applied to all element IDs to the right (`1 3`). When the parser reaches another pair of brackets (`[B]`), that new state is then applied to elements to the right of that (`2 4`).

### State Naming
To distinguish between explicitly-defined states and slots, the rule is simple: strings are states, numbers are slots.

`[R] 1` means element `1` is assigned to state `R`. `[1] 1` means element `1` is assigned the value of slot 1. (For this reason, custom states that have numeric names are not supported.)

## Compatibility
While Photon 2 was intended to re-use many aspects of Photon LE for compatability, major changes in the addon architecture and a closer review of Photon LE's code eventually ruled this out. Photon 2 has been written from the ground-up and actually has very, very little in common with Photon LE.

Luckily, the actual data used to define legacy Photon components and vehicles is generally usable enough for automatic compatability to be viable.

Due to the presently fluid nature of Photon 2, compatability functionality has not yet been implemented but remains a late-stage priority.

## Operations
For those interested, this is an overview of how Photon works internally.

### Library 
The Photon 2 library is an internal table that stores and tracks (mostly) raw table data from user-made content, such as vehicles, components, and sirens.

#### Content Stored in the Library
1. Custom user commands 
2. Custom user input configurations
3. Sirens
4. Vehicles (referred to as "profiles")
5. Components

### Index
The index is similar to the library, but stores processed entries from the library. 

## Performance
I've tried to avoid doing too much benchmarking while the addon is still incomplete. From superficial tests so far, performance varies between better to on-par with Photon LE. There are a few avenues I'm aware of to boost performance when I get to it.

Nonetheless, for content creators, here is a quick guide:

### Performance Tips
#### Lights
Generally speaking, the fewer the active lights there are, the better performance is going to be. More importantly, however, is the type of light you use. (For non-light elements this doesn't really matter.)

Light performance, from best to worst by type:
1. Sub-material
2. Mesh
3. 2D
4. Projected

#### Components
Just as is the case with lights, know that the fewer components there are, the better the performance will be. One complex model is typoically faster than two basic models. In practical terms, this means one model with four Ions (each independently boned) is significantly faster than using four separate Ion components.

It's also worth noting that material parameters and count matter as well. While not noticeable with only a few, the performance boost from simpler models becomes apparent when there are 10 or more of the same model.

This means that complex materials on lightbars are usually fine (as there's usually just one per vehicle), but highly detailed perimeter components will degrade performance.

#### Vehicle Equipment
Each component added in a vehicle's equipment table generates a child component, derived from an original Library entry. This allows for developers to directly manipulate almost all aspects of components within a vehicle file, rather than needing to manually create an entirely new component file.

### Index
Every object stored in the `Library` is "compiled," and the result is then loaded into the `Index`. Generally speaking, this process converts the raw data into a more complex, verbose and inter-linked data structure that Photon 2 interacts with internally. 

It also adds logic/functions to the objects (as opposed to simply data).

### Instances
Instances are objects that have been "spawned" into the game. They are directly derived from objects in the Index, but now manage their own state and interact with the world. 
 
Instances are created and destroyed as users enter and exit a Photon Controller's PVS.