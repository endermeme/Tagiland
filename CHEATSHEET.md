# Cheat sheet

Only what this repo changes. Everything else is stock Omarchy.

## Touchpad

All three fingers. Two-finger swipes are not usable here — see the README.

| Hold | Swipe | Result |
| --- | --- | --- |
| — | left / right | Previous / next workspace |
| `Super`+`Shift` | right | Send window to the next workspace, follow it |
| `Super`+`Shift` | left | Send window to the previous workspace, follow it |
| `Super`+`Alt` | any | Resize inside the tiling layout |
| `Super`+`Ctrl`+`Alt` | any | Float the window, then resize it freely |

`Super`+`Ctrl`+`Alt` leaves the window floating. `Super`+`T` tiles it back.

Modifiers are matched exactly, so holding `Super`+`Shift` will not also trigger
the plain workspace swipe.

## Windows

| Keys | Result |
| --- | --- |
| `Super`+`Q` | Close |
| `Super`+`Shift`+`Q` | Force kill |
| `Super`+`Alt`+`←` `→` | Narrow / widen |
| `Super`+`Alt`+`↑` `↓` | Shorten / heighten |

`Super`+`W` no longer closes windows. There is one close key, not two.

## Workspaces

| Keys | Result |
| --- | --- |
| `Super`+`1`…`0` | Go to workspace 1–10 |
| `Super`+`Ctrl`+`←` `→` | Previous / next workspace |
| `Super`+`Ctrl`+`Shift`+`←` `→` | Carry the window there |
| `Super`+`Ctrl`+`Shift`+`1`…`0` | Send window to workspace 1–10 |

The arrow bindings use `+1`/`-1`, not `e+1`/`e-1`, so they reach an empty
workspace instead of stopping at the last one that exists.

## Everything else

| Keys | Result |
| --- | --- |
| `Super`+`E` | File manager |
| `Super`+`V` | Clipboard history |
| `Super`+`.` | Emoji picker |
| `Super`+`Shift`+`S` | Snip a region to the clipboard |
| `Ctrl`+`Alt`+`Esc` | Reset the touchpad |
| `Ctrl`+`Shift` | Switch input method (EN / VI) |

`Ctrl`+`Alt`+`Esc` is for when s2idle leaves the touchpad reporting a finger
that never lifted, so every gesture counts one finger too many.

## Bar

Left to right: menu, workspaces, then indicators, CPU/temp/RAM, clock,
input-method badge, keyboard layout, weather, updates, then the tray and the
system controls.

- Hover the CPU block for power draw and battery runtime.
- Click the `EN` / `VI` badge to switch input method.
- The display panel has a refresh-rate row. Rates at or above 90 Hz are marked
  `USES MORE BATTERY`, because on this panel they are the largest single draw.
- Power profiles do not switch themselves when you plug or unplug. Whatever you
  picked stays picked.
