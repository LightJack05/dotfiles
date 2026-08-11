hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "default")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LADSPA_PATH", "/usr/lib/ladspa")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_STYLE_OVERRIDE", "breeze")
hl.env("XCURSOR_SIZE", "24")

hl.config({
    render = {
        cm_auto_hdr = true,
        cm_sdr_eotf = "gamma22",
    },
})

local home = os.getenv("HOME") or ""

local function path_exists(p)
    local f = io.open(p, "r")
    if f then f:close() return true end
    return false
end

local function dir_exists(p)
    local ok = os.execute('test -d "' .. p .. '"')
    return ok == true or ok == 0
end

-- 10-bit screen capture. Forcing RGBA10 yields 10-bit/HDR screencasts but breaks
-- screensharing in apps that can't negotiate 10-bit. It's the only genuinely
-- machine-specific setting, so rather than a per-device config we opt in locally:
-- on a machine whose display + apps support it (e.g. the desktop), run once:
--   touch ~/.config/hypr/enable-10bit-capture
if path_exists(home .. "/.config/hypr/enable-10bit-capture") then
    hl.env("PIPEWIRE_CAPTURE_FORMAT", "RGBA10")
end

-- Wallpapers live outside this repo (a separate multi-GB submodule) and may be
-- absent on some machines (e.g. headless). See hyprpaper.conf for the path.
local wallpaper_dir = home .. "dotfiles/Wallpapers/Kurzgesagt"

-- display.lua is generated at runtime by hyprmonitormanager.
require("display")
require("workspace-rules")
require("keymaps")

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment XDG_RUNTIME_DIR WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync -c ~/.config/swaync/swaync.json -s ~/.config/swaync/style.css")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("hypridle")
    if dir_exists(wallpaper_dir) then
        hl.exec_cmd("hyprpaper")
    end
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("hyprmonitormanager daemon")
end)

hl.config({
    input = {
        kb_layout  = "us_custom",
        kb_variant = "us_custom",
        kb_model   = "",
        kb_options = "caps:super",
        kb_rules   = "",

        follow_mouse  = 1,
        accel_profile = "flat",

        touchpad = {
            drag_lock      = false,
            natural_scroll = true,
            scroll_factor  = 0.15,
        },

        sensitivity  = 1.0,
        repeat_delay = 200,
    },
})

hl.config({
    general = {
        no_focus_fallback = true,
        border_size       = 0,
        gaps_in           = 2,
        gaps_out          = 4,

        col = {
            active_border   = "rgba(eeeeeeFF)",
            inactive_border = "rgba(31324433)",
        },

        layout         = "dwindle",
        allow_tearing  = false,
        resize_on_border = true,
    },
})

hl.config({
    decoration = {
        rounding = 7,

        blur = {
            enabled          = true,
            size             = 9,
            passes           = 5,
            ignore_opacity   = true,
            new_optimizations = true,
        },

        shadow = {
            enabled      = false,
            range        = 20,
            render_power = 2,
            sharp        = false,
            color        = "rgba(eeeeeebb)",
            color_inactive = "rgba(00000000)",
            offset       = "0 0",
            scale        = 0.99,
        },

        dim_inactive    = true,
        dim_strength    = 0.3,
        inactive_opacity = 1,
    },
})

hl.config({ animations = { enabled = true } })

hl.config({
    cursor = {
        no_hardware_cursors = 1,
    }
})

hl.curve("linear",             { type = "bezier", points = { {0, 0},         {1, 1}       } })
hl.curve("catppuccin_standard",{ type = "bezier", points = { {0.25, 0.1},    {0.25, 1}    } })
hl.curve("catppuccin_decel",   { type = "bezier", points = { {0.05, 0.7},    {0.1, 1}     } })
hl.curve("catppuccin_accel",   { type = "bezier", points = { {0.3, 0},       {0.8, 0.15}  } })
hl.curve("soft_overshot",      { type = "bezier", points = { {0.1, 0.9},     {0.15, 1.05} } })
hl.curve("soft_curve",         { type = "bezier", points = { {0.26, 0.26},   {0.15, 1}    } })
hl.curve("swipe_in",           { type = "bezier", points = { {0.25, 0.1},    {0.25, 1}    } })
hl.curve("swipe_out",          { type = "bezier", points = { {0.3, 0},       {0.8, 0.15}  } })

hl.animation({ leaf = "windows",       enabled = true,  speed = 1.5, bezier = "swipe_in",         style = "slide"       })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 1,   bezier = "swipe_in",         style = "slide"       })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1,   bezier = "swipe_out",        style = "slide"       })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 1,   bezier = "catppuccin_decel", style = "popin 40%"   })
hl.animation({ leaf = "fade",          enabled = true,  speed = 5,   bezier = "soft_curve"                              })
hl.animation({ leaf = "fadeIn",        enabled = false, speed = 1.3, bezier = "swipe_in"                                })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 0.8, bezier = "swipe_in",         style = "slide"       })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 0.6, bezier = "swipe_out",        style = "slide"       })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1,   bezier = "swipe_in"                                })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 0.8, bezier = "soft_curve"                              })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 0.8, bezier = "catppuccin_decel", style = "slide 50%"   })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 0.8, bezier = "swipe_in",       style = "slidevert 50%" })
hl.animation({ leaf = "border",        enabled = true,  speed = 3,   bezier = "soft_curve"                              })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    gestures = {
        workspace_swipe_invert       = true,
        workspace_swipe_cancel_ratio = 0.1,
        workspace_swipe_touch        = true,
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.config({
    misc = {
        force_default_wallpaper = 1,
        animate_manual_resizes  = true,
    },
})

hl.layer_rule({
    name      = "diable-animation-wallpaper",
    animation = "none",
    no_anim   = true,
    match     = { namespace = "hyprpaper" },
})

hl.layer_rule({
    name      = "layerrule-1",
    animation = "none",
    no_anim   = true,
    match     = { namespace = "selection" },
})

hl.layer_rule({
    name        = "layerrule-2",
    blur        = true,
    ignore_alpha = 0,
    match       = { namespace = "wofi" },
})

hl.layer_rule({
    name        = "layerrule-3",
    blur        = true,
    ignore_alpha = 0,
    match       = { namespace = "swaync-control-center" },
})

hl.layer_rule({
    name        = "layerrule-waybar",
    blur        = true,
    ignore_alpha = 0,
    match       = { namespace = "waybar" },
})

hl.config({
    xwayland = {
        force_zero_scaling = false,
    },
})

hl.window_rule({
    name           = "supress_maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "floatSatty",
    match = { class = "com.gabm.satty" },
    float = true,
})

hl.window_rule({
    name  = "floatZenityHyprMonitorManager",
    match = { class = "zenity", title = "HyprMonitorManager" },
    float = true,
})

hl.window_rule({
    name  = "floatNwgDisplays",
    match = { class = "nwg-displays" },
    float = true,
})
