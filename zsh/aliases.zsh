alias ff='fastfetch -c ~/.config/fastfetch/config.jsonc'
alias ff1='fastfetch -c ~/.config/fastfetch/config1.jsonc'
alias x11='termux-x11 :1 -xstartup "dbus-launch --exit-with-session i3"'
alias clearr='cd && clear && ff1'
alias gpush='cd && cd .config && git add . && git commit -m "Auto-commit: $(date)" && git push && cd -'
alias capslock='~/.local/bin/capslock-rightclick.sh &\
disown'
alias touchy='sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi'
