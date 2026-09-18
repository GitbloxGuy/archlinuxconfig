#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/screenshot_$(date +'%Y%m%d_%H%M%S').png"

grim "$FILE"
cat "$FILE" | wl-copy

notify-send "Full Screenshot Captured" "$FILE" -i image-x-generic
