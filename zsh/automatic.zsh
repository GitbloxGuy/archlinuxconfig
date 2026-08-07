mkdesktop() {
  if [ -z "$1" ]; then
    echo "Usage: mkdesktop <app_command> [Display Name]"
    return 1
  fi

  local app="$1"
  local name="${2:-$1}"
  local dest="$HOME/.local/share/applications/${app}.desktop"
  local sys_file="/usr/share/applications/${app}.desktop"

  mkdir -p "$HOME/.local/share/applications"

  if [ -f "$sys_file" ]; then
    cp "$sys_file" "$dest"
    sed -i "s|^Exec=.*|Exec=kitty -e ${app}|; s|^Terminal=.*|Terminal=false|" "$dest"
    echo "Copied and patched existing entry: $dest"
  else
    cat > "$dest" << EOF
[Desktop Entry]
Type=Application
Name=${name}
Icon=${app}
Exec=kitty -e ${app}
Terminal=false
Categories=Utility;
EOF
    echo "Created new entry: $dest"
  fi
}


