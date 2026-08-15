#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/screenshot_$(date +'%Y%m%d_%H%M%S').png"

# Freeze the screen: hyprpicker -r renders a static overlay instead of picking a color
hyprpicker -r -z &
FREEZE_PID=$!
sleep 0.2  # give it a beat to actually render before slurp grabs input

if ! geometry=$(slurp -b 28282840 -c fabd2fff -w 2); then
    kill "$FREEZE_PID" 2>/dev/null
    notify-send "Screenshot" "Selection cancelled" -i dialog-information
    exit 0
fi

kill "$FREEZE_PID" 2>/dev/null

grim -g "$geometry" "$FILE"
cat "$FILE" | wl-copy

notify-send "Screenshot Captured" "Saved to $FILE and copied to clipboard" -i image-x-generic
