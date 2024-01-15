# [Click here for the Photon 2 Wiki/Documentation](https://photon.lighting/docs)

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

## Light/Element Groups
Use element groups to reference related elements under one user-friendly name instead of always needing to manage multiple index numbers.

Elements can belong to multiple groups and their names can be used when writing sequences.

# Advanced Development Changes

## Annotations
Photon 2 is now documented using EmmyLua annotations. This provides intellisense, code validation (i.e. Lint), and static typing. 

When using VSCode, use Sumneko's Lua package to enable the annotation functionality. While it unfortunately cannot be used with any GLua plugins, I have generated annotation files scraped from the Garry's Mod Wiki (https://github.com/NullEnt1ty/gmod-wiki-scraper) as a stop-gap measure.

## Object Orientation
Photon 2 makes heavy use of metatables and custom inheritance to mimic traditional OOP designs. This makes it far more flexible for Photon asset creators and substantially improves interal operations and debugging.

## Inheritance
A common theme throughout Photon 2 is the ability to inherit content. Inheritance allows you to create new components and vehicles that are based on existing ones, but without the need to copy and paste entire files. Instead, simply modify the sections you need to tweak and the rest is handled automatically.

Sometimes this is want you want, and sometimes it's not. If you find that a parent value is appearing when you don't want it to, you must manually prevent the particular field/route from being inherited using the global `UNSET` variable.

(See the `photon_siren_secondary` component for an example of this.)

## Compatibility
While Photon 2 was intended to re-use many aspects of Photon LE for compatability, major changes in the addon architecture and a closer review of Photon LE's code eventually ruled this out. Photon 2 has been written from the ground-up and actually has very, very little in common with Photon LE.

Luckily, the actual data used to define legacy Photon components and vehicles is generally usable enough for automatic compatability to be viable.

Due to the presently fluid nature of Photon 2, compatability functionality has not yet been implemented but remains a late-stage priority.
