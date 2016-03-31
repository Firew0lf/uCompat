# uCompat
µLua compatibility layer for ctrµLua.

### What is that ?

_uCompat_ is a ctrµLua "library" that allows you to launch and use µLua homebrews
on your 3DS.

### How does it work ?

This library recreate the µLua execution environment in ctrµLua using only pure
Lua. All the functions were recreated using the [official µLua documentation](https://sourceforge.net/p/microlua/wiki/API471/),
and the library is designed to run any µLua program from 3.0 to 4.7.2.

### How do I use it ?

Just download the latest version by clicking the "Download ZIP" button (somewhere
on the page) or with a `git clone`, and place the `uCompat` directory in your
ctrµLua `libs` folder (the __folder__, not the files in the folder).
Once it's done, put your µLua homebrews in a directory somewhere, it doesn't
mater where, just remember it.
Finally, open your homebrews' main files (`index.lua` on a lot of them) and add
the line `require("uCompat")` at the beggining of the file, before any other
line of code. Now, it should work.

### What's done ?

 * Canvas
 * Color
 * Controls
 * DateTime
 * Debug
 * dsUser
 * Font
 * Image
 * ini
 * Map
 * Motion
 * Nifi
 * Rumble
 * screen
 * ScrollMap
 * Sound (without sound)
 * Sprite
 * System
 * Timer
 * Wifi

### What's not ?

 * Soundbanks decoding
 * `screen.drawGradientRect()`: very ugly render ...
 * 3DS <-> DS Nifi
