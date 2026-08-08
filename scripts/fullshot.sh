#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/screenshot_$(date +'%Y%m%d_%H%M%S').png"

grim "$FILE"
cat "$FILE" | wl-copy

notify-send "Screenshot Captured" "Saved to $FILE and copied to clipboard" -i image-x-generic
