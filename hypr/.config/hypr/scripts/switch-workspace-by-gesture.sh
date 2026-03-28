#!/bin/bash

direction="$1"
name="$(hyprctl activeworkspace -j | jq -r '.name')"

# notify-send "test $direction $name"

primary_workspaces=(A R S T G Q W F P B J L U Y M)
secondary_workspaces=(Z X C D V K H)
# letters=(A R S T G Q W F P B J L U Y M Z X C D V K H)

idx=-1
for i in "${!primary_workspaces[@]}"; do
  if [[ "${primary_workspaces[$i]}" == "$name" ]]; then
    idx="$i"
    declare -n letters=primary_workspaces
    break
  fi
done

if [[ "$idx" -lt 0 ]]; then
  for i in "${!secondary_workspaces[@]}"; do
    if [[ "${secondary_workspaces[$i]}" == "$name" ]]; then
      idx="$i"
      declare -n letters=secondary_workspaces
      break
    fi
  done
fi

if [[ "$idx" -lt 0 ]]; then
  notify-send "Error: '$name' not found in array" >&2
  exit 1
fi

len=${#letters[@]}

if [[ "$direction" == "left" ]]; then
  next_idx=$(( (idx + 1) % len ))
  next_name="${letters[$next_idx]}"
  hyprctl dispatch workspace "name:$next_name"
elif [[ "$direction" == "right" ]]; then
  prev_idx=$(( (idx - 1 + len) % len ))
  prev_name="${letters[$prev_idx]}"
  hyprctl dispatch workspace "name:$prev_name"
else
  notify-send "Unknown direction"
  exit 1
fi
