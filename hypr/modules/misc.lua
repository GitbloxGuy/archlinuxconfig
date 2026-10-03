
----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- Disables the random hyprland logo / anime girl background. :(
        vrr                     = 0,    -- Set to 0 to completely stop FreeSync frame timing flickering
    },

    xwayland = {
        force_zero_scaling = true,      -- Prevents blurry scaling on high-res displays
    },
    
    general = {
        allow_tearing = true,           -- Lower latency presentation timing control
    },

    render = {
        direct_scanout = 0,             -- Stops full-screen games from hijacking buffers and strobing
    }
})
