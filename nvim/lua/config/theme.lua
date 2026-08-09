vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.api.nvim_set_hl(0, "Visual", { bg = "#3a3a5a", bold = true })

-- Cursor highlight
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "Cursor", { fg = "lime", bg = "lime", bold = true })
vim.api.nvim_set_hl(0, "Cursor2", { fg = "red", bg = "red", bold = true })

vim.opt.guicursor = table.concat({
    "n-v-c:block-Cursor/lCursor-blinkwait5000-blinkon200-blinkoff200",
    "i-ci-ve:ver25-Cursor2/lCursor2-blinkwait5000-blinkon200-blinkoff200",
    "r-cr:hor50-Cursor2/lCursor2",
    "o:block-Cursor2/lCursor2-blinkwait5000-blinkon200-blinkoff200",
}, ",")

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'lime', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
vim.opt.signcolumn = "yes"

-- Lualine transparency
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })


local c = {
  go       = "#79D4FD", -- Go brand cyan (keywords)
  cyan     = "cyan",
  purple   = "#B46BFF", -- functions / methods
  green    = "lime", -- strings
  yellow   = "#FFFF1D", -- types / classes
  orange   = "#FFCE1F", -- numbers / constants / builtins
  red      = "#FF1310", -- return / self / errors
  rose     = "#FF5F7B", -- parameters
  pink     = "#F76FD3", -- escapes / macros / special
  teal     = "#2EE6C8", -- operators / special symbols
  blue     = "#4D9FFF", -- constructors / links / labels
  peri     = "#93A4FF", -- fields / properties
  flamingo = "#F2A6A6", -- namespaces / modules
  text     = "#DFE6F5", -- variables (bright neutral)
  punct    = "#8B93AB", -- punctuation / delimiters
  comment  = "#9BA3B4", -- comments
  base     = "#1E1E2E",
}
 
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end
 
