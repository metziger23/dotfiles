#!/usr/bin/env bash
set -euo pipefail

floating="$(hyprctl activewindow -j | jq -r '.floating')"

# must be exactly "true" or "false", otherwise stop
if [[ "$floating" != "true" && "$floating" != "false" ]]; then
  exit 1
fi

if [[ "$floating" == "true" ]]; then
  hyprctl dispatch cyclenext prev tiled hist
else
  hyprctl dispatch cyclenext prev floating hist
fi
