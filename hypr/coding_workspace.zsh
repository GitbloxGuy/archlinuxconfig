#!/bin/zsh

# 1. Open your terminal with Neovim using a distinct layout class
kitty --class="floating_nvim" -e nvim &

# 2. Wait until the Neovim window is fully registered by Hyprland
while ! hyprctl clients | grep -q "class: floating_nvim"; do
    sleep 0.05
done

# 3. Force focus to the Neovim window (ignores mouse position)
hyprctl dispatch focuswindow class:floating_nvim

# 4. Securely apply the preselect to the right of the focused window
hyprctl dispatch layoutmsg preselect r

# 5. Open Zen browser
zen-browser &

