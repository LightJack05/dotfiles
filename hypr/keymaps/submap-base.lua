local M = {}

function M.setup()
    hl.bind("escape", hl.dsp.submap("reset"))
end

return M
