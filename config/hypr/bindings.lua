-- Windows-style window and workspace controls.

-- SUPER + W was Omarchy's close key; drop it so there is only one way to close.
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + SHIFT + Q", "Force kill window", hl.dsp.window.kill())

-- SUPER + CTRL + arrows default to moving focus within a window group.
-- "+1"/"-1" over "e+1"/"e-1": the e-forms only hop between workspaces that
-- already exist, so they go nowhere when just one workspace is open.
hl.unbind("SUPER + CTRL + LEFT")
hl.unbind("SUPER + CTRL + RIGHT")
o.bind("SUPER + CTRL + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "-1" }))
o.bind("SUPER + CTRL + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "+1" }))
o.bind("SUPER + CTRL + SHIFT + LEFT", "Move window to previous workspace", hl.dsp.window.move({ workspace = "-1" }))
o.bind("SUPER + CTRL + SHIFT + RIGHT", "Move window to next workspace", hl.dsp.window.move({ workspace = "+1" }))

-- code:10..code:19 are the number row 1..0, so this survives a non-QWERTY layout.
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  o.bind("SUPER + CTRL + SHIFT + " .. key, "Move window to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace) }))
end

-- Region snip to clipboard, like Win+Shift+S. The key ships bound to the Google
-- Maps webapp; without the unbind both fire on the same press.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot region to clipboard", "omarchy-capture-screenshot region copy")

-- Clipboard history on SUPER + V. SUPER + CTRL + V opened the same manager.
hl.unbind("SUPER + V")
hl.unbind("SUPER + CTRL + V")
o.bind("SUPER + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Emoji picker on SUPER + PERIOD, as on Windows.
hl.unbind("SUPER + CTRL + E")
o.bind("SUPER + PERIOD", "Emojis", "omarchy-shell shell toggle omarchy.emojis")

-- File manager on SUPER + E. SUPER + SHIFT + F was the stock key.
hl.unbind("SUPER + SHIFT + F")
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })

-- Clears a touchpad left reporting a phantom finger after resume. Runs through
-- a NOPASSWD sudoers entry because a password prompt is useless when the
-- pointer is the broken part. See system/ for the script and the sudoers file.
o.bind("CTRL + ALT + ESCAPE", "Reset touchpad", "sudo /usr/local/bin/omarchy-touchpad-reset")

-- Arrow-key resize. These four default to moving the window into a neighbouring
-- group; group placement is still on SUPER + ALT + G and the cycling keys.
hl.unbind("SUPER + ALT + LEFT")
hl.unbind("SUPER + ALT + RIGHT")
hl.unbind("SUPER + ALT + UP")
hl.unbind("SUPER + ALT + DOWN")
o.bind("SUPER + ALT + RIGHT", "Widen window", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind("SUPER + ALT + LEFT", "Narrow window", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + ALT + DOWN", "Heighten window", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
o.bind("SUPER + ALT + UP", "Shorten window", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
