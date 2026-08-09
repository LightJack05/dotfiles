{ pkgs, config, ... }:
let
  gl = config.lib.nixGL.wrap;
in
{
  # General-purpose CLI tools not tied to any single config module. Everything
  # else now lives in the module that requires it (kitty in kitty/, tmux in
  # tmux/, screenshot/media/clipboard tools in hypr/, snx in snx/, ...), so it's
  # obvious why each package is installed.
  home.packages =
    (map gl (
      with pkgs;
      [
        firefox
      ]
    ))
    ++ (with pkgs; [
      ripgrep
      jq
    ]);
}
