-- Ansible filetype detection.
--
-- `ansible-language-server` only claims the `yaml.ansible` filetype (see
-- nvim-lspconfig's `lsp/ansiblels.lua`), and neovim never sets that on its own:
-- a role's `tasks/main.yml` is detected as plain `yaml`, so the server never
-- attaches. Map the conventional ansible layouts onto `yaml.ansible` here.
--
-- The dotted filetype is deliberate — autocmd matching splits on the dot, so
-- yaml highlighting and `yamlls` still apply via the `yaml` component and
-- `ansiblels` is added on top of them, rather than replacing them.

-- Directories that make up a role.
local role_dirs = { "tasks", "handlers", "meta", "defaults", "vars" }

-- Unrelated projects have `vars/` or `meta/` folders too, so a file inside one
-- only counts as ansible when its containing directory really looks like a
-- role. Every role has at least one of these two.
local function is_role(dir)
    return vim.fn.isdirectory(dir .. "/tasks") == 1 or vim.fn.isdirectory(dir .. "/meta") == 1
end

local patterns = {}

for _, dir in ipairs(role_dirs) do
    -- `.-` is non-greedy, so the capture stops at the *first* matching segment
    -- and still resolves the role root for files nested deeper (tasks/sub/x.yml).
    patterns[".*/" .. dir .. "/.*%.ya?ml"] = function(path)
        local role = path:match("^(.-)/" .. dir .. "/")
        if role and is_role(role) then
            return "yaml.ansible"
        end
    end
end

-- These layouts are unambiguous on their own — no role check needed.
for _, dir in ipairs({ "roles", "playbooks", "group_vars", "host_vars" }) do
    patterns[".*/" .. dir .. "/.*%.ya?ml"] = "yaml.ansible"
end

vim.filetype.add({
    filename = {
        ["site.yml"] = "yaml.ansible",
        ["site.yaml"] = "yaml.ansible",
        ["playbook.yml"] = "yaml.ansible",
        ["playbook.yaml"] = "yaml.ansible",
    },
    pattern = patterns,
})

-- A playbook can live anywhere under any name, so path patterns alone can't
-- catch them all. Fall back to peeking at the buffer: a play keyed by `hosts:`
-- is unmistakably ansible, and is specific enough not to fire on stray yaml.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("ansible_playbook_detect", { clear = true }),
    pattern = "yaml",
    callback = function(args)
        -- The pattern above also matches the compound `yaml.ansible`; bail out
        -- on anything already resolved so setting the option can't recurse.
        if vim.bo[args.buf].filetype ~= "yaml" then return end

        for _, line in ipairs(vim.api.nvim_buf_get_lines(args.buf, 0, 50, false)) do
            if line:match("^%s*%-?%s*hosts:%s*%S") then
                vim.bo[args.buf].filetype = "yaml.ansible"
                return
            end
        end
    end,
})
