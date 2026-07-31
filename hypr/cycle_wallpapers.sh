#!/usr/bin/env zsh

WALLPAPER_DIR="$HOME/Wallpapercycle"
INTERVAL=30

pgrep -x "awww-daemon" > /dev/null || awww-daemon &
sleep 5

setopt NULL_GLOB

while true; do
img=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | shuf -n 1)

if [ -n "$img" ]; then
	awww img "$img" --transition-type fade --transition-fps 60
fi
sleep "$INTERVAL"
done                                                                                                                         
