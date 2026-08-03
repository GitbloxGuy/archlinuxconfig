-------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


hl.window_rule({
    name = "float-default-size-center",
    match = { float = true },
    size = "50% 50%",
    move = {"monitor_w*0.5-(window_w*0.5)", "monitor_h*0.5-(window_h*0.5)"},
})

hl.window_rule({ match = { class = "zen-browser" }, no_blur = true })

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "nmtui-float-popup",
    match = { title = "^nmtui-float$" },

    float = true,
    size = "500 300",
    move = {"cursor_x-(window_w*0.6)", "cursor_y-(window_h*0.01)"},
})

hl.window_rule({
  match = { class = "^(kitty-dropterm)$" },
  float = true,
  center = true,
})



