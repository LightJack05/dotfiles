local wallpaper  = require("keymaps.config.wallpaper")
local waybar     = require("keymaps.config.waybar")

hl.define_submap("CONFIG", function()
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))

    hl.bind("w", hl.dsp.submap("CONFIG/WALLPAPER"))
    hl.bind("b", hl.dsp.submap("CONFIG/WAYBAR"))

end)

wallpaper.define_submap()
waybar.define_submap()
