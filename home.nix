{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "sa";
  home.homeDirectory = "/home/sa";
  home.packages = with pkgs; [ ];
  
  gtk = {
    enable = true;
    
    # GTK 主题（以 Catppuccin 为例）
    theme = {
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
    };

    # 图标主题
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # 光标主题
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # 设置 XCursor 指针全局生效
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
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
  #services.xsettingsd.enable = true;
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
  home.stateVersion = "26.05";
}
