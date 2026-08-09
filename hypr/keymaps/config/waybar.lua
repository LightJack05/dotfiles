local M = {}

function M.define_submap()
    hl.define_submap("CONFIG/WAYBAR", function()
        hl.bind("escape", hl.dsp.submap("reset"))
        hl.bind("catchall", hl.dsp.submap("reset"))

        hl.bind("r", hl.dsp.exec_cmd([[bash -c "killall -SIGUSR2 -r '.*waybar.*'; hyprctl notify 1 4000 0 ' Reloading waybar... '"]]))
        hl.bind("c", hl.dsp.exec_cmd([[bash -c "killall -SIGUSR1 -r '.*waybar.*'; hyprctl notify 1 4000 0 ' Toggled waybar visibility... '"]]))

    end)
end

return M
