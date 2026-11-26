{ ... }:

{
  # Deploy mimeapps.list verbatim into ~/.config/mimeapps.list (XDG spec name).
  # force = true avoids activation failures if an app/xdg-mime created one first.
  xdg.configFile."mimeapps.list" = {
    source = ./mime-apps.list;
    force = true;
  };
}
