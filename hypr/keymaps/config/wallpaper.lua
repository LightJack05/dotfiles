local M = {}

function M.define_submap()
    hl.define_submap("CONFIG/WALLPAPER", function()
        hl.bind("escape", hl.dsp.submap("reset"))
        hl.bind("catchall", hl.dsp.submap("reset"))

        hl.bind("r", hl.dsp.exec_cmd("killall -r '.*hyprpaper.*'; hyprpaper& hyprctl notify 1 4000 0 ' Restarted hyprpaper '"))

    end)
end

return M
