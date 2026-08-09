local M = {}

function M.setup_submap()
    require("keymaps.universal-keymap").setup()
    hl.bind("escape", hl.dsp.submap("reset"))

    hl.bind("left",  hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
    hl.bind("right", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })
    hl.bind("H",     hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
    hl.bind("L",     hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
    hl.bind("K",     hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
    hl.bind("J",     hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

    hl.bind("catchall", hl.dsp.submap("reset"))
end

return M
