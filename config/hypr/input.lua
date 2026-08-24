-- Scroll the way Windows does: content follows the fingers.
hl.config({
  input = {
    natural_scroll = true,
    touchpad = { natural_scroll = true },
  },
})

-- Three-finger horizontal swipe changes workspace.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Reach an empty workspace instead of dead-ending on the last existing one.
hl.config({
  gestures = {
    workspace_swipe_create_new = true,
    workspace_swipe_distance = 300,
    workspace_swipe_cancel_ratio = 0.4,
  },
})

-- Carry the focused window to the next/previous workspace. Hyprland has no
-- action for this -- "move" drags the window around the screen instead. A plain
-- lambda fires once on release, so one swipe moves exactly one workspace.
hl.gesture({
  fingers = 3,
  direction = "right",
  mods = "SUPER SHIFT",
  action = function() hl.dispatch(hl.dsp.window.move({ workspace = "+1" })) end,
})
hl.gesture({
  fingers = 3,
  direction = "left",
  mods = "SUPER SHIFT",
  action = function() hl.dispatch(hl.dsp.window.move({ workspace = "-1" })) end,
})

-- Resize inside the tiling layout. Three fingers, not two: libinput reports
-- two-finger motion as scroll or pinch, never as a swipe.
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER ALT", action = "resize" })

-- Free-form resize. Dwindle only adjusts split ratios between siblings, so
-- floating the window first is what makes both axes move. It stays floating.
hl.gesture({
  fingers = 3,
  direction = "swipe",
  mods = "SUPER CTRL ALT",
  action = {
    start = function() hl.dispatch(hl.dsp.window.float({ action = "on" })) end,
    update = function(e)
      hl.dispatch(hl.dsp.window.resize({ x = e.delta.x, y = e.delta.y, relative = true }))
    end,
  },
})
