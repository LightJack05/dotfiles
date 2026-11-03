local on_created_empty = {
    ["special:magic"] = "kitty",
    ["1"] = "firefox",
    ["2"] = "firefox https://discord.com/channels/@me https://web.whatsapp.com https://mail.google.com",
    ["3"] = "firefox https://calendar.google.com https://tasks.google.com https://contacts.google.com",
    ["4"] = [[kitty /usr/bin/zsh -c "/usr/bin/zsh -c \"tmux a || tmux new-session -s home \""]],
    ["5"] = "firefox https://github.com https://gitea.lightjack.de",
}

hl.on("workspace.created", function(ws)
    if not ws.is_empty then return end
    local cmd = on_created_empty[ws.addressable_name]
    if cmd then
        hl.exec_cmd(cmd)
    end
end)

hl.workspace_rule({ workspace = "special:magic" })
hl.workspace_rule({ workspace = "1", default_name = "1: Web"              })
hl.workspace_rule({ workspace = "2", default_name = "2: Comms"            })
hl.workspace_rule({ workspace = "3", default_name = "3: Mission Control"  })
hl.workspace_rule({ workspace = "4", default_name = "4: Tmux"             })
hl.workspace_rule({ workspace = "5", default_name = "5: GitWeb"           })
