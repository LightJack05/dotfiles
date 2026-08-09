local colors = {
    blue     = "#89b4fa",
    green    = "#a6e3a1",
    mauve    = "#cba6f7",
    red      = "#f38ba8",
    peach    = "#fab387",
    text     = "#cdd6f4",
    mantle   = "#181825",
    surface0 = "#313244",
    surface1 = "#45475a",
    overlay0 = "#6c7086",
}

local mocha = {
    normal = {
        a = { bg = colors.blue, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.blue },
        c = { bg = "none", fg = colors.text },
    },
    insert = {
        a = { bg = colors.green, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.green },
    },
    visual = {
        a = { bg = colors.mauve, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.mauve },
    },
    replace = {
        a = { bg = colors.red, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.red },
    },
    command = {
        a = { bg = colors.peach, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.peach },
    },
    inactive = {
        a = { bg = colors.mantle, fg = colors.blue },
        b = { bg = colors.mantle, fg = colors.surface1 },
        c = { bg = "none", fg = colors.text },
    },
}


require("lualine").setup({
    options = {
        theme = mocha,
        section_separators = '',
        component_separators = '',
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
