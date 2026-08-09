local M = {}

function M.setup_submap()
    require("keymaps.universal-keymap").setup()
    hl.bind("escape", hl.dsp.submap("reset"))

    -- Switch workspace 1–10
    for i = 1, 9 do
        hl.bind("" .. i, hl.dsp.focus({ workspace = i }))
    end
    hl.bind("0", hl.dsp.focus({ workspace = 10 }))

    -- Switch workspace 11–20
    for i = 1, 10 do
        hl.bind("F" .. i, hl.dsp.focus({ workspace = 10 + i }))
    end

    -- Switch workspace 21–30
    for i = 1, 9 do
        hl.bind("ALT + " .. i, hl.dsp.focus({ workspace = 20 + i }))
    end
    hl.bind("ALT + 0", hl.dsp.focus({ workspace = 30 }))

    -- Switch workspace 31–40
    for i = 1, 10 do
        hl.bind("ALT + F" .. i, hl.dsp.focus({ workspace = 30 + i }))
    end

    hl.bind("left",  hl.dsp.focus({ workspace = "-1" }))
    hl.bind("right", hl.dsp.focus({ workspace = "+1" }))
    hl.bind("H",     hl.dsp.focus({ workspace = "-1" }))
    hl.bind("L",     hl.dsp.focus({ workspace = "+1" }))

    -- Move window to adjacent workspace
    hl.bind("SHIFT + H",     hl.dsp.window.move({ workspace = "-1" }))
    hl.bind("SHIFT + L",     hl.dsp.window.move({ workspace = "+1" }))
    hl.bind("SHIFT + left",  hl.dsp.window.move({ workspace = "-1" }))
    hl.bind("SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

    -- Move active window to workspace 1–10
    for i = 1, 9 do
        hl.bind("SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
    end
    hl.bind("SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

    -- Move active window to workspace 11–20
    for i = 1, 10 do
        hl.bind("SHIFT + F" .. i, hl.dsp.window.move({ workspace = 10 + i }))
    end

    -- Move active window to workspace 21–30
    for i = 1, 9 do
        hl.bind("SHIFT + ALT + " .. i, hl.dsp.window.move({ workspace = 20 + i }))
    end
    hl.bind("SHIFT + ALT + 0", hl.dsp.window.move({ workspace = 30 }))

    -- Move active window to workspace 31–40
    for i = 1, 10 do
        hl.bind("SHIFT + ALT + F" .. i, hl.dsp.window.move({ workspace = 30 + i }))
    end

    hl.bind("catchall", hl.dsp.submap("reset"))
end

return M
