#!/usr/bin/env bash

# Create directory if it doesn't exist
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# Generate filename with date and time
FILE="$DIR/screenshot_$(date +'%Y%m%d_%H%M%S').png"

# Capture selected region and handle cancel actions gracefully
if ! geometry=$(slurp -b 28282840 -c fabd2fff -w 2); then
	notify-send "Screenshot" "Selection cancelled" -i dialog-information
    exit 0
fi

# Take screenshot, copy to clipboard, and save file
grim -g "$geometry" "$FILE"
cat "$FILE" | wl-copy

# Send success notification
notify-send "Screenshot Captured" "Saved to $FILE and copied to clipboard" -i image-x-generic

