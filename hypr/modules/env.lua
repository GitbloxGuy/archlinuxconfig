
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "10")
hl.env("HYPRCURSOR_SIZE", "10")
hl.env("TERMINAL", "kitty")
hl.env("XDG_DATA_DIRS", os.getenv("HOME") .. "/.local/share:/usr/local/share:/usr/share")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