local function apply()

  -- Base groups (regex syntax + treesitter fallback) ------------------------
  hl("Comment",      { fg = c.comment, italic = true })
  hl("Constant",     { fg = c.orange })
  hl("String",       { fg = c.green })
  hl("Character",    { fg = c.teal })
  hl("Number",       { fg = c.orange })
  hl("Boolean",      { fg = c.orange })
  hl("Float",        { fg = c.orange })
  hl("Identifier",   { fg = c.text })
  hl("Function",     { fg = c.purple })
  hl("Statement",    { fg = c.go })
  hl("Conditional",  { fg = c.go })
  hl("Repeat",       { fg = c.go })
  hl("Label",        { fg = c.blue })
  hl("Operator",     { fg = c.teal })
  hl("Keyword",      { fg = c.go })
  hl("Exception",    { fg = c.go })
  hl("PreProc",      { fg = c.pink })
  hl("Include",      { fg = c.pink })
  hl("Define",       { fg = c.pink })
  hl("Macro",        { fg = c.pink })
  hl("Type",         { fg = c.yellow })
  hl("StorageClass", { fg = c.yellow })
  hl("Structure",    { fg = c.yellow })
  hl("Typedef",      { fg = c.yellow })
  hl("Special",      { fg = c.pink })
  hl("SpecialChar",  { fg = c.pink })
  hl("Delimiter",    { fg = c.punct })
  hl("Todo",         { fg = "black", bg = c.blue, bold = true })
  hl("Error",        { fg = c.red })
 
  -- Treesitter (the fine-grained distinctions) ------------------------------
  hl("@comment",              { fg = c.comment, italic = true })
  hl("@comment.todo",         { fg = "black", bold = true })
  hl("@comment.error",        { fg = "black", bg = c.red, bold = true })
  hl("@comment.warning",      { fg = "black", bg = c.yellow, bold = true })
  hl("@comment.note",         { fg = "black", bg = c.cyan, bold = true })
 
  hl("@keyword",              { fg = c.go })
  hl("@keyword.function",     { fg = c.go, bold = true })
  hl("@keyword.operator",     { fg = c.teal })
  hl("@keyword.return",       { fg = c.red })    -- 'return' pops
  hl("@keyword.import",       { fg = c.go })
  hl("@keyword.exception",    { fg = c.go })
  hl("@keyword.conditional",  { fg = c.go })
  hl("@keyword.repeat",       { fg = c.go })
  hl("@conditional",          { fg = c.go })     -- older nvim
  hl("@repeat",               { fg = c.go })     -- older nvim
  hl("@exception",            { fg = c.go })     -- older nvim
 
  hl("@operator",             { fg = c.teal })
 
  hl("@function",             { fg = c.cyan })
  hl("@function.call",        { fg = c.cyan })
  hl("@function.builtin",     { fg = c.orange })
  hl("@function.method",      { fg = c.cyan })
  hl("@function.method.call", { fg = c.cyan })
  hl("@constructor",          { fg = c.blue })
 
  hl("@string",               { fg = c.green })
  hl("@string.escape",        { fg = c.pink })   -- \n \t inside strings
  hl("@string.regexp",        { fg = c.orange })
  hl("@string.special",       { fg = c.teal })
  hl("@string.special.url",   { fg = c.blue, underline = true })
  hl("@character",            { fg = c.teal })
  hl("@character.special",    { fg = c.pink })
 
  hl("@number",               { fg = c.orange })
  hl("@number.float",         { fg = c.orange })
  hl("@boolean",              { fg = c.orange })
  hl("@constant",             { fg = c.orange })
  hl("@constant.builtin",     { fg = c.orange })
  hl("@constant.macro",       { fg = c.pink })
 
  hl("@variable",             { fg = c.text })
  hl("@variable.builtin",     { fg = c.red })      -- self / this / super
  hl("@variable.parameter",   { fg = c.rose })     -- function params (Go receivers too)
  hl("@variable.member",      { fg = c.peri })     -- struct fields
  hl("@property",             { fg = c.peri })
  hl("@field",                { fg = c.peri })     -- older nvim
 
  hl("@type",                 { fg = c.yellow })
  hl("@type.builtin",         { fg = c.yellow, italic = true }) -- int/string/error
  hl("@type.definition",      { fg = c.yellow })
  hl("@attribute",            { fg = c.yellow })
  hl("@module",               { fg = c.flamingo }) -- package names (fmt, http)
  hl("@namespace",            { fg = c.flamingo }) -- older nvim
 
  hl("@punctuation.delimiter",{ fg = c.punct })
  hl("@punctuation.bracket",  { fg = c.punct })
  hl("@punctuation.special",  { fg = c.teal })     -- ${...} interpolation
 
  hl("@tag",                  { fg = c.go })       -- HTML / JSX
  hl("@tag.attribute",        { fg = c.yellow })
  hl("@tag.delimiter",        { fg = c.punct })
 
  hl("@label",                { fg = c.blue })
 
  -- Markup (markdown, help, docstrings) -------------------------------------
  hl("@markup.heading",       { fg = c.go, bold = true })
  hl("@markup.strong",        { fg = c.orange, bold = true })
  hl("@markup.italic",        { fg = c.orange, italic = true })
  hl("@markup.link",          { fg = c.blue })
  hl("@markup.link.url",      { fg = c.blue, underline = true })
  hl("@markup.raw",           { fg = c.green })    -- inline `code`
  hl("@markup.list",          { fg = c.teal })
  hl("@markup.quote",         { fg = c.comment, italic = true })
  hl("@markup.raw.block",   {})
  hl("@text.literal.block", {})
 
  -- LSP semantic tokens -> follow the treesitter mapping --------------------
  hl("@lsp.mod.format",         { fg = c.pink })
  hl("@lsp.type.class",         { link = "@type" })
  hl("@lsp.type.decorator",     { link = "@attribute" })
  hl("@lsp.type.enum",          { link = "@type" })
  hl("@lsp.type.enumMember",    { link = "@constant" })
  hl("@lsp.type.function",      { link = "@function" })
  hl("@lsp.type.interface",     { link = "@type" })
  hl("@lsp.type.macro",         { link = "@constant.macro" })
  hl("@lsp.type.functions",     { link = "@function.method" })
  hl("@lsp.type.method",        { link = "@function.method" })
  hl("@lsp.type.namespace",     { link = "@module" })
  hl("@lsp.type.parameter",     { link = "@variable.parameter" })
  hl("@lsp.type.property",      { link = "@property" })
  hl("@lsp.type.struct",        { link = "@type" })
  hl("@lsp.type.type",          { link = "@type" })
  hl("@lsp.type.typeParameter", { link = "@type" })
  hl("@lsp.type.variable",      { link = "@variable" })
  hl("@lsp.type.label",         { link = "@label" })
  hl("@lsp.type.comment",    {})
  hl("@lsp.type.comment.go", {})


  -- Popup windows
  hl("NormalFloat", { bg = "#181825", fg = c.text })   -- mantle: one step off your editor bg
  hl("FloatBorder", { bg = "#181825", fg = c.punct })
  hl("LspSignatureActiveParameter", { fg = c.go, bold = true })
end
 
-- Reapply on every colorscheme change, and once right now.
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
apply()
