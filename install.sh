#!/bin/bash
# Symlink this repo into ~/.config. Anything already there is moved aside with
# a .bak.<timestamp> suffix first, so a bad run is always undoable.
#
#   ./install.sh            link everything
#   ./install.sh --dry-run  print what would happen, touch nothing

set -euo pipefail

REPO=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
STAMP=$(date +%s)
DRY=0
[[ ${1:-} == --dry-run ]] && DRY=1

link() {
  local src=$REPO/$1 dst=$HOME/$2

  if [[ ! -e $src ]]; then
    echo "missing in repo: $1" >&2
    return 1
  fi

  # An existing symlink is ours to replace; a real file is the user's to keep.
  if [[ -L $dst ]]; then
    ((DRY)) || rm "$dst"
  elif [[ -e $dst ]]; then
    echo "  backup  $2 -> $2.bak.$STAMP"
    ((DRY)) || mv "$dst" "$dst.bak.$STAMP"
  fi

  echo "  link    $2"
  ((DRY)) || { mkdir -p "$(dirname "$dst")"; ln -s "$src" "$dst"; }
}

((DRY)) && echo "dry run, nothing will be written"

echo "hyprland:"
link config/hypr/bindings.lua .config/hypr/bindings.lua
link config/hypr/input.lua    .config/hypr/input.lua
# Machine-specific: eDP-1 at 2880x1800. Edit before trusting it on other hardware.
link config/hypr/monitors.lua .config/hypr/monitors.lua

echo "bar:"
link config/omarchy/shell.json                .config/omarchy/shell.json
link config/omarchy/bar/scripts/sysstats      .config/omarchy/bar/scripts/sysstats
link config/omarchy/bar/scripts/imstatus      .config/omarchy/bar/scripts/imstatus
link config/omarchy/bin/monitor-refresh-rate  .config/omarchy/bin/monitor-refresh-rate

echo "plugins:"
link config/omarchy/plugins/binhtagilla.battery .config/omarchy/plugins/binhtagilla.battery
link config/omarchy/plugins/binhtagilla.monitor .config/omarchy/plugins/binhtagilla.monitor

cat <<'NOTE'

Not linked, because they need root:

  sudo install -m755 system/omarchy-touchpad-reset /usr/local/bin/
  sudo install -m440 system/omarchy-touchpad-reset.sudoers \
       /etc/sudoers.d/omarchy-touchpad-reset

Then reload:

  hyprctl reload && hyprctl configerrors
  omarchy restart shell
NOTE
