local M = {}

function M.setup()
    local terminal    = "kitty"
    local fileManager = "thunar"
    local menu        = "killall -r '.*wofi.*'; wofi --insensitive --show drun -I -a"
    local browser     = "firefox"
    local lockscreen  = "pidof hyprlock || hyprlock"
    local notificationAgent  = "swaync-client -t"
    local colorpicker        = "hyprpicker | wl-copy"
    local emojiPicker        = "killall -r '.*wofi.*'; wofi-emoji"
    local cliphist           = "killall -r '.*wofi.*'; cliphist list | wofi --dmenu | cliphist decode | wl-copy"
    local screenShot         = [[grim -g "$(slurp -d)" - | satty --filename - --actions-on-enter save-to-clipboard --copy-command 'wl-copy' --early-exit]]

    -- Quick launch shortcuts
    hl.bind("SUPER + B",      hl.dsp.exec_cmd(browser))
    hl.bind("SUPER + Q",      hl.dsp.exec_cmd(terminal))
    hl.bind("SUPER + E",      hl.dsp.exec_cmd(fileManager))
    hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
    hl.bind("SUPER + SPACE",  hl.dsp.exec_cmd(menu))
    hl.bind("SUPER + V",      hl.dsp.exec_cmd(cliphist))
    hl.bind("SUPER + period", hl.dsp.exec_cmd(emojiPicker))
    hl.bind("Print",          hl.dsp.exec_cmd(screenShot))
    hl.bind("SUPER + x",      hl.dsp.exec_cmd(colorpicker))

    -- System shortcuts
    hl.bind("SUPER + SHIFT + M", hl.dsp.exit())
    hl.bind("SUPER + C",               hl.dsp.window.close())
    hl.bind("SUPER + SHIFT + C",       hl.dsp.window.kill())
    hl.bind("SUPER + backslash",         hl.dsp.exec_cmd(lockscreen))
    hl.bind("SUPER + F",         hl.dsp.window.fullscreen())

    -- Move focus (SUPER+CONTROL)
    hl.bind("SUPER + CONTROL + H",     hl.dsp.focus({ direction = "l" }))
    hl.bind("SUPER + CONTROL + L",     hl.dsp.focus({ direction = "r" }))
    hl.bind("SUPER + CONTROL + K",     hl.dsp.focus({ direction = "u" }))
    hl.bind("SUPER + CONTROL + J",     hl.dsp.focus({ direction = "d" }))
    hl.bind("SUPER + ALT + H",         hl.dsp.focus({ direction = "l" }))
    hl.bind("SUPER + ALT + L",         hl.dsp.focus({ direction = "r" }))
    hl.bind("SUPER + ALT + K",         hl.dsp.focus({ direction = "u" }))
    hl.bind("SUPER + ALT + J",         hl.dsp.focus({ direction = "d" }))
    hl.bind("SUPER + CONTROL + left",  hl.dsp.focus({ direction = "l" }))
    hl.bind("SUPER + CONTROL + right", hl.dsp.focus({ direction = "r" }))
    hl.bind("SUPER + CONTROL + up",    hl.dsp.focus({ direction = "u" }))
    hl.bind("SUPER + CONTROL + down",  hl.dsp.focus({ direction = "d" }))

    -- Switch workspaces 1–10
    for i = 1, 9 do
        hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
    end
    hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

    -- Switch workspaces 11–20 (F1–F10)
    for i = 1, 10 do
        hl.bind("SUPER + F" .. i, hl.dsp.focus({ workspace = 10 + i }))
    end

    -- Switch workspaces 21–30 (SUPER+ALT+[0-9])
    for i = 1, 9 do
        hl.bind("SUPER + ALT + " .. i, hl.dsp.focus({ workspace = 20 + i }))
    end
    hl.bind("SUPER + ALT + 0", hl.dsp.focus({ workspace = 30 }))

    -- Switch workspaces 31–40 (SUPER+ALT+F1–F10)
    for i = 1, 10 do
        hl.bind("SUPER + ALT + F" .. i, hl.dsp.focus({ workspace = 30 + i }))
    end

    -- Move active window to workspace 1–10
    for i = 1, 9 do
        hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
    end
    hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

    -- Move active window to workspace 11–20
    for i = 1, 10 do
        hl.bind("SUPER + SHIFT + F" .. i, hl.dsp.window.move({ workspace = 10 + i }))
    end

    -- Move active window to workspace 21–30
    for i = 1, 9 do
        hl.bind("SUPER + ALT + SHIFT + " .. i, hl.dsp.window.move({ workspace = 20 + i }))
    end
    hl.bind("SUPER + ALT + SHIFT + 0", hl.dsp.window.move({ workspace = 30 }))

    -- Move active window to workspace 31–40
    for i = 1, 10 do
        hl.bind("SUPER + ALT + SHIFT + F" .. i, hl.dsp.window.move({ workspace = 30 + i }))
    end

    -- Special workspace (scratchpad)
    hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Media keys
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),      { repeating = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),      { repeating = true })
    hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                          { repeating = true })
    hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                { repeating = true })
    hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                            { repeating = true })
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),    { repeating = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 5%+"),                           { repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"),                           { repeating = true })

    -- Workspace left/right
    hl.bind("SUPER + left",  hl.dsp.focus({ workspace = "-1" }))
    hl.bind("SUPER + right", hl.dsp.focus({ workspace = "+1" }))
    hl.bind("SUPER + h",     hl.dsp.focus({ workspace = "-1" }))
    hl.bind("SUPER + l",     hl.dsp.focus({ workspace = "+1" }))

    hl.bind("SUPER + n", hl.dsp.exec_cmd(notificationAgent))
end

return M
