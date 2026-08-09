{ pkgs, ... }:

let
  # ── Theme selection ─────────────────────────────────────────────────────────
  # Everything below is driven from these five values. To switch themes later,
  # change them here (and point colorScheme at a different *.colors file for Qt).
  gtkTheme = {
    name = "Breeze-Dark";
    package = pkgs.kdePackages.breeze-gtk;
  };
  iconTheme = {
    name = "Fluent-dark";
    package = pkgs.fluent-icon-theme;
  };
  qtStyle = "breeze"; # Qt widget style (QT_STYLE_OVERRIDE)
  colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
  font = {
    name = "Adwaita Sans";
    mono = "Adwaita Mono";
    size = 11;
  };

  # kdeglobals drives KDE/KF6 apps (Dolphin, etc). On a non-Plasma system these
  # apps read their color *palette* straight from kdeglobals — naming a scheme is
  # not enough, which is why Dolphin used to open light. So we build kdeglobals
  # from the upstream Breeze-Dark color scheme (never hand-maintaining the
  # palette) and inject the widget style, icon theme and fonts on top.
  fontSpec = family: "${family},${toString font.size},-1,5,50,0,0,0,0,0";
  kdeglobals = pkgs.runCommandLocal "kdeglobals" { } ''
    cp ${colorScheme} "$out"
    chmod +w "$out"
    sed=${pkgs.gnused}/bin/sed
    # widget style — [KDE] group already exists in the color scheme file
    "$sed" -i '/^\[KDE\]/a widgetStyle=${qtStyle}' "$out"
    # fonts — [General] group already exists in the color scheme file
    "$sed" -i '/^\[General\]/a font=${fontSpec font.name}\nfixed=${fontSpec font.mono}\nmenuFont=${fontSpec font.name}\ntoolBarFont=${fontSpec font.name}' "$out"
    # icon theme — new group
    printf '\n[Icons]\nTheme=${iconTheme.name}\n' >> "$out"
  '';
in
{
  # ── GTK 2/3/4 ───────────────────────────────────────────────────────────────
  # gtk.theme propagates to GTK3 and GTK4; for GTK4 home-manager also generates
  # ~/.config/gtk-4.0/gtk.css importing the theme (GTK4 otherwise ignores it).
  gtk = {
    enable = true;
    theme = gtkTheme;
    iconTheme = iconTheme;
    font = {
      inherit (font) name size;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "icon:";
      gtk-cursor-theme-name = "default";
      gtk-cursor-theme-size = 24;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-sound-theme-name = "ocean";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name = "default";
      gtk-cursor-theme-size = 24;
    };
  };

  # ── Qt 5/6 + KDE apps ───────────────────────────────────────────────────────
  # platformTheme "kde" => QT_QPA_PLATFORMTHEME=kde (+ kio/plasma-integration),
  # style "breeze" => QT_STYLE_OVERRIDE=breeze (+ breeze packages). Together with
  # kdeglobals below this themes Qt5, Qt6 and KDE apps uniformly — no qt5ct/qt6ct.
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = qtStyle;
  };

  xdg.configFile."kdeglobals".source = kdeglobals;

  # ── Fonts ───────────────────────────────────────────────────────────────────
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    adwaita-fonts # Adwaita Sans / Mono — GTK + Qt UI font
    roboto # "Roboto" family — hyprlock labels
    nerd-fonts.roboto-mono # "RobotoMono Nerd Font" — kitty + hyprlock
    nerd-fonts.symbols-only # "Symbols Nerd Font" — icon-glyph fallback (waybar etc.)
  ];
}
