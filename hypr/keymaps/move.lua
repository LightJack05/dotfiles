local M = {}

function M.setup_submap()
    require("keymaps.universal-keymap").setup()
    hl.bind("escape", hl.dsp.submap("reset"))

    -- Move window by direction
    hl.bind("H",     hl.dsp.window.move({ direction = "l" }))
    hl.bind("L",     hl.dsp.window.move({ direction = "r" }))
    hl.bind("K",     hl.dsp.window.move({ direction = "u" }))
    hl.bind("J",     hl.dsp.window.move({ direction = "d" }))
    hl.bind("left",  hl.dsp.window.move({ direction = "l" }))
    hl.bind("right", hl.dsp.window.move({ direction = "r" }))
    hl.bind("up",    hl.dsp.window.move({ direction = "u" }))
    hl.bind("down",  hl.dsp.window.move({ direction = "d" }))

    -- Move active window to workspace 1–10
    for i = 1, 9 do
        hl.bind("" .. i, hl.dsp.window.move({ workspace = i }))
    end
    hl.bind("0", hl.dsp.window.move({ workspace = 10 }))

    -- Move active window to workspace 11–20
    for i = 1, 10 do
        hl.bind("F" .. i, hl.dsp.window.move({ workspace = 10 + i }))
    end

    -- Move active window to workspace 21–30
    for i = 1, 9 do
        hl.bind("ALT + " .. i, hl.dsp.window.move({ workspace = 20 + i }))
    end
    hl.bind("ALT + 0", hl.dsp.window.move({ workspace = 30 }))

    -- Move active window to workspace 31–40
    for i = 1, 10 do
        hl.bind("ALT + F" .. i, hl.dsp.window.move({ workspace = 30 + i }))
    end

    hl.bind("catchall", hl.dsp.submap("reset"))
end

return M
