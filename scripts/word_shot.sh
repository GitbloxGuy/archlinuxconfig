
#!/bin/zsh

# 1. Define temporary path
IMAGE_PATH="/tmp/ocr_screenshot.png"

# 2. Take a screenshot of a region on Hyprland (Wayland)
grim -g "$(slurp -b 28282800 -c ff051eff -w 2)" "$IMAGE_PATH"

# Give the file a moment to write to storage
sleep 0.2

# 3. Extract text and copy directly to the system clipboard
if [ -f "$IMAGE_PATH" ]; then
    # Extracts text, trims empty space, and copies to Wayland clipboard
    tesseract "$IMAGE_PATH" stdout 2>/dev/null | wl-copy
    
    # 4. Cleanup temporary file
    rm "$IMAGE_PATH"
fi
