{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "sa";
  home.homeDirectory = "/home/sa";
  
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.packages = with pkgs; [
    dconf
    glib
    gsettings-desktop-schemas
    xdg-desktop-portal-gtk
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.Settings" = "gtk";
    };
  };

  programs.tmux = {
    enable = true;
    # 直接在此处写入原本写在 .tmux.conf 里的内容
    extraConfig = ''
      set -g mouse on
      unbind -n MouseDown3Pane
      set -g default-command fish
    '';
  };
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
  home.stateVersion = "26.05";
}
