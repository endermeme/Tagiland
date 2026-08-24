# Tagiland

My Omarchy bar and my touchpad gestures. That's the whole scope — there is no
theme in here, no shell config, no editor setup. The terminal, prompt and
editor are all stock, and versioning them would only fight `omarchy update`.

Needs Omarchy with Hyprland 0.56 or newer. The config is Lua; hyprlang has been
deprecated since 0.55 and none of this will parse under it.

[Cheat sheet](CHEATSHEET.md) has every key and gesture.

## Install

```sh
git clone https://github.com/endermeme/Tagiland.git
cd Tagiland
./install.sh --dry-run   # read this first
./install.sh
```

It symlinks into `~/.config` and moves anything already there to
`.bak.<timestamp>`. Two files need root and are left for you to install by
hand; the script prints the commands at the end.

## Gestures

Three fingers for everything. That is not a preference — libinput classifies
two-finger motion as scroll or pinch and never as a swipe. In 40k lines of my
own Hyprland log, three-finger swipes reached `SWIPE_START` 524 times and
two-finger swipes reached it zero times out of 614 attempts. A
`fingers = 2, direction = "swipe"` gesture loads without error and then never
fires, which is a miserable thing to debug.

Two of the four gestures are hand-rolled Lua because Hyprland has no action for
them:

Carrying a window to the next workspace isn't a built-in. The `move` action
drags the window around the screen, which is a different thing entirely. So
each direction dispatches `movetoworkspace` from a plain lambda. Plain lambdas
fire once, on release, which is exactly right — one swipe, one workspace.

Free-form resize needs the window floating first. The `resize` action does pass
the full 2D delta down, but dwindle only adjusts split ratios between sibling
nodes and zeroes whichever axis already spans the work area. A lone window on a
workspace cannot be resized at all. So `Super`+`Ctrl`+`Alt` floats the window,
then resizes it live from a table action with `start` and `update`. It stays
floating afterwards; tiling it back would let the layout recompute the size and
throw the resize away.

## Bar

`shell.json` alone is not enough to reproduce the bar. It references two shell
scripts and two cloned plugins, so those are here too.

`bar/scripts/sysstats` forks nothing. It reads `/proc` and `/sys` with bash
builtins and printfs the JSON by hand. The version that shelled out to `sensors`
and `jq` was costing about 70,000 process spawns a day to draw three numbers.
All the arithmetic is fixed-point integer maths, because bash has no floats.

`bar/scripts/imstatus` shows an EN/VI badge for fcitx5. It asks the bus daemon
who owns `org.fcitx.Fcitx5` rather than talking to fcitx5 itself, because fcitx5
is D-Bus activatable and any message to it spawns a stray instance that steals
the bus name from the systemd-managed one. Polled every second, that turns into
config edits that appear to do nothing.

`binhtagilla.monitor` is Omarchy's display panel plus a refresh-rate row, driven
by `bin/monitor-refresh-rate`. That helper carries resolution, position, scale
and bit depth over unchanged and writes the chosen rate into `monitors.lua`, so
it survives a reboot — Hyprland's `preferred` mode follows EDID, which on this
panel means 60 Hz forever.

`binhtagilla.battery` is Omarchy's battery service with the automatic power
profile switch taken out. Upstream re-applies a saved profile on every plug and
unplug, which is why a profile picked by hand kept snapping back.

## Things that will bite you

`omarchy update` runs migrations, and `omarchy refresh hyprland` overwrites
`~/.config/hypr/`. Symlinks do not protect you. What the repo buys you is
seeing the diff and reverting it.

The plugin directories are named `binhtagilla.*` because that is how
`omarchy plugin clone` names things. `shell.json` refers to them by that id, so
renaming means editing both.

`config/hypr/monitors.lua` is one laptop: eDP-1, 2880x1800, 10-bit. Read it
before you let it near another machine.
