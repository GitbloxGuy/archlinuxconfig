#!/usr/bin/env zsh

# 1. Open nvim (big pane)
kitty --class="floating_nvim" -e nvim &

while ! hyprctl clients | grep -q "floating_nvim"; do
    sleep 0.05
done

# 2. Next window opens to the RIGHT of nvim
hyprctl dispatch 'hl.dsp.layout("preselect r")'

# 3. Open a plain kitty terminal (top-right)
kitty --class="coding_term" &

while ! hyprctl clients | grep -q "coding_term"; do
    sleep 0.05
done

# 4. Shrink the terminal's split (it's the focused/active window right now),
#    which grows nvim to fill the rest. Lower value = smaller terminal pane.
#    Tune this number to taste — 0.5 is a starting point.
hyprctl dispatch 'hl.dsp.layout("splitratio exact 0.5")'

# 5. Next window opens BELOW the terminal (splits its cell, not the screen)
hyprctl dispatch 'hl.dsp.layout("preselect d")'

# 6. Open zen-browser — lands bottom-right, under the terminal
zen &

sleep 1
