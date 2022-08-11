{ config, lib, pkgs, ... }:

{
  # input methods
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
        fcitx5-configtool
        fcitx5-gtk
        fcitx5-chinese-addons
      ];
      enableRimeData = true;
    };
  };

  fonts.fonts = with pkgs; [
    font-awesome
    noto-fonts
    nerdfonts
    wqy_zenhei
    wqy_microhei
    material-design-icons
    unifont
  ];

  environment.systemPackages = with pkgs; [
    # desktop
    alacritty
    xfce.thunar
    flameshot
    font-manager

    # softwares
    # browser
    qutebrowser
    chromium
    firefox
    # IM
    tdesktop
    discord
    slack
    mattermost-desktop
    # viewers
    zathura
    nomacs
    cider
    vlc

    # icon
    papirus-icon-theme

    # emacs
    pandoc
    ripgrep
    fd
    editorconfig-checker
    nixfmt
  ];
}
