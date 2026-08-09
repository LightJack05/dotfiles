{ lib, hyprmonitormanager, ... }:

let
  configsDir = ./configs;

  # Recursively collect every tracked file under ./configs as a relative path.
  collect =
    dir: prefix:
    lib.concatLists (
      lib.mapAttrsToList (
        name: type:
        let
          rel = if prefix == "" then name else "${prefix}/${name}";
        in
        if type == "directory" then collect (dir + "/${name}") rel else [ rel ]
      ) (builtins.readDir dir)
    );

  files = collect configsDir "";
in
{
  # hyprmonitormanager's per-monitor-combo configs (keyed by a hash of the
  # connected displays). They're reused across machines, so we track them in this
  # repo and symlink each file into place — deployed everywhere automatically, no
  # copying needed to "adopt" a config on a new device.
  #
  # Individual files are symlinked (not the whole configs dir) so the directory
  # stays writable: when hyprmonitormanager generates a config for a NEW monitor
  # combo it lands in ~/.config/hyprmonitormanager/configs/<newhash>/ alongside
  # these symlinks. To share/persist a new one, copy that dir into this repo.
  # (Existing tracked configs are read-only symlinks; edit them here, not at
  # runtime.)
  #
  xdg.configFile = lib.listToAttrs (
    map (rel: {
      name = "hyprmonitormanager/configs/${rel}";
      value.source = configsDir + "/${rel}";
    }) files
  );

  # The daemon/binary comes from its own flake input (passed via extraSpecialArgs).
  home.packages = [ hyprmonitormanager ];
}
