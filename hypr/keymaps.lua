local universal = require("keymaps.universal-keymap")
local resize    = require("keymaps.resize")
local move      = require("keymaps.move")
local workspace = require("keymaps.workspace")

-- Register universal keymaps at root level
universal.setup()

-- Submap entry binds
hl.bind("SUPER + R", hl.dsp.submap("RESIZE"))
hl.bind("SUPER + M", hl.dsp.submap("MOVE"))
hl.bind("SUPER + W", hl.dsp.submap("WORKSPACE"))
hl.bind("SUPER + O", hl.dsp.submap("CONFIG"))

-- Define submaps
require("keymaps.config")

hl.define_submap("RESIZE",    resize.setup_submap)
hl.define_submap("MOVE",      move.setup_submap)
hl.define_submap("WORKSPACE", workspace.setup_submap)
